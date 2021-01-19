Content-Type: multipart/mixed; boundary="===============0017527646652553274=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] client: add station diagnostic information to 'show'
Date: Tue, 19 Jan 2021 09:14:45 -0800
Message-ID: <20210119171445.389944-2-prestwoj@gmail.com>
In-Reply-To: <20210119171445.389944-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0017527646652553274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The information requested with GetDiagnostics will now appear in
the "station <iface> show" command. If IWD is not connected, or
there is no diagnostic interface (older IWD version) 'show' will
behave as it always has, only showing scanning/connected.
---
 client/station.c | 106 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/client/station.c b/client/station.c
index b6b59239..93b1a4da 100644
--- a/client/station.c
+++ b/client/station.c
@@ -130,6 +130,10 @@ static struct proxy_interface_type station_interface_t=
ype =3D {
 	.ops =3D &station_ops,
 };
 =

+static struct proxy_interface_type station_diagnostic_interface =3D {
+	.interface =3D IWD_STATION_DIAGNOSTIC_INTERFACE,
+};
+
 static void check_errors_method_callback(struct l_dbus_message *message,
 								void *user_data)
 {
@@ -137,7 +141,8 @@ static void check_errors_method_callback(struct l_dbus_=
message *message,
 }
 =

 static void display_station(const char *device_name,
-					const struct proxy_interface *proxy)
+					const struct proxy_interface *proxy,
+					bool *connected)
 {
 	const struct station *station =3D proxy_interface_get_data(proxy);
 	char *caption =3D l_strdup_printf("%s: %s", "Station", device_name);
@@ -145,10 +150,15 @@ static void display_station(const char *device_name,
 	proxy_properties_display(proxy, caption, MARGIN, 20, 47);
 	l_free(caption);
 =

-	if (station->connected_network)
+	if (station->connected_network) {
 		display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
 				"Connected network", 47,
 				network_get_name(station->connected_network));
+		*connected =3D true;
+		return;
+	}
+
+	*connected =3D false;
 =

 	display_table_footer();
 }
@@ -583,20 +593,106 @@ static enum cmd_status cmd_scan(const char *device_n=
ame,
 	return CMD_STATUS_TRIGGERED;
 }
 =

+static void get_diagnostics_callback(struct l_dbus_message *message,
+					void *user_data)
+{
+	struct l_dbus_message_iter iter;
+	struct l_dbus_message_iter variant;
+	const char *key;
+
+	if (dbus_message_has_error(message))
+		return;
+
+	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter)) {
+		l_error("Failed to parse GetDiagnostics message");
+		goto done;
+	}
+
+	while (l_dbus_message_iter_next_entry(&iter, &key, &variant)) {
+		const char *s_value;
+		uint32_t u_value;
+		int16_t i_value;
+		uint8_t y_value;
+
+		if (!strcmp(key, "ConnectedBss") || !strcmp(key, "RxMode") ||
+				!strcmp(key, "TxMode")) {
+			/* String variants with no special handling */
+
+			l_dbus_message_iter_get_variant(&variant, "s",
+							&s_value);
+
+			display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
+				key, 47, s_value);
+		} else if (!strcmp(key, "RxBitrate") ||
+				!strcmp(key, "TxBitrate")) {
+			/* Bitrates expressed in 100Kbit/s */
+
+			l_dbus_message_iter_get_variant(&variant, "u",
+							&u_value);
+			display("%s%*s  %-*s%u Kbit/s\n", MARGIN, 8, "", 20,
+				key, u_value * 100);
+		} else if (!strcmp(key, "ExpectedThroughput")) {
+			/* ExpectedThroughput expressed in Kbit/s */
+
+			l_dbus_message_iter_get_variant(&variant, "u",
+							&u_value);
+			display("%s%*s  %-*s%u Kbit/s\n", MARGIN, 8, "", 20,
+				key, u_value);
+		} else if (!strcmp(key, "RSSI")) {
+			/* RSSI expressed in dBm */
+
+			l_dbus_message_iter_get_variant(&variant, "n",
+							&i_value);
+			display("%s%*s  %-*s%i dBm\n", MARGIN, 8, "", 20,
+				key, i_value);
+		} else if (!strcmp(key, "RxMCS") || !strcmp(key, "TxMCS")) {
+			/* MCS index's are single byte integers */
+
+			l_dbus_message_iter_get_variant(&variant, "y",
+							&y_value);
+			display("%s%*s  %-*s%u\n", MARGIN, 8, "", 20,
+				key, y_value);
+		}
+	}
+
+done:
+	/* Finish the table started by cmd_show */
+	display_table_footer();
+	display_refresh_reset();
+}
+
 static enum cmd_status cmd_show(const char *device_name,
 						char **argv, int argc)
 {
 	const struct proxy_interface *station =3D
 			device_proxy_find(device_name, IWD_STATION_INTERFACE);
+	const struct proxy_interface *diagnostic =3D
+					device_proxy_find(device_name,
+					IWD_STATION_DIAGNOSTIC_INTERFACE);
+	bool connected;
 =

 	if (!station) {
 		display("No station on device: '%s'\n", device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 =

-	display_station(device_name, station);
+	display_station(device_name, station, &connected);
 =

-	return CMD_STATUS_DONE;
+	/*
+	 * No need to query additional diagnostic information if not connected,
+	 * or IWD has no diagnostic interface.
+	 */
+	if (!connected || !diagnostic) {
+		display_table_footer();
+		display_refresh_reset();
+		return CMD_STATUS_DONE;
+	}
+
+	proxy_interface_method_call(diagnostic, "GetDiagnostics", "",
+					get_diagnostics_callback);
+
+	/* Don't display table footer, this will be done in the callback */
+	return CMD_STATUS_TRIGGERED;
 }
 =

 static const struct command station_commands[] =3D {
@@ -663,6 +759,7 @@ COMMAND_FAMILY(station_command_family, station_command_=
family_init,
 static int station_interface_init(void)
 {
 	proxy_interface_type_register(&station_interface_type);
+	proxy_interface_type_register(&station_diagnostic_interface);
 =

 	return 0;
 }
@@ -670,6 +767,7 @@ static int station_interface_init(void)
 static void station_interface_exit(void)
 {
 	proxy_interface_type_unregister(&station_interface_type);
+	proxy_interface_type_unregister(&station_diagnostic_interface);
 }
 =

 INTERFACE_TYPE(station_interface_type,
-- =

2.26.2

--===============0017527646652553274==--

