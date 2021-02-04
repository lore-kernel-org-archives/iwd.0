Content-Type: multipart/mixed; boundary="===============7503131939186961864=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] station: move scan cancelation to
 __station_connect_network
Date: Thu, 04 Feb 2021 15:03:17 -0800
Message-ID: <20210204230319.237085-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7503131939186961864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This handles connect-on-disconnect, as well as retrying other BSS's
on failures rather than only explicit Connect() calls.
---
 src/station.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/src/station.c b/src/station.c
index 8c1e97d6..06c4d75e 100644
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

--===============7503131939186961864==--

