Content-Type: multipart/mixed; boundary="===============6910558112761337175=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 1/3] station: Use separate msg holder for hidden connections
Date: Tue, 09 Jun 2020 18:22:19 -0700
Message-ID: <20200610012221.19263-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6910558112761337175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce hidden_pending to keep reference to the dbus message object
while we wait for the scan results to be returned while trying to
connect to a hidden network. This simplifies the logic by separating it
into two independent logical units: scanning, connecting and eliminates
a possibility of a memory leak in the case when Network.Connect being
initiated while Station.ConnectHiddenNetwork is in progress.
---
 src/station.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index ca6a0b8e..583016ab 100644
--- a/src/station.c
+++ b/src/station.c
@@ -73,6 +73,7 @@ struct station {
 	struct l_hashmap *networks;
 	struct l_queue *networks_sorted;
 	struct l_dbus_message *connect_pending;
+	struct l_dbus_message *hidden_pending;
 	struct l_dbus_message *disconnect_pending;
 	struct l_dbus_message *scan_pending;
 	struct signal_agent *signal_agent;
@@ -2433,8 +2434,8 @@ static void station_hidden_network_scan_triggered(int=
 err, void *user_data)
 	if (!err)
 		return;
 =

-	dbus_pending_reply(&station->connect_pending,
-				dbus_error_failed(station->connect_pending));
+	dbus_pending_reply(&station->hidden_pending,
+				dbus_error_failed(station->hidden_pending));
 }
 =

 static bool station_hidden_network_scan_results(int err,
@@ -2452,8 +2453,8 @@ static bool station_hidden_network_scan_results(int e=
rr,
 =

 	l_debug("");
 =

-	msg =3D station->connect_pending;
-	station->connect_pending =3D NULL;
+	msg =3D station->hidden_pending;
+	station->hidden_pending =3D NULL;
 =

 	if (err) {
 		dbus_pending_reply(&msg, dbus_error_failed(msg));
@@ -2527,7 +2528,7 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 =

 	l_debug("");
 =

-	if (station->connect_pending || station_is_busy(station))
+	if (station->hidden_pending || station_is_busy(station))
 		return dbus_error_busy(message);
 =

 	if (!l_dbus_message_get_arguments(message, "s", &ssid))
@@ -2553,7 +2554,7 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 	if (!station->hidden_network_scan_id)
 		return dbus_error_failed(message);
 =

-	station->connect_pending =3D l_dbus_message_ref(message);
+	station->hidden_pending =3D l_dbus_message_ref(message);
 =

 	return NULL;
 }
@@ -3132,6 +3133,10 @@ static void station_free(struct station *station)
 		dbus_pending_reply(&station->connect_pending,
 				dbus_error_aborted(station->connect_pending));
 =

+	if (station->hidden_pending)
+		dbus_pending_reply(&station->hidden_pending,
+				dbus_error_aborted(station->hidden_pending));
+
 	if (station->disconnect_pending)
 		dbus_pending_reply(&station->disconnect_pending,
 			dbus_error_aborted(station->disconnect_pending));
-- =

2.13.6

--===============6910558112761337175==--

