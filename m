Content-Type: multipart/mixed; boundary="===============1802757882678660918=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] station: Simplify and comply with coding style
Date: Tue, 08 Oct 2019 13:18:17 -0700
Message-ID: <20191008201817.29586-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1802757882678660918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9b3e087e..72393d51 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1164,19 +1164,20 @@ static void station_enter_state(struct station *sta=
tion,
 	case STATION_STATE_CONNECTED:
 		periodic_scan_stop(station);
 =

+		if (!station->netconfig)
+			break;
+
 		if (station->state =3D=3D STATION_STATE_ROAMING) {
-			if (station->netconfig)
-				netconfig_reconfigure(station->netconfig);
+			netconfig_reconfigure(station->netconfig);
 =

 			break;
 		}
 =

-		if (station->netconfig)
-			netconfig_configure(station->netconfig,
-						network_get_settings(
-							station->connected_network),
-						netdev_get_address(
-								station->netdev));
+		netconfig_configure(station->netconfig,
+					network_get_settings(
+						station->connected_network),
+					netdev_get_address(
+							station->netdev));
 		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_ROAMING:
@@ -3066,9 +3067,10 @@ static void station_free(struct station *station)
 	if (station->connected_bss)
 		netdev_disconnect(station->netdev, NULL, NULL);
 =

-	if (station->netconfig)
+	if (station->netconfig) {
 		netconfig_destroy(station->netconfig);
-	station->netconfig =3D NULL;
+		station->netconfig =3D NULL;
+	}
 =

 	periodic_scan_stop(station);
 =

-- =

2.13.6

--===============1802757882678660918==--

