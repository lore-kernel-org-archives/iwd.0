Content-Type: multipart/mixed; boundary="===============7062336519762646030=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] eapol,
 ap: Remove assumption of single cipher in authenticator IE
Date: Mon, 01 Feb 2021 14:40:42 +0100
Message-ID: <20210201134042.45494-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210201134042.45494-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7062336519762646030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow the user of the eapol_sm & handshake_state APIs to have multiple
pairwise ciphers listed in the authenticator IE.
---
 src/ap.c        | 18 +++++++++++++-----
 src/eapol.c     |  4 ++--
 src/handshake.c | 15 ++++++++-------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 06234249..37dd05b9 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -709,7 +709,7 @@ static void ap_start_handshake(struct sta_state *sta, b=
ool use_eapol_start,
 	struct ap_state *ap =3D sta->ap;
 	const uint8_t *own_addr =3D netdev_get_address(ap->netdev);
 	struct ie_rsn_info rsn;
-	uint8_t bss_rsne[24];
+	uint8_t bss_rsne[64];
 =

 	handshake_state_set_ssid(sta->hs, (void *) ap->config->ssid,
 					strlen(ap->config->ssid));
@@ -1485,7 +1485,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 			goto unsupported;
 		}
 =

-		if (!(rsn_info.pairwise_ciphers & ap->ciphers)) {
+		if (__builtin_popcount(rsn_info.pairwise_ciphers) !=3D 1 ||
+				!(rsn_info.pairwise_ciphers & ap->ciphers)) {
 			err =3D MMPDU_REASON_CODE_INVALID_PAIRWISE_CIPHER;
 			goto unsupported;
 		}
@@ -2108,7 +2109,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
 	struct wiphy *wiphy =3D netdev_get_wiphy(ap->netdev);
 	uint32_t hidden_ssid =3D NL80211_HIDDEN_SSID_NOT_IN_USE;
-	uint32_t nl_ciphers =3D ie_rsn_cipher_suite_to_cipher(ap->ciphers);
+	unsigned int nl_ciphers_cnt =3D __builtin_popcount(ap->ciphers);
+	uint32_t nl_ciphers[nl_ciphers_cnt];
 	uint32_t group_nl_cipher =3D
 		ie_rsn_cipher_suite_to_cipher(ap->group_cipher);
 	uint32_t nl_akm =3D CRYPTO_AKM_PSK;
@@ -2117,11 +2119,17 @@ static struct l_genl_msg *ap_build_cmd_start_ap(str=
uct ap_state *ap)
 	uint32_t ch_freq =3D scan_channel_to_freq(ap->config->channel,
 						SCAN_BAND_2_4_GHZ);
 	uint32_t ch_width =3D NL80211_CHAN_WIDTH_20;
+	unsigned int i;
 =

 	static const uint8_t bcast_addr[6] =3D {
 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
 	};
 =

+	for (i =3D 0, nl_ciphers_cnt =3D 0; i < 8; i++)
+		if (ap->ciphers & (1 << i))
+			nl_ciphers[nl_ciphers_cnt++] =3D
+				ie_rsn_cipher_suite_to_cipher(1 << i);
+
 	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
 	tail_len =3D ap_build_beacon_pr_tail(ap, false, tail);
@@ -2148,8 +2156,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 				ap->config->ssid);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_HIDDEN_SSID, 4,
 				&hidden_ssid);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_CIPHER_SUITES_PAIRWISE, 4,
-				&nl_ciphers);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
+				nl_ciphers_cnt * 4, nl_ciphers);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_CIPHER_SUITE_GROUP, 4,
 				&group_nl_cipher);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_WPA_VERSIONS, 4, &wpa_version);
diff --git a/src/eapol.c b/src/eapol.c
index c42f1a05..ecb8b4f8 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1307,8 +1307,8 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 	ek->key_rsc[7] =3D 0;
 =

 	/*
-	 * Just one RSNE in Key Data as we only set one cipher in ap->ciphers
-	 * currently.
+	 * Just one RSNE in Key Data as we either accept the single pairwise
+	 * cipher in the supplicant IE or fail.
 	 */
 	memcpy(key_data_buf, sm->handshake->authenticator_ie, rsne_len);
 =

diff --git a/src/handshake.c b/src/handshake.c
index e76cf8fb..c4b81207 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -133,14 +133,10 @@ void handshake_state_set_8021x_config(struct handshak=
e_state *s,
 static bool handshake_state_setup_own_ciphers(struct handshake_state *s,
 						const struct ie_rsn_info *info)
 {
-	if (__builtin_popcount(info->pairwise_ciphers) !=3D 1)
-		return false;
-
 	if (__builtin_popcount(info->akm_suites) !=3D 1)
 		return false;
 =

 	s->akm_suite =3D info->akm_suites;
-	s->pairwise_cipher =3D info->pairwise_ciphers;
 	s->group_cipher =3D info->group_cipher;
 	s->group_management_cipher =3D info->group_management_cipher;
 =

@@ -191,9 +187,6 @@ bool handshake_state_set_supplicant_ie(struct handshake=
_state *s,
 	s->wpa_ie =3D is_ie_wpa_ie(ie + 2, ie[1]);
 	s->osen_ie =3D is_ie_wfa_ie(ie + 2, ie[1], IE_WFA_OI_OSEN);
 =

-	if (s->authenticator)
-		return true;
-
 	if (s->wpa_ie) {
 		if (ie_parse_wpa_from_data(ie, ie[1] + 2, &info) < 0)
 			return false;
@@ -205,6 +198,14 @@ bool handshake_state_set_supplicant_ie(struct handshak=
e_state *s,
 			return false;
 	}
 =

+	if (__builtin_popcount(info.pairwise_ciphers) !=3D 1)
+		return false;
+
+	s->pairwise_cipher =3D info.pairwise_ciphers;
+
+	if (s->authenticator)
+		return true;
+
 	return handshake_state_setup_own_ciphers(s, &info);
 }
 =

-- =

2.27.0

--===============7062336519762646030==--

