Content-Type: multipart/mixed; boundary="===============1538028964453332696=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/6] scan: don't special case periodic scan work
Date: Tue, 11 Jan 2022 09:45:11 -0800
Message-ID: <20220111174514.1074967-3-prestwoj@gmail.com>
In-Reply-To: 20220111174514.1074967-1-prestwoj@gmail.com

--===============1538028964453332696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Periodic scans were handled specially where they were only
started if no other requests were pending in the scan queue.
This is fine, and what we want, but this can actually be
handled automatically by nature of the wiphy work queue rather
than needing to check the request queue explicitly.

Instead we can insert periodic scans at a lower priority than
other scans. This puts them at the end of the work queue, as
well as allows future requests to jump ahead if a periodic scan
has not yet started.

Eventually, once all pending scans are done, the peridoic scan
may begin. This is no different than the preivous behavior and
avoids the need for any special checks once scan requests
complete.

One check was added to address the problem of the periodic scan
timer firing before the scan could even start. Currently this
happened to be handled fine in scan_periodic_queue, as it checks
the queue length. Since this check was removed we must see check
for this condition inside scan_periodic_timeout.
---
 src/scan.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index e6ee3007..a82e6257 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -69,7 +69,6 @@ struct scan_periodic {
 	scan_trigger_func_t trigger;
 	scan_notify_func_t callback;
 	void *userdata;
-	bool retry:1;
 	uint32_t id;
 	bool needs_active_scan:1;
 };
@@ -881,27 +880,32 @@ static bool scan_periodic_notify(int err, struct l_qu=
eue *bss_list,
 	return false;
 }
 =

+static void scan_periodic_destroy(void *user_data)
+{
+	struct scan_context *sc =3D user_data;
+
+	sc->sp.id =3D 0;
+}
+
 static bool scan_periodic_queue(struct scan_context *sc)
 {
-	if (!l_queue_isempty(sc->requests)) {
-		sc->sp.retry =3D true;
-		return false;
-	}
+	struct scan_parameters params =3D {};
 =

 	if (sc->sp.needs_active_scan && known_networks_has_hidden()) {
-		struct scan_parameters params =3D {
-			.randomize_mac_addr_hint =3D true
-		};
+		params.randomize_mac_addr_hint =3D true;
 =

 		sc->sp.needs_active_scan =3D false;
-
-		sc->sp.id =3D scan_active_full(sc->wdev_id, &params,
-						scan_periodic_triggered,
-						scan_periodic_notify, sc, NULL);
+		sc->sp.id =3D scan_common(sc->wdev_id, false, &params,
+					WIPHY_WORK_PRIORITY_PERIODIC_SCAN,
+					scan_periodic_triggered,
+					scan_periodic_notify, sc,
+					scan_periodic_destroy);
 	} else
-		sc->sp.id =3D scan_passive(sc->wdev_id, NULL,
-						scan_periodic_triggered,
-						scan_periodic_notify, sc, NULL);
+		sc->sp.id =3D scan_common(sc->wdev_id, true, &params,
+					WIPHY_WORK_PRIORITY_PERIODIC_SCAN,
+					scan_periodic_triggered,
+					scan_periodic_notify, sc,
+					scan_periodic_destroy);
 =

 	return sc->sp.id !=3D 0;
 }
@@ -973,7 +977,6 @@ bool scan_periodic_stop(uint64_t wdev_id)
 	sc->sp.trigger =3D NULL;
 	sc->sp.callback =3D NULL;
 	sc->sp.userdata =3D NULL;
-	sc->sp.retry =3D false;
 	sc->sp.needs_active_scan =3D false;
 =

 	return true;
@@ -1004,6 +1007,16 @@ static void scan_periodic_timeout(struct l_timeout *=
timeout, void *user_data)
 =

 	l_debug("scan_periodic_timeout: %" PRIx64, sc->wdev_id);
 =

+	/*
+	 * Timeout triggered before periodic scan could even start, just rearm
+	 * with the same interval.
+	 */
+	if (sc->sp.id) {
+		l_debug("Periodic scan timer called before scan could start!");
+		scan_periodic_rearm(sc);
+		return;
+	}
+
 	sc->sp.interval *=3D 2;
 	if (sc->sp.interval > SCAN_MAX_INTERVAL)
 		sc->sp.interval =3D SCAN_MAX_INTERVAL;
@@ -1048,11 +1061,6 @@ static bool start_next_scan_request(struct wiphy_rad=
io_work_item *item)
 =

 	scan_request_failed(sc, sr, -EIO);
 =

-	if (sc->sp.retry) {
-		sc->sp.retry =3D false;
-		scan_periodic_queue(sc);
-	}
-
 	return true;
 }
 =

-- =

2.31.1

--===============1538028964453332696==--

