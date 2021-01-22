Content-Type: multipart/mixed; boundary="===============8691949609329140061=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 6/8] client: implement "ap <wlan> show"
Date: Fri, 22 Jan 2021 12:38:47 -0800
Message-ID: <20210122203849.679952-6-prestwoj@gmail.com>
In-Reply-To: <20210122203849.679952-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8691949609329140061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This command uses GetDiagnostics to show a list of connected
clients and some information about them. The information
contained for each connected station nearly maps 1:1 with the
station diagnostics information shown in "station <wlan> show"
apart from "ConnectedBss" which is now "Address".
---
 client/ap.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/client/ap.c b/client/ap.c
index a6a2681b..81baa3fc 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -30,6 +30,7 @@
 #include "client/dbus-proxy.h"
 #include "client/device.h"
 #include "client/display.h"
+#include "client/diagnostic.h"
 =

 struct ap {
 	bool started;
@@ -189,6 +190,51 @@ static enum cmd_status cmd_stop(const char *device_nam=
e, char **argv, int argc)
 	return CMD_STATUS_TRIGGERED;
 }
 =

+static struct proxy_interface_type ap_diagnostic_interface_type =3D {
+	.interface =3D IWD_AP_DIAGNOSTIC_INTERFACE,
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
+		diagnostic_display(&iter, "", 20, 20);
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
@@ -196,6 +242,7 @@ static const struct command ap_commands[] =3D {
 		"name\" with\n\t\t\t\t\t\t    a passphrase" },
 	{ "<wlan>", "stop", NULL,   cmd_stop, "Stop a started access\n"
 		"\t\t\t\t\t\t    point" },
+	{ "<wlan", "show", NULL, cmd_show, "Show AP info", false },
 	{ }
 };
 =

@@ -236,6 +283,7 @@ COMMAND_FAMILY(ap_command_family, ap_command_family_ini=
t,
 static int ap_interface_init(void)
 {
 	proxy_interface_type_register(&ap_interface_type);
+	proxy_interface_type_register(&ap_diagnostic_interface_type);
 =

 	return 0;
 }
@@ -243,6 +291,7 @@ static int ap_interface_init(void)
 static void ap_interface_exit(void)
 {
 	proxy_interface_type_unregister(&ap_interface_type);
+	proxy_interface_type_unregister(&ap_diagnostic_interface_type);
 }
 =

 INTERFACE_TYPE(ap_interface_type, ap_interface_init, ap_interface_exit)
-- =

2.26.2

--===============8691949609329140061==--

