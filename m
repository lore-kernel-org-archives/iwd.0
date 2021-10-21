Content-Type: multipart/mixed; boundary="===============2141274765755440146=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 07/12] netconfig: Refactor setting new values to system
Date: Thu, 21 Oct 2021 10:50:36 +0200
Message-ID: <20211021085041.294524-7-andrew.zaborowski@intel.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============2141274765755440146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Refactor and unify how the netconfig values, that we obtain from DHCP or
the settings or otherwise, are written/committed to the system netdevs.
We basically concentrate all of those actions in a new function
netconfig_set() that is called whenever any value changes.  The only
exceptions are the sysfs writes and some of the ARP table writes.

This will allow us to more easily delegate committing the values to an
(optional) D-Bus agent, or expose them as D-Bus properties if we ever
choose to do that in the future.  For that I'm also passing a bitmask
telling netconfig_set() which values may have actually changed, so we
don't bother looking at those that definitely haven't changed.
---
This is a relatively big change to review but the v4 and v6 portions
are similar.
---
 src/netconfig.c | 541 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 398 insertions(+), 143 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 7b4b7f8a..a73afe24 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -51,6 +51,15 @@
 #include "src/ie.h"
 #include "src/netconfig.h"
 =

+enum netconfig_changed_flags {
+	NETCONFIG_CHANGED_ADDRESS	=3D 1 << 0,
+	NETCONFIG_CHANGED_NETMASK	=3D 1 << 1,
+	NETCONFIG_CHANGED_GATEWAY	=3D 1 << 2,
+	NETCONFIG_CHANGED_DNS		=3D 1 << 3,
+	NETCONFIG_CHANGED_DOMAINS	=3D 1 << 4,
+	NETCONFIG_CHANGED_ALL		=3D 0x1f,
+};
+
 struct netconfig {
 	uint32_t ifindex;
 	struct l_dhcp_client *dhcp_client;
@@ -58,7 +67,9 @@ struct netconfig {
 	uint8_t rtm_protocol;
 	uint8_t rtm_v6_protocol;
 	struct l_rtnl_address *v4_address;
+	struct l_rtnl_address *stale_v4_address;
 	struct l_rtnl_address *v6_address;
+	struct l_rtnl_address *stale_v6_address;
 	char **dns4_overrides;
 	char **dns6_overrides;
 	char **dns4_list;
@@ -69,6 +80,8 @@ struct netconfig {
 	char *v6_gateway_str;
 	char *v4_domain;
 	char **v6_domains;
+	unsigned int pending_v4_set;
+	unsigned int pending_v6_set;
 =

 	const struct l_settings *active_settings;
 =

@@ -844,10 +857,8 @@ static void netconfig_route6_add_cb(int error, uint16_=
t type,
 	}
 }
 =

-static bool netconfig_ipv4_routes_install(struct netconfig *netconfig)
+static bool netconfig_ipv4_subnet_route_install(struct netconfig *netconfi=
g)
 {
-	L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
-	const uint8_t *gateway_mac =3D NULL;
 	struct in_addr in_addr;
 	char ip[INET_ADDRSTRLEN];
 	char network[INET_ADDRSTRLEN];
@@ -870,10 +881,19 @@ static bool netconfig_ipv4_routes_install(struct netc=
onfig *netconfig)
 						netconfig_route_generic_cb,
 						netconfig, NULL)) {
 		l_error("netconfig: Failed to add subnet route.");
-
 		return false;
 	}
 =

+	return true;
+}
+
+static bool netconfig_ipv4_gateway_route_install(struct netconfig *netconf=
ig)
+{
+	L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
+	const uint8_t *gateway_mac =3D NULL;
+	struct in_addr in_addr;
+	char ip[INET_ADDRSTRLEN];
+
 	gateway =3D netconfig_ipv4_get_gateway(netconfig, &gateway_mac);
 	if (!gateway) {
 		l_debug("No gateway obtained from %s.",
@@ -889,6 +909,10 @@ static bool netconfig_ipv4_routes_install(struct netco=
nfig *netconfig)
 		return true;
 	}
 =

+	if (!l_rtnl_address_get_address(netconfig->v4_address, ip) ||
+			inet_pton(AF_INET, ip, &in_addr) < 1)
+		return false;
+
 	netconfig->route4_add_gateway_cmd_id =3D
 		l_rtnl_route4_add_gateway(rtnl, netconfig->ifindex, gateway, ip,
 						ROUTE_PRIORITY_OFFSET,
@@ -902,50 +926,77 @@ static bool netconfig_ipv4_routes_install(struct netc=
onfig *netconfig)
 		return false;
 	}
 =

-	if (gateway_mac) {
-		/*
-		 * Attempt to use the gateway MAC address received from the AP
-		 * by writing the mapping directly into the netdev's ARP table
-		 * so as to save one data frame roundtrip before first IP
-		 * connections are established.  This is very low-priority but
-		 * print error messages just because they may indicate bigger
-		 * problems.
-		 */
-		if (!l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex,
+	/*
+	 * Attempt to use the gateway MAC address received from the AP by
+	 * writing the mapping directly into the netdev's ARP table so as
+	 * to save one data frame roundtrip before first IP connections
+	 * are established.  This is very low-priority but print error
+	 * messages just because they may indicate bigger problems.
+	 */
+	if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex,
 					AF_INET,
 					&netconfig->fils_override->ipv4_gateway,
 					gateway_mac, 6,
 					netconfig_set_neighbor_entry_cb, NULL,
 					NULL))
-			l_debug("l_rtnl_neighbor_set_hwaddr failed");
+		l_debug("l_rtnl_neighbor_set_hwaddr failed");
+
+	return true;
+}
+
+static bool netconfig_ipv6_static_gateway_route_install(
+						struct netconfig *netconfig)
+{
+	_auto_(l_rtnl_route_free) struct l_rtnl_route *gateway =3D NULL;
+	const uint8_t *gateway_mac;
+
+	gateway =3D netconfig_get_static6_gateway(netconfig,
+						&netconfig->v6_gateway_str,
+						&gateway_mac);
+	if (!gateway) {
+		l_debug("No IPv6 gateway set");
+		return true;
 	}
 =

+	netconfig->route6_add_cmd_id =3D l_rtnl_route_add(rtnl,
+							netconfig->ifindex,
+							gateway,
+							netconfig_route6_add_cb,
+							netconfig, NULL);
+	if (!L_WARN_ON(unlikely(!netconfig->route6_add_cmd_id)))
+		return false;
+
+	if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex,
+					AF_INET6,
+					netconfig->fils_override->ipv6_gateway,
+					gateway_mac, 6,
+					netconfig_set_neighbor_entry_cb, NULL,
+					NULL))
+		l_debug("l_rtnl_neighbor_set_hwaddr failed");
+
 	return true;
 }
 =

