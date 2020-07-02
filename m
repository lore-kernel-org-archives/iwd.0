Content-Type: multipart/mixed; boundary="===============3993863139135299315=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] network: use wiphy work queue for connections
Date: Thu, 02 Jul 2020 10:35:31 -0700
Message-ID: <20200702173533.8712-6-prestwoj@gmail.com>
In-Reply-To: <20200702173533.8712-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3993863139135299315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Network was refactored to use the wiphy work queue for
connections. This removes the need for an ANQP watch since we can
insert the connect work item at a lower priority than ANQP. This
will, by nature, force the connect attempt to wait for ANQP to
complete, ensuring that the network_info is populated.
---
 src/network.c | 147 ++++++++++++++++++++++++++------------------------
 src/station.c |   6 +--
 2 files changed, 81 insertions(+), 72 deletions(-)

diff --git a/src/network.c b/src/network.c
index 70541b59..6206a022 100644
--- a/src/network.c
+++ b/src/network.c
@@ -52,7 +52,6 @@
 #include "src/util.h"
 =

 static uint32_t known_networks_watch;
-static uint32_t anqp_watch;
 =

 struct network {
 	char ssid[33];
@@ -70,13 +69,16 @@ struct network {
 	uint8_t hessid[6];
 	char **nai_realms;
 	uint8_t *rc_ie;
+
+	/* D-Bus message and BSS saved when connecting via network_connect() */
+	struct l_dbus_message *connect_msg;
+	struct scan_bss *connect_bss;
+	struct wiphy_radio_work_item work;
+
 	bool update_psk:1;  /* Whether PSK should be written to storage */
 	bool ask_passphrase:1; /* Whether we should force-ask agent */
 	bool is_hs20:1;
-	bool anqp_pending:1;	/* Set if there is a pending ANQP request */
 	int rank;
-	/* Holds DBus Connect() message if it comes in before ANQP finishes */
-	struct l_dbus_message *connect_after_anqp;
 };
 =

 static bool network_settings_load(struct network *network)
@@ -138,6 +140,7 @@ void network_connected(struct network *network)
 	enum security security =3D network_get_security(network);
 	const char *ssid =3D network_get_ssid(network);
 	int err;
+	struct wiphy *wiphy =3D station_get_wiphy(network->station);
 =

 	if (!network->info) {
 		/*
@@ -164,6 +167,8 @@ void network_connected(struct network *network)
 				network_secret_check_cacheable, network);
 =

 	l_queue_clear(network->blacklist, NULL);
+
+	wiphy_radio_work_done(wiphy, network->work.id);
 }
 =

 void network_disconnected(struct network *network)
@@ -516,6 +521,30 @@ static bool bss_is_sae(const struct scan_bss *bss)
 	return __bss_is_sae(bss, &rsn);
 }
 =

+static void network_connect_destroy(struct wiphy_radio_work_item *item)
+{
+	struct network *network =3D l_container_of(item, struct network, work);
+
+	if (network->connect_msg)
+		l_dbus_message_unref(network->connect_msg);
+
+	network->connect_bss =3D NULL;
+	network->connect_msg =3D NULL;
+}
+
+static bool network_autoconnect_ready(struct wiphy_radio_work_item *item)
+{
+	struct network *network =3D l_container_of(item, struct network, work);
+
+	return __station_connect_network(network->station, network,
+						network->connect_bss) !=3D 0;
+}
+
+static const struct wiphy_radio_work_item_ops autoconnect_work_ops =3D {
+	.do_work =3D network_autoconnect_ready,
+	.destroy =3D network_connect_destroy,
+};
+
 int network_autoconnect(struct network *network, struct scan_bss *bss)
 {
 	struct station *station =3D network->station;
@@ -525,8 +554,8 @@ int network_autoconnect(struct network *network, struct=
 scan_bss *bss)
 	bool is_rsn;
 	int ret;
 =

-	/* already waiting for an agent request, connect in progress */
-	if (network->agent_request)
+	/* A connect is already in progress */
+	if (network->work.id)
 		return -EALREADY;
 =

 	switch (security) {
@@ -588,7 +617,12 @@ int network_autoconnect(struct network *network, struc=
t scan_bss *bss)
 	}
 =

 done:
-	return __station_connect_network(station, network, bss);
+	network->connect_bss =3D bss;
+
+	wiphy_radio_work_insert(wiphy, &network->work, 1,
+					&autoconnect_work_ops);
+
+	return 0;
 =

 close_settings:
 	network_settings_close(network);
@@ -597,6 +631,8 @@ close_settings:
 =

 void network_connect_failed(struct network *network, bool in_handshake)
 {
+	struct wiphy *wiphy =3D station_get_wiphy(network->station);
+
 	/*
 	 * Connection failed during the handshake phase.  If PSK try asking
 	 * for the passphrase once more
@@ -610,6 +646,8 @@ void network_connect_failed(struct network *network, bo=
ol in_handshake)
 	network->secrets =3D NULL;
 =

 	l_queue_clear(network->blacklist, NULL);
+
+	wiphy_radio_work_done(wiphy, network->work.id);
 }
 =

 static bool hotspot_info_matches(struct network *network,
@@ -1130,12 +1168,41 @@ error:
 	return reply;
 }
 =

+static bool network_connect_ready(struct wiphy_radio_work_item *item)
+{
+	struct network *network =3D l_container_of(item, struct network, work);
+	struct scan_bss *bss =3D network->connect_bss;
+	struct l_dbus_message *message =3D network->connect_msg;
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
+static const struct wiphy_radio_work_item_ops connect_work_ops =3D {
+	.do_work =3D network_connect_ready,
+	.destroy =3D network_connect_destroy,
+};
+
 static struct l_dbus_message *network_connect(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
 	struct network *network =3D user_data;
 	struct station *station =3D network->station;
+	struct wiphy *wiphy =3D station_get_wiphy(station);
 	struct scan_bss *bss;
 =

 	l_debug("");
@@ -1157,36 +1224,12 @@ static struct l_dbus_message *network_connect(struc=
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
+	network->connect_bss =3D bss;
+	network->connect_msg =3D l_dbus_message_ref(message);
 =

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
+	wiphy_radio_work_insert(wiphy, &network->work, 1, &connect_work_ops);
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
@@ -1508,35 +1551,6 @@ static void known_networks_changed(enum known_networ=
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
@@ -1570,8 +1584,6 @@ static int network_init(void)
 	known_networks_watch =3D
 		known_networks_watch_add(known_networks_changed, NULL, NULL);
 =

-	anqp_watch =3D station_add_anqp_watch(anqp_watch_changed, NULL, NULL);
-
 	return 0;
 }
 =

@@ -1580,9 +1592,6 @@ static void network_exit(void)
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

--===============3993863139135299315==--

