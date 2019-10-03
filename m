Content-Type: multipart/mixed; boundary="===============5933392459443087814=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: [PATCH] station: don't reset/(re)configure/destroy NULL netconfig's
Date: Thu, 03 Oct 2019 11:43:50 -0500
Message-ID: <20191003114350.GE8802@dtznix>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5933392459443087814==
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

2.23.GIT

--===============5933392459443087814==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUVHUDJWQTNxVlpm
Y0hzWG9yNjdEcVFTU0FuUUlGQWwyV0pVWUFDZ2tRNjdEcVFTU0EKblFLbmpnLy9SdjVrY1JyRUl1
Y1dZeHk1UGlJcEZxZW5SQlpaSlpJRGFZdjJuaEFOV1phZEY5dkJoeEtEcVpJWgo2L0FlQWlsVXRr
NXZNa3FGL3RTT3VOQzhjRWdNa3ZySTVWZU12aytRT2RXWEV4a3VzOU5IVkZhdjF2OEZaRWRiCm5W
S0N3T0hOVHAwOEs5Rytkek5ZSVlTeW44d2l1cmJVaXB4ZjhZTi9UcndBYUJ6aFB5QVdTelF4QlRo
T3dOTnoKQk1teC9VdlZLOTA4M25yUzV0VXJUVVhBTDJkMmhPWXBhdnpHNkkxZTF0b1VRMWYvSmF1
Mzg0Y2JLamZVc3psLwpyY1RpOExaejhFT2tUUUwrUTZZKzR1VDI0bW1BVm9qQVAzak9OS1hkQ1l1
QjN1MzVQUUpmbjQra3F2bzVpZGtoCnpyK1dLbDkwY1IxdTEwb3EzRGdIaVZJMUU4NDFESEZKZGI3
MUthQy9sS21OSGlQd2ZoZzVXUm5rRE4xSTd2UnYKUVllTUhmWXdHaThycUhONWV0aTNxL1o5S3ZQ
Q1l6RXZ1Rm9mbnBqWFE1bUFvZVVrNVlIc0k1S01xTmFLNFNBTgpaYnNidFVpdnJtK1NGTm1RV3Zw
cGg4S0h3OEVueExGZGU5N0NtQmVxeXZRSkJMMkRIMFVMTEgwRXIveWhtaURmClUrOHFIV0tsL3Rx
UWNPcklRaGtsN0V1Zk1HREw3M29ZNkp4andZRW5SbkFrNjY2NzdzaEgzNEZocXRXY3ZydEcKSytr
OU4rZDhuVWZRWWkvV0RXVFNnTzNITktOSDJlQVJ4eFRCNVZsUTkvU3M2WWpTTVhtTW9ReXhSZTcv
RlpGVwpwN3V1OXpnVFdDeDZkRjlwTk5kTFd2Yll5VGRzYVp3NEtaRUJKbFlJYVl0NytvY3hPUWM9
Cj1LeUV1Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============5933392459443087814==--

