Content-Type: multipart/mixed; boundary="===============5405529024968392657=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/3] scan: parse the scan start time
Date: Thu, 21 Nov 2019 10:29:03 -0800
Message-ID: <20191121182905.20409-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5405529024968392657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The kernel sends NL80211_ATTR_SCAN_START_TIME_TSF with CMD_TRIGGER and
RRM requires this value for beacon measurement reports.

The start time is parsed during CMD_TRIGGER and set into the scan request.
A getter was added to obtain this time value for an already triggered
scan.

After making the change, the SCAN_ABORTED case was cleaned up a bit to
remove the local scan_request usage in favor of the one used for all the
other cases.
---
 src/scan.c | 41 ++++++++++++++++++++++++++++++++++-------
 src/scan.h |  2 ++
 2 files changed, 36 insertions(+), 7 deletions(-)

-v4:
 * Store the start time in the request, no context
 * Move the scan request peek outside of the switch so all cases can
   use it.

diff --git a/src/scan.c b/src/scan.c
index e007ce5d..e2d73601 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -75,6 +75,8 @@ struct scan_request {
 	scan_destroy_func_t destroy;
 	bool passive:1; /* Active or Passive scan? */
 	struct l_queue *cmds;
+	/* The time the current scan was started. Reported in TRIGGER_SCAN */
+	uint64_t start_time_tsf;
 };
 =

 struct scan_context {
@@ -778,6 +780,25 @@ bool scan_periodic_stop(uint64_t wdev_id)
 	return true;
 }
 =

+uint64_t scan_get_triggered_time(uint64_t wdev_id, uint32_t id)
+{
+	struct scan_context *sc;
+	struct scan_request *sr;
+
+	sc =3D l_queue_find(scan_contexts, scan_context_match, &wdev_id);
+	if (!sc)
+		return 0;
+
+	if (!sc->triggered)
+		return 0;
+
+	sr =3D l_queue_find(sc->requests, scan_request_match, L_UINT_TO_PTR(id));
+	if (!sr)
+		return 0;
+
+	return sr->start_time_tsf;
+}
+
 static void scan_periodic_timeout(struct l_timeout *timeout, void *user_da=
ta)
 {
 	struct scan_context *sc =3D user_data;
@@ -1439,6 +1460,8 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 	uint32_t wiphy_id;
 	struct scan_context *sc;
 	bool active_scan =3D false;
+	uint64_t start_time_tsf =3D 0;
+	struct scan_request *sr;
 =

 	cmd =3D l_genl_msg_get_command(msg);
 =

@@ -1461,15 +1484,22 @@ static void scan_notify(struct l_genl_msg *msg, voi=
d *user_data)
 		case NL80211_ATTR_SCAN_SSIDS:
 			active_scan =3D true;
 			break;
+		case NL80211_ATTR_SCAN_START_TIME_TSF:
+			if (len !=3D sizeof(uint64_t))
+				return;
+
+			start_time_tsf =3D l_get_u64(data);
+			break;
 		}
 	}
 =

+	sr =3D l_queue_peek_head(sc->requests);
+
 	switch (cmd) {
 	case NL80211_CMD_NEW_SCAN_RESULTS:
 	{
 		struct l_genl_msg *scan_msg;
 		struct scan_results *results;
-		struct scan_request *sr =3D l_queue_peek_head(sc->requests);
 		bool send_next =3D false;
 		bool get_results =3D false;
 =

@@ -1543,12 +1573,11 @@ static void scan_notify(struct l_genl_msg *msg, voi=
d *user_data)
 		else
 			sc->state =3D SCAN_STATE_PASSIVE;
 =

+		sr->start_time_tsf =3D start_time_tsf;
+
 		break;
 =

 	case NL80211_CMD_SCAN_ABORTED:
-	{
-		struct scan_request *sr =3D l_queue_peek_head(sc->requests);
-
 		if (sc->state =3D=3D SCAN_STATE_NOT_RUNNING)
 			break;
 =

@@ -1557,8 +1586,7 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 		if (sc->triggered) {
 			sc->triggered =3D false;
 =

-			scan_finished(sc, -ECANCELED, NULL,
-					l_queue_peek_head(sc->requests));
+			scan_finished(sc, -ECANCELED, NULL, sr);
 		} else if (sr && !sc->start_cmd_id && !sc->get_scan_cmd_id) {
 			/*
 			 * If this was an external scan that got aborted
@@ -1572,7 +1600,6 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 =

 		break;
 	}
-	}
 }
 =

 uint8_t scan_freq_to_channel(uint32_t freq, enum scan_band *out_band)
diff --git a/src/scan.h b/src/scan.h
index 8fc2aa56..b6c4e12d 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -124,6 +124,8 @@ void scan_periodic_start(uint64_t wdev_id, scan_trigger=
_func_t trigger,
 				scan_notify_func_t func, void *userdata);
 bool scan_periodic_stop(uint64_t wdev_id);
 =

+uint64_t scan_get_triggered_time(uint64_t wdev_id, uint32_t id);
+
 void scan_bss_free(struct scan_bss *bss);
 int scan_bss_rank_compare(const void *a, const void *b, void *user);
 =

-- =

2.17.1

--===============5405529024968392657==--

