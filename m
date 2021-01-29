Content-Type: multipart/mixed; boundary="===============4242064831191573044=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] ap: Allow setting multiple ciphers in ap->ciphers
Date: Sat, 30 Jan 2021 00:27:39 +0100
Message-ID: <20210129232740.27393-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210129232740.27393-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4242064831191573044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ap->ciphers is still set to one selected cipher currently but this
reduces the amount of work needed to resolve the TODO comment about
listing all supported ciphers in the pairwise ciphers RSNE fields.
---
 src/ap.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 1359dcac..86866f9d 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -709,7 +709,9 @@ static void ap_start_handshake(struct sta_state *sta, b=
ool use_eapol_start,
 	struct ap_state *ap =3D sta->ap;
 	const uint8_t *own_addr =3D netdev_get_address(ap->netdev);
 	struct ie_rsn_info rsn;
-	uint8_t bss_rsne[24];
+	uint8_t bss_rsne[64];
+	uint16_t mask;
+	struct wiphy *wiphy =3D netdev_get_wiphy(ap->netdev);
 =

 	handshake_state_set_ssid(sta->hs, (void *) ap->config->ssid,
 					strlen(ap->config->ssid));
@@ -724,7 +726,10 @@ static void ap_start_handshake(struct sta_state *sta, =
bool use_eapol_start,
 	ie_build_rsne(&rsn, bss_rsne);
 	handshake_state_set_authenticator_ie(sta->hs, bss_rsne);
 =

-	handshake_state_override_pairwise_cipher(sta->hs, ap->ciphers);
+	mask =3D ap->ciphers;
+	mask &=3D sta->hs->supplicant_ciphers ?: 0xffff;
+	handshake_state_override_pairwise_cipher(sta->hs,
+					wiphy_select_cipher(wiphy, mask));
 =

 	if (gtk_rsc)
 		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
@@ -2110,6 +2115,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
 	struct wiphy *wiphy =3D netdev_get_wiphy(ap->netdev);
 	uint32_t hidden_ssid =3D NL80211_HIDDEN_SSID_NOT_IN_USE;
+	unsigned int nl_ciphers_cnt =3D __builtin_popcount(ap->ciphers);
+	uint32_t nl_ciphers[nl_ciphers_cnt];
 	uint32_t group_nl_cipher =3D
 		ie_rsn_cipher_suite_to_cipher(ap->group_cipher);
 	uint32_t nl_akm =3D CRYPTO_AKM_PSK;
@@ -2118,11 +2125,17 @@ static struct l_genl_msg *ap_build_cmd_start_ap(str=
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
@@ -2149,8 +2162,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
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
-- =

2.20.1

--===============4242064831191573044==--

