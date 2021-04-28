Content-Type: multipart/mixed; boundary="===============7878585635772536905=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 1/2] station: tie diagnostic interface cleanup to
 DISCONNECTING
Date: Wed, 28 Apr 2021 12:40:11 -0700
Message-ID: <20210428194012.149913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7878585635772536905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prior to this the diagnostic interface was taken down when station
transitioned to DISCONNECTED. This worked but once station is in
a DISCONNECTING state it then calls netdev_disconnect(). Trying to
get any diagnostic data during this time may not work as its
unknown what state exactly the kernel is in. To be safe take the
interface down when station is DISCONNECTING.
---
 src/station.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9c2b4e64..0cee3525 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1229,9 +1229,6 @@ static void station_enter_state(struct station *stati=
on,
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_DISCONNECTED:
-		l_dbus_object_remove_interface(dbus_get_bus(),
-					netdev_get_path(station->netdev),
-					IWD_STATION_DIAGNOSTIC_INTERFACE);
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_CONNECTED:
@@ -1242,6 +1239,10 @@ static void station_enter_state(struct station *stat=
ion,
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_DISCONNECTING:
+		l_dbus_object_remove_interface(dbus_get_bus(),
+					netdev_get_path(station->netdev),
+					IWD_STATION_DIAGNOSTIC_INTERFACE);
+		break;
 	case STATION_STATE_ROAMING:
 		break;
 	}
-- =

2.26.2

--===============7878585635772536905==--

