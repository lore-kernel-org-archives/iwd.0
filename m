Content-Type: multipart/mixed; boundary="===============3360299837186776876=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] station: remove ANQP watch
Date: Thu, 02 Jul 2020 10:35:32 -0700
Message-ID: <20200702173533.8712-7-prestwoj@gmail.com>
In-Reply-To: <20200702173533.8712-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3360299837186776876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 34 ++--------------------------------
 src/station.h |  5 -----
 2 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/src/station.c b/src/station.c
index 69c4ae01..113f030b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -59,7 +59,6 @@ static uint32_t netdev_watch;
 static uint32_t mfp_setting;
 static bool anqp_disabled;
 static bool netconfig_enabled;
-static struct watchlist anqp_watches;
 =

 struct station {
 	enum station_state state;
@@ -450,18 +449,6 @@ static void remove_anqp(void *data)
 	l_free(entry);
 }
 =

-static bool anqp_entry_foreach(void *data, void *user_data)
-{
-	struct anqp_entry *e =3D data;
-
-	WATCHLIST_NOTIFY(&anqp_watches, station_anqp_watch_func_t,
-				STATION_ANQP_FINISHED, e->network);
-
-	remove_anqp(e);
-
-	return true;
-}
-
 static void station_anqp_response_cb(enum anqp_result result,
 					const void *anqp, size_t anqp_len,
 					void *user_data)
@@ -518,8 +505,8 @@ request_done:
 	if (l_queue_find(station->anqp_pending, match_pending, NULL))
 		return;
 =

-	/* Notify all watchers now that every ANQP request has finished */
-	l_queue_foreach_remove(station->anqp_pending, anqp_entry_foreach, NULL);
+	/* Clear queue now that every ANQP request has finished */
+	l_queue_clear(station->anqp_pending, remove_anqp);
 =

 	l_queue_destroy(station->autoconnect_list, l_free);
 	station->autoconnect_list =3D l_queue_new();
@@ -589,8 +576,6 @@ static bool station_start_anqp(struct station *station,=
 struct network *network,
 =

 	l_queue_push_head(station->anqp_pending, entry);
 =

-	WATCHLIST_NOTIFY(&anqp_watches, station_anqp_watch_func_t,
-				STATION_ANQP_STARTED, network);
 	return true;
 }
 =

@@ -1232,18 +1217,6 @@ bool station_remove_state_watch(struct station *stat=
ion, uint32_t id)
 	return watchlist_remove(&station->state_watches, id);
 }
 =

-uint32_t station_add_anqp_watch(station_anqp_watch_func_t func,
-				void *user_data,
-				station_destroy_func_t destroy)
-{
-	return watchlist_add(&anqp_watches, func, user_data, destroy);
-}
-
-void station_remove_anqp_watch(uint32_t id)
-{
-	watchlist_remove(&anqp_watches, id);
-}
-
 bool station_set_autoconnect(struct station *station, bool autoconnect)
 {
 	if (station->autoconnect =3D=3D autoconnect)
@@ -3303,8 +3276,6 @@ static int station_init(void)
 	if (!netconfig_enabled)
 		l_info("station: Network configuration is disabled.");
 =

-	watchlist_init(&anqp_watches, NULL);
-
 	return 0;
 }
 =

@@ -3314,7 +3285,6 @@ static void station_exit(void)
 	netdev_watch_remove(netdev_watch);
 	l_queue_destroy(station_list, NULL);
 	station_list =3D NULL;
-	watchlist_destroy(&anqp_watches);
 }
 =

 IWD_MODULE(station, station_init, station_exit)
diff --git a/src/station.h b/src/station.h
index 17a0f8df..a9a33afe 100644
--- a/src/station.h
+++ b/src/station.h
@@ -74,11 +74,6 @@ uint32_t station_add_state_watch(struct station *station,
 					station_destroy_func_t destroy);
 bool station_remove_state_watch(struct station *station, uint32_t id);
 =

-uint32_t station_add_anqp_watch(station_anqp_watch_func_t func,
-				void *user_data,
-				station_destroy_func_t destroy);
-void station_remove_anqp_watch(uint32_t id);
-
 bool station_set_autoconnect(struct station *station, bool autoconnect);
 =

 void station_ap_directed_roam(struct station *station,
-- =

2.21.1

--===============3360299837186776876==--

