Content-Type: multipart/mixed; boundary="===============6537456240219398735=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: fix RoamThreshold5G
Date: Tue, 27 Jul 2021 15:50:23 -0700
Message-ID: <20210727225023.36586-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6537456240219398735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The RoamThreshold5G was never honored because it was being
set prior to any connections. This caused the logic inside
netdev_cqm_rssi_update to always choose the 2GHz threshold
(RoamThreshold) due to netdev->frequency being zero at this time.

Instead call netdev_cqm_rssi_update in all connect/transition
calls after netdev->frequency is updated. This will allow both
the 2G and 5G thresholds to be used depending on what frequency
the new BSS is.

The call to netdev_cqm_rssi_update in netdev_setup_interface
was also removed since it serves no purpose, at least now
that there are two thresholds to consider.
---
 src/netdev.c | 192 +++++++++++++++++++++++++--------------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 6a6deafd..deb780dc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3161,6 +3161,100 @@ static int netdev_start_powered_mac_change(struct n=
etdev *netdev)
 	return 0;
 }
 =

+static struct l_genl_msg *netdev_build_cmd_cqm_rssi_update(
+							struct netdev *netdev,
+							const int8_t *levels,
+							size_t levels_num)
+{
+	struct l_genl_msg *msg;
+	uint32_t hyst =3D 5;
+	int thold_count;
+	int32_t thold_list[levels_num + 2];
+	int threshold =3D netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
+						LOW_SIGNAL_THRESHOLD;
+
+	if (levels_num =3D=3D 0) {
+		thold_list[0] =3D threshold;
+		thold_count =3D 1;
+	} else {
+		/*
+		 * Build the list of all the threshold values we care about:
+		 *  - the low/high level threshold,
+		 *  - the value ranges requested by
+		 *    netdev_set_rssi_report_levels
+		 */
+		unsigned int i;
+		bool low_sig_added =3D false;
+
+		thold_count =3D 0;
+		for (i =3D 0; i < levels_num; i++) {
+			int32_t val =3D levels[levels_num - i - 1];
+
+			if (i && thold_list[thold_count - 1] >=3D val)
+				return NULL;
+
+			if (val >=3D threshold && !low_sig_added) {
+				thold_list[thold_count++] =3D threshold;
+				low_sig_added =3D true;
+
+				/* Duplicate values are not allowed */
+				if (val =3D=3D threshold)
+					continue;
+			}
+
+			thold_list[thold_count++] =3D val;
+		}
+	}
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_SET_CQM, 32 + thold_count * 4);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_enter_nested(msg, NL80211_ATTR_CQM);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_CQM_RSSI_THOLD,
+				thold_count * 4, thold_list);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_CQM_RSSI_HYST, 4, &hyst);
+	l_genl_msg_leave_nested(msg);
+
+	return msg;
+}
+
+static void netdev_cmd_set_cqm_cb(struct l_genl_msg *msg, void *user_data)
+{
+	int err =3D l_genl_msg_get_error(msg);
+	const char *ext_error;
+
+	if (err >=3D 0)
+		return;
+
+	ext_error =3D l_genl_msg_get_extended_error(msg);
+	l_error("CMD_SET_CQM failed: %s",
+			ext_error ? ext_error : strerror(-err));
+}
+
+static int netdev_cqm_rssi_update(struct netdev *netdev)
+{
+	struct l_genl_msg *msg;
+
+	l_debug("");
+
+	if (!wiphy_has_ext_feature(netdev->wiphy,
+					NL80211_EXT_FEATURE_CQM_RSSI_LIST))
+		msg =3D netdev_build_cmd_cqm_rssi_update(netdev, NULL, 0);
+	else
+		msg =3D netdev_build_cmd_cqm_rssi_update(netdev,
+						netdev->rssi_levels,
+						netdev->rssi_levels_num);
+	if (!msg)
+		return -EINVAL;
+
+	if (!l_genl_family_send(nl80211, msg, netdev_cmd_set_cqm_cb,
+				NULL, NULL)) {
+		l_genl_msg_unref(msg);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static bool netdev_connection_work_ready(struct wiphy_radio_work_item *ite=
m)
 {
 	struct netdev *netdev =3D l_container_of(item, struct netdev, work);
@@ -3309,6 +3403,7 @@ static int netdev_connect_common(struct netdev *netde=
v,
 	netdev->frequency =3D bss->frequency;
 	netdev->cur_rssi =3D bss->signal_strength / 100;
 	netdev_rssi_level_init(netdev);
+	netdev_cqm_rssi_update(netdev);
 =

 	handshake_state_set_authenticator_address(hs, bss->addr);
 =

@@ -3804,6 +3899,7 @@ static void prepare_ft(struct netdev *netdev, struct =
scan_bss *target_bss)
 	}
 =

 	netdev_rssi_polling_update(netdev);
+	netdev_cqm_rssi_update(netdev);
 =

 	if (netdev->sm) {
 		eapol_sm_free(netdev->sm);
@@ -4904,75 +5000,6 @@ static void netdev_unicast_notify(struct l_genl_msg =
*msg, void *user_data)
 	}
 }
 =

-static struct l_genl_msg *netdev_build_cmd_cqm_rssi_update(
-							struct netdev *netdev,
-							const int8_t *levels,
-							size_t levels_num)
-{
-	struct l_genl_msg *msg;
-	uint32_t hyst =3D 5;
-	int thold_count;
-	int32_t thold_list[levels_num + 2];
-	int threshold =3D netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
-						LOW_SIGNAL_THRESHOLD;
-
-	if (levels_num =3D=3D 0) {
-		thold_list[0] =3D threshold;
-		thold_count =3D 1;
-	} else {
-		/*
-		 * Build the list of all the threshold values we care about:
-		 *  - the low/high level threshold,
-		 *  - the value ranges requested by
-		 *    netdev_set_rssi_report_levels
-		 */
-		unsigned int i;
-		bool low_sig_added =3D false;
-
-		thold_count =3D 0;
-		for (i =3D 0; i < levels_num; i++) {
-			int32_t val =3D levels[levels_num - i - 1];
-
-			if (i && thold_list[thold_count - 1] >=3D val)
-				return NULL;
-
-			if (val >=3D threshold && !low_sig_added) {
-				thold_list[thold_count++] =3D threshold;
-				low_sig_added =3D true;
-
-				/* Duplicate values are not allowed */
-				if (val =3D=3D threshold)
-					continue;
-			}
-
-			thold_list[thold_count++] =3D val;
-		}
-	}
-
-	msg =3D l_genl_msg_new_sized(NL80211_CMD_SET_CQM, 32 + thold_count * 4);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_enter_nested(msg, NL80211_ATTR_CQM);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_CQM_RSSI_THOLD,
-				thold_count * 4, thold_list);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_CQM_RSSI_HYST, 4, &hyst);
-	l_genl_msg_leave_nested(msg);
-
-	return msg;
-}
-
-static void netdev_cmd_set_cqm_cb(struct l_genl_msg *msg, void *user_data)
-{
-	int err =3D l_genl_msg_get_error(msg);
-	const char *ext_error;
-
-	if (err >=3D 0)
-		return;
-
-	ext_error =3D l_genl_msg_get_extended_error(msg);
-	l_error("CMD_SET_CQM failed: %s",
-			ext_error ? ext_error : strerror(-err));
-}
-
 int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *lev=
