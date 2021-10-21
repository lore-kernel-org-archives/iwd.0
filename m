Content-Type: multipart/mixed; boundary="===============1421841197806755684=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 08/12] netconfig: Move FILS override checks to common functions
Date: Thu, 21 Oct 2021 10:50:37 +0200
Message-ID: <20211021085041.294524-8-andrew.zaborowski@intel.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============1421841197806755684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 56 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index a73afe24..88e10e3f 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -220,6 +220,36 @@ static inline char *netconfig_ipv6_to_string(const uin=
t8_t *addr)
 	return addr_str;
 }
 =

+static bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
+{
+	if ((af =3D=3D AF_INET ? netconfig->rtm_protocol :
+				netconfig->rtm_v6_protocol) !=3D RTPROT_DHCP)
+		return false;
+
+	if (!netconfig->fils_override)
+		return false;
+
+	if (af =3D=3D AF_INET)
+		return !!netconfig->fils_override->ipv4_addr;
+
+	return !l_memeqzero(netconfig->fils_override->ipv6_addr, 16);
+}
+
+static bool netconfig_use_fils_gateway(struct netconfig *netconfig, int af)
+{
+	if ((af =3D=3D AF_INET ? netconfig->rtm_protocol :
+				netconfig->rtm_v6_protocol) !=3D RTPROT_DHCP)
+		return false;
+
+	if (!netconfig->fils_override)
+		return false;
+
+	if (af =3D=3D AF_INET)
+		return !!netconfig->fils_override->ipv4_gateway;
+
+	return !l_memeqzero(netconfig->fils_override->ipv6_gateway, 16);
+}
+
 static char **netconfig_get_dns_list(struct netconfig *netconfig, int af,
 					const uint8_t **out_dns_mac)
 {
@@ -503,7 +533,7 @@ static char *netconfig_ipv4_get_gateway(struct netconfi=
g *netconfig,
 		return gateway;
 =

 	case RTPROT_DHCP:
-		if (fils && fils->ipv4_gateway) {
+		if (netconfig_use_fils_gateway(netconfig, AF_INET)) {
 			gateway =3D netconfig_ipv4_to_string(fils->ipv4_gateway);
 =

 			if (gateway && out_mac &&
@@ -571,10 +601,7 @@ static struct l_rtnl_route *netconfig_get_static6_gate=
way(
 =

 	gateway =3D l_settings_get_string(netconfig->active_settings,
 						"IPv6", "Gateway");
-	if (!gateway && netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
-			netconfig->fils_override &&
-			!l_memeqzero(netconfig->fils_override->ipv6_gateway,
-					16)) {
+	if (!gateway && netconfig_use_fils_gateway(netconfig, AF_INET6)) {
 		gateway =3D netconfig_ipv6_to_string(
 					netconfig->fils_override->ipv6_gateway);
 =

@@ -742,8 +769,7 @@ static void netconfig_ifaddr_ipv6_added(struct netconfi=
g *netconfig,
 			ip, ifa->ifa_prefixlen);
 =

 	if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP ||
-			(netconfig->fils_override &&
-			 !l_memeqzero(netconfig->fils_override->ipv6_addr, 16)))
+			netconfig_use_fils_addr(netconfig, AF_INET6))
 		return;
 =

 	inet_pton(AF_INET6, ip, &in6);
@@ -1120,9 +1146,7 @@ static void netconfig_set(struct netconfig *netconfig=
, uint8_t af,
 		 * static and FILS-provided cases here.
 		 */
 	} else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ||
-			(netconfig->fils_override &&
-			 !l_memeqzero(netconfig->fils_override->ipv6_addr,
-					16))) {
+			netconfig_use_fils_addr(netconfig, AF_INET6)) {
 		if (!netconfig->v6_address)
 			return;
 =

@@ -1168,9 +1192,7 @@ static void netconfig_set(struct netconfig *netconfig=
, uint8_t af,
 			netconfig->notify =3D NULL;
 		}
 	} else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ||
-			(netconfig->fils_override &&
-			 !l_memeqzero(netconfig->fils_override->ipv6_gateway,
-					16))) {
+			netconfig_use_fils_gateway(netconfig, AF_INET6)) {
 		if (changed & (NETCONFIG_CHANGED_GATEWAY))
 			if (netconfig_ipv6_static_gateway_route_install(
 								netconfig))
@@ -1481,9 +1503,7 @@ static bool netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
 	bool set_address =3D (netconfig->rtm_protocol =3D=3D RTPROT_STATIC);
 =

-	if (netconfig->rtm_protocol =3D=3D RTPROT_DHCP &&
-			netconfig->fils_override &&
-			netconfig->fils_override->ipv4_addr) {
+	if (netconfig_use_fils_addr(netconfig, AF_INET)) {
 		L_AUTO_FREE_VAR(char *, addr_str) =3D netconfig_ipv4_to_string(
 					netconfig->fils_override->ipv4_addr);
 		uint8_t prefix_len =3D netconfig->fils_override->ipv4_prefix_len;
@@ -1569,9 +1589,7 @@ static bool netconfig_ipv6_select_and_install(struct =
netconfig *netconfig)
 =

 	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "0");
 =

-	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
-			netconfig->fils_override &&
-			!l_memeqzero(netconfig->fils_override->ipv6_addr, 16)) {
+	if (netconfig_use_fils_addr(netconfig, AF_INET6)) {
 		uint8_t prefix_len =3D netconfig->fils_override->ipv6_prefix_len;
 		L_AUTO_FREE_VAR(char *, addr_str) =3D netconfig_ipv6_to_string(
 					netconfig->fils_override->ipv6_addr);
-- =

2.32.0

--===============1421841197806755684==--

