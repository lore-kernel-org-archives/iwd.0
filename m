Content-Type: multipart/mixed; boundary="===============8365733028444174784=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] station: Add RoamScanning property to debug interface
Date: Fri, 13 Aug 2021 09:13:44 -0700
Message-ID: <20210813161346.793270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8365733028444174784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This lets the test environment know if IWD is attempting a roam
prior to the roaming state being set.
---
 src/station.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 408ae887..a1885cfa 100644
--- a/src/station.c
+++ b/src/station.c
@@ -114,6 +114,7 @@ struct station {
 	bool ap_directed_roaming : 1;
 	bool scanning : 1;
 	bool autoconnect : 1;
+	bool roam_scanning : 1;
 };
 =

 struct anqp_entry {
@@ -1842,8 +1843,15 @@ static void station_roam_scan_triggered(int err, voi=
d *user_data)
 =

 	/*
 	 * Do not update the Scanning property as we won't be updating the
-	 * list of networks.
+	 * list of networks. But if in developer mode update the RoamScanning
+	 * property for autotesting.
 	 */
+	station->roam_scanning =3D true;
+
+	if (iwd_is_developer_mode())
+		l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(station->netdev),
+				IWD_STATION_DEBUG_INTERFACE, "RoamScanning");
 }
 =

 static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
@@ -1968,6 +1976,12 @@ static void station_roam_scan_destroy(void *userdata)
 	struct station *station =3D userdata;
 =

 	station->roam_scan_id =3D 0;
+	station->roam_scanning =3D false;
+
+	if (iwd_is_developer_mode())
+		l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(station->netdev),
+				IWD_STATION_DEBUG_INTERFACE, "RoamScanning");
 }
 =

 static int station_roam_scan(struct station *station,
@@ -3978,6 +3992,22 @@ static struct l_dbus_message *station_property_set_a=
utoconnect(
 	return l_dbus_message_new_method_return(message);
 }
 =

+static bool station_property_get_roam_scanning(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	bool scanning;
+
+	scanning =3D station->roam_scanning;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &scanning);
+
+	return true;
+}
+
+
 static void station_setup_debug_interface(
 					struct l_dbus_interface *interface)
 {
@@ -3994,6 +4024,9 @@ static void station_setup_debug_interface(
 	l_dbus_interface_property(interface, "AutoConnect", 0, "b",
 					station_property_get_autoconnect,
 					station_property_set_autoconnect);
+	l_dbus_interface_property(interface, "RoamScanning", 0, "b",
+					station_property_get_roam_scanning,
+					NULL);
 }
 =

 static void ap_roam_frame_event(const struct mmpdu_header *hdr,
-- =

2.31.1

--===============8365733028444174784==--

