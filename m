Content-Type: multipart/mixed; boundary="===============2114383428122119197=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/7] scan: refactor to use radio management module
Date: Thu, 25 Jun 2020 11:56:43 -0700
Message-ID: <20200625185645.30122-6-prestwoj@gmail.com>
In-Reply-To: <20200625185645.30122-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2114383428122119197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To use radio management scanning mostly remained the same.
start_next_scan_request was modified to be used as the work callback,
as well as not start the next scan if the current one was done
(since this is taken care of by radio management now). All calls to
start_next_scan_request were removed, and more or less replaced with
radio_mgmt_done.

scan_{suspend,resume} were both removed since radio management
priorities solve this for us. ANQP requests can be inserted ahead of
scan requests, which accomplishes the same thing.
---
 src/scan.c    | 104 +++++++++++++++-----------------------------------
 src/scan.h    |   3 --
 src/station.c |  16 +-------
 3 files changed, 31 insertions(+), 92 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 83804e57..c3e201d4 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -49,6 +49,7 @@
 #include "src/p2putil.h"
 #include "src/mpdu.h"
 #include "src/scan.h"
+#include "src/radio_mgmt.h"
 =

 #define SCAN_MAX_INTERVAL 320
 #define SCAN_INIT_INTERVAL 10
@@ -56,7 +57,8 @@
 static struct l_queue *scan_contexts;
 =

 static struct l_genl_family *nl80211;
-static uint32_t next_scan_request_id;
+
+struct scan_context;
 =

 struct scan_periodic {
 	struct l_timeout *timeout;
@@ -70,6 +72,7 @@ struct scan_periodic {
 };
 =

 struct scan_request {
+	struct scan_context *sc;
 	uint32_t id;
 	scan_trigger_func_t trigger;
 	scan_notify_func_t callback;
@@ -106,7 +109,6 @@ struct scan_context {
 	bool triggered:1;
 	/* Whether any commands from current request's queue have started */
 	bool started:1;
-	bool suspended:1;
 	struct wiphy *wiphy;
 };
 =

@@ -118,7 +120,7 @@ struct scan_results {
 	struct scan_request *sr;
 };
 =

-static bool start_next_scan_request(struct scan_context *sc);
+static bool start_next_scan_request(void *user_data);
 static void scan_periodic_rearm(struct scan_context *sc);
 =

 static bool scan_context_match(const void *a, const void *b)
@@ -159,7 +161,7 @@ static void scan_request_failed(struct scan_context *sc,
 	else if (sr->callback)
 		sr->callback(err, NULL, sr->userdata);
 =

-	scan_request_free(sr);
+	radio_mgmt_done(sc->wdev_id, sr->id);
 }
 =

 static struct scan_context *scan_context_new(uint64_t wdev_id)
@@ -180,11 +182,18 @@ static struct scan_context *scan_context_new(uint64_t=
 wdev_id)
 	return sc;
 }
 =

+static void scan_request_cancel(void *data)
+{
+	struct scan_request *sr =3D data;
+
+	radio_mgmt_done(sr->sc->wdev_id, sr->id);
+}
+
 static void scan_context_free(struct scan_context *sc)
 {
 	l_debug("sc: %p", sc);
 =

-	l_queue_destroy(sc->requests, scan_request_free);
+	l_queue_destroy(sc->requests, scan_request_cancel);
 =

 	if (sc->sp.timeout)
 		l_timeout_remove(sc->sp.timeout);
@@ -215,7 +224,6 @@ static void scan_request_triggered(struct l_genl_msg *m=
sg, void *userdata)
 		}
 =

 		l_queue_remove(sc->requests, sr);
-		start_next_scan_request(sc);
 =

 		scan_request_failed(sc, sr, err);
 =

@@ -532,35 +540,21 @@ static uint32_t scan_common(uint64_t wdev_id, bool pa=
ssive,
 		return 0;
 =

 	sr =3D l_new(struct scan_request, 1);
+	sr->sc =3D sc;
 	sr->trigger =3D trigger;
 	sr->callback =3D notify;
 	sr->userdata =3D userdata;
 	sr->destroy =3D destroy;
 	sr->passive =3D passive;
-	sr->id =3D ++next_scan_request_id;
 	sr->cmds =3D l_queue_new();
 =

 	scan_cmds_add(sr->cmds, sc, passive, params);
 =

-	/* Queue empty implies !sc->triggered && !sc->start_cmd_id */
-	if (!l_queue_isempty(sc->requests))
-		goto done;
-
-	if (sc->suspended)
-		goto done;
-
-	if (sc->state !=3D SCAN_STATE_NOT_RUNNING)
-		goto done;
-
-	if (!scan_request_send_trigger(sc, sr))
-		goto done;
-
-	sr->destroy =3D NULL;	/* Don't call destroy when returning error */
-	scan_request_free(sr);
-	return 0;
-done:
 	l_queue_push_tail(sc->requests, sr);
 =

+	sr->id =3D radio_mgmt_push(wdev_id, 2, start_next_scan_request, sr,
+					scan_request_free);
+
 	return sr->id;
 }
 =

@@ -633,6 +627,8 @@ bool scan_cancel(uint64_t wdev_id, uint32_t id)
 			sr->destroy =3D NULL;
 		}
 =

