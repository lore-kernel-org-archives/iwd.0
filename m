Content-Type: multipart/mixed; boundary="===============0598311586865836255=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] netconfig: Add IP configuration properties on Station and
 P2P
Date: Wed, 08 Sep 2021 23:44:40 +0200
Message-ID: <20210908214440.358243-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210908214440.358243-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0598311586865836255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the IPv{4,6}Configuration D-Bus interfaces on the station and P2P
objects that expose current netconfig values.  Access Point and P2P-GO
are not handled yet, and some of the IP config properties may not
automatically generate PropertiesChanged on DHCP lease renewals but
their values are unlikely to change.
---
 src/dbus.h      |   2 +
 src/netconfig.c | 640 ++++++++++++++++++++++++++++++++++++++++--------
 src/netconfig.h |   2 +-
 src/p2p.c       |   4 +-
 src/station.c   |   8 +-
 5 files changed, 551 insertions(+), 105 deletions(-)

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
index c748630b..503bb41f 100644
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
@@ -58,14 +59,18 @@ struct netconfig {
 	uint8_t rtm_protocol;
 	uint8_t rtm_v6_protocol;
 	struct l_rtnl_address *v4_address;
+	struct l_rtnl_address *v6_address;
 	char **dns4_overrides;
 	char **dns6_overrides;
 	struct ie_fils_ip_addr_response_info *fils_override;
+	char *v4_gateway_str;
+	char *v6_gateway_str;
 =

 	const struct l_settings *active_settings;
 =

 	netconfig_notify_func_t notify;
 	void *user_data;
+	bool connected;
 =

 	struct resolve *resolve;
 =

@@ -74,6 +79,12 @@ struct netconfig {
 	uint32_t addr4_add_cmd_id;
 	uint32_t addr6_add_cmd_id;
 	uint32_t route4_add_gateway_cmd_id;
+
+	char *dbus_path;
+	struct interface_data {
+		bool is_ipv4;
+		struct netconfig *netconfig;
+	} ipv4_data, ipv6_data;
 };
 =

 static struct l_netlink *rtnl;
@@ -132,6 +143,7 @@ static void netconfig_free(void *data)
 	l_dhcp_client_destroy(netconfig->dhcp_client);
 	l_dhcp6_client_destroy(netconfig->dhcp6_client);
 =

+	l_free(netconfig->dbus_path);
 	l_free(netconfig);
 }
 =

@@ -152,20 +164,6 @@ static struct netconfig *netconfig_find(uint32_t ifind=
ex)
 	return NULL;
 }
 =

-#define APPEND_STRDUPV(dest, index, src)			\
-	do {							\
-		char **p;					\
-		for (p =3D src; p && *p; p++)			\
-			dest[index++] =3D l_strdup(*p);		\
-	} while (0)						\
-
-#define APPENDV(dest, index, src)				\
-	do {							\
-		char **p;					\
-		for (p =3D src; p && *p; p++)			\
-			dest[index++] =3D *p;			\
-	} while (0)						\
-
 static inline char *netconfig_ipv4_to_string(uint32_t addr)
 {
 	struct in_addr in_addr =3D { .s_addr =3D addr };
@@ -196,77 +194,108 @@ static inline char *netconfig_ipv6_to_string(const u=
int8_t *addr)
 	return addr_str;
 }
 =

