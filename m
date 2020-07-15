Content-Type: multipart/mixed; boundary="===============6297706275520278130=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v8] netdev: use wiphy radio work queue for connections
Date: Wed, 15 Jul 2020 14:29:17 -0700
Message-ID: <20200715212917.16717-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6297706275520278130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds connection/FT attempts to the radio work queue. This
will ensure that connections aren't delayed or done concurrently
with scanning.
---
 src/netdev.c  | 191 ++++++++++++++++++++++++++++++++++++--------------
 src/station.c |   8 +--
 2 files changed, 141 insertions(+), 58 deletions(-)

v8:
 - Put auth-proto/normal connects back together as this prevented SAE
   from randomizing the address
 - Separated out ft work into its own worker function

diff --git a/src/netdev.c b/src/netdev.c
index e469fb1c..9e2690d3 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -136,6 +136,9 @@ struct netdev {
 =

 	struct l_io *pae_io;  /* for drivers without EAPoL over NL80211 */
 =

+	struct l_genl_msg *connect_cmd;
+	struct wiphy_radio_work_item work;
+
 	bool connected : 1;
 	bool operational : 1;
 	bool rekey_offload_support : 1;
@@ -485,6 +488,9 @@ static void netdev_preauth_destroy(void *data)
 =

 static void netdev_connect_free(struct netdev *netdev)
 {
+	if (netdev->work.id)
+		wiphy_radio_work_done(netdev->wiphy, netdev->work.id);
+
 	if (netdev->sm) {
 		eapol_sm_free(netdev->sm);
 		netdev->sm =3D NULL;
@@ -530,6 +536,11 @@ static void netdev_connect_free(struct netdev *netdev)
 	netdev->ignore_connect_event =3D false;
 	netdev->expect_connect_failure =3D false;
 =

+	if (netdev->connect_cmd) {
+		l_genl_msg_unref(netdev->connect_cmd);
+		netdev->connect_cmd =3D NULL;
+	}
+
 	netdev_rssi_polling_update(netdev);
 =

 	if (netdev->connect_cmd_id) {
@@ -1019,6 +1030,9 @@ static void netdev_connect_ok(struct netdev *netdev)
 	}
 =

 	netdev_rssi_polling_update(netdev);
+
+	if (netdev->work.id)
+		wiphy_radio_work_done(netdev->wiphy, netdev->work.id);
 }
 =

 static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
@@ -1487,6 +1501,9 @@ void netdev_handshake_failed(struct handshake_state *=
hs, uint16_t reason_code)
 		if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
 			l_error("error sending DEL_STATION");
 	}
+
+	if (netdev->work.id)
+		wiphy_radio_work_done(netdev->wiphy, netdev->work.id);
 }
 =

 static void hardware_rekey_cb(struct l_genl_msg *msg, void *data)
