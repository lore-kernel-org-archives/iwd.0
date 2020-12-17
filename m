Content-Type: multipart/mixed; boundary="===============6070154703174690568=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] station: Split DBus scans into 3 frequency subsets
Date: Thu, 17 Dec 2020 02:28:58 +0100
Message-ID: <20201217012859.820525-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6070154703174690568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A scan normally takes about 2 seconds on my dual-band wifi adapter when
connected.  The drivers will normally probe on each supported channel in
some unspecified order and will have new partial results after each step
but the kernel sends NL80211_CMD_NEW_SCAN_RESULTS only when the full
scan request finishes, and for segmented scans we will wait for all
segments to finish before calling back from scan_active() or
scan_passive().

To improve user experience define our own channel order favouring the
2.4 channels 1, 6 and 11 and probe those as an individual scan request
so we can update most our DBus org.connman.iwd.Network objects more
quickly, before continuing with 5GHz band channels, updating DBus
objects again and finally the other 2.4GHz band channels.

The overall DBus-triggered scan on my wifi adapter takes about the same
time but my measurements were not very strict, and were not very
consistent with and without this change.  With the change most Network
objects are updated after about 200ms though, meaning that I get most
of the network updates in the nm-applet UI 200ms from opening the
network list.  The 5GHz band channels take another 1 to 1.5s to scan and
remaining 2.4GHz band channels another ~300ms.

Hopefully this is similar when using other drivers although I can easily
imagine a driver that parallelizes 2.4GHz and 5GHz channel probing using
two radios, or uses 2, 4 or another number of dual-band radios to probe
2, 4, ... channels simultanously.  We'd then lose some of the
performance benefit.  The faster scan results may be worth the longer
overall scan time anyway.
I'm also assuming that the wiphy's supported frequency list is exactly
what was scanned when we passed no frequency list to
NL80211_CMD_TRIGGER_SCAN and we won't get errors for passing some
frequency that shouldn't have been scanned.
---
 src/station.c | 120 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 107 insertions(+), 13 deletions(-)