+		radio_mgmt_done(wdev_id, sr->id);
+
 		return true;
 	}
 =

@@ -649,11 +645,11 @@ bool scan_cancel(uint64_t wdev_id, uint32_t id)
 		sc->start_cmd_id =3D 0;
 		l_queue_remove(sc->requests, sr);
 		sc->started =3D false;
-		start_next_scan_request(sc);
 	} else
 		l_queue_remove(sc->requests, sr);
 =

-	scan_request_free(sr);
+	radio_mgmt_done(wdev_id, sr->id);
+
 	return true;
 }
 =

@@ -832,34 +828,22 @@ static void scan_periodic_rearm(struct scan_context *=
sc)
 						scan_periodic_timeout_destroy);
 }
 =

-static bool start_next_scan_request(struct scan_context *sc)
+static bool start_next_scan_request(void *user_data)
 {
-	struct scan_request *sr =3D l_queue_peek_head(sc->requests);
+	struct scan_request *sr =3D user_data;
+	struct scan_context *sc =3D sr->sc;
 =

-	if (sc->suspended)
-		return true;
-
-	if (sc->state !=3D SCAN_STATE_NOT_RUNNING)
-		return true;
-
-	if (sc->start_cmd_id || sc->get_scan_cmd_id)
-		return true;
-
-	while (sr) {
-		if (!scan_request_send_trigger(sc, sr))
-			return true;
-
-		scan_request_failed(sc, sr, -EIO);
+	if (!scan_request_send_trigger(sc, sr))
+		return false;
 =

-		sr =3D l_queue_peek_head(sc->requests);
-	}
+	scan_request_failed(sc, sr, -EIO);
 =

 	if (sc->sp.retry) {
 		sc->sp.retry =3D false;
 		scan_periodic_queue(sc);
 	}
 =

-	return false;
+	return true;
 }
 =

 static bool scan_parse_vendor_specific(struct scan_bss *bss, const void *d=
ata,
@@ -1511,9 +1495,7 @@ static void scan_finished(struct scan_context *sc,
 		 * taken care of sending the next command for a new or ongoing
 		 * scan, or scheduling the next periodic scan.
 		 */
-		start_next_scan_request(sc);
-
-		scan_request_free(sr);
+		radio_mgmt_done(sc->wdev_id, sr->id);
 	} else if (sc->sp.callback)
 		new_owner =3D sc->sp.callback(err, bss_list, sc->sp.userdata);
 =

@@ -2133,32 +2115,6 @@ bool scan_wdev_remove(uint64_t wdev_id)
 	return true;
 }
 =

-bool scan_suspend(uint64_t wdev_id)
-{
-	struct scan_context *sc;
-
-	sc =3D l_queue_find(scan_contexts, scan_context_match, &wdev_id);
-	if (!sc)
-		return false;
-
-	sc->suspended =3D true;
-
-	return true;
-}
-
-void scan_resume(uint64_t wdev_id)
-{
-	struct scan_context *sc;
-
-	sc =3D l_queue_find(scan_contexts, scan_context_match, &wdev_id);
-	if (!sc)
-		return;
-
-	sc->suspended =3D false;
-
-	start_next_scan_request(sc);
-}
-
 static int scan_init(void)
 {
 	const struct l_settings *config =3D iwd_get_config();
diff --git a/src/scan.h b/src/scan.h
index aeeddf05..df0cc17c 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -170,6 +170,3 @@ bool scan_freq_set_isempty(const struct scan_freq_set *=
set);
 =

 bool scan_wdev_add(uint64_t wdev_id);
 bool scan_wdev_remove(uint64_t wdev_id);
-
-bool scan_suspend(uint64_t wdev_id);
-void scan_resume(uint64_t wdev_id);
diff --git a/src/station.c b/src/station.c
index b23fd1a0..dd9347a8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -530,8 +530,6 @@ request_done:
 		station_network_foreach(station, network_add_foreach, station);
 		station_autoconnect_next(station);
 	}
-
-	scan_resume(netdev_get_wdev_id(station->netdev));
 }
 =

 static bool station_start_anqp(struct station *station, struct network *ne=
twork,
@@ -661,19 +659,7 @@ void station_set_scan_results(struct station *station,
 =

 	l_hashmap_foreach_remove(station->networks, process_network, station);
 =

-	/*
-	 * ANQP requests are scheduled in the same manor as scans, and cannot
-	 * be done simultaneously. To avoid long queue times (waiting for a
-	 * scan to finish) its best to stop scanning, do ANQP, then resume
-	 * scanning.
-	 *
-	 * TODO: It may be possible for some hardware to actually scan and do
-	 * ANQP at the same time. Detecting this could allow us to continue
-	 * scanning.
-	 */
-	if (wait_for_anqp)
-		scan_suspend(netdev_get_wdev_id(station->netdev));
-	else if (add_to_autoconnect) {
+	if (!wait_for_anqp && add_to_autoconnect) {
 		station_network_foreach(station, network_add_foreach, station);
 		station_autoconnect_next(station);
 	}
-- =

2.21.1

--===============2114383428122119197==--