@@ -2421,32 +2438,48 @@ static struct l_genl_msg *netdev_build_cmd_connect(=
struct netdev *netdev,
 =

 struct rtnl_data {
 	struct netdev *netdev;
-	struct l_genl_msg *cmd_connect;
 	uint8_t addr[ETH_ALEN];
 	int ref;
 };
 =

-static int netdev_begin_connection(struct netdev *netdev,
-					struct l_genl_msg *cmd_connect)
+static int netdev_begin_connection(struct netdev *netdev)
 {
-	if (cmd_connect) {
+	if (netdev->connect_cmd) {
 		netdev->connect_cmd_id =3D l_genl_family_send(nl80211,
-					cmd_connect, netdev_cmd_connect_cb,
-					netdev, NULL);
+						netdev->connect_cmd,
+						netdev_cmd_connect_cb, netdev,
+						NULL);
 =

-		if (!netdev->connect_cmd_id) {
-			l_genl_msg_unref(cmd_connect);
-			return -EIO;
-		}
+		if (!netdev->connect_cmd_id)
+			goto failed;
+
+		netdev->connect_cmd =3D NULL;
 	}
 =

+	/*
+	 * Set the supplicant address now, this may have already been done for
+	 * a non-randomized address connect, but if we are randomizing we need
+	 * to set it again as the address should have now changed.
+	 */
 	handshake_state_set_supplicant_address(netdev->handshake, netdev->addr);
 =

-	/* set connected since the auth protocols cannot do so internally */
-	if (netdev->ap && auth_proto_start(netdev->ap))
+	if (netdev->ap) {
+		if (!auth_proto_start(netdev->ap))
+			goto failed;
+
+		/*
+		 * set connected since the auth protocols cannot do
+		 * so internally
+		 */
 		netdev->connected =3D true;
+	}
 =

 	return 0;
+
+failed:
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
+	return -EIO;
 }
 =

 static void netdev_mac_change_failed(struct netdev *netdev,
@@ -2461,8 +2494,6 @@ static void netdev_mac_change_failed(struct netdev *n=
etdev,
 	 * mac_change_cmd_id was set.
 	 */
 	if (!netdev_get_is_up(netdev)) {
-		l_genl_msg_unref(req->cmd_connect);
-
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 				netdev, NETDEV_WATCH_EVENT_DOWN);
 =

@@ -2474,7 +2505,7 @@ static void netdev_mac_change_failed(struct netdev *n=
etdev,
 		 */
 		l_info("Interface still up after failing to change the MAC, "
 			"continuing with connection");
-		if (netdev_begin_connection(netdev, req->cmd_connect) < 0)
+		if (netdev_begin_connection(netdev) < 0)
 			goto failed;
 =

 		return;
@@ -2517,7 +2548,7 @@ static void netdev_mac_power_up_cb(int error, uint16_=
t type,
 	/*
 	 * Pick up where we left off in netdev_connect_commmon.
 	 */
-	if (netdev_begin_connection(netdev, req->cmd_connect) < 0) {
+	if (netdev_begin_connection(netdev) < 0) {
 		l_error("Failed to connect after changing MAC");
 		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
 				MMPDU_STATUS_CODE_UNSPECIFIED);
@@ -2576,9 +2607,7 @@ static void netdev_mac_power_down_cb(int error, uint1=
6_t type,
  * Returns -EALREADY if the requested MAC matched our current MAC
  * Returns -EIO if there was an IO error when powering down
  */
-static int netdev_start_powered_mac_change(struct netdev *netdev,
-					struct scan_bss *bss,
-					struct l_genl_msg *cmd_connect)
+static int netdev_start_powered_mac_change(struct netdev *netdev)
 {
 	struct rtnl_data *req;
 	uint8_t new_addr[6];
@@ -2586,8 +2615,8 @@ static int netdev_start_powered_mac_change(struct net=
dev *netdev,
 	/* No address set in handshake, use per-network MAC generation */
 	if (util_mem_is_zero(netdev->handshake->spa, ETH_ALEN))
 		wiphy_generate_address_from_ssid(netdev->wiphy,
-						(const char *)bss->ssid,
-						new_addr);
+					(const char *)netdev->handshake->ssid,
+					new_addr);
 	else
 		memcpy(new_addr, netdev->handshake->spa, ETH_ALEN);
 =

@@ -2600,7 +2629,6 @@ static int netdev_start_powered_mac_change(struct net=
dev *netdev,
 	req =3D l_new(struct rtnl_data, 1);
 	req->netdev =3D netdev;
 	/* This message will need to be unreffed upon any error */
-	req->cmd_connect =3D cmd_connect;
 	req->ref++;
 	memcpy(req->addr, new_addr, sizeof(req->addr));
 =

@@ -2609,7 +2637,6 @@ static int netdev_start_powered_mac_change(struct net=
dev *netdev,
 					req, netdev_mac_destroy);
 =

 	if (!netdev->mac_change_cmd_id) {
-		l_genl_msg_unref(req->cmd_connect);
 		l_free(req);
 =

 		return -EIO;
@@ -2618,6 +2645,35 @@ static int netdev_start_powered_mac_change(struct ne=
tdev *netdev,
 	return 0;
 }
 =

+static bool netdev_connection_work_ready(struct wiphy_radio_work_item *ite=
m)
+{
+	struct netdev *netdev =3D l_container_of(item, struct netdev, work);
+
+	if (mac_per_ssid) {
+		int ret =3D netdev_start_powered_mac_change(netdev);
+
+		if (!ret)
+			return false;
+		else if (ret !=3D -EALREADY)
+			goto failed;
+	}
+
+	if (netdev_begin_connection(netdev) < 0)
+		goto failed;
+
+	return false;
+
+failed:
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+				MMPDU_STATUS_CODE_UNSPECIFIED);
+
+	return true;
+}
+
+static const struct wiphy_radio_work_item_ops connect_work_ops =3D {
+	.do_work =3D netdev_connection_work_ready,
+};
+
 static int netdev_connect_common(struct netdev *netdev,
 					struct l_genl_msg *cmd_connect,
 					struct scan_bss *bss,
@@ -2626,6 +2682,7 @@ static int netdev_connect_common(struct netdev *netde=
v,
 					netdev_event_func_t event_filter,
 					netdev_connect_cb_t cb, void *user_data)
 {
+	netdev->connect_cmd =3D cmd_connect;
 	netdev->event_filter =3D event_filter;
 	netdev->connect_cb =3D cb;
 	netdev->user_data =3D user_data;
@@ -2642,14 +2699,9 @@ static int netdev_connect_common(struct netdev *netd=
ev,
 					NL80211_EXT_FEATURE_CAN_REPLACE_PTK0))
 		handshake_state_set_no_rekey(hs, true);
 =

-	if (mac_per_ssid) {
-		int ret =3D netdev_start_powered_mac_change(netdev, bss,
-								cmd_connect);
-		if (ret !=3D -EALREADY)
-			return ret;
-	}
-
-	return netdev_begin_connection(netdev, cmd_connect);
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
+				&connect_work_ops);
+	return 0;
 }
 =

 int netdev_connect(struct netdev *netdev, struct scan_bss *bss,
@@ -2667,7 +2719,7 @@ int netdev_connect(struct netdev *netdev, struct scan=
_bss *bss,
 			netdev->type !=3D NL80211_IFTYPE_P2P_CLIENT)
 		return -ENOTSUP;
 =

-	if (netdev->connected || netdev->connect_cmd_id)
+	if (netdev->connected || netdev->connect_cmd_id || netdev->work.id)
 		return -EISCONN;
 =

 	switch (hs->akm_suite) {
@@ -2709,23 +2761,36 @@ int netdev_disconnect(struct netdev *netdev,
 				netdev_disconnect_cb_t cb, void *user_data)
 {
 	struct l_genl_msg *disconnect;
+	bool send_disconnect =3D true;
 =

 	if (netdev->type !=3D NL80211_IFTYPE_STATION &&
 			netdev->type !=3D NL80211_IFTYPE_P2P_CLIENT)
 		return -ENOTSUP;
 =

-	if (!netdev->connected)
-		return -ENOTCONN;
-
 	if (netdev->disconnect_cmd_id)
 		return -EINPROGRESS;
 =

 	/* Only perform this if we haven't successfully fully associated yet */
 	if (!netdev->operational) {
+		/*
+		 * Three possibilities here:
+		 * 1. We do not actually have a connect in progress (work.id
+		 *    is zero), then we can bail out early with an error.
+		 * 2. We have sent CMD_CONNECT but not fully connected. The
+		 *    CMD_CONNECT needs to be canceled and a disconnect should
+		 *    be sent.
+		 * 3. Queued up the connect work, but haven't sent CMD_CONNECT
+		 *    to the kernel. This case we do not need to send a
+		 *    disconnect.
+		 */
+		if (!netdev->work.id)
+			return -ENOTCONN;
+
 		if (netdev->connect_cmd_id) {
 			l_genl_family_cancel(nl80211, netdev->connect_cmd_id);
 			netdev->connect_cmd_id =3D 0;
-		}
+		} else
+			send_disconnect =3D false;
 =

 		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
 					MMPDU_REASON_CODE_UNSPECIFIED);
@@ -2733,19 +2798,23 @@ int netdev_disconnect(struct netdev *netdev,
 		netdev_connect_free(netdev);
 	}
 =

-	disconnect =3D netdev_build_cmd_disconnect(netdev,
+	if (send_disconnect) {
+		disconnect =3D netdev_build_cmd_disconnect(netdev,
 					MMPDU_REASON_CODE_DEAUTH_LEAVING);
-	netdev->disconnect_cmd_id =3D l_genl_family_send(nl80211, disconnect,
-				netdev_cmd_disconnect_cb, netdev, NULL);
+		netdev->disconnect_cmd_id =3D l_genl_family_send(nl80211,
+					disconnect, netdev_cmd_disconnect_cb,
+					netdev, NULL);
 =

-	if (!netdev->disconnect_cmd_id) {
-		l_genl_msg_unref(disconnect);
-		return -EIO;
-	}
+		if (!netdev->disconnect_cmd_id) {
+			l_genl_msg_unref(disconnect);
+			return -EIO;
+		}
 =

-	netdev->disconnect_cb =3D cb;
-	netdev->user_data =3D user_data;
-	netdev->aborting =3D true;
+		netdev->disconnect_cb =3D cb;
+		netdev->user_data =3D user_data;
+		netdev->aborting =3D true;
+	} else if (cb)
+		cb(netdev, true, user_data);
 =

 	return 0;
 }
@@ -3087,12 +3156,31 @@ static void netdev_ft_over_ds_tx_authenticate(struc=
t iovec *iov,
 					netdev_ft_request_cb);
 }
 =

+static bool netdev_ft_work_ready(struct wiphy_radio_work_item *item)
+{
+	struct netdev *netdev =3D l_container_of(item, struct netdev, work);
+
+	if (!auth_proto_start(netdev->ap)) {
+		/* Restore original nonce */
+		memcpy(netdev->handshake->snonce, netdev->prev_snonce, 32);
+
+		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+						MMPDU_STATUS_CODE_UNSPECIFIED);
+		return true;
+	}
+
+	return false;
+}
+
+static const struct wiphy_radio_work_item_ops ft_work_ops =3D {
+	.do_work =3D netdev_ft_work_ready,
+};
+
 static int fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
 				bool over_air,
 				netdev_connect_cb_t cb)
 {
 	struct netdev_handshake_state *nhs;
-	int err =3D -EINVAL;
 =

 	if (!netdev->operational)
 		return -ENOTCONN;
@@ -3173,15 +3261,10 @@ static int fast_transition(struct netdev *netdev, s=
truct scan_bss *target_bss,
 					netdev_ft_over_ds_tx_authenticate,
 					netdev_ft_tx_associate, netdev);
 =

-	if (!auth_proto_start(netdev->ap))
-		goto restore_snonce;
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
+				&ft_work_ops);
 =

 	return 0;
-
-restore_snonce:
-	memcpy(netdev->handshake->snonce, netdev->prev_snonce, 32);
-
-	return err;
 }
 =

 int netdev_fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
diff --git a/src/station.c b/src/station.c
index 35f4a96d..0095d6c8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2702,10 +2702,6 @@ int station_disconnect(struct station *station)
 	if (!station->connected_bss)
 		return -ENOTCONN;
 =

-	if (netdev_disconnect(station->netdev,
-					station_disconnect_cb, station) < 0)
-		return -EIO;
-
 	if (station->netconfig)
 		netconfig_reset(station->netconfig);
 =

@@ -2718,6 +2714,10 @@ int station_disconnect(struct station *station)
 =

 	station_enter_state(station, STATION_STATE_DISCONNECTING);
 =

+	if (netdev_disconnect(station->netdev,
+					station_disconnect_cb, station) < 0)
+		return -EIO;
+
 	return 0;
 }
 =

-- =

2.21.1

--===============6297706275520278130==--

