Content-Type: multipart/mixed; boundary="===============4571134119742679000=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 07/13] station: network: make ANQP watch a generic event
Date: Wed, 15 Sep 2021 10:36:18 -0700
Message-ID: <20210915173624.11917-7-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============4571134119742679000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the addition of OWE transition network needs to be notified
of the hidden OWE scan which is quite similar to how it is notified
of ANQP. The ANQP event watch can be made generic and reused to
allow other events besides ANQP.
---
 src/network.c | 15 ++++++++-------
 src/station.c | 22 +++++++++++-----------
 src/station.h | 12 ++++++------
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/src/network.c b/src/network.c
index 4a6cf3ae..d985f811 100644
--- a/src/network.c
+++ b/src/network.c
@@ -59,7 +59,7 @@
 #define SAE_PT_SETTING "SAE-PT-Group%u"
 =

 static uint32_t known_networks_watch;
-static uint32_t anqp_watch;
+static uint32_t event_watch;
 =

 struct network {
 	char ssid[33];
@@ -1898,12 +1898,13 @@ static void known_networks_changed(enum known_netwo=
rks_event event,
 	}
 }
 =

-static void anqp_watch_changed(enum station_anqp_state state,
+static void event_watch_changed(enum station_event state,
 				struct network *network, void *user_data)
 {
-	network->anqp_pending =3D state =3D=3D STATION_ANQP_STARTED;
+	network->anqp_pending =3D state =3D=3D STATION_EVENT_ANQP_STARTED;
 =

-	if (state =3D=3D STATION_ANQP_FINISHED && network->connect_after_anqp) {
+	if (state =3D=3D STATION_EVENT_ANQP_FINISHED &&
+						network->connect_after_anqp) {
 		struct l_dbus_message *reply;
 =

 		l_debug("ANQP complete, resuming connect to %s", network->ssid);
@@ -1960,7 +1961,7 @@ static int network_init(void)
 	known_networks_watch =3D
 		known_networks_watch_add(known_networks_changed, NULL, NULL);
 =

-	anqp_watch =3D station_add_anqp_watch(anqp_watch_changed, NULL, NULL);
+	event_watch =3D station_add_event_watch(event_watch_changed, NULL, NULL);
 =

 	return 0;
 }
@@ -1970,8 +1971,8 @@ static void network_exit(void)
 	known_networks_watch_remove(known_networks_watch);
 	known_networks_watch =3D 0;
 =

-	station_remove_anqp_watch(anqp_watch);
-	anqp_watch =3D 0;
+	station_remove_event_watch(event_watch);
+	event_watch =3D 0;
 =

 	l_dbus_unregister_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE);
 }
diff --git a/src/station.c b/src/station.c
index 2846d3d2..8a28b9a8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -64,7 +64,7 @@ static uint32_t mfp_setting;
 static uint32_t roam_retry_interval;
 static bool anqp_disabled;
 static bool netconfig_enabled;
-static struct watchlist anqp_watches;
+static struct watchlist event_watches;
 =

 struct station {
 	enum station_state state;
@@ -485,8 +485,8 @@ static bool anqp_entry_foreach(void *data, void *user_d=
ata)
 {
 	struct anqp_entry *e =3D data;
 =

-	WATCHLIST_NOTIFY(&anqp_watches, station_anqp_watch_func_t,
-				STATION_ANQP_FINISHED, e->network);
+	WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_ANQP_FINISHED, e->network);
 =

 	remove_anqp(e);
 =

@@ -620,8 +620,8 @@ static bool station_start_anqp(struct station *station,=
 struct network *network,
 =

 	l_queue_push_head(station->anqp_pending, entry);
 =

-	WATCHLIST_NOTIFY(&anqp_watches, station_anqp_watch_func_t,
-				STATION_ANQP_STARTED, network);
+	WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_ANQP_STARTED, network);
 	return true;
 }
 =

@@ -1216,16 +1216,16 @@ bool station_remove_state_watch(struct station *sta=
tion, uint32_t id)
 	return watchlist_remove(&station->state_watches, id);
 }
 =

-uint32_t station_add_anqp_watch(station_anqp_watch_func_t func,
+uint32_t station_add_event_watch(station_event_watch_func_t func,
 				void *user_data,
 				station_destroy_func_t destroy)
 {
-	return watchlist_add(&anqp_watches, func, user_data, destroy);
+	return watchlist_add(&event_watches, func, user_data, destroy);
 }
 =

-void station_remove_anqp_watch(uint32_t id)
+void station_remove_event_watch(uint32_t id)
 {
-	watchlist_remove(&anqp_watches, id);
+	watchlist_remove(&event_watches, id);
 }
 =

 bool station_set_autoconnect(struct station *station, bool autoconnect)
@@ -4183,7 +4183,7 @@ static int station_init(void)
 	if (!netconfig_enabled)
 		l_info("station: Network configuration is disabled.");
 =

-	watchlist_init(&anqp_watches, NULL);
+	watchlist_init(&event_watches, NULL);
 =

 	return 0;
 }
@@ -4199,7 +4199,7 @@ static void station_exit(void)
 	netdev_watch_remove(netdev_watch);
 	l_queue_destroy(station_list, NULL);
 	station_list =3D NULL;
-	watchlist_destroy(&anqp_watches);
+	watchlist_destroy(&event_watches);
 }
 =

 IWD_MODULE(station, station_init, station_exit)
diff --git a/src/station.h b/src/station.h
index a9a9258d..fabdd922 100644
--- a/src/station.h
+++ b/src/station.h
@@ -45,14 +45,14 @@ enum station_state {
 	STATION_STATE_ROAMING
 };
 =

-enum station_anqp_state {
-	STATION_ANQP_STARTED,
-	STATION_ANQP_FINISHED,
+enum station_event {
+	STATION_EVENT_ANQP_STARTED,
+	STATION_EVENT_ANQP_FINISHED,
 };
 =

 typedef void (*station_foreach_func_t)(struct station *, void *data);
 typedef void (*station_state_watch_func_t)(enum station_state, void *userd=
ata);
-typedef void (*station_anqp_watch_func_t)(enum station_anqp_state,
+typedef void (*station_event_watch_func_t)(enum station_event,
 						struct network *network,
 						void *user_data);
 typedef void (*station_destroy_func_t)(void *userdata);
@@ -77,10 +77,10 @@ uint32_t station_add_state_watch(struct station *statio=
n,
 					station_destroy_func_t destroy);
 bool station_remove_state_watch(struct station *station, uint32_t id);
 =

-uint32_t station_add_anqp_watch(station_anqp_watch_func_t func,
+uint32_t station_add_event_watch(station_event_watch_func_t func,
 				void *user_data,
 				station_destroy_func_t destroy);
-void station_remove_anqp_watch(uint32_t id);
+void station_remove_event_watch(uint32_t id);
 =

 bool station_set_autoconnect(struct station *station, bool autoconnect);
 =

-- =

2.31.1

--===============4571134119742679000==--

