Content-Type: multipart/mixed; boundary="===============2113076342868590900=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] client: ap: show SSID in 'ap <wlan> show'
Date: Mon, 01 Feb 2021 14:05:18 -0800
Message-ID: <20210201220518.36975-5-prestwoj@gmail.com>
In-Reply-To: <20210201220518.36975-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2113076342868590900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will show some basic AP information like Started and
SSID. Some cleanup was done to make the AP interface and
client table columns line up.
---
 client/ap.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/client/ap.c b/client/ap.c
index 9a7f8642..783f1e19 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -34,6 +34,7 @@
 =

 struct ap {
 	bool started;
+	char *ssid;
 };
 =

 static void *ap_create(void)
@@ -74,8 +75,35 @@ static void update_started(void *data, struct l_dbus_mes=
sage_iter *variant)
 	ap->started =3D value;
 }
 =

+static const char *get_ssid_tostr(const void *data)
+{
+	const struct ap *ap =3D data;
+
+	if (!ap->ssid)
+		return "";
+
+	return ap->ssid;
+}
+
+static void update_ssid(void *data, struct l_dbus_message_iter *variant)
+{
+	struct ap *ap =3D data;
+	const char *ssid;
+
+	if (ap->ssid)
+		l_free(ap->ssid);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &ssid)) {
+		ap->ssid =3D NULL;
+		return;
+	}
+
+	ap->ssid =3D l_strdup(ssid);
+}
+
 static const struct proxy_interface_property ap_properties[] =3D {
 	{ "Started",  "b", update_started,  get_started_tostr },
+	{ "SSID",     "s", update_ssid, get_ssid_tostr },
 	{ }
 };
 =

@@ -221,9 +249,9 @@ static void ap_get_diagnostics_callback(struct l_dbus_m=
essage *message,
 =

 	while (l_dbus_message_iter_next_entry(&array, &iter)) {
 		sprintf(client_num, "Client %u", idx++);
-		display_table_header(client_num, "%-*s%-*s",
+		display_table_header(client_num, "            %-*s%-*s",
 					20, "Property", 20, "Value");
-		diagnostic_display(&iter, "", 20, 20);
+		diagnostic_display(&iter, "            ", 20, 20);
 		display_table_footer();
 	}
 }
@@ -232,12 +260,17 @@ static enum cmd_status cmd_show(const char *device_na=
me, char **argv, int argc)
 {
 	const struct proxy_interface *ap_diagnostic =3D
 		device_proxy_find(device_name, IWD_AP_DIAGNOSTIC_INTERFACE);
+	const struct proxy_interface *ap_i =3D
+		device_proxy_find(device_name, IWD_ACCESS_POINT_INTERFACE);
 =

-	if (!ap_diagnostic) {
+	if (!ap_diagnostic || !ap_i) {
 		display("No ap on device: '%s'\n", device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 =

+	proxy_properties_display(ap_i, "Access Point Interface", MARGIN, 20, 20);
+	display_table_footer();
+
 	proxy_interface_method_call(ap_diagnostic, "GetDiagnostics", "",
 					ap_get_diagnostics_callback);
 =

-- =

2.26.2

--===============2113076342868590900==--

