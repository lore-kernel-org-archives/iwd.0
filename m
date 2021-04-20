Content-Type: multipart/mixed; boundary="===============0548337872326419627=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 8/8] station: Move AP directed roam watch to station
Date: Tue, 20 Apr 2021 11:35:19 -0500
Message-ID: <20210420163519.12375-8-denkenz@gmail.com>
In-Reply-To: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0548337872326419627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Logically this frame watch belongs in station.  It was kept in device.c
for the purported reason that the station object was removed with
ifdown/ifup changes and hence the frame watch might need to be removed
and re-added unnecessarily.  Since the kernel does not actually allow to
unregister a frame watch (only when the netdev is removed or its iftype
changes), re-adding a frame watch might trigger a -EALREADY or similar
error.

Avoid this by registering the frame watch when a new netdev is detected
in STATION mode, or when the interface type changes to STATION.
---
 src/device.c  | 22 ----------------------
 src/station.c | 51 +++++++++++++++++++++++++++++++++++++++++++++------
 src/station.h |  4 ----
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/src/device.c b/src/device.c
index dc2c181ad4b3..02da2cdc0f08 100644
--- a/src/device.c
+++ b/src/device.c
@@ -37,8 +37,6 @@
 #include "src/scan.h"
 #include "src/netdev.h"
 #include "src/dbus.h"
-#include "src/frame-xchg.h"
-#include "src/station.h"
 =

 struct device {
 	uint32_t index;
@@ -54,18 +52,6 @@ struct device {
 =

 static uint32_t netdev_watch;
 =

-static void device_ap_roam_frame_event(const struct mmpdu_header *hdr,
-		const void *body, size_t body_len, int rssi, void *user_data)
-{
-	struct device *device =3D user_data;
-	struct station *station =3D station_find(device->index);
-
-	if (!station)
-		return;
-
-	station_ap_directed_roam(station, hdr, body, body_len);
-}
-
 static bool device_property_get_name(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -304,7 +290,6 @@ static struct device *device_create(struct wiphy *wiphy=
, struct netdev *netdev)
 	struct device *device;
 	struct l_dbus *dbus =3D dbus_get_bus();
 	uint32_t ifindex =3D netdev_get_ifindex(netdev);
-	const uint8_t action_ap_roam_prefix[2] =3D { 0x0a, 0x07 };
 =

 	device =3D l_new(struct device, 1);
 	device->index =3D ifindex;
@@ -320,13 +305,6 @@ static struct device *device_create(struct wiphy *wiph=
y, struct netdev *netdev)
 		l_info("Unable to register %s interface",
 				L_DBUS_INTERFACE_PROPERTIES);
 =

-	/*
-	 * register for AP roam transition watch
-	 */
-	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
-			action_ap_roam_prefix, sizeof(action_ap_roam_prefix),
-			device_ap_roam_frame_event, device, NULL);
-
 	device->powered =3D netdev_get_is_up(netdev);
 =

 	device->dbus_powered =3D true;
diff --git a/src/station.c b/src/station.c
index 064872c688af..5e3338f0dace 100644
--- a/src/station.c
+++ b/src/station.c
@@ -55,6 +55,7 @@
 #include "src/anqp.h"
 #include "src/anqputil.h"
 #include "src/diagnostic.h"
+#include "src/frame-xchg.h"
 =

 static struct l_queue *station_list;
 static uint32_t netdev_watch;
@@ -2221,9 +2222,9 @@ static bool station_cannot_roam(struct station *stati=
on)
 #define WNM_REQUEST_MODE_TERMINATION_IMMINENT		(1 << 3)
 #define WNM_REQUEST_MODE_ESS_DISASSOCIATION_IMMINENT	(1 << 4)
 =

-void station_ap_directed_roam(struct station *station,
-				const struct mmpdu_header *hdr,
-				const void *body, size_t body_len)
+static void station_ap_directed_roam(struct station *station,
+					const struct mmpdu_header *hdr,
+					const void *body, size_t body_len)
 {
 	uint32_t pos =3D 0;
 	uint8_t req_mode;
@@ -3704,15 +3705,48 @@ static void station_destroy_diagnostic_interface(vo=
id *user_data)
 {
 }
 =

+static void ap_roam_frame_event(const struct mmpdu_header *hdr,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
+{
+	uint32_t ifindex =3D L_PTR_TO_UINT(user_data);
+	struct station *station =3D station_find(ifindex);
+
+	if (!station)
+		return;
+
+	station_ap_directed_roam(station, hdr, body, body_len);
+}
+
+static void add_frame_watches(struct netdev *netdev)
+{
+	static const uint8_t action_ap_roam_prefix[2] =3D { 0x0a, 0x07 };
+
+	/*
+	 * register for AP roam transition watch
+	 */
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
+			action_ap_roam_prefix, sizeof(action_ap_roam_prefix),
+			ap_roam_frame_event,
+			L_UINT_TO_PTR(netdev_get_ifindex(netdev)), NULL);
+}
+
 static void station_netdev_watch(struct netdev *netdev,
 				enum netdev_watch_event event, void *userdata)
 {
 	switch (event) {
-	case NETDEV_WATCH_EVENT_UP:
 	case NETDEV_WATCH_EVENT_NEW:
-		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION &&
-				netdev_get_is_up(netdev))
+		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION) {
+			add_frame_watches(netdev);
+
+			if (netdev_get_is_up(netdev))
+				station_create(netdev);
+		}
+		break;
+	case NETDEV_WATCH_EVENT_UP:
+		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION)
 			station_create(netdev);
+
 		break;
 	case NETDEV_WATCH_EVENT_DOWN:
 	case NETDEV_WATCH_EVENT_DEL:
@@ -3720,6 +3754,11 @@ static void station_netdev_watch(struct netdev *netd=
ev,
 						netdev_get_path(netdev),
 						IWD_STATION_INTERFACE);
 		break;
+	case NETDEV_WATCH_EVENT_IFTYPE_CHANGE:
+		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION)
+			add_frame_watches(netdev);
+
+		break;
 	default:
 		break;
 	}
diff --git a/src/station.h b/src/station.h
index f114733b0cbc..6918b1464a5a 100644
--- a/src/station.h
+++ b/src/station.h
@@ -83,10 +83,6 @@ void station_remove_anqp_watch(uint32_t id);
 =

 bool station_set_autoconnect(struct station *station, bool autoconnect);
 =

-void station_ap_directed_roam(struct station *station,
-				const struct mmpdu_header *hdr,
-				const void *body, size_t body_len);
-
 int __station_connect_network(struct station *station, struct network *net=
work,
 				struct scan_bss *bss);
 void station_connect_network(struct station *station, struct network *netw=
ork,
-- =

2.26.3

--===============0548337872326419627==--

