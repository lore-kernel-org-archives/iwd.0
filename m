Content-Type: multipart/mixed; boundary="===============2141048806528628917=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] netconfig: Add network configuration properties on
 Station and P2P
Date: Wed, 30 Jun 2021 21:06:34 +0200
Message-ID: <20210630190635.264095-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210630190635.264095-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2141048806528628917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add NetworkConfiguration D-Bus interfaces under the station and P2P
objects that expose current IP configurations.  Access Point and P2P-GO
are not handled yet, and some of the IP config properties may not
automatically generate PropertiesChanged on DHCP lease renewals but
their values are unlikely to change.
---
 src/dbus.h      |   1 +
 src/netconfig.c | 531 +++++++++++++++++++++++++++++++++++++++++++-----
 src/netconfig.h |   3 +-
 src/p2p.c       |   5 +-
 src/station.c   |  17 +-
 5 files changed, 496 insertions(+), 61 deletions(-)

diff --git a/src/dbus.h b/src/dbus.h
index b3896108..d5c58af2 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -42,6 +42,7 @@
 #define IWD_P2P_WFD_INTERFACE "net.connman.iwd.p2p.Display"
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
+#define IWD_NETCONFIG_INTERFACE "net.connman.iwd.NetworkConfiguration"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
diff --git a/src/netconfig.c b/src/netconfig.c
index 005316cd..20c39f0f 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -47,17 +47,24 @@
 #include "src/common.h"
 #include "src/network.h"
 #include "src/resolve.h"
+#include "src/dbus.h"
 #include "src/netconfig.h"
 =

 struct netconfig {
 	uint32_t ifindex;
+	char *device_path;
+	char *ipv4_path;
+	char *ipv6_path;
 	struct l_dhcp_client *dhcp_client;
 	struct l_dhcp6_client *dhcp6_client;
 	uint8_t rtm_protocol;
 	uint8_t rtm_v6_protocol;
 	struct l_rtnl_address *v4_address;
+	struct l_rtnl_address *v6_address;
 	char **dns4_overrides;
 	char **dns6_overrides;
+	char *v4_gateway_str;
+	char *v6_gateway_str;
 =

 	const struct l_settings *active_settings;
 =

@@ -129,6 +136,9 @@ static void netconfig_free(void *data)
 	l_dhcp_client_destroy(netconfig->dhcp_client);
 	l_dhcp6_client_destroy(netconfig->dhcp6_client);
 =

+	l_free(netconfig->device_path);
+	l_free(netconfig->ipv4_path);
+	l_free(netconfig->ipv6_path);
 	l_free(netconfig);
 }
 =

@@ -149,6 +159,38 @@ static struct netconfig *netconfig_find(uint32_t ifind=
ex)
 	return NULL;
 }
 =