+static void netconfig_set(struct netconfig *netconfig, uint8_t af,
+				unsigned int changed);
+
 static void netconfig_ipv4_ifaddr_add_cmd_cb(int error, uint16_t type,
 						const void *data, uint32_t len,
 						void *user_data)
 {
 	struct netconfig *netconfig =3D user_data;
+	unsigned int changed =3D netconfig->pending_v4_set;
 =

 	netconfig->addr4_add_cmd_id =3D 0;
 =

-	if (error && error !=3D -EEXIST) {
+	if (error && error !=3D -EEXIST)
 		l_error("netconfig: Failed to add IP address. "
 				"Error %d: %s", error, strerror(-error));
-		return;
-	}
-
-	netconfig_gateway_to_arp(netconfig);
-
-	if (!netconfig_ipv4_routes_install(netconfig)) {
-		l_error("netconfig: Failed to install IPv4 routes.");
-		return;
-	}
+	else
+		netconfig_ipv4_subnet_route_install(netconfig);
 =

-	netconfig_set_dns(netconfig);
-	netconfig_set_domains(netconfig);
+	netconfig->pending_v4_set =3D 0;
+	netconfig_set(netconfig, AF_INET, changed);
 }
 =

 static void netconfig_ipv6_ifaddr_add_cmd_cb(int error, uint16_t type,
@@ -953,40 +1004,16 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int err=
or, uint16_t type,
 						void *user_data)
 {
 	struct netconfig *netconfig =3D user_data;
-	struct l_rtnl_route *gateway;
-	const uint8_t *gateway_mac;
+	unsigned int changed =3D netconfig->pending_v4_set;
 =

 	netconfig->addr6_add_cmd_id =3D 0;
 =

-	if (error && error !=3D -EEXIST) {
+	if (error && error !=3D -EEXIST)
 		l_error("netconfig: Failed to add IPv6 address. "
 				"Error %d: %s", error, strerror(-error));
-		return;
-	}
-
-	gateway =3D netconfig_get_static6_gateway(netconfig,
-						&netconfig->v6_gateway_str,
-						&gateway_mac);
-	if (gateway) {
-		netconfig->route6_add_cmd_id =3D l_rtnl_route_add(rtnl,
-							netconfig->ifindex,
-							gateway,
-							netconfig_route6_add_cb,
-							netconfig, NULL);
-		L_WARN_ON(unlikely(!netconfig->route6_add_cmd_id));
-		l_rtnl_route_free(gateway);
-
-		if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
-					netconfig->ifindex, AF_INET6,
-					netconfig->fils_override->ipv6_gateway,
-					gateway_mac, 6,
-					netconfig_set_neighbor_entry_cb, NULL,
-					NULL))
-			l_debug("l_rtnl_neighbor_set_hwaddr failed");
-	}
 =

