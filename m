Content-Type: multipart/mixed; boundary="===============1447154854437066132=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 7/8] netconfig: Add IPv4 configuration properties on Station
 and P2P
Date: Sat, 25 Sep 2021 03:11:52 +0200
Message-ID: <20210925011153.25195-7-andrew.zaborowski@intel.com>
In-Reply-To: 20210925011153.25195-1-andrew.zaborowski@intel.com

--===============1447154854437066132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the IPv4Configuration D-Bus interface on the station and P2P
objects that expose current netconfig values.  Access Point and P2P-GO
are not handled yet.
---
 src/dbus.h      |   1 +
 src/netconfig.c | 293 ++++++++++++++++++++++++++++++++++++++++++++++--
 src/netconfig.h |   2 +-
 src/p2p.c       |   4 +-
 src/station.c   |   8 +-
 5 files changed, 291 insertions(+), 17 deletions(-)

diff --git a/src/dbus.h b/src/dbus.h
index 7703b37f..a7248554 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -43,6 +43,7 @@
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
+#define IWD_IPV4_CONFIG_INTERFACE "net.connman.iwd.IPv4Configuration"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
diff --git a/src/netconfig.c b/src/netconfig.c
index 7cb6b2c6..b7c0b432 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -49,6 +49,7 @@
 #include "src/resolve.h"
 #include "src/util.h"
 #include "src/ie.h"
+#include "src/dbus.h"
 #include "src/netconfig.h"
 =

 struct netconfig {
@@ -73,6 +74,7 @@ struct netconfig {
 =

 	netconfig_notify_func_t notify;
 	void *user_data;
+	bool v4_configured;
 =

 	struct resolve *resolve;
 =

@@ -82,6 +84,12 @@ struct netconfig {
 	uint32_t addr6_add_cmd_id;
 	uint32_t route4_add_gateway_cmd_id;
 	uint32_t route6_add_cmd_id;
+
+	char *dbus_path;
+	struct interface_data {
+		uint8_t af;
+		struct netconfig *netconfig;
+	} v4_data;
 };
 =

 static struct l_netlink *rtnl;
@@ -140,6 +148,7 @@ static void netconfig_free(void *data)
 	l_dhcp_client_destroy(netconfig->dhcp_client);
 	l_dhcp6_client_destroy(netconfig->dhcp6_client);
 =

+	l_free(netconfig->dbus_path);
 	l_free(netconfig);
 }
 =

@@ -256,6 +265,19 @@ static char **netconfig_get_dns_list(struct netconfig =
*netconfig, int af,
 	}
 }
 =

+static void netconfig_property_changed(struct netconfig *netconfig, uint8_=
t af,
+					const char *property_name)
+{
+	if (!netconfig->dbus_path)
+		return;
+
+	if (!netconfig->v4_configured)
+		return;
+
+	l_dbus_property_changed(dbus_get_bus(), netconfig->dbus_path,
+				IWD_IPV4_CONFIG_INTERFACE, property_name);
+}
+
 static void netconfig_set_neighbor_entry_cb(int error,
 						uint16_t type, const void *data,
 						uint32_t len, void *user_data)
@@ -304,6 +326,7 @@ static void netconfig_dns_list_update(struct netconfig =
*netconfig, uint8_t af)
 =

 	l_strv_free(*dns_list_ptr);
 	*dns_list_ptr =3D new_dns_list;
+	netconfig_property_changed(netconfig, af, "DomainNameServers");
 =

 	if (fils_dns_mac) {
 		const struct ie_fils_ip_addr_response_info *fils =3D
@@ -399,6 +422,9 @@ static void netconfig_domains_update(struct netconfig *=
netconfig, uint8_t af)
 			changed =3D true;
 		}
 	}
