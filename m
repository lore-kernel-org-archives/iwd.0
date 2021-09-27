Content-Type: multipart/mixed; boundary="===============3455201579499451643=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] netconfig: Set address at configure time
Date: Mon, 27 Sep 2021 11:42:14 -0500
Message-ID: <20210927164214.16006-1-denkenz@gmail.com>

--===============3455201579499451643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

netconfig_load_settings is called when establishing a new initial
association to a network.  This function tries to update dhcp/dhcpv6
clients with the MAC address of the netdev being used.  However, it is
too early to update the MAC here since netdev might need to powercycle
the underlying network device in order to update the MAC (i.e. when
AddressRandomization=3D"network" is used).

If the MAC is set incorrectly, DHCP clients are unable to obtain the
lease properly and station is stuck in "connecting" mode indefinitely.
Fix this by delaying MAC address update until netconfig_configure() is
invoked.

Fixes: ad228461abbf ("netconfig: Move loading settings to new method, refac=
tor")
---
 src/netconfig.c | 17 +++++++++--------
 src/netconfig.h |  3 +--
 src/p2p.c       |  3 +--
 src/station.c   |  3 +--
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 421270c98c6b..1d6edcab02bf 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1046,6 +1046,7 @@ static void netconfig_ipv4_acd_event(enum l_acd_event=
 event, void *user_data)
 =

 static bool netconfig_ipv4_select_and_install(struct netconfig *netconfig)
 {
+	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
 	bool set_address =3D (netconfig->rtm_protocol =3D=3D RTPROT_STATIC);
 =

 	if (netconfig->rtm_protocol =3D=3D RTPROT_DHCP &&
@@ -1106,6 +1107,9 @@ static bool netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 		return true;
 	}
 =

+	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
+					netdev_get_address(netdev), ETH_ALEN);
+
 	if (l_dhcp_client_start(netconfig->dhcp_client))
 		return true;
 =

@@ -1162,7 +1166,10 @@ static bool netconfig_ipv6_select_and_install(struct=
 netconfig *netconfig)
 		return true;
 	}
 =

-	/* DHCP */
+	/* DHCPv6 or RA, update MAC */
+	l_dhcp6_client_set_address(netconfig->dhcp6_client, ARPHRD_ETHER,
+					netdev_get_address(netdev), ETH_ALEN);
+
 	return true;
 }
 =

@@ -1196,8 +1203,7 @@ static int validate_dns_list(int family, char **dns_l=
ist)
 }
 =

 bool netconfig_load_settings(struct netconfig *netconfig,
-				const struct l_settings *active_settings,
-				const uint8_t *mac_address)
+				const struct l_settings *active_settings)
 {
 	char *mdns;
 	bool send_hostname;
@@ -1302,11 +1308,6 @@ bool netconfig_load_settings(struct netconfig *netco=
nfig,
 	resolve_set_mdns(netconfig->resolve, mdns);
 	l_free(mdns);
 =

-	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
-							mac_address, ETH_ALEN);
-	l_dhcp6_client_set_address(netconfig->dhcp6_client, ARPHRD_ETHER,
-							mac_address, ETH_ALEN);
-
 	netconfig->active_settings =3D active_settings;
 	netconfig->dns4_overrides =3D dns4_overrides;
 	netconfig->dns6_overrides =3D dns6_overrides;
diff --git a/src/netconfig.h b/src/netconfig.h
index fa46c7c80236..3c4e7641ed2a 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -32,8 +32,7 @@ typedef void (*netconfig_notify_func_t)(enum netconfig_ev=
ent event,
 							void *user_data);
 =

 bool netconfig_load_settings(struct netconfig *netconfig,
-				const struct l_settings *active_settings,
-				const uint8_t *mac_address);
+				const struct l_settings *active_settings);
 bool netconfig_configure(struct netconfig *netconfig,
 				netconfig_notify_func_t notify,
 				void *user_data);
diff --git a/src/p2p.c b/src/p2p.c
index 62df1ea5a7d0..90779f9500e5 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1328,8 +1328,7 @@ static void p2p_start_client_netconfig(struct p2p_dev=
ice *dev)
 =

 	settings =3D dev->conn_netconfig_settings ?: p2p_dhcp_settings;
 =

-	if (!netconfig_load_settings(dev->conn_netconfig, settings,
-					dev->conn_addr) ||
+	if (!netconfig_load_settings(dev->conn_netconfig, settings) ||
 			!netconfig_configure(dev->conn_netconfig,
 						p2p_netconfig_event_handler,
 						dev)) {
diff --git a/src/station.c b/src/station.c
index 672c48603d75..6bcf8dddadd0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2869,8 +2869,7 @@ int __station_connect_network(struct station *station=
, struct network *network,
 =

 	if (station->netconfig && !netconfig_load_settings(
 					station->netconfig,
-					network_get_settings(network),
-					netdev_get_address(station->netdev)))
+					network_get_settings(network)))
 		return -EINVAL;
 =

 	hs =3D station_handshake_setup(station, network, bss);
-- =

2.26.3

--===============3455201579499451643==--