-	netconfig_set_dns(netconfig);
-	netconfig_set_domains(netconfig);
+	netconfig->pending_v6_set =3D 0;
+	netconfig_set(netconfig, AF_INET6, changed);
 }
 =

 static void netconfig_ifaddr_del_cmd_cb(int error, uint16_t type,
@@ -1009,21 +1036,169 @@ static void netconfig_ifaddr_del_cmd_cb(int error,=
 uint16_t type,
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
+static void netconfig_set(struct netconfig *netconfig, uint8_t af,
+				unsigned int changed)
+{
+	struct l_rtnl_address *stale_addr;
+
+	if (af =3D=3D AF_INET)
+		stale_addr =3D l_steal_ptr(netconfig->stale_v4_address);
+	else
+		stale_addr =3D l_steal_ptr(netconfig->stale_v6_address);
+
+	if (stale_addr) {
+		L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
+						stale_addr,
+						netconfig_ifaddr_del_cmd_cb,
+						netconfig, NULL));
+		l_rtnl_address_free(stale_addr);
+	}
+
+	if (af =3D=3D AF_INET) {
+		if (!netconfig->v4_address)
+			return;
+
+		if ((changed & (NETCONFIG_CHANGED_ADDRESS |
+					NETCONFIG_CHANGED_NETMASK)) &&
+				!netconfig->addr4_add_cmd_id) {
+			netconfig->addr4_add_cmd_id =3D l_rtnl_ifaddr_add(rtnl,
+					netconfig->ifindex,
+					netconfig->v4_address,
+					netconfig_ipv4_ifaddr_add_cmd_cb,
+					netconfig, NULL);
+			if (!L_WARN_ON(!netconfig->addr4_add_cmd_id))
+				changed &=3D ~(NETCONFIG_CHANGED_ADDRESS |
+						NETCONFIG_CHANGED_NETMASK);
+		}
+
+		/*
+		 * If we either started the address addition now or one was
+		 * already in progress, wait for that operation's callback
+		 * and we'll be called again to set the rest of the values
+		 * in the changed bitmask.
+		 */
+		if (netconfig->addr4_add_cmd_id) {
+			netconfig->pending_v4_set |=3D changed;
+			return;
+		}
+
+		/*
+		 * For IPv6 the address, the subnet route and the gateway
+		 * route are handled automatically for DHCP, only cover the
+		 * static and FILS-provided cases here.
+		 */
+	} else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ||
+			(netconfig->fils_override &&
+			 !l_memeqzero(netconfig->fils_override->ipv6_addr,
+					16))) {
+		if (!netconfig->v6_address)
+			return;
+
+		if ((changed & (NETCONFIG_CHANGED_ADDRESS |
+					NETCONFIG_CHANGED_NETMASK)) &&
+				!netconfig->addr6_add_cmd_id) {
+			netconfig->addr6_add_cmd_id =3D l_rtnl_ifaddr_add(rtnl,
+					netconfig->ifindex,
+					netconfig->v6_address,
+					netconfig_ipv6_ifaddr_add_cmd_cb,
+					netconfig, NULL);
+			if (!L_WARN_ON(!netconfig->addr6_add_cmd_id))
+				changed &=3D ~(NETCONFIG_CHANGED_ADDRESS |
+						NETCONFIG_CHANGED_NETMASK);
+		}
+
+		/*
+		 * If we either started the address addition now or one was
+		 * already in progress, wait for that operation's callback
+		 * and we'll be called again to set the rest of the values
+		 * in the changed bitmask.
+		 */
+		if (netconfig->addr6_add_cmd_id) {
+			netconfig->pending_v4_set |=3D changed;
+			return;
+		}
+	}
+
+	if (af =3D=3D AF_INET) {
+		if (changed & NETCONFIG_CHANGED_GATEWAY) {
+			netconfig_gateway_to_arp(netconfig);
+
+			if (netconfig_ipv4_gateway_route_install(netconfig))
+				changed &=3D ~NETCONFIG_CHANGED_GATEWAY;
+		} else if (netconfig->notify) {
+			/*
+			 * The gateway route addition callback notifies the user
+			 * of netconfig success if a gateway is provided, otherwise
+			 * notify here.
+			 */
+			netconfig->notify(NETCONFIG_EVENT_CONNECTED,
+						netconfig->user_data);
+			netconfig->notify =3D NULL;
+		}
+	} else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ||
+			(netconfig->fils_override &&
+			 !l_memeqzero(netconfig->fils_override->ipv6_gateway,
+					16))) {
+		if (changed & (NETCONFIG_CHANGED_GATEWAY))
+			if (netconfig_ipv6_static_gateway_route_install(
+								netconfig))
+				changed &=3D ~NETCONFIG_CHANGED_GATEWAY;
+	}
+
+	if (changed & NETCONFIG_CHANGED_DNS) {
+		netconfig_set_dns(netconfig);
+		changed &=3D ~NETCONFIG_CHANGED_DNS;
+	}
+
+	if (changed & NETCONFIG_CHANGED_DOMAINS) {
+		netconfig_set_domains(netconfig);
+		changed &=3D ~NETCONFIG_CHANGED_DOMAINS;
+	}
+}
+
 static void netconfig_ipv4_dhcp_event_handler(struct l_dhcp_client *client,
 						enum l_dhcp_client_event event,
 						void *userdata)
 {
 	struct netconfig *netconfig =3D userdata;
+	unsigned int changed =3D 0;
 =

 	l_debug("DHCPv4 event %d", event);
 =

 	switch (event) {
 	case L_DHCP_CLIENT_EVENT_IP_CHANGED:
-		L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ifaddr_del_cmd_cb,
-					netconfig, NULL));
-		/* Fall through. */
 	case L_DHCP_CLIENT_EVENT_LEASE_OBTAINED:
 	{
 		char *gateway_str;
@@ -1035,9 +1210,19 @@ static void netconfig_ipv4_dhcp_event_handler(struct=
 l_dhcp_client *client,
 		else {
 			l_free(netconfig->v4_gateway_str);
 			netconfig->v4_gateway_str =3D gateway_str;
+			changed |=3D NETCONFIG_CHANGED_GATEWAY;
 		}
 =

 		address =3D netconfig_get_dhcp4_address(netconfig);
+
+		if (!netconfig_address_cmp_prefix_len(netconfig->v4_address,
+							address))
+			changed |=3D NETCONFIG_CHANGED_ADDRESS;
+
+		if (netconfig_address_cmp_address(netconfig->v4_address,
+							address))
+			changed |=3D NETCONFIG_CHANGED_NETMASK;
+
 		l_rtnl_address_free(netconfig->v4_address);
 		netconfig->v4_address =3D address;
 =

@@ -1047,26 +1232,36 @@ static void netconfig_ipv4_dhcp_event_handler(struc=
t l_dhcp_client *client,
 			return;
 		}
 =

-		netconfig_dns_list_update(netconfig, AF_INET);
-		netconfig_domains_update(netconfig, AF_INET);
+		if (netconfig_dns_list_update(netconfig, AF_INET))
+			changed |=3D NETCONFIG_CHANGED_DNS;
 =

-		L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
-				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ipv4_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
+		if (netconfig_domains_update(netconfig, AF_INET))
+			changed |=3D NETCONFIG_CHANGED_DOMAINS;
+
+		netconfig_set(netconfig, AF_INET, changed);
 		break;
 	}
 	case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
 		break;
 	case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
-		L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ifaddr_del_cmd_cb,
-					netconfig, NULL));
-		l_rtnl_address_free(netconfig->v4_address);
-		netconfig->v4_address =3D NULL;
-		l_free(l_steal_ptr(netconfig->v4_gateway_str));
+		l_debug("Lease for interface %u expired", netconfig->ifindex);
+		changed =3D NETCONFIG_CHANGED_ADDRESS | NETCONFIG_CHANGED_NETMASK;
+		l_rtnl_address_free(netconfig->stale_v4_address);
+		netconfig->stale_v4_address =3D
+			l_steal_ptr(netconfig->v4_address);
+
+		if (netconfig->v4_gateway_str) {
+			changed |=3D NETCONFIG_CHANGED_GATEWAY;
+			l_free(l_steal_ptr(netconfig->v4_gateway_str));
+		}
+
+		if (netconfig_dns_list_update(netconfig, AF_INET))
+			changed |=3D NETCONFIG_CHANGED_DNS;
+
+		if (netconfig_domains_update(netconfig, AF_INET))
+			changed |=3D NETCONFIG_CHANGED_DOMAINS;
+
+		netconfig_set(netconfig, AF_INET, changed);
 =

 		/* Fall through. */
 	case L_DHCP_CLIENT_EVENT_NO_LEASE:
