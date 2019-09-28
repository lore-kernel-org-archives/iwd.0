Content-Type: multipart/mixed; boundary="===============4877171866109279925=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 05/14] netconfig: Switch to internal active network settings
Date: Fri, 27 Sep 2019 17:12:24 -0700
Message-ID: <20190928001233.19217-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4877171866109279925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As part of the de-coupling from station object, switch all of
the network settings inquiries to use active_settings. active_settings
are set with netconfig_configure by the owner of netconfig object
and removed with netconfig_reset once network disconnects.
---
 src/netconfig.c | 46 +++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 88d2588e..4e294512 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -113,29 +113,11 @@ static struct netconfig *netconfig_find(uint32_t ifin=
dex)
 	return NULL;
 }
 =

-static struct l_settings *netconfig_get_connected_network_settings(
-						struct netconfig *netconfig)
-{
-	struct station *station;
-	const struct network *network;
-
-	station =3D station_find(netconfig->ifindex);
-	if (!station)
-		return NULL;
-
-	network =3D station_get_connected_network(station);
-	if (!network)
-		return NULL;
-
-	return network_get_settings(network);
-}
-
 static struct netconfig_ifaddr *netconfig_ipv4_get_ifaddr(
 						struct netconfig *netconfig,
 						uint8_t proto)
 {
 	const struct l_dhcp_lease *lease;
-	const struct l_settings *settings;
 	struct netconfig_ifaddr *ifaddr;
 	struct in_addr in_addr;
 	char *netmask;
@@ -143,18 +125,17 @@ static struct netconfig_ifaddr *netconfig_ipv4_get_if=
addr(
 =

 	switch (proto) {
 	case RTPROT_STATIC:
-		settings =3D netconfig_get_connected_network_settings(netconfig);
-		if (!settings)
-			return NULL;
 =

-		ip =3D l_settings_get_string(settings, "IPv4", "ip");
+		ip =3D l_settings_get_string(netconfig->active_settings, "IPv4",
+									"ip");
 		if (!ip)
 			return NULL;
 =

 		ifaddr =3D l_new(struct netconfig_ifaddr, 1);
 		ifaddr->ip =3D ip;
 =

-		netmask =3D l_settings_get_string(settings, "IPv4", "netmask");
+		netmask =3D l_settings_get_string(netconfig->active_settings,
+							"IPv4", "netmask");
 		if (netmask && inet_pton(AF_INET, netmask, &in_addr) > 0)
 			ifaddr->prefix_len =3D __builtin_popcountl(
 						L_BE32_TO_CPU(in_addr.s_addr));
@@ -163,8 +144,9 @@ static struct netconfig_ifaddr *netconfig_ipv4_get_ifad=
dr(
 =

 		l_free(netmask);
 =

-		ifaddr->broadcast =3D l_settings_get_string(settings, "IPv4",
-								"broadcast");
+		ifaddr->broadcast =3D
+			l_settings_get_string(netconfig->active_settings,
+							"IPv4", "broadcast");
 		ifaddr->family =3D AF_INET;
 =

 		return ifaddr;
@@ -203,15 +185,12 @@ static struct netconfig_ifaddr *netconfig_ipv4_get_if=
addr(
 static char *netconfig_ipv4_get_gateway(struct netconfig *netconfig)
 {
 	const struct l_dhcp_lease *lease;
-	const struct l_settings *settings;
 =

 	switch (netconfig->rtm_protocol) {
 	case RTPROT_STATIC:
-		settings =3D netconfig_get_connected_network_settings(netconfig);
-		if (!settings)
-			return NULL;
 =

-		return l_settings_get_string(settings, "IPv4", "gateway");
+		return l_settings_get_string(netconfig->active_settings,
+							"IPv4", "gateway");
 =

 	case RTPROT_DHCP:
 		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
@@ -227,15 +206,12 @@ static char *netconfig_ipv4_get_gateway(struct netcon=
fig *netconfig)
 static char **netconfig_ipv4_get_dns(struct netconfig *netconfig, uint8_t =
proto)
 {
 	const struct l_dhcp_lease *lease;
-	const struct l_settings *settings;
 =

 	switch (proto) {
 	case RTPROT_STATIC:
-		settings =3D netconfig_get_connected_network_settings(netconfig);
-		if (!settings)
-			return NULL;
 =

-		return l_settings_get_string_list(settings, "IPv4", "dns", ' ');
+		return l_settings_get_string_list(netconfig->active_settings,
+							"IPv4", "dns", ' ');
 =

 	case RTPROT_DHCP:
 		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
-- =

2.13.6

--===============4877171866109279925==--

