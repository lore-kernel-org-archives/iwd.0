Content-Type: multipart/mixed; boundary="===============4362067010658242149=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 6/6] netdev: use wiphy radio work queue for connections
Date: Wed, 08 Jul 2020 17:04:37 -0700
Message-ID: <20200709000437.32719-6-prestwoj@gmail.com>
In-Reply-To: <20200709000437.32719-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4362067010658242149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds connection/FT attempts to the radio work queue. This
will ensure that connections aren't delayed or done concurrently
with scanning.
---
 src/netdev.c | 86 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 20 deletions(-)

v3:
 - Added check for netdev->work.id before signaling work as done. This is
   because AP/AdHoc both use some netdev APIs and these modules do not yet
   use the work queue.

diff --git a/src/netdev.c b/src/netdev.c
index e469fb1c..a7f92ff8 100644
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
@@ -529,6 +535,7 @@ static void netdev_connect_free(struct netdev *netdev)
 	netdev->in_ft =3D false;
 	netdev->ignore_connect_event =3D false;
 	netdev->expect_connect_failure =3D false;
+	netdev->connect_cmd =3D NULL;
 =

 	netdev_rssi_polling_update(netdev);
 =

@@ -625,12 +632,12 @@ static void netdev_free(void *data)
 		netdev->mac_change_cmd_id =3D 0;
 	}
 =

+	scan_wdev_remove(netdev->wdev_id);
+
 	if (netdev->events_ready)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 					netdev, NETDEV_WATCH_EVENT_DEL);
 =

-	scan_wdev_remove(netdev->wdev_id);
-
 	watchlist_destroy(&netdev->station_watches);
 =

 	l_io_destroy(netdev->pae_io);
@@ -1019,6 +1026,9 @@ static void netdev_connect_ok(struct netdev *netdev)
 	}
 =

 	netdev_rssi_polling_update(netdev);
+
+	if (netdev->work.id)
+		wiphy_radio_work_done(netdev->wiphy, netdev->work.id);
 }
 =

 static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
@@ -1487,6 +1497,9 @@ void netdev_handshake_failed(struct handshake_state *=
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
@@ -2426,25 +2439,60 @@ struct rtnl_data {
 	int ref;
 };
 =

-static int netdev_begin_connection(struct netdev *netdev,
-					struct l_genl_msg *cmd_connect)
+static bool netdev_connection_ready(struct wiphy_radio_work_item *item)
 {
-	if (cmd_connect) {
+	struct netdev *netdev =3D l_container_of(item, struct netdev, work);
+
+	if (netdev->connect_cmd) {
 		netdev->connect_cmd_id =3D l_genl_family_send(nl80211,
-					cmd_connect, netdev_cmd_connect_cb,
-					netdev, NULL);
+					netdev->connect_cmd,
+					netdev_cmd_connect_cb, netdev, NULL);
 =

 		if (!netdev->connect_cmd_id) {
-			l_genl_msg_unref(cmd_connect);
-			return -EIO;
+			l_genl_msg_unref(netdev->connect_cmd);
+			netdev->connect_cmd =3D NULL;
+
+			netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+				MMPDU_STATUS_CODE_UNSPECIFIED);
+			return true;
 		}
+
+		netdev->connect_cmd =3D NULL;
 	}
 =

-	handshake_state_set_supplicant_address(netdev->handshake, netdev->addr);
+	if (netdev->ap) {
+		if (!auth_proto_start(netdev->ap)) {
+			/* Restore original nonce if this was an FT attempt */
+			if (netdev->in_ft)
+				memcpy(netdev->handshake->snonce,
+						netdev->prev_snonce, 32);
+
+			netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+						MMPDU_STATUS_CODE_UNSPECIFIED);
+			return true;
+		}
+		/*
+		 * set connected since the auth protocols cannot do
+		 * so internally
+		 */
 =

-	/* set connected since the auth protocols cannot do so internally */
-	if (netdev->ap && auth_proto_start(netdev->ap))
 		netdev->connected =3D true;
+	}
+
+	return false;
+}
+
+static const struct wiphy_radio_work_item_ops connect_work_ops =3D {
+	.do_work =3D netdev_connection_ready,
+};
+
+static int netdev_begin_connection(struct netdev *netdev,
+					struct l_genl_msg *cmd_connect)
+{
+	netdev->connect_cmd =3D cmd_connect;
+
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
+				&connect_work_ops);
 =

 	return 0;
 }
@@ -2514,6 +2562,8 @@ static void netdev_mac_power_up_cb(int error, uint16_=
t type,
 		return;
 	}
 =

+	handshake_state_set_supplicant_address(netdev->handshake, netdev->addr);
+
 	/*
 	 * Pick up where we left off in netdev_connect_commmon.
 	 */
@@ -2649,6 +2699,8 @@ static int netdev_connect_common(struct netdev *netde=
v,
 			return ret;
 	}
 =

+	handshake_state_set_supplicant_address(netdev->handshake, netdev->addr);
+
 	return netdev_begin_connection(netdev, cmd_connect);
 }
 =

@@ -3092,7 +3144,6 @@ static int fast_transition(struct netdev *netdev, str=
uct scan_bss *target_bss,
 				netdev_connect_cb_t cb)
 {
 	struct netdev_handshake_state *nhs;
-	int err =3D -EINVAL;
 =

 	if (!netdev->operational)
 		return -ENOTCONN;
@@ -3173,15 +3224,10 @@ static int fast_transition(struct netdev *netdev, s=
truct scan_bss *target_bss,
 					netdev_ft_over_ds_tx_authenticate,
 					netdev_ft_tx_associate, netdev);
 =

-	if (!auth_proto_start(netdev->ap))
-		goto restore_snonce;
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
+				&connect_work_ops);
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
-- =

2.21.1

--===============4362067010658242149==--