@@ -1090,6 +1285,7 @@ static void netconfig_dhcp6_event_handler(struct l_dh=
cp6_client *client,
 						void *userdata)
 {
 	struct netconfig *netconfig =3D userdata;
+	unsigned int changed =3D 0;
 =

 	switch (event) {
 	case L_DHCP6_CLIENT_EVENT_IP_CHANGED:
@@ -1112,28 +1308,52 @@ static void netconfig_dhcp6_event_handler(struct l_=
dhcp6_client *client,
 		else {
 			l_free(netconfig->v6_gateway_str);
 			netconfig->v6_gateway_str =3D gateway_str;
+			changed |=3D NETCONFIG_CHANGED_GATEWAY;
 		}
 =

 		address =3D l_rtnl_address_new(addr_str,
 					l_dhcp6_lease_get_prefix_length(lease));
+
+		if (!netconfig_address_cmp_prefix_len(netconfig->v6_address,
+							address))
+			changed |=3D NETCONFIG_CHANGED_ADDRESS;
+
+		if (netconfig_address_cmp_address(netconfig->v6_address,
+							address))
+			changed |=3D NETCONFIG_CHANGED_NETMASK;
+
 		l_rtnl_address_free(netconfig->v6_address);
 		netconfig->v6_address =3D address;
 =

-		netconfig_dns_list_update(netconfig, AF_INET6);
-		netconfig_domains_update(netconfig, AF_INET6);
-		netconfig_set_dns(netconfig);
-		netconfig_set_domains(netconfig);
+		if (netconfig_dns_list_update(netconfig, AF_INET6))
+			changed |=3D NETCONFIG_CHANGED_DNS;
+
+		if (netconfig_domains_update(netconfig, AF_INET6))
+			changed |=3D NETCONFIG_CHANGED_DOMAINS;
+
+		netconfig_set(netconfig, AF_INET6, changed);
 		break;
 	}
 	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
-		l_debug("Lease for interface %u expired", netconfig->ifindex);
-		netconfig_dns_list_update(netconfig, AF_INET6);
-		netconfig_domains_update(netconfig, AF_INET6);
-		netconfig_set_dns(netconfig);
-		netconfig_set_domains(netconfig);
-		l_rtnl_address_free(netconfig->v6_address);
-		netconfig->v6_address =3D NULL;
-		l_free(l_steal_ptr(netconfig->v6_gateway_str));
+		l_debug("IPv6 lease for interface %u expired",
+			netconfig->ifindex);
+		changed =3D NETCONFIG_CHANGED_ADDRESS | NETCONFIG_CHANGED_NETMASK;
+		l_rtnl_address_free(netconfig->stale_v6_address);
+		netconfig->stale_v6_address =3D
+			l_steal_ptr(netconfig->v6_address);
+
+		if (netconfig->v6_gateway_str) {
+			changed |=3D NETCONFIG_CHANGED_GATEWAY;
+			l_free(l_steal_ptr(netconfig->v6_gateway_str));
+		}
+
+		if (netconfig_dns_list_update(netconfig, AF_INET6))
+			changed |=3D NETCONFIG_CHANGED_DNS;
+
+		if (netconfig_domains_update(netconfig, AF_INET6))
+			changed |=3D NETCONFIG_CHANGED_DOMAINS;
+
+		netconfig_set(netconfig, AF_INET6, changed);
 =

 		/* Fall through */
 	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
@@ -1144,50 +1364,93 @@ static void netconfig_dhcp6_event_handler(struct l_=
dhcp6_client *client,
 	}
 }
 =

-static void netconfig_remove_v4_address(struct netconfig *netconfig)
-{
-	if (!netconfig->v4_address)
-		return;
-
-	L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ifaddr_del_cmd_cb,
-					netconfig, NULL));
-	l_rtnl_address_free(netconfig->v4_address);
-	netconfig->v4_address =3D NULL;
-}
-
 static void netconfig_reset_v4(struct netconfig *netconfig)
 {
 	if (netconfig->rtm_protocol) {
-		netconfig_remove_v4_address(netconfig);
+		unsigned int changed =3D 0;
+
+		if (netconfig->v4_address)
+			changed |=3D NETCONFIG_CHANGED_ADDRESS |
+				NETCONFIG_CHANGED_NETMASK;
+
+		l_rtnl_address_free(netconfig->stale_v4_address);
+		netconfig->stale_v4_address =3D l_steal_ptr(netconfig->v4_address);
+
+		if (netconfig->v4_gateway_str)
+			changed |=3D NETCONFIG_CHANGED_GATEWAY;
+
+		l_free(l_steal_ptr(netconfig->v4_gateway_str));
+
+		if (netconfig->dns4_list)
+			changed |=3D NETCONFIG_CHANGED_DNS;
 =

 		l_strv_free(l_steal_ptr(netconfig->dns4_overrides));
 		l_strv_free(l_steal_ptr(netconfig->dns4_list));
 =

+		if (netconfig->v4_domain)
+			changed |=3D NETCONFIG_CHANGED_DOMAINS;
+
+		l_free(l_steal_ptr(netconfig->v4_domain));
+
+		netconfig_set(netconfig, AF_INET, changed);
+
 		l_dhcp_client_stop(netconfig->dhcp_client);
 		netconfig->rtm_protocol =3D 0;
 =

 		l_acd_destroy(netconfig->acd);
 		netconfig->acd =3D NULL;
+	}
+}
 =

