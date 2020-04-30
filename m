Content-Type: multipart/mixed; boundary="===============2252392057256027467=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] p2p: Do DHCP as part of connection setup
Date: Thu, 30 Apr 2020 15:48:43 +0200
Message-ID: <20200430134847.62234-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200430134847.62234-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2252392057256027467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use netconfig.c functions to unconditionally run DHCP negotiation,
fail the connection setup if DHCP fails.  Only report connection success
after netconfig returns.
---
 src/p2p.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 7 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index be009505..4dd94da4 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -53,6 +53,7 @@
 #include "src/module.h"
 #include "src/frame-xchg.h"
 #include "src/nl80211util.h"
+#include "src/netconfig.h"
 #include "src/p2p.h"
 =

 struct p2p_device {
@@ -92,6 +93,8 @@ struct p2p_device {
 	uint32_t conn_netdev_watch_id;
 	uint32_t conn_new_intf_cmd_id;
 	struct wsc_enrollee *conn_enrollee;
+	struct netconfig *conn_netconfig;
+	struct l_timeout *conn_dhcp_timeout;
 =

 	struct l_timeout *config_timeout;
 	unsigned long go_config_delay;
@@ -132,6 +135,7 @@ struct p2p_peer {
 };
 =

 static struct l_queue *p2p_device_list;
+static struct l_settings *p2p_dhcp_settings;
 =

 /*
  * For now we only scan the common 2.4GHz channels, to be replaced with
@@ -185,7 +189,8 @@ static void p2p_discovery_user_free(void *data)
 static inline bool p2p_peer_operational(struct p2p_peer *peer)
 {
 	return peer && peer->dev->conn_netdev && !peer->dev->conn_wsc_bss &&
-		!peer->wsc.pending_connect && !peer->dev->disconnecting;
+		!peer->dev->conn_dhcp_timeout && !peer->wsc.pending_connect &&
+		!peer->dev->disconnecting;
 }
 =

 static bool p2p_peer_match(const void *a, const void *b)
@@ -325,6 +330,12 @@ static void p2p_connection_reset(struct p2p_device *de=
v)
 =

 	l_timeout_remove(dev->config_timeout);
 	l_timeout_remove(dev->go_neg_req_timeout);
+	l_timeout_remove(dev->conn_dhcp_timeout);
+
+	if (dev->conn_netconfig) {
+		netconfig_destroy(dev->conn_netconfig);
+		dev->conn_netconfig =3D NULL;
+	}
 =

 	if (dev->conn_new_intf_cmd_id)
 		/*
@@ -490,6 +501,71 @@ static const struct frame_xchg_prefix p2p_frame_pd_res=
p =3D {
 	.len =3D 7,
 };
 =

+static void p2p_netconfig_event_handler(enum netconfig_event event,
+					void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	struct p2p_peer *peer =3D dev->conn_peer;
+
+	switch (event) {
+	case NETCONFIG_EVENT_CONNECTED:
+		l_timeout_remove(dev->conn_dhcp_timeout);
+
+		dbus_pending_reply(&peer->wsc.pending_connect,
+					l_dbus_message_new_method_return(
+						peer->wsc.pending_connect));
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(dev->conn_peer),
+					IWD_P2P_PEER_INTERFACE, "Connected");
+
+		break;
+	default:
+		l_error("station: Unsupported netconfig event: %d.", event);
+		p2p_connect_failed(dev);
+		break;
+	}
+}
+
+static void p2p_dhcp_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	l_debug("");
+
+	p2p_connect_failed(dev);
+}
+
+static void p2p_dhcp_timeout_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->conn_dhcp_timeout =3D NULL;
+}
+
+static void p2p_start_dhcp(struct p2p_device *dev)
+{
+	uint32_t ifindex =3D netdev_get_ifindex(dev->conn_netdev);
+	unsigned int dhcp_timeout_val;
+
+	if (!l_settings_get_uint(iwd_get_config(), "P2P", "DHCPTimeout",
+					&dhcp_timeout_val))
+		dhcp_timeout_val =3D 10;	/* 10s default */
+
+	dev->conn_netconfig =3D netconfig_new(ifindex);
+	if (!dev->conn_netconfig) {
+		p2p_connect_failed(dev);
+		return;
+	}
+
+	netconfig_configure(dev->conn_netconfig, p2p_dhcp_settings,
+				dev->conn_addr, p2p_netconfig_event_handler,
+				dev);
+	dev->conn_dhcp_timeout =3D l_timeout_create(dhcp_timeout_val,
+						p2p_dhcp_timeout, dev,
+						p2p_dhcp_timeout_destroy);
+	return;
+}
+
 static void p2p_netdev_connect_cb(struct netdev *netdev,
 					enum netdev_result result,
 					void *event_data, void *user_data)
@@ -506,12 +582,7 @@ static void p2p_netdev_connect_cb(struct netdev *netde=
v,
 =

 	switch (result) {
 	case NETDEV_RESULT_OK:
-		dbus_pending_reply(&peer->wsc.pending_connect,
-					l_dbus_message_new_method_return(
-						peer->wsc.pending_connect));
-		l_dbus_property_changed(dbus_get_bus(),
-					p2p_peer_get_path(dev->conn_peer),
-					IWD_P2P_PEER_INTERFACE, "Connected");
+		p2p_start_dhcp(dev);
 		break;
 	case NETDEV_RESULT_AUTHENTICATION_FAILED:
 	case NETDEV_RESULT_ASSOCIATION_FAILED:
@@ -3485,6 +3556,7 @@ static int p2p_init(void)
 		l_error("Unable to register the %s interface",
 			IWD_P2P_PEER_INTERFACE);
 =

+	p2p_dhcp_settings =3D l_settings_new();
 	p2p_device_list =3D l_queue_new();
 =

 	return 0;
@@ -3496,8 +3568,11 @@ static void p2p_exit(void)
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_PEER_INTERFACE);
 	l_queue_destroy(p2p_device_list, p2p_device_free);
 	p2p_device_list =3D NULL;
+	l_settings_free(p2p_dhcp_settings);
+	p2p_dhcp_settings =3D NULL;
 }
 =

 IWD_MODULE(p2p, p2p_init, p2p_exit)
 IWD_MODULE_DEPENDS(p2p, wiphy)
 IWD_MODULE_DEPENDS(p2p, scan)
+IWD_MODULE_DEPENDS(p2p, netconfig)
-- =

2.25.1

--===============2252392057256027467==--

