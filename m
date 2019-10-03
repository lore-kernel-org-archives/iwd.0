Content-Type: multipart/mixed; boundary="===============2378465647545596383=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/2] netconfig: Allow to override IPv6 DHCP DNSs with static
 addresses
Date: Thu, 03 Oct 2019 13:48:51 -0700
Message-ID: <20191003204851.9781-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191003204851.9781-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2378465647545596383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 51d06ce1..7513c5b9 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -346,23 +346,14 @@ static char **netconfig_ipv6_get_dns(struct netconfig=
 *netconfig, uint8_t proto)
 	char **dns_list;
 	char **p;
 =

-	switch (proto) {
-	case RTPROT_STATIC:
-		p =3D dns_list =3D
-			l_settings_get_string_list(netconfig->active_settings,
+	p =3D dns_list =3D l_settings_get_string_list(netconfig->active_settings,
 							"IPv6", "dns", ' ');
-
-		if (!dns_list || !*dns_list) {
-			l_strv_free(dns_list);
-
-			return NULL;
-		}
-
+	if (dns_list && *dns_list) {
 		for (; *p; p++) {
 			if (inet_pton(AF_INET6, *p, &in6_addr) =3D=3D 1)
 				continue;
 =

-			l_error("netconfig: Invalid IPv6 DNS address %s is "
+			l_error("netconfig: Invalid IPv6 DNS address '%s' is "
 				"provided in network configuration file.", *p);
 =

 			l_strv_free(dns_list);
@@ -370,9 +361,18 @@ static char **netconfig_ipv6_get_dns(struct netconfig =
*netconfig, uint8_t proto)
 			return NULL;
 		}
 =

+		/* Allow to override the DHCP DNSs with static addressing. */
 		return dns_list;
+	} else if (dns_list) {
+		l_error("netconfig: No IPv6 DNS address is provided in network "
+							"configuration file.");
 =

-	case RTPROT_DHCP:
+		l_strv_free(dns_list);
+
+		return NULL;
+	}
+
+	if (proto =3D=3D RTPROT_DHCP) {
 		/* TODO */
 =

 		return NULL;
-- =

2.13.6

--===============2378465647545596383==--

