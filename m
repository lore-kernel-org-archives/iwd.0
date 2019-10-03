Content-Type: multipart/mixed; boundary="===============4275837460423307387=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: [PATCH] station: don't reset/(re)configure/destroy NULL netconfig's
Date: Thu, 03 Oct 2019 12:24:09 -0500
Message-ID: <20191003172409.590-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4275837460423307387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes crashes when `enable_network_config` is false (default).
---
 src/station.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/src/station.c b/src/station.c
index eed3a7f..9b3e087 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1165,16 +1165,18 @@ static void station_enter_state(struct station *sta=
tion,
 		periodic_scan_stop(station);
 =

 		if (station->state =3D=3D STATION_STATE_ROAMING) {
-			netconfig_reconfigure(station->netconfig);
+			if (station->netconfig)
+				netconfig_reconfigure(station->netconfig);
 =

 			break;
 		}
 =

-		netconfig_configure(station->netconfig,
-					network_get_settings(
-						station->connected_network),
-					netdev_get_address(
-							station->netdev));
+		if (station->netconfig)
+			netconfig_configure(station->netconfig,
+						network_get_settings(
+							station->connected_network),
+						netdev_get_address(
+								station->netdev));
 		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_ROAMING:
@@ -1262,7 +1264,8 @@ static void station_disassociated(struct station *sta=
tion)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 =

-	netconfig_reset(station->netconfig);
+	if (station->netconfig)
+		netconfig_reset(station->netconfig);
 =

 	station_reset_connection_state(station);
 =

@@ -2344,7 +2347,8 @@ static void station_disconnect_onconnect(struct stati=
on *station,
 		return;
 	}
 =

-	netconfig_reset(station->netconfig);
+	if (station->netconfig)
+		netconfig_reset(station->netconfig);
 =

 	station_reset_connection_state(station);
 =

@@ -2581,7 +2585,8 @@ int station_disconnect(struct station *station)
 					station_disconnect_cb, station) < 0)
 		return -EIO;
 =

-	netconfig_reset(station->netconfig);
+	if (station->netconfig)
+		netconfig_reset(station->netconfig);
 =

 	/*
 	 * If the disconnect somehow fails we won't know if we're still
@@ -3061,7 +3066,8 @@ static void station_free(struct station *station)
 	if (station->connected_bss)
 		netdev_disconnect(station->netdev, NULL, NULL);
 =

-	netconfig_destroy(station->netconfig);
+	if (station->netconfig)
+		netconfig_destroy(station->netconfig);
 	station->netconfig =3D NULL;
 =

 	periodic_scan_stop(station);
-- =

2.23.0

--===============4275837460423307387==--

