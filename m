Content-Type: multipart/mixed; boundary="===============0763381276095093052=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/5] station: Move 'connected' logic out of enter state func
Date: Tue, 08 Oct 2019 14:48:21 -0700
Message-ID: <20191008214824.19466-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191008214824.19466-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0763381276095093052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously, station state 'connected' used to identify an interface associa=
ted
with AP. With the introduction of netconfig, an interface is assumed to be
connected after the IP addresses have been assigned to it. If netconfig is
disabled, the behavior remains unchanged.

The change of station state by netconfig to 'connected' is implemented in
the follow up patches.
---
 src/station.c | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/src/station.c b/src/station.c
index 72393d51..9997352e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1162,23 +1162,6 @@ static void station_enter_state(struct station *stat=
ion,
 =

 		break;
 	case STATION_STATE_CONNECTED:
-		periodic_scan_stop(station);
-
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
-		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_ROAMING:
 		break;
@@ -1326,6 +1309,28 @@ static void station_roam_failed(struct station *stat=
ion)
 		station_roam_timeout_rearm(station, 60);
 }
 =

+static void station_connected(struct station *station)
+{
+	periodic_scan_stop(station);
+
+	if (!station->netconfig) {
+		station_enter_state(station, STATION_STATE_CONNECTED);
+
+		return;
+	}
+
+	if (station->state =3D=3D STATION_STATE_ROAMING) {
+		netconfig_reconfigure(station->netconfig);
+
+		return;
+	}
+
+	netconfig_configure(station->netconfig,
+				network_get_settings(
+						station->connected_network),
+				netdev_get_address(station->netdev));
+}
+
 static void station_reassociate_cb(struct netdev *netdev,
 					enum netdev_result result,
 					void *event_data,
@@ -1340,9 +1345,10 @@ static void station_reassociate_cb(struct netdev *ne=
tdev,
 =

 	if (result =3D=3D NETDEV_RESULT_OK) {
 		station_roamed(station);
-		station_enter_state(station, STATION_STATE_CONNECTED);
-	} else
+		station_connected(station);
+	} else {
 		station_roam_failed(station);
+	}
 }
 =

 static void station_fast_transition_cb(struct netdev *netdev,
@@ -1359,9 +1365,10 @@ static void station_fast_transition_cb(struct netdev=
 *netdev,
 =

 	if (result =3D=3D NETDEV_RESULT_OK) {
 		station_roamed(station);
-		station_enter_state(station, STATION_STATE_CONNECTED);
-	} else
+		station_connected(station);
+	} else {
 		station_roam_failed(station);
+	}
 }
 =

 static void station_netdev_event(struct netdev *netdev, enum netdev_event =
event,
@@ -2280,7 +2287,7 @@ static void station_connect_cb(struct netdev *netdev,=
 enum netdev_result result,
 	}
 =

 	network_connected(station->connected_network);
-	station_enter_state(station, STATION_STATE_CONNECTED);
+	station_connected(station);
 }
 =

 int __station_connect_network(struct station *station, struct network *net=
work,
-- =

2.13.6

--===============0763381276095093052==--

