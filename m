Content-Type: multipart/mixed; boundary="===============0286262205314273738=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/7] network: use radio management for connections
Date: Thu, 25 Jun 2020 11:56:44 -0700
Message-ID: <20200625185645.30122-7-prestwoj@gmail.com>
In-Reply-To: <20200625185645.30122-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0286262205314273738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Network was refactored to use the radio management module for
connections. This removes the need for an ANQP watch since we can
insert the connect work item at a lower priority than ANQP. This
will, by nature, force the connect attempt to wait for ANQP to
complete, ensuring that the network_info is populated.
---
 src/network.c | 148 ++++++++++++++++++++++++++------------------------
 src/station.c |   6 +-
 2 files changed, 81 insertions(+), 73 deletions(-)

diff --git a/src/network.c b/src/network.c
index 70541b59..c86d0c7b 100644
--- a/src/network.c
+++ b/src/network.c
@@ -50,9 +50,15 @@
 #include "src/network.h"
 #include "src/blacklist.h"
 #include "src/util.h"
+#include "src/radio_mgmt.h"
 =

 static uint32_t known_networks_watch;
-static uint32_t anqp_watch;
+
+struct network_connect_info {
+	uint32_t work_id;
+	struct scan_bss *bss;
+	struct l_dbus_message *message;
+};
 =

 struct network {
 	char ssid[33];
@@ -73,10 +79,8 @@ struct network {
 	bool update_psk:1;  /* Whether PSK should be written to storage */
 	bool ask_passphrase:1; /* Whether we should force-ask agent */
 	bool is_hs20:1;
-	bool anqp_pending:1;	/* Set if there is a pending ANQP request */
 	int rank;
-	/* Holds DBus Connect() message if it comes in before ANQP finishes */
-	struct l_dbus_message *connect_after_anqp;
+	struct network_connect_info connect;
 };
 =

 static bool network_settings_load(struct network *network)
@@ -138,6 +142,7 @@ void network_connected(struct network *network)
 	enum security security =3D network_get_security(network);
 	const char *ssid =3D network_get_ssid(network);
 	int err;
+	struct netdev *netdev =3D station_get_netdev(network->station);
 =

 	if (!network->info) {
 		/*
@@ -164,6 +169,8 @@ void network_connected(struct network *network)
 				network_secret_check_cacheable, network);
 =

 	l_queue_clear(network->blacklist, NULL);
+
+	radio_mgmt_done(netdev_get_wdev_id(netdev), network->connect.work_id);
 }
 =

 void network_disconnected(struct network *network)
@@ -516,17 +523,39 @@ static bool bss_is_sae(const struct scan_bss *bss)
 	return __bss_is_sae(bss, &rsn);
 }
 =

+static void network_connect_info_destroy(void *user_data)
+{
+	struct network_connect_info *info =3D user_data;
+
+	if (info->message)
+		l_dbus_message_unref(info->message);
+
+	info->work_id =3D 0;
+	info->bss =3D NULL;
+	info->message =3D NULL;
+}
+
+static bool network_autoconnect_ready(void *user_data)
+{
+	struct network_connect_info *info =3D user_data;
+	struct network *network =3D l_container_of(info, struct network, connect);
+
+	return __station_connect_network(network->station, network,
+						info->bss) !=3D 0;
+}
+
 int network_autoconnect(struct network *network, struct scan_bss *bss)
 {
 	struct station *station =3D network->station;
+	struct netdev *netdev =3D station_get_netdev(network->station);
 	struct wiphy *wiphy =3D station_get_wiphy(station);
 	enum security security =3D network_get_security(network);
 	struct ie_rsn_info rsn;
 	bool is_rsn;
 	int ret;
 =

-	/* already waiting for an agent request, connect in progress */
-	if (network->agent_request)
+	/* A connect is already in progress */
+	if (network->connect.work_id)
 		return -EALREADY;
 =

 	switch (security) {
@@ -588,7 +617,13 @@ int network_autoconnect(struct network *network, struc=
t scan_bss *bss)
 	}
 =

 done:
-	return __station_connect_network(station, network, bss);
+	network->connect.bss =3D bss;
+	network->connect.work_id =3D radio_mgmt_push(netdev_get_wdev_id(netdev),
+						1, network_autoconnect_ready,
+						&network->connect,
+						network_connect_info_destroy);
+
+	return 0;
 =

 close_settings:
 	network_settings_close(network);
@@ -597,6 +632,8 @@ close_settings:
 =

 void network_connect_failed(struct network *network, bool in_handshake)
 {
+	struct netdev *netdev =3D station_get_netdev(network->station);
+
 	/*
 	 * Connection failed during the handshake phase.  If PSK try asking
 	 * for the passphrase once more
@@ -610,6 +647,8 @@ void network_connect_failed(struct network *network, bo=
ol in_handshake)
 	network->secrets =3D NULL;
 =

 	l_queue_clear(network->blacklist, NULL);
+
+	radio_mgmt_done(netdev_get_wdev_id(netdev), network->connect.work_id);
 }
 =

 static bool hotspot_info_matches(struct network *network,
@@ -1130,12 +1169,37 @@ error:
 	return reply;
 }
 =

+static bool network_connect_ready(void *user_data)
+{
+	struct network_connect_info *info =3D user_data;
+	struct network *network =3D l_container_of(info, struct network, connect);
+	struct scan_bss *bss =3D info->bss;
+	struct l_dbus_message *message =3D info->message;
+
+	switch (network_get_security(network)) {
+	case SECURITY_PSK:
+		return network_connect_psk(network, bss, message);
+	case SECURITY_NONE:
+		station_connect_network(network->station, network, bss,
+						message);
+		return NULL;
+	case SECURITY_8021X:
+		if (!network_settings_load(network))
+			return dbus_error_not_configured(message);
+
+		return network_connect_8021x(network, bss, message);
+	default:
+		return dbus_error_not_supported(message);
+	}
+}
+
 static struct l_dbus_message *network_connect(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
 	struct network *network =3D user_data;
 	struct station *station =3D network->station;
+	struct netdev *netdev =3D station_get_netdev(station);
 	struct scan_bss *bss;
 =

 	l_debug("");
@@ -1157,36 +1221,14 @@ static struct l_dbus_message *network_connect(struc=
t l_dbus *dbus,
 	if (!bss)
 		return dbus_error_not_supported(message);
 =

-	switch (network_get_security(network)) {
-	case SECURITY_PSK:
-		return network_connect_psk(network, bss, message);
-	case SECURITY_NONE:
-		station_connect_network(station, network, bss, message);
-		return NULL;
-	case SECURITY_8021X:
-		if (network->connect_after_anqp)
-			return dbus_error_busy(message);
-
-		/*
-		 * If there is an ongoing ANQP request we must wait for that to
-		 * finish. Save the message and wait for the ANQP watch to
-		 * fire
-		 */
-		if (network->anqp_pending) {
-			network->connect_after_anqp =3D
-						l_dbus_message_ref(message);
-			l_debug("Pending ANQP request, delaying connect to %s",
-						network->ssid);
-			return NULL;
-		}
+	network->connect.bss =3D bss;
+	network->connect.message =3D l_dbus_message_ref(message);
+	network->connect.work_id =3D radio_mgmt_push(netdev_get_wdev_id(netdev),
+						1, network_connect_ready,
+						&network->connect,
+						network_connect_info_destroy);
 =

-		if (!network_settings_load(network))
-			return dbus_error_not_configured(message);
-
-		return network_connect_8021x(network, bss, message);
-	default:
-		return dbus_error_not_supported(message);
-	}
+	return NULL;
 }
 =

 void network_connect_new_hidden_network(struct network *network,
@@ -1508,35 +1550,6 @@ static void known_networks_changed(enum known_networ=
ks_event event,
 	}
 }
 =

-static void anqp_watch_changed(enum station_anqp_state state,
-				struct network *network, void *user_data)
-{
-	network->anqp_pending =3D state =3D=3D STATION_ANQP_STARTED;
-
-	if (state =3D=3D STATION_ANQP_FINISHED && network->connect_after_anqp) {
-		struct l_dbus_message *reply;
-
-		l_debug("ANQP complete, resuming connect to %s", network->ssid);
-
-		if (!network_settings_load(network)) {
-			reply =3D dbus_error_not_configured(
-						network->connect_after_anqp);
-			dbus_pending_reply(&network->connect_after_anqp, reply);
-			return;
-		}
-
-		reply =3D network_connect_8021x(network,
-					network_bss_select(network, true),
-					network->connect_after_anqp);
-
-		if (reply)
-			l_dbus_send(dbus_get_bus(), reply);
-
-		l_dbus_message_unref(network->connect_after_anqp);
-		network->connect_after_anqp =3D NULL;
-	}
-}
-
 static void setup_network_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Connect", 0,
@@ -1570,8 +1583,6 @@ static int network_init(void)
 	known_networks_watch =3D
 		known_networks_watch_add(known_networks_changed, NULL, NULL);
 =

-	anqp_watch =3D station_add_anqp_watch(anqp_watch_changed, NULL, NULL);
-
 	return 0;
 }
 =

@@ -1580,9 +1591,6 @@ static void network_exit(void)
 	known_networks_watch_remove(known_networks_watch);
 	known_networks_watch =3D 0;
 =

-	station_remove_anqp_watch(anqp_watch);
-	anqp_watch =3D 0;
-
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE);
 }
 =

diff --git a/src/station.c b/src/station.c
index dd9347a8..69c4ae01 100644
--- a/src/station.c
+++ b/src/station.c
@@ -183,10 +183,8 @@ static void station_autoconnect_next(struct station *s=
tation)
 		r =3D network_autoconnect(entry->network, entry->bss);
 		l_free(entry);
 =

-		if (!r) {
-			station_enter_state(station, STATION_STATE_CONNECTING);
+		if (!r)
 			return;
-		}
 	}
 }
 =

@@ -2377,6 +2375,8 @@ int __station_connect_network(struct station *station=
, struct network *network,
 	station->connected_bss =3D bss;
 	station->connected_network =3D network;
 =

+	station_enter_state(station, STATION_STATE_CONNECTING);
+
 	return 0;
 }
 =

-- =

2.21.1

--===============0286262205314273738==--

