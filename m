Content-Type: multipart/mixed; boundary="===============1302807735176614666=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] netdev: factor out scan_bss from CMD_CONNECT builder
Date: Fri, 03 Sep 2021 12:26:24 -0700
Message-ID: <20210903192626.12890-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1302807735176614666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to support OWE in the CMD_CONNECT path the scan_bss parameter
needs to be removed since this is lost after netdev_connect returns.
Nearly everything needed is also stored in the handshake except the
privacy capability which is now being mirrored in the netdev object
itself.
---
 src/netdev.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index a5d1b8ed..8592685c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -181,6 +181,7 @@ struct netdev {
 	bool events_ready : 1;
 	bool retry_auth : 1;
 	bool in_reassoc : 1;
+	bool privacy : 1;
 };
 =

 struct netdev_preauth_state {
@@ -788,6 +789,7 @@ static void netdev_connect_free(struct netdev *netdev)
 	netdev->ignore_connect_event =3D false;
 	netdev->expect_connect_failure =3D false;
 	netdev->cur_rssi_low =3D false;
+	netdev->privacy =3D false;
 =

 	if (netdev->connect_cmd) {
 		l_genl_msg_unref(netdev->connect_cmd);
@@ -2901,7 +2903,6 @@ static void netdev_fils_tx_associate(struct iovec *fi=
ls_iov, size_t n_fils_iov,
 }
 =

 static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
-						struct scan_bss *bss,
 						struct handshake_state *hs,
 						const uint8_t *prev_bssid,
 						const struct iovec *vendor_ies,
@@ -2924,10 +2925,9 @@ static struct l_genl_msg *netdev_build_cmd_connect(s=
truct netdev *netdev,
 	msg =3D l_genl_msg_new_sized(NL80211_CMD_CONNECT, 512);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ,
-						4, &bss->frequency);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, bss->addr);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID,
-						bss->ssid_len, bss->ssid);
+							4, &netdev->frequency);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
 =

 	switch (nhs->type) {
@@ -2950,7 +2950,7 @@ static struct l_genl_msg *netdev_build_cmd_connect(st=
ruct netdev *netdev,
 		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, ETH_ALEN,
 						prev_bssid);
 =

-	if (bss->capability & IE_BSS_CAP_PRIVACY)
+	if (netdev->privacy)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_PRIVACY, 0, NULL);
 =

 	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
@@ -3476,6 +3476,10 @@ static void netdev_connect_common(struct netdev *net=
dev,
 	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
 	const uint8_t *prev_bssid =3D prev_bss ? prev_bss->addr : NULL;
 =

+	netdev->frequency =3D bss->frequency;
+	netdev->privacy =3D bss->capability & IE_BSS_CAP_PRIVACY;
+	handshake_state_set_authenticator_address(hs, bss->addr);
+
 	if (!is_rsn)
 		goto build_cmd_connect;
 =

@@ -3519,8 +3523,8 @@ static void netdev_connect_common(struct netdev *netd=
ev,
 		break;
 	default:
 build_cmd_connect:
-		cmd_connect =3D netdev_build_cmd_connect(netdev, bss, hs,
-					prev_bssid, vendor_ies, num_vendor_ies);
+		cmd_connect =3D netdev_build_cmd_connect(netdev, hs, prev_bssid,
+						vendor_ies, num_vendor_ies);
 =

 		if (!is_offload(hs) && (is_rsn || hs->settings_8021x)) {
 			sm =3D eapol_sm_new(hs);
@@ -3536,13 +3540,10 @@ build_cmd_connect:
 	netdev->user_data =3D user_data;
 	netdev->handshake =3D hs;
 	netdev->sm =3D sm;
-	netdev->frequency =3D bss->frequency;
 	netdev->cur_rssi =3D bss->signal_strength / 100;
 	netdev_rssi_level_init(netdev);
 	netdev_cqm_rssi_update(netdev);
 =

-	handshake_state_set_authenticator_address(hs, bss->addr);
-
 	if (!wiphy_has_ext_feature(netdev->wiphy,
 					NL80211_EXT_FEATURE_CAN_REPLACE_PTK0))
 		handshake_state_set_no_rekey(hs, true);
-- =

2.31.1

--===============1302807735176614666==--

