Content-Type: multipart/mixed; boundary="===============7668866534812943025=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 4/8] ap: add AP diagnostic interface
Date: Fri, 22 Jan 2021 12:38:45 -0800
Message-ID: <20210122203849.679952-4-prestwoj@gmail.com>
In-Reply-To: <20210122203849.679952-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7668866534812943025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a new AccessPointDiagnostic interface. This interface
provides similar low level functionality as StationDiagnostic, but
for when IWD is in AP mode. This uses netdev_get_all_stations
which will dump all stations, parse, and return each station in
an individual callback. Once the dump is complete the destroy is
called and all data is packaged as an array of dictionaries.
---
 src/ap.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index d9e7e404..cef28327 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -52,6 +52,7 @@
 #include "src/eap-wsc.h"
 #include "src/ap.h"
 #include "src/storage.h"
+#include "src/diagnostic.h"
 =

 struct ap_state {
 	struct netdev *netdev;
@@ -2963,6 +2964,89 @@ static void ap_destroy_interface(void *user_data)
 	l_free(ap_if);
 }
 =

+struct diagnostic_data {
+	struct l_dbus_message *pending;
+	struct l_dbus_message_builder *builder;
+};
+
+static void ap_get_station_cb(const struct diagnostic_station_info *info,
+				void *user_data)
+{
+	struct diagnostic_data *data =3D user_data;
+
+	/* First station info */
+	if (!data->builder) {
+		struct l_dbus_message *reply =3D
+				l_dbus_message_new_method_return(data->pending);
+
+		data->builder =3D l_dbus_message_builder_new(reply);
+
+		l_dbus_message_builder_enter_array(data->builder, "a{sv}");
+	}
+
+	l_dbus_message_builder_enter_array(data->builder, "{sv}");
+	dbus_append_dict_basic(data->builder, "Address", 's',
+					util_address_to_string(info->addr));
+
+	diagnostic_info_to_dict(info, data->builder);
+
+	l_dbus_message_builder_leave_array(data->builder);
+}
+
+static void ap_get_station_destroy(void *user_data)
+{
+	struct diagnostic_data *data =3D user_data;
+	struct l_dbus_message *reply;
+
+	if (!data->builder) {
+		reply =3D l_dbus_message_new_method_return(data->pending);
+
+		data->builder =3D l_dbus_message_builder_new(reply);
+
+		l_dbus_message_builder_enter_array(data->builder, "a{sv}");
+	}
+
+	l_dbus_message_builder_leave_array(data->builder);
+	reply =3D l_dbus_message_builder_finalize(data->builder);
+	l_dbus_message_builder_destroy(data->builder);
+
+	dbus_pending_reply(&data->pending, reply);
+
+	l_free(data);
+}
+
+static struct l_dbus_message *ap_dbus_get_diagnostics(struct l_dbus *dbus,
+		struct l_dbus_message *message, void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	struct diagnostic_data *data;
+	int ret;
+
+	data =3D l_new(struct diagnostic_data, 1);
+	data->pending =3D l_dbus_message_ref(message);
+
+	ret =3D netdev_get_all_stations(ap_if->ap->netdev, ap_get_station_cb,
+					data, ap_get_station_destroy);
+
+	if (ret < 0) {
+		l_dbus_message_unref(data->pending);
+		l_free(data);
+		return dbus_error_from_errno(ret, message);
+	}
+
+	return NULL;
+}
+
+static void ap_setup_diagnostic_interface(struct l_dbus_interface *interfa=
ce)
+{
+	l_dbus_interface_method(interface, "GetDiagnostics", 0,
+				ap_dbus_get_diagnostics, "aa{sv}", "", "diagnostic");
+}
+
+static void ap_diagnostic_interface_destroy(void *user_data)
+{
+}
+
 static void ap_add_interface(struct netdev *netdev)
 {
 	struct ap_if_data *ap_if;
@@ -2978,12 +3062,16 @@ static void ap_add_interface(struct netdev *netdev)
 	/* setup ap dbus interface */
 	l_dbus_object_add_interface(dbus_get_bus(),
 			netdev_get_path(netdev), IWD_AP_INTERFACE, ap_if);
+	l_dbus_object_add_interface(dbus_get_bus(), netdev_get_path(netdev),
+			IWD_AP_DIAGNOSTIC_INTERFACE, ap_if);
 }
 =

 static void ap_remove_interface(struct netdev *netdev)
 {
 	l_dbus_object_remove_interface(dbus_get_bus(),
 			netdev_get_path(netdev), IWD_AP_INTERFACE);
+	l_dbus_object_remove_interface(dbus_get_bus(), netdev_get_path(netdev),
+			IWD_AP_DIAGNOSTIC_INTERFACE);
 }
 =

 static void ap_netdev_watch(struct netdev *netdev,
@@ -3014,6 +3102,9 @@ static int ap_init(void)
 =

 	l_dbus_register_interface(dbus_get_bus(), IWD_AP_INTERFACE,
 			ap_setup_interface, ap_destroy_interface, false);
+	l_dbus_register_interface(dbus_get_bus(), IWD_AP_DIAGNOSTIC_INTERFACE,
+			ap_setup_diagnostic_interface,
+			ap_diagnostic_interface_destroy, false);
 =

 	/*
 	 * Reusing [General].EnableNetworkConfiguration as a switch to enable
-- =

2.26.2

--===============7668866534812943025==--

