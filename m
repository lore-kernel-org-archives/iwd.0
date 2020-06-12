Content-Type: multipart/mixed; boundary="===============2477896456127769123=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] station: add ANQP state watch API
Date: Fri, 12 Jun 2020 12:14:11 -0700
Message-ID: <20200612191414.13413-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2477896456127769123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is to allow network to watch for ANQP activity in order to
fix the race condition between scanning finishing and ANQP finishing.
Without this it is possible for a DBus Connect() to come in before
ANQP has completed and causing the network to return NotConfigured,
when its actually in the process of obtaining all the network info.

The watch was made globally in station due to network not having
a station object until each individual network is created. Adding a
watch during network creation would result in many watchers as well
as a lot of removal/addition as networks are found and lost.
---
 src/station.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/station.h | 13 +++++++++++++
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 87fadc3f..f0a0e810 100644
--- a/src/station.c
+++ b/src/station.c
@@ -59,6 +59,7 @@ static uint32_t netdev_watch;
 static uint32_t mfp_setting;
 static bool anqp_disabled;
 static bool netconfig_enabled;
+static struct watchlist anqp_watches;
 =

 struct station {
 	enum station_state state;
@@ -434,6 +435,32 @@ static void network_add_foreach(struct network *networ=
k, void *user_data)
 	station_add_autoconnect_bss(station, network, bss);
 }
 =

+static bool match_pending(const void *a, const void *b)
+{
+	const struct anqp_entry *entry =3D a;
+
+	return entry->pending !=3D 0;
+}
+
+static void remove_anqp(void *data)
+{
+	struct anqp_entry *entry =3D data;
+
+	l_free(entry);
+}
+
+static bool anqp_entry_foreach(void *data, void *user_data)
+{
+	struct anqp_entry *e =3D data;
+
+	WATCHLIST_NOTIFY(&anqp_watches, station_anqp_watch_func_t,
+				STATION_ANQP_FINISHED, e->network);
+
+	remove_anqp(e);
+
+	return true;
+}
+
 static void station_anqp_response_cb(enum anqp_result result,
 					const void *anqp, size_t anqp_len,
 					void *user_data)
@@ -487,12 +514,15 @@ static void station_anqp_response_cb(enum anqp_result=
 result,
 	l_strv_free(realms);
 =

 request_done:
-	l_queue_remove(station->anqp_pending, entry);
+	entry->pending =3D 0;
 =

-	/* If no more requests, resume scanning */
-	if (!l_queue_isempty(station->anqp_pending))
+	/* Return if there are other pending requests */
+	if (l_queue_find(station->anqp_pending, match_pending, NULL))
 		return;
 =

+	/* Notify all watchers now that every ANQP request has finished */
+	l_queue_foreach_remove(station->anqp_pending, anqp_entry_foreach, NULL);
+
 	l_queue_destroy(station->autoconnect_list, l_free);
 	station->autoconnect_list =3D l_queue_new();
 =

@@ -564,6 +594,8 @@ static bool station_start_anqp(struct station *station,=
 struct network *network,
 =

 	l_queue_push_head(station->anqp_pending, entry);
 =

+	WATCHLIST_NOTIFY(&anqp_watches, station_anqp_watch_func_t,
+				STATION_ANQP_STARTED, network);
 	return true;
 }
 =

@@ -1217,6 +1249,18 @@ bool station_remove_state_watch(struct station *stat=
ion, uint32_t id)
 	return watchlist_remove(&station->state_watches, id);
 }
 =

+uint32_t station_add_anqp_watch(station_anqp_watch_func_t func,
+				void *user_data,
+				station_destroy_func_t destroy)
+{
+	return watchlist_add(&anqp_watches, func, user_data, destroy);
+}
+
+void station_remove_anqp_watch(uint32_t id)
+{
+	watchlist_remove(&anqp_watches, id);
+}
+
 bool station_set_autoconnect(struct station *station, bool autoconnect)
 {
 	if (station->autoconnect =3D=3D autoconnect)
@@ -3270,6 +3314,8 @@ static int station_init(void)
 	if (!netconfig_enabled)
 		l_info("station: Network configuration is disabled.");
 =

+	watchlist_init(&anqp_watches, NULL);
+
 	return 0;
 }
 =

@@ -3279,6 +3325,7 @@ static void station_exit(void)
 	netdev_watch_remove(netdev_watch);
 	l_queue_destroy(station_list, NULL);
 	station_list =3D NULL;
+	watchlist_destroy(&anqp_watches);
 }
 =

 IWD_MODULE(station, station_init, station_exit)
diff --git a/src/station.h b/src/station.h
index 4155081b..17a0f8df 100644
--- a/src/station.h
+++ b/src/station.h
@@ -43,8 +43,16 @@ enum station_state {
 	STATION_STATE_ROAMING
 };
 =

+enum station_anqp_state {
+	STATION_ANQP_STARTED,
+	STATION_ANQP_FINISHED,
+};
+
 typedef void (*station_foreach_func_t)(struct station *, void *data);
 typedef void (*station_state_watch_func_t)(enum station_state, void *userd=
ata);
+typedef void (*station_anqp_watch_func_t)(enum station_anqp_state,
+						struct network *network,
+						void *user_data);
 typedef void (*station_destroy_func_t)(void *userdata);
 typedef void (*station_network_foreach_func_t)(struct network *, void *dat=
a);
 =

@@ -66,6 +74,11 @@ uint32_t station_add_state_watch(struct station *station,
 					station_destroy_func_t destroy);
 bool station_remove_state_watch(struct station *station, uint32_t id);
 =

+uint32_t station_add_anqp_watch(station_anqp_watch_func_t func,
+				void *user_data,
+				station_destroy_func_t destroy);
+void station_remove_anqp_watch(uint32_t id);
+
 bool station_set_autoconnect(struct station *station, bool autoconnect);
 =

 void station_ap_directed_roam(struct station *station,
-- =

2.21.1

--===============2477896456127769123==--