-		l_free(l_steal_ptr(netconfig->v4_gateway_str));
+static void netconfig_reset_v6(struct netconfig *netconfig)
+{
+	if (netconfig->rtm_v6_protocol) {
+		unsigned int changed =3D 0;
+		struct netdev *netdev =3D netdev_find(netconfig->ifindex);
 =

-		l_free(l_steal_ptr(netconfig->v4_domain));
+		if (netconfig->v6_address)
+			changed |=3D NETCONFIG_CHANGED_ADDRESS |
+				NETCONFIG_CHANGED_NETMASK;
+
+		l_rtnl_address_free(netconfig->stale_v6_address);
+		netconfig->stale_v6_address =3D l_steal_ptr(netconfig->v6_address);
+
+		if (netconfig->v6_gateway_str)
+			changed |=3D NETCONFIG_CHANGED_GATEWAY;
+
+		l_free(l_steal_ptr(netconfig->v6_gateway_str));
+
+		if (netconfig->dns6_list)
+			changed |=3D NETCONFIG_CHANGED_DNS;
+
+		l_strv_free(l_steal_ptr(netconfig->dns6_overrides));
+		l_strv_free(l_steal_ptr(netconfig->dns6_list));
+
+		if (netconfig->v6_domains)
+			changed |=3D NETCONFIG_CHANGED_DOMAINS;
+
+		l_free(l_steal_ptr(netconfig->v6_domains));
+
+		netconfig_set(netconfig, AF_INET6, changed);
+
+		l_dhcp6_client_stop(netconfig->dhcp6_client);
+		netconfig->rtm_v6_protocol =3D 0;
+
+		sysfs_write_ipv6_setting(netdev_get_name(netdev),
+						"disable_ipv6", "1");
 	}
 }
 =

 static void netconfig_ipv4_acd_event(enum l_acd_event event, void *user_da=
ta)
 {
 	struct netconfig *netconfig =3D user_data;
+	unsigned int changed;
 =

 	switch (event) {
 	case L_ACD_EVENT_AVAILABLE:
-		L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
-				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ipv4_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
+		changed =3D netconfig->pending_v4_set;
+		netconfig->pending_v4_set =3D 0;
+		netconfig_set(netconfig, AF_INET, changed);
 		return;
 	case L_ACD_EVENT_CONFLICT:
 		/*
@@ -1205,7 +1468,10 @@ static void netconfig_ipv4_acd_event(enum l_acd_even=
t event, void *user_data)
 		 * case.
 		 */
 		l_error("netconfig: statically configured address was lost");
-		netconfig_remove_v4_address(netconfig);
+
+		l_rtnl_address_free(netconfig->stale_v4_address);
+		netconfig->stale_v4_address =3D l_steal_ptr(netconfig->v4_address);
+		netconfig_set(netconfig, AF_INET, NETCONFIG_CHANGED_ALL);
 		break;
 	}
 }
