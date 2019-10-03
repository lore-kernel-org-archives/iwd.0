Content-Type: multipart/mixed; boundary="===============0463221471941974901=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] netconfig: Allow to override IPv4 DHCP DNSs with static
 addresses
Date: Thu, 03 Oct 2019 13:48:50 -0700
Message-ID: <20191003204851.9781-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0463221471941974901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 285d5fef..51d06ce1 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -207,14 +207,37 @@ static char *netconfig_ipv4_get_gateway(struct netcon=
fig *netconfig)
 static char **netconfig_ipv4_get_dns(struct netconfig *netconfig, uint8_t =
proto)
 {
 	const struct l_dhcp_lease *lease;
+	struct in_addr in_addr;
+	char **dns_list;
+	char **p;
 =

-	switch (proto) {
-	case RTPROT_STATIC:
-
-		return l_settings_get_string_list(netconfig->active_settings,
+	p =3D dns_list =3D l_settings_get_string_list(netconfig->active_settings,
 							"IPv4", "dns", ' ');
+	if (dns_list && *dns_list) {
+		for (; *p; p++) {
+			if (inet_pton(AF_INET, *p, &in_addr) =3D=3D 1)
+				continue;
 =

-	case RTPROT_DHCP:
+			l_error("netconfig: Invalid IPv4 DNS address '%s' is "
+				"provided in network configuration file.", *p);
+
+			l_strv_free(dns_list);
+
+			return NULL;
+		}
+
+		/* Allow to override the DHCP DNSs with static addressing. */
+		return dns_list;
+	} else if (dns_list) {
+		l_error("netconfig: No IPv4 DNS address is provided in network "
+							"configuration file.");
+
+		l_strv_free(dns_list);
+
+		return NULL;
+	}
+
+	if (proto =3D=3D RTPROT_DHCP) {
 		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
 		if (!lease)
 			return NULL;
@@ -662,9 +685,7 @@ static void netconfig_ipv4_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 =

 	dns =3D netconfig_ipv4_get_dns(netconfig, netconfig->rtm_protocol);
 	if (!dns) {
-		l_error("netconfig: Failed to obtain DNS addresses from %s.",
-				netconfig->rtm_protocol =3D=3D RTPROT_STATIC ?
-				"setting file" : "DHCPv4 lease");
+		l_error("netconfig: Failed to obtain DNS addresses.");
 		goto done;
 	}
 =

-- =

2.13.6

--===============0463221471941974901==--

