Content-Type: multipart/mixed; boundary="===============5247991891824383050=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] station: make autoconnect settable via debug interface
Date: Thu, 12 Aug 2021 13:38:06 -0700
Message-ID: <20210812203812.738060-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5247991891824383050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds the property "AutoConnect" to the station debug interface
which can be read/written to disable or enable autoconnect globally.
As one would expect this property is only going to be used for testing
hence why it was put on the debug interface. Mosts tests disable
autoconnect (or they should) because it leads to unexpected connections.
---
 src/station.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/src/station.c b/src/station.c
index f77fd663..f9b2b16d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1211,6 +1211,11 @@ bool station_set_autoconnect(struct station *station=
, bool autoconnect)
 	if (station_is_autoconnecting(station) && !autoconnect)
 		station_enter_state(station, STATION_STATE_DISCONNECTED);
 =

+	if (iwd_is_developer_mode())
+		l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(station->netdev),
+				IWD_STATION_DEBUG_INTERFACE, "AutoConnect");
+
 	return true;
 }
 =

@@ -3831,6 +3836,41 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 =

+static bool station_property_get_autoconnect(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	bool autoconnect;
+
+	autoconnect =3D station->autoconnect;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &autoconnect);
+
+	return true;
+}
+
+static struct l_dbus_message *station_property_set_autoconnect(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	bool autoconnect;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "b", &autoconnect))
+		return dbus_error_invalid_args(message);
+
+	l_debug("Setting autoconnect %s", autoconnect ? "true" : "false");
+
+	station_set_autoconnect(station, autoconnect);
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void station_setup_debug_interface(
 					struct l_dbus_interface *interface)
 {
@@ -3839,6 +3879,10 @@ static void station_setup_debug_interface(
 					"mac");
 	l_dbus_interface_method(interface, "Roam", 0,
 					station_force_roam, "", "ay", "mac");
+
+	l_dbus_interface_property(interface, "AutoConnect", 0, "b",
+					station_property_get_autoconnect,
+					station_property_set_autoconnect);
 }
 =

 static void ap_roam_frame_event(const struct mmpdu_header *hdr,
-- =

2.31.1

--===============5247991891824383050==--

