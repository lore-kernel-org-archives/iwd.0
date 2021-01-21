Content-Type: multipart/mixed; boundary="===============4518470407560387109=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/5] client: implement "ap <wlan> show"
Date: Thu, 21 Jan 2021 10:11:12 -0800
Message-ID: <20210121181113.572092-4-prestwoj@gmail.com>
In-Reply-To: <20210121181113.572092-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4518470407560387109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This command uses GetDiagnostics to show a list of connected
clients and some information about them. The information
contained for each connected station nearly maps 1:1 with the
station diagnostics information shown in "station <wlan> show"
apart from "ConnectedBss" which is now "Address".
---
 client/ap.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/client/ap.c b/client/ap.c
index a6a2681b..6e2e96c4 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -189,6 +189,76 @@ static enum cmd_status cmd_stop(const char *device_nam=
e, char **argv, int argc)
 	return CMD_STATUS_TRIGGERED;
 }
 =

+static struct proxy_interface_type ap_diagnostic_interface_type =3D {
+	.interface =3D IWD_AP_DIAGNOSTIC_INTERFACE,
+};
+
+static void display_bitrate_100kbps(struct l_dbus_message_iter *variant,
+				const char *key, const char *margin,
+				int name_column_width, int value_column_width)
+{
+	uint32_t rate;
+
+	l_dbus_message_iter_get_variant(variant, "u", &rate);
+
+	display("%s%-*s%-*u Kbit/s\n", margin, name_column_width, key,
+			value_column_width, rate * 100);
+}
+
+static const struct display_dict_mapping diagnostic_mapping[] =3D {
+	{ "Address", 's', NULL },
+	{ "RxMode", 's', NULL },
+	{ "TxMode", 's', NULL },
+	{ "RxBitrate", 0, display_bitrate_100kbps },
+	{ "TxBitrate", 0, display_bitrate_100kbps },
+	{ "ExpectedThroughput", 'u', "Kbit/s" },
+	{ "RSSI", 'n', "dBm" },
+	{ "RxMCS", 'y', NULL },
+	{ "TxMCS", 'y', NULL},
+	{ NULL }
+};
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
+		display_dictionary(&iter, diagnostic_mapping, "", 20, 20);
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
@@ -196,6 +266,7 @@ static const struct command ap_commands[] =3D {
 		"name\" with\n\t\t\t\t\t\t    a passphrase" },
 	{ "<wlan>", "stop", NULL,   cmd_stop, "Stop a started access\n"
 		"\t\t\t\t\t\t    point" },
+	{ "<wlan", "show", NULL, cmd_show, "Show AP info", false },
 	{ }
 };
 =

@@ -236,6 +307,7 @@ COMMAND_FAMILY(ap_command_family, ap_command_family_ini=
t,
 static int ap_interface_init(void)
 {
 	proxy_interface_type_register(&ap_interface_type);
+	proxy_interface_type_register(&ap_diagnostic_interface_type);
 =

 	return 0;
 }
@@ -243,6 +315,7 @@ static int ap_interface_init(void)
 static void ap_interface_exit(void)
 {
 	proxy_interface_type_unregister(&ap_interface_type);
+	proxy_interface_type_unregister(&ap_diagnostic_interface_type);
 }
 =

 INTERFACE_TYPE(ap_interface_type, ap_interface_init, ap_interface_exit)
-- =

2.26.2

--===============4518470407560387109==--

