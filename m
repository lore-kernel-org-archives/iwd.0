Content-Type: multipart/mixed; boundary="===============0747393435075530077=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] device: Switch to new frame watch API
Date: Thu, 16 Jan 2020 03:40:57 +0100
Message-ID: <20200116024100.18371-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0747393435075530077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/device.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0ad1ccbf..c24d7ed1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -37,6 +37,7 @@
 #include "src/scan.h"
 #include "src/netdev.h"
 #include "src/dbus.h"
+#include "src/frame-xchg.h"
 #include "src/station.h"
 =

 struct device {
@@ -48,16 +49,13 @@ struct device {
 	bool powered : 1;		/* Current IFUP state */
 	bool dbus_powered : 1;		/* Last IFUP state wanted via D-Bus */
 =

-	uint32_t ap_roam_watch;
 	uint32_t wiphy_rfkill_watch;
 };
 =

 static uint32_t netdev_watch;
 =

-static void device_ap_roam_frame_event(struct netdev *netdev,
-		const struct mmpdu_header *hdr,
-		const void *body, size_t body_len,
-		void *user_data)
+static void device_ap_roam_frame_event(const struct mmpdu_header *hdr,
+		const void *body, size_t body_len, int rssi, void *user_data)
 {
 	struct device *device =3D user_data;
 	struct station *station =3D station_find(device->index);
@@ -325,9 +323,9 @@ static struct device *device_create(struct wiphy *wiphy=
, struct netdev *netdev)
 	/*
 	 * register for AP roam transition watch
 	 */
-	device->ap_roam_watch =3D netdev_frame_watch_add(netdev, 0x00d0,
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
 			action_ap_roam_prefix, sizeof(action_ap_roam_prefix),
-			device_ap_roam_frame_event, device);
+			device_ap_roam_frame_event, device, NULL);
 =

 	device->powered =3D netdev_get_is_up(netdev);
 =

@@ -343,9 +341,16 @@ static void device_free(struct device *device)
 {
 	l_debug("");
 =

-	netdev_frame_watch_remove(device->netdev, device->ap_roam_watch);
 	wiphy_state_watch_remove(device->wiphy, device->wiphy_rfkill_watch);
 =

+	/*
+	 * We're triggered on NETDEV_WATCH_EVENT_DEL or device_exit.  The former
+	 * is triggered on NL80211_CMD_DEL_INTERFACE and RTM_DELLINK which
+	 * also cause all frame watches to be unregistered so we don't have
+	 * to do this here.  device_exit is triggered under the same conditions
+	 * as frame_xchg_exit.
+	 */
+
 	l_free(device);
 }
 =

-- =

2.20.1

--===============0747393435075530077==--

