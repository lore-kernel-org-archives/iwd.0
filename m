Content-Type: multipart/mixed; boundary="===============6958167729913167494=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 16/17] p2p: Create the P2P-Client interface
Date: Fri, 03 Apr 2020 18:14:29 +0200
Message-ID: <20200403161430.14168-16-andrew.zaborowski@intel.com>
In-Reply-To: <20200403161430.14168-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6958167729913167494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once we've found the provisioning BSS create the P2P-Client interface
that we're going to use for the actual provisioning and the final P2P
connection.
---
 src/p2p.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 180 insertions(+), 5 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index abf91fc2..79be15e8 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -87,7 +87,11 @@ struct p2p_device {
 	char *conn_pin;
 	uint8_t conn_addr[6];
 	uint16_t conn_password_id;
+	unsigned int conn_num;
 	struct scan_bss *conn_wsc_bss;
+	struct netdev *conn_netdev;
+	uint32_t conn_netdev_watch_id;
+	uint32_t conn_new_intf_cmd_id;
 =

 	struct l_timeout *config_timeout;
 	unsigned long go_config_delay;
@@ -452,6 +456,47 @@ static void p2p_connection_reset(struct p2p_device *de=
v)
 	l_timeout_remove(dev->config_timeout);
 	l_timeout_remove(dev->go_neg_req_timeout);
 =

+	if (dev->conn_new_intf_cmd_id)
+		/*
+		 * Note this may result in the interface being created
+		 * and unused, we don't have its ifindex or wdev_id here
+		 * to be able to delete it.  Could use a separate netlink
+		 * socket for each connection or disallowing .Disconnect
+		 * calls while this command runs.
+		 */
+		l_genl_family_cancel(dev->nl80211, dev->conn_new_intf_cmd_id);
+
+	if (dev->conn_netdev) {
+		struct l_genl_msg *msg;
+		uint64_t wdev_id =3D netdev_get_wdev_id(dev->conn_netdev);
+
+		msg =3D l_genl_msg_new(NL80211_CMD_DEL_INTERFACE);
+		l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &wdev_id);
+
+		if (!l_genl_family_send(dev->nl80211, msg, NULL, NULL, NULL)) {
+			l_genl_msg_unref(msg);
+			l_error("Sending DEL_INTERFACE for %s failed",
+				netdev_get_name(dev->conn_netdev));
+		}
+
+		netdev_destroy(dev->conn_netdev);
+		dev->conn_netdev =3D NULL;
+	}
+
+	/*
+	 * Removing the netdev above makes sure that both the WSC connection
+	 * and the final WPA2 connection (wsc.c and netdev.c) no longer need
+	 * the bss so we can free it now -- if it wasn't freed as a result
+	 * of wsc_enrollee_cancel or netdev_destroy triggering
+	 * p2p_peer_provision_done in the first place.
+	 */
+	if (dev->conn_wsc_bss) {
+		scan_bss_free(dev->conn_wsc_bss);
+		dev->conn_wsc_bss =3D NULL;
+	}
+
+	netdev_watch_remove(dev->conn_netdev_watch_id);
+
 	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_CONNECT);
 	frame_xchg_stop(dev->wdev_id);
 =

@@ -572,11 +617,117 @@ static const struct frame_xchg_prefix p2p_frame_pd_r=
esp =3D {
 	.len =3D 7,
 };
 =

-static void p2p_device_interface_create(struct p2p_device *dev)
+static void p2p_provision_connect(struct p2p_device *dev)
 {
 	/* TODO */
 }
 =

