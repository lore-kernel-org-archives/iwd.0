Content-Type: multipart/mixed; boundary="===============0675407400124534502=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v3 3/5] netconfig: Add IPv6 static address installation/removal
Date: Tue, 01 Oct 2019 09:31:22 -0700
Message-ID: <20191001163124.1179-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191001163124.1179-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0675407400124534502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The network configuration options for IPv6 are grouped under [IPv6]
and include the following:
	ip=3D ADDRESS/PREFIX
	gateway=3DADDRESS
	dns=3DADDRESS

The placeholders for DHCPv6 are placed along the way and marked
as TODO items.
---
 src/netconfig.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 163 insertions(+), 9 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index be710ebb..87edd0a8 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -48,6 +48,7 @@ struct netconfig {
 	struct l_dhcp_client *dhcp_client;
 	struct l_queue *ifaddr_list;
 	uint8_t rtm_protocol;
+	uint8_t rtm_v6_protocol;
 =

 	const struct l_settings *active_settings;
 };
@@ -224,6 +225,70 @@ static char **netconfig_ipv4_get_dns(struct netconfig =
*netconfig, uint8_t proto)
 	return NULL;
 }
 =

+static struct netconfig_ifaddr *netconfig_ipv6_get_ifaddr(
+						struct netconfig *netconfig,
+						uint8_t proto)
+{
+	struct in6_addr in6_addr;
+	struct netconfig_ifaddr *ifaddr;
+	char *ip;
+	char *p;
+
+	switch (proto) {
+	case RTPROT_STATIC:
+		if (!netconfig->active_settings)
+			return NULL;
+
+		ip =3D l_settings_get_string(netconfig->active_settings, "IPv6",
+									"ip");
+		if (!ip)
+			return NULL;
+
+		ifaddr =3D l_new(struct netconfig_ifaddr, 1);
+		ifaddr->ip =3D ip;
+
+		p =3D strrchr(ifaddr->ip, '/');
+		if (!p)
+			goto no_prefix_len;
+
+		*p =3D '\0';
+
+		if (inet_pton(AF_INET6, ifaddr->ip, &in6_addr) < 1) {
+			l_error("netconfig: Invalid IPv6 address %s is "
+				"provided in network configuration file.",
+				ifaddr->ip);
+
+			netconfig_ifaddr_destroy(ifaddr);
+
+			return NULL;
+		}
+
+		if (*++p =3D=3D '\0')
+			goto no_prefix_len;
+
+		ifaddr->prefix_len =3D strtoul(p, NULL, 10);
+
+		if (!unlikely(errno =3D=3D EINVAL || errno =3D=3D ERANGE ||
+				!ifaddr->prefix_len ||
+				ifaddr->prefix_len > 128))
+			goto proceed;
+
+no_prefix_len:
+		ifaddr->prefix_len =3D 128;
+proceed:
+		ifaddr->family =3D AF_INET6;
+
+		return ifaddr;
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
@@ -540,6 +605,19 @@ done:
 	netconfig_ifaddr_destroy(ifaddr);
 }
 =

+static void netconfig_ipv6_ifaddr_add_cmd_cb(int error, uint16_t type,
+						const void *data, uint32_t len,
+						void *user_data)
+{
+	if (error && error !=3D -EEXIST) {
+		l_error("netconfig: Failed to add IPv6 address. "
+				"Error %d: %s", error, strerror(-error));
+		return;
+	}
+
+	/* TODO Install routes and DNS */
+}
+
 static void netconfig_install_address(struct netconfig *netconfig,
 						struct netconfig_ifaddr *ifaddr)
 {
@@ -559,6 +637,16 @@ static void netconfig_install_address(struct netconfig=
 *netconfig,
 		l_error("netconfig: Failed to set IP %s/%u.", ifaddr->ip,
 							ifaddr->prefix_len);
 		break;
+	case AF_INET6:
+		if (rtnl_ifaddr_ipv6_add(rtnl, netconfig->ifindex,
+					ifaddr->prefix_len, ifaddr->ip,
+					netconfig_ipv6_ifaddr_add_cmd_cb,
+					netconfig, NULL))
+			return;
+
+		l_error("netconfig: Failed to set IPv6 address %s/%u.",
+					ifaddr->ip, ifaddr->prefix_len);
+		break;
 	default:
 		l_error("netconfig: Unsupported address family: %u",
 								ifaddr->family);
@@ -605,6 +693,16 @@ static void netconfig_uninstall_address(struct netconf=
ig *netconfig,
 		l_error("netconfig: Failed to delete IP %s/%u.",
 						ifaddr->ip, ifaddr->prefix_len);
 		break;
+	case AF_INET6:
+		if (rtnl_ifaddr_ipv6_delete(rtnl, netconfig->ifindex,
+					ifaddr->prefix_len, ifaddr->ip,
+					netconfig_ifaddr_del_cmd_cb, netconfig,
+					NULL))
+			return;
+
+		l_error("netconfig: Failed to delete IPv6 address %s/%u.",
+						ifaddr->ip, ifaddr->prefix_len);
+		break;
 	default:
 		l_error("netconfig: Unsupported address family: %u",
 								ifaddr->family);
@@ -725,6 +823,51 @@ static void netconfig_ipv4_select_and_uninstall(struct=
 netconfig *netconfig)
 	l_dhcp_client_stop(netconfig->dhcp_client);
 }
 =

+static void netconfig_ipv6_select_and_install(struct netconfig *netconfig)
+{
+	struct netconfig_ifaddr *ifaddr;
+
+	ifaddr =3D netconfig_ipv6_get_ifaddr(netconfig, RTPROT_STATIC);
+	if (ifaddr) {
+		netconfig->rtm_v6_protocol =3D RTPROT_STATIC;
+		netconfig_install_address(netconfig, ifaddr);
+		netconfig_ifaddr_destroy(ifaddr);
+
+		return;
+	}
+
+	/*
+	 *      TODO
+	 *
+	 *      netconfig->rtm_v6_protocol =3D RTPROT_DHCP;
+	 *
+	 *      netconfig_ipv6_dhcp_set_mac_address(netconfig);
+	 *
+	 *      if (l_dhcp_v6_client_start(netconfig->l_dhcp_v6_client))
+	 *            return;
+	 *
+	 *      l_error("netconfig: Failed to start DHCPv6 client for "
+	 *                  "interface %u", netconfig->ifindex);
+	 */
+}
+
+static void netconfig_ipv6_select_and_uninstall(struct netconfig *netconfi=
g)
+{
+	struct netconfig_ifaddr *ifaddr;
+
+	ifaddr =3D netconfig_ipv6_get_ifaddr(netconfig,
+						netconfig->rtm_v6_protocol);
+	if (ifaddr) {
+		netconfig_uninstall_address(netconfig, ifaddr);
+		netconfig_ifaddr_destroy(ifaddr);
+	}
+
+	/*
+	 * TODO
+	 * l_dhcp_v6_client_stop(netconfig->l_dhcp_v6_client);
+	 */
+}
+
 bool netconfig_configure(struct netconfig *netconfig,
 				const struct l_settings *active_settings,
 				const uint8_t *mac_address)
@@ -736,7 +879,7 @@ bool netconfig_configure(struct netconfig *netconfig,
 =

 	netconfig_ipv4_select_and_install(netconfig);
 =

-	/* TODO: IPv6 addressing */
+	netconfig_ipv6_select_and_install(netconfig);
 =

 	return true;
 }
@@ -749,13 +892,23 @@ bool netconfig_reconfigure(struct netconfig *netconfi=
g)
 		 * TODO l_dhcp_client to try to request a
 		 * previously used address.
 		 *
-		 * return;
+		 * goto ipv6;
 		 */
 	}
 =

 	netconfig_ipv4_select_and_install(netconfig);
 =

-	/* TODO: IPv6 addressing */
+	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
+		/*
+		 *
+		 * TODO l_dhcp_v6_client to try to request a
+		 * previously used address.
+		 *
+		 * return
+		 */
+	}
+
+	netconfig_ipv6_select_and_install(netconfig);
 =

 	return true;
 }
