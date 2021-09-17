Content-Type: multipart/mixed; boundary="===============0543592715789301743=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] netconfig: Add IP configuration properties on Station and P2P
Date: Fri, 17 Sep 2021 12:18:22 +0200
Message-ID: <20210917101822.556531-1-andrew.zaborowski@intel.com>

--===============0543592715789301743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the IPv{4,6}Configuration D-Bus interfaces on the station and P2P
objects that expose current netconfig values.  Access Point and P2P-GO
are not handled yet.
---
 src/dbus.h      |   2 +
 src/netconfig.c | 651 +++++++++++++++++++++++++++++++++++++++++++-----
 src/netconfig.h |   2 +-
 src/p2p.c       |   4 +-
 src/station.c   |   8 +-
 5 files changed, 604 insertions(+), 63 deletions(-)

diff --git a/src/dbus.h b/src/dbus.h
index 7703b37f..a345f7ac 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -43,6 +43,8 @@
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
+#define IWD_IPV4_CONFIG_INTERFACE "net.connman.iwd.IPv4Configuration"
+#define IWD_IPV6_CONFIG_INTERFACE "net.connman.iwd.IPv6Configuration"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
diff --git a/src/netconfig.c b/src/netconfig.c
index 421270c9..a529fad4 100644
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
@@ -58,14 +59,23 @@ struct netconfig {
 	uint8_t rtm_protocol;
 	uint8_t rtm_v6_protocol;
 	struct l_rtnl_address *v4_address;
+	struct l_rtnl_address *v6_address;
 	char **dns4_overrides;
 	char **dns6_overrides;
+	char **dns4_list;
+	char **dns6_list;
 	struct ie_fils_ip_addr_response_info *fils_override;
+	char *v4_gateway_str;
+	char *v6_gateway_str;
+	char *v4_domain;
+	char **v6_domains;
 =

 	const struct l_settings *active_settings;
 =

 	netconfig_notify_func_t notify;
 	void *user_data;
+	bool v4_configured;
+	bool v6_configured;
 =

 	struct resolve *resolve;
 =

@@ -74,6 +84,13 @@ struct netconfig {
 	uint32_t addr4_add_cmd_id;
 	uint32_t addr6_add_cmd_id;
 	uint32_t route4_add_gateway_cmd_id;
+	uint32_t route6_add_cmd_id;
+
+	char *dbus_path;
+	struct interface_data {
+		bool is_ipv4;
+		struct netconfig *netconfig;
+	} v4_data, v6_data;
 };
 =

 static struct l_netlink *rtnl;
@@ -132,6 +149,7 @@ static void netconfig_free(void *data)
 	l_dhcp_client_destroy(netconfig->dhcp_client);
 	l_dhcp6_client_destroy(netconfig->dhcp6_client);
 =

+	l_free(netconfig->dbus_path);
 	l_free(netconfig);
 }
 =

@@ -257,6 +275,18 @@ static void netconfig_set_neighbor_entry_cb(int error,
 			strerror(-error), error);
 }
 =

+static bool netconfig_strv_eq(char *const *a, char *const *b)
+{
+	if (l_strv_length((char **) a) !=3D l_strv_length((char **) b))
+		return false;
+
+	for (; a && *a; a++, b++)
+		if (strcmp(*a, *b))
+			return false;
+
+	return true;
+}
+
 static int netconfig_set_dns(struct netconfig *netconfig)
 {
 	const uint8_t *fils_dns4_mac =3D NULL;
@@ -270,23 +300,25 @@ static int netconfig_set_dns(struct netconfig *netcon=
fig)
 	char **dns_list;
 	const struct ie_fils_ip_addr_response_info *fils =3D
 		netconfig->fils_override;
+	struct l_dbus *dbus =3D dbus_get_bus();
 =

-	if (!dns4_list && !dns6_list)
-		return 0;
+	if (dns6_list) {
+		dns_list =3D l_malloc(sizeof(char *) *
+					(n_entries4 + n_entries6 + 1));
 =

-	dns_list =3D dns4_list;
+		if (dns4_list)
+			memcpy(dns_list, dns4_list,
+				sizeof(char *) * n_entries4);
 =

-	if (dns6_list) {
-		dns_list =3D l_realloc(dns_list,
-				sizeof(char *) * (n_entries4 + n_entries6 + 1));
 		memcpy(dns_list + n_entries4, dns6_list,
 			sizeof(char *) * (n_entries6 + 1));
-		/* Contents now belong to dns_list, so no l_strfreev */
-		l_free(dns6_list);
-	}
+	} else
+		dns_list =3D dns4_list;
 =

 	resolve_set_dns(netconfig->resolve, dns_list);
-	l_strv_free(dns_list);
+
+	if (dns6_list)
+		l_free(dns_list);
 =

 	if (fils_dns4_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
 					netconfig->ifindex, AF_INET,
@@ -302,6 +334,30 @@ static int netconfig_set_dns(struct netconfig *netconf=
ig)
 					NULL))
 		l_debug("l_rtnl_neighbor_set_hwaddr failed");
 =