+static void p2p_device_netdev_watch_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->conn_netdev_watch_id =3D 0;
+}
+
+static void p2p_device_netdev_notify(struct netdev *netdev,
+					enum netdev_watch_event event,
+					void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	if (dev->conn_netdev !=3D netdev)
+		return;
+
+	switch (event) {
+	case NETDEV_WATCH_EVENT_UP:
+	case NETDEV_WATCH_EVENT_NEW:
+		if (!dev->conn_wsc_bss || !netdev_get_is_up(netdev))
+			break;
+
+		p2p_provision_connect(dev);
+		break;
+	case NETDEV_WATCH_EVENT_DEL:
+		dev->conn_netdev =3D NULL;
+		/* Fall through */
+	case NETDEV_WATCH_EVENT_DOWN:
+	case NETDEV_WATCH_EVENT_ADDRESS_CHANGE:
+		p2p_connect_failed(dev);
+		break;
+	default:
+		break;
+	}
+}
+
+static void p2p_device_new_interface_cb(struct l_genl_msg *msg,
+					void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	l_debug("");
+
+	if (l_genl_msg_get_error(msg) < 0) {
+		l_error("NEW_INTERFACE failed: %s",
+			strerror(-l_genl_msg_get_error(msg)));
+		p2p_connect_failed(dev);
+		return;
+	}
+
+	/* Create the netdev so we don't have to parse the message ourselves */
+	dev->conn_netdev =3D netdev_create_from_genl(msg, dev->conn_addr);
+	if (!dev->conn_netdev) {
+		p2p_connect_failed(dev);
+		return;
+	}
+
+	/*
+	 * Register a watch for each connection rather than having one
+	 * global watch.  Each connection's watch will receive events
+	 * related to all other connections too, and will check that its
+	 * conn_netdev !=3D netdev and exit immediately.  This is not ideal
+	 * but it's the same complexity (n^2) as that of one global watch
+	 * that receives all events and iterates over p2p_device_list to
+	 * find the connection.
+	 */
+	dev->conn_netdev_watch_id =3D netdev_watch_add(p2p_device_netdev_notify,
+					dev, p2p_device_netdev_watch_destroy);
+}
+
+static void p2p_device_new_interface_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->conn_new_intf_cmd_id =3D 0;
+}
+
+static void p2p_device_interface_create(struct p2p_device *dev)
+{
+	uint32_t iftype =3D NL80211_IFTYPE_P2P_CLIENT;
+	char ifname[32];
+	uint32_t wiphy_id =3D dev->wdev_id >> 32;
+	struct l_genl_msg *msg;
+
+	snprintf(ifname, sizeof(ifname), "wlan%i-p2p-cl%i",
+			wiphy_id, dev->conn_num++);
+	l_debug("creating %s", ifname);
+
+	msg =3D l_genl_msg_new(NL80211_CMD_NEW_INTERFACE);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFTYPE, 4, &iftype);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFNAME,
+				strlen(ifname) + 1, ifname);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_4ADDR, 1, "\0");
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, "");
+
+	dev->conn_new_intf_cmd_id =3D l_genl_family_send(dev->nl80211, msg,
+					p2p_device_new_interface_cb, dev,
+					p2p_device_new_interface_destroy);
+	if (!dev->conn_new_intf_cmd_id) {
+		l_genl_msg_unref(msg);
+		l_error("Error sending NEW_INTERFACE for %s", ifname);
+		p2p_connect_failed(dev);
+	}
+}
+
 static void p2p_scan_destroy(void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
@@ -2526,6 +2677,15 @@ static void p2p_device_enable_destroy(void *user_dat=
a)
 	dev->start_stop_cmd_id =3D 0;
 }
 =

+static bool p2p_peer_remove_disconnected(void *peer, void *conn_peer)
+{
+	if (peer =3D=3D conn_peer)
+		return false;
+
+	p2p_peer_put(peer);
+	return true;
+}
+
 static bool p2p_device_start_stop(struct p2p_device *dev,
 				l_dbus_property_complete_cb_t complete,
 				struct l_dbus_message *message)
@@ -2557,13 +2717,28 @@ static bool p2p_device_start_stop(struct p2p_device=
 *dev,
 	if (dev->enabled) {
 		/*
 		 * Stopping the P2P device, drop all peers as we can't start
-		 * new connections from now on.
+		 * new connections from now on.  Check if we have a connection
+		 * being set up without a .conn_netdev and without
+		 * .conn_wsc_bss -- this will mean the connection is still in
+		 * the PD or GO Negotiation phase or inside the scan.  Those
+		 * phases happen on the device interface so the connection
+		 * gets immediately aborted.
 		 */
-		if (dev->conn_peer)
+		if (dev->conn_peer && !dev->conn_netdev && !dev->conn_wsc_bss)
 			p2p_connect_failed(dev);
 =

-		l_queue_destroy(dev->peer_list, p2p_peer_put);
-		dev->peer_list =3D NULL;
+		if (!dev->conn_peer) {
+			l_queue_destroy(dev->peer_list, p2p_peer_put);
+			dev->peer_list =3D NULL;
+		} else
+			/*
+			 * If the connection already depends on its own
+			 * netdev only, we can let it continue until the user
+			 * decides to disconnect.
+			 */
+			l_queue_foreach_remove(dev->peer_list,
+						p2p_peer_remove_disconnected,
+						dev->conn_peer);
 	}
 =

 	return true;
-- =

2.20.1

--===============6958167729913167494==--

