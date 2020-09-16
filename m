Content-Type: multipart/mixed; boundary="===============9125300048776856207=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] p2p: Try IP allocation during 4-Way handshake on client
Date: Wed, 16 Sep 2020 11:17:53 +0200
Message-ID: <20200916091754.516851-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200916091754.516851-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9125300048776856207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 60 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index cf4d4bf3..5ee887d3 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -32,6 +32,8 @@
 #include <stdio.h>
 #include <time.h>
 #include <errno.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
 =

 #include <ell/ell.h>
 =

@@ -97,7 +99,9 @@ struct p2p_device {
 	uint32_t conn_new_intf_cmd_id;
 	struct wsc_enrollee *conn_enrollee;
 	struct netconfig *conn_netconfig;
+	struct l_settings *conn_netconfig_settings;
 	struct l_timeout *conn_dhcp_timeout;
+	char *conn_peer_ip;
 	struct p2p_wfd_properties *conn_own_wfd;
 	uint8_t conn_psk[32];
 	int conn_retry_count;
@@ -109,6 +113,7 @@ struct p2p_device {
 	unsigned int conn_go_scan_retry;
 	uint32_t conn_go_oper_freq;
 	uint8_t conn_peer_interface_addr[6];
+	struct p2p_capability_attr conn_peer_capability;
 =

 	struct p2p_group_id_attr go_group_id;
 	struct ap_state *group;
@@ -446,6 +451,9 @@ static void p2p_connection_reset(struct p2p_device *dev)
 	if (dev->conn_netconfig) {
 		netconfig_destroy(dev->conn_netconfig);
 		dev->conn_netconfig =3D NULL;
+		l_settings_free(dev->conn_netconfig_settings);
+		l_free(dev->conn_peer_ip);
+		dev->conn_peer_ip =3D NULL;
 	}
 =

 	if (dev->conn_new_intf_cmd_id)
@@ -761,6 +769,11 @@ static void p2p_netconfig_event_handler(enum netconfig=
_event event,
 	switch (event) {
 	case NETCONFIG_EVENT_CONNECTED:
 		l_timeout_remove(dev->conn_dhcp_timeout);
+
+		if (!dev->conn_peer_ip)
+			dev->conn_peer_ip =3D netconfig_get_dhcp_server_ipv4(
+							dev->conn_netconfig);
+
 		p2p_peer_connect_done(dev);
 		break;
 	default:
@@ -786,10 +799,11 @@ static void p2p_dhcp_timeout_destroy(void *user_data)
 	dev->conn_dhcp_timeout =3D NULL;
 }
 =

-static void p2p_start_dhcp_client(struct p2p_device *dev)
+static void p2p_start_client_netconfig(struct p2p_device *dev)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(dev->conn_netdev);
 	unsigned int dhcp_timeout_val;
+	struct l_settings *settings;
 =

 	if (!l_settings_get_uint(iwd_get_config(), "P2P", "DHCPTimeout",
 					&dhcp_timeout_val))
@@ -803,9 +817,9 @@ static void p2p_start_dhcp_client(struct p2p_device *de=
v)
 		}
 	}
 =

-	netconfig_configure(dev->conn_netconfig, p2p_dhcp_settings,
-				dev->conn_addr, p2p_netconfig_event_handler,
-				dev);
+	settings =3D dev->conn_netconfig_settings ?: p2p_dhcp_settings;
+	netconfig_configure(dev->conn_netconfig, settings, dev->conn_addr,
+				p2p_netconfig_event_handler, dev);
 	dev->conn_dhcp_timeout =3D l_timeout_create(dhcp_timeout_val,
 						p2p_dhcp_timeout, dev,
 						p2p_dhcp_timeout_destroy);
@@ -827,7 +841,7 @@ static void p2p_netdev_connect_cb(struct netdev *netdev,
 =

 	switch (result) {
 	case NETDEV_RESULT_OK:
-		p2p_start_dhcp_client(dev);
+		p2p_start_client_netconfig(dev);
 		break;
 	case NETDEV_RESULT_AUTHENTICATION_FAILED:
 	case NETDEV_RESULT_ASSOCIATION_FAILED:
@@ -916,6 +930,13 @@ static void p2p_netdev_event(struct netdev *netdev, en=
um netdev_event event,
 	};
 }
 =

+static const char *p2p_ip_to_string(uint32_t addr)
+{
+	struct in_addr ia =3D { .s_addr =3D L_CPU_TO_BE32(addr) };
+
+	return inet_ntoa(ia);
+}
+
 static void p2p_handshake_event(struct handshake_state *hs,
 				enum handshake_event event, void *user_data,
 				...)
@@ -925,6 +946,24 @@ static void p2p_handshake_event(struct handshake_state=
 *hs,
 	va_start(args, user_data);
 =

 	switch (event) {
+	case HANDSHAKE_EVENT_COMPLETE:
+	{
+		struct p2p_device *dev =3D user_data;
+		struct l_settings *ip_config;
+
+		if (!hs->support_ip_allocation)
+			break;
+
+		ip_config =3D l_settings_new();
+		l_settings_set_string(ip_config, "IPv4", "Address",
+					p2p_ip_to_string(hs->client_ip_addr));
+		l_settings_set_string(ip_config, "IPv4", "Netmask",
+					p2p_ip_to_string(hs->subnet_mask));
+		dev->conn_netconfig_settings =3D ip_config;
+		dev->conn_peer_ip =3D l_strdup(p2p_ip_to_string(hs->go_ip_addr));
+
+		break;
+	}
 	case HANDSHAKE_EVENT_FAILED:
 		netdev_handshake_failed(hs, va_arg(args, int));
 		break;
@@ -993,6 +1032,9 @@ static void p2p_try_connect_group(struct p2p_device *d=
ev)
 	handshake_state_set_ssid(hs, bss->ssid, bss->ssid_len);
 	handshake_state_set_pmk(hs, dev->conn_psk, 32);
 =

+	if (dev->conn_peer_capability.group_caps & P2P_GROUP_CAP_IP_ALLOCATION)
+		hs->support_ip_allocation =3D true;
+
 	r =3D netdev_connect(dev->conn_netdev, bss, hs, ie_iov, ie_num,
 				p2p_netdev_event, p2p_netdev_connect_cb, dev);
 	if (r < 0) {
@@ -1393,6 +1435,7 @@ static bool p2p_provision_scan_notify(int err, struct=
 l_queue *bss_list,
 		l_debug("GO found in the scan results");
 =

 		dev->conn_wsc_bss =3D bss;
+		dev->conn_peer_capability =3D *capability;
 		p2p_device_interface_create(dev);
 		l_queue_remove(bss_list, bss);
 		l_queue_destroy(bss_list,
@@ -4405,14 +4448,11 @@ static bool p2p_peer_get_connected_ip(struct l_dbus=
 *dbus,
 					void *user_data)
 {
 	struct p2p_peer *peer =3D user_data;
-	char *server_ip;
 =

-	if (!p2p_peer_operational(peer))
+	if (!p2p_peer_operational(peer) || !peer->dev->conn_peer_ip)
 		return false;
 =

-	server_ip =3D netconfig_get_dhcp_server_ipv4(peer->dev->conn_netconfig);
-	l_dbus_message_builder_append_basic(builder, 's', server_ip);
-	l_free(server_ip);
+	l_dbus_message_builder_append_basic(builder, 's', peer->dev->conn_peer_ip=
);
 	return true;
 }
 =

-- =

2.25.1

--===============9125300048776856207==--