+static char **netconfig_get_dns_list(struct netconfig *netconfig, int af)
+{
+	if (af =3D=3D AF_INET) {
+		const struct l_dhcp_lease *lease;
+
+		if (netconfig->dns4_overrides)
+			return l_strv_copy(netconfig->dns4_overrides);
+
+		if (netconfig->rtm_protocol !=3D RTPROT_DHCP)
+			return NULL;
+
+		if (!(lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client)))
+			return NULL;
+
+		return l_dhcp_lease_get_dns(lease);
+	} else {
+		const struct l_dhcp6_lease *lease;
+
+		if (netconfig->dns6_overrides)
+			return l_strv_copy(netconfig->dns6_overrides);
+
+		if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
+			return NULL;
+
+		if (!(lease =3D l_dhcp6_client_get_lease(
+						netconfig->dhcp6_client)))
+			return NULL;
+
+		return l_dhcp6_lease_get_dns(lease);
+	}
+}
+
 #define APPEND_STRDUPV(dest, index, src)			\
 	do {							\
 		char **p;					\
@@ -165,46 +207,25 @@ static struct netconfig *netconfig_find(uint32_t ifin=
dex)
 =

 static int netconfig_set_dns(struct netconfig *netconfig)
 {
-	char **dns6_list =3D NULL;
-	char **dns4_list =3D NULL;
-	unsigned int n_entries =3D 0;
+	char **dns4_list =3D netconfig_get_dns_list(netconfig, AF_INET);
+	char **dns6_list =3D netconfig_get_dns_list(netconfig, AF_INET6);
+	unsigned int n_entries4 =3D l_strv_length(dns4_list);
+	unsigned int n_entries6 =3D l_strv_length(dns6_list);
 	char **dns_list;
 =

-	if (!netconfig->dns4_overrides &&
-			netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
-		const struct l_dhcp_lease *lease =3D
-			l_dhcp_client_get_lease(netconfig->dhcp_client);
-
-		if (lease)
-			dns4_list =3D l_dhcp_lease_get_dns(lease);
-	}
+	if (!dns4_list && !dns6_list)
+		return 0;
 =

-	if (!netconfig->dns6_overrides &&
-			netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
-		const struct l_dhcp6_lease *lease =3D
-			l_dhcp6_client_get_lease(netconfig->dhcp6_client);
+	dns_list =3D l_realloc(dns4_list,
+				sizeof(char *) * (n_entries4 + n_entries6 + 1));
 =

-		if (lease)
-			dns6_list =3D l_dhcp6_lease_get_dns(lease);
+	if (dns6_list) {
+		memcpy(dns_list + n_entries4, dns6_list,
+			sizeof(char *) * (n_entries6 + 1));
+		/* Contents now belong to dns_list, so no l_strfreev */
+		l_free(dns6_list);
 	}
 =

-	n_entries +=3D l_strv_length(netconfig->dns4_overrides);
-	n_entries +=3D l_strv_length(netconfig->dns6_overrides);
-	n_entries +=3D l_strv_length(dns4_list);
-	n_entries +=3D l_strv_length(dns6_list);
-
-	dns_list =3D l_new(char *, n_entries + 1);
-	n_entries =3D 0;
-
-	APPEND_STRDUPV(dns_list, n_entries, netconfig->dns4_overrides);
-	APPENDV(dns_list, n_entries, dns4_list);
-	/* Contents now belong to ret, so not l_strfreev */
-	l_free(dns4_list);
-	APPEND_STRDUPV(dns_list, n_entries, netconfig->dns6_overrides);
-	APPENDV(dns_list, n_entries, dns6_list);
-	/* Contents now belong to ret, so not l_strfreev */
-	l_free(dns6_list);
-
 	resolve_set_dns(netconfig->resolve, dns_list);
 	l_strv_free(dns_list);
 	return 0;
@@ -385,7 +406,8 @@ no_prefix_len:
 }
 =

 static struct l_rtnl_route *netconfig_get_static6_gateway(
-						struct netconfig *netconfig)
+						struct netconfig *netconfig,
+						char **out_str)
 {
 	L_AUTO_FREE_VAR(char *, gateway);
 	struct l_rtnl_route *ret;
@@ -405,6 +427,7 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 =

 	l_rtnl_route_set_priority(ret, ROUTE_PRIORITY_OFFSET);
 	l_rtnl_route_set_protocol(ret, RTPROT_STATIC);
+	*out_str =3D l_steal_ptr(gateway);
 =

 	return ret;
 }
@@ -600,6 +623,47 @@ static void netconfig_route_generic_cb(int error, uint=
16_t type,
 	}
 }
 =