+	if (netconfig_strv_eq(netconfig->dns4_list, dns4_list))
+		l_strv_free(dns4_list);
+	else {
+		l_strv_free(netconfig->dns4_list);
+		netconfig->dns4_list =3D dns4_list;
+
+		if (netconfig->dbus_path && netconfig->v4_configured)
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"DomainNameServers");
+	}
+
+	if (netconfig_strv_eq(netconfig->dns6_list, dns6_list))
+		l_strv_free(dns6_list);
+	else {
+		l_strv_free(netconfig->dns6_list);
+		netconfig->dns6_list =3D dns6_list;
+
+		if (netconfig->dbus_path && netconfig->v6_configured)
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"DomainNameServers");
+	}
+
 	return 0;
 }
 =

@@ -328,6 +384,7 @@ static int netconfig_set_domains(struct netconfig *netc=
onfig)
 	char *v4_domain =3D NULL;
 	char **v6_domains =3D NULL;
 	char **p;
+	struct l_dbus *dbus =3D dbus_get_bus();
 =

 	memset(domains, 0, sizeof(domains));
 =

@@ -358,8 +415,30 @@ static int netconfig_set_domains(struct netconfig *net=
config)
 					L_ARRAY_SIZE(domains) - 1, *p);
 =

 	resolve_set_domains(netconfig->resolve, domains);
-	l_strv_free(v6_domains);
-	l_free(v4_domain);
+
+	if (l_streq0(v4_domain, netconfig->v4_domain))
+		l_free(v4_domain);
+	else {
+		l_free(netconfig->v4_domain);
+		netconfig->v4_domain =3D v4_domain;
+
+		if (netconfig->dbus_path && netconfig->v4_configured)
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"DomainNames");
+	}
+
+	if (netconfig_strv_eq(netconfig->v6_domains, v6_domains))
+		l_strv_free(v6_domains);
+	else {
+		l_strv_free(netconfig->v6_domains);
+		netconfig->v6_domains =3D v6_domains;
+
+		if (netconfig->dbus_path && netconfig->v6_configured)
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"DomainNames");
+	}
 =

 	return 0;
 }
