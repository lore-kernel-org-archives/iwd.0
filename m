Content-Type: multipart/mixed; boundary="===============3266081565585759470=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] station: only add diagnostic interface when connected
Date: Wed, 03 Feb 2021 11:07:04 -0800
Message-ID: <20210203190705.184958-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3266081565585759470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The diagnostic interface returns an error anyways if station is
not connected so it makes more sense to only bring the interface
up when its actually usable. This also removes the interface
when station disconnects, which was never done before (the
interface stayed up indefinitely due to a forgotten remove call).
---
 src/station.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/src/station.c b/src/station.c
index df7140c0..c108f0e9 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1217,11 +1217,21 @@ static void station_enter_state(struct station *sta=
tion,
 		l_dbus_property_changed(dbus,
 				network_get_path(station->connected_network),
 				IWD_NETWORK_INTERFACE, "Connected");
-		/* fall through */
+
+		periodic_scan_stop(station);
+		break;
 	case STATION_STATE_DISCONNECTED:
+		l_dbus_object_remove_interface(dbus_get_bus(),
+					netdev_get_path(station->netdev),
+					IWD_STATION_DIAGNOSTIC_INTERFACE);
+		periodic_scan_stop(station);
+		break;
 	case STATION_STATE_CONNECTED:
+		l_dbus_object_add_interface(dbus,
+					netdev_get_path(station->netdev),
+					IWD_STATION_DIAGNOSTIC_INTERFACE,
+					station);
 		periodic_scan_stop(station);
-
 		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_ROAMING:
@@ -3411,9 +3421,6 @@ static struct station *station_create(struct netdev *=
netdev)
 =

 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_STATION_INTERFACE, station);
-	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
-					IWD_STATION_DIAGNOSTIC_INTERFACE,
-					station);
 =

 	if (netconfig_enabled)
 		station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev));
@@ -3588,12 +3595,6 @@ static struct l_dbus_message *station_get_diagnostic=
s(struct l_dbus *dbus,
 	struct station *station =3D user_data;
 	int ret;
 =

-	/*
-	 * At this time all values depend on a connected state.
-	 */
-	if (station->state !=3D STATION_STATE_CONNECTED)
-		return dbus_error_not_connected(message);
-
 	ret =3D netdev_get_current_station(station->netdev,
 				station_get_diagnostic_cb, station,
 				station_get_diagnostic_destroy);
-- =

2.26.2

--===============3266081565585759470==--

