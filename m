Content-Type: multipart/mixed; boundary="===============5016974730288651686=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/6] netconfig: Use CamelCase for IPv4 DNS setting
Date: Tue, 10 Dec 2019 15:38:34 -0800
Message-ID: <20191210233837.1499-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191210233837.1499-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5016974730288651686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 0d5f9464..58a08b35 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -233,12 +233,18 @@ static char **netconfig_ipv4_get_dns(struct netconfig=
 *netconfig, uint8_t proto)
 	const struct l_dhcp_lease *lease;
 	struct in_addr in_addr;
 	char **dns_list;
-	char **p;
 =

-	p =3D dns_list =3D l_settings_get_string_list(netconfig->active_settings,
-							"IPv4", "dns", ' ');
+	dns_list =3D l_settings_get_string_list(netconfig->active_settings,
+							"IPv4", "DNS", ' ');
+	if (!dns_list)
+		dns_list =3D l_settings_get_string_list(
+						netconfig->active_settings,
+						"IPv4", "dns", ' ');
+
 	if (dns_list && *dns_list) {
-		for (; *p; p++) {
+		char **p;
+
+		for (p =3D dns_list; *p; p++) {
 			if (inet_pton(AF_INET, *p, &in_addr) =3D=3D 1)
 				continue;
 =

-- =

2.13.6

--===============5016974730288651686==--