@@ -1243,6 +1509,17 @@ static bool netconfig_ipv4_select_and_install(struct=
 netconfig *netconfig)
 =

 	if (set_address) {
 		char ip[INET6_ADDRSTRLEN];
+		unsigned int changed =3D NETCONFIG_CHANGED_ADDRESS |
+			NETCONFIG_CHANGED_NETMASK;
+
+		if (netconfig->v4_gateway_str)
+			changed |=3D NETCONFIG_CHANGED_GATEWAY;
+
+		if (netconfig_dns_list_update(netconfig, AF_INET))
+			changed |=3D NETCONFIG_CHANGED_DNS;
+
+		if (netconfig_domains_update(netconfig, AF_INET))
+			changed |=3D NETCONFIG_CHANGED_DOMAINS;
 =

 		if (L_WARN_ON(!netconfig->v4_address ||
 					!l_rtnl_address_get_address(
@@ -1250,9 +1527,6 @@ static bool netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 							ip)))
 			return false;
 =

-		netconfig_dns_list_update(netconfig, AF_INET);
-		netconfig_domains_update(netconfig, AF_INET);
-
 		netconfig->acd =3D l_acd_new(netconfig->ifindex);
 		l_acd_set_event_handler(netconfig->acd,
 					netconfig_ipv4_acd_event, netconfig,
@@ -1266,12 +1540,9 @@ static bool netconfig_ipv4_select_and_install(struct=
 netconfig *netconfig)
 			l_acd_destroy(netconfig->acd);
 			netconfig->acd =3D NULL;
 =

-			L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
-				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ipv4_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
-		}
+			netconfig_set(netconfig, AF_INET, changed);
+		} else
+			netconfig->pending_v4_set |=3D changed;
 =

 		return true;
 	}
