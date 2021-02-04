Content-Type: multipart/mixed; boundary="===============3704604136439284830=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] station: move scan cancelation to
 __station_connect_network
Date: Thu, 04 Feb 2021 15:53:53 -0800
Message-ID: <20210204235354.240547-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3704604136439284830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An earlier patch fixed a problem where a queued quick scan would
be triggered and fail once already connected, resulting in a state
transition from connected --> autoconnect_full. This fixed the
Connect() path but this could also happen via autoconnect. Starting
from a connected state, the sequence goes:

 - DBus scan is triggered
 - AP disconnects IWD
 - State transition from disconnected --> autoconnect_quick
 - Queue quick scan
 - DBus scan results come in and used to autoconnect
 - A connect work item is inserted ahead of all others, transition
   from autoconnect_quick --> connecting.
 - Connect completes, transition from connecting --> connected
 - Quick scan can finally get triggered, which the kernel fails to
   do since IWD is connected, transition from connected -->
   autoconnect_full.

By moving the scan cancellation from station_connect_network into
__station_connect_network we handle both the explicit Connect()
path as well as autoconnect.
---
 src/station.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

v2:
 * Clarifed the exact sequence of events in description

diff --git a/src/station.c b/src/station.c
index 8288916f..1f59e270 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2497,6 +2497,25 @@ int __station_connect_network(struct station *statio=
n, struct network *network,
 	struct handshake_state *hs;
 	int r;
 =

+	/*
+	 * If a hidden scan is not completed, station_is_busy would not
+	 * indicate anything is going on so we need to cancel the scan and
+	 * fail the connection now.
+	 */
+	if (station->hidden_network_scan_id) {
+		scan_cancel(netdev_get_wdev_id(station->netdev),
+				station->hidden_network_scan_id);
+
+		dbus_pending_reply(&station->hidden_pending,
+				dbus_error_failed(station->hidden_pending));
+	}
+
+	if (station->quick_scan_id) {
+		scan_cancel(netdev_get_wdev_id(station->netdev),
+				station->quick_scan_id);
+		station->quick_scan_id =3D 0;
+	}
+
 	hs =3D station_handshake_setup(station, network, bss);
 	if (!hs)
 		return -ENOTSUP;
@@ -2576,25 +2595,6 @@ void station_connect_network(struct station *station=
, struct network *network,
 	struct l_dbus *dbus =3D dbus_get_bus();
 	int err;
 =

-	/*
-	 * If a hidden scan is not completed, station_is_busy would not
-	 * indicate anything is going on so we need to cancel the scan and
-	 * fail the connection now.
-	 */
-	if (station->hidden_network_scan_id) {
-		scan_cancel(netdev_get_wdev_id(station->netdev),
-				station->hidden_network_scan_id);
-
-		dbus_pending_reply(&station->hidden_pending,
-				dbus_error_failed(station->hidden_pending));
-	}
-
-	if (station->quick_scan_id) {
-		scan_cancel(netdev_get_wdev_id(station->netdev),
-				station->quick_scan_id);
-		station->quick_scan_id =3D 0;
-	}
-
 	if (station_is_busy(station)) {
 		station_disconnect_onconnect(station, network, bss, message);
 =

-- =

2.26.2

--===============3704604136439284830==--

