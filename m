Content-Type: multipart/mixed; boundary="===============7708580702984170378=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v4 5/5] netconfig: Install IPv6 DNS
Date: Tue, 01 Oct 2019 16:44:25 -0700
Message-ID: <20191001234425.22913-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191001234425.22913-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7708580702984170378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 129fe518..65ba5330 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -323,6 +323,50 @@ static char *netconfig_ipv6_get_gateway(struct netconf=
ig *netconfig)
 	return NULL;
 }
 =

+static char **netconfig_ipv6_get_dns(struct netconfig *netconfig, uint8_t =
proto)
+{
+	struct in6_addr in6_addr;
+	char **dns_list;
+	char **p;
+
+	switch (proto) {
+	case RTPROT_STATIC:
+		if (!netconfig->active_settings)
+			return NULL;
+
+		p =3D dns_list =3D
+			l_settings_get_string_list(netconfig->active_settings,
+							"IPv6", "dns", ' ');
+
+		if (!dns_list || !*dns_list) {
+			l_strv_free(dns_list);
+
+			return NULL;
+		}
+
+		for (; *p; p++) {
+			if (inet_pton(AF_INET6, *p, &in6_addr) =3D=3D 1)
+				continue;
+
+			l_error("netconfig: Invalid IPv6 DNS address %s is "
+				"provided in network configuration file.", *p);
+
+			l_strv_free(dns_list);
+
+			return NULL;
+		}
+
+		return dns_list;
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
@@ -672,6 +716,7 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 						void *user_data)
 {
 	struct netconfig *netconfig =3D user_data;
+	char **dns;
 =

 	if (error && error !=3D -EEXIST) {
 		l_error("netconfig: Failed to add IPv6 address. "
@@ -685,7 +730,16 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error=
, uint16_t type,
 		return;
 	}
 =

-	/* TODO Install DNS */
+	dns =3D netconfig_ipv6_get_dns(netconfig, netconfig->rtm_v6_protocol);
+	if (!dns) {
+		l_error("netconfig: Failed to obtain the DNS addresses from "
+			"%s.", netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ?
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

--===============7708580702984170378==--

