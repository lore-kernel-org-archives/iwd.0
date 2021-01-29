Content-Type: multipart/mixed; boundary="===============4737690859354468413=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] ap: Set the group cipher when sending START_AP
Date: Sat, 30 Jan 2021 00:27:36 +0100
Message-ID: <20210129232740.27393-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4737690859354468413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Seems this overlooked because an initial version of ap.c didn't have
group traffic support.  This doesn't fix some brcmfmac problems where it
silently overrides the group cipher in the beacon frames though.
---
 src/ap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index ce639907..c4715696 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2108,7 +2108,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
 	struct wiphy *wiphy =3D netdev_get_wiphy(ap->netdev);
 	uint32_t hidden_ssid =3D NL80211_HIDDEN_SSID_NOT_IN_USE;
-	uint32_t nl_ciphers =3D ie_rsn_cipher_suite_to_cipher(ap->ciphers);
+	uint32_t group_nl_cipher =3D
+		ie_rsn_cipher_suite_to_cipher(ap->group_cipher);
 	uint32_t nl_akm =3D CRYPTO_AKM_PSK;
 	uint32_t wpa_version =3D NL80211_WPA_VERSION_2;
 	uint32_t auth_type =3D NL80211_AUTHTYPE_OPEN_SYSTEM;
@@ -2148,6 +2149,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 				&hidden_ssid);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_CIPHER_SUITES_PAIRWISE, 4,
 				&nl_ciphers);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_CIPHER_SUITE_GROUP, 4,
+				&group_nl_cipher);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_WPA_VERSIONS, 4, &wpa_version);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_AKM_SUITES, 4, &nl_akm);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
-- =

2.20.1

--===============4737690859354468413==--

