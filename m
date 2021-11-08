Content-Type: multipart/mixed; boundary="===============6333507091170156451=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 2/9] netconfig: Move FILS override checks to common functions
Date: Mon, 08 Nov 2021 12:28:31 +0100
Message-ID: <20211108112838.372416-2-andrew.zaborowski@intel.com>
In-Reply-To: 20211108112838.372416-1-andrew.zaborowski@intel.com

--===============6333507091170156451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 56 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index ea77e818..885e34a8 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -189,6 +189,36 @@ static inline char *netconfig_ipv6_to_string(const uin=
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
@@ -472,7 +502,7 @@ static char *netconfig_ipv4_get_gateway(struct netconfi=
g *netconfig,
 		return gateway;
 =

 	case RTPROT_DHCP:
-		if (fils && fils->ipv4_gateway) {
+		if (netconfig_use_fils_gateway(netconfig, AF_INET)) {
 			gateway =3D netconfig_ipv4_to_string(fils->ipv4_gateway);
 =

 			if (gateway && out_mac &&
@@ -540,10 +570,7 @@ static struct l_rtnl_route *netconfig_get_static6_gate=
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

@@ -711,8 +738,7 @@ static void netconfig_ifaddr_ipv6_added(struct netconfi=
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
@@ -1089,9 +1115,7 @@ static void netconfig_set(struct netconfig *netconfig=
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

@@ -1137,9 +1161,7 @@ static void netconfig_set(struct netconfig *netconfig=
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
@@ -1450,9 +1472,7 @@ static bool netconfig_ipv4_select_and_install(struct =
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
@@ -1538,9 +1558,7 @@ static bool netconfig_ipv6_select_and_install(struct =
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

--===============6333507091170156451==--

