Content-Type: multipart/mixed; boundary="===============6756815779266936556=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/6] wfd-source: Fix some races on iwd name owner change
Date: Tue, 04 Aug 2020 16:52:58 +0200
Message-ID: <20200804145303.151878-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6756815779266936556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Subscribe to InterfacesAdded/Removed/PropertiesChanged signals before
using GetManagedObjects.  For some reason when iwd starts after the
client, we consistently get the managed objects list from before Adapter
interfaces are added but we miss the subsequent InterfacesAdded
signals, probably has to do with the GetManagedObjects and the AddMatch
calls all being synchronous.

Secondly call self.populate_devices() on init as it won't be called if
IWD is not on the bus.
---
 test/wfd-source | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/test/wfd-source b/test/wfd-source
index e74d0adf..a83cd0cb 100755
--- a/test/wfd-source
+++ b/test/wfd-source
@@ -826,6 +826,7 @@ class WFDSource(Gtk.Window):
         self.rtsp_port =3D 7236
         self.devices =3D None
         self.objects =3D {}
+        self.populate_devices()
         self.dbus =3D dbus.SystemBus()
         self.dbus.watch_name_owner('net.connman.iwd', self.on_name_owner_c=
hange)
         self.on_name_owner_change('dummy' if self.dbus.name_has_owner('net=
.connman.iwd') else '')
@@ -857,17 +858,6 @@ class WFDSource(Gtk.Window):
             return True
 =

         manager =3D dbus.Interface(self.dbus.get_object('net.connman.iwd',=
 '/'), 'org.freedesktop.DBus.ObjectManager')
-        self.devices =3D {}
-        self.objects =3D manager.GetManagedObjects()
-
-        for path in self.objects:
-            if DEVICE_IF in self.objects[path]:
-                self.add_dev(path)
-        for path in self.objects:
-            if PEER_IF in self.objects[path]:
-                self.add_peer(path)
-
-        self.populate_devices()
 =

         self.dbus.add_signal_receiver(self.on_properties_changed,
             bus_name=3D"net.connman.iwd",
@@ -883,6 +873,18 @@ class WFDSource(Gtk.Window):
             dbus_interface=3D"org.freedesktop.DBus.ObjectManager",
             signal_name=3D"InterfacesRemoved")
 =

+        self.objects =3D manager.GetManagedObjects()
+        self.devices =3D {}
+
+        for path in self.objects:
+            if DEVICE_IF in self.objects[path]:
+                self.add_dev(path)
+        for path in self.objects:
+            if PEER_IF in self.objects[path]:
+                self.add_peer(path)
+
+        self.populate_devices()
+
         svc_mgr =3D dbus.Interface(self.dbus.get_object('net.connman.iwd',=
 '/net/connman/iwd'), SVC_MGR_IF)
         svc_mgr.RegisterDisplayService({
             'Source': True,
-- =

2.25.1

--===============6756815779266936556==--

