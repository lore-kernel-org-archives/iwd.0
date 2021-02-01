Content-Type: multipart/mixed; boundary="===============8377835037862446011=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] ap: add Name property
Date: Mon, 01 Feb 2021 15:52:14 -0800
Message-ID: <20210201235217.46602-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8377835037862446011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Its useful being able to refer to the network Name/SSID once
an AP is started. For example opening an iwctl session with an
already started AP provides no way of obtaining the SSID.
---
 src/ap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

v2:
 * changed 'SSID' to 'Name'

diff --git a/src/ap.c b/src/ap.c
index 37dd05b9..f33d73e1 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2971,12 +2971,18 @@ static void ap_if_event_func(enum ap_event_type typ=
e, const void *event_data,
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Started");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "Name");
 		break;
 =

 	case AP_EVENT_STOPPING:
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Started");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "Name");
 =

 		if (!ap_if->pending)
 			ap_if->ap =3D NULL;
@@ -3112,6 +3118,22 @@ static bool ap_dbus_property_get_started(struct l_db=
us *dbus,
 	return true;
 }
 =

+static bool ap_dbus_property_get_name(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+
+	if (!ap_if->ap || !ap_if->ap->config || !ap_if->ap->started)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's',
+						ap_if->ap->config->ssid);
+
+	return true;
+}
+
 static void ap_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
@@ -3123,6 +3145,8 @@ static void ap_setup_interface(struct l_dbus_interfac=
e *interface)
 =

 	l_dbus_interface_property(interface, "Started", 0, "b",
 					ap_dbus_property_get_started, NULL);
+	l_dbus_interface_property(interface, "Name", 0, "s",
+					ap_dbus_property_get_name, NULL);
 }
 =

 static void ap_destroy_interface(void *user_data)
-- =

2.26.2

--===============8377835037862446011==--

