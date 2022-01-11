Content-Type: multipart/mixed; boundary="===============5032660328184249727=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/3] scan: set scan priority via scan_common
Date: Mon, 10 Jan 2022 16:15:18 -0800
Message-ID: <20220111001519.1013183-2-prestwoj@gmail.com>
In-Reply-To: 20220111001519.1013183-1-prestwoj@gmail.com

--===============5032660328184249727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a priority argument to scan_common rather than hard
coding it when inserting the work item
---
 src/scan.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 54159dfd..96907e59 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -52,6 +52,8 @@
 #include "src/band.h"
 #include "src/scan.h"
 =

+#define SCAN_WORK_PRIORITY 2
+
 /* User configurable options */
 static double RANK_5G_FACTOR;
 static uint32_t SCAN_MAX_INTERVAL;
@@ -607,6 +609,7 @@ static struct scan_request *scan_request_new(struct sca=
n_context *sc,
 =

 static uint32_t scan_common(uint64_t wdev_id, bool passive,
 				const struct scan_parameters *params,
+				int priority,
 				scan_trigger_func_t trigger,
 				scan_notify_func_t notify, void *userdata,
 				scan_destroy_func_t destroy)
@@ -625,7 +628,8 @@ static uint32_t scan_common(uint64_t wdev_id, bool pass=
ive,
 =

 	l_queue_push_tail(sc->requests, sr);
 =

-	return wiphy_radio_work_insert(sc->wiphy, &sr->work, 2, &work_ops);
+	return wiphy_radio_work_insert(sc->wiphy, &sr->work,
+					priority, &work_ops);
 }
 =

 uint32_t scan_passive(uint64_t wdev_id, struct scan_freq_set *freqs,
@@ -634,8 +638,8 @@ uint32_t scan_passive(uint64_t wdev_id, struct scan_fre=
q_set *freqs,
 {
 	struct scan_parameters params =3D { .freqs =3D freqs };
 =

-	return scan_common(wdev_id, true, &params, trigger, notify,
-							userdata, destroy);
+	return scan_common(wdev_id, true, &params, SCAN_WORK_PRIORITY, trigger,
+				notify, userdata, destroy);
 }
 =

 uint32_t scan_passive_full(uint64_t wdev_id,
@@ -644,7 +648,7 @@ uint32_t scan_passive_full(uint64_t wdev_id,
 			scan_notify_func_t notify, void *userdata,
 			scan_destroy_func_t destroy)
 {
-	return scan_common(wdev_id, true, params, trigger,
+	return scan_common(wdev_id, true, params, SCAN_WORK_PRIORITY, trigger,
 				notify, userdata, destroy);
 }
 =

@@ -658,7 +662,7 @@ uint32_t scan_active(uint64_t wdev_id, uint8_t *extra_i=
e, size_t extra_ie_size,
 	params.extra_ie =3D extra_ie;
 	params.extra_ie_size =3D extra_ie_size;
 =

-	return scan_common(wdev_id, false, &params,
+	return scan_common(wdev_id, false, &params, SCAN_WORK_PRIORITY,
 					trigger, notify, userdata, destroy);
 }
 =

@@ -667,7 +671,7 @@ uint32_t scan_active_full(uint64_t wdev_id,
 			scan_trigger_func_t trigger, scan_notify_func_t notify,
 			void *userdata, scan_destroy_func_t destroy)
 {
-	return scan_common(wdev_id, false, params,
+	return scan_common(wdev_id, false, params, SCAN_WORK_PRIORITY,
 					trigger, notify, userdata, destroy);
 }
 =

@@ -795,7 +799,8 @@ uint32_t scan_owe_hidden(uint64_t wdev_id, struct l_que=
ue *list,
 done:
 	l_queue_push_tail(sc->requests, sr);
 =

-	return wiphy_radio_work_insert(sc->wiphy, &sr->work, 2, &work_ops);
+	return wiphy_radio_work_insert(sc->wiphy, &sr->work,
+					SCAN_WORK_PRIORITY, &work_ops);
 }
 =

 bool scan_cancel(uint64_t wdev_id, uint32_t id)
-- =

2.31.1

--===============5032660328184249727==--