+
+	if (changed)
+		netconfig_property_changed(netconfig, af, "DomainNames");
 }
 =

 static struct l_rtnl_address *netconfig_get_static4_address(
@@ -663,6 +689,57 @@ static void netconfig_ifaddr_cmd_cb(int error, uint16_=
t type,
 	netconfig_ifaddr_notify(type, data, len, user_data);
 }
 =

+static void netconfig_connected(struct netconfig *netconfig)
+{
+	if (netconfig->notify) {
+		netconfig->notify(NETCONFIG_EVENT_CONNECTED,
+					netconfig->user_data);
+		netconfig->notify =3D NULL;
+	}
+}
+
+static void netconfig_connected_v4(struct netconfig *netconfig)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	netconfig_connected(netconfig);
+
+	netconfig->v4_configured =3D true;
+
+	if (!netconfig->dbus_path)
+		return;
+
+	if (unlikely(!l_dbus_object_add_interface(dbus,
+						netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						&netconfig->v4_data)))
+		l_info("Unable to add %s at %s",
+			IWD_IPV4_CONFIG_INTERFACE, netconfig->dbus_path);
+
+	if (!l_dbus_object_add_interface(dbus, netconfig->dbus_path,
+						L_DBUS_INTERFACE_PROPERTIES,
+						netconfig))
+		/* Properties may already exist on the object, not an error */
+		l_debug("Unable to add %s at %s",
+			L_DBUS_INTERFACE_PROPERTIES, netconfig->dbus_path);
+}
+
+static void netconfig_disconnected_v4(struct netconfig *netconfig)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	netconfig->v4_configured =3D false;
+
+	if (!netconfig->dbus_path)
+		return;
+
+	if (unlikely(!l_dbus_object_remove_interface(dbus,
+						netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE)))
+		l_info("l_dbus_object_remove_interface failed for %s at %s",
+			IWD_IPV4_CONFIG_INTERFACE, netconfig->dbus_path);
+}
+
 static void netconfig_ifaddr_ipv6_added(struct netconfig *netconfig,
 					const struct ifaddrmsg *ifa,
 					uint32_t len)
@@ -772,11 +849,7 @@ static void netconfig_route_add_cmd_cb(int error, uint=
16_t type,
 		return;
 	}
 =

-	if (!netconfig->notify)
-		return;
-
-	netconfig->notify(NETCONFIG_EVENT_CONNECTED, netconfig->user_data);
-	netconfig->notify =3D NULL;
+	netconfig_connected_v4(netconfig);
 }
 =

 static void netconfig_route6_add_cb(int error, uint16_t type,
@@ -830,12 +903,7 @@ static bool netconfig_ipv4_routes_install(struct netco=
nfig *netconfig)
 				netconfig->rtm_protocol =3D=3D RTPROT_STATIC ?
 				"setting file" : "DHCPv4 lease");
 =

-		if (netconfig->notify) {
-			netconfig->notify(NETCONFIG_EVENT_CONNECTED,
-						netconfig->user_data);
-			netconfig->notify =3D NULL;
-		}
-
+		netconfig_connected_v4(netconfig);
 		return true;
 	}
 =

@@ -957,6 +1025,38 @@ static void netconfig_ifaddr_del_cmd_cb(int error, ui=
nt16_t type,
 				"Error %d: %s", error, strerror(-error));
 }
 =

+static bool netconfig_address_cmp_address(const struct l_rtnl_address *a,
+						const struct l_rtnl_address *b)
+{
+	char str_a[INET6_ADDRSTRLEN];
+	char str_b[INET6_ADDRSTRLEN];
+
+	if (a =3D=3D b)
+		return true;
+
+	if (!a || !b)
+		return false;
+
+	if (!l_rtnl_address_get_address(a, str_a) ||
+			!l_rtnl_address_get_address(b, str_b))
+		return false;
+
+	return !strcmp(str_a, str_b);
+}
+
+static bool netconfig_address_cmp_prefix_len(const struct l_rtnl_address *=
a,
+						const struct l_rtnl_address *b)
+{
+	if (a =3D=3D b)
+		return true;
+
+	if (!a || !b)
+		return false;
+
+	return l_rtnl_address_get_prefix_length(a) =3D=3D
+		l_rtnl_address_get_prefix_length(b);
+}
+
 static void netconfig_ipv4_dhcp_event_handler(struct l_dhcp_client *client,
 						enum l_dhcp_client_event event,
 						void *userdata)
@@ -983,9 +1083,22 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
l_dhcp_client *client,
 		else {
 			l_free(netconfig->v4_gateway_str);
 			netconfig->v4_gateway_str =3D gateway_str;
+			netconfig_property_changed(netconfig, AF_INET,
+							"Gateway");
 		}
 =

 		address =3D netconfig_get_dhcp4_address(netconfig);
+
+		if (!netconfig_address_cmp_prefix_len(netconfig->v4_address,
+							address))
+			netconfig_property_changed(netconfig, AF_INET,
+							"Netmask");
+
+		if (netconfig_address_cmp_address(netconfig->v4_address,
+							address))
+			netconfig_property_changed(netconfig, AF_INET,
+							"Address");
+
 		l_rtnl_address_free(netconfig->v4_address);
 		netconfig->v4_address =3D address;
 =

@@ -1016,6 +1129,9 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
l_dhcp_client *client,
 		netconfig->v4_address =3D NULL;
 		l_free(l_steal_ptr(netconfig->v4_gateway_str));
 =

