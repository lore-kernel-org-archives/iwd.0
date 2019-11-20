Content-Type: multipart/mixed; boundary="===============0125278201380305464=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] device: Make functions static, drop device.h
Date: Wed, 20 Nov 2019 23:23:43 +0100
Message-ID: <20191120222346.7881-3-andrew.zaborowski@intel.com>
In-Reply-To: <20191120222346.7881-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0125278201380305464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am   |   2 +-
 src/adhoc.c   |   1 -
 src/ap.c      |   1 -
 src/device.c  | 113 +++++++++++++++++++++++++-------------------------
 src/device.h  |  30 --------------
 src/station.c |   1 -
 6 files changed, 57 insertions(+), 91 deletions(-)
 delete mode 100644 src/device.h

diff --git a/Makefile.am b/Makefile.am
index f58006e7..8c69d9f4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -189,7 +189,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/plugin.h src/plugin.c \
 					src/netdev.h src/netdev.c \
 					src/wiphy.h src/wiphy.c \
-					src/device.h src/device.c \
+					src/device.c \
 					src/station.h src/station.c \
 					src/ie.h src/ie.c \
 					src/dbus.h src/dbus.c \
diff --git a/src/adhoc.c b/src/adhoc.c
index a63c4669..52164a0a 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -30,7 +30,6 @@
 =

 #include "src/iwd.h"
 #include "src/module.h"
-#include "src/device.h"
 #include "src/netdev.h"
 #include "src/wiphy.h"
 #include "src/crypto.h"
diff --git a/src/ap.c b/src/ap.c
index 2fca6ce2..c79fe9b5 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -34,7 +34,6 @@
 #include "src/iwd.h"
 #include "src/module.h"
 #include "src/scan.h"
-#include "src/device.h"
 #include "src/netdev.h"
 #include "src/wiphy.h"
 #include "src/crypto.h"
diff --git a/src/device.c b/src/device.c
index 4c963bc2..20224e8f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -38,7 +38,6 @@
 #include "src/netdev.h"
 #include "src/dbus.h"
 #include "src/station.h"
-#include "src/device.h"
 =

 struct device {
 	uint32_t index;
@@ -285,59 +284,6 @@ static void setup_device_interface(struct l_dbus_inter=
face *interface)
 					device_property_set_mode);
 }
 =

-static void device_netdev_notify(struct netdev *netdev,
-					enum netdev_watch_event event,
-					void *user_data)
-{
-	struct device *device;
-	struct l_dbus *dbus =3D dbus_get_bus();
-	const char *path =3D netdev_get_path(netdev);
-
-	device =3D l_dbus_object_get_data(dbus, path, IWD_DEVICE_INTERFACE);
-
-	if (!device && event !=3D NETDEV_WATCH_EVENT_NEW)
-		return;
-
-	switch (event) {
-	case NETDEV_WATCH_EVENT_NEW:
-		if (L_WARN_ON(device))
-			break;
-
-		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_P2P_CLIENT ||
-				netdev_get_iftype(netdev) =3D=3D
-				NETDEV_IFTYPE_P2P_GO)
-			return;
-
-		device_create(netdev_get_wiphy(netdev), netdev);
-		break;
-	case NETDEV_WATCH_EVENT_DEL:
-		l_dbus_unregister_object(dbus, path);
-		break;
-	case NETDEV_WATCH_EVENT_UP:
-		device->powered =3D true;
-
-		l_dbus_property_changed(dbus, path,
-					IWD_DEVICE_INTERFACE, "Powered");
-		break;
-	case NETDEV_WATCH_EVENT_DOWN:
-		device->powered =3D false;
-
-		l_dbus_property_changed(dbus, path,
-					IWD_DEVICE_INTERFACE, "Powered");
-		break;
-	case NETDEV_WATCH_EVENT_NAME_CHANGE:
-		l_dbus_property_changed(dbus, path,
-					IWD_DEVICE_INTERFACE, "Name");
-		break;
-	case NETDEV_WATCH_EVENT_ADDRESS_CHANGE:
-		l_dbus_property_changed(dbus, path,
-					IWD_DEVICE_INTERFACE, "Address");
-		break;
-	default:
-		break;
-	}
-}
-
 static void device_wiphy_state_changed_event(struct wiphy *wiphy,
 					enum wiphy_state_watch_event event,
 					void *user_data)
@@ -355,7 +301,7 @@ static void device_wiphy_state_changed_event(struct wip=
hy *wiphy,
 	}
 }
 =

-struct device *device_create(struct wiphy *wiphy, struct netdev *netdev)
+static struct device *device_create(struct wiphy *wiphy, struct netdev *ne=
tdev)
 {
 	struct device *device;
 	struct l_dbus *dbus =3D dbus_get_bus();
@@ -395,7 +341,7 @@ struct device *device_create(struct wiphy *wiphy, struc=
t netdev *netdev)
 	return device;
 }
 =

-void device_remove(struct device *device)
+static void device_free(struct device *device)
 {
 	l_debug("");
 =

@@ -407,11 +353,64 @@ void device_remove(struct device *device)
 	l_free(device);
 }
 =

+static void device_netdev_notify(struct netdev *netdev,
+					enum netdev_watch_event event,
+					void *user_data)
+{
+	struct device *device;
+	struct l_dbus *dbus =3D dbus_get_bus();
+	const char *path =3D netdev_get_path(netdev);
+
+	device =3D l_dbus_object_get_data(dbus, path, IWD_DEVICE_INTERFACE);
+
+	if (!device && event !=3D NETDEV_WATCH_EVENT_NEW)
+		return;
+
+	switch (event) {
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
+	case NETDEV_WATCH_EVENT_UP:
+		device->powered =3D true;
+
+		l_dbus_property_changed(dbus, path,
+					IWD_DEVICE_INTERFACE, "Powered");
+		break;
+	case NETDEV_WATCH_EVENT_DOWN:
+		device->powered =3D false;
+
+		l_dbus_property_changed(dbus, path,
+					IWD_DEVICE_INTERFACE, "Powered");
+		break;
+	case NETDEV_WATCH_EVENT_NAME_CHANGE:
+		l_dbus_property_changed(dbus, path,
+					IWD_DEVICE_INTERFACE, "Name");
+		break;
+	case NETDEV_WATCH_EVENT_ADDRESS_CHANGE:
+		l_dbus_property_changed(dbus, path,
+					IWD_DEVICE_INTERFACE, "Address");
+		break;
+	default:
+		break;
+	}
+}
+
 static void destroy_device_interface(void *user_data)
 {
 	struct device *device =3D user_data;
 =

-	device_remove(device);
+	device_free(device);
 }
 =

 static int device_init(void)
diff --git a/src/device.h b/src/device.h
deleted file mode 100644
index 31e472be..00000000
--- a/src/device.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- *
- *  Wireless daemon for Linux
- *
- *  Copyright (C) 2013-2019  Intel Corporation. All rights reserved.
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#include <stdbool.h>
-
-struct wiphy;
-struct netdev;
-struct device;
-
-struct device *device_create(struct wiphy *wiphy, struct netdev *netdev);
-void device_remove(struct device *device);
diff --git a/src/station.c b/src/station.c
index 76cf20a1..b98aeb63 100644
--- a/src/station.c
+++ b/src/station.c
@@ -37,7 +37,6 @@
 #include "src/iwd.h"
 #include "src/module.h"
 #include "src/common.h"
-#include "src/device.h"
 #include "src/watchlist.h"
 #include "src/scan.h"
 #include "src/netdev.h"
-- =

2.20.1

--===============0125278201380305464==--