diff --git a/src/station.c b/src/station.c
index ed3741d3..79b026b9 100644
--- a/src/station.c
+++ b/src/station.c
@@ -98,6 +98,10 @@ struct station {
 	/* Set of frequencies to scan first when attempting a roam */
 	struct scan_freq_set *roam_freqs;
 =

+	/* Frequencies split into subsets by priority */
+	struct scan_freq_set *scan_freqs_order[3];
+	unsigned int dbus_scan_subset_idx;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -2885,6 +2889,13 @@ static struct l_dbus_message *station_dbus_get_hidde=
n_access_points(
 	return reply;
 }
 =

+static void station_dbus_scan_done(struct station *station)
+{
+	station->dbus_scan_id =3D 0;
+
+	station_property_set_scanning(station, false);
+}
+
 static void station_dbus_scan_triggered(int err, void *user_data)
 {
 	struct station *station =3D user_data;
@@ -2893,25 +2904,68 @@ static void station_dbus_scan_triggered(int err, vo=
id *user_data)
 	l_debug("station_scan_triggered: %i", err);
 =

 	if (err < 0) {
-		reply =3D dbus_error_from_errno(err, station->scan_pending);
-		dbus_pending_reply(&station->scan_pending, reply);
+		if (station->scan_pending) {
+			reply =3D dbus_error_from_errno(err,
+							station->scan_pending);
+			dbus_pending_reply(&station->scan_pending, reply);
+		}
+
+		station_dbus_scan_done(station);
 		return;
 	}
 =

-	l_debug("Scan triggered for %s", netdev_get_name(station->netdev));
+	l_debug("Scan triggered for %s subset %i",
+		netdev_get_name(station->netdev),
+		station->dbus_scan_subset_idx);
 =

-	reply =3D l_dbus_message_new_method_return(station->scan_pending);
-	l_dbus_message_set_arguments(reply, "");
-	dbus_pending_reply(&station->scan_pending, reply);
+	if (station->scan_pending) {
+		reply =3D l_dbus_message_new_method_return(station->scan_pending);
+		l_dbus_message_set_arguments(reply, "");
+		dbus_pending_reply(&station->scan_pending, reply);
+	}
 =

 	station_property_set_scanning(station, true);
 }
 =

-static void station_dbus_scan_destroy(void *userdata)
+static bool station_dbus_scan_subset(struct station *station);
+
+static bool station_dbus_scan_results(int err, struct l_queue *bss_list, v=
oid *userdata)
 {
 	struct station *station =3D userdata;
+	unsigned int next_idx =3D station->dbus_scan_subset_idx + 1;
+	bool autoconnect;
+	bool last_subset;
 =

-	station->dbus_scan_id =3D 0;
+	if (err) {
+		station_dbus_scan_done(station);
+		return false;
+	}
+
+	autoconnect =3D station_is_autoconnecting(station);
+	last_subset =3D next_idx >=3D L_ARRAY_SIZE(station->scan_freqs_order) ||
+		station->scan_freqs_order[next_idx] =3D=3D NULL;
+
+	station_set_scan_results(station, bss_list, autoconnect);
+
+	station->dbus_scan_subset_idx =3D next_idx;
+
+	if (last_subset || !station_dbus_scan_subset(station))
+		station_dbus_scan_done(station);
+
+	return true;
+}
+
+static bool station_dbus_scan_subset(struct station *station)
+{
+	unsigned int idx =3D station->dbus_scan_subset_idx;
+
+	station->dbus_scan_id =3D station_scan_trigger(station,
+						station->scan_freqs_order[idx],
+						station_dbus_scan_triggered,
+						station_dbus_scan_results,
+						NULL);
+
+	return station->dbus_scan_id !=3D 0;
 }
 =

 static struct l_dbus_message *station_dbus_scan(struct l_dbus *dbus,
@@ -2928,12 +2982,9 @@ static struct l_dbus_message *station_dbus_scan(stru=
ct l_dbus *dbus,
 	if (station->state =3D=3D STATION_STATE_CONNECTING)
 		return dbus_error_busy(message);
 =

-	station->dbus_scan_id =3D station_scan_trigger(station, NULL,
-						station_dbus_scan_triggered,
-						new_scan_results,
-						station_dbus_scan_destroy);
+	station->dbus_scan_subset_idx =3D 0;
 =

-	if (!station->dbus_scan_id)
+	if (!station_dbus_scan_subset(station))
 		return dbus_error_failed(message);
 =

 	station->scan_pending =3D l_dbus_message_ref(message);
@@ -3209,6 +3260,41 @@ struct scan_bss *station_get_connected_bss(struct st=
ation *station)
 	return station->connected_bss;
 }
 =

+static void station_add_one_freq(uint32_t freq, void *user_data)
+{
+	struct station *station =3D user_data;
+
+	if (freq > 3000)
+		scan_freq_set_add(station->scan_freqs_order[1], freq);
+	else if (!scan_freq_set_contains(station->scan_freqs_order[0], freq))
+		scan_freq_set_add(station->scan_freqs_order[2], freq);
+}
+
+static void station_fill_scan_freq_subsets(struct station *station)
+{
+	const struct scan_freq_set *supported =3D
+		wiphy_get_supported_freqs(station->wiphy);
+
+	/*
+	 * Scan the 2.4GHz "social channels" first, 5GHz second, if supported,
+	 * all other 2.4GHz channels last.  To be refined as needed.
+	 */
+	station->scan_freqs_order[0] =3D scan_freq_set_new();
+	scan_freq_set_add(station->scan_freqs_order[0], 2412);
+	scan_freq_set_add(station->scan_freqs_order[0], 2437);
+	scan_freq_set_add(station->scan_freqs_order[0], 2462);
+
+	station->scan_freqs_order[1] =3D scan_freq_set_new();
+	station->scan_freqs_order[2] =3D scan_freq_set_new();
+	scan_freq_set_foreach(supported, station_add_one_freq, station);
+
+	if (scan_freq_set_isempty(station->scan_freqs_order[1])) {
+		scan_freq_set_free(station->scan_freqs_order[1]);
+		station->scan_freqs_order[1] =3D station->scan_freqs_order[2];
+		station->scan_freqs_order[2] =3D NULL;
+	}
+}
+
 static struct station *station_create(struct netdev *netdev)
 {
 	struct station *station;
@@ -3240,6 +3326,8 @@ static struct station *station_create(struct netdev *=
netdev)
 =

 	station->anqp_pending =3D l_queue_new();
 =

+	station_fill_scan_freq_subsets(station);
+
 	return station;
 }
 =

@@ -3306,6 +3394,12 @@ static void station_free(struct station *station)
 =

 	l_queue_destroy(station->anqp_pending, remove_anqp);
 =

+	scan_freq_set_free(station->scan_freqs_order[0]);
+	scan_freq_set_free(station->scan_freqs_order[1]);
+
+	if (station->scan_freqs_order[2])
+		scan_freq_set_free(station->scan_freqs_order[2]);
+
 	l_free(station);
 }
 =

-- =

2.27.0

--===============6070154703174690568==--

