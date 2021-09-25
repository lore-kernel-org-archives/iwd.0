Content-Type: multipart/mixed; boundary="===============5566066212559042397=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 1/8] netconfig: Track the IPv6 route add netlink command
Date: Sat, 25 Sep 2021 03:11:46 +0200
Message-ID: <20210925011153.25195-1-andrew.zaborowski@intel.com>

--===============5566066212559042397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For symmetry with IPv4, save the command id for this netlink command so
we can later add logic to the callback as well as be able to cancel the
command.  No functional change in this commit alone.
---
 src/netconfig.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 421270c9..da775480 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -74,6 +74,7 @@ struct netconfig {
 	uint32_t addr4_add_cmd_id;
 	uint32_t addr6_add_cmd_id;
 	uint32_t route4_add_gateway_cmd_id;
+	uint32_t route6_add_cmd_id;
 };
 =

 static struct l_netlink *rtnl;
@@ -739,6 +740,21 @@ static void netconfig_route_add_cmd_cb(int error, uint=
16_t type,
 	netconfig->notify =3D NULL;
 }
 =

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
+		return;
+	}
+}
+
 static bool netconfig_ipv4_routes_install(struct netconfig *netconfig)
 {
 	L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
@@ -859,10 +875,12 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int erro=
r, uint16_t type,
 =

 	gateway =3D netconfig_get_static6_gateway(netconfig, &gateway_mac);
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
@@ -1360,6 +1378,11 @@ bool netconfig_reset(struct netconfig *netconfig)
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
-- =

2.30.2

--===============5566066212559042397==--

