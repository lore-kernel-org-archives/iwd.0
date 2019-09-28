Content-Type: multipart/mixed; boundary="===============8173822821163445571=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 13/14] netconfig: Install IPv6 default route
Date: Fri, 27 Sep 2019 17:12:32 -0700
Message-ID: <20190928001233.19217-13-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8173822821163445571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 14aac28f..6651b2cd 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -278,6 +278,25 @@ proceed:
 	return NULL;
 }
 =

+static char *netconfig_ipv6_get_gateway(struct netconfig *netconfig)
+{
+	switch (netconfig->rtm_v6_protocol) {
+	case RTPROT_STATIC:
+		if (!netconfig->active_settings)
+			return NULL;
+
+		return l_settings_get_string(netconfig->active_settings, "IPv6",
+								"gateway");
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
 static struct netconfig_ifaddr *netconfig_ifaddr_find(
 					const struct netconfig *netconfig,
 					uint8_t family, uint8_t prefix_len,
@@ -577,17 +596,52 @@ done:
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

--===============8173822821163445571==--

