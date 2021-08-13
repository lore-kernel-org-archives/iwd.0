Content-Type: multipart/mixed; boundary="===============1074578929685421788=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] station: Add generic Event signal
Date: Fri, 13 Aug 2021 12:47:08 -0700
Message-ID: <20210813194710.807550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1074578929685421788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is meant to be used as a generic notification to autotests. For
now 'no-roam-candidates' is the only event being sent. The idea
is to extend these events to signal conditions that are otherwise
undiscoverable in autotesting.
---
 src/station.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 408ae887..d3482e2c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -153,6 +153,24 @@ static bool station_is_autoconnecting(struct station *=
station)
 			station->state =3D=3D STATION_STATE_AUTOCONNECT_QUICK;
 }
 =

+static bool station_debug_event(struct station *station, const char *name)
+{
+	struct l_dbus_message *signal;
+
+	if (!iwd_is_developer_mode())
+		return true;
+
+	l_debug("StationDebug.Event(%s)", name);
+
+	signal =3D l_dbus_message_new_signal(dbus_get_bus(),
+					netdev_get_path(station->netdev),
+					IWD_STATION_DEBUG_INTERFACE, "Event");
+
+	l_dbus_message_set_arguments(signal, "sav", name, 0);
+
+	return l_dbus_send(dbus_get_bus(), signal) !=3D 0;
+}
+
 static void station_property_set_scanning(struct station *station,
 								bool scanning)
 {
@@ -1938,8 +1956,10 @@ next:
 		goto fail_free_bss;
 =

 	/* See if we have anywhere to roam to */
-	if (!best_bss || scan_bss_addr_eq(best_bss, station->connected_bss))
+	if (!best_bss || scan_bss_addr_eq(best_bss, station->connected_bss)) {
+		station_debug_event(station, "no-roam-candidates");
 		goto fail_free_bss;
+	}
 =

 	bss =3D network_bss_find_by_addr(network, best_bss->addr);
 	if (bss) {
@@ -3991,6 +4011,8 @@ static void station_setup_debug_interface(
 					station_debug_scan, "", "aq",
 					"frequencies");
 =

+	l_dbus_interface_signal(interface, "Event", 0, "sav", "name", "data");
+
 	l_dbus_interface_property(interface, "AutoConnect", 0, "b",
 					station_property_get_autoconnect,
 					station_property_set_autoconnect);
-- =

2.31.1

--===============1074578929685421788==--

