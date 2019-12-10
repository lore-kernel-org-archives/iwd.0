Content-Type: multipart/mixed; boundary="===============2037867876782354904=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 6/6] netconfig: Use CamelCase for IPv6 DNS setting
Date: Tue, 10 Dec 2019 15:38:37 -0800
Message-ID: <20191210233837.1499-6-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191210233837.1499-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2037867876782354904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index d91f4120..c7e9f934 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -382,12 +382,19 @@ static char **netconfig_ipv6_get_dns(struct netconfig=
 *netconfig, uint8_t proto)
 {
 	struct in6_addr in6_addr;
 	char **dns_list;
-	char **p;
 =

-	p =3D dns_list =3D l_settings_get_string_list(netconfig->active_settings,
-							"IPv6", "dns", ' ');
+	dns_list =3D l_settings_get_string_list(netconfig->active_settings,
+							"IPv6", "DNS", ' ');
+
+	if (!dns_list)
+		dns_list =3D l_settings_get_string_list(
+						netconfig->active_settings,
+						"IPv6", "dns", ' ');
+
 	if (dns_list && *dns_list) {
-		for (; *p; p++) {
+		char **p;
+
+		for (p =3D dns_list; *p; p++) {
 			if (inet_pton(AF_INET6, *p, &in6_addr) =3D=3D 1)
 				continue;
 =

-- =

2.13.6

--===============2037867876782354904==--

