Content-Type: multipart/mixed; boundary="===============5041639462565894224=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] client: implement "ap <wlan> show"
Date: Wed, 20 Jan 2021 10:30:34 -0800
Message-ID: <20210120183036.477287-6-prestwoj@gmail.com>
In-Reply-To: <20210120183036.477287-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5041639462565894224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This command uses GetDiagnostics to show a list of connected
clients and some information about them. The information
contained for each connected station nearly maps 1:1 with the
station diagnostics information shown in "station <wlan> show"
apart from "ConnectedBss" which is now "Address".
---
 client/ap.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/client/ap.c b/client/ap.c
index a6a2681b..91d265a7 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -189,6 +189,100 @@ static enum cmd_status cmd_stop(const char *device_na=
me, char **argv, int argc)
 	return CMD_STATUS_TRIGGERED;
 }
 =

+static struct proxy_interface_type ap_diagnostic_interface_type =3D {
+	.interface =3D IWD_AP_DIAGNOSTIC_INTERFACE,
+};
+
+static void display_client(struct l_dbus_message_iter *iter)
+{
+	struct l_dbus_message_iter variant;
+	const char *key;
+
+	while (l_dbus_message_iter_next_entry(iter, &key, &variant)) {
+		const char *s_value;
+		uint32_t u_value;
+		int16_t i_value;
+		uint8_t y_value;
+
+		if (!strcmp(key, "Address") || !strcmp(key, "RxMode") ||
+				!strcmp(key, "TxMode")) {
+			/* String variants with no special handling */
+
+			l_dbus_message_iter_get_variant(&variant, "s",
+							&s_value);
+
+			display("%-*s%-*s\n", 20, key, 47, s_value);
+		} else if (!strcmp(key, "RxBitrate") ||
+				!strcmp(key, "TxBitrate")) {
+			/* Bitrates expressed in 100Kbit/s */
+
+			l_dbus_message_iter_get_variant(&variant, "u",
+							&u_value);
+			display("%-*s%u Kbit/s\n", 20, key, u_value * 100);
+		} else if (!strcmp(key, "ExpectedThroughput")) {
+			/* ExpectedThroughput expressed in Kbit/s */
+
+			l_dbus_message_iter_get_variant(&variant, "u",
+							&u_value);
+			display("%*s  %-*s%u Kbit/s\n", 0, "", 20,
+				key, u_value);
+		} else if (!strcmp(key, "RSSI")) {
+			/* RSSI expressed in dBm */
+
+			l_dbus_message_iter_get_variant(&variant, "n",
+							&i_value);
+			display("%-*s%i dBm\n", 20, key, i_value);
+		} else if (!strcmp(key, "RxMCS") || !strcmp(key, "TxMCS")) {
+			/* MCS index's are single byte integers */
+
+			l_dbus_message_iter_get_variant(&variant, "y",
+							&y_value);
+			display("%-*s%u\n", 20, key, y_value);
+		}
+	}
+}
+
+static void ap_get_diagnostics_callback(struct l_dbus_message *message,
+					void *user_data)
+{
+	struct l_dbus_message_iter array;
+	struct l_dbus_message_iter iter;
+	uint16_t idx =3D 0;
+	char client_num[15];
+
+	if (dbus_message_has_error(message))
+		return;
+
+	if (!l_dbus_message_get_arguments(message, "aa{sv}", &array)) {
+		display("Failed to parse GetDiagnostics message");
+		return;
+	}
+
+	while (l_dbus_message_iter_next_entry(&array, &iter)) {
+		sprintf(client_num, "Client %u", idx++);
+		display_table_header(client_num, "%-*s%-*s",
+					20, "Property", 20, "Value");
+		display_client(&iter);
+		display_table_footer();
+	}
+}
+
+static enum cmd_status cmd_show(const char *device_name, char **argv, int =
argc)
+{
+	const struct proxy_interface *ap_diagnostic =3D
+		device_proxy_find(device_name, IWD_AP_DIAGNOSTIC_INTERFACE);
+
+	if (!ap_diagnostic) {
+		display("No ap on device: '%s'\n", device_name);
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	proxy_interface_method_call(ap_diagnostic, "GetDiagnostics", "",
+					ap_get_diagnostics_callback);
+
+	return CMD_STATUS_TRIGGERED;
+}
+
 static const struct command ap_commands[] =3D {
 	{ NULL, "list", NULL, cmd_list, "List devices in AP mode", true },
 	{ "<wlan>", "start", "<\"network name\"> <passphrase>", cmd_start,
@@ -196,6 +290,7 @@ static const struct command ap_commands[] =3D {
 		"name\" with\n\t\t\t\t\t\t    a passphrase" },
 	{ "<wlan>", "stop", NULL,   cmd_stop, "Stop a started access\n"
 		"\t\t\t\t\t\t    point" },
+	{ "<wlan", "show", NULL, cmd_show, "Show AP info", false },
 	{ }
 };
 =

@@ -236,6 +331,7 @@ COMMAND_FAMILY(ap_command_family, ap_command_family_ini=
t,
 static int ap_interface_init(void)
 {
 	proxy_interface_type_register(&ap_interface_type);
+	proxy_interface_type_register(&ap_diagnostic_interface_type);
 =

 	return 0;
 }
@@ -243,6 +339,7 @@ static int ap_interface_init(void)
 static void ap_interface_exit(void)
 {
 	proxy_interface_type_unregister(&ap_interface_type);
+	proxy_interface_type_unregister(&ap_diagnostic_interface_type);
 }
 =

 INTERFACE_TYPE(ap_interface_type, ap_interface_init, ap_interface_exit)
-- =

2.26.2

--===============5041639462565894224==--

