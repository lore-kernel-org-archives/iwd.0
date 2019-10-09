Content-Type: multipart/mixed; boundary="===============4032687133971239637=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 1/3] station: Move 'connected' logic out of enter state func
Date: Wed, 09 Oct 2019 14:53:31 -0700
Message-ID: <20191009215333.14547-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4032687133971239637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously, station state 'connected' used to identify an interface associa=
ted
with AP. With the introduction of netconfig, an interface is assumed to be
connected after the IP addresses have been assigned to it. If netconfig is
disabled, the behavior remains unchanged.
---
 src/station.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/src/station.c b/src/station.c
index 72393d51..af209ebb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1158,26 +1158,9 @@ static void station_enter_state(struct station *stat=
ion,
 				IWD_NETWORK_INTERFACE, "Connected");
 		/* fall through */
 	case STATION_STATE_DISCONNECTED:
-		periodic_scan_stop(station);
-
-		break;
 	case STATION_STATE_CONNECTED:
 		periodic_scan_stop(station);
 =

-		if (!station->netconfig)
-			break;
-
-		if (station->state =3D=3D STATION_STATE_ROAMING) {
-			netconfig_reconfigure(station->netconfig);
-
-			break;
-		}
-
-		netconfig_configure(station->netconfig,
-					network_get_settings(
-						station->connected_network),
-					netdev_get_address(
-							station->netdev));
 		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_ROAMING:
@@ -1302,6 +1285,11 @@ static void station_roamed(struct station *station)
 	station->signal_low =3D false;
 	station->roam_min_time.tv_sec =3D 0;
 	station->roam_no_orig_ap =3D false;
+
+	if (station->netconfig)
+		netconfig_reconfigure(station->netconfig);
+
+	station_enter_state(station, STATION_STATE_CONNECTED);
 }
 =

 static void station_roam_failed(struct station *station)
@@ -1338,10 +1326,9 @@ static void station_reassociate_cb(struct netdev *ne=
tdev,
 	if (station->state !=3D STATION_STATE_ROAMING)
 		return;
 =

-	if (result =3D=3D NETDEV_RESULT_OK) {
+	if (result =3D=3D NETDEV_RESULT_OK)
 		station_roamed(station);
-		station_enter_state(station, STATION_STATE_CONNECTED);
-	} else
+	else
 		station_roam_failed(station);
 }
 =

@@ -1357,10 +1344,9 @@ static void station_fast_transition_cb(struct netdev=
 *netdev,
 	if (station->state !=3D STATION_STATE_ROAMING)
 		return;
 =

-	if (result =3D=3D NETDEV_RESULT_OK) {
+	if (result =3D=3D NETDEV_RESULT_OK)
 		station_roamed(station);
-		station_enter_state(station, STATION_STATE_CONNECTED);
-	} else
+	else
 		station_roam_failed(station);
 }
 =

@@ -2280,7 +2266,14 @@ static void station_connect_cb(struct netdev *netdev=
, enum netdev_result result,
 	}
 =

 	network_connected(station->connected_network);
-	station_enter_state(station, STATION_STATE_CONNECTED);
+
+	if (station->netconfig)
+		netconfig_configure(station->netconfig,
+					network_get_settings(
+						station->connected_network),
+					netdev_get_address(station->netdev));
+	else
+		station_enter_state(station, STATION_STATE_CONNECTED);
 }
 =

 int __station_connect_network(struct station *station, struct network *net=
work,
-- =

2.13.6

--===============4032687133971239637==--

