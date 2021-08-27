Content-Type: multipart/mixed; boundary="===============9093149649801086615=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] netconfig: Move loading settings to new method, refactor
Date: Fri, 27 Aug 2021 05:02:03 +0200
Message-ID: <20210827030207.353705-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9093149649801086615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split loading settings out of network_configure into a new method,
network_load_settings.  Make sure both consistently handle errors by
printing messages and informing the caller.
---
 src/netconfig.c | 236 ++++++++++++++++++++++++++++++------------------
 src/netconfig.h |   5 +-
 src/p2p.c       |  12 ++-
 src/station.c   |  20 ++--
 4 files changed, 175 insertions(+), 98 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 005316cd..10c9b90c 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -47,6 +47,7 @@
 #include "src/common.h"
 #include "src/network.h"
 #include "src/resolve.h"
+#include "src/util.h"
 #include "src/netconfig.h"
 =

 struct netconfig {
@@ -270,49 +271,47 @@ static int netconfig_set_domains(struct netconfig *ne=
tconfig)
 }
 =

 static struct l_rtnl_address *netconfig_get_static4_address(
-						struct netconfig *netconfig)
+				const struct l_settings *active_settings)
 {
 	struct l_rtnl_address *ifaddr =3D NULL;
-	char *ip;
-	char *netmask;
+	L_AUTO_FREE_VAR(char *, ip) =3D NULL;
+	L_AUTO_FREE_VAR(char *, netmask) =3D NULL;
 	struct in_addr in_addr;
-	char *broadcast;
+	L_AUTO_FREE_VAR(char *, broadcast) =3D NULL;
 	uint32_t prefix_len;
 =

-	ip =3D l_settings_get_string(netconfig->active_settings, "IPv4",
-								"Address");
+	ip =3D l_settings_get_string(active_settings, "IPv4", "Address");
 	if (!ip)
 		return NULL;
 =

-	netmask =3D l_settings_get_string(netconfig->active_settings,
-						"IPv4", "Netmask");
+	netmask =3D l_settings_get_string(active_settings, "IPv4", "Netmask");
+	if (netmask) {
+		if (inet_pton(AF_INET, netmask, &in_addr) !=3D 1) {
+			l_error("netconfig: Can't parse IPv4 Netmask");
+			return NULL;
+		}
 =

-	if (netmask && inet_pton(AF_INET, netmask, &in_addr) > 0)
 		prefix_len =3D __builtin_popcountl(in_addr.s_addr);
-	else
-		prefix_len =3D 24;
 =

-	l_free(netmask);
+		if (ntohl(in_addr.s_addr) !=3D
+				util_netmask_from_prefix(prefix_len)) {
+			l_error("netconfig: Invalid IPv4 Netmask");
+			return NULL;
+		}
+	} else
+		prefix_len =3D 24;
 =

 	ifaddr =3D l_rtnl_address_new(ip, prefix_len);
-	l_free(ip);
-
 	if (!ifaddr) {
-		l_error("Unable to parse IPv4.Address, ignoring...");
+		l_error("netconfig: Unable to parse IPv4.Address");
 		return NULL;
 	}
 =

-	broadcast =3D l_settings_get_string(netconfig->active_settings,
-						"IPv4", "Broadcast");
-	if (broadcast) {
-		bool r =3D l_rtnl_address_set_broadcast(ifaddr, broadcast);
-		l_free(broadcast);
-
-		if (!r) {
-			l_error("Unable to parse IPv4.Broadcast, ignoring...");
-			l_rtnl_address_free(ifaddr);
-			return NULL;
-		}
+	broadcast =3D l_settings_get_string(active_settings, "IPv4", "Broadcast");
+	if (broadcast && !l_rtnl_address_set_broadcast(ifaddr, broadcast)) {
+		l_error("netconfig: Unable to parse IPv4.Broadcast");
+		l_rtnl_address_free(ifaddr);
+		return NULL;
 	}
 =

 	l_rtnl_address_set_noprefixroute(ifaddr, true);
@@ -347,15 +346,14 @@ static char *netconfig_ipv4_get_gateway(struct netcon=
fig *netconfig)
 }
 =

 static struct l_rtnl_address *netconfig_get_static6_address(
-						struct netconfig *netconfig)
+				const struct l_settings *active_settings)
 {
 	L_AUTO_FREE_VAR(char *, ip);
 	char *p;
 	struct l_rtnl_address *ret;
 	uint32_t prefix_len =3D 128;
 =

-	ip =3D l_settings_get_string(netconfig->active_settings, "IPv6",
-								"Address");
+	ip =3D l_settings_get_string(active_settings, "IPv6", "Address");
 	if (!ip)
 		return NULL;
 =

@@ -898,14 +896,17 @@ static void netconfig_ipv4_acd_event(enum l_acd_event=
 event, void *user_data)
 	}
 }
 =

