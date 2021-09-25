Content-Type: multipart/mixed; boundary="===============3285402066110426320=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 4/8] netconfig: Track gateway address strings
Date: Sat, 25 Sep 2021 03:11:49 +0200
Message-ID: <20210925011153.25195-4-andrew.zaborowski@intel.com>
In-Reply-To: 20210925011153.25195-1-andrew.zaborowski@intel.com

--===============3285402066110426320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cache the latest v4 and v6 gateway IP string in struct netconfig state
to be able to more easily detect changes in those values in future
commits and perhaps to simplify the ..._routes_install functions.
netconfig_ipv4_get_gateway's out_mac parameter can now be NULL.  While
editing that function fix a small formatting annoyance.
---
 src/netconfig.c | 63 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 30e56157..e93e496c 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -62,6 +62,8 @@ struct netconfig {
 	char **dns4_overrides;
 	char **dns6_overrides;
 	struct ie_fils_ip_addr_response_info *fils_override;
+	char *v4_gateway_str;
+	char *v6_gateway_str;
 =

 	const struct l_settings *active_settings;
 =

@@ -419,6 +421,8 @@ static char *netconfig_ipv4_get_gateway(struct netconfi=
g *netconfig,
 {
 	const struct l_dhcp_lease *lease;
 	char *gateway;
+	const struct ie_fils_ip_addr_response_info *fils =3D
+		netconfig->fils_override;
 =

 	switch (netconfig->rtm_protocol) {
 	case RTPROT_STATIC:
@@ -432,15 +436,12 @@ static char *netconfig_ipv4_get_gateway(struct netcon=
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
@@ -478,7 +479,7 @@ static struct l_rtnl_address *netconfig_get_static6_add=
ress(
 	prefix_len =3D strtoul(p, NULL, 10);
 	if (!unlikely(errno =3D=3D EINVAL || errno =3D=3D ERANGE ||
 			!prefix_len || prefix_len > 128)) {
-		l_error("netconfig: Invalid prefix '%s'  provided in network"
+		l_error("netconfig: Invalid prefix '%s' provided in network"
 				" configuration file", p);
 		return NULL;
 	}
@@ -494,6 +495,7 @@ no_prefix_len:
 =

 static struct l_rtnl_route *netconfig_get_static6_gateway(
 						struct netconfig *netconfig,
+						char **out_str,
 						const uint8_t **out_mac)
 {
 	L_AUTO_FREE_VAR(char *, gateway);
@@ -524,6 +526,7 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 =

 	l_rtnl_route_set_priority(ret, ROUTE_PRIORITY_OFFSET);
 	l_rtnl_route_set_protocol(ret, RTPROT_STATIC);
+	*out_str =3D l_steal_ptr(gateway);
 	*out_mac =3D mac;
 =

 	return ret;
@@ -876,7 +879,9 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 		return;
 	}
 =

-	gateway =3D netconfig_get_static6_gateway(netconfig, &gateway_mac);
+	gateway =3D netconfig_get_static6_gateway(netconfig,
+						&netconfig->v6_gateway_str,
+						&gateway_mac);
 	if (gateway) {
 		netconfig->route6_add_cmd_id =3D l_rtnl_route_add(rtnl,
 							netconfig->ifindex,
@@ -933,10 +938,24 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
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
+		}
+
+		address =3D netconfig_get_dhcp4_address(netconfig);
+		l_rtnl_address_free(netconfig->v4_address);
+		netconfig->v4_address =3D address;
+
 		if (!netconfig->v4_address) {
 			l_error("netconfig: Failed to obtain IP addresses from "
 							"DHCPv4 lease.");
@@ -949,6 +968,7 @@ static void netconfig_ipv4_dhcp_event_handler(struct l_=
dhcp_client *client,
 					netconfig_ipv4_ifaddr_add_cmd_cb,
 					netconfig, NULL)));
 		break;
+	}
 	case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
 		break;
 	case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
@@ -958,6 +978,7 @@ static void netconfig_ipv4_dhcp_event_handler(struct l_=
dhcp_client *client,
 					netconfig, NULL));
 		l_rtnl_address_free(netconfig->v4_address);
 		netconfig->v4_address =3D NULL;
+		l_free(l_steal_ptr(netconfig->v4_gateway_str));
 =

 		/* Fall through. */
 	case L_DHCP_CLIENT_EVENT_NO_LEASE:
@@ -992,6 +1013,17 @@ static void netconfig_dhcp6_event_handler(struct l_dh=
cp6_client *client,
 		L_AUTO_FREE_VAR(char *, addr_str) =3D
 			l_dhcp6_lease_get_address(lease);
 		struct l_rtnl_address *address;
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
+		}
 =

 		address =3D l_rtnl_address_new(addr_str,
 					l_dhcp6_lease_get_prefix_length(lease));
@@ -1008,6 +1040,7 @@ static void netconfig_dhcp6_event_handler(struct l_dh=
cp6_client *client,
 		netconfig_set_domains(netconfig);
 		l_rtnl_address_free(netconfig->v6_address);
 		netconfig->v6_address =3D NULL;
+		l_free(l_steal_ptr(netconfig->v6_gateway_str));
 =

 		/* Fall through */
 	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
@@ -1044,6 +1077,9 @@ static void netconfig_reset_v4(struct netconfig *netc=
onfig)
 =

 		l_acd_destroy(netconfig->acd);
 		netconfig->acd =3D NULL;
+
+		l_free(netconfig->v4_gateway_str);
+		netconfig->v4_gateway_str =3D NULL;
 	}
 }
 =

@@ -1427,6 +1463,9 @@ bool netconfig_reset(struct netconfig *netconfig)
 =

 		sysfs_write_ipv6_setting(netdev_get_name(netdev),
 						"disable_ipv6", "1");
+
+		l_free(netconfig->v6_gateway_str);
+		netconfig->v6_gateway_str =3D NULL;
 	}
 =

 	l_free(l_steal_ptr(netconfig->fils_override));
-- =

2.30.2

--===============3285402066110426320==--

