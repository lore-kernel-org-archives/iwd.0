Content-Type: multipart/mixed; boundary="===============2856087099818900221=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] eapol: IP Allocation KDE support authenticator side
Date: Mon, 14 Sep 2020 15:51:17 +0200
Message-ID: <20200914135120.463623-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200914135120.463623-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2856087099818900221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Again the hs->support_ip_allocation flag is used for two purposes here,
first the user signals whether to support this mechanism through this
flag, then it reads the flag to find out if an IP was allocated.
---
 src/eapol.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/src/eapol.c b/src/eapol.c
index acf07c41..c42f1a05 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1322,6 +1322,21 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *s=
m)
 		key_data_len +=3D gtk_kde[1] + 2;
 	}
 =

+	if (sm->handshake->support_ip_allocation) {
+		/* Wi-Fi P2P Technical Specification v1.7 Table 59 */
+		key_data_buf[key_data_len++] =3D IE_TYPE_VENDOR_SPECIFIC;
+		key_data_buf[key_data_len++] =3D 4 + 12;
+		l_put_be32(HANDSHAKE_KDE_IP_ADDRESS_ALLOC,
+				key_data_buf + key_data_len + 0);
+		l_put_be32(sm->handshake->client_ip_addr,
+				key_data_buf + key_data_len + 4);
+		l_put_be32(sm->handshake->subnet_mask,
+				key_data_buf + key_data_len + 8);
+		l_put_be32(sm->handshake->go_ip_addr,
+				key_data_buf + key_data_len + 12);
+		key_data_len +=3D 4 + 12;
+	}
+
 	kek =3D handshake_state_get_kek(sm->handshake);
 	key_data_len =3D eapol_encrypt_key_data(kek, key_data_buf,
 						key_data_len, ek, sm->mic_len);
@@ -1450,11 +1465,26 @@ static void eapol_handle_ptk_2_of_4(struct eapol_sm=
 *sm,
 	if (!rsne || rsne[1] !=3D sm->handshake->supplicant_ie[1] ||
 			memcmp(rsne + 2, sm->handshake->supplicant_ie + 2,
 				rsne[1])) {
-
 		handshake_failed(sm, MMPDU_REASON_CODE_IE_DIFFERENT);
 		return;
 	}
 =

+	if (sm->handshake->support_ip_allocation) {
+		const uint8_t *ip_req_kde =3D
+			eapol_find_wfa_kde(EAPOL_KEY_DATA(ek, sm->mic_len),
+					EAPOL_KEY_DATA_LEN(ek, sm->mic_len),
+					HANDSHAKE_KDE_IP_ADDRESS_REQ & 255);
+
+		if (ip_req_kde &&
+				(ip_req_kde[1] < 5 || ip_req_kde[6] !=3D 0x01)) {
+			l_debug("Invalid IP Address Request KDE in frame 2/4");
+			handshake_failed(sm, MMPDU_REASON_CODE_INVALID_IE);
+			return;
+		}
+
+		sm->handshake->support_ip_allocation =3D ip_req_kde !=3D NULL;
+	}
+
 	memcpy(sm->handshake->snonce, ek->key_nonce,
 			sizeof(sm->handshake->snonce));
 	sm->handshake->have_snonce =3D true;
-- =

2.25.1

--===============2856087099818900221==--