els,
 					size_t levels_num)
 {
@@ -5131,31 +5158,6 @@ int netdev_get_all_stations(struct netdev *netdev, n=
etdev_get_station_cb_t cb,
 	return 0;
 }
 =

-static int netdev_cqm_rssi_update(struct netdev *netdev)
-{
-	struct l_genl_msg *msg;
-
-	l_debug("");
-
-	if (!wiphy_has_ext_feature(netdev->wiphy,
-					NL80211_EXT_FEATURE_CQM_RSSI_LIST))
-		msg =3D netdev_build_cmd_cqm_rssi_update(netdev, NULL, 0);
-	else
-		msg =3D netdev_build_cmd_cqm_rssi_update(netdev,
-						netdev->rssi_levels,
-						netdev->rssi_levels_num);
-	if (!msg)
-		return -EINVAL;
-
-	if (!l_genl_family_send(nl80211, msg, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
-		l_genl_msg_unref(msg);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static void netdev_add_station_frame_watches(struct netdev *netdev)
 {
 	static const uint8_t action_neighbor_report_prefix[2] =3D { 0x05, 0x05 };
@@ -5192,8 +5194,6 @@ static void netdev_setup_interface(struct netdev *net=
dev)
 {
 	switch (netdev->type) {
 	case NL80211_IFTYPE_STATION:
-		/* Set RSSI threshold for CQM notifications */
-		netdev_cqm_rssi_update(netdev);
 		netdev_add_station_frame_watches(netdev);
 		break;
 	default:
-- =

2.31.1

--===============6537456240219398735==--