@@ -763,13 +916,13 @@ bool netconfig_reconfigure(struct netconfig *netconfi=
g)
 bool netconfig_reset(struct netconfig *netconfig)
 {
 	netconfig_ipv4_select_and_uninstall(netconfig);
+	netconfig->rtm_protocol =3D 0;
 =

-	/* TODO: IPv6 addressing */
+	netconfig_ipv6_select_and_uninstall(netconfig);
+	netconfig->rtm_v6_protocol =3D 0;
 =

 	resolve_remove(netconfig->ifindex);
 =

-	netconfig->rtm_protocol =3D 0;
-
 	return true;
 }
 =

@@ -806,13 +959,14 @@ void netconfig_destroy(struct netconfig *netconfig)
 =

 	l_queue_remove(netconfig_list, netconfig);
 =

-	if (netconfig->rtm_protocol) {
+	if (netconfig->rtm_protocol)
 		netconfig_ipv4_select_and_uninstall(netconfig);
 =

-		/* TODO Uninstall IPv6 addresses. */
+	if (netconfig->rtm_v6_protocol)
+		netconfig_ipv6_select_and_uninstall(netconfig);
 =

+	if (netconfig->rtm_protocol || netconfig->rtm_v6_protocol)
 		resolve_remove(netconfig->ifindex);
-	}
 =

 	netconfig_free(netconfig);
 }
-- =

2.13.6

--===============0675407400124534502==--

