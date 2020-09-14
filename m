Content-Type: multipart/mixed; boundary="===============1106345260437087237=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] eapol: IP Allocation KDE support
Date: Mon, 14 Sep 2020 15:51:16 +0200
Message-ID: <20200914135120.463623-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1106345260437087237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Support IP allocation during the 4-Way Handshake as defined in the P2P
spec.  This is the supplicant side implementation.

The API requires the user to set hs->support_ip_allocation true before
eapol_start().  On HANDSHAKE_EVENT_COMPLETE, if this same flag is still
set, we've received the IP lease, the netmask and the authenticator's
IP from the authenticator and there's no need to start DHCP.  If the
flag is cleared, the user needs to use DHCP.
---
I can split this into two flags if preferred.
---
 src/eapol.c     | 76 +++++++++++++++++++++++++++++++++++++++++++------
 src/handshake.h |  9 +++++-
 2 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 977f720b..acf07c41 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1088,7 +1088,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 	const uint8_t *kck;
 	struct eapol_key *step2;
 	uint8_t mic[MIC_MAXLEN];
-	uint8_t *ies;
+	uint8_t ies[512];
 	size_t ies_len;
 	const uint8_t *own_ie =3D sm->handshake->supplicant_ie;
 	const uint8_t *pmkid;
@@ -1199,8 +1199,6 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 		 * Rebuild the RSNE to include the PMKR1Name and append
 		 * MDE + FTE.
 		 */
-		ies =3D alloca(512);
-
 		rsn_info.num_pmkids =3D 1;
 		rsn_info.pmkids =3D sm->handshake->pmk_r1_name;
 =

