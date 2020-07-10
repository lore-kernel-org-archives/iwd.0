Content-Type: multipart/mixed; boundary="===============8070382196867949057=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/2] scan: refactor to use wiphy radio work queue
Date: Fri, 10 Jul 2020 09:10:39 -0700
Message-ID: <20200710161040.9374-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8070382196867949057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To use the wiphy radio work queue, scanning mostly remained the same.
start_next_scan_request was modified to be used as the work callback,
as well as not start the next scan if the current one was done
(since this is taken care of by wiphy work queue now). All
calls to start_next_scan_request were removed, and more or less
replaced with wiphy_radio_work_done.

scan_{suspend,resume} were both removed since radio management
priorities solve this for us. ANQP requests can be inserted ahead of
scan requests, which accomplishes the same thing.
---
 src/scan.c    | 143 +++++++++++++++++++++-----------------------------
 src/scan.h    |   3 --
 src/station.c |  16 +-----
 3 files changed, 62 insertions(+), 100 deletions(-)

v4:
 - Fixed some tricky logic inside the scan results to handle a busy
   result due to external scans, as well as a race where an external
   scan is triggered just before our own.

diff --git a/src/scan.c b/src/scan.c
index 83804e57..f1bb3646 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -56,7 +56,8 @@
 static struct l_queue *scan_contexts;
 =

 static struct l_genl_family *nl80211;