+static void netconfig_connected(struct netconfig *netconfig)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	if (netconfig->notify) {
+		netconfig->notify(NETCONFIG_EVENT_CONNECTED,
+					netconfig->user_data);
+		netconfig->notify =3D NULL;
+	}
+
+	if (netconfig->ipv4_path &&
+			!l_dbus_object_add_interface(dbus, netconfig->ipv4_path,
+							IWD_NETCONFIG_INTERFACE,
+							netconfig))
+		l_info("Unable to add %s to %s",
+			IWD_NETCONFIG_INTERFACE, netconfig->ipv4_path);
+
+	if (netconfig->ipv4_path &&
+			!l_dbus_object_add_interface(dbus, netconfig->ipv4_path,
+						L_DBUS_INTERFACE_PROPERTIES,
+						netconfig))
+		/* Properties may already exist on the object, not an error */
+		l_info("Unable to add %s to %s",
+			L_DBUS_INTERFACE_PROPERTIES, netconfig->ipv4_path);
+
+	if (netconfig->ipv6_path &&
+			!l_dbus_object_add_interface(dbus, netconfig->ipv6_path,
+							IWD_NETCONFIG_INTERFACE,
+							netconfig))
+		l_info("Unable to add %s to %s",
+			IWD_NETCONFIG_INTERFACE, netconfig->ipv6_path);
+
+	if (netconfig->ipv6_path &&
+			!l_dbus_object_add_interface(dbus, netconfig->ipv6_path,
+						L_DBUS_INTERFACE_PROPERTIES,
+						netconfig))
+		/* Properties may already exist on the object, not an error */
+		l_info("Unable to add %s to %s",
+			L_DBUS_INTERFACE_PROPERTIES, netconfig->ipv6_path);
+}
+
 static void netconfig_route_add_cmd_cb(int error, uint16_t type,
 						const void *data, uint32_t len,
 						void *user_data)
@@ -614,11 +678,7 @@ static void netconfig_route_add_cmd_cb(int error, uint=
16_t type,
 		return;
 	}
 =

-	if (!netconfig->notify)
-		return;
-
-	netconfig->notify(NETCONFIG_EVENT_CONNECTED, netconfig->user_data);
-	netconfig->notify =3D NULL;
+	netconfig_connected(netconfig);
 }
 =

 static bool netconfig_ipv4_routes_install(struct netconfig *netconfig)
@@ -656,12 +716,7 @@ static bool netconfig_ipv4_routes_install(struct netco=
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
+		netconfig_connected(netconfig);
 		return true;
 	}
 =

@@ -719,7 +774,8 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 		return;
 	}
 =

