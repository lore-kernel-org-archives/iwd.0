Content-Type: multipart/mixed; boundary="===============5954241121336758445=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/7] station: create StationDiagnostic interface
Date: Mon, 11 Jan 2021 13:35:01 -0800
Message-ID: <20210111213502.551370-6-prestwoj@gmail.com>
In-Reply-To: <20210111213502.551370-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5954241121336758445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This interface sits aside the regular station interface but
provides low level connection details for diagnostic and
testing purposes.
---
 src/station.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

v2:
 * Moved the dbus dict append to its own API in dbus.c
 * Fixed returning empty message on error

diff --git a/src/station.c b/src/station.c
index 1e3706af..f6255a32 100644
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
@@ -3455,6 +3459,94 @@ static void station_destroy_interface(void *user_dat=
a)
 	station_free(station);
 }
 =

+static void station_get_diagnostic_cb(struct netdev_station_info *info,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	struct l_dbus_message *reply;
+	struct l_dbus_message_builder *builder;
+	int16_t rssi;
+
+
+	if (!info) {
+		reply =3D dbus_error_aborted(station->get_station_pending);
+		goto done;
+	}
+
+	reply =3D l_dbus_message_new_method_return(station->get_station_pending);
+
+	rssi =3D (int16_t)info->cur_rssi;
+
+	builder =3D l_dbus_message_builder_new(reply);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	dbus_append_dict_basic(builder, "ConnectedBss", "s",
+						util_address_to_string(
+						station->connected_bss->addr));
+	dbus_append_dict_basic(builder, "RSSI", "n", &rssi);
+	dbus_append_dict_basic(builder, "TxBitrate", "u", &info->tx_bitrate);
+	dbus_append_dict_basic(builder, "TxMCS", "y", &info->tx_mcs);
+	dbus_append_dict_basic(builder, "RxBitrate", "u", &info->rx_bitrate);
+	dbus_append_dict_basic(builder, "RxMCS", "y", &info->rx_mcs);
+	dbus_append_dict_basic(builder, "ExpectedThroughput", "u",
+				&info->expected_throughput);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
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
+		reply =3D dbus_error_aborted(station->get_station_pending);
+		dbus_pending_reply(&station->get_station_pending, reply);
+	}
+}
+
+static struct l_dbus_message *station_get_diagnostics(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct station *station =3D user_data;
+	int ret;
+
+	/*
+	 * At this time all values depend on a connected state.
+	 */
+	if (station->state !=3D STATION_STATE_CONNECTED)
+		return dbus_error_not_connected(message);
+
+	ret =3D netdev_get_current_station(station->netdev,
+				station_get_diagnostic_cb, station,
+				station_get_diagnostic_destroy);
+	if (ret < 0)
+		return dbus_error_from_errno(ret, message);
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
@@ -3483,6 +3575,11 @@ static int station_init(void)
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
@@ -3521,6 +3618,8 @@ static int station_init(void)
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

--===============5954241121336758445==--

