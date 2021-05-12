Content-Type: multipart/mixed; boundary="===============5090723339631604704=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] station: send FT-over-DS actions upon connection
Date: Wed, 12 May 2021 12:21:42 -0700
Message-ID: <20210512192144.348398-5-prestwoj@gmail.com>
In-Reply-To: <20210512192144.348398-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5090723339631604704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Roam times can be slightly improved by sending out the FT-over-DS
action frames to any BSS in the mobility domain immediately after
connecting. This preauthenticates IWD to each AP which means
Reassociation can happen right away when a roam is needed.

When a roam is needed station_transition_start will first try
FT-over-DS (if supported) via netdev_fast_transtion_over_ds. The
return is checked and if netdev has no cached entries FT-over-Air
will be used instead.
---
 src/station.c | 97 +++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/src/station.c b/src/station.c
index b9368ef2..9e1b9cc0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1720,45 +1720,6 @@ static bool bss_match_bssid(const void *a, const voi=
d *b)
 	return !memcmp(bss->addr, bssid, sizeof(bss->addr));
 }
 =

-static void station_fast_transition_ds_cb(struct netdev *netdev,
-					uint16_t status, const uint8_t *bssid,
-					void *user_data)
-{
-	struct station *station =3D user_data;
-	struct scan_bss *bss;
-
-	if (status !=3D 0)
-		goto failed;
-
-	/*
-	 * TODO: In the future it may be desired to start sending out these
-	 * FT-over-DS action frames at the time of connecting then be able to
-	 * roam immediately when required. If this is being done we can simply
-	 * bail out now as ft already caches the entires. But since this was
-	 * initiated due to a need to roam, do so now.
-	 */
-
-	/* Make sure we still have our BSS */
-	bss =3D l_queue_find(station->bss_list, bss_match_bssid, bssid);
-	if (!bss)
-		goto failed;
-
-	l_debug("Starting FT-over-DS roam");
-
-	if (netdev_fast_transition_over_ds(station->netdev, bss,
-					station_fast_transition_cb) < 0)
-		goto failed;
-
-	station->connected_bss =3D bss;
-	station->preparing_roam =3D false;
-	station_enter_state(station, STATION_STATE_ROAMING);
-
-	return;
-
-failed:
-	station_roam_retry(station);
-}
-
 static void station_preauthenticate_cb(struct netdev *netdev,
 					enum netdev_result result,
 					const uint8_t *pmk, void *user_data)
@@ -1849,6 +1810,7 @@ static void station_transition_start(struct station *=
station,
 	enum security security =3D network_get_security(connected);
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
+	int ret;
 =

 	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
 			util_address_to_string(bss->addr));
@@ -1868,19 +1830,21 @@ static void station_transition_start(struct station=
 *station,
 =

 		/* FT-over-DS can be better suited for these situations */
 		if ((hs->mde[4] & 1) && station->signal_low) {
-			if (netdev_fast_transition_over_ds_action(
-					station->netdev, bss,
-					station_fast_transition_ds_cb,
-					station) < 0) {
+			ret =3D netdev_fast_transition_over_ds(station->netdev,
+					bss, station_fast_transition_cb);
+			/* No action responses from this BSS, try over air */
+			if (ret =3D=3D -ENOENT)
+				goto try_over_air;
+			else if (ret < 0) {
+				/*
+				 * If we are here FT-over-air will not work
+				 * either (identical checks) so try again later.
+				 */
 				station_roam_retry(station);
+				return;
 			}
-
-			/*
-			 * Set connected_bss/preparing_roam/state only on a
-			 * successful FT-over-DS action frame response
-			 */
-			return;
 		} else {
+try_over_air:
 			if (netdev_fast_transition(station->netdev, bss,
 					station_fast_transition_cb) < 0) {
 				station_roam_failed(station);
@@ -2512,10 +2476,36 @@ static void station_connect_dbus_reply(struct stati=
on *station,
 	dbus_pending_reply(&station->connect_pending, reply);
 }
 =

+static void foreach_over_ds_action(void *data, void *user_data)
+{
+	struct scan_bss *bss =3D data;
+	struct station *station =3D user_data;
+	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
+	const char *ssid =3D network_get_ssid(station->connected_network);
+
+	if (bss->ssid_len !=3D strlen(ssid))
+		return;
+
+	if (memcmp(bss->ssid, ssid, bss->ssid_len))
+		return;
+
+	if (bss =3D=3D station->connected_bss)
+		return;
+
+	/*
+	 * Fire and forget. Netdev will maintain a cache of responses and
+	 * when the time comes these can be referenced for a roam
+	 */
+	if (station_can_fast_transition(hs, bss))
+		netdev_fast_transition_over_ds_action(station->netdev, bss,
+							NULL, NULL);
+}
+
 static void station_connect_cb(struct netdev *netdev, enum netdev_result r=
esult,
 					void *event_data, void *user_data)
 {
 	struct station *station =3D user_data;
+	struct handshake_state *hs =3D netdev_get_handshake(netdev);
 =

 	l_debug("%u, result: %d", netdev_get_ifindex(station->netdev), result);
 =

@@ -2566,6 +2556,15 @@ static void station_connect_cb(struct netdev *netdev=
, enum netdev_result result,
 			l_warn("Could not request neighbor report");
 	}
 =

+	/*
+	 * If this network supports FT-over-DS send initial action frames now
+	 * to prepare for future roams.
+	 */
+	if (station_can_fast_transition(hs, station->connected_bss) &&
+						(hs->mde[4] & 1))
+		l_queue_foreach(station->bss_list, foreach_over_ds_action,
+					station);
+
 	network_connected(station->connected_network);
 =

 	if (station->netconfig)
-- =

2.31.1

--===============5090723339631604704==--

