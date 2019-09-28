Content-Type: multipart/mixed; boundary="===============8784100939798000212=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 11/14] netconfig: Add IPv6 static address
 installation/removal
Date: Fri, 27 Sep 2019 17:12:30 -0700
Message-ID: <20190928001233.19217-11-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8784100939798000212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The placeholders for DHCPv6 are placed along the way and marked
as TODO items.
---
 src/netconfig.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 152 insertions(+), 9 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 6f97eed5..14aac28f 100644
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
@@ -224,6 +225,59 @@ static char **netconfig_ipv4_get_dns(struct netconfig =
*netconfig, uint8_t proto)
 	return NULL;
 }
 =

+static struct netconfig_ifaddr *netconfig_ipv6_get_ifaddr(
+						struct netconfig *netconfig,
+						uint8_t proto)
+{
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
+		if (*++p =3D=3D '\0')
+			goto no_prefix_len;
+
+		ifaddr->prefix_len =3D strtoul(p, NULL, 10);
+
+		p =3D strrchr(ifaddr->ip, '/');
+		*p =3D '\0';
+
+		if (!unlikely(errno =3D=3D ERANGE || !ifaddr->prefix_len ||
+					ifaddr->prefix_len > 128))
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
 static struct netconfig_ifaddr *netconfig_ifaddr_find(
 					const struct netconfig *netconfig,
 					uint8_t family, uint8_t prefix_len,
@@ -523,6 +577,19 @@ done:
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
@@ -542,6 +609,16 @@ static void netconfig_install_address(struct netconfig=
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
@@ -588,6 +665,16 @@ static void netconfig_uninstall_address(struct netconf=
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
@@ -708,6 +795,51 @@ static void netconfig_ipv4_select_and_uninstall(struct=
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
+	 * 	TODO
+	 *
+	 *      netconfig->rtm_v6_protocol =3D RTPROT_DHCP;
+	 *
+	 *      netconfig_ipv6_dhcp_set_mac_address(netconfig);
+	 *
+	 *	if (l_dhcp_v6_client_start(netconfig->l_dhcp_v6_client))
+	 *		return;
+	 *
+	 * 	l_error("netconfig: Failed to start DHCPv6 client for "
+	 *			"interface %u", netconfig->ifindex);
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
+	 * l_dhcp_v6_client_start(netconfig->l_dhcp_v6_client);
+	 */
+}
+
 bool netconfig_configure(struct netconfig *netconfig,
 				const struct l_settings *active_settings,
 				const uint8_t *mac_address)
@@ -719,7 +851,7 @@ bool netconfig_configure(struct netconfig *netconfig,
 =

 	netconfig_ipv4_select_and_install(netconfig);
 =

-	/* TODO: IPv6 addressing */
+	netconfig_ipv6_select_and_install(netconfig);
 =

 	return true;
 }
@@ -732,13 +864,23 @@ bool netconfig_reconfigure(struct netconfig *netconfi=
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
@@ -746,13 +888,13 @@ bool netconfig_reconfigure(struct netconfig *netconfi=
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

@@ -789,13 +931,14 @@ void netconfig_destroy(struct netconfig *netconfig)
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

--===============8784100939798000212==--

