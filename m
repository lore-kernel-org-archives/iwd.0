Content-Type: multipart/mixed; boundary="===============7086871192945114289=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 2/3] station: separate FT-over-DS stages
Date: Fri, 30 Apr 2021 10:47:03 -0700
Message-ID: <20210430174704.272253-2-prestwoj@gmail.com>
In-Reply-To: <20210430174704.272253-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7086871192945114289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FT-over-DS was refactored to separate the FT action frame and
reassociation. From stations standpoint IWD needs to call
netdev_fast_transition_over_ds_action prior to actually roaming.
For now these two stages are being combined and the action
roam happens immediately after the action response callback.
---
 src/station.c | 81 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 15 deletions(-)

v6:
 * Added station_roam_retry to avoid need the over_ds flag
 * Delay ROAMING state until after a successful action frame
   response.

diff --git a/src/station.c b/src/station.c
index c89b1901..442f8ee2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1582,6 +1582,21 @@ static void station_roamed(struct station *station)
 	station_enter_state(station, STATION_STATE_CONNECTED);
 }
 =

+static void station_roam_retry(struct station *station)
+{
+	/*
+	 * If we're still connected to the old BSS, only clear preparing_roam
+	 * and reattempt in 60 seconds if signal level is still low at that
+	 * time.
+	 */
+	station->preparing_roam =3D false;
+	station->roam_scan_full =3D false;
+	station->ap_directed_roaming =3D false;
+
+	if (station->signal_low)
+		station_roam_timeout_rearm(station, roam_retry_interval);
+}
+
 static void station_roam_failed(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
@@ -1620,17 +1635,7 @@ static void station_roam_failed(struct station *stat=
ion)
 	}
 =

 delayed_retry:
-	/*
-	 * If we're still connected to the old BSS, only clear preparing_roam
-	 * and reattempt in 60 seconds if signal level is still low at that
-	 * time.
-	 */
-	station->preparing_roam =3D false;
-	station->roam_scan_full =3D false;
-	station->ap_directed_roaming =3D false;
-
-	if (station->signal_low)
-		station_roam_timeout_rearm(station, roam_retry_interval);
+	station_roam_retry(station);
 }
 =

 static void station_netconfig_event_handler(enum netconfig_event event,
@@ -1713,6 +1718,45 @@ static bool bss_match_bssid(const void *a, const voi=
d *b)
 	return !memcmp(bss->addr, bssid, sizeof(bss->addr));
 }
 =

+static void station_fast_transition_ds_cb(struct netdev *netdev,
+					uint16_t status, const uint8_t *bssid,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	struct scan_bss *bss;
+
+	if (status !=3D 0)
+		goto failed;
+
+	/*
+	 * TODO: In the future it may be desired to start sending out these
+	 * FT-over-DS action frames at the time of connecting then be able to
+	 * roam immediately when required. If this is being done we can simply
+	 * bail out now as ft already caches the entires. But since this was
+	 * initiated due to a need to roam, do so now.
+	 */
+
+	/* Make sure we still have our BSS */
+	bss =3D l_queue_find(station->bss_list, bss_match_bssid, bssid);
+	if (!bss)
+		goto failed;
+
+	l_debug("Starting FT-over-DS roam");
+
+	if (netdev_fast_transition_over_ds(station->netdev, bss,
+					station_fast_transition_cb) < 0)
+		goto failed;
+
+	station->connected_bss =3D bss;
+	station->preparing_roam =3D false;
+	station_enter_state(station, STATION_STATE_ROAMING);
+
+	return;
+
+failed:
+	station_roam_retry(station);
+}
+
 static void station_preauthenticate_cb(struct netdev *netdev,
 					enum netdev_result result,
 					const uint8_t *pmk, void *user_data)
@@ -1810,11 +1854,18 @@ static void station_transition_start(struct station=
 *station,
 		/* FT-over-DS can be better suited for these situations */
 		if ((hs->mde[4] & 1) && (station->ap_directed_roaming ||
 				station->signal_low)) {
-			if (netdev_fast_transition_over_ds(station->netdev, bss,
-					station_fast_transition_cb) < 0) {
-				station_roam_failed(station);
-				return;
+			if (netdev_fast_transition_over_ds_action(
+					station->netdev, bss,
+					station_fast_transition_ds_cb,
+					station) < 0) {
+				station_roam_retry(station);
 			}
+
+			/*
+			 * Set connected_bss/preparing_roam/state only on a
+			 * successful FT-over-DS action frame response
+			 */
+			return;
 		} else {
 			if (netdev_fast_transition(station->netdev, bss,
 					station_fast_transition_cb) < 0) {
-- =

2.26.2

--===============7086871192945114289==--

