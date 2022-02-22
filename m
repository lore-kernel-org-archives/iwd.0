Content-Type: multipart/mixed; boundary="===============5344123137200704215=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/7] client: add AP scanning support to iwctl
Date: Tue, 22 Feb 2022 14:57:17 -0800
Message-ID: <20220222225718.2485794-6-prestwoj@gmail.com>
In-Reply-To: 20220222225718.2485794-1-prestwoj@gmail.com

--===============5344123137200704215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/ap.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/client/ap.c b/client/ap.c
index 0f14e9b8..74584730 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -35,6 +35,7 @@
 struct ap {
 	bool started;
 	char *name;
+	bool scanning;
 };
 =

 static void *ap_create(void)
@@ -104,9 +105,31 @@ static void update_name(void *data, struct l_dbus_mess=
age_iter *variant)
 	ap->name =3D l_strdup(name);
 }
 =

+static void update_scanning(void *data, struct l_dbus_message_iter *varian=
t)
+{
+	struct ap *ap =3D data;
+	bool value;
+
+	if (!l_dbus_message_iter_get_variant(variant, "b", &value)) {
+		ap->scanning =3D false;
+
+		return;
+	}
+
+	ap->scanning =3D value;
+}
+
+static const char *get_scanning_tostr(const void *data)
+{
+	const struct ap *ap =3D data;
+
+	return ap->scanning ? "yes" : "no";
+}
+
 static const struct proxy_interface_property ap_properties[] =3D {
 	{ "Started",  "b", update_started,  get_started_tostr },
 	{ "Name",     "s", update_name, get_name_tostr },
+	{ "Scanning", "b", update_scanning, get_scanning_tostr },
 	{ }
 };
 =

@@ -301,6 +324,95 @@ static enum cmd_status cmd_start_profile(const char *d=
evice_name,
 	return CMD_STATUS_TRIGGERED;
 }
 =

+static enum cmd_status cmd_scan(const char *device_name, char **argv, int =
argc)
+{
+	const struct proxy_interface *ap_i;
+
+	ap_i =3D device_proxy_find(device_name, IWD_ACCESS_POINT_INTERFACE);
+	if (!ap_i) {
+		display("No ap on device: '%s'\n", device_name);
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	proxy_interface_method_call(ap_i, "Scan", "",
+						check_errors_method_callback);
+
+	return CMD_STATUS_TRIGGERED;
+}
+
+static void ap_display_network(struct l_dbus_message_iter *iter,
+				const char *margin, int name_width,
+				int value_width)
+{
+	const char *key;
+	struct l_dbus_message_iter variant;
+
+	while (l_dbus_message_iter_next_entry(iter, &key, &variant)) {
+		const char *s;
+		int16_t n;
+
+		if (!strcmp(key, "Name") || !strcmp(key, "Security")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "s", &s))
+				goto parse_error;
+
+			display("%s%-*s%-*s\n", margin, name_width, key,
+						value_width, s);
+		} else if (!strcmp(key, "SignalStrength")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "n", &n))
+				goto parse_error;
+
+			display("%s%-*s%-*i\n", margin, name_width, key,
+						value_width, n);
+		}
+	}
+
+	return;
+
+parse_error:
+	display("Error displaying network results");
+}
+
+static void ap_get_networks_callback(struct l_dbus_message *message,
+					void *user_data)
+{
+	struct l_dbus_message_iter array;
+	struct l_dbus_message_iter iter;
+
+	if (dbus_message_has_error(message))
+		return;
+
+	if (!l_dbus_message_get_arguments(message, "aa{sv}", &array)) {
+		display("Failed to parse GetDiagnostics message");
+		return;
+	}
+
+	display_table_header("Networks", "            %-*s%-*s",
+					20, "Property", 20, "Value");
+	while (l_dbus_message_iter_next_entry(&array, &iter)) {
+		ap_display_network(&iter, "            ", 20, 20);
+		display("\n");
+	}
+
+	display_table_footer();
+}
+
+static enum cmd_status cmd_get_networks(const char *device_name, char **ar=
gv,
+					int argc)
+{
+	const struct proxy_interface *ap_i;
+
+	ap_i =3D device_proxy_find(device_name, IWD_ACCESS_POINT_INTERFACE);
+	if (!ap_i) {
+		display("No ap on device: '%s'\n", device_name);
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	proxy_interface_method_call(ap_i, "GetOrderedNetworks", "",
+						ap_get_networks_callback);
+
+	return CMD_STATUS_TRIGGERED;
+}
+
 static const struct command ap_commands[] =3D {
 	{ NULL, "list", NULL, cmd_list, "List devices in AP mode", true },
 	{ "<wlan>", "start", "<\"network name\"> <passphrase>", cmd_start,
@@ -311,6 +423,9 @@ static const struct command ap_commands[] =3D {
 	{ "<wlan>", "stop", NULL,   cmd_stop, "Stop a started access\n"
 		"\t\t\t\t\t\t    point" },
 	{ "<wlan>", "show", NULL, cmd_show, "Show AP info", false },
+	{ "<wlan>", "scan", NULL, cmd_scan, "Start an AP scan", false },
+	{ "<wlan>", "get-networks", NULL, cmd_get_networks,
+				"Get network list after scanning", false },
 	{ }
 };
 =

-- =

2.34.1

--===============5344123137200704215==--

