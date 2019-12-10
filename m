Content-Type: multipart/mixed; boundary="===============3220677142074777348=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/6] netconfig: Use CamelCase for IPv4 address settings
Date: Tue, 10 Dec 2019 15:38:32 -0800
Message-ID: <20191210233837.1499-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3220677142074777348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 9d32c37a..df9d7ce4 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -131,15 +131,24 @@ static struct netconfig_ifaddr *netconfig_ipv4_get_if=
addr(
 	case RTPROT_STATIC:
 =

 		ip =3D l_settings_get_string(netconfig->active_settings, "IPv4",
-									"ip");
-		if (!ip)
-			return NULL;
+								"Address");
+		if (!ip) {
+			ip =3D l_settings_get_string(netconfig->active_settings,
+							"IPv4", "ip");
+			if (!ip)
+				return NULL;
+		}
 =

 		ifaddr =3D l_new(struct netconfig_ifaddr, 1);
 		ifaddr->ip =3D ip;
 =

 		netmask =3D l_settings_get_string(netconfig->active_settings,
-							"IPv4", "netmask");
+							"IPv4", "Netmask");
+		if (!netmask)
+			netmask =3D l_settings_get_string(
+						netconfig->active_settings,
+						"IPv4", "netmask");
+
 		if (netmask && inet_pton(AF_INET, netmask, &in_addr) > 0)
 			ifaddr->prefix_len =3D __builtin_popcountl(
 						L_BE32_TO_CPU(in_addr.s_addr));
@@ -150,7 +159,13 @@ static struct netconfig_ifaddr *netconfig_ipv4_get_ifa=
ddr(
 =

 		ifaddr->broadcast =3D
 			l_settings_get_string(netconfig->active_settings,
-							"IPv4", "broadcast");
+							"IPv4", "Broadcast");
+		if (!ifaddr->broadcast)
+			ifaddr->broadcast =3D
+				l_settings_get_string(
+						netconfig->active_settings,
+						"IPv4", "broadcast");
+
 		ifaddr->family =3D AF_INET;
 =

 		return ifaddr;
-- =

2.13.6

--===============3220677142074777348==--

