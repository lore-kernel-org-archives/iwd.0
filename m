Content-Type: multipart/mixed; boundary="===============5113803572515985381=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] netconfig: Add IPv4 domain name helper and installer
Date: Mon, 09 Dec 2019 15:28:04 -0800
Message-ID: <20191209232805.2873-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5113803572515985381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The provided domain name helper allows to override the DHCP lease
option value with the static one from network configuration file.
---
 src/netconfig.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 9d32c37a..9f0127ac 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -251,6 +251,28 @@ static char **netconfig_ipv4_get_dns(struct netconfig =
*netconfig, uint8_t proto)
 	return NULL;
 }
 =

+static char *netconfig_ipv4_get_domain_name(struct netconfig *netconfig,
+								uint8_t proto)
+{
+	const struct l_dhcp_lease *lease;
+	char *domain_name;
+
+	domain_name =3D l_settings_get_string(netconfig->active_settings,
+							"IPv4", "domain_name");
+	if (domain_name)
+		/* Allow to override the DHCP domain name with setting entry. */
+		return domain_name;
+
+	if (proto !=3D RTPROT_DHCP)
+		return NULL;
+
+	lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
+	if (!lease)
+		return NULL;
+
+	return l_dhcp_lease_get_domain_name(lease);
+}
+
 static struct netconfig_ifaddr *netconfig_ipv6_get_ifaddr(
 						struct netconfig *netconfig,
 						uint8_t proto)
@@ -685,6 +707,7 @@ static void netconfig_ipv4_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 	struct netconfig *netconfig =3D user_data;
 	struct netconfig_ifaddr *ifaddr;
 	char **dns;
+	char *domain_name;
 =

 	if (error && error !=3D -EEXIST) {
 		l_error("netconfig: Failed to add IP address. "
@@ -709,12 +732,21 @@ static void netconfig_ipv4_ifaddr_add_cmd_cb(int erro=
r, uint16_t type,
 	dns =3D netconfig_ipv4_get_dns(netconfig, netconfig->rtm_protocol);
 	if (!dns) {
 		l_error("netconfig: Failed to obtain DNS addresses.");
-		goto done;
+		goto domain_name;
 	}
 =

 	resolve_add_dns(netconfig->ifindex, ifaddr->family, dns);
 	l_strv_free(dns);
 =

+domain_name:
+	domain_name =3D netconfig_ipv4_get_domain_name(netconfig,
+						netconfig->rtm_protocol);
+	if (!domain_name)
+		goto done;
+
+	resolve_add_domain_name(netconfig->ifindex, domain_name);
+	l_free(domain_name);
+
 done:
 	netconfig_ifaddr_destroy(ifaddr);
 }
-- =

2.13.6

--===============5113803572515985381==--

