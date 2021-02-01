Content-Type: multipart/mixed; boundary="===============5793156734792384675=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] ap: add SSID property
Date: Mon, 01 Feb 2021 14:05:16 -0800
Message-ID: <20210201220518.36975-3-prestwoj@gmail.com>
In-Reply-To: <20210201220518.36975-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5793156734792384675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Its useful being able to refer to the SSID once an AP is
started. For example opening an iwctl session with an
already started AP provides no way of obtaining the SSID.
---
 src/ap.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index fddf0255..d58932dd 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2971,12 +2971,18 @@ static void ap_if_event_func(enum ap_event_type typ=
e, const void *event_data,
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Started");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "SSID");
 		break;
 =

 	case AP_EVENT_STOPPING:
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Started");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "SSID");
 =

 		if (!ap_if->pending)
 			ap_if->ap =3D NULL;
@@ -3112,6 +3118,24 @@ static bool ap_dbus_property_get_started(struct l_db=
us *dbus,
 	return true;
 }
 =

+static bool ap_dbus_property_get_ssid(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	const char *ssid;
+
+	if (!ap_if->ap || !ap_if->ap->config || !ap_if->ap->started)
+		ssid =3D "";
+	else
+		ssid =3D ap_if->ap->config->ssid;
+
+	l_dbus_message_builder_append_basic(builder, 's', ssid);
+
+	return true;
+}
+
 static void ap_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
@@ -3123,6 +3147,8 @@ static void ap_setup_interface(struct l_dbus_interfac=
e *interface)
 =

 	l_dbus_interface_property(interface, "Started", 0, "b",
 					ap_dbus_property_get_started, NULL);
+	l_dbus_interface_property(interface, "SSID", 0, "s",
+					ap_dbus_property_get_ssid, NULL);
 }
 =

 static void ap_destroy_interface(void *user_data)
-- =

2.26.2

--===============5793156734792384675==--

