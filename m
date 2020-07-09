Content-Type: multipart/mixed; boundary="===============7494633267128125262=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 5/6] station: cancel hidden network scan when connecting
Date: Wed, 08 Jul 2020 17:04:36 -0700
Message-ID: <20200709000437.32719-5-prestwoj@gmail.com>
In-Reply-To: <20200709000437.32719-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7494633267128125262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before connecting to a hidden network we must scan. During this scan
if another connection attempt comes in the expected behavior is to
abort the original connection. Rather than waiting for the scan to
complete, then canceling the original hidden connection we can just
cancel the hidden scan immediately, reply to dbus, and continue with
the new connection attempt.
---
 src/station.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/station.c b/src/station.c
index d7b319d8..35f4a96d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2474,6 +2474,19 @@ void station_connect_network(struct station *station=
, struct network *network,
 	struct l_dbus *dbus =3D dbus_get_bus();
 	int err;
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
 	if (station_is_busy(station)) {
 		station_disconnect_onconnect(station, network, bss, message);
 =

@@ -2525,6 +2538,8 @@ static bool station_hidden_network_scan_results(int e=
rr,
 =

 	msg =3D station->hidden_pending;
 	station->hidden_pending =3D NULL;
+	/* Zero this now so station_connect_network knows the scan is done */
+	station->hidden_network_scan_id =3D 0;
 =

 	if (err) {
 		dbus_pending_reply(&msg, dbus_error_failed(msg));
-- =

2.21.1

--===============7494633267128125262==--