-	gateway =3D netconfig_get_static6_gateway(netconfig);
+	gateway =3D netconfig_get_static6_gateway(netconfig,
+						&netconfig->v6_gateway_str);
 	if (gateway) {
 		L_WARN_ON(!l_rtnl_route_add(rtnl, netconfig->ifindex,
 						gateway,
@@ -752,11 +808,44 @@ static void netconfig_ifaddr_del_cmd_cb(int error, ui=
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
 {
 	struct netconfig *netconfig =3D userdata;
+	struct l_dbus *dbus =3D dbus_get_bus();
 =

 	l_debug("DHCPv4 event %d", event);
 =

@@ -766,10 +855,45 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
l_dhcp_client *client,
 					netconfig->v4_address,
 					netconfig_ifaddr_del_cmd_cb,
 					netconfig, NULL));
-		l_rtnl_address_free(netconfig->v4_address);
 		/* Fall through. */
 	case L_DHCP_CLIENT_EVENT_LEASE_OBTAINED:
-		netconfig->v4_address =3D netconfig_get_dhcp4_address(netconfig);
+	{
+		char *gateway_str;
+		struct l_rtnl_address *address;
+
+		gateway_str =3D netconfig_ipv4_get_gateway(netconfig);
+		if (l_streq0(netconfig->v4_gateway_str, gateway_str))
+			l_free(gateway_str);
+		else {
+			l_free(netconfig->v4_gateway_str);
+			netconfig->v4_gateway_str =3D gateway_str;
+
+			if (netconfig->ipv4_path)
+				l_dbus_property_changed(dbus,
+							netconfig->ipv4_path,
+							IWD_NETCONFIG_INTERFACE,
+							"Gateway");
+		}
+
+		address =3D netconfig_get_dhcp4_address(netconfig);
+
+		if (netconfig->ipv4_path && !netconfig_address_cmp_prefix_len(
+							netconfig->v4_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->ipv4_path,
+						IWD_NETCONFIG_INTERFACE,
+						"Netmask");
+
+		if (netconfig->ipv4_path && netconfig_address_cmp_address(
+							netconfig->v4_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->ipv4_path,
+						IWD_NETCONFIG_INTERFACE,
+						"Address");
+
+		l_rtnl_address_free(netconfig->v4_address);
+		netconfig->v4_address =3D address;
+
 		if (!netconfig->v4_address) {
 			l_error("netconfig: Failed to obtain IP addresses from "
 							"DHCPv4 lease.");
@@ -782,6 +906,7 @@ static void netconfig_ipv4_dhcp_event_handler(struct l_=
dhcp_client *client,
 					netconfig_ipv4_ifaddr_add_cmd_cb,
 					netconfig, NULL)));
 		break;
+	}
 	case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
 		break;
 	case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
@@ -792,6 +917,25 @@ static void netconfig_ipv4_dhcp_event_handler(struct l=
_dhcp_client *client,
 		l_rtnl_address_free(netconfig->v4_address);
 		netconfig->v4_address =3D NULL;
 =

+		if (netconfig->ipv4_path) {
+			l_dbus_property_changed(dbus, netconfig->ipv4_path,
+						IWD_NETCONFIG_INTERFACE,
+						"Address");
+			l_dbus_property_changed(dbus, netconfig->ipv4_path,
+						IWD_NETCONFIG_INTERFACE,
+						"Netmask");
+		}
+
+		if (netconfig->v4_gateway_str) {
+			if (netconfig->ipv4_path)
+				l_dbus_property_changed(dbus,
+							netconfig->ipv4_path,
+							IWD_NETCONFIG_INTERFACE,
+							"Gateway");
+
+			l_free(l_steal_ptr(netconfig->v4_gateway_str));
+		}
+
 		/* Fall through. */
 	case L_DHCP_CLIENT_EVENT_NO_LEASE:
 		/*
@@ -814,18 +958,85 @@ static void netconfig_dhcp6_event_handler(struct l_dh=
cp6_client *client,
 						void *userdata)
 {
 	struct netconfig *netconfig =3D userdata;
+	struct l_dbus *dbus =3D dbus_get_bus();
 =

 	switch (event) {
 	case L_DHCP6_CLIENT_EVENT_IP_CHANGED:
 	case L_DHCP6_CLIENT_EVENT_LEASE_OBTAINED:
 	case L_DHCP6_CLIENT_EVENT_LEASE_RENEWED:
+	{
+		__auto_type lease =3D
+			l_dhcp6_client_get_lease(netconfig->dhcp6_client);
+		L_AUTO_FREE_VAR(char *, addr_str) =3D
+			l_dhcp6_lease_get_address(lease);
+		struct l_rtnl_address *address;
+		__auto_type icmp6 =3D
+			l_dhcp6_client_get_icmp6(netconfig->dhcp6_client);
+		__auto_type router =3D l_icmp6_client_get_router(icmp6);
+		char *gateway_str =3D l_icmp6_router_get_address(router);
+
+		if (l_streq0(netconfig->v6_gateway_str, gateway_str))
+			l_free(gateway_str);
+		else {
+			l_free(netconfig->v6_gateway_str);
+			netconfig->v6_gateway_str =3D gateway_str;
+
+			if (netconfig->ipv6_path)
+				l_dbus_property_changed(dbus,
+							netconfig->ipv6_path,
+							IWD_NETCONFIG_INTERFACE,
+							"Gateway");
+		}
+
+		address =3D l_rtnl_address_new(addr_str,
+					l_dhcp6_lease_get_prefix_length(lease));
+
+		if (netconfig->ipv6_path && !netconfig_address_cmp_prefix_len(
+							netconfig->v6_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->ipv6_path,
+						IWD_NETCONFIG_INTERFACE,
+						"Netmask");
+
+		if (netconfig->ipv4_path && netconfig_address_cmp_address(
+							netconfig->v6_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->ipv6_path,
+						IWD_NETCONFIG_INTERFACE,
+						"Address");
+
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v4_address =3D address;
+
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
 		break;
+	}
 	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
 		l_debug("Lease for interface %u expired", netconfig->ifindex);
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D NULL;
+
+		if (netconfig->ipv6_path) {
+			l_dbus_property_changed(dbus, netconfig->ipv6_path,
+						IWD_NETCONFIG_INTERFACE,
+						"Address");
+			l_dbus_property_changed(dbus, netconfig->ipv6_path,
+						IWD_NETCONFIG_INTERFACE,
+						"Netmask");
+		}
+
+		if (netconfig->v6_gateway_str) {
+			if (netconfig->ipv6_path)
+				l_dbus_property_changed(dbus,
+							netconfig->ipv6_path,
+							IWD_NETCONFIG_INTERFACE,
+							"Gateway");
+
+			l_free(l_steal_ptr(netconfig->v6_gateway_str));
+		}
 =

 		/* Fall through */
 	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
@@ -862,6 +1073,9 @@ static void netconfig_reset_v4(struct netconfig *netco=
nfig)
 =

 		l_acd_destroy(netconfig->acd);
 		netconfig->acd =3D NULL;
+
+		l_free(netconfig->v4_gateway_str);
+		netconfig->v4_gateway_str =3D NULL;
 	}
 }
 =

@@ -941,7 +1155,6 @@ static void netconfig_ipv4_select_and_install(struct n=
etconfig *netconfig)
 static void netconfig_ipv6_select_and_install(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-	struct l_rtnl_address *address;
 	bool enabled;
 =

 	if (!l_settings_get_bool(netconfig->active_settings, "IPv6",
@@ -955,14 +1168,14 @@ static void netconfig_ipv6_select_and_install(struct=
 netconfig *netconfig)
 =

 	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "0");
 =

-	address =3D netconfig_get_static6_address(netconfig);
-	if (address) {
+	netconfig->v6_address =3D netconfig_get_static6_address(netconfig);
+	if (netconfig->v6_address) {
 		netconfig->rtm_v6_protocol =3D RTPROT_STATIC;
 		L_WARN_ON(!(netconfig->addr6_add_cmd_id =3D
-			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex, address,
+			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
+					netconfig->v6_address,
 					netconfig_ipv6_ifaddr_add_cmd_cb,
 					netconfig, NULL)));
-		l_rtnl_address_free(address);
 		return;
 	}
 =

@@ -1088,6 +1301,7 @@ bool netconfig_reconfigure(struct netconfig *netconfi=
g)
 bool netconfig_reset(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
+	struct l_dbus *dbus =3D dbus_get_bus();
 =

 	if (netconfig->route4_add_gateway_cmd_id) {
 		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
@@ -1110,6 +1324,9 @@ bool netconfig_reset(struct netconfig *netconfig)
 	netconfig_reset_v4(netconfig);
 =

 	if (netconfig->rtm_v6_protocol) {
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D NULL;
+
 		l_strfreev(netconfig->dns6_overrides);
 		netconfig->dns6_overrides =3D NULL;
 =

@@ -1118,8 +1335,17 @@ bool netconfig_reset(struct netconfig *netconfig)
 =

 		sysfs_write_ipv6_setting(netdev_get_name(netdev),
 						"disable_ipv6", "1");
+
+		l_free(netconfig->v6_gateway_str);
+		netconfig->v6_gateway_str =3D NULL;
 	}
 =

+	if (netconfig->ipv4_path)
+		l_dbus_unregister_object(dbus, netconfig->ipv4_path);
+
+	if (netconfig->ipv6_path)
+		l_dbus_unregister_object(dbus, netconfig->ipv6_path);
+
 	return true;
 }
 =

@@ -1137,7 +1363,8 @@ char *netconfig_get_dhcp_server_ipv4(struct netconfig=
 *netconfig)
 	return l_dhcp_lease_get_server_id(lease);
 }
 =

-struct netconfig *netconfig_new(uint32_t ifindex)
+struct netconfig *netconfig_new(uint32_t ifindex, const char *device_path,
+				const char *ipv4_path, const char *ipv6_path)
 {
 	struct netdev *netdev =3D netdev_find(ifindex);
 	struct netconfig *netconfig;
@@ -1154,6 +1381,9 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 =

 	netconfig =3D l_new(struct netconfig, 1);
 	netconfig->ifindex =3D ifindex;
+	netconfig->device_path =3D l_strdup(device_path);
+	netconfig->ipv4_path =3D l_strdup(ipv4_path);
+	netconfig->ipv6_path =3D l_strdup(ipv6_path);
 	netconfig->resolve =3D resolve_new(ifindex);
 =

 	netconfig->dhcp_client =3D l_dhcp_client_new(ifindex);
@@ -1203,6 +1433,193 @@ void netconfig_destroy(struct netconfig *netconfig)
 	netconfig_free(netconfig);
 }
 =

+static bool netconfig_property_get_device(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct netconfig *netconfig =3D user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'o',
+						netconfig->device_path);
+	return true;
+}
+
+static bool netconfig_is_ipv4_obj(struct netconfig *netconfig,
+					struct l_dbus_message *message)
+{
+	return netconfig->ipv4_path &&
+		!strcmp(l_dbus_message_get_path(message), netconfig->ipv4_path);
+}
+
+static bool netconfig_property_get_method(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct netconfig *netconfig =3D user_data;
+	uint8_t protocol;
+
+	protocol =3D netconfig_is_ipv4_obj(netconfig, message) ?
+		netconfig->rtm_protocol : netconfig->rtm_v6_protocol;
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
+	struct netconfig *netconfig =3D user_data;
+	const struct l_rtnl_address *address;
+	char ip_str[INET6_ADDRSTRLEN];
+
+	address =3D netconfig_is_ipv4_obj(netconfig, message) ?
+		netconfig->v4_address : netconfig->v6_address;
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
+	struct netconfig *netconfig =3D user_data;
+	const struct l_rtnl_address *address;
+	uint8_t prefix_len;
+
+	address =3D netconfig_is_ipv4_obj(netconfig, message) ?
+		netconfig->v4_address : netconfig->v6_address;
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
+	struct netconfig *netconfig =3D user_data;
+	const char *gateway_str =3D netconfig_is_ipv4_obj(netconfig, message) ?
+		netconfig->v4_gateway_str : netconfig->v6_gateway_str;
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
+	struct netconfig *netconfig =3D user_data;
+	char **dns_str_list =3D netconfig_get_dns_list(netconfig,
+				netconfig_is_ipv4_obj(netconfig, message) ?
+				AF_INET : AF_INET6);
+	char **i;
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (i =3D dns_str_list; i && *i; i++)
+		l_dbus_message_builder_append_basic(builder, 's', *i);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_strv_free(dns_str_list);
+	return true;
+}
+
+static bool netconfig_property_get_domains(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct netconfig *netconfig =3D user_data;
+
+	if (netconfig_is_ipv4_obj(netconfig, message)) {
+		L_AUTO_FREE_VAR(char *, domain) =3D
+			l_settings_get_string(netconfig->active_settings,
+						"IPv4", "DomainName");
+
+		if (!domain) {
+			const struct l_dhcp_lease *lease;
+
+			if (netconfig->rtm_protocol !=3D RTPROT_DHCP)
+				return false;
+
+			lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
+			if (!lease)
+				return false;
+
+			if (!(domain =3D l_dhcp_lease_get_domain_name(lease)))
+				return false;
+		}
+
+		l_dbus_message_builder_enter_array(builder, "s");
+		l_dbus_message_builder_append_basic(builder, 's', domain);
+		l_dbus_message_builder_leave_array(builder);
+	} else {
+		const struct l_dhcp6_lease *lease;
+		char **domains;
+		char **i;
+
+		if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
+			return false;
+
+		lease =3D l_dhcp6_client_get_lease(netconfig->dhcp6_client);
+		if (!lease)
+			return false;
+
+		domains =3D l_dhcp6_lease_get_domains(lease);
+		if (!domains)
+			return false;
+
+		l_dbus_message_builder_enter_array(builder, "s");
+
+		for (i =3D domains; *i; i++)
+			l_dbus_message_builder_append_basic(builder, 's', *i);
+
+		l_dbus_message_builder_leave_array(builder);
+		l_strv_free(domains);
+	}
+
+	return true;
+}
+
+static void netconfig_setup_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_property(interface, "Device", 0, "o",
+					netconfig_property_get_device, NULL);
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
+					netconfig_property_get_domains, NULL);
+}
+
 static int netconfig_init(void)
 {
 	uint32_t r;
@@ -1254,6 +1671,8 @@ static int netconfig_init(void)
 =

 	netconfig_list =3D l_queue_new();
 =

+	l_dbus_register_interface(dbus_get_bus(), IWD_NETCONFIG_INTERFACE,
+					netconfig_setup_interface, NULL, false);
 	return 0;
 =

 error:
@@ -1270,6 +1689,8 @@ static void netconfig_exit(void)
 	rtnl =3D NULL;
 =

 	l_queue_destroy(netconfig_list, netconfig_free);
+
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_NETCONFIG_INTERFACE);
 }
 =

 IWD_MODULE(netconfig, netconfig_init, netconfig_exit)
diff --git a/src/netconfig.h b/src/netconfig.h
index 2c68cb1c..17c26c72 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -38,5 +38,6 @@ bool netconfig_reconfigure(struct netconfig *netconfig);
 bool netconfig_reset(struct netconfig *netconfig);
 char *netconfig_get_dhcp_server_ipv4(struct netconfig *netconfig);
 =

-struct netconfig *netconfig_new(uint32_t ifindex);
+struct netconfig *netconfig_new(uint32_t ifindex, const char *device_path,
+				const char *ipv4_path, const char *ipv6_path);
 void netconfig_destroy(struct netconfig *netconfig);
diff --git a/src/p2p.c b/src/p2p.c
index cb6cd98b..124372e6 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1319,7 +1319,10 @@ static void p2p_start_client_netconfig(struct p2p_de=
vice *dev)
 	struct l_settings *settings;
 =

 	if (!dev->conn_netconfig) {
-		dev->conn_netconfig =3D netconfig_new(ifindex);
+		const char *peer_path =3D p2p_peer_get_path(dev->conn_peer);
+
+		dev->conn_netconfig =3D netconfig_new(ifindex, peer_path,
+							peer_path, NULL);
 		if (!dev->conn_netconfig) {
 			p2p_connect_failed(dev);
 			return;
diff --git a/src/station.c b/src/station.c
index 0b0cc59c..6c7843d0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3568,6 +3568,7 @@ static struct station *station_create(struct netdev *=
netdev)
 {
 	struct station *station;
 	struct l_dbus *dbus =3D dbus_get_bus();
+	const char *path;
 =

 	station =3D l_new(struct station, 1);
 	watchlist_init(&station->state_watches, NULL);
@@ -3587,11 +3588,19 @@ static struct station *station_create(struct netdev=
 *netdev)
 =

 	station_set_autoconnect(station, true);
 =

-	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
-					IWD_STATION_INTERFACE, station);
+	path =3D netdev_get_path(netdev);
+	l_dbus_object_add_interface(dbus, path, IWD_STATION_INTERFACE, station);
+
+	if (netconfig_enabled) {
+		L_AUTO_FREE_VAR(char *, ipv4_path) =3D
+			l_strdup_printf("%s/ipv4", path);
+		L_AUTO_FREE_VAR(char *, ipv6_path) =3D
+			l_strdup_printf("%s/ipv6", path);
 =

-	if (netconfig_enabled)
-		station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev));
+		station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev),
+							path, ipv4_path,
+							ipv6_path);
+	}
 =

 	station->anqp_pending =3D l_queue_new();
 =

-- =

2.30.2

--===============2141048806528628917==--

