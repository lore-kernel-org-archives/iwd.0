Content-Type: multipart/mixed; boundary="===============3547031642162236907=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] ap: add StartWithConfig DBus method
Date: Fri, 30 Oct 2020 09:34:12 -0700
Message-ID: <20201030163413.2446645-4-prestwoj@gmail.com>
In-Reply-To: <20201030163413.2446645-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3547031642162236907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Users can now start an AP from settings based off a config file
on disk. The only argument is the SSID which will be used to
lookup the ap_config loaded during ap_init.
---
 src/ap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 956b7be9..92e8ce62 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2711,6 +2711,44 @@ static struct l_dbus_message *ap_dbus_stop(struct l_=
dbus *dbus,
 	return NULL;
 }
 =

+static bool match_ssid(const void *a, const void *data)
+{
+	const struct ap_config *config =3D a;
+	const char *ssid =3D data;
+
+	return !strcmp(config->ssid, ssid);
+}
+
+static struct l_dbus_message *ap_dbus_start_with_config(struct l_dbus *dbu=
s,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	const char *ssid;
+	struct ap_config *config;
+	int err;
+
+	if (ap_if->ap && ap_if->ap->started)
+		return dbus_error_already_exists(message);
+
+	if (ap_if->ap || ap_if->pending)
+		return dbus_error_busy(message);
+
+	if (!l_dbus_message_get_arguments(message, "s", &ssid))
+		return dbus_error_invalid_args(message);
+
+	config =3D l_queue_find(ap_configs, match_ssid, ssid);
+	if (!config)
+		return dbus_error_not_found(message);
+
+	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err, ap_if);
+	if (!ap_if->ap)
+		return dbus_error_from_errno(err, message);
+
+	ap_if->pending =3D l_dbus_message_ref(message);
+	return NULL;
+}
+
 static bool ap_dbus_property_get_started(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -2729,6 +2767,9 @@ static void ap_setup_interface(struct l_dbus_interfac=
e *interface)
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
 			"ss", "ssid", "wpa2_passphrase");
 	l_dbus_interface_method(interface, "Stop", 0, ap_dbus_stop, "", "");
+	l_dbus_interface_method(interface, "StartWithConfig", 0,
+					ap_dbus_start_with_config, "", "s",
+					"ssid");
 =

 	l_dbus_interface_property(interface, "Started", 0, "b",
 					ap_dbus_property_get_started, NULL);
-- =

2.26.2

--===============3547031642162236907==--

