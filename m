Content-Type: multipart/mixed; boundary="===============3594796080582484161=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] device: Move device creation from netdev.c to event watch
Date: Wed, 20 Nov 2019 23:23:42 +0100
Message-ID: <20191120222346.7881-2-andrew.zaborowski@intel.com>
In-Reply-To: <20191120222346.7881-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3594796080582484161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create and destroy the device state struct and the DBus interfaces in a
way more similar to the Station, AdHoc and AP interfaces.  Drop
netdev_get_device() and the device specific code in netdev that as far
as I can tell wasn't needed.
---
 src/device.c | 42 +++++++++++++++++++++++++++++++-----------
 src/netdev.c | 16 ++++------------
 src/netdev.h |  2 --
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/src/device.c b/src/device.c
index e0e42c4d..4c963bc2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -289,31 +289,48 @@ static void device_netdev_notify(struct netdev *netde=
v,
 					enum netdev_watch_event event,
 					void *user_data)
 {
-	struct device *device =3D netdev_get_device(netdev);
+	struct device *device;
 	struct l_dbus *dbus =3D dbus_get_bus();
+	const char *path =3D netdev_get_path(netdev);
+
+	device =3D l_dbus_object_get_data(dbus, path, IWD_DEVICE_INTERFACE);
 =

-	if (!device)
+	if (!device && event !=3D NETDEV_WATCH_EVENT_NEW)
 		return;
 =

 	switch (event) {
+	case NETDEV_WATCH_EVENT_NEW:
+		if (L_WARN_ON(device))
+			break;
+
+		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_P2P_CLIENT ||
+				netdev_get_iftype(netdev) =3D=3D
+				NETDEV_IFTYPE_P2P_GO)
+			return;
+
+		device_create(netdev_get_wiphy(netdev), netdev);
+		break;
+	case NETDEV_WATCH_EVENT_DEL:
+		l_dbus_unregister_object(dbus, path);
+		break;
 	case NETDEV_WATCH_EVENT_UP:
 		device->powered =3D true;
 =

-		l_dbus_property_changed(dbus, netdev_get_path(device->netdev),
+		l_dbus_property_changed(dbus, path,
 					IWD_DEVICE_INTERFACE, "Powered");
 		break;
 	case NETDEV_WATCH_EVENT_DOWN:
 		device->powered =3D false;
 =

-		l_dbus_property_changed(dbus, netdev_get_path(device->netdev),
+		l_dbus_property_changed(dbus, path,
 					IWD_DEVICE_INTERFACE, "Powered");
 		break;
 	case NETDEV_WATCH_EVENT_NAME_CHANGE:
-		l_dbus_property_changed(dbus, netdev_get_path(device->netdev),
+		l_dbus_property_changed(dbus, path,
 					IWD_DEVICE_INTERFACE, "Name");
 		break;
 	case NETDEV_WATCH_EVENT_ADDRESS_CHANGE:
-		l_dbus_property_changed(dbus, netdev_get_path(device->netdev),
+		l_dbus_property_changed(dbus, path,
 					IWD_DEVICE_INTERFACE, "Address");
 		break;
 	default:
@@ -380,12 +397,8 @@ struct device *device_create(struct wiphy *wiphy, stru=
ct netdev *netdev)
 =

 void device_remove(struct device *device)
 {
-	struct l_dbus *dbus =3D dbus_get_bus();
-
 	l_debug("");
 =

-	l_dbus_unregister_object(dbus, netdev_get_path(device->netdev));
-
 	scan_wdev_remove(netdev_get_wdev_id(device->netdev));
 =

 	netdev_frame_watch_remove(device->netdev, device->ap_roam_watch);
@@ -394,12 +407,19 @@ void device_remove(struct device *device)
 	l_free(device);
 }
 =

+static void destroy_device_interface(void *user_data)
+{
+	struct device *device =3D user_data;
+
+	device_remove(device);
+}
+
 static int device_init(void)
 {
 	if (!l_dbus_register_interface(dbus_get_bus(),
 					IWD_DEVICE_INTERFACE,
 					setup_device_interface,
-					NULL, false))
+					destroy_device_interface, false))
 		return false;
 =

 	netdev_watch =3D netdev_watch_add(device_netdev_notify, NULL, NULL);
diff --git a/src/netdev.c b/src/netdev.c
index e3fcbc1b..3c1510b9 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -50,7 +50,6 @@
 #include "src/eapol.h"
 #include "src/handshake.h"
 #include "src/crypto.h"
-#include "src/device.h"
 #include "src/scan.h"
 #include "src/netdev.h"
 #include "src/ft.h"
@@ -89,7 +88,6 @@ struct netdev {
 	char name[IFNAMSIZ];
 	uint32_t type;
 	uint8_t addr[ETH_ALEN];
-	struct device *device;
 	struct wiphy *wiphy;
 	unsigned int ifi_flags;
 	uint32_t frequency;
@@ -150,6 +148,7 @@ struct netdev {
 	bool expect_connect_failure : 1;
 	bool aborting : 1;
 	bool mac_randomize_once : 1;
+	bool events_ready : 1;
 };
 =

 struct netdev_preauth_state {
@@ -306,11 +305,6 @@ struct handshake_state *netdev_get_handshake(struct ne=
tdev *netdev)
 	return netdev->handshake;
 }
 =

-struct device *netdev_get_device(struct netdev *netdev)
-{
-	return netdev->device;
-}
-
 const char *netdev_get_path(struct netdev *netdev)
 {
 	static char path[256];
@@ -656,11 +650,9 @@ static void netdev_free(void *data)
 		netdev->qos_map_cmd_id =3D 0;
 	}
 =

-	if (netdev->device) {
+	if (netdev->events_ready)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 					netdev, NETDEV_WATCH_EVENT_DEL);
-		device_remove(netdev->device);
-	}
 =

 	watchlist_destroy(&netdev->frame_watches);
 	watchlist_destroy(&netdev->station_watches);
@@ -4203,7 +4195,7 @@ static void netdev_newlink_notify(const struct ifinfo=
msg *ifi, int bytes)
 		}
 	}
 =

-	if (!netdev->device) /* Did we send NETDEV_WATCH_EVENT_NEW yet? */
+	if (!netdev->events_ready) /* Did we send NETDEV_WATCH_EVENT_NEW yet? */
 		return;
 =

 	new_up =3D netdev_get_is_up(netdev);
@@ -4269,9 +4261,9 @@ static void netdev_initial_up_cb(int error, uint16_t =
type, const void *data,
 =

 	l_debug("Interface %i initialized", netdev->index);
 =

-	netdev->device =3D device_create(netdev->wiphy, netdev);
 	WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 				netdev, NETDEV_WATCH_EVENT_NEW);
+	netdev->events_ready =3D true;
 }
 =

 static void netdev_set_mac_cb(int error, uint16_t type, const void *data,
diff --git a/src/netdev.h b/src/netdev.h
index 8028167d..032265f9 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -23,7 +23,6 @@
 #include <stdbool.h>
 =

 struct netdev;
-struct device;
 struct scan_bss;
 struct handshake_state;
 struct eapol_sm;
@@ -135,7 +134,6 @@ int netdev_set_4addr(struct netdev *netdev, bool use_4a=
ddr,
 bool netdev_get_4addr(struct netdev *netdev);
 const char *netdev_get_name(struct netdev *netdev);
 bool netdev_get_is_up(struct netdev *netdev);
-struct device *netdev_get_device(struct netdev *netdev);
 const char *netdev_get_path(struct netdev *netdev);
 =

 struct handshake_state *netdev_handshake_state_new(struct netdev *netdev);
-- =

2.20.1

--===============3594796080582484161==--

