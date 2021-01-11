Content-Type: multipart/mixed; boundary="===============2173201145715560762=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] station: create StationDiagnostic interface
Date: Mon, 11 Jan 2021 09:12:38 -0800
Message-ID: <20210111171239.472372-7-prestwoj@gmail.com>
In-Reply-To: <20210111171239.472372-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2173201145715560762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This interface sits aside the regular station interface but
provides low level connection details for diagnostic and
testing purposes.
---
 src/station.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/src/station.c b/src/station.c
index 1e3706af..8cdd5443 100644
--- a/src/station.c
+++ b/src/station.c
@@ -77,6 +77,7 @@ struct station {
 	struct l_dbus_message *hidden_pending;
 	struct l_dbus_message *disconnect_pending;
 	struct l_dbus_message *scan_pending;
+	struct l_dbus_message *get_station_pending;
 	struct signal_agent *signal_agent;
 	uint32_t dbus_scan_id;
 	uint32_t quick_scan_id;
@@ -3333,6 +3334,9 @@ static struct station *station_create(struct netdev *=
netdev)
 =

 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_STATION_INTERFACE, station);
+	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
+					IWD_STATION_DIAGNOSTIC_INTERFACE,
+					station);
 =

 	if (netconfig_enabled)
 		station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev));
@@ -3455,6 +3459,111 @@ static void station_destroy_interface(void *user_da=
ta)
 	station_free(station);
 }
 =

+/*
+ * Helper to append a dictionary value. This will only work for basic type=
s.
+ */
+static void append_dict(struct l_dbus_message_builder *builder,
+			const char *name, const char *type, const void *data)
+{
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', name);
+	l_dbus_message_builder_enter_variant(builder, type);
+	l_dbus_message_builder_append_basic(builder, type[0], data);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+static void station_build_diagnostic_dict(struct station *station,
+					struct l_dbus_message *msg,
+					struct netdev_station_info *info)
+{
+	struct l_dbus_message_builder *builder =3D
+					l_dbus_message_builder_new(msg);
+	int16_t rssi =3D (int16_t)info->cur_rssi;
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	append_dict(builder, "ConnectedBss", "s", util_address_to_string(
+						station->connected_bss->addr));
+	append_dict(builder, "RSSI", "n", &rssi);
+	append_dict(builder, "TxBitrate", "u", &info->tx_bitrate);
+	append_dict(builder, "TxMCS", "y", &info->tx_mcs);
+	append_dict(builder, "RxBitrate", "u", &info->rx_bitrate);
+	append_dict(builder, "RxMCS", "y", &info->rx_mcs);
+	append_dict(builder, "ExpectedThroughput", "u",
+				&info->expected_throughput);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void station_get_diagnostic_cb(struct netdev *netdev,
+					struct netdev_station_info *info,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	struct l_dbus_message *reply;
+
+	if (!info) {
+		reply =3D dbus_error_aborted(station->get_station_pending);
+		goto done;
+	}
+
+	reply =3D l_dbus_message_new_method_return(station->get_station_pending);
+
+	station_build_diagnostic_dict(station, reply, info);
+
+done:
+	dbus_pending_reply(&station->get_station_pending, reply);
+}
+
+static void station_get_diagnostic_destroy(void *user_data)
+{
+	struct station *station =3D user_data;
+	struct l_dbus_message *reply;
+
+	if (station->get_station_pending) {
+		reply =3D l_dbus_message_new_method_return(
+						station->get_station_pending);
+		dbus_pending_reply(&station->get_station_pending, reply);
+	}
+}
+
+static struct l_dbus_message *station_get_diagnostics(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct station *station =3D user_data;
+
+	/*
+	 * At this time all values depend on a connected state.
+	 */
+	if (station->state !=3D STATION_STATE_CONNECTED)
+		return dbus_error_not_connected(message);
+
+	if (netdev_get_station(station->netdev, station->connected_bss->addr,
+				station_get_diagnostic_cb, station,
+				station_get_diagnostic_destroy) < 0)
+		return dbus_error_busy(message);
+
+	station->get_station_pending =3D l_dbus_message_ref(message);
+
+	return NULL;
+}
+
+static void station_setup_diagnostic_interface(
+					struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "GetDiagnostics", 0,
+				station_get_diagnostics, "a{sv}", "",
+				"diagnostics");
+}
+
+static void station_destroy_diagnostic_interface(void *user_data)
+{
+}
+
 static void station_netdev_watch(struct netdev *netdev,
 				enum netdev_watch_event event, void *userdata)
 {
@@ -3483,6 +3592,11 @@ static int station_init(void)
 	l_dbus_register_interface(dbus_get_bus(), IWD_STATION_INTERFACE,
 					station_setup_interface,
 					station_destroy_interface, false);
+	l_dbus_register_interface(dbus_get_bus(),
+					IWD_STATION_DIAGNOSTIC_INTERFACE,
+					station_setup_diagnostic_interface,
+					station_destroy_diagnostic_interface,
+					false);
 =

 	if (!l_settings_get_uint(iwd_get_config(), "General",
 					"ManagementFrameProtection",
@@ -3521,6 +3635,8 @@ static int station_init(void)
 =

 static void station_exit(void)
 {
+	l_dbus_unregister_interface(dbus_get_bus(),
+					IWD_STATION_DIAGNOSTIC_INTERFACE);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_STATION_INTERFACE);
 	netdev_watch_remove(netdev_watch);
 	l_queue_destroy(station_list, NULL);
-- =

2.26.2

--===============2173201145715560762==--

