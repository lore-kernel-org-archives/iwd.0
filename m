Content-Type: multipart/mixed; boundary="===============8396201356227723194=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 1/8] netconfig: Decouple from station state
Date: Mon, 30 Sep 2019 09:35:51 -0700
Message-ID: <20190930163558.28123-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8396201356227723194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of relying on station state changed signal, netconfig
introduces three new API calls to configure, re-configure and
reset the network configurations. The owner of netconfig object
is responsible for initiating the re-configuration of the device
depending on its state.
---
 src/netconfig.c | 79 ++++++++++++++++++++++++++++++-----------------------=
----
 src/netconfig.h |  6 +++++
 2 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 2074689f..88d2588e 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -48,6 +48,8 @@ struct netconfig {
 	struct l_dhcp_client *dhcp_client;
 	struct l_queue *ifaddr_list;
 	uint8_t rtm_protocol;
+
+	const struct l_settings *active_settings;
 };
 =

 struct netconfig_ifaddr {
@@ -589,16 +591,10 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
l_dhcp_client *client,
 	}
 }
 =

-static bool netconfig_ipv4_dhcp_create(struct netconfig *netconfig,
-							struct station *station)
+static bool netconfig_ipv4_dhcp_create(struct netconfig *netconfig)
 {
 	netconfig->dhcp_client =3D l_dhcp_client_new(netconfig->ifindex);
 =

-	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
-					netdev_get_address(
-						station_get_netdev(station)),
-					ETH_ALEN);
-
 	l_dhcp_client_set_event_handler(netconfig->dhcp_client,
 					netconfig_ipv4_dhcp_event_handler,
 					netconfig, NULL);
@@ -654,41 +650,57 @@ static void netconfig_ipv4_select_and_uninstall(struc=
t netconfig *netconfig)
 	l_dhcp_client_stop(netconfig->dhcp_client);
 }
 =

-static void netconfig_station_state_changed(enum station_state state,
-								void *userdata)
+bool netconfig_configure(struct netconfig *netconfig,
+				const struct l_settings *active_settings,
+				const uint8_t *mac_address)
 {
-	struct netconfig *netconfig =3D userdata;
+	netconfig->active_settings =3D active_settings;
 =

-	l_debug("");
+	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
+							mac_address, ETH_ALEN);
 =

-	switch (state) {
-	case STATION_STATE_CONNECTED:
-		netconfig_ipv4_select_and_install(netconfig);
+	netconfig_ipv4_select_and_install(netconfig);
 =

-		/* TODO: IPv6 addressing */
+	/* TODO: IPv6 addressing */
 =

-		break;
-	case STATION_STATE_DISCONNECTED:
-		netconfig_ipv4_select_and_uninstall(netconfig);
+	return true;
+}
 =

-		/* TODO: IPv6 addressing */
+bool netconfig_reconfigure(struct netconfig *netconfig)
+{
+	if (netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
+		/*
+		 *
+		 * TODO l_dhcp_client to try to request a
+		 * previously used address.
+		 *
+		 * return;
+		 */
+	}
 =

-		resolve_remove(netconfig->ifindex);
+	netconfig_ipv4_select_and_install(netconfig);
 =

-		break;
-	case STATION_STATE_ROAMING:
-		break;
-	default:
-		return;
-	}
+	/* TODO: IPv6 addressing */
 =

-	netconfig->station_state =3D state;
+	return true;
+}
+
+bool netconfig_reset(struct netconfig *netconfig)
+{
+	netconfig_ipv4_select_and_uninstall(netconfig);
+
+	/* TODO: IPv6 addressing */
+
+	resolve_remove(netconfig->ifindex);
+
+	netconfig->rtm_protocol =3D 0;
+
+	return true;
 }
 =

 struct netconfig *netconfig_new(uint32_t ifindex)
 {
 	struct netconfig *netconfig;
-	struct station *station;
 =

 	if (!netconfig_list)
 		return NULL;
@@ -699,18 +711,11 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	if (netconfig)
 		return netconfig;
 =

-	station =3D station_find(ifindex);
-	if (!station)
-		return NULL;
-
 	netconfig =3D l_new(struct netconfig, 1);
 	netconfig->ifindex =3D ifindex;
 	netconfig->ifaddr_list =3D l_queue_new();
 =

-	netconfig_ipv4_dhcp_create(netconfig, station);
-
-	station_add_state_watch(station, netconfig_station_state_changed,
-							netconfig, NULL);
+	netconfig_ipv4_dhcp_create(netconfig);
 =

 	l_queue_push_tail(netconfig_list, netconfig);
 =

@@ -726,7 +731,7 @@ void netconfig_destroy(struct netconfig *netconfig)
 =

 	l_queue_remove(netconfig_list, netconfig);
 =

-	if (netconfig->station_state !=3D STATION_STATE_DISCONNECTED) {
+	if (netconfig->rtm_protocol) {
 		netconfig_ipv4_select_and_uninstall(netconfig);
 =

 		/* TODO Uninstall IPv6 addresses. */
diff --git a/src/netconfig.h b/src/netconfig.h
index fd344830..cacd384a 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -22,5 +22,11 @@
 =

 struct netconfig;
 =

+bool netconfig_configure(struct netconfig *netconfig,
+				const struct l_settings *active_settings,
+				const uint8_t *mac_address);
+bool netconfig_reconfigure(struct netconfig *netconfig);
+bool netconfig_reset(struct netconfig *netconfig);
+
 struct netconfig *netconfig_new(uint32_t ifindex);
 void netconfig_destroy(struct netconfig *netconfig);
-- =

2.13.6

--===============8396201356227723194==--

