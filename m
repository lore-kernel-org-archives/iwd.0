Content-Type: multipart/mixed; boundary="===============2998755398317142320=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH 1/2] station: refresh ordered network list on (dis)connect
Date: Fri, 14 Aug 2020 15:32:46 +0200
Message-ID: <20200814133246.307981-2-alsi@bang-olufsen.dk>
In-Reply-To: <20200814133246.307981-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2998755398317142320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Doing so ensures that the currently connected network is always at the
beginning of the list. Previously, the list would only get updated after
a scan.

This fixes the documented behaviour of GetOrderedNetworks() DBus method,
which states that the currently connected network is always at the
beginning of the returned array.
---
 src/station.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/station.c b/src/station.c
index 42d60942..7a055f32 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1195,6 +1195,12 @@ static void station_enter_state(struct station *stat=
ion,
 					new_scan_results, station);
 		break;
 	case STATION_STATE_CONNECTING:
+		/* Refresh the ordered network list */
+		network_rank_update(network, true);
+		l_queue_remove(station->networks_sorted, network);
+		l_queue_insert(station->networks_sorted, network, network_rank_compare,
+					NULL);
+
 		l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
 		l_dbus_property_changed(dbus,
@@ -1295,6 +1301,12 @@ static void station_reset_connection_state(struct st=
ation *station)
 	station->connected_bss =3D NULL;
 	station->connected_network =3D NULL;
 =

+	/* Refresh the ordered network list */
+	network_rank_update(station->connected_network, false);
+	l_queue_remove(station->networks_sorted, station->connected_network);
+	l_queue_insert(station->networks_sorted, station->connected_network,
+				network_rank_compare, NULL);
+
 	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
 	l_dbus_property_changed(dbus, network_get_path(network),
-- =

2.28.0

--===============2998755398317142320==--

