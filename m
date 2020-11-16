Content-Type: multipart/mixed; boundary="===============5847408672698164551=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: get neighbor reports early
Date: Mon, 16 Nov 2020 14:22:02 -0800
Message-ID: <20201116222202.3486443-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5847408672698164551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Waiting to request neighbor reports until we are in need of a roam
delays the roam time, and probably isn't as reliable since we are
most likely in a low RSSI state. Instead the neighbor report can
be requested immediately after connecting, saved, and used if/when
a roam is needed. The existing behavior is maintained if the early
neighbor report fails where a neighbor report is requested at the
time of the roam.

The code which parses the reports was factored out and shared
between the existing (late) neighbor report callback and the early
neighbor report callback.
---
 src/station.c | 140 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 46 deletions(-)

diff --git a/src/station.c b/src/station.c
index db36b748..8bd3e147 100644
--- a/src/station.c
+++ b/src/station.c
@@ -95,6 +95,9 @@ struct station {
 =

 	struct netconfig *netconfig;
 =

+	/* Set of frequencies to scan first when attempting a roam */
+	struct scan_freq_set *roam_freqs;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -1306,6 +1309,9 @@ static void station_reset_connection_state(struct sta=
tion *station)
 	station->connected_bss =3D NULL;
 	station->connected_network =3D NULL;
 =

+	if (station->roam_freqs)
+		scan_freq_set_free(station->roam_freqs);
+
 	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
 	l_dbus_property_changed(dbus, network_get_path(network),
@@ -1879,40 +1885,15 @@ static uint32_t station_freq_from_neighbor_report(c=
onst uint8_t *country,
 	return freq;
 }
 =

-static void station_neighbor_report_cb(struct netdev *netdev, int err,
-					const uint8_t *reports,
-					size_t reports_len, void *user_data)
+static void parse_neighbor_report(struct station *station,
+				const uint8_t *reports, size_t reports_len,
+				struct scan_freq_set **set)
 {
-	struct station *station =3D user_data;
 	struct ie_tlv_iter iter;
 	int count_md =3D 0, count_no_md =3D 0;
 	struct scan_freq_set *freq_set_md, *freq_set_no_md;
 	uint32_t current_freq =3D 0;
 	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
-	int r;
-
-	l_debug("ifindex: %u, error: %d(%s)",
-			netdev_get_ifindex(station->netdev),
-			err, err < 0 ? strerror(-err) : "");
-
-	/*
-	 * Check if we're still attempting to roam -- if dbus Disconnect
-	 * had been called in the meantime we just abort the attempt.
-	 */
-	if (!station->preparing_roam || err =3D=3D -ENODEV)
-		return;
-
-	if (!reports || err) {
-		r =3D station_roam_scan_known_freqs(station);
-
-		if (r =3D=3D -ENODATA)
-			l_debug("no neighbor report results or known freqs");
-
-		if (r < 0)
-			station_roam_failed(station);
-
-		return;
-	}
 =

 	freq_set_md =3D scan_freq_set_new();
 	freq_set_no_md =3D scan_freq_set_new();
@@ -2000,17 +1981,53 @@ static void station_neighbor_report_cb(struct netde=
v *netdev, int err,
 	 */
 	if (count_md) {
 		scan_freq_set_add(freq_set_md, current_freq);
-
-		r =3D station_roam_scan(station, freq_set_md);
+		*set =3D freq_set_md;
+		scan_freq_set_free(freq_set_no_md);
 	} else if (count_no_md) {
 		scan_freq_set_add(freq_set_no_md, current_freq);
-
-		r =3D station_roam_scan(station, freq_set_no_md);
+		*set =3D freq_set_no_md;
+		scan_freq_set_free(freq_set_md);
 	} else
-		r =3D station_roam_scan(station, NULL);
+		*set =3D NULL;
+}
+
+static void station_neighbor_report_cb(struct netdev *netdev, int err,
+					const uint8_t *reports,
+					size_t reports_len, void *user_data)
+{
+	struct station *station =3D user_data;
+	struct scan_freq_set *freq_set;
+	int r;
+
+	l_debug("ifindex: %u, error: %d(%s)",
+			netdev_get_ifindex(station->netdev),
+			err, err < 0 ? strerror(-err) : "");
+
+	/*
+	 * Check if we're still attempting to roam -- if dbus Disconnect
+	 * had been called in the meantime we just abort the attempt.
+	 */
+	if (!station->preparing_roam || err =3D=3D -ENODEV)
+		return;
+
+	if (!reports || err) {
+		r =3D station_roam_scan_known_freqs(station);
+
+		if (r =3D=3D -ENODATA)
+			l_debug("no neighbor report results or known freqs");
+
+		if (r < 0)
+			station_roam_failed(station);
+
+		return;
+	}
+
+	parse_neighbor_report(station, reports, reports_len, &freq_set);
+
+	r =3D station_roam_scan(station, freq_set);
 =

-	scan_freq_set_free(freq_set_md);
-	scan_freq_set_free(freq_set_no_md);
+	if (freq_set)
+		scan_freq_set_free(freq_set);
 =

 	if (r < 0)
 		station_roam_failed(station);
@@ -2028,19 +2045,24 @@ static void station_roam_trigger_cb(struct l_timeou=
t *timeout, void *user_data)
 	station->preparing_roam =3D true;
 =

 	/*
-	 * If current BSS supports Neighbor Reports, narrow the scan down
-	 * to channels occupied by known neighbors in the ESS.  This isn't
-	 * 100% reliable as the neighbor lists are not required to be
-	 * complete or current.  It is likely still better than doing a
-	 * full scan.  10.11.10.1: "A neighbor report may not be exhaustive
-	 * either by choice, or due to the fact that there may be neighbor
-	 * APs not known to the AP."
+	 * First try to use the neighbor report requested after connecting. If
+	 * none were obtained request a neighbor report now. If that fails,
+	 * scan any known frequencies.
 	 */
-	if (station->connected_bss->cap_rm_neighbor_report &&
-			!station->roam_no_orig_ap)
-		if (!netdev_neighbor_report_req(station->netdev,
-						station_neighbor_report_cb))
+	if (station->roam_freqs) {
+		if (station_roam_scan(station, station->roam_freqs) =3D=3D 0) {
+			l_debug("Using cached neighbor report for roam");
 			return;
+		}
+
+	} else if (station->connected_bss->cap_rm_neighbor_report &&
+			!station->roam_no_orig_ap) {
+		if (netdev_neighbor_report_req(station->netdev,
+					station_neighbor_report_cb) =3D=3D 0) {
+			l_debug("Requesting neighbor report for roam");
+			return;
+		}
+	}
 =

 	r =3D station_roam_scan_known_freqs(station);
 	if (r =3D=3D -ENODATA)
@@ -2317,6 +2339,23 @@ static void station_connect_dbus_reply(struct statio=
n *station,
 	dbus_pending_reply(&station->connect_pending, reply);
 }
 =

+static void station_early_neighbor_report_cb(struct netdev *netdev, int er=
r,
+					const uint8_t *reports,
+					size_t reports_len, void *user_data)
+{
+	struct station *station =3D user_data;
+
+	l_debug("ifindex: %u, error: %d(%s)",
+			netdev_get_ifindex(station->netdev),
+			err, err < 0 ? strerror(-err) : "");
+
+	if (!reports || err)
+		return;
+
+	parse_neighbor_report(station, reports, reports_len,
+				&station->roam_freqs);
+}
+
 static void station_connect_cb(struct netdev *netdev, enum netdev_result r=
esult,
 					void *event_data, void *user_data)
 {
@@ -2361,6 +2400,15 @@ static void station_connect_cb(struct netdev *netdev=
, enum netdev_result result,
 		return;
 	}
 =

+	/*
+	 * Get a neighbor report now so future roams can avoid waiting for
+	 * a report at that time
+	 */
+	if (station->connected_bss->cap_rm_neighbor_report) {
+		if (netdev_neighbor_report_req(station->netdev,
+					station_early_neighbor_report_cb) < 0)
+			l_warn("Could not request neighbor report");
+	}
 	network_connected(station->connected_network);
 =

 	if (station->netconfig)
-- =

2.26.2

--===============5847408672698164551==--

