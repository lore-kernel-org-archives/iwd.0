Content-Type: multipart/mixed; boundary="===============5948313131116643098=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2] scan: Sort scan_requests by wiphy work item priority
Date: Fri, 29 Apr 2022 11:58:19 -0500
Message-ID: <20220429165819.12162-1-denkenz@gmail.com>

--===============5948313131116643098==
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

v2 - Send priority as user_data since wiphy_radio_work_item part of the
request hasn't been initialized yet (not inserted onto the wiphy work
queue) and can't be compared.

 src/scan.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index b0824e72ebaf..cc6e682c93ee 100644
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
+	const struct scan_request *cur =3D b;
+	int priority =3D L_PTR_TO_INT(user_data);
+
+	if (cur->work.priority <=3D priority)
+		return 1;
+
+	return -1;
+}
+
 static uint32_t scan_common(uint64_t wdev_id, bool passive,
 				const struct scan_parameters *params,
 				int priority,
@@ -630,7 +641,12 @@ static uint32_t scan_common(uint64_t wdev_id, bool pas=
sive,
 =

 	scan_cmds_add(sr->cmds, sc, passive, params);
 =

-	l_queue_push_tail(sc->requests, sr);
+	/*
+	 * sr->work isn't initialized yet, it will be done by
+	 * wiphy_radio_work_insert().  Pass the priority as user_data instead
+	 */
+	l_queue_insert(sc->requests, sr, insert_by_priority,
+						L_INT_TO_PTR(priority));
 =

 	return wiphy_radio_work_insert(sc->wiphy, &sr->work,
 					priority, &work_ops);
@@ -801,7 +817,8 @@ uint32_t scan_owe_hidden(uint64_t wdev_id, struct l_que=
ue *list,
 	}
 =

 done:
-	l_queue_push_tail(sc->requests, sr);
+	l_queue_insert(sc->requests, sr, insert_by_priority,
+				L_INT_TO_PTR(WIPHY_WORK_PRIORITY_SCAN));
 =

 	return wiphy_radio_work_insert(sc->wiphy, &sr->work,
 					WIPHY_WORK_PRIORITY_SCAN, &work_ops);
-- =

2.32.0

--===============5948313131116643098==--

