Content-Type: multipart/mixed; boundary="===============7094410687455832608=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 2/8] station: netconfig devices based on station state
Date: Mon, 30 Sep 2019 09:35:52 -0700
Message-ID: <20190930163558.28123-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190930163558.28123-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7094410687455832608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/station.c b/src/station.c
index 02c5260b..0666287b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1158,8 +1158,23 @@ static void station_enter_state(struct station *stat=
ion,
 				IWD_NETWORK_INTERFACE, "Connected");
 		/* fall through */
 	case STATION_STATE_DISCONNECTED:
+		periodic_scan_stop(station);
+
+		break;
 	case STATION_STATE_CONNECTED:
 		periodic_scan_stop(station);
+
+		if (station->state =3D=3D STATION_STATE_ROAMING) {
+			netconfig_reconfigure(station->netconfig);
+
+			break;
+		}
+
+		netconfig_configure(station->netconfig,
+					network_get_settings(
+						station->connected_network),
+					netdev_get_address(
+							station->netdev));
 		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_ROAMING:
@@ -1247,6 +1262,8 @@ static void station_disassociated(struct station *sta=
tion)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 =

+	netconfig_reset(station->netconfig);
+
 	station_reset_connection_state(station);
 =

 	station_enter_state(station, STATION_STATE_DISCONNECTED);
@@ -2327,6 +2344,8 @@ static void station_disconnect_onconnect(struct stati=
on *station,
 		return;
 	}
 =

+	netconfig_reset(station->netconfig);
+
 	station_reset_connection_state(station);
 =

 	station_enter_state(station, STATION_STATE_DISCONNECTING);
@@ -2562,6 +2581,8 @@ int station_disconnect(struct station *station)
 					station_disconnect_cb, station) < 0)
 		return -EIO;
 =

+	netconfig_reset(station->netconfig);
+
 	/*
 	 * If the disconnect somehow fails we won't know if we're still
 	 * connected so we may as well indicate now that we're no longer
-- =

2.13.6

--===============7094410687455832608==--

