Content-Type: multipart/mixed; boundary="===============0506013862302194328=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] client: update to work with diagnostic changes
Date: Wed, 03 Feb 2021 11:07:05 -0800
Message-ID: <20210203190705.184958-2-prestwoj@gmail.com>
In-Reply-To: <20210203190705.184958-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0506013862302194328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The diagnostic interface will now only come up when station is
connected. This avoids the need for display station to return
a 'connected' out parameter. We can instead just see that
the diagnostic interface doesn't exist.
---
 client/station.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/client/station.c b/client/station.c
index 0bda604c..c2e7a12b 100644
--- a/client/station.c
+++ b/client/station.c
@@ -142,8 +142,7 @@ static void check_errors_method_callback(struct l_dbus_=
message *message,
 }
 =

 static void display_station(const char *device_name,
-					const struct proxy_interface *proxy,
-					bool *connected)
+					const struct proxy_interface *proxy)
 {
 	const struct station *station =3D proxy_interface_get_data(proxy);
 	char *caption =3D l_strdup_printf("%s: %s", "Station", device_name);
@@ -155,12 +154,13 @@ static void display_station(const char *device_name,
 		display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
 				"Connected network", 47,
 				network_get_name(station->connected_network));
-		*connected =3D true;
+		/*
+		 * If connected the diagnostic interface is presumably up so
+		 * don't add the table footer just yet.
+		 */
 		return;
 	}
 =

-	*connected =3D false;
-
 	display_table_footer();
 }
 =

@@ -623,20 +623,19 @@ static enum cmd_status cmd_show(const char *device_na=
me,
 	const struct proxy_interface *diagnostic =3D
 					device_proxy_find(device_name,
 					IWD_STATION_DIAGNOSTIC_INTERFACE);
-	bool connected;
 =

 	if (!station) {
 		display("No station on device: '%s'\n", device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 =

-	display_station(device_name, station, &connected);
+	display_station(device_name, station);
 =

 	/*
-	 * No need to query additional diagnostic information if not connected,
-	 * or IWD has no diagnostic interface.
+	 * No need to query additional diagnostic information if IWD has
+	 * no diagnostic interface.
 	 */
-	if (!connected || !diagnostic) {
+	if (!diagnostic) {
 		display_table_footer();
 		display_refresh_reset();
 		return CMD_STATUS_DONE;
-- =

2.26.2

--===============0506013862302194328==--

