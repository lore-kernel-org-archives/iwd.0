Content-Type: multipart/mixed; boundary="===============5424813496923733484=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] station: use wiphy radio work queue for roams
Date: Thu, 02 Jul 2020 10:35:33 -0700
Message-ID: <20200702173533.8712-8-prestwoj@gmail.com>
In-Reply-To: <20200702173533.8712-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5424813496923733484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The wiphy radio work queue is now used for the roaming path in
station. station_transition_start was modified to be the worker
function and station->connect_pending_bss was reused to hold the
BSS roam candidate.
---
 src/station.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/src/station.c b/src/station.c
index 113f030b..38f3eefd 100644
--- a/src/station.c
+++ b/src/station.c
@@ -94,6 +94,8 @@ struct station {
 =

 	struct netconfig *netconfig;
 =

+	struct wiphy_radio_work_item work;
+
 	bool preparing_roam : 1;
 	bool signal_low : 1;
 	bool roam_no_orig_ap : 1;
@@ -1316,6 +1318,8 @@ static void station_roamed(struct station *station)
 		netconfig_reconfigure(station->netconfig);
 =

 	station_enter_state(station, STATION_STATE_CONNECTED);
+
+	wiphy_radio_work_done(station->wiphy, station->work.id);
 }
 =

 static void station_roam_failed(struct station *station)
@@ -1338,6 +1342,8 @@ static void station_roam_failed(struct station *stati=
on)
 		station_disassociated(station);
 	else if (station->signal_low)
 		station_roam_timeout_rearm(station, 60);
+
+	wiphy_radio_work_done(station->wiphy, station->work.id);
 }
 =

 static void station_netconfig_event_handler(enum netconfig_event event,
@@ -1484,12 +1490,13 @@ static void station_preauthenticate_cb(struct netde=
v *netdev,
 	station_transition_reassociate(station, bss, new_hs);
 }
 =

-static void station_transition_start(struct station *station,
-							struct scan_bss *bss)
+static bool station_transition_start(struct wiphy_radio_work_item *item)
 {
+	struct station *station =3D l_container_of(item, struct station, work);
 	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
 	struct network *connected =3D station->connected_network;
 	enum security security =3D network_get_security(connected);
+	struct scan_bss *bss =3D station->connect_pending_bss;
 	uint16_t mdid;
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
@@ -1511,7 +1518,7 @@ static void station_transition_start(struct station *=
station,
 				station->connected_network, bss) < 0) {
 			l_error("rebuilding handshake rsne failed");
 			station_roam_failed(station);
-			return;
+			return true;
 		}
 =

 		/* FT-over-DS can be better suited for these situations */
@@ -1520,21 +1527,22 @@ static void station_transition_start(struct station=
 *station,
 			if (netdev_fast_transition_over_ds(station->netdev, bss,
 					station_fast_transition_cb) < 0) {
 				station_roam_failed(station);
-				return;
+				return true;
 			}
 		} else {
 			if (netdev_fast_transition(station->netdev, bss,
 					station_fast_transition_cb) < 0) {
 				station_roam_failed(station);
-				return;
+				return true;
 			}
 		}
 =

 		station->connected_bss =3D bss;
 		station->preparing_roam =3D false;
+		station->connect_pending_bss =3D NULL;
 		station_enter_state(station, STATION_STATE_ROAMING);
 =

-		return;
+		return false;
 	}
 =

 	/* Non-FT transition */
@@ -1566,17 +1574,19 @@ static void station_transition_start(struct station=
 *station,
 		if (netdev_preauthenticate(station->netdev, bss,
 						station_preauthenticate_cb,
 						station) >=3D 0)
-			return;
+			return true;
 	}
 =

 	new_hs =3D station_handshake_setup(station, connected, bss);
 	if (!new_hs) {
 		l_error("station_handshake_setup failed in reassociation");
 		station_roam_failed(station);
-		return;
+		return true;
 	}
 =

 	station_transition_reassociate(station, bss, new_hs);
+
+	return false;
 }
 =

 static void station_roam_scan_triggered(int err, void *user_data)
@@ -1594,6 +1604,10 @@ static void station_roam_scan_triggered(int err, voi=
d *user_data)
 	 */
 }
 =

+static const struct wiphy_radio_work_item_ops station_work_ops =3D {
+	.do_work =3D station_transition_start,
+};
+
 static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 					void *userdata)
 {
@@ -1706,7 +1720,10 @@ next:
 		l_queue_push_tail(station->bss_list, best_bss);
 	}
 =

-	station_transition_start(station, best_bss);
+	station->connect_pending_bss =3D best_bss;
+
+	wiphy_radio_work_insert(station->wiphy, &station->work, 1,
+				&station_work_ops);
 =

 	return true;
 =

-- =

2.21.1

--===============5424813496923733484==--

