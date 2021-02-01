Content-Type: multipart/mixed; boundary="===============9098799093498910408=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] client: ap: show Name in 'ap <wlan> show'
Date: Mon, 01 Feb 2021 15:52:16 -0800
Message-ID: <20210201235217.46602-3-prestwoj@gmail.com>
In-Reply-To: <20210201235217.46602-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9098799093498910408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will show some basic AP information like Started and
network Name. Some cleanup was done to make the AP interface
and client table columns line up.
---
 client/ap.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

v2:
 * Added cleanup of 'name'
 * Delayed check of diagnostic interface until after the AP
   properties are displayed.

diff --git a/client/ap.c b/client/ap.c
index 7130bb9a..b0386c60 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -34,6 +34,7 @@
 =

 struct ap {
 	bool started;
+	char *name;
 };
 =

 static void *ap_create(void)
@@ -45,6 +46,9 @@ static void ap_destroy(void *data)
 {
 	struct ap *ap =3D data;
 =

+	if (ap->name)
+		l_free(ap->name);
+
 	l_free(ap);
 }
 =

@@ -74,8 +78,35 @@ static void update_started(void *data, struct l_dbus_mes=
sage_iter *variant)
 	ap->started =3D value;
 }
 =

+static const char *get_name_tostr(const void *data)
+{
+	const struct ap *ap =3D data;
+
+	if (!ap->name)
+		return "";
+
+	return ap->name;
+}
+
+static void update_name(void *data, struct l_dbus_message_iter *variant)
+{
+	struct ap *ap =3D data;
+	const char *name;
+
+	if (ap->name)
+		l_free(ap->name);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &name)) {
+		ap->name =3D NULL;
+		return;
+	}
+
+	ap->name =3D l_strdup(name);
+}
+
 static const struct proxy_interface_property ap_properties[] =3D {
 	{ "Started",  "b", update_started,  get_started_tostr },
+	{ "Name",     "s", update_name, get_name_tostr },
 	{ }
 };
 =

@@ -212,9 +243,9 @@ static void ap_get_diagnostics_callback(struct l_dbus_m=
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
@@ -223,12 +254,20 @@ static enum cmd_status cmd_show(const char *device_na=
me, char **argv, int argc)
 {
 	const struct proxy_interface *ap_diagnostic =3D
 		device_proxy_find(device_name, IWD_AP_DIAGNOSTIC_INTERFACE);
+	const struct proxy_interface *ap_i =3D
+		device_proxy_find(device_name, IWD_ACCESS_POINT_INTERFACE);
 =

-	if (!ap_diagnostic) {
+	if (!ap_i) {
 		display("No ap on device: '%s'\n", device_name);
 		return CMD_STATUS_INVALID_VALUE;
 	}
 =

+	proxy_properties_display(ap_i, "Access Point Interface", MARGIN, 20, 20);
+	display_table_footer();
+
+	if (!ap_diagnostic)
+		return CMD_STATUS_DONE;
+
 	proxy_interface_method_call(ap_diagnostic, "GetDiagnostics", "",
 					ap_get_diagnostics_callback);
 =

-- =

2.26.2

--===============9098799093498910408==--