@@ -1214,7 +1212,16 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm =
*sm,
 		ies_len +=3D fte[1] + 2;
 	} else {
 		ies_len =3D own_ie[1] + 2;
-		ies =3D (uint8_t *) own_ie;
+		memcpy(ies, own_ie, ies_len);
+	}
+
+	if (sm->handshake->support_ip_allocation) {
+		/* Wi-Fi P2P Technical Specification v1.7 Table 58 */
+		ies[ies_len++] =3D IE_TYPE_VENDOR_SPECIFIC;
+		ies[ies_len++] =3D 4 + 1;
+		l_put_be32(HANDSHAKE_KDE_IP_ADDRESS_REQ, ies + ies_len);
+		ies_len +=3D 4;
+		ies[ies_len++] =3D 0x01;
 	}
 =

 	step2 =3D eapol_create_ptk_2_of_4(sm->protocol_version,
@@ -1381,7 +1388,8 @@ static const uint8_t *eapol_find_rsne(const uint8_t *=
data, size_t data_len,
 	return first;
 }
 =

-static const uint8_t *eapol_find_osen(const uint8_t *data, size_t data_len)
+static const uint8_t *eapol_find_wfa_kde(const uint8_t *data, size_t data_=
len,
+					uint8_t oi_type)
 {
 	struct ie_tlv_iter iter;
 =

@@ -1389,7 +1397,7 @@ static const uint8_t *eapol_find_osen(const uint8_t *=
data, size_t data_len)
 =

 	while (ie_tlv_iter_next(&iter)) {
 		if (ie_tlv_iter_get_tag(&iter) =3D=3D IE_TYPE_VENDOR_SPECIFIC) {
-			if (!is_ie_wfa_ie(iter.data, iter.len, IE_WFA_OI_OSEN))
+			if (!is_ie_wfa_ie(iter.data, iter.len, oi_type))
 				continue;
 		} else
 			continue;
@@ -1474,6 +1482,28 @@ static const uint8_t *eapol_find_wpa_ie(const uint8_=
t *data, size_t data_len)
 	return NULL;
 }
 =

+static bool eapol_check_ip_mask(const uint8_t *mask,
+				const uint8_t *ip1, const uint8_t *ip2)
+{
+	uint32_t mask_uint =3D l_get_be32(mask);
+	uint32_t ip1_uint =3D l_get_be32(ip1);
+	uint32_t ip2_uint =3D l_get_be32(ip2);
+
+	return
+		/* Check IPs are in the same subnet */
+		((ip1_uint ^ ip2_uint) & mask_uint) =3D=3D 0 &&
+		/* Check IPs are different */
+		ip1_uint !=3D ip2_uint &&
+		/* Check IPs are not subnet addresses */
+		(ip1_uint & ~mask_uint) !=3D 0 &&
+		(ip2_uint & ~mask_uint) !=3D 0 &&
+		/* Check IPs are not broadcast addresses */
+		(ip1_uint | mask_uint) !=3D 0xffffffff &&
+		(ip2_uint | mask_uint) !=3D 0xffffffff &&
+		/* Check the 1s are at the start of the mask */
+		(uint32_t) (mask_uint << __builtin_popcountl(mask_uint)) =3D=3D 0;
+}
+
 static void eapol_handle_ptk_3_of_4(struct eapol_sm *sm,
 					const struct eapol_key *ek,
 					const uint8_t *decrypted_key_data,
@@ -1520,8 +1550,9 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm *=
sm,
 		rsne =3D eapol_find_wpa_ie(decrypted_key_data,
 					decrypted_key_data_size);
 	else if (sm->handshake->osen_ie)
-		rsne =3D eapol_find_osen(decrypted_key_data,
-					decrypted_key_data_size);
+		rsne =3D eapol_find_wfa_kde(decrypted_key_data,
+					decrypted_key_data_size,
+					IE_WFA_OI_OSEN);
 	else
 		rsne =3D eapol_find_rsne(decrypted_key_data,
 					decrypted_key_data_size,
@@ -1667,6 +1698,35 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm =
*sm,
 	} else
 		igtk =3D NULL;
 =

+	if (sm->handshake->support_ip_allocation) {
+		const uint8_t *ip_alloc_kde =3D
+			eapol_find_wfa_kde(decrypted_key_data,
+					decrypted_key_data_size,
+					HANDSHAKE_KDE_IP_ADDRESS_ALLOC & 255);
+
+		if (ip_alloc_kde &&
+				(ip_alloc_kde[1] < 16 ||
+				 !eapol_check_ip_mask(ip_alloc_kde + 10,
+							ip_alloc_kde + 6,
+							ip_alloc_kde + 14))) {
+			l_debug("Invalid IP Allocation KDE in frame 3/4");
+			handshake_failed(sm, MMPDU_REASON_CODE_INVALID_IE);
+			return;
+		}
+
+		sm->handshake->support_ip_allocation =3D ip_alloc_kde !=3D NULL;
+
+		if (ip_alloc_kde) {
+			sm->handshake->client_ip_addr =3D
+				l_get_be32(ip_alloc_kde + 6);
+			sm->handshake->subnet_mask =3D
+				l_get_be32(ip_alloc_kde + 10);
+			sm->handshake->go_ip_addr =3D
+				l_get_be32(ip_alloc_kde + 14);
+		} else
+			l_debug("Authenticator ignored our IP Address Request");
+	}
+
 retransmit:
 	/*
 	 * 802.11-2016, Section 12.7.6.4:
diff --git a/src/handshake.h b/src/handshake.h
index c88bb0d1..b738efd9 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -28,8 +28,8 @@
 struct handshake_state;
 enum crypto_cipher;
 =

-/* 802.11-2016 Table 12-6 in section 12.7.2 */
 enum handshake_kde {
+	/* 802.11-2016 Table 12-6 in section 12.7.2 */
 	HANDSHAKE_KDE_GTK		=3D 0x000fac01,
 	HANDSHAKE_KDE_MAC_ADDRESS	=3D 0x000fac03,
 	HANDSHAKE_KDE_PMKID		=3D 0x000fac04,
@@ -41,6 +41,9 @@ enum handshake_kde {
 	HANDSHAKE_KDE_KEY_ID		=3D 0x000fac0a,
 	HANDSHAKE_KDE_MULTIBAND_GTK	=3D 0x000fac0b,
 	HANDSHAKE_KDE_MULTIBAND_KEY_ID	=3D 0x000fac0c,
+	/* Wi-Fi P2P Technical Specification v1.7 4.2.8 */
+	HANDSHAKE_KDE_IP_ADDRESS_REQ	=3D 0x506f9a04,
+	HANDSHAKE_KDE_IP_ADDRESS_ALLOC	=3D 0x506f9a05,
 };
 =

 enum handshake_event {
@@ -124,6 +127,10 @@ struct handshake_state {
 	uint8_t proto_version : 2;
 	unsigned int gtk_index;
 	struct erp_cache_entry *erp_cache;
+	bool support_ip_allocation : 1;
+	uint32_t client_ip_addr;
+	uint32_t subnet_mask;
+	uint32_t go_ip_addr;
 	void *user_data;
 =

 	void (*free)(struct handshake_state *s);
-- =

2.25.1

--===============1106345260437087237==--

