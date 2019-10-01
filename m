Content-Type: multipart/mixed; boundary="===============6516471381105293968=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v4 4/5] netconfig: Install IPv6 default route
Date: Tue, 01 Oct 2019 16:44:24 -0700
Message-ID: <20191001234425.22913-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191001234425.22913-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6516471381105293968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 7d26acb0..129fe518 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -289,6 +289,40 @@ proceed:
 	return NULL;
 }
 =

+static char *netconfig_ipv6_get_gateway(struct netconfig *netconfig)
+{
+	struct in6_addr in6_addr;
+	char *gateway;
+
+	switch (netconfig->rtm_v6_protocol) {
+	case RTPROT_STATIC:
+		if (!netconfig->active_settings)
+			return NULL;
+
+		gateway =3D l_settings_get_string(netconfig->active_settings,
+							"IPv6", "gateway");
+
+		if (inet_pton(AF_INET6, gateway, &in6_addr) < 1) {
+			l_error("netconfig: Invalid IPv6 gateway address %s is "
+				"provided in network configuration file.",
+				gateway);
+
+			l_free(gateway);
+
+			return NULL;
+		}
+
+		return gateway;
+
+	case RTPROT_DHCP:
+		/* TODO */
+
+		return NULL;
+	}
+
+	return NULL;
+}
+
 static bool netconfig_ifaddr_match(const void *a, const void *b)
 {
 	const struct netconfig_ifaddr *entry =3D a;
@@ -606,17 +640,52 @@ done:
 	netconfig_ifaddr_destroy(ifaddr);
 }
 =

+static bool netconfig_ipv6_routes_install(struct netconfig *netconfig)
+{
+	L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
+
+	gateway =3D netconfig_ipv6_get_gateway(netconfig);
+	if (!gateway) {
+		l_error("netconfig: Failed to obtain gateway from %s.",
+				netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ?
+				"settings file" : "DHCPv6 lease");
+
+		return false;
+	}
+
+	if (!rtnl_route_ipv6_add_gateway(rtnl, netconfig->ifindex, gateway,
+						ROUTE_PRIORITY_OFFSET,
+						netconfig->rtm_v6_protocol,
+						netconfig_route_cmd_cb,
+						NULL, NULL)) {
+		l_error("netconfig: Failed to add route for: %s gateway.",
+								gateway);
+
+		return false;
+	}
+
+	return true;
+}
+
 static void netconfig_ipv6_ifaddr_add_cmd_cb(int error, uint16_t type,
 						const void *data, uint32_t len,
 						void *user_data)
 {
+	struct netconfig *netconfig =3D user_data;
+
 	if (error && error !=3D -EEXIST) {
 		l_error("netconfig: Failed to add IPv6 address. "
 				"Error %d: %s", error, strerror(-error));
 		return;
 	}
 =

-	/* TODO Install routes and DNS */
+	if (!netconfig_ipv6_routes_install(netconfig)) {
+		l_error("netconfig: Failed to install IPv6 routes.");
+
+		return;
+	}
+
+	/* TODO Install DNS */
 }
 =

 static void netconfig_install_address(struct netconfig *netconfig,
-- =

2.13.6

--===============6516471381105293968==--

