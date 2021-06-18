Content-Type: multipart/mixed; boundary="===============2768862623589491917=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] station: Remove diagnostics interface reliably
Date: Fri, 18 Jun 2021 09:33:22 +0200
Message-ID: <20210618073324.67095-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2768862623589491917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the idea is that the interface should only be present when connected
then don't do this in the DISCONNECTING state as there are various
possible transitions from CONNECTED or ROAMING directly to DISCONNECTED.
---
 src/station.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 5b8b61b4..11711973 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1211,9 +1211,6 @@ static void station_enter_state(struct station *stati=
on,
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_DISCONNECTING:
-		l_dbus_object_remove_interface(dbus_get_bus(),
-					netdev_get_path(station->netdev),
-					IWD_STATION_DIAGNOSTIC_INTERFACE);
 		break;
 	case STATION_STATE_ROAMING:
 		break;
@@ -1317,6 +1314,8 @@ static void station_reset_connection_state(struct sta=
tion *station)
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
 	l_dbus_property_changed(dbus, network_get_path(network),
 				IWD_NETWORK_INTERFACE, "Connected");
+	l_dbus_object_remove_interface(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_DIAGNOSTIC_INTERFACE);
 }
 =

 static void station_disassociated(struct station *station)
-- =

2.30.2

--===============2768862623589491917==--

