Content-Type: multipart/mixed; boundary="===============8669385628854128451=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 8/8] netconfig: Install IPv6 DNS
Date: Mon, 30 Sep 2019 09:35:58 -0700
Message-ID: <20190930163558.28123-8-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190930163558.28123-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8669385628854128451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 6651b2cd..cb072462 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -297,6 +297,25 @@ static char *netconfig_ipv6_get_gateway(struct netconf=
ig *netconfig)
 	return NULL;
 }
 =

+static char **netconfig_ipv6_get_dns(struct netconfig *netconfig, uint8_t =
proto)
+{
+	switch (proto) {
+	case RTPROT_STATIC:
+		if (!netconfig->active_settings)
+			return NULL;
+
+		return l_settings_get_string_list(netconfig->active_settings,
+							"IPv6", "dns", ' ');
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
@@ -628,6 +647,7 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 						void *user_data)
 {
 	struct netconfig *netconfig =3D user_data;
+	char **dns;
 =

 	if (error && error !=3D -EEXIST) {
 		l_error("netconfig: Failed to add IPv6 address. "
@@ -641,7 +661,16 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error=
, uint16_t type,
 		return;
 	}
 =

-	/* TODO Install DNS */
+	dns =3D netconfig_ipv6_get_dns(netconfig, netconfig->rtm_v6_protocol);
+	if (!dns) {
+		l_error("netconfig: Failed to obtain DNS addresses from %s.",
+				netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ?
+				"setting file" : "DHCPv6 lease");
+		return;
+	}
+
+	resolve_add_dns(netconfig->ifindex, AF_INET6, dns);
+	l_strv_free(dns);
 }
 =

 static void netconfig_install_address(struct netconfig *netconfig,
-- =

2.13.6

--===============8669385628854128451==--