-static uint32_t next_scan_request_id;
+
+struct scan_context;
 =

 struct scan_periodic {
 	struct l_timeout *timeout;
@@ -70,7 +71,7 @@ struct scan_periodic {
 };
 =

 struct scan_request {
-	uint32_t id;
+	struct scan_context *sc;
 	scan_trigger_func_t trigger;
 	scan_notify_func_t callback;
 	void *userdata;
@@ -79,6 +80,7 @@ struct scan_request {
 	struct l_queue *cmds;
 	/* The time the current scan was started. Reported in TRIGGER_SCAN */
 	uint64_t start_time_tsf;
+	struct wiphy_radio_work_item work;
 };
 =

 struct scan_context {
@@ -106,7 +108,7 @@ struct scan_context {
 	bool triggered:1;
 	/* Whether any commands from current request's queue have started */
 	bool started:1;
-	bool suspended:1;
+	bool work_started:1;
 	struct wiphy *wiphy;
 };
 =

@@ -118,7 +120,7 @@ struct scan_results {
 	struct scan_request *sr;
 };
 =

-static bool start_next_scan_request(struct scan_context *sc);
+static bool start_next_scan_request(struct wiphy_radio_work_item *item);
 static void scan_periodic_rearm(struct scan_context *sc);
 =

 static bool scan_context_match(const void *a, const void *b)
@@ -134,12 +136,13 @@ static bool scan_request_match(const void *a, const v=
oid *b)
 	const struct scan_request *sr =3D a;
 	uint32_t id =3D L_PTR_TO_UINT(b);
 =

-	return sr->id =3D=3D id;
+	return sr->work.id =3D=3D id;
 }
 =

-static void scan_request_free(void *data)
+static void scan_request_free(struct wiphy_radio_work_item *item)
 {
-	struct scan_request *sr =3D data;
+	struct scan_request *sr =3D l_container_of(item, struct scan_request,
+							work);
 =

 	if (sr->destroy)
 		sr->destroy(sr->userdata);
@@ -159,12 +162,12 @@ static void scan_request_failed(struct scan_context *=
sc,
 	else if (sr->callback)
 		sr->callback(err, NULL, sr->userdata);
 =

-	scan_request_free(sr);
+	wiphy_radio_work_done(sc->wiphy, sr->work.id);
 }
 =

 static struct scan_context *scan_context_new(uint64_t wdev_id)
 {
-	struct wiphy *wiphy =3D wiphy_find(wdev_id >> 32);
+	struct wiphy *wiphy =3D wiphy_find_by_wdev(wdev_id);
 	struct scan_context *sc;
 =

 	if (!wiphy)
@@ -180,11 +183,18 @@ static struct scan_context *scan_context_new(uint64_t=
 wdev_id)
 	return sc;
 }
 =

+static void scan_request_cancel(void *data)
+{
+	struct scan_request *sr =3D data;
+
+	wiphy_radio_work_done(sr->sc->wiphy, sr->work.id);
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
@@ -215,7 +225,6 @@ static void scan_request_triggered(struct l_genl_msg *m=
sg, void *userdata)
 		}
 =

 		l_queue_remove(sc->requests, sr);
-		start_next_scan_request(sc);
 =

 		scan_request_failed(sc, sr, err);
 =

@@ -517,6 +526,11 @@ static int scan_request_send_trigger(struct scan_conte=
xt *sc,
 	return -EIO;
 }
 =

+static const struct wiphy_radio_work_item_ops work_ops =3D {
+	.do_work =3D start_next_scan_request,
+	.destroy =3D scan_request_free,
+};
+
 static uint32_t scan_common(uint64_t wdev_id, bool passive,
 				const struct scan_parameters *params,
 				scan_trigger_func_t trigger,
@@ -532,36 +546,19 @@ static uint32_t scan_common(uint64_t wdev_id, bool pa=
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

-	return sr->id;
+	return wiphy_radio_work_insert(sc->wiphy, &sr->work, 2, &work_ops);
 }
 =

 uint32_t scan_passive(uint64_t wdev_id, struct scan_freq_set *freqs,
@@ -622,7 +619,7 @@ bool scan_cancel(uint64_t wdev_id, uint32_t id)
 	if (!sr)
 		return false;
 =

-	/* If already triggered, just zero out the callback */
+	/* If already triggered, just zero out the callback. */
 	if (sr =3D=3D l_queue_peek_head(sc->requests) && sc->triggered) {
 		l_debug("Scan is at the top of the queue and triggered");
 =

@@ -649,11 +646,11 @@ bool scan_cancel(uint64_t wdev_id, uint32_t id)
 		sc->start_cmd_id =3D 0;
 		l_queue_remove(sc->requests, sr);
 		sc->started =3D false;
-		start_next_scan_request(sc);
 	} else
 		l_queue_remove(sc->requests, sr);
 =

-	scan_request_free(sr);
+	wiphy_radio_work_done(sc->wiphy, sr->work.id);
+
 	return true;
 }
 =

@@ -832,34 +829,30 @@ static void scan_periodic_rearm(struct scan_context *=
sc)
 						scan_periodic_timeout_destroy);
 }
 =

-static bool start_next_scan_request(struct scan_context *sc)
+static bool start_next_scan_request(struct wiphy_radio_work_item *item)
 {
-	struct scan_request *sr =3D l_queue_peek_head(sc->requests);
+	struct scan_request *sr =3D l_container_of(item,
+						struct scan_request, work);
+	struct scan_context *sc =3D sr->sc;
 =

-	if (sc->suspended)
-		return true;
+	sc->work_started =3D true;
 =

 	if (sc->state !=3D SCAN_STATE_NOT_RUNNING)
-		return true;
-
-	if (sc->start_cmd_id || sc->get_scan_cmd_id)
-		return true;
+		return false;
 =

-	while (sr) {
-		if (!scan_request_send_trigger(sc, sr))
-			return true;
+	if (!scan_request_send_trigger(sc, sr))
+		return false;
 =

-		scan_request_failed(sc, sr, -EIO);
+	sc->work_started =3D false;
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
@@ -1511,9 +1504,7 @@ static void scan_finished(struct scan_context *sc,
 		 * taken care of sending the next command for a new or ongoing
 		 * scan, or scheduling the next periodic scan.
 		 */
-		start_next_scan_request(sc);
-
-		scan_request_free(sr);
+		wiphy_radio_work_done(sc->wiphy, sr->work.id);
 	} else if (sc->sp.callback)
 		new_owner =3D sc->sp.callback(err, bss_list, sc->sp.userdata);
 =

@@ -1645,6 +1636,7 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 		/* Was this our own scan or an external scan */
 		if (sc->triggered) {
 			sc->triggered =3D false;
+			sc->work_started =3D false;
 =

 			if (!sr->callback) {
 				scan_finished(sc, -ECANCELED, NULL, sr);
@@ -1677,9 +1669,20 @@ static void scan_notify(struct l_genl_msg *msg, void=
 *user_data)
 			sr =3D NULL;
 		}
 =

-		/* Send the next command of a new or an ongoing request */
-		if (send_next)
-			start_next_scan_request(sc);
+		/*
+		 * Send the next command of an ongoing request, or continue with
+		 * a previously busy scan attempt due to an external scan. A
+		 * temporary scan_request object is used (rather than 'sr')
+		 * because the state of 'sr' tells us if the results should
+		 * be used either as normal scan results, or to take advantage
+		 * of the external scan as a 'free' periodic scan of sorts.
+		 */
+		if (sc->work_started || send_next) {
+			struct scan_request *next =3D l_queue_peek_head(
+								sc->requests);
+
+			start_next_scan_request(&next->work);
+		}
 =

 		if (!get_results)
 			break;
@@ -1720,17 +1723,19 @@ static void scan_notify(struct l_genl_msg *msg, voi=
d *user_data)
 =

 		if (sc->triggered) {
 			sc->triggered =3D false;
+			sc->work_started =3D false;
 =

 			scan_finished(sc, -ECANCELED, NULL, sr);
 		} else {
-			/*
+			 /*
 			 * If this was an external scan that got aborted
 			 * we may be able to now queue our own scan although
 			 * the abort could also have been triggered by the
 			 * hardware or the driver because of another activity
 			 * starting in which case we should just get an EBUSY.
 			 */
-			start_next_scan_request(sc);
+			if (sc->work_started)
+				start_next_scan_request(&sr->work);
 		}
 =

 		break;
@@ -2133,32 +2138,6 @@ bool scan_wdev_remove(uint64_t wdev_id)
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
index 0622e810..35f4a96d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -531,8 +531,6 @@ request_done:
 		station_network_foreach(station, network_add_foreach, station);
 		station_autoconnect_next(station);
 	}
-
-	scan_resume(netdev_get_wdev_id(station->netdev));
 }
 =

 static bool station_start_anqp(struct station *station, struct network *ne=
twork,
@@ -662,19 +660,7 @@ void station_set_scan_results(struct station *station,
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

--===============8070382196867949057==--

