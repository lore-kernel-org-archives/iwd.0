Content-Type: multipart/mixed; boundary="===============7195600950580765269=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/4] netconfig: Remove IPv6 default route
Date: Wed, 02 Oct 2019 13:39:57 -0700
Message-ID: <20191002203959.5582-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191002203959.5582-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7195600950580765269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The IPv6 default route needs to be explicitly revoked. Unlike in IPv4,
there is no SRC address associated with the route and it will not be
removed on address removal.
---
 src/netconfig.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/netconfig.c b/src/netconfig.c
index 90cd6bc2..cf951245 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -958,6 +958,7 @@ static void netconfig_ipv6_select_and_install(struct ne=
tconfig *netconfig)
 static void netconfig_ipv6_select_and_uninstall(struct netconfig *netconfi=
g)
 {
 	struct netconfig_ifaddr *ifaddr;
+	char *gateway;
 =

 	ifaddr =3D netconfig_ipv6_get_ifaddr(netconfig,
 						netconfig->rtm_v6_protocol);
@@ -970,6 +971,20 @@ static void netconfig_ipv6_select_and_uninstall(struct=
 netconfig *netconfig)
 	 * TODO
 	 * l_dhcp_v6_client_stop(netconfig->l_dhcp_v6_client);
 	 */
+
+	gateway =3D netconfig_ipv6_get_gateway(netconfig);
+	if (!gateway)
+		return;
+
+	if (!rtnl_route_ipv6_delete_gateway(rtnl, netconfig->ifindex,
+			gateway, ROUTE_PRIORITY_OFFSET,
+			netconfig->rtm_v6_protocol,
+			netconfig_route_cmd_cb, NULL, NULL)) {
+		l_error("netconfig: Failed to delete route for: %s gateway.",
+								gateway);
+	}
+
+	l_free(gateway);
 }
 =

 bool netconfig_configure(struct netconfig *netconfig,
-- =

2.13.6

--===============7195600950580765269==--

