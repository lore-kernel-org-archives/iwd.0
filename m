Content-Type: multipart/mixed; boundary="===============1228326278061240196=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 16/18] p2p: Add ConnectedInterface and ConnectedIP Peer
 properties
Date: Sat, 11 Jul 2020 03:00:51 +0200
Message-ID: <20200711010053.224223-16-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1228326278061240196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The are useful for P2P service implementations to know unambiguously
which network interface a new P2P connection is on and the peer's IPv4
address if they need to initiate an IP connection or validate an
incoming connection's address from the peer.
---
 src/p2p.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index 03dc3b8b..aae633fb 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -617,6 +617,14 @@ static void p2p_netconfig_event_handler(enum netconfig=
_event event,
 		l_dbus_property_changed(dbus_get_bus(),
 					p2p_peer_get_path(dev->conn_peer),
 					IWD_P2P_PEER_INTERFACE, "Connected");
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(dev->conn_peer),
+					IWD_P2P_PEER_INTERFACE,
+					"ConnectedInterface");
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(dev->conn_peer),
+					IWD_P2P_PEER_INTERFACE,
+					"ConnectedIP");
 =

 		break;
 	default:
@@ -733,6 +741,14 @@ static void p2p_netdev_event(struct netdev *netdev, en=
um netdev_event event,
 		l_dbus_property_changed(dbus_get_bus(),
 					p2p_peer_get_path(dev->conn_peer),
 					IWD_P2P_PEER_INTERFACE, "Connected");
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(dev->conn_peer),
+					IWD_P2P_PEER_INTERFACE,
+					"ConnectedInterface");
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_peer_get_path(dev->conn_peer),
+					IWD_P2P_PEER_INTERFACE,
+					"ConnectedIP");
 		p2p_connection_reset(dev);
 		break;
 	default:
@@ -2438,9 +2454,16 @@ static void p2p_peer_disconnect(struct p2p_peer *pee=
r)
 		dbus_pending_reply(&peer->wsc.pending_connect,
 				dbus_error_aborted(peer->wsc.pending_connect));
 =

-	if (p2p_peer_operational(peer))
+	if (p2p_peer_operational(peer)) {
 		l_dbus_property_changed(dbus_get_bus(), p2p_peer_get_path(peer),
 					IWD_P2P_PEER_INTERFACE, "Connected");
+		l_dbus_property_changed(dbus_get_bus(), p2p_peer_get_path(peer),
+					IWD_P2P_PEER_INTERFACE,
+					"ConnectedInterface");
+		l_dbus_property_changed(dbus_get_bus(), p2p_peer_get_path(peer),
+					IWD_P2P_PEER_INTERFACE,
+					"ConnectedIP");
+	}
 =

 	dev->disconnecting =3D true;
 =

@@ -3968,6 +3991,38 @@ static bool p2p_peer_get_connected(struct l_dbus *db=
us,
 	return true;
 }
 =

+static bool p2p_peer_get_connected_if(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	const char *ifname =3D netdev_get_name(peer->dev->conn_netdev);
+
+	if (!p2p_peer_operational(peer))
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', ifname);
+	return true;
+}
+
+static bool p2p_peer_get_connected_ip(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	char *server_ip;
+
+	if (!p2p_peer_operational(peer))
+		return false;
+
+	server_ip =3D netconfig_get_dhcp_server_ipv4(peer->dev->conn_netconfig);
+	l_dbus_message_builder_append_basic(builder, 's', server_ip);
+	l_free(server_ip);
+	return true;
+}
+
 static struct l_dbus_message *p2p_peer_dbus_disconnect(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -3999,6 +4054,10 @@ static void p2p_peer_interface_setup(struct l_dbus_i=
nterface *interface)
 					p2p_peer_get_subcategory, NULL);
 	l_dbus_interface_property(interface, "Connected", 0, "b",
 					p2p_peer_get_connected, NULL);
+	l_dbus_interface_property(interface, "ConnectedInterface", 0, "s",
+					p2p_peer_get_connected_if, NULL);
+	l_dbus_interface_property(interface, "ConnectedIP", 0, "s",
+					p2p_peer_get_connected_ip, NULL);
 	l_dbus_interface_method(interface, "Disconnect", 0,
 				p2p_peer_dbus_disconnect, "", "");
 }
-- =

2.25.1

--===============1228326278061240196==--

