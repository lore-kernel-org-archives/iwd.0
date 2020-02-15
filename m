Content-Type: multipart/mixed; boundary="===============2439382217983742509=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 2/3] netconfig: Use ell's rtnl API
Date: Sat, 15 Feb 2020 10:48:40 +0100
Message-ID: <20200215094841.28265-3-wagi@monom.org>
In-Reply-To: <20200215094841.28265-1-wagi@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2439382217983742509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 327244f9b23f..e89f87f89e0c 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -502,8 +502,8 @@ static void netconfig_ifaddr_added(struct netconfig *ne=
tconfig,
 	ifaddr->family =3D ifa->ifa_family;
 	ifaddr->prefix_len =3D ifa->ifa_prefixlen;
 =

-	rtnl_ifaddr_extract(ifa, len, &label, &ifaddr->ip,
-							&ifaddr->broadcast);
+	l_rtnl_ifaddr4_extract(ifa, len, &label, &ifaddr->ip,
+					&ifaddr->broadcast);
 =

 	l_debug("%s: ifaddr %s/%u broadcast %s", label, ifaddr->ip,
 					ifaddr->prefix_len, ifaddr->broadcast);
@@ -519,7 +519,7 @@ static void netconfig_ifaddr_deleted(struct netconfig *=
netconfig,
 	struct netconfig_ifaddr *ifaddr;
 	struct netconfig_ifaddr query;
 =

-	rtnl_ifaddr_extract(ifa, len, NULL, &query.ip, NULL);
+	l_rtnl_ifaddr4_extract(ifa, len, NULL, &query.ip, NULL);
 =

 	query.family =3D ifa->ifa_family;
 	query.prefix_len =3D ifa->ifa_prefixlen;
@@ -586,7 +586,7 @@ static void netconfig_ifaddr_ipv6_added(struct netconfi=
g *netconfig,
 	ifaddr->family =3D ifa->ifa_family;
 	ifaddr->prefix_len =3D ifa->ifa_prefixlen;
 =

-	rtnl_ifaddr_ipv6_extract(ifa, len, &ifaddr->ip);
+	l_rtnl_ifaddr6_extract(ifa, len, &ifaddr->ip);
 =

 	l_debug("ifindex %u: ifaddr %s/%u", netconfig->ifindex, ifaddr->ip,
 							ifaddr->prefix_len);
@@ -601,7 +601,7 @@ static void netconfig_ifaddr_ipv6_deleted(struct netcon=
fig *netconfig,
 	struct netconfig_ifaddr *ifaddr;
 	struct netconfig_ifaddr query;
 =

-	rtnl_ifaddr_ipv6_extract(ifa, len, &query.ip);
+	l_rtnl_ifaddr6_extract(ifa, len, &query.ip);
 =

 	query.family =3D ifa->ifa_family;
 	query.prefix_len =3D ifa->ifa_prefixlen;
@@ -707,7 +707,7 @@ static bool netconfig_ipv4_routes_install(struct netcon=
fig *netconfig,
 	if (!network)
 		return false;
 =

-	if (!rtnl_route_ipv4_add_connected(rtnl, netconfig->ifindex,
+	if (!l_rtnl_route4_add_connected(rtnl, netconfig->ifindex,
 						ifaddr->prefix_len, network,
 						ifaddr->ip,
 						netconfig->rtm_protocol,
@@ -727,7 +727,7 @@ static bool netconfig_ipv4_routes_install(struct netcon=
fig *netconfig,
 		return false;
 	}
 =

-	if (!rtnl_route_ipv4_add_gateway(rtnl, netconfig->ifindex, gateway,
+	if (!l_rtnl_route4_add_gateway(rtnl, netconfig->ifindex, gateway,
 						ifaddr->ip,
 						ROUTE_PRIORITY_OFFSET,
 						netconfig->rtm_protocol,
@@ -806,7 +806,7 @@ static bool netconfig_ipv6_routes_install(struct netcon=
fig *netconfig)
 		return false;
 	}
 =

-	if (!rtnl_route_ipv6_add_gateway(rtnl, netconfig->ifindex, gateway,
+	if (!l_rtnl_route6_add_gateway(rtnl, netconfig->ifindex, gateway,
 						ROUTE_PRIORITY_OFFSET,
 						netconfig->rtm_v6_protocol,
 						netconfig_route_add_cmd_cb,
@@ -860,7 +860,7 @@ static void netconfig_install_address(struct netconfig =
*netconfig,
 =

 	switch (ifaddr->family) {
 	case AF_INET:
-		if (rtnl_ifaddr_add(rtnl, netconfig->ifindex,
+		if (l_rtnl_ifaddr4_add(rtnl, netconfig->ifindex,
 					ifaddr->prefix_len, ifaddr->ip,
 					ifaddr->broadcast,
 					netconfig_ipv4_ifaddr_add_cmd_cb,
@@ -871,7 +871,7 @@ static void netconfig_install_address(struct netconfig =
*netconfig,
 							ifaddr->prefix_len);
 		break;
 	case AF_INET6:
-		if (rtnl_ifaddr_ipv6_add(rtnl, netconfig->ifindex,
+		if (l_rtnl_ifaddr6_add(rtnl, netconfig->ifindex,
 					ifaddr->prefix_len, ifaddr->ip,
 					netconfig_ipv6_ifaddr_add_cmd_cb,
 					netconfig, NULL))
@@ -916,7 +916,7 @@ static void netconfig_uninstall_address(struct netconfi=
g *netconfig,
 =

 	switch (ifaddr->family) {
 	case AF_INET:
-		if (rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
+		if (l_rtnl_ifaddr4_delete(rtnl, netconfig->ifindex,
 					ifaddr->prefix_len, ifaddr->ip,
 					ifaddr->broadcast,
 					netconfig_ifaddr_del_cmd_cb, netconfig,
@@ -927,7 +927,7 @@ static void netconfig_uninstall_address(struct netconfi=
g *netconfig,
 						ifaddr->ip, ifaddr->prefix_len);
 		break;
 	case AF_INET6:
-		if (rtnl_ifaddr_ipv6_delete(rtnl, netconfig->ifindex,
+		if (l_rtnl_ifaddr6_delete(rtnl, netconfig->ifindex,
 					ifaddr->prefix_len, ifaddr->ip,
 					netconfig_ifaddr_del_cmd_cb, netconfig,
 					NULL))
@@ -1094,7 +1094,7 @@ static void netconfig_ipv6_select_and_uninstall(struc=
t netconfig *netconfig)
 	if (!gateway)
 		return;
 =

-	if (!rtnl_route_ipv6_delete_gateway(rtnl, netconfig->ifindex,
+	if (!l_rtnl_route6_delete_gateway(rtnl, netconfig->ifindex,
 			gateway, ROUTE_PRIORITY_OFFSET,
 			netconfig->rtm_v6_protocol,
 			netconfig_route_del_cmd_cb, NULL, NULL)) {
@@ -1233,7 +1233,7 @@ static int netconfig_init(void)
 		goto error;
 	}
 =

-	r =3D rtnl_ifaddr_get(rtnl, netconfig_ifaddr_cmd_cb, NULL, NULL);
+	r =3D l_rtnl_ifaddr4_dump(rtnl, netconfig_ifaddr_cmd_cb, NULL, NULL);
 	if (!r) {
 		l_error("netconfig: Failed to get addresses from RTNL link.");
 		goto error;
@@ -1247,7 +1247,7 @@ static int netconfig_init(void)
 		goto error;
 	}
 =

-	r =3D rtnl_ifaddr_ipv6_get(rtnl, netconfig_ifaddr_ipv6_cmd_cb, NULL,
+	r =3D l_rtnl_ifaddr6_dump(rtnl, netconfig_ifaddr_ipv6_cmd_cb, NULL,
 									NULL);
 	if (!r) {
 		l_error("netconfig: Failed to get IPv6 addresses from RTNL"
-- =

2.25.0
--===============2439382217983742509==--