+		if (netconfig->v4_configured)
+			netconfig_disconnected_v4(netconfig);
+
 		/* Fall through. */
 	case L_DHCP_CLIENT_EVENT_NO_LEASE:
 		/*
@@ -1102,6 +1218,9 @@ static void netconfig_remove_v4_address(struct netcon=
fig *netconfig)
 					netconfig, NULL));
 	l_rtnl_address_free(netconfig->v4_address);
 	netconfig->v4_address =3D NULL;
+
+	if (netconfig->v4_configured)
+		netconfig_disconnected_v4(netconfig);
 }
 =

 static void netconfig_reset_v4(struct netconfig *netconfig)
@@ -1473,6 +1592,9 @@ bool netconfig_reset(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
 =

+	if (netconfig->v4_configured)
+		netconfig_disconnected_v4(netconfig);
+
 	if (netconfig->route4_add_gateway_cmd_id) {
 		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
 		netconfig->route4_add_gateway_cmd_id =3D 0;
@@ -1565,7 +1687,7 @@ void netconfig_handle_fils_ip_resp(struct netconfig *=
netconfig,
 	netconfig->fils_override =3D l_memdup(info, sizeof(*info));
 }
 =

-struct netconfig *netconfig_new(uint32_t ifindex)
+struct netconfig *netconfig_new(uint32_t ifindex, const char *dbus_path)
 {
 	struct netdev *netdev =3D netdev_find(ifindex);
 	struct netconfig *netconfig;
@@ -1582,6 +1704,7 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 =

 	netconfig =3D l_new(struct netconfig, 1);
 	netconfig->ifindex =3D ifindex;
+	netconfig->dbus_path =3D l_strdup(dbus_path);
 	netconfig->resolve =3D resolve_new(ifindex);
 =

 	netconfig->dhcp_client =3D l_dhcp_client_new(ifindex);
@@ -1614,6 +1737,17 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	sysfs_write_ipv6_setting(netdev_get_name(netdev), "accept_ra", "0");
 	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "1");
 =

+	/*
+	 * Use struct interface_data as interface user_data so that the
+	 * property getters can check which interface they're being called
+	 * for.  For the org.freedesktop.DBus.Properties.{Get,GetAll} calls
+	 * we can read the interface name from the first argument but the
+	 * getters are also called when the InterfaceAdded signal messages
+	 * is being built.
+	 */
+	netconfig->v4_data.af =3D AF_INET;
+	netconfig->v4_data.netconfig =3D netconfig;
+
 	return netconfig;
 }
 =

@@ -1631,6 +1765,135 @@ void netconfig_destroy(struct netconfig *netconfig)
 	netconfig_free(netconfig);
 }
 =