-static void netconfig_set_neighbor_entry_cb(int error,
-						uint16_t type, const void *data,
-						uint32_t len, void *user_data)
-{
-	if (error)
-		l_error("l_rtnl_neighbor_set_hwaddr failed: %s (%i)",
-			strerror(-error), error);
-}
-
-static int netconfig_set_dns(struct netconfig *netconfig)
+static char **netconfig_get_dns_list(struct netconfig *netconfig, int af,
+					const uint8_t **out_dns_mac)
 {
-	char **dns6_list =3D NULL;
-	char **dns4_list =3D NULL;
-	unsigned int n_entries =3D 0;
-	char **dns_list;
-	const uint8_t *fils_dns4_mac =3D NULL;
-	const uint8_t *fils_dns6_mac =3D NULL;
 	const struct ie_fils_ip_addr_response_info *fils =3D
 		netconfig->fils_override;
 =

-	if (!netconfig->dns4_overrides &&
-			netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
+	if (af =3D=3D AF_INET) {
 		const struct l_dhcp_lease *lease;
 =

+		if (netconfig->dns4_overrides)
+			return l_strv_copy(netconfig->dns4_overrides);
+
+		if (netconfig->rtm_protocol !=3D RTPROT_DHCP)
+			return NULL;
+
 		if (fils && fils->ipv4_dns) {
-			dns4_list =3D l_new(char *, 2);
-			dns4_list[0] =3D netconfig_ipv4_to_string(fils->ipv4_dns);
+			char **dns_list =3D l_new(char *, 2);
 =

 			if (!l_memeqzero(fils->ipv4_dns_mac, 6) &&
+					out_dns_mac &&
 					util_ip_subnet_match(
 							fils->ipv4_prefix_len,
 							&fils->ipv4_addr,
 							&fils->ipv4_dns))
-				fils_dns4_mac =3D fils->ipv4_dns_mac;
-		} else if ((lease =3D l_dhcp_client_get_lease(
-						netconfig->dhcp_client)))
-			dns4_list =3D l_dhcp_lease_get_dns(lease);
-	}
+				*out_dns_mac =3D fils->ipv4_dns_mac;
+
+			dns_list[0] =3D netconfig_ipv4_to_string(fils->ipv4_dns);
+			return dns_list;
+		}
 =

-	if (!netconfig->dns6_overrides &&
-			netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
+		if (!(lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client)))
+			return NULL;
+
+		return l_dhcp_lease_get_dns(lease);
+	} else {
 		const struct l_dhcp6_lease *lease;
 =

-		if (fils && !l_memeqzero(fils->ipv6_dns,
-						16)) {
-			dns6_list =3D l_new(char *, 2);
-			dns6_list[0] =3D netconfig_ipv6_to_string(fils->ipv6_dns);
+		if (netconfig->dns6_overrides)
+			return l_strv_copy(netconfig->dns6_overrides);
+
+		if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
+			return NULL;
+
+		if (fils && !l_memeqzero(fils->ipv6_dns, 16)) {
+			char **dns_list =3D l_new(char *, 2);
 =

 			if (!l_memeqzero(fils->ipv6_dns_mac, 6) &&
+					out_dns_mac &&
 					util_ip_subnet_match(
 							fils->ipv6_prefix_len,
 							fils->ipv6_addr,
 							fils->ipv6_dns))
-				fils_dns6_mac =3D fils->ipv6_dns_mac;
-		} else if ((lease =3D l_dhcp6_client_get_lease(
+				*out_dns_mac =3D fils->ipv6_dns_mac;
+
+			dns_list[0] =3D netconfig_ipv6_to_string(fils->ipv6_dns);
+			return dns_list;
+		}
+
+		if (!(lease =3D l_dhcp6_client_get_lease(
 						netconfig->dhcp6_client)))
-			dns6_list =3D l_dhcp6_lease_get_dns(lease);
+			return NULL;
+
+		return l_dhcp6_lease_get_dns(lease);
 	}
+}
+
+static void netconfig_set_neighbor_entry_cb(int error,
+						uint16_t type, const void *data,
+						uint32_t len, void *user_data)
+{
+	if (error)
+		l_error("l_rtnl_neighbor_set_hwaddr failed: %s (%i)",
+			strerror(-error), error);
+}
+
+static int netconfig_set_dns(struct netconfig *netconfig)
+{
+	const uint8_t *fils_dns4_mac =3D NULL;
+	const uint8_t *fils_dns6_mac =3D NULL;
+	char **dns4_list =3D netconfig_get_dns_list(netconfig, AF_INET,
+							&fils_dns4_mac);
+	char **dns6_list =3D netconfig_get_dns_list(netconfig, AF_INET6,
+							&fils_dns6_mac);
+	unsigned int n_entries4 =3D l_strv_length(dns4_list);
+	unsigned int n_entries6 =3D l_strv_length(dns6_list);
+	char **dns_list;
+	const struct ie_fils_ip_addr_response_info *fils =3D
+		netconfig->fils_override;
 =

-	n_entries +=3D l_strv_length(netconfig->dns4_overrides);
-	n_entries +=3D l_strv_length(netconfig->dns6_overrides);
-	n_entries +=3D l_strv_length(dns4_list);
-	n_entries +=3D l_strv_length(dns6_list);
+	if (!dns4_list && !dns6_list)
+		return 0;
 =

-	dns_list =3D l_new(char *, n_entries + 1);
-	n_entries =3D 0;
+	dns_list =3D l_realloc(dns4_list,
+				sizeof(char *) * (n_entries4 + n_entries6 + 1));
+
+	if (dns6_list) {
+		memcpy(dns_list + n_entries4, dns6_list,
+			sizeof(char *) * (n_entries6 + 1));
+		/* Contents now belong to dns_list, so no l_strfreev */
+		l_free(dns6_list);
+	}
 =

-	APPEND_STRDUPV(dns_list, n_entries, netconfig->dns4_overrides);
-	APPENDV(dns_list, n_entries, dns4_list);
-	APPEND_STRDUPV(dns_list, n_entries, netconfig->dns6_overrides);
-	APPENDV(dns_list, n_entries, dns6_list);
 	resolve_set_dns(netconfig->resolve, dns_list);
 =

 	if (fils_dns4_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
@@ -284,9 +313,6 @@ static int netconfig_set_dns(struct netconfig *netconfi=
g)
 		l_debug("l_rtnl_neighbor_set_hwaddr failed");
 =

 	l_strv_free(dns_list);
-	/* Contents belonged to dns_list, so not l_strfreev */
-	l_free(dns4_list);
-	l_free(dns6_list);
 	return 0;
 }
 =

@@ -402,6 +428,8 @@ static char *netconfig_ipv4_get_gateway(struct netconfi=
g *netconfig,
 {
 	const struct l_dhcp_lease *lease;
 	char *gateway;
+	const struct ie_fils_ip_addr_response_info *fils =3D
+		netconfig->fils_override;
 =

 	switch (netconfig->rtm_protocol) {
 	case RTPROT_STATIC:
@@ -415,15 +443,12 @@ static char *netconfig_ipv4_get_gateway(struct netcon=
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
@@ -477,10 +502,12 @@ no_prefix_len:
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
@@ -492,7 +519,7 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 					netconfig->fils_override->ipv6_gateway);
 =

 		if (!l_memeqzero(netconfig->fils_override->ipv6_gateway_mac, 6))
-			*out_mac =3D netconfig->fils_override->ipv6_gateway_mac;
+			mac =3D netconfig->fils_override->ipv6_gateway_mac;
 	} else if (!gateway)
 		return NULL;
 =

@@ -506,6 +533,8 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 =

 	l_rtnl_route_set_priority(ret, ROUTE_PRIORITY_OFFSET);
 	l_rtnl_route_set_protocol(ret, RTPROT_STATIC);
+	*out_str =3D l_steal_ptr(gateway);
+	*out_mac =3D mac;
 =

 	return ret;
 }
@@ -703,6 +732,43 @@ static void netconfig_route_generic_cb(int error, uint=
16_t type,
 	}
 }
 =

+static void netconfig_connected(struct netconfig *netconfig)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	netconfig->connected =3D true;
+
+	if (netconfig->notify) {
+		netconfig->notify(NETCONFIG_EVENT_CONNECTED,
+					netconfig->user_data);
+		netconfig->notify =3D NULL;
+	}
+
+	if (netconfig->dbus_path &&
+			unlikely(!l_dbus_object_add_interface(dbus,
+						netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						&netconfig->ipv4_data)))
+		l_info("Unable to add %s at %s",
+			IWD_IPV4_CONFIG_INTERFACE, netconfig->dbus_path);
+
+	if (netconfig->dbus_path &&
+			unlikely(!l_dbus_object_add_interface(dbus,
+						netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						&netconfig->ipv6_data)))
+		l_info("Unable to add %s at %s",
+			IWD_IPV6_CONFIG_INTERFACE, netconfig->dbus_path);
+
+	if (netconfig->dbus_path &&
+			!l_dbus_object_add_interface(dbus, netconfig->dbus_path,
+						L_DBUS_INTERFACE_PROPERTIES,
+						netconfig))
+		/* Properties may already exist on the object, not an error */
+		l_debug("Unable to add %s at %s",
+			L_DBUS_INTERFACE_PROPERTIES, netconfig->dbus_path);
+}
+
 static void netconfig_route_add_cmd_cb(int error, uint16_t type,
 						const void *data, uint32_t len,
 						void *user_data)
@@ -717,11 +783,7 @@ static void netconfig_route_add_cmd_cb(int error, uint=
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
@@ -760,12 +822,7 @@ static bool netconfig_ipv4_routes_install(struct netco=
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

@@ -832,7 +889,7 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 {
 	struct netconfig *netconfig =3D user_data;
 	struct l_rtnl_route *gateway;
-	const uint8_t *gateway_mac =3D NULL;
+	const uint8_t *gateway_mac;
 =

 	netconfig->addr6_add_cmd_id =3D 0;
 =

@@ -842,7 +899,9 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 		return;
 	}
 =

-	gateway =3D netconfig_get_static6_gateway(netconfig, &gateway_mac);
+	gateway =3D netconfig_get_static6_gateway(netconfig,
+						&netconfig->v6_gateway_str,
+						&gateway_mac);
 	if (gateway) {
 		L_WARN_ON(!l_rtnl_route_add(rtnl, netconfig->ifindex,
 						gateway,
@@ -883,11 +942,44 @@ static void netconfig_ifaddr_del_cmd_cb(int error, ui=
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

@@ -897,10 +989,47 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
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
+			if (netconfig->dbus_path && netconfig->connected)
+				l_dbus_property_changed(dbus,
+						netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"Gateway");
+		}
+
+		address =3D netconfig_get_dhcp4_address(netconfig);
+
+		if (netconfig->dbus_path && netconfig->connected &&
+				!netconfig_address_cmp_prefix_len(
+							netconfig->v4_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"Netmask");
+
+		if (netconfig->dbus_path && netconfig->connected &&
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
@@ -913,6 +1042,7 @@ static void netconfig_ipv4_dhcp_event_handler(struct l=
_dhcp_client *client,
 					netconfig_ipv4_ifaddr_add_cmd_cb,
 					netconfig, NULL)));
 		break;
+	}
 	case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
 		break;
 	case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
@@ -923,6 +1053,25 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
l_dhcp_client *client,
 		l_rtnl_address_free(netconfig->v4_address);
 		netconfig->v4_address =3D NULL;
 =

+		if (netconfig->dbus_path && netconfig->connected) {
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"Address");
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"Netmask");
+		}
+
+		if (netconfig->v4_gateway_str) {
+			if (netconfig->dbus_path && netconfig->connected)
+				l_dbus_property_changed(dbus,
+						netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE,
+						"Gateway");
+
+			l_free(l_steal_ptr(netconfig->v4_gateway_str));
+		}
+
 		/* Fall through. */
 	case L_DHCP_CLIENT_EVENT_NO_LEASE:
 		/*
@@ -945,18 +1094,87 @@ static void netconfig_dhcp6_event_handler(struct l_d=
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
+			if (netconfig->dbus_path && netconfig->connected)
+				l_dbus_property_changed(dbus,
+						netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"Gateway");
+		}
+
+		address =3D l_rtnl_address_new(addr_str,
+					l_dhcp6_lease_get_prefix_length(lease));
+
+		if (netconfig->dbus_path && netconfig->connected &&
+				!netconfig_address_cmp_prefix_len(
+							netconfig->v6_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"Netmask");
+
+		if (netconfig->dbus_path && netconfig->connected &&
+				netconfig_address_cmp_address(
+							netconfig->v6_address,
+							address))
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
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
+		if (netconfig->dbus_path && netconfig->connected) {
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"Address");
+			l_dbus_property_changed(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"Netmask");
+		}
+
+		if (netconfig->v6_gateway_str) {
+			if (netconfig->dbus_path && netconfig->connected)
+				l_dbus_property_changed(dbus,
+						netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						"Gateway");
+
+			l_free(l_steal_ptr(netconfig->v6_gateway_str));
+		}
 =

 		/* Fall through */
 	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
@@ -969,6 +1187,8 @@ static void netconfig_dhcp6_event_handler(struct l_dhc=
p6_client *client,
 =

 static void netconfig_remove_v4_address(struct netconfig *netconfig)
 {
+	struct l_dbus *dbus =3D dbus_get_bus();
+
 	if (!netconfig->v4_address)
 		return;
 =

@@ -978,6 +1198,15 @@ static void netconfig_remove_v4_address(struct netcon=
fig *netconfig)
 					netconfig, NULL));
 	l_rtnl_address_free(netconfig->v4_address);
 	netconfig->v4_address =3D NULL;
+
+	if (netconfig->dbus_path && netconfig->connected) {
+		l_dbus_property_changed(dbus, netconfig->dbus_path,
+					IWD_IPV4_CONFIG_INTERFACE,
+					"Address");
+		l_dbus_property_changed(dbus, netconfig->dbus_path,
+					IWD_IPV4_CONFIG_INTERFACE,
+					"Netmask");
+	}
 }
 =

 static void netconfig_reset_v4(struct netconfig *netconfig)
@@ -993,6 +1222,9 @@ static void netconfig_reset_v4(struct netconfig *netco=
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

@@ -1102,7 +1334,6 @@ static bool netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 static bool netconfig_ipv6_select_and_install(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-	struct l_rtnl_address *address =3D NULL;
 =

 	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_UNSPEC) {
 		l_debug("IPV6 configuration disabled");
@@ -1111,10 +1342,7 @@ static bool netconfig_ipv6_select_and_install(struct=
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
@@ -1124,11 +1352,12 @@ static bool netconfig_ipv6_select_and_install(struc=
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
@@ -1138,12 +1367,12 @@ static bool netconfig_ipv6_select_and_install(struc=
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

@@ -1258,7 +1487,6 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 =

 	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
 		v6_address =3D netconfig_get_static6_address(active_settings);
-		l_rtnl_address_free(v6_address);
 =

 		if (unlikely(!v6_address)) {
 			l_error("netconfig: Can't parse IPv6 address");
@@ -1276,11 +1504,14 @@ bool netconfig_load_settings(struct netconfig *netc=
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

@@ -1339,6 +1570,16 @@ bool netconfig_reconfigure(struct netconfig *netconf=
ig)
 bool netconfig_reset(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	if (netconfig->dbus_path && netconfig->connected) {
+		l_dbus_object_remove_interface(dbus, netconfig->dbus_path,
+						IWD_IPV4_CONFIG_INTERFACE);
+		l_dbus_object_remove_interface(dbus, netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE);
+	}
+
+	netconfig->connected =3D false;
 =

 	if (netconfig->route4_add_gateway_cmd_id) {
 		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
@@ -1361,6 +1602,9 @@ bool netconfig_reset(struct netconfig *netconfig)
 	netconfig_reset_v4(netconfig);
 =

 	if (netconfig->rtm_v6_protocol) {
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D NULL;
+
 		l_strfreev(netconfig->dns6_overrides);
 		netconfig->dns6_overrides =3D NULL;
 =

@@ -1369,6 +1613,9 @@ bool netconfig_reset(struct netconfig *netconfig)
 =

 		sysfs_write_ipv6_setting(netdev_get_name(netdev),
 						"disable_ipv6", "1");
+
+		l_free(netconfig->v6_gateway_str);
+		netconfig->v6_gateway_str =3D NULL;
 	}
 =

 	l_free(l_steal_ptr(netconfig->fils_override));
@@ -1419,7 +1666,7 @@ void netconfig_handle_fils_ip_resp(struct netconfig *=
netconfig,
 	netconfig->fils_override =3D l_memdup(info, sizeof(*info));
 }
 =

-struct netconfig *netconfig_new(uint32_t ifindex)
+struct netconfig *netconfig_new(uint32_t ifindex, const char *dbus_path)
 {
 	struct netdev *netdev =3D netdev_find(ifindex);
 	struct netconfig *netconfig;
@@ -1436,6 +1683,7 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 =

 	netconfig =3D l_new(struct netconfig, 1);
 	netconfig->ifindex =3D ifindex;
+	netconfig->dbus_path =3D l_strdup(dbus_path);
 	netconfig->resolve =3D resolve_new(ifindex);
 =

 	netconfig->dhcp_client =3D l_dhcp_client_new(ifindex);
@@ -1468,6 +1716,19 @@ struct netconfig *netconfig_new(uint32_t ifindex)
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
+	netconfig->ipv4_data.is_ipv4 =3D true;
+	netconfig->ipv4_data.netconfig =3D netconfig;
+	netconfig->ipv6_data.is_ipv4 =3D false;
+	netconfig->ipv6_data.netconfig =3D netconfig;
+
 	return netconfig;
 }
 =

@@ -1485,6 +1746,174 @@ void netconfig_destroy(struct netconfig *netconfig)
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
+	protocol =3D data->is_ipv4 ?  data->netconfig->rtm_protocol :
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
+	char **dns_str_list =3D netconfig_get_dns_list(data->netconfig,
+					data->is_ipv4 ? AF_INET : AF_INET6,
+					NULL);
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
+	const struct interface_data *data =3D user_data;
+
+	if (data->is_ipv4) {
+		L_AUTO_FREE_VAR(char *, domain) =3D
+			l_settings_get_string(data->netconfig->active_settings,
+						"IPv4", "DomainName");
+
+		if (!domain) {
+			const struct l_dhcp_lease *lease;
+
+			if (data->netconfig->rtm_protocol !=3D RTPROT_DHCP)
+				return false;
+
+			lease =3D l_dhcp_client_get_lease(
+						data->netconfig->dhcp_client);
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
+		if (data->netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
+			return false;
+
+		lease =3D l_dhcp6_client_get_lease(data->netconfig->dhcp6_client);
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
@@ -1536,6 +1965,14 @@ static int netconfig_init(void)
 =

 	netconfig_list =3D l_queue_new();
 =

+	L_WARN_ON(unlikely(!l_dbus_register_interface(dbus_get_bus(),
+						IWD_IPV4_CONFIG_INTERFACE,
+						netconfig_setup_interface,
+						NULL, false)));
+	L_WARN_ON(unlikely(!l_dbus_register_interface(dbus_get_bus(),
+						IWD_IPV6_CONFIG_INTERFACE,
+						netconfig_setup_interface,
+						NULL, false)));
 	return 0;
 =

 error:
@@ -1552,6 +1989,9 @@ static void netconfig_exit(void)
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
index ac741f5a..a6b5922f 100644
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

--===============0598311586865836255==--

