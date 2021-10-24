Content-Type: multipart/mixed; boundary="===============0295933536150370309=="
MIME-Version: 1.0
From: Michael Trimarchi <michael at amarulasolutions.com>
To: iwd at lists.01.org
Subject: [RFC PATCH] ap: Expose connected stations property
Date: Sun, 24 Oct 2021 09:13:38 +0000
Message-ID: <20211024091338.21203-1-michael@amarulasolutions.com>

--===============0295933536150370309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a way to be notified about the connected stations in access
point mode. This can be used in order to ask from Diagnostic
interface the properties for each station or to just use them
from other services like connman or network manager to report
the number of clients

Signed-off-by: Michael Trimarchi <michael(a)amarulasolutions.com>
---
 src/ap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 46a7a6a8..e88be99c 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -98,6 +98,7 @@ struct ap_state {
 	uint8_t netconfig_gateway4_mac[6];
 	uint8_t netconfig_dns4_mac[6];
 =

+	uint16_t connected_stations;
 	bool started : 1;
 	bool gtk_set : 1;
 	bool netconfig_set_addr4 : 1;
@@ -347,6 +348,7 @@ static void ap_new_rsna(struct sta_state *sta)
 		event_data.assoc_ies_len =3D sta->assoc_ies_len;
 		ap->ops->handle_event(AP_EVENT_STATION_ADDED, &event_data,
 					ap->user_data);
+		ap->connected_stations++;
 	}
 }
 =

@@ -385,6 +387,7 @@ static void ap_drop_rsna(struct sta_state *sta)
 		event_data.mac =3D sta->addr;
 		ap->ops->handle_event(AP_EVENT_STATION_REMOVED, &event_data,
 					ap->user_data);
+		ap->connected_stations++;
 	}
 }
 =

@@ -3495,6 +3498,10 @@ static void ap_if_event_func(enum ap_event_type type=
, const void *event_data,
 =

 	case AP_EVENT_STATION_ADDED:
 	case AP_EVENT_STATION_REMOVED:
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "ConnectedStations");
+		break;
 	case AP_EVENT_REGISTRATION_START:
 	case AP_EVENT_REGISTRATION_SUCCESS:
 	case AP_EVENT_PBC_MODE_EXIT:
@@ -3626,6 +3633,19 @@ error:
 	return dbus_error_from_errno(err, message);
 }
 =

+static bool ap_dbus_property_connected_stations(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						struct l_dbus_message_builder *builder,
+						void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	uint16_t stations =3D ap_if->ap ? ap_if->ap->connected_stations : 0;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &stations);
+
+	return true;
+}
+
 static bool ap_dbus_property_get_started(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -3668,6 +3688,9 @@ static void ap_setup_interface(struct l_dbus_interfac=
e *interface)
 					ap_dbus_property_get_started, NULL);
 	l_dbus_interface_property(interface, "Name", 0, "s",
 					ap_dbus_property_get_name, NULL);
+
+	l_dbus_interface_property(interface, "ConnectedStations", 0, "i",
+					ap_dbus_property_connected_stations, NULL);
 }
 =

 static void ap_destroy_interface(void *user_data)
-- =

2.25.1

--===============0295933536150370309==--