+static bool netconfig_property_get_method(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct interface_data *data =3D user_data;
+	uint8_t protocol;
+
+	protocol =3D data->af =3D=3D AF_INET ? data->netconfig->rtm_protocol :
+		data->netconfig->rtm_v6_protocol;
+
+	l_dbus_message_builder_append_basic(builder, 's',
+						protocol =3D=3D RTPROT_DHCP ?
+						"auto" : "static");
+	return true;
+}
+
+static bool netconfig_property_get_address(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct interface_data *data =3D user_data;
+	const struct l_rtnl_address *address;
+	char ip_str[INET6_ADDRSTRLEN];
+
+	address =3D data->af =3D=3D AF_INET ? data->netconfig->v4_address :
+		data->netconfig->v6_address;
+
+	if (!address || !l_rtnl_address_get_address(address, ip_str))
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', ip_str);
+	return true;
+}
+
+static bool netconfig_property_get_prefix(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct interface_data *data =3D user_data;
+	const struct l_rtnl_address *address;
+	uint8_t prefix_len;
+
+	address =3D data->af =3D=3D AF_INET ?
+		data->netconfig->v4_address : data->netconfig->v6_address;
+
+	if (!address || !(prefix_len =3D
+				l_rtnl_address_get_prefix_length(address)))
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 'y', &prefix_len);
+	return true;
+}
+
+static bool netconfig_property_get_gateway(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct interface_data *data =3D user_data;
+	const char *gateway_str =3D data->af =3D=3D AF_INET ?
+		data->netconfig->v4_gateway_str :
+		data->netconfig->v6_gateway_str;
+
+	if (!gateway_str)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', gateway_str);
+	return true;
+}
+
+static bool netconfig_property_get_dnses(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct interface_data *data =3D user_data;
+	char **dns_str_list =3D data->af =3D=3D AF_INET ?
+		data->netconfig->dns4_list : data->netconfig->dns6_list;
+	char **i;
+
+	if (!dns_str_list)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (i =3D dns_str_list; i && *i; i++)
+		l_dbus_message_builder_append_basic(builder, 's', *i);
+
+	l_dbus_message_builder_leave_array(builder);
+	return true;
+}
+
+static bool netconfig_property_get_v4_domains(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct interface_data *data =3D user_data;
+
+	if (!data->netconfig->v4_domain)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "s");
+	l_dbus_message_builder_append_basic(builder, 's',
+						data->netconfig->v4_domain);
+	l_dbus_message_builder_leave_array(builder);
+	return true;
+}
+
+static void netconfig_setup_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_property(interface, "Method", 0, "s",
+					netconfig_property_get_method, NULL);
+	l_dbus_interface_property(interface, "Address", 0, "s",
+					netconfig_property_get_address, NULL);
+	l_dbus_interface_property(interface, "PrefixLength", 0, "y",
+					netconfig_property_get_prefix, NULL);
+	l_dbus_interface_property(interface, "Gateway", 0, "s",
+					netconfig_property_get_gateway, NULL);
+	l_dbus_interface_property(interface, "DomainNameServers", 0, "as",
+					netconfig_property_get_dnses, NULL);
+	l_dbus_interface_property(interface, "DomainNames", 0, "as",
+					netconfig_property_get_v4_domains,
+					NULL);
+}
+
 static int netconfig_init(void)
 {
 	uint32_t r;
@@ -1682,6 +1945,10 @@ static int netconfig_init(void)
 =

 	netconfig_list =3D l_queue_new();
 =

+	L_WARN_ON(unlikely(!l_dbus_register_interface(dbus_get_bus(),
+						IWD_IPV4_CONFIG_INTERFACE,
+						netconfig_setup_interface,
+						NULL, false)));
 	return 0;
 =

 error:
@@ -1698,6 +1965,8 @@ static void netconfig_exit(void)
 	rtnl =3D NULL;
 =

 	l_queue_destroy(netconfig_list, netconfig_free);
+
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_IPV4_CONFIG_INTERFACE);
 }
 =

 IWD_MODULE(netconfig, netconfig_init, netconfig_exit)
diff --git a/src/netconfig.h b/src/netconfig.h
index fa46c7c8..5d54d9cc 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -45,5 +45,5 @@ bool netconfig_get_fils_ip_req(struct netconfig *netconfi=
g,
 void netconfig_handle_fils_ip_resp(struct netconfig *netconfig,
 			const struct ie_fils_ip_addr_response_info *info);
 =

-struct netconfig *netconfig_new(uint32_t ifindex);
+struct netconfig *netconfig_new(uint32_t ifindex, const char *dbus_path);
 void netconfig_destroy(struct netconfig *netconfig);
diff --git a/src/p2p.c b/src/p2p.c
index 62df1ea5..dc5f3f72 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1319,7 +1319,9 @@ static void p2p_start_client_netconfig(struct p2p_dev=
ice *dev)
 	struct l_settings *settings;
 =

 	if (!dev->conn_netconfig) {
-		dev->conn_netconfig =3D netconfig_new(ifindex);
+		const char *peer_path =3D p2p_peer_get_path(dev->conn_peer);
+
+		dev->conn_netconfig =3D netconfig_new(ifindex, peer_path);
 		if (!dev->conn_netconfig) {
 			p2p_connect_failed(dev);
 			return;
diff --git a/src/station.c b/src/station.c
index 672c4860..934815f2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3826,6 +3826,7 @@ static struct station *station_create(struct netdev *=
netdev)
 	struct station *station;
 	struct l_dbus *dbus =3D dbus_get_bus();
 	bool autoconnect =3D true;
+	const char *path;
 =

 	station =3D l_new(struct station, 1);
 	watchlist_init(&station->state_watches, NULL);
@@ -3843,11 +3844,12 @@ static struct station *station_create(struct netdev=
 *netdev)
 =

 	l_queue_push_head(station_list, station);
 =

-	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
-					IWD_STATION_INTERFACE, station);
+	path =3D netdev_get_path(netdev);
+	l_dbus_object_add_interface(dbus, path, IWD_STATION_INTERFACE, station);
 =

 	if (netconfig_enabled)
-		station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev));
+		station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev),
+							path);
 =

 	station->anqp_pending =3D l_queue_new();
 =

-- =

2.30.2

--===============1447154854437066132==--

