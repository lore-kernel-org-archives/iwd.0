Content-Type: multipart/mixed; boundary="===============7181740395571328339=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] scan: Sort scan_requests by wiphy work item priority
Date: Fri, 29 Apr 2022 09:37:50 -0500
Message-ID: <20220429143750.6364-1-denkenz@gmail.com>

--===============7181740395571328339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Periodic scan requests are meant to be performed with a lower priority
than normal scan requests.  They're thus given a different priority when
inserting them into the wiphy work queue.  Unfortunately, the priority
is not taken into account when they are inserted into the
sr->requests queue.  This can result in the scanning code being confused
since it assumes the top of the queue is always the next scheduled or
currently ongoing scan.  As a result any further wiphy_work might never be
started properly.

Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert(=
) Inserting work item 3
Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() =
Starting work item 3
Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_timeout() 1
Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert(=
) Inserting work item 4
Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert(=
) Inserting work item 5
Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() =
Work item 3 done
Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() =
Starting work item 5
Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan notifi=
cation Trigger Scan(33)
Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_request_triggered() =
Passive scan triggered for wdev 1
Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_triggered()=
 Periodic scan triggered for wdev 1

In the above log, scan request 5 (triggered by dbus) is started before
scan request 4 (periodic scan).  Yet the scanning code thinks scan
request 4 was triggered.

Fix this by using the wiphy_work priority to sort the sr->requests queue
so that the scans are ordered in the same manner.

Reported-by: Alvin =C5=A0ipraga <ALSI(a)bang-olufsen.dk>
---
 src/scan.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index b0824e72ebaf..dd4fca531b36 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -611,6 +611,17 @@ static struct scan_request *scan_request_new(struct sc=
an_context *sc,
 	return sr;
 }
 =

+static int insert_by_priority(const void *a, const void *b, void *user_dat=
a)
+{
+	const struct scan_request *new =3D a;
+	const struct scan_request *cur =3D b;
+
+	if (cur->work.priority <=3D new->work.priority)
+		return 1;
+
+	return -1;
+}
+
 static uint32_t scan_common(uint64_t wdev_id, bool passive,
 				const struct scan_parameters *params,
 				int priority,
@@ -630,7 +641,7 @@ static uint32_t scan_common(uint64_t wdev_id, bool pass=
ive,
 =

 	scan_cmds_add(sr->cmds, sc, passive, params);
 =

-	l_queue_push_tail(sc->requests, sr);
+	l_queue_insert(sc->requests, sr, insert_by_priority, NULL);
 =

 	return wiphy_radio_work_insert(sc->wiphy, &sr->work,
 					priority, &work_ops);
@@ -801,7 +812,7 @@ uint32_t scan_owe_hidden(uint64_t wdev_id, struct l_que=
ue *list,
 	}
 =

 done:
-	l_queue_push_tail(sc->requests, sr);
+	l_queue_insert(sc->requests, sr, insert_by_priority, NULL);
 =

 	return wiphy_radio_work_insert(sc->wiphy, &sr->work,
 					WIPHY_WORK_PRIORITY_SCAN, &work_ops);
-- =

2.32.0

--===============7181740395571328339==--