@@ -417,6 +496,8 @@ static char *netconfig_ipv4_get_gateway(struct netconfi=
g *netconfig,
 {
 	const struct l_dhcp_lease *lease;
 	char *gateway;
+	const struct ie_fils_ip_addr_response_info *fils =3D
+		netconfig->fils_override;
 =

 	switch (netconfig->rtm_protocol) {
 	case RTPROT_STATIC:
@@ -430,15 +511,12 @@ static char *netconfig_ipv4_get_gateway(struct netcon=
fig *netconfig,
 		return gateway;
 =

 	case RTPROT_DHCP:
-		if (netconfig->fils_override &&
-				netconfig->fils_override->ipv4_gateway) {
-			gateway =3D netconfig_ipv4_to_string(
-					netconfig->fils_override->ipv4_gateway);
+		if (fils && fils->ipv4_gateway) {
+			gateway =3D netconfig_ipv4_to_string(fils->ipv4_gateway);
 =

-			if (gateway && !l_memeqzero(netconfig->fils_override->
-							ipv4_gateway_mac, 6))
-				*out_mac =3D netconfig->fils_override->
-					ipv4_gateway_mac;
+			if (gateway && out_mac &&
+					!l_memeqzero(fils->ipv4_gateway_mac, 6))
+				*out_mac =3D fils->ipv4_gateway_mac;
 =

 			return gateway;
 		}
@@ -476,7 +554,7 @@ static struct l_rtnl_address *netconfig_get_static6_add=
ress(
 	prefix_len =3D strtoul(p, NULL, 10);
 	if (!unlikely(errno =3D=3D EINVAL || errno =3D=3D ERANGE ||
 			!prefix_len || prefix_len > 128)) {
-		l_error("netconfig: Invalid prefix '%s'  provided in network"
+		l_error("netconfig: Invalid prefix '%s' provided in network"
 				" configuration file", p);
 		return NULL;
 	}
@@ -492,10 +570,12 @@ no_prefix_len:
 =

 static struct l_rtnl_route *netconfig_get_static6_gateway(
 						struct netconfig *netconfig,
+						char **out_str,
 						const uint8_t **out_mac)
 {
 	L_AUTO_FREE_VAR(char *, gateway);
 	struct l_rtnl_route *ret;
+	const uint8_t *mac =3D NULL;
 =

 	gateway =3D l_settings_get_string(netconfig->active_settings,
 						"IPv6", "Gateway");
@@ -507,7 +587,7 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 					netconfig->fils_override->ipv6_gateway);
 =

 		if (!l_memeqzero(netconfig->fils_override->ipv6_gateway_mac, 6))
-			*out_mac =3D netconfig->fils_override->ipv6_gateway_mac;
+			mac =3D netconfig->fils_override->ipv6_gateway_mac;
 	} else if (!gateway)
 		return NULL;
 =

@@ -521,6 +601,8 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 =

 	l_rtnl_route_set_priority(ret, ROUTE_PRIORITY_OFFSET);
 	l_rtnl_route_set_protocol(ret, RTPROT_STATIC);
+	*out_str =3D l_steal_ptr(gateway);
+	*out_mac =3D mac;
 =

 	return ret;
 }
@@ -623,6 +705,99 @@ static void netconfig_ifaddr_cmd_cb(int error, uint16_=
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
+	if (!netconfig->v6_configured &&
+			!l_dbus_object_add_interface(dbus, netconfig->dbus_path,
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
+static void netconfig_disconnected_v6(struct netconfig *netconfig)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	netconfig->v6_configured =3D false;
+
+	if (!netconfig->dbus_path)
+		return;
+
+	if (unlikely(!l_dbus_object_remove_interface(dbus,
+						netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE)))
+		l_info("l_dbus_object_remove_interface failed for %s at %s",
+			IWD_IPV6_CONFIG_INTERFACE, netconfig->dbus_path);
+}
+
+static void netconfig_connected_v6(struct netconfig *netconfig)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	netconfig->v6_configured =3D true;
+
+	if (!netconfig->dbus_path)
+		return;
+
+	if (unlikely(!l_dbus_object_add_interface(dbus,
+						netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						&netconfig->v6_data)))
+		l_info("Unable to add %s at %s",
+			IWD_IPV6_CONFIG_INTERFACE, netconfig->dbus_path);
+
+	if (!netconfig->v4_configured &&
+			!l_dbus_object_add_interface(dbus, netconfig->dbus_path,
+						L_DBUS_INTERFACE_PROPERTIES,
+						netconfig))
+		/* Properties may already exist on the object, not an error */
+		l_debug("Unable to add %s at %s",
+			L_DBUS_INTERFACE_PROPERTIES, netconfig->dbus_path);
+}
+
 static void netconfig_ifaddr_ipv6_added(struct netconfig *netconfig,
 					const struct ifaddrmsg *ifa,
 					uint32_t len)
@@ -732,11 +907,24 @@ static void netconfig_route_add_cmd_cb(int error, uin=
t16_t type,
 		return;
 	}
 =

-	if (!netconfig->notify)
+	netconfig_connected_v4(netconfig);
+}
+
+static void netconfig_route6_add_cb(int error, uint16_t type,
+					const void *data, uint32_t len,
+					void *user_data)
+{
+	struct netconfig *netconfig =3D user_data;
+
+	netconfig->route6_add_cmd_id =3D 0;
+
+	if (error) {
+		l_error("netconfig: Failed to add route. Error %d: %s",
+						error, strerror(-error));
 		return;
+	}
 =

-	netconfig->notify(NETCONFIG_EVENT_CONNECTED, netconfig->user_data);
-	netconfig->notify =3D NULL;
+	netconfig_connected_v6(netconfig);
 }
 =

 static bool netconfig_ipv4_routes_install(struct netconfig *netconfig)
@@ -775,12 +963,7 @@ static bool netconfig_ipv4_routes_install(struct netco=
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

@@ -847,7 +1030,7 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error=
, uint16_t type,
 {
 	struct netconfig *netconfig =3D user_data;
 	struct l_rtnl_route *gateway;
-	const uint8_t *gateway_mac =3D NULL;
+	const uint8_t *gateway_mac;
 =

 	netconfig->addr6_add_cmd_id =3D 0;
 =

@@ -857,12 +1040,16 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int err=
or, uint16_t type,
 		return;
 	}
 =

-	gateway =3D netconfig_get_static6_gateway(netconfig, &gateway_mac);
+	gateway =3D netconfig_get_static6_gateway(netconfig,
+						&netconfig->v6_gateway_str,
+						&gateway_mac);
 	if (gateway) {
-		L_WARN_ON(!l_rtnl_route_add(rtnl, netconfig->ifindex,
-						gateway,
-						netconfig_route_generic_cb,
-						netconfig, NULL));
+		netconfig->route6_add_cmd_id =3D l_rtnl_route_add(rtnl,
+							netconfig->ifindex,
+							gateway,
+							netconfig_route6_add_cb,
+							netconfig, NULL);
+		L_WARN_ON(unlikely(!netconfig->route6_add_cmd_id));
 		l_rtnl_route_free(gateway);
 =

 		if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
@@ -876,6 +1063,9 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error=
, uint16_t type,
 =

 	netconfig_set_dns(netconfig);
 	netconfig_set_domains(netconfig);
+
+	if (!netconfig->route6_add_cmd_id)
+		netconfig_connected_v6(netconfig);
 }
 =

 static void netconfig_ifaddr_del_cmd_cb(int error, uint16_t type,
@@ -898,11 +1088,44 @@ static void netconfig_ifaddr_del_cmd_cb(int error, u=
int16_t type,
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

@@ -912,10 +1135,47 @@ static void netconfig_ipv4_dhcp_event_handler(struct=
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
+		gateway_str =3D netconfig_ipv4_get_gateway(netconfig, NULL);
+		if (l_streq0(netconfig->v4_gateway_str, gateway_str))
+			l_free(gateway_str);
+		else {
+			l_free(netconfig->v4_gateway_str);
+			netconfig->v4_gateway_str =3D gateway_str;
+
+			if (netconfig->dbus_path && netconfig->v4_configured)
+				l_dbus_property_changed(dbus,
+						netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"Gateway");
+		}
+
+		address =3D netconfig_get_dhcp4_address(netconfig);
+
+		if (netconfig->dbus_path && netconfig->v4_configured &&
+				!netconfig_address_cmp_prefix_len(
+							netconfig->v4_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"Netmask");
+
+		if (netconfig->dbus_path && netconfig->v4_configured &&
+				netconfig_address_cmp_address(
+							netconfig->v4_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"Address");
+
+		l_rtnl_address_free(netconfig->v4_address);
+		netconfig->v4_address =3D address;
+
 		if (!netconfig->v4_address) {
 			l_error("netconfig: Failed to obtain IP addresses from "
 							"DHCPv4 lease.");
@@ -928,6 +1188,7 @@ static void netconfig_ipv4_dhcp_event_handler(struct l=
_dhcp_client *client,
 					netconfig_ipv4_ifaddr_add_cmd_cb,
 					netconfig, NULL)));
 		break;
+	}
 	case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
 		break;
 	case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
@@ -937,6 +1198,10 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
l_dhcp_client *client,
 					netconfig, NULL));
 		l_rtnl_address_free(netconfig->v4_address);
 		netconfig->v4_address =3D NULL;
+		l_free(l_steal_ptr(netconfig->v4_gateway_str));
+
+		if (netconfig->v4_configured)
+			netconfig_disconnected_v4(netconfig);
 =

 		/* Fall through. */
 	case L_DHCP_CLIENT_EVENT_NO_LEASE:
@@ -960,18 +1225,76 @@ static void netconfig_dhcp6_event_handler(struct l_d=
hcp6_client *client,
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
+			if (netconfig->dbus_path && netconfig->v6_configured)
+				l_dbus_property_changed(dbus,
+						netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"Gateway");
+		}
+
+		address =3D l_rtnl_address_new(addr_str,
+					l_dhcp6_lease_get_prefix_length(lease));
+
+		if (netconfig->dbus_path && netconfig->v6_configured &&
+				!netconfig_address_cmp_prefix_len(
+							netconfig->v6_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"Netmask");
+
+		if (netconfig->dbus_path && netconfig->v6_configured &&
+				netconfig_address_cmp_address(
+							netconfig->v6_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"Address");
+
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D address;
+
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
+
+		if (!netconfig->v6_configured)
+			netconfig_connected_v6(netconfig);
+
 		break;
+	}
 	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
 		l_debug("Lease for interface %u expired", netconfig->ifindex);
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D NULL;
+		l_free(l_steal_ptr(netconfig->v6_gateway_str));
+
+		if (netconfig->v6_configured)
+			netconfig_disconnected_v6(netconfig);
 =

 		/* Fall through */
 	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
@@ -993,6 +1316,9 @@ static void netconfig_remove_v4_address(struct netconf=
ig *netconfig)
 					netconfig, NULL));
 	l_rtnl_address_free(netconfig->v4_address);
 	netconfig->v4_address =3D NULL;
+
+	if (netconfig->v4_configured)
+		netconfig_disconnected_v4(netconfig);
 }
 =

 static void netconfig_reset_v4(struct netconfig *netconfig)
@@ -1000,14 +1326,19 @@ static void netconfig_reset_v4(struct netconfig *ne=
tconfig)
 	if (netconfig->rtm_protocol) {
 		netconfig_remove_v4_address(netconfig);
 =

-		l_strfreev(netconfig->dns4_overrides);
-		netconfig->dns4_overrides =3D NULL;
+		l_strv_free(l_steal_ptr(netconfig->dns4_overrides));
+		l_strv_free(l_steal_ptr(netconfig->dns4_list));
 =

 		l_dhcp_client_stop(netconfig->dhcp_client);
 		netconfig->rtm_protocol =3D 0;
 =

 		l_acd_destroy(netconfig->acd);
 		netconfig->acd =3D NULL;
+
+		l_free(netconfig->v4_gateway_str);
+		netconfig->v4_gateway_str =3D NULL;
+
+		l_free(l_steal_ptr(netconfig->v4_domain));
 	}
 }
 =

@@ -1117,7 +1448,6 @@ static bool netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 static bool netconfig_ipv6_select_and_install(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-	struct l_rtnl_address *address =3D NULL;
 =

 	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_UNSPEC) {
 		l_debug("IPV6 configuration disabled");
@@ -1126,10 +1456,7 @@ static bool netconfig_ipv6_select_and_install(struct=
 netconfig *netconfig)
 =

 	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "0");
 =

-	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC)
-		address =3D netconfig_get_static6_address(
-						netconfig->active_settings);
-	else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
+	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
 			netconfig->fils_override &&
 			!l_memeqzero(netconfig->fils_override->ipv6_addr, 16)) {
 		uint8_t prefix_len =3D netconfig->fils_override->ipv6_prefix_len;
@@ -1139,11 +1466,12 @@ static bool netconfig_ipv6_select_and_install(struc=
t netconfig *netconfig)
 		if (unlikely(!addr_str))
 			return false;
 =

-		if (L_WARN_ON(unlikely(!(address =3D l_rtnl_address_new(addr_str,
-								prefix_len)))))
+		netconfig->v6_address =3D l_rtnl_address_new(addr_str,
+								prefix_len);
+		if (L_WARN_ON(unlikely(!netconfig->v6_address)))
 			return false;
 =

-		l_rtnl_address_set_noprefixroute(address, true);
+		l_rtnl_address_set_noprefixroute(netconfig->v6_address, true);
 =

 		/*
 		 * TODO: If netconfig->fils_override->ipv6_lifetime is set,
@@ -1153,12 +1481,12 @@ static bool netconfig_ipv6_select_and_install(struc=
t netconfig *netconfig)
 		 */
 	}
 =

-	if (address) {
+	if (netconfig->v6_address) {
 		L_WARN_ON(!(netconfig->addr6_add_cmd_id =3D
-			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex, address,
+			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
+					netconfig->v6_address,
 					netconfig_ipv6_ifaddr_add_cmd_cb,
 					netconfig, NULL)));
-		l_rtnl_address_free(address);
 		return true;
 	}
 =

@@ -1273,7 +1601,6 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 =

 	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
 		v6_address =3D netconfig_get_static6_address(active_settings);
-		l_rtnl_address_free(v6_address);
 =

 		if (unlikely(!v6_address)) {
 			l_error("netconfig: Can't parse IPv6 address");
@@ -1291,11 +1618,14 @@ bool netconfig_load_settings(struct netconfig *netc=
onfig,
 =

 	if (!v6_enabled)
 		netconfig->rtm_v6_protocol =3D RTPROT_UNSPEC;
-	else if (v6_address)
+	else if (v6_address) {
+		netconfig->v6_address =3D l_steal_ptr(v6_address);
 		netconfig->rtm_v6_protocol =3D RTPROT_STATIC;
-	else
+	} else
 		netconfig->rtm_v6_protocol =3D RTPROT_DHCP;
 =

+	l_rtnl_address_free(v6_address);
+
 	if (send_hostname)
 		l_dhcp_client_set_hostname(netconfig->dhcp_client, hostname);
 =

@@ -1355,11 +1685,22 @@ bool netconfig_reset(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
 =

+	if (netconfig->v4_configured)
+		netconfig_disconnected_v4(netconfig);
+
+	if (netconfig->v6_configured)
+		netconfig_disconnected_v6(netconfig);
+
 	if (netconfig->route4_add_gateway_cmd_id) {
 		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
 		netconfig->route4_add_gateway_cmd_id =3D 0;
 	}
 =

+	if (netconfig->route6_add_cmd_id) {
+		l_netlink_cancel(rtnl, netconfig->route6_add_cmd_id);
+		netconfig->route6_add_cmd_id =3D 0;
+	}
+
 	if (netconfig->addr4_add_cmd_id) {
 		l_netlink_cancel(rtnl, netconfig->addr4_add_cmd_id);
 		netconfig->addr4_add_cmd_id =3D 0;
@@ -1376,14 +1717,22 @@ bool netconfig_reset(struct netconfig *netconfig)
 	netconfig_reset_v4(netconfig);
 =

 	if (netconfig->rtm_v6_protocol) {
-		l_strfreev(netconfig->dns6_overrides);
-		netconfig->dns6_overrides =3D NULL;
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D NULL;
+
+		l_strv_free(l_steal_ptr(netconfig->dns6_overrides));
+		l_strv_free(l_steal_ptr(netconfig->dns6_list));
 =

 		l_dhcp6_client_stop(netconfig->dhcp6_client);
 		netconfig->rtm_v6_protocol =3D 0;
 =

 		sysfs_write_ipv6_setting(netdev_get_name(netdev),
 						"disable_ipv6", "1");
+
+		l_free(netconfig->v6_gateway_str);
+		netconfig->v6_gateway_str =3D NULL;
+
+		l_strv_free(l_steal_ptr(netconfig->v6_domains));
 	}
 =

 	l_free(l_steal_ptr(netconfig->fils_override));
@@ -1434,7 +1783,7 @@ void netconfig_handle_fils_ip_resp(struct netconfig *=
netconfig,
 	netconfig->fils_override =3D l_memdup(info, sizeof(*info));
 }
 =

-struct netconfig *netconfig_new(uint32_t ifindex)
+struct netconfig *netconfig_new(uint32_t ifindex, const char *dbus_path)
 {
 	struct netdev *netdev =3D netdev_find(ifindex);
 	struct netconfig *netconfig;
@@ -1451,6 +1800,7 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 =

 	netconfig =3D l_new(struct netconfig, 1);
 	netconfig->ifindex =3D ifindex;
+	netconfig->dbus_path =3D l_strdup(dbus_path);
 	netconfig->resolve =3D resolve_new(ifindex);
 =

 	netconfig->dhcp_client =3D l_dhcp_client_new(ifindex);
@@ -1483,6 +1833,19 @@ struct netconfig *netconfig_new(uint32_t ifindex)
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
+	netconfig->v4_data.is_ipv4 =3D true;
+	netconfig->v4_data.netconfig =3D netconfig;
+	netconfig->v6_data.is_ipv4 =3D false;
+	netconfig->v6_data.netconfig =3D netconfig;
+
 	return netconfig;
 }
 =

@@ -1500,6 +1863,167 @@ void netconfig_destroy(struct netconfig *netconfig)
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
+	protocol =3D data->is_ipv4 ? data->netconfig->rtm_protocol :
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
+	address =3D data->is_ipv4 ? data->netconfig->v4_address :
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
+	address =3D data->is_ipv4 ?
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
+	const char *gateway_str =3D data->is_ipv4 ?
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
+	char **dns_str_list =3D data->is_ipv4 ?
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
+static bool netconfig_property_get_v6_domains(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct interface_data *data =3D user_data;
+	char **i;
+
+	if (!data->netconfig->v6_domains)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (i =3D data->netconfig->v6_domains; *i; i++)
+		l_dbus_message_builder_append_basic(builder, 's', *i);
+
+	l_dbus_message_builder_leave_array(builder);
+	return true;
+}
+
+static void netconfig_setup_interface(struct l_dbus_interface *interface,
+					bool is_ipv4)
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
+	l_dbus_interface_property(interface, "DomainNames", 0, "as", is_ipv4 ?
+					netconfig_property_get_v4_domains :
+					netconfig_property_get_v6_domains,
+					NULL);
+}
+
+static void netconfig_setup_v4_interface(struct l_dbus_interface *interfac=
e)
+{
+	netconfig_setup_interface(interface, true);
+}
+
+static void netconfig_setup_v6_interface(struct l_dbus_interface *interfac=
e)
+{
+	netconfig_setup_interface(interface, false);
+}
+
 static int netconfig_init(void)
 {
 	uint32_t r;
@@ -1551,6 +2075,14 @@ static int netconfig_init(void)
 =

 	netconfig_list =3D l_queue_new();
 =

+	L_WARN_ON(unlikely(!l_dbus_register_interface(dbus_get_bus(),
+						IWD_IPV4_CONFIG_INTERFACE,
+						netconfig_setup_v4_interface,
+						NULL, false)));
+	L_WARN_ON(unlikely(!l_dbus_register_interface(dbus_get_bus(),
+						IWD_IPV6_CONFIG_INTERFACE,
+						netconfig_setup_v6_interface,
+						NULL, false)));
 	return 0;
 =

 error:
@@ -1567,6 +2099,9 @@ static void netconfig_exit(void)
 	rtnl =3D NULL;
 =

 	l_queue_destroy(netconfig_list, netconfig_free);
+
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_IPV4_CONFIG_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_IPV6_CONFIG_INTERFACE);
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
index 3328271b..b68e4f7c 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1320,7 +1320,9 @@ static void p2p_start_client_netconfig(struct p2p_dev=
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
index 6de5fd4a..105d0ad8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3577,6 +3577,7 @@ static struct station *station_create(struct netdev *=
netdev)
 	struct station *station;
 	struct l_dbus *dbus =3D dbus_get_bus();
 	bool autoconnect =3D true;
+	const char *path;
 =

 	station =3D l_new(struct station, 1);
 	watchlist_init(&station->state_watches, NULL);
@@ -3594,11 +3595,12 @@ static struct station *station_create(struct netdev=
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

--===============0543592715789301743==--