-static void netconfig_ipv4_select_and_install(struct netconfig *netconfig)
+static bool netconfig_ipv4_select_and_install(struct netconfig *netconfig)
 {
-	char ip[INET6_ADDRSTRLEN];
+	if (netconfig->rtm_protocol =3D=3D RTPROT_STATIC) {
+		char ip[INET6_ADDRSTRLEN];
+
+		if (L_WARN_ON(!netconfig->v4_address ||
+					!l_rtnl_address_get_address(
+							netconfig->v4_address,
+							ip)))
+			return false;
 =

-	netconfig->v4_address =3D netconfig_get_static4_address(netconfig);
-	if (netconfig->v4_address &&
-			l_rtnl_address_get_address(netconfig->v4_address, ip)) {
-		netconfig->rtm_protocol =3D RTPROT_STATIC;
 		netconfig->acd =3D l_acd_new(netconfig->ifindex);
 		l_acd_set_event_handler(netconfig->acd,
 					netconfig_ipv4_acd_event, netconfig,
@@ -926,47 +927,43 @@ static void netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 					netconfig, NULL)));
 		}
 =

-		return;
+		return true;
 	}
 =

-	netconfig->rtm_protocol =3D RTPROT_DHCP;
-
 	if (l_dhcp_client_start(netconfig->dhcp_client))
-		return;
+		return true;
 =

 	l_error("netconfig: Failed to start DHCPv4 client for interface %u",
 							netconfig->ifindex);
+	return false;
 }
 =

-static void netconfig_ipv6_select_and_install(struct netconfig *netconfig)
+static bool netconfig_ipv6_select_and_install(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-	struct l_rtnl_address *address;
-	bool enabled;
 =

-	if (!l_settings_get_bool(netconfig->active_settings, "IPv6",
-					"Enabled", &enabled))
-		enabled =3D ipv6_enabled;
-
-	if (!enabled) {
+	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_UNSPEC) {
 		l_debug("IPV6 configuration disabled");
-		return;
+		return true;
 	}
 =

 	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "0");
 =

-	address =3D netconfig_get_static6_address(netconfig);
-	if (address) {
-		netconfig->rtm_v6_protocol =3D RTPROT_STATIC;
+	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC) {
+		struct l_rtnl_address *address =3D
+			netconfig_get_static6_address(
+						netconfig->active_settings);
+
 		L_WARN_ON(!(netconfig->addr6_add_cmd_id =3D
 			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex, address,
 					netconfig_ipv6_ifaddr_add_cmd_cb,
 					netconfig, NULL)));
 		l_rtnl_address_free(address);
-		return;
+		return true;
 	}
 =

-	netconfig->rtm_v6_protocol =3D RTPROT_DHCP;
+	/* DHCP */
+	return true;
 }
 =

 static int validate_dns_list(int family, char **dns_list)
@@ -998,77 +995,144 @@ static int validate_dns_list(int family, char **dns_=
list)
 	return n_valid;
 }
 =

