Content-Type: multipart/mixed; boundary="===============9200675069407827478=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 6/6] scan: refactor to use offchannel module
Date: Wed, 17 Jun 2020 10:56:45 -0700
Message-ID: <20200617175645.31197-6-prestwoj@gmail.com>
In-Reply-To: <20200617175645.31197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9200675069407827478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To use offchannel scanning mostly remained the same.
start_next_scan_request was modified to be used as the offchannel work
callback, as well as not start the next scan if the current one was
done (since this is taken care of by offchannel now). All calls to
start_next_scan_request were removed, and more or less replaced with
offchan_work_done.

Since scan_suspend is per wdev we must iterate all the requests
and suspend each using offchan_work_suspend. And the opposite is
done for resuming. A small feature was added to scan_suspend/resume
(ref counting) to prevent a single call to scan_resume from resuming
if other modules had previously suspended. This way scanning doesnt
get resumed out from under a module from somewhere else.

At the moment nothing else besides ANQP suspends scanning, but this may
change. Station may want to suspend scanning while connecting because
it could cause delays connection. A carefully timed scan could end up
being started after CMD_CONNECT but before eapol. This could be handled
by simply returning Busy, but because the scan could take place after
connecting we might as well honor the users request, just delayed until
after connecting.
---
 src/scan.c | 114 +++++++++++++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 51 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 83804e57..d13d4223 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -49,6 +49,7 @@
 #include "src/p2putil.h"
 #include "src/mpdu.h"
 #include "src/scan.h"
+#include "src/offchannel.h"
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
@@ -106,7 +109,7 @@ struct scan_context {
 	bool triggered:1;
 	/* Whether any commands from current request's queue have started */
 	bool started:1;
-	bool suspended:1;
+	int32_t suspended;
 	struct wiphy *wiphy;
 };
 =

@@ -118,7 +121,7 @@ struct scan_results {
 	struct scan_request *sr;
 };
 =

-static bool start_next_scan_request(struct scan_context *sc);
+static bool start_next_scan_request(void *user_data);
 static void scan_periodic_rearm(struct scan_context *sc);
 =

 static bool scan_context_match(const void *a, const void *b)
@@ -159,7 +162,7 @@ static void scan_request_failed(struct scan_context *sc,
 	else if (sr->callback)
 		sr->callback(err, NULL, sr->userdata);
 =

-	scan_request_free(sr);
+	offchan_work_done(sc->wdev_id, sr->id);
 }
 =

 static struct scan_context *scan_context_new(uint64_t wdev_id)
@@ -180,11 +183,18 @@ static struct scan_context *scan_context_new(uint64_t=
 wdev_id)
 	return sc;
 }
 =

+static void scan_request_cancel(void *data)
+{
+	struct scan_request *sr =3D data;
+
+	offchan_work_done(sr->sc->wdev_id, sr->id);
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

@@ -532,35 +541,24 @@ static uint32_t scan_common(uint64_t wdev_id, bool pa=
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

+	sr->id =3D offchan_work_push(wdev_id, sc->suspended > 0 ?
+					OFFCHAN_PRIORITY_SUSPENDED :
+					OFFCHAN_PRIORITY_NORMAL,
+					start_next_scan_request, sr,
+					scan_request_free);
+
 	return sr->id;
 }
 =

@@ -633,6 +631,8 @@ bool scan_cancel(uint64_t wdev_id, uint32_t id)
 			sr->destroy =3D NULL;
 		}
 =

+		offchan_work_done(wdev_id, sr->id);
+
 		return true;
 	}
 =

@@ -649,11 +649,11 @@ bool scan_cancel(uint64_t wdev_id, uint32_t id)
 		sc->start_cmd_id =3D 0;
 		l_queue_remove(sc->requests, sr);
 		sc->started =3D false;
-		start_next_scan_request(sc);
 	} else
 		l_queue_remove(sc->requests, sr);
 =

-	scan_request_free(sr);
+	offchan_work_done(wdev_id, sr->id);
+
 	return true;
 }
 =

@@ -832,34 +832,22 @@ static void scan_periodic_rearm(struct scan_context *=
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
@@ -1511,9 +1499,7 @@ static void scan_finished(struct scan_context *sc,
 		 * taken care of sending the next command for a new or ongoing
 		 * scan, or scheduling the next periodic scan.
 		 */
-		start_next_scan_request(sc);
-
-		scan_request_free(sr);
+		offchan_work_done(sc->wdev_id, sr->id);
 	} else if (sc->sp.callback)
 		new_owner =3D sc->sp.callback(err, bss_list, sc->sp.userdata);
 =

@@ -2133,6 +2119,26 @@ bool scan_wdev_remove(uint64_t wdev_id)
 	return true;
 }
 =

+static void scan_request_suspend(void *data, void *user_data)
+{
+	struct scan_request *sr =3D data;
+	uint64_t *wdev_id =3D user_data;
+
+	offchan_work_suspend(*wdev_id, sr->id);
+}
+
+static void scan_request_resume(void *data, void *user_data)
+{
+	struct scan_request *sr =3D data;
+	uint64_t *wdev_id =3D user_data;
+
+	offchan_work_resume(*wdev_id, sr->id);
+}
+
+/*
+ * This will suspend any work items in offchannel, but leave the request
+ * queue untouched so all pending scans can be resumed later.
+ */
 bool scan_suspend(uint64_t wdev_id)
 {
 	struct scan_context *sc;
@@ -2141,7 +2147,11 @@ bool scan_suspend(uint64_t wdev_id)
 	if (!sc)
 		return false;
 =

-	sc->suspended =3D true;
+	/* only suspend requests once */
+	if (sc->suspended =3D=3D 0)
+		l_queue_foreach(sc->requests, scan_request_suspend, &wdev_id);
+
+	sc->suspended++;
 =

 	return true;
 }
@@ -2154,9 +2164,11 @@ void scan_resume(uint64_t wdev_id)
 	if (!sc)
 		return;
 =

-	sc->suspended =3D false;
+	if (sc->suspended > 0)
+		sc->suspended--;
 =

-	start_next_scan_request(sc);
+	if (sc->suspended =3D=3D 0)
+		l_queue_foreach(sc->requests, scan_request_resume, &wdev_id);
 }
 =

 static int scan_init(void)
-- =

2.21.1

--===============9200675069407827478==--

