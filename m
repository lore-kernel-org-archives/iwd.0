Content-Type: multipart/mixed; boundary="===============4519751084324798987=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/6] scan: set scan priority via scan_common
Date: Tue, 11 Jan 2022 09:45:10 -0800
Message-ID: <20220111174514.1074967-2-prestwoj@gmail.com>
In-Reply-To: 20220111174514.1074967-1-prestwoj@gmail.com

--===============4519751084324798987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a priority argument to scan_common rather than hard
coding it when inserting the work item and uses the newly
defined wiphy priority for scanning.
---
 src/scan.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 54159dfd..e6ee3007 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -607,6 +607,7 @@ static struct scan_request *scan_request_new(struct sca=
n_context *sc,
 =

 static uint32_t scan_common(uint64_t wdev_id, bool passive,
 				const struct scan_parameters *params,
+				int priority,
 				scan_trigger_func_t trigger,
 				scan_notify_func_t notify, void *userdata,
 				scan_destroy_func_t destroy)
@@ -625,7 +626,8 @@ static uint32_t scan_common(uint64_t wdev_id, bool pass=
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
@@ -634,8 +636,8 @@ uint32_t scan_passive(uint64_t wdev_id, struct scan_fre=
q_set *freqs,
 {
 	struct scan_parameters params =3D { .freqs =3D freqs };
 =

-	return scan_common(wdev_id, true, &params, trigger, notify,
-							userdata, destroy);
+	return scan_common(wdev_id, true, &params, WIPHY_WORK_PRIORITY_SCAN,
+				trigger, notify, userdata, destroy);
 }
 =

 uint32_t scan_passive_full(uint64_t wdev_id,
@@ -644,8 +646,8 @@ uint32_t scan_passive_full(uint64_t wdev_id,
 			scan_notify_func_t notify, void *userdata,
 			scan_destroy_func_t destroy)
 {
-	return scan_common(wdev_id, true, params, trigger,
-				notify, userdata, destroy);
+	return scan_common(wdev_id, true, params, WIPHY_WORK_PRIORITY_SCAN,
+				trigger, notify, userdata, destroy);
 }
 =

 uint32_t scan_active(uint64_t wdev_id, uint8_t *extra_ie, size_t extra_ie_=
size,
@@ -658,7 +660,7 @@ uint32_t scan_active(uint64_t wdev_id, uint8_t *extra_i=
e, size_t extra_ie_size,
 	params.extra_ie =3D extra_ie;
 	params.extra_ie_size =3D extra_ie_size;
 =

-	return scan_common(wdev_id, false, &params,
+	return scan_common(wdev_id, false, &params, WIPHY_WORK_PRIORITY_SCAN,
 					trigger, notify, userdata, destroy);
 }
 =

@@ -667,7 +669,7 @@ uint32_t scan_active_full(uint64_t wdev_id,
 			scan_trigger_func_t trigger, scan_notify_func_t notify,
 			void *userdata, scan_destroy_func_t destroy)
 {
-	return scan_common(wdev_id, false, params,
+	return scan_common(wdev_id, false, params, WIPHY_WORK_PRIORITY_SCAN,
 					trigger, notify, userdata, destroy);
 }
 =

@@ -795,7 +797,8 @@ uint32_t scan_owe_hidden(uint64_t wdev_id, struct l_que=
ue *list,
 done:
 	l_queue_push_tail(sc->requests, sr);
 =

-	return wiphy_radio_work_insert(sc->wiphy, &sr->work, 2, &work_ops);
+	return wiphy_radio_work_insert(sc->wiphy, &sr->work,
+					WIPHY_WORK_PRIORITY_SCAN, &work_ops);
 }
 =

 bool scan_cancel(uint64_t wdev_id, uint32_t id)
-- =

2.31.1

--===============4519751084324798987==--

