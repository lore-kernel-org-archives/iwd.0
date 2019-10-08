Content-Type: multipart/mixed; boundary="===============5136461066276899620=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/5] netconfig: Split route add/del callbacks
Date: Tue, 08 Oct 2019 14:48:20 -0700
Message-ID: <20191008214824.19466-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5136461066276899620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 84eea7f5..31cbeb2a 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -591,14 +591,25 @@ static void netconfig_ifaddr_ipv6_cmd_cb(int error, u=
int16_t type,
 	netconfig_ifaddr_ipv6_notify(type, data, len, user_data);
 }
 =

-static void netconfig_route_cmd_cb(int error, uint16_t type,
+static void netconfig_route_add_cmd_cb(int error, uint16_t type,
 						const void *data, uint32_t len,
 						void *user_data)
 {
 	if (!error)
 		return;
 =

-	l_error("netconfig: Route command failure. Error %d: %s",
+	l_error("netconfig: Failed to add route. Error %d: %s",
+						error, strerror(-error));
+}
+
+static void netconfig_route_del_cmd_cb(int error, uint16_t type,
+						const void *data, uint32_t len,
+						void *user_data)
+{
+	if (!error)
+		return;
+
+	l_error("netconfig: Failed to delete route. Error %d: %s",
 						error, strerror(-error));
 }
 =

@@ -623,7 +634,7 @@ static bool netconfig_ipv4_routes_install(struct netcon=
fig *netconfig,
 						ifaddr->prefix_len, network,
 						ifaddr->ip,
 						netconfig->rtm_protocol,
-						netconfig_route_cmd_cb,
+						netconfig_route_add_cmd_cb,
 						NULL, NULL)) {
 		l_error("netconfig: Failed to add subnet route.");
 =

@@ -643,7 +654,7 @@ static bool netconfig_ipv4_routes_install(struct netcon=
fig *netconfig,
 						ifaddr->ip,
 						ROUTE_PRIORITY_OFFSET,
 						netconfig->rtm_protocol,
-						netconfig_route_cmd_cb,
+						netconfig_route_add_cmd_cb,
 						NULL, NULL)) {
 		l_error("netconfig: Failed to add route for: %s gateway.",
 								gateway);
@@ -711,7 +722,7 @@ static bool netconfig_ipv6_routes_install(struct netcon=
fig *netconfig)
 	if (!rtnl_route_ipv6_add_gateway(rtnl, netconfig->ifindex, gateway,
 						ROUTE_PRIORITY_OFFSET,
 						netconfig->rtm_v6_protocol,
-						netconfig_route_cmd_cb,
+						netconfig_route_add_cmd_cb,
 						NULL, NULL)) {
 		l_error("netconfig: Failed to add route for: %s gateway.",
 								gateway);
@@ -999,7 +1010,7 @@ static void netconfig_ipv6_select_and_uninstall(struct=
 netconfig *netconfig)
 	if (!rtnl_route_ipv6_delete_gateway(rtnl, netconfig->ifindex,
 			gateway, ROUTE_PRIORITY_OFFSET,
 			netconfig->rtm_v6_protocol,
-			netconfig_route_cmd_cb, NULL, NULL)) {
+			netconfig_route_del_cmd_cb, NULL, NULL)) {
 		l_error("netconfig: Failed to delete route for: %s gateway.",
 								gateway);
 	}
-- =

2.13.6

--===============5136461066276899620==--