-bool netconfig_configure(struct netconfig *netconfig,
+bool netconfig_load_settings(struct netconfig *netconfig,
 				const struct l_settings *active_settings,
-				const uint8_t *mac_address,
-				netconfig_notify_func_t notify, void *user_data)
+				const uint8_t *mac_address)
 {
 	char *mdns;
-	char hostname[HOST_NAME_MAX + 1];
 	bool send_hostname;
+	bool v6_enabled;
+	char hostname[HOST_NAME_MAX + 1];
+	char **dns4_overrides =3D NULL;
+	char **dns6_overrides =3D NULL;
+	struct l_rtnl_address *v4_address =3D NULL;
+	struct l_rtnl_address *v6_address =3D NULL;
 =

-	netconfig->dns4_overrides =3D l_settings_get_string_list(active_settings,
+	dns4_overrides =3D l_settings_get_string_list(active_settings,
 							"IPv4", "DNS", ' ');
+	if (dns4_overrides) {
+		int r =3D validate_dns_list(AF_INET, dns4_overrides);
 =

-	if (netconfig->dns4_overrides) {
-		int r =3D validate_dns_list(AF_INET, netconfig->dns4_overrides);
+		if (unlikely(r <=3D 0)) {
+			l_strfreev(dns4_overrides);
+			dns4_overrides =3D NULL;
 =

-		if (r <=3D 0) {
-			l_strfreev(netconfig->dns4_overrides);
-			netconfig->dns4_overrides =3D NULL;
+			if (r < 0)
+				goto err_dns4;
 		}
 =

 		if (r =3D=3D 0)
 			l_error("netconfig: Empty IPv4.DNS entry, skipping...");
 	}
 =

-	netconfig->dns6_overrides =3D l_settings_get_string_list(active_settings,
+	dns6_overrides =3D l_settings_get_string_list(active_settings,
 							"IPv6", "DNS", ' ');
 =

-	if (netconfig->dns6_overrides) {
-		int r =3D validate_dns_list(AF_INET6, netconfig->dns6_overrides);
+	if (dns6_overrides) {
+		int r =3D validate_dns_list(AF_INET6, dns6_overrides);
+
+		if (unlikely(r <=3D 0)) {
+			l_strfreev(dns6_overrides);
+			dns6_overrides =3D NULL;
 =

-		if (r <=3D 0) {
-			l_strfreev(netconfig->dns6_overrides);
-			netconfig->dns6_overrides =3D NULL;
+			if (r < 0)
+				goto err_dns6;
 		}
 =

 		if (r =3D=3D 0)
 			l_error("netconfig: Empty IPv6.DNS entry, skipping...");
 	}
 =

-	netconfig->active_settings =3D active_settings;
-	netconfig->notify =3D notify;
-	netconfig->user_data =3D user_data;
-
-	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
-							mac_address, ETH_ALEN);
-	l_dhcp6_client_set_address(netconfig->dhcp6_client, ARPHRD_ETHER,
-							mac_address, ETH_ALEN);
-
 	if (!l_settings_get_bool(active_settings,
 					"IPv4", "SendHostname", &send_hostname))
 		send_hostname =3D false;
 =

 	if (send_hostname) {
-		if (gethostname(hostname, sizeof(hostname)) =3D=3D 0) {
-			l_dhcp_client_set_hostname(
-				netconfig->dhcp_client, hostname);
-		} else {
+		if (gethostname(hostname, sizeof(hostname)) !=3D 0) {
 			l_warn("netconfig: Unable to get hostname. "
 					"Error %d: %s", errno, strerror(errno));
+			send_hostname =3D false;
 		}
 	}
 =

-	netconfig_ipv4_select_and_install(netconfig);
+	mdns =3D l_settings_get_string(active_settings,
+					"Network", "MulticastDNS");
 =

-	netconfig_ipv6_select_and_install(netconfig);
+	if (l_settings_has_key(active_settings, "IPv4", "Address")) {
+		v4_address =3D netconfig_get_static4_address(active_settings);
+
+		if (unlikely(!v4_address)) {
+			l_error("netconfig: Can't parse IPv4 address");
+			goto err_v4_addr;
+		}
+	}
+
+	if (!l_settings_get_bool(active_settings, "IPv6",
+					"Enabled", &v6_enabled))
+		v6_enabled =3D ipv6_enabled;
+
+	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
+		v6_address =3D netconfig_get_static6_address(active_settings);
+		l_rtnl_address_free(v6_address);
+
+		if (unlikely(!v6_address)) {
+			l_error("netconfig: Can't parse IPv6 address");
+			goto err_v6_addr;
+		}
+	}
+
+	/* No more validation steps for now, commit new values */
+
+	if (v4_address) {
+		netconfig->v4_address =3D v4_address;
+		netconfig->rtm_protocol =3D RTPROT_STATIC;
+	} else
+		netconfig->rtm_protocol =3D RTPROT_DHCP;
+
+	if (!v6_enabled)
+		netconfig->rtm_v6_protocol =3D RTPROT_UNSPEC;
+	else if (v6_address)
+		netconfig->rtm_v6_protocol =3D RTPROT_STATIC;
+	else
+		netconfig->rtm_v6_protocol =3D RTPROT_DHCP;
+
+	if (send_hostname)
+		l_dhcp_client_set_hostname(netconfig->dhcp_client, hostname);
 =

-	mdns =3D l_settings_get_string(active_settings,
-						"Network", "MulticastDNS");
 	resolve_set_mdns(netconfig->resolve, mdns);
 	l_free(mdns);
 =

+	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
+							mac_address, ETH_ALEN);
+	l_dhcp6_client_set_address(netconfig->dhcp6_client, ARPHRD_ETHER,
+							mac_address, ETH_ALEN);
+
+	netconfig->active_settings =3D active_settings;
+	return true;
+
+err_v6_addr:
+	l_rtnl_address_free(v4_address);
+err_v4_addr:
+	l_free(mdns);
+	l_strfreev(dns6_overrides);
+err_dns6:
+	l_strfreev(dns4_overrides);
+err_dns4:
+	return false;
+}
+
+bool netconfig_configure(struct netconfig *netconfig,
+				netconfig_notify_func_t notify, void *user_data)
+{
+	netconfig->notify =3D notify;
+	netconfig->user_data =3D user_data;
+
+	if (unlikely(!netconfig_ipv4_select_and_install(netconfig)))
+		return false;
+
+	if (unlikely(!netconfig_ipv6_select_and_install(netconfig)))
+		return false;
+
 	return true;
 }
 =

diff --git a/src/netconfig.h b/src/netconfig.h
index 2c68cb1c..73e4df8b 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -29,9 +29,10 @@ enum netconfig_event {
 typedef void (*netconfig_notify_func_t)(enum netconfig_event event,
 							void *user_data);
 =

-bool netconfig_configure(struct netconfig *netconfig,
+bool netconfig_load_settings(struct netconfig *netconfig,
 				const struct l_settings *active_settings,
-				const uint8_t *mac_address,
+				const uint8_t *mac_address);
+bool netconfig_configure(struct netconfig *netconfig,
 				netconfig_notify_func_t notify,
 				void *user_data);
 bool netconfig_reconfigure(struct netconfig *netconfig);
diff --git a/src/p2p.c b/src/p2p.c
index 8170bbe0..3328271b 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1328,8 +1328,16 @@ static void p2p_start_client_netconfig(struct p2p_de=
vice *dev)
 	}
 =

 	settings =3D dev->conn_netconfig_settings ?: p2p_dhcp_settings;
-	netconfig_configure(dev->conn_netconfig, settings, dev->conn_addr,
-				p2p_netconfig_event_handler, dev);
+
+	if (!netconfig_load_settings(dev->conn_netconfig, settings,
+					dev->conn_addr) ||
+			!netconfig_configure(dev->conn_netconfig,
+						p2p_netconfig_event_handler,
+						dev)) {
+		p2p_connect_failed(dev);
+		return;
+	}
+
 	dev->conn_dhcp_timeout =3D l_timeout_create(p2p_dhcp_timeout_val,
 						p2p_dhcp_timeout, dev,
 						p2p_dhcp_timeout_destroy);
diff --git a/src/station.c b/src/station.c
index d61e775a..f6237ade 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2443,14 +2443,12 @@ static void station_connect_ok(struct station *stat=
ion)
 =

 	network_connected(station->connected_network);
 =

-	if (station->netconfig)
-		netconfig_configure(station->netconfig,
-					network_get_settings(
-						station->connected_network),
-					netdev_get_address(station->netdev),
-					station_netconfig_event_handler,
-					station);
-	else
+	if (station->netconfig) {
+		if (L_WARN_ON(!netconfig_configure(station->netconfig,
+						station_netconfig_event_handler,
+						station)))
+			return;
+	} else
 		station_enter_state(station, STATION_STATE_CONNECTED);
 }
 =

@@ -2592,6 +2590,12 @@ int __station_connect_network(struct station *statio=
n, struct network *network,
 	struct handshake_state *hs;
 	int r;
 =

+	if (station->netconfig && !netconfig_load_settings(
+					station->netconfig,
+					network_get_settings(network),
+					netdev_get_address(station->netdev)))
+		return -EINVAL;
+
 	hs =3D station_handshake_setup(station, network, bss);
 	if (!hs)
 		return -ENOTSUP;
-- =

2.30.2

--===============9093149649801086615==--

