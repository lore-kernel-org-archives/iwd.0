Content-Type: multipart/mixed; boundary="===============5451145617297959913=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/5] test: choose default device in force-roam
Date: Thu, 23 Sep 2021 15:57:24 -0700
Message-ID: <20210923225728.556306-1-prestwoj@gmail.com>

--===============5451145617297959913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes the usage much more convenient if the system has only
a single device.
---
 test/force-roam | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/test/force-roam b/test/force-roam
index b45ad2e6..a6df854a 100755
--- a/test/force-roam
+++ b/test/force-roam
@@ -3,14 +3,33 @@
 import sys
 import dbus
 =

-if (len(sys.argv) !=3D 3):
-    print("Usage: %s <device> <mac>" % (sys.argv[0]))
+if len(sys.argv) < 2 or len(sys.argv) > 3:
+    print("Usage: %s [device] <mac>" % (sys.argv[0]))
     sys.exit(1)
 =

 bus =3D dbus.SystemBus()
-device =3D dbus.Interface(bus.get_object("net.connman.iwd", sys.argv[1]),
+device =3D None
+
+if len(sys.argv) =3D=3D 2:
+    manager =3D dbus.Interface(bus.get_object("net.connman.iwd", "/"),
+                                "org.freedesktop.DBus.ObjectManager")
+    objects =3D manager.GetManagedObjects()
+    for path in objects:
+        for interface in objects[path]:
+            if interface =3D=3D "net.connman.iwd.StationDebug":
+                device =3D dbus.Interface(bus.get_object("net.connman.iwd"=
, path),
                                     "net.connman.iwd.StationDebug")
+                break
+
+    if not device:
+        print("StationDebug interface not found")
+        exit()
 =

-mac =3D sys.argv[2].replace(':', '')
+    mac =3D sys.argv[1]
+else:
+    device =3D dbus.Interface(bus.get_object("net.connman.iwd", sys.argv[1=
]),
+                                    "net.connman.iwd.StationDebug")
+    mac =3D sys.argv[2]
 =

+mac =3D mac.replace(':', '')
 device.Roam(dbus.ByteArray.fromhex(mac))
-- =

2.31.1

--===============5451145617297959913==--

