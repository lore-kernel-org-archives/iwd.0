Content-Type: multipart/mixed; boundary="===============8294112569987946765=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] station: implement Scan on debug interface
Date: Thu, 12 Aug 2021 16:12:28 -0700
Message-ID: <20210812231233.747743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8294112569987946765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is to support the autotesting framework by allowing a smaller
scan subset. This will cut down on the amount of time spent scanning
via normal DBus scans (where the entire spectrum is scanned).
---
 src/station.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/src/station.c b/src/station.c
index 2155aa3c..5d447356 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3839,6 +3839,109 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 =

+static void station_debug_scan_triggered(int err, void *user_data)
+{
+	struct station *station =3D user_data;
+	struct l_dbus_message *reply;
+
+	if (err < 0) {
+		if (station->scan_pending) {
+			reply =3D dbus_error_from_errno(err,
+							station->scan_pending);
+			dbus_pending_reply(&station->scan_pending, reply);
+		}
+
+		station_dbus_scan_done(station);
+		return;
+	}
+
+	l_debug("debug scan triggered for %s",
+			netdev_get_name(station->netdev));
+
+	if (station->scan_pending) {
+		reply =3D l_dbus_message_new_method_return(station->scan_pending);
+		l_dbus_message_set_arguments(reply, "");
+		dbus_pending_reply(&station->scan_pending, reply);
+	}
+
+	station_property_set_scanning(station, true);
+}
+
+static bool station_debug_scan_results(int err, struct l_queue *bss_list,
+					const struct scan_freq_set *freqs,
+					void *userdata)
+{
+	struct station *station =3D userdata;
+	bool autoconnect;
+
+	if (err) {
+		station_dbus_scan_done(station);
+		return false;
+	}
+
+	autoconnect =3D station_is_autoconnecting(station);
+	station_set_scan_results(station, bss_list, freqs, autoconnect);
+
+	station_dbus_scan_done(station);
+
+	return true;
+}
+
+static struct l_dbus_message *station_debug_scan(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct station *station =3D user_data;
+	struct l_dbus_message_iter iter;
+	uint16_t *freqs;
+	uint32_t freqs_len;
+	struct scan_freq_set *freq_set;
+	unsigned int i;
+
+	if (station->dbus_scan_id)
+		return dbus_error_busy(message);
+
+	if (station->state =3D=3D STATION_STATE_CONNECTING ||
+			station->state =3D=3D STATION_STATE_CONNECTING_AUTO)
+		return dbus_error_busy(message);
+
+	if (!l_dbus_message_get_arguments(message, "aq", &iter))
+		goto invalid_args;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &freqs, &freqs_len))
+		goto invalid_args;
+
+	freq_set =3D scan_freq_set_new();
+
+	for (i =3D 0; i < freqs_len; i++) {
+		if (!scan_freq_set_add(freq_set, (uint32_t)freqs[i])) {
+			scan_freq_set_free(freq_set);
+			goto invalid_args;
+		}
+
+		l_debug("added frequency %u", freqs[i]);
+	}
+
+	station->dbus_scan_id =3D station_scan_trigger(station, freq_set,
+						station_debug_scan_triggered,
+						station_debug_scan_results,
+						NULL);
+
+	scan_freq_set_free(freq_set);
+
+	if (!station->dbus_scan_id)
+		goto failed;
+
+	station->scan_pending =3D l_dbus_message_ref(message);
+
+	return NULL;
+
+failed:
+	return dbus_error_failed(message);
+invalid_args:
+	return dbus_error_invalid_args(message);
+}
+
 static bool station_property_get_autoconnect(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -3883,6 +3986,10 @@ static void station_setup_debug_interface(
 	l_dbus_interface_method(interface, "Roam", 0,
 					station_force_roam, "", "ay", "mac");
 =

+	l_dbus_interface_method(interface, "Scan", 0,
+					station_debug_scan, "", "aq",
+					"frequencies");
+
 	l_dbus_interface_property(interface, "AutoConnect", 0, "b",
 					station_property_get_autoconnect,
 					station_property_set_autoconnect);
-- =

2.31.1

--===============8294112569987946765==--

