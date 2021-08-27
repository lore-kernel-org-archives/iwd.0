Content-Type: multipart/mixed; boundary="===============8510819234920902367=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] netconfig: Apply MACs received in FILS IP Assigment
Date: Fri, 27 Aug 2021 05:05:44 +0200
Message-ID: <20210827030544.353932-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8510819234920902367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the MAC addresses for the gateways and DNS servers received in the
FILS IP Assigment IE together with the gateway IP and DNS server IP.
Commit the IP to MAC mappings directly to the ARP/NDP tables so that the
network stack can skip sending the corresponding queries over the air.
---
 src/netconfig.c | 119 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 98 insertions(+), 21 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 6e1e1aa7..9bbaece5 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -196,22 +196,40 @@ static inline char *netconfig_ipv6_to_string(const ui=
nt8_t *addr)
 	return addr_str;
 }
 =

+static void netconfig_set_neighbor_entry_cb(int error,
+						uint16_t type, const void *data,
+						uint32_t len, void *user_data)
+{
+	if (error)
+		l_error("l_rtnl_neighbor_set_hwaddr failed: %s (%i)",
+			strerror(-error), error);
+}
+
 static int netconfig_set_dns(struct netconfig *netconfig)
 {
 	char **dns6_list =3D NULL;
 	char **dns4_list =3D NULL;
 	unsigned int n_entries =3D 0;
 	char **dns_list;
+	const uint8_t *fils_dns4_mac =3D NULL;
+	const uint8_t *fils_dns6_mac =3D NULL;
+	const struct ie_fils_ip_addr_response_info *fils =3D
+		netconfig->fils_override;
 =

 	if (!netconfig->dns4_overrides &&
 			netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
 		const struct l_dhcp_lease *lease;
 =

-		if (netconfig->fils_override &&
-				netconfig->fils_override->ipv4_dns) {
+		if (fils && fils->ipv4_dns) {
 			dns4_list =3D l_new(char *, 2);
-			dns4_list[0] =3D netconfig_ipv4_to_string(
-					netconfig->fils_override->ipv4_dns);
+			dns4_list[0] =3D netconfig_ipv4_to_string(fils->ipv4_dns);
+
+			if (!l_memeqzero(fils->ipv4_dns_mac, 6) &&
+					util_ip_subnet_match(
+							fils->ipv4_prefix_len,
+							&fils->ipv4_addr,
+							&fils->ipv4_dns))
+				fils_dns4_mac =3D fils->ipv4_dns_mac;
 		} else if ((lease =3D l_dhcp_client_get_lease(
 						netconfig->dhcp_client)))
 			dns4_list =3D l_dhcp_lease_get_dns(lease);
@@ -221,12 +239,17 @@ static int netconfig_set_dns(struct netconfig *netcon=
fig)
 			netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
 		const struct l_dhcp6_lease *lease;
 =

-		if (netconfig->fils_override &&
-				!l_memeqzero(netconfig->fils_override->ipv6_dns,
+		if (fils && !l_memeqzero(fils->ipv6_dns,
 						16)) {
 			dns6_list =3D l_new(char *, 2);
-			dns6_list[0] =3D netconfig_ipv6_to_string(
-					netconfig->fils_override->ipv6_dns);
+			dns6_list[0] =3D netconfig_ipv6_to_string(fils->ipv6_dns);
+
+			if (!l_memeqzero(fils->ipv6_dns_mac, 6) &&
+					util_ip_subnet_match(
+							fils->ipv6_prefix_len,
+							fils->ipv6_addr,
+							fils->ipv6_dns))
+				fils_dns6_mac =3D fils->ipv6_dns_mac;
 		} else if ((lease =3D l_dhcp6_client_get_lease(
 						netconfig->dhcp6_client)))
 			dns6_list =3D l_dhcp6_lease_get_dns(lease);
@@ -242,15 +265,28 @@ static int netconfig_set_dns(struct netconfig *netcon=
fig)
 =

 	APPEND_STRDUPV(dns_list, n_entries, netconfig->dns4_overrides);
 	APPENDV(dns_list, n_entries, dns4_list);
-	/* Contents now belong to ret, so not l_strfreev */
-	l_free(dns4_list);
 	APPEND_STRDUPV(dns_list, n_entries, netconfig->dns6_overrides);
 	APPENDV(dns_list, n_entries, dns6_list);
-	/* Contents now belong to ret, so not l_strfreev */
-	l_free(dns6_list);
-
 	resolve_set_dns(netconfig->resolve, dns_list);
+
+	if (fils_dns4_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
+					netconfig->ifindex, AF_INET,
+					&fils->ipv4_dns, fils_dns4_mac, 6,
+					netconfig_set_neighbor_entry_cb, NULL,
+					NULL))
+		l_debug("l_rtnl_neighbor_set_hwaddr failed");
+
+	if (fils_dns6_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
+					netconfig->ifindex, AF_INET6,
+					fils->ipv6_dns, fils_dns6_mac, 6,
+					netconfig_set_neighbor_entry_cb, NULL,
+					NULL))
+		l_debug("l_rtnl_neighbor_set_hwaddr failed");
+
 	l_strv_free(dns_list);
+	/* Contents belonged to dns_list, so not l_strfreev */
+	l_free(dns4_list);
+	l_free(dns6_list);
 	return 0;
 }
 =

@@ -361,7 +397,8 @@ static struct l_rtnl_address *netconfig_get_static4_add=
ress(
 	return ifaddr;
 }
 =

-static char *netconfig_ipv4_get_gateway(struct netconfig *netconfig)
+static char *netconfig_ipv4_get_gateway(struct netconfig *netconfig,
+					const uint8_t **out_mac)
 {
 	const struct l_dhcp_lease *lease;
 	char *gateway;
@@ -379,10 +416,18 @@ static char *netconfig_ipv4_get_gateway(struct netcon=
fig *netconfig)
 =

 	case RTPROT_DHCP:
 		if (netconfig->fils_override &&
-				netconfig->fils_override->ipv4_gateway)
-			return netconfig_ipv4_to_string(
+				netconfig->fils_override->ipv4_gateway) {
+			gateway =3D netconfig_ipv4_to_string(
 					netconfig->fils_override->ipv4_gateway);
 =

+			if (gateway && !l_memeqzero(netconfig->fils_override->
+							ipv4_gateway_mac, 6))
+				*out_mac =3D netconfig->fils_override->
+					ipv4_gateway_mac;
+
+			return gateway;
+		}
+
 		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
 		if (!lease)
 			return NULL;
@@ -431,7 +476,8 @@ no_prefix_len:
 }
 =

 static struct l_rtnl_route *netconfig_get_static6_gateway(
-						struct netconfig *netconfig)
+						struct netconfig *netconfig,
+						const uint8_t **out_mac)
 {
 	L_AUTO_FREE_VAR(char *, gateway);
 	struct l_rtnl_route *ret;
@@ -441,10 +487,13 @@ static struct l_rtnl_route *netconfig_get_static6_gat=
eway(
 	if (!gateway && netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
 			netconfig->fils_override &&
 			!l_memeqzero(netconfig->fils_override->ipv6_gateway,
-					16))
+					16)) {
 		gateway =3D netconfig_ipv6_to_string(
 					netconfig->fils_override->ipv6_gateway);
-	else if (!gateway)
+
+		if (!l_memeqzero(netconfig->fils_override->ipv6_gateway_mac, 6))
+			*out_mac =3D netconfig->fils_override->ipv6_gateway_mac;
+	} else if (!gateway)
 		return NULL;
 =

 	ret =3D l_rtnl_route_new_gateway(gateway);
@@ -678,6 +727,7 @@ static void netconfig_route_add_cmd_cb(int error, uint1=
6_t type,
 static bool netconfig_ipv4_routes_install(struct netconfig *netconfig)
 {
 	L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
+	const uint8_t *gateway_mac =3D NULL;
 	struct in_addr in_addr;
 	char ip[INET_ADDRSTRLEN];
 	char network[INET_ADDRSTRLEN];
@@ -704,7 +754,7 @@ static bool netconfig_ipv4_routes_install(struct netcon=
fig *netconfig)
 		return false;
 	}
 =

-	gateway =3D netconfig_ipv4_get_gateway(netconfig);
+	gateway =3D netconfig_ipv4_get_gateway(netconfig, &gateway_mac);
 	if (!gateway) {
 		l_debug("No gateway obtained from %s.",
 				netconfig->rtm_protocol =3D=3D RTPROT_STATIC ?
@@ -732,6 +782,24 @@ static bool netconfig_ipv4_routes_install(struct netco=
nfig *netconfig)
 		return false;
 	}
 =

+	if (gateway_mac) {
+		/*
+		 * Attempt to use the gateway MAC address received from the AP
+		 * by writing the mapping directly into the netdev's ARP table
+		 * so as to save one data frame roundtrip before first IP
+		 * connections are established.  This is very low-priority but
+		 * print error messages just because they may indicate bigger
+		 * problems.
+		 */
+		if (!l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex,
+					AF_INET,
+					&netconfig->fils_override->ipv4_gateway,
+					gateway_mac, 6,
+					netconfig_set_neighbor_entry_cb, NULL,
+					NULL))
+			l_debug("l_rtnl_neighbor_set_hwaddr failed");
+	}
+
 	return true;
 }
 =

@@ -764,6 +832,7 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 {
 	struct netconfig *netconfig =3D user_data;
 	struct l_rtnl_route *gateway;
+	const uint8_t *gateway_mac =3D NULL;
 =

 	netconfig->addr6_add_cmd_id =3D 0;
 =

@@ -773,13 +842,21 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int erro=
r, uint16_t type,
 		return;
 	}
 =

-	gateway =3D netconfig_get_static6_gateway(netconfig);
+	gateway =3D netconfig_get_static6_gateway(netconfig, &gateway_mac);
 	if (gateway) {
 		L_WARN_ON(!l_rtnl_route_add(rtnl, netconfig->ifindex,
 						gateway,
 						netconfig_route_generic_cb,
 						netconfig, NULL));
 		l_rtnl_route_free(gateway);
+
+		if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
+					netconfig->ifindex, AF_INET6,
+					netconfig->fils_override->ipv6_gateway,
+					gateway_mac, 6,
+					netconfig_set_neighbor_entry_cb, NULL,
+					NULL))
+			l_debug("l_rtnl_neighbor_set_hwaddr failed");
 	}
 =

 	netconfig_set_dns(netconfig);
-- =

2.30.2

--===============8510819234920902367==--

