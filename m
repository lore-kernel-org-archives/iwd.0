Content-Type: multipart/mixed; boundary="===============6633999792331161786=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/5] station: commonize the building of diagnostic dict
Date: Thu, 21 Jan 2021 10:11:09 -0800
Message-ID: <20210121181113.572092-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6633999792331161786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AP mode will use the same structure for its diagnostic interface
and mostly the same dictionary keys. Apart from ConnectedBss and
Address being different, the remainder are the same so the
netdev_station_info to DBus dictionary conversion has been made
common so both station and AP can use it to build its diagnostic
dictionaries.
---
 src/station.c | 71 ++++++++++++++++++++++++++++++---------------------
 src/station.h |  3 +++
 2 files changed, 45 insertions(+), 29 deletions(-)

v2:
 * Generalized the dictionary building so both station and AP could
   use it.

diff --git a/src/station.c b/src/station.c
index c65fc0cc..3582ea24 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3448,36 +3448,16 @@ static void station_setup_interface(struct l_dbus_i=
nterface *interface)
 					station_property_get_state, NULL);
 }
 =

-static void station_destroy_interface(void *user_data)
-{
-	struct station *station =3D user_data;
-
-	station_free(station);
-}
-
-static void station_get_diagnostic_cb(const struct netdev_station_info *in=
fo,
-					void *user_data)
+/*
+ * Appends values from netdev_station_info into a DBus dictionary. This as=
sumes
+ * the DBus dictionary array has already been 'entered', and expects the
+ * caller to 'leave' once called. This does not append the station address
+ * since the dictionary key name may be different depending on the caller.
+ */
+bool station_info_to_dict(const struct netdev_station_info *info,
+				struct l_dbus_message_builder *builder)
 {
-	struct station *station =3D user_data;
-	struct l_dbus_message *reply;
-	struct l_dbus_message_builder *builder;
-	int16_t rssi;
-
-	if (!info) {
-		reply =3D dbus_error_aborted(station->get_station_pending);
-		goto done;
-	}
-
-	reply =3D l_dbus_message_new_method_return(station->get_station_pending);
-
-	rssi =3D (int16_t)info->cur_rssi;
-
-	builder =3D l_dbus_message_builder_new(reply);
-
-	l_dbus_message_builder_enter_array(builder, "{sv}");
-
-	dbus_append_dict_basic(builder, "ConnectedBss", 's',
-					util_address_to_string(info->addr));
+	int16_t rssi =3D (int16_t)info->cur_rssi;
 =

 	if (info->have_cur_rssi)
 		dbus_append_dict_basic(builder, "RSSI", 'n', &rssi);
@@ -3544,6 +3524,39 @@ static void station_get_diagnostic_cb(const struct n=
etdev_station_info *info,
 		dbus_append_dict_basic(builder, "ExpectedThroughput", 'u',
 					&info->expected_throughput);
 =

+	return true;
+}
+
+static void station_destroy_interface(void *user_data)
+{
+	struct station *station =3D user_data;
+
+	station_free(station);
+}
+
+static void station_get_diagnostic_cb(const struct netdev_station_info *in=
fo,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	struct l_dbus_message *reply;
+	struct l_dbus_message_builder *builder;
+
+	if (!info) {
+		reply =3D dbus_error_aborted(station->get_station_pending);
+		goto done;
+	}
+
+	reply =3D l_dbus_message_new_method_return(station->get_station_pending);
+
+	builder =3D l_dbus_message_builder_new(reply);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	dbus_append_dict_basic(builder, "ConnectedBss", 's',
+					util_address_to_string(info->addr));
+
+	station_info_to_dict(info, builder);
+
 	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
diff --git a/src/station.h b/src/station.h
index c4fd505b..f6b46bd1 100644
--- a/src/station.h
+++ b/src/station.h
@@ -100,3 +100,6 @@ void station_network_foreach(struct station *station,
 				void *user_data);
 struct l_queue *station_get_bss_list(struct station *station);
 struct scan_bss *station_get_connected_bss(struct station *station);
+
+bool station_info_to_dict(const struct netdev_station_info *info,
+				struct l_dbus_message_builder *builder);
-- =

2.26.2

--===============6633999792331161786==--

