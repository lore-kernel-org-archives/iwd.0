Content-Type: multipart/mixed; boundary="===============1130932608956709771=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 02/12] netconfig: Cache the IPv6 l_rtnl_address object
Date: Thu, 21 Oct 2021 10:50:31 +0200
Message-ID: <20211021085041.294524-2-andrew.zaborowski@intel.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============1130932608956709771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For symmetry with netconfig->v4_address add a netconfig->v6_address
so that we can track what the current address is at any time.
---
 src/netconfig.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 833fd3ab..13c8c9b7 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -58,6 +58,7 @@ struct netconfig {
 	uint8_t rtm_protocol;
 	uint8_t rtm_v6_protocol;
 	struct l_rtnl_address *v4_address;
+	struct l_rtnl_address *v6_address;
 	char **dns4_overrides;
 	char **dns6_overrides;
 	char *mdns;
@@ -131,6 +132,8 @@ static void netconfig_free_settings(struct netconfig *n=
etconfig)
 {
 	l_rtnl_address_free(netconfig->v4_address);
 	netconfig->v4_address =3D NULL;
+	l_rtnl_address_free(netconfig->v6_address);
+	netconfig->v6_address =3D NULL;
 =

 	l_strfreev(netconfig->dns4_overrides);
 	netconfig->dns4_overrides =3D NULL;
@@ -1031,13 +1034,28 @@ static void netconfig_dhcp6_event_handler(struct l_=
dhcp6_client *client,
 	case L_DHCP6_CLIENT_EVENT_IP_CHANGED:
 	case L_DHCP6_CLIENT_EVENT_LEASE_OBTAINED:
 	case L_DHCP6_CLIENT_EVENT_LEASE_RENEWED:
+	{
+		const struct l_dhcp6_lease *lease =3D
+			l_dhcp6_client_get_lease(netconfig->dhcp6_client);
+		_auto_(l_free) char *addr_str =3D
+			l_dhcp6_lease_get_address(lease);
+		struct l_rtnl_address *address;
+
+		address =3D l_rtnl_address_new(addr_str,
+					l_dhcp6_lease_get_prefix_length(lease));
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D address;
+
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
 		break;
+	}
 	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
 		l_debug("Lease for interface %u expired", netconfig->ifindex);
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D NULL;
 =

 		/* Fall through */
 	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
@@ -1187,7 +1205,6 @@ static bool netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 static bool netconfig_ipv6_select_and_install(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-	struct l_rtnl_address *address =3D NULL;
 =

 	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_UNSPEC) {
 		l_debug("IPV6 configuration disabled");
@@ -1196,10 +1213,7 @@ static bool netconfig_ipv6_select_and_install(struct=
 netconfig *netconfig)
 =

 	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "0");
 =

-	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC)
-		address =3D netconfig_get_static6_address(
-						netconfig->active_settings);
-	else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
+	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
 			netconfig->fils_override &&
 			!l_memeqzero(netconfig->fils_override->ipv6_addr, 16)) {
 		uint8_t prefix_len =3D netconfig->fils_override->ipv6_prefix_len;
@@ -1209,11 +1223,12 @@ static bool netconfig_ipv6_select_and_install(struc=
t netconfig *netconfig)
 		if (unlikely(!addr_str))
 			return false;
 =

-		if (L_WARN_ON(unlikely(!(address =3D l_rtnl_address_new(addr_str,
-								prefix_len)))))
+		netconfig->v6_address =3D l_rtnl_address_new(addr_str,
+								prefix_len);
+		if (L_WARN_ON(unlikely(!netconfig->v6_address)))
 			return false;
 =

-		l_rtnl_address_set_noprefixroute(address, true);
+		l_rtnl_address_set_noprefixroute(netconfig->v6_address, true);
 =

 		/*
 		 * TODO: If netconfig->fils_override->ipv6_lifetime is set,
@@ -1223,12 +1238,12 @@ static bool netconfig_ipv6_select_and_install(struc=
t netconfig *netconfig)
 		 */
 	}
 =

-	if (address) {
+	if (netconfig->v6_address) {
 		L_WARN_ON(!(netconfig->addr6_add_cmd_id =3D
-			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex, address,
+			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
+					netconfig->v6_address,
 					netconfig_ipv6_ifaddr_add_cmd_cb,
 					netconfig, NULL)));
-		l_rtnl_address_free(address);
 		return true;
 	}
 =

@@ -1345,7 +1360,6 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 =

 	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
 		v6_address =3D netconfig_get_static6_address(active_settings);
-		l_rtnl_address_free(v6_address);
 =

 		if (unlikely(!v6_address)) {
 			l_error("netconfig: Can't parse IPv6 address");
@@ -1371,6 +1385,9 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 	if (netconfig->rtm_protocol =3D=3D RTPROT_STATIC)
 		netconfig->v4_address =3D v4_address;
 =

+	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC)
+		netconfig->v6_address =3D v6_address;
+
 	netconfig->active_settings =3D active_settings;
 	netconfig->dns4_overrides =3D dns4_overrides;
 	netconfig->dns6_overrides =3D dns6_overrides;
@@ -1457,6 +1474,9 @@ bool netconfig_reset(struct netconfig *netconfig)
 	netconfig_reset_v4(netconfig);
 =

 	if (netconfig->rtm_v6_protocol) {
+		l_rtnl_address_free(netconfig->v6_address);
+		netconfig->v6_address =3D NULL;
+
 		l_strfreev(netconfig->dns6_overrides);
 		netconfig->dns6_overrides =3D NULL;
 =

-- =

2.32.0

--===============1130932608956709771==--

