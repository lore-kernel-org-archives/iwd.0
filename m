Content-Type: multipart/mixed; boundary="===============7196530350459366367=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] station: Don't expire BSSes between freq subset scans
Date: Thu, 17 Dec 2020 02:28:59 +0100
Message-ID: <20201217012859.820525-2-andrew.zaborowski@intel.com>
In-Reply-To: <20201217012859.820525-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7196530350459366367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a parameter to station_set_scan_results to allow skipping the
removal of old BSSes.  In the DBus-triggered scan only expire BSSes
after having gone through the full supported frequency set.

It should be safe to pass partial scan results to
station_set_scan_results() when not expiring BSSes so using this new
parameter I guess we could also call it for roam scan results.
---
 src/station.c | 31 ++++++++++++++++++++++---------
 src/station.h |  2 +-
 src/wsc.c     |  4 ++--
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/src/station.c b/src/station.c
index 79b026b9..1e3706af 100644
--- a/src/station.c
+++ b/src/station.c
@@ -610,7 +610,8 @@ static bool station_start_anqp(struct station *station,=
 struct network *network,
  */
 void station_set_scan_results(struct station *station,
 						struct l_queue *new_bss_list,
-						bool add_to_autoconnect)
+						bool add_to_autoconnect,
+						bool expire)
 {
 	const struct l_queue_entry *bss_entry;
 	struct network *network;
@@ -624,7 +625,8 @@ void station_set_scan_results(struct station *station,
 	l_queue_destroy(station->autoconnect_list, l_free);
 	station->autoconnect_list =3D l_queue_new();
 =

-	station_bss_list_remove_expired_bsses(station);
+	if (expire)
+		station_bss_list_remove_expired_bsses(station);
 =

 	for (bss_entry =3D l_queue_get_entries(station->bss_list); bss_entry;
 						bss_entry =3D bss_entry->next) {
@@ -1022,7 +1024,7 @@ static bool new_scan_results(int err, struct l_queue =
*bss_list, void *userdata)
 		return false;
 =

 	autoconnect =3D station_is_autoconnecting(station);
-	station_set_scan_results(station, bss_list, autoconnect);
+	station_set_scan_results(station, bss_list, autoconnect, true);
 =

 	return true;
 }
@@ -1088,7 +1090,7 @@ static bool station_quick_scan_results(int err, struc=
t l_queue *bss_list,
 		goto done;
 =

 	autoconnect =3D station_is_autoconnecting(station);
-	station_set_scan_results(station, bss_list, autoconnect);
+	station_set_scan_results(station, bss_list, autoconnect, true);
 =

 done:
 	if (station->state =3D=3D STATION_STATE_AUTOCONNECT_QUICK)
@@ -2889,10 +2891,21 @@ static struct l_dbus_message *station_dbus_get_hidd=
en_access_points(
 	return reply;
 }
 =

-static void station_dbus_scan_done(struct station *station)
+static void station_dbus_scan_done(struct station *station, bool expired)
 {
 	station->dbus_scan_id =3D 0;
 =

+	if (!expired) {
+		/*
+		 * We haven't dropped old BSS records from bss_list during
+		 * this scan yet so do it now.  Call station_set_scan_results
+		 * with an empty new BSS list to do this.  Not the cheapest
+		 * but this should only happen when station_dbus_scan_done is
+		 * called early, i.e. due to an error.
+		 */
+		station_set_scan_results(station, l_queue_new(), false, true);
+	}
+
 	station_property_set_scanning(station, false);
 }
 =

@@ -2910,7 +2923,7 @@ static void station_dbus_scan_triggered(int err, void=
 *user_data)
 			dbus_pending_reply(&station->scan_pending, reply);
 		}
 =

-		station_dbus_scan_done(station);
+		station_dbus_scan_done(station, false);
 		return;
 	}
 =

@@ -2937,7 +2950,7 @@ static bool station_dbus_scan_results(int err, struct=
 l_queue *bss_list, void *u
 	bool last_subset;
 =

 	if (err) {
-		station_dbus_scan_done(station);
+		station_dbus_scan_done(station, false);
 		return false;
 	}
 =

@@ -2945,12 +2958,12 @@ static bool station_dbus_scan_results(int err, stru=
ct l_queue *bss_list, void *u
 	last_subset =3D next_idx >=3D L_ARRAY_SIZE(station->scan_freqs_order) ||
 		station->scan_freqs_order[next_idx] =3D=3D NULL;
 =

-	station_set_scan_results(station, bss_list, autoconnect);
+	station_set_scan_results(station, bss_list, autoconnect, last_subset);
 =

 	station->dbus_scan_subset_idx =3D next_idx;
 =

 	if (last_subset || !station_dbus_scan_subset(station))
-		station_dbus_scan_done(station);
+		station_dbus_scan_done(station, last_subset);
 =

 	return true;
 }
diff --git a/src/station.h b/src/station.h
index 17a0f8df..c4fd505b 100644
--- a/src/station.h
+++ b/src/station.h
@@ -65,7 +65,7 @@ struct network *station_network_find(struct station *stat=
ion, const char *ssid,
 					enum security security);
 =

 void station_set_scan_results(struct station *station, struct l_queue *bss=
_list,
-				bool add_to_autoconnect);
+				bool add_to_autoconnect, bool expire);
 =

 enum station_state station_get_state(struct station *station);
 uint32_t station_add_state_watch(struct station *station,
diff --git a/src/wsc.c b/src/wsc.c
index aec9900c..5ba63a64 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -787,7 +787,7 @@ static bool push_button_scan_results(int err, struct l_=
queue *bss_list,
 	}
 =

 	wsc_cancel_scan(wsc);
-	station_set_scan_results(wsc->station, bss_list, false);
+	station_set_scan_results(wsc->station, bss_list, false, true);
 =

 	l_debug("Found AP to connect to: %s",
 			util_address_to_string(target->addr));
@@ -931,7 +931,7 @@ static bool pin_scan_results(int err, struct l_queue *b=
ss_list, void *userdata)
 	}
 =

 	wsc_cancel_scan(wsc);
-	station_set_scan_results(wsc->station, bss_list, false);
+	station_set_scan_results(wsc->station, bss_list, false, true);
 =

 	l_debug("Found AP to connect to: %s",
 			util_address_to_string(target->addr));
-- =

2.27.0

--===============7196530350459366367==--