@@ -1324,13 +1595,16 @@ static bool netconfig_ipv6_select_and_install(struc=
t netconfig *netconfig)
 	}
 =

 	if (netconfig->v6_address) {
-		netconfig_dns_list_update(netconfig, AF_INET6);
+		unsigned int changed =3D NETCONFIG_CHANGED_ADDRESS |
+			NETCONFIG_CHANGED_NETMASK;
 =

-		L_WARN_ON(!(netconfig->addr6_add_cmd_id =3D
-			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v6_address,
-					netconfig_ipv6_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
+		if (netconfig->v6_gateway_str)
+			changed |=3D NETCONFIG_CHANGED_GATEWAY;
+
+		if (netconfig_dns_list_update(netconfig, AF_INET6))
+			changed |=3D NETCONFIG_CHANGED_DNS;
+
+		netconfig_set(netconfig, AF_INET6, changed);
 		return true;
 	}
 =

@@ -1523,8 +1797,6 @@ bool netconfig_reconfigure(struct netconfig *netconfi=
g)
 =

 bool netconfig_reset(struct netconfig *netconfig)
 {
-	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-
 	if (netconfig->route4_add_gateway_cmd_id) {
 		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
 		netconfig->route4_add_gateway_cmd_id =3D 0;
@@ -1549,24 +1821,7 @@ bool netconfig_reset(struct netconfig *netconfig)
 		resolve_revert(netconfig->resolve);
 =

 	netconfig_reset_v4(netconfig);
-
-	if (netconfig->rtm_v6_protocol) {
-		l_rtnl_address_free(netconfig->v6_address);
-		netconfig->v6_address =3D NULL;
-
-		l_strv_free(l_steal_ptr(netconfig->dns6_overrides));
-		l_strv_free(l_steal_ptr(netconfig->dns6_list));
-
-		l_dhcp6_client_stop(netconfig->dhcp6_client);
-		netconfig->rtm_v6_protocol =3D 0;
-
-		sysfs_write_ipv6_setting(netdev_get_name(netdev),
-						"disable_ipv6", "1");
-
-		l_free(l_steal_ptr(netconfig->v6_gateway_str));
-
-		l_strv_free(l_steal_ptr(netconfig->v6_domains));
-	}
+	netconfig_reset_v6(netconfig);
 =

 	l_free(l_steal_ptr(netconfig->fils_override));
 =

-- =

2.32.0

--===============2141274765755440146==--

