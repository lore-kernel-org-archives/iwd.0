Content-Type: multipart/mixed; boundary="===============8105989218322905362=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] scan: remove periodic scans from queue on abort
Date: Mon, 07 Feb 2022 13:28:06 -0800
Message-ID: <20220207212806.449583-1-prestwoj@gmail.com>

--===============8105989218322905362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The periodic scan code was refactored to make normal scans and
periodic scans consistent by keeping both in the same queue. But
that change left out the abort path where periodic scans were not
actually removed from the queue.

This fixes a rare crash when a periodic scan has been triggered and
the device goes down. This path never removes the request from the
queue but still frees it. Then when the scan context is removed the
stale request is freed again.

0 0x4bb65b in scan_request_cancel src/scan.c:202
1 0x64313c in l_queue_clear ell/queue.c:107
2 0x643348 in l_queue_destroy ell/queue.c:82
3 0x4bbfb7 in scan_context_free src/scan.c:209
4 0x4c9a78 in scan_wdev_remove src/scan.c:2115
5 0x42fecd in netdev_free src/netdev.c:965
6 0x445827 in netdev_destroy src/netdev.c:6507
7 0x52beb9 in manager_config_notify src/manager.c:765
8 0x67084b in process_multicast ell/genl.c:1029
9 0x67084b in received_data ell/genl.c:1096
10 0x65e790 in io_callback ell/io.c:120
11 0x65aaae in l_main_iterate ell/main.c:478
12 0x65b213 in l_main_run ell/main.c:525
13 0x65b213 in l_main_run ell/main.c:507
14 0x65b72c in l_main_run_with_signal ell/main.c:647
15 0x4124e7 in main src/main.c:532
---
 src/scan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 99813952..1ab6420b 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1993,9 +1993,10 @@ static void scan_notify(struct l_genl_msg *msg, void=
 *user_data)
 			sr->triggered =3D false;
 =

 			/* If periodic scan, don't report the abort */
-			if (sr->periodic)
+			if (sr->periodic) {
+				l_queue_remove(sc->requests, sr);
 				wiphy_radio_work_done(sc->wiphy, sr->work.id);
-			else
+			} else
 				scan_finished(sc, -ECANCELED, NULL, NULL, sr);
 		} else if (wiphy_radio_work_is_running(sc->wiphy,
 							sr->work.id)) {
-- =

2.31.1

--===============8105989218322905362==--

