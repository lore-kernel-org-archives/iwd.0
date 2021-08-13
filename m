Content-Type: multipart/mixed; boundary="===============1302689563303271484=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] auto-t: iwd.py: clean up StationDebug
Date: Fri, 13 Aug 2021 15:45:52 -0700
Message-ID: <20210813224554.816379-2-prestwoj@gmail.com>
In-Reply-To: <20210813224554.816379-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1302689563303271484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Initialize this once and reference that for each method/property
---
 autotests/util/iwd.py | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 737b2beb..54157b00 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -248,6 +248,12 @@ class StationDebug(IWDDBusAbstract):
     def autoconnect(self):
         return self._properties['AutoConnect']
 =

+    def connect_bssid(self, address):
+        self._iface.ConnectBssid(dbus.ByteArray.fromhex(address.replace(':=
', '')))
+
+    def roam(self, address):
+        self._iface.Roam(dbus.ByteArray.fromhex(address.replace(':', '')))
+
     def scan(self, frequencies):
         frequencies =3D dbus.Array([dbus.UInt16(f) for f in frequencies])
         self._iface.Scan(frequencies)
@@ -278,9 +284,11 @@ class Device(IWDDBusAbstract):
         self._wps_manager_if =3D None
         self._station_if =3D None
         self._station_props =3D None
-        self._station_debug =3D None
+
         IWDDBusAbstract.__init__(self, *args, **kwargs)
 =

+        self._station_debug =3D StationDebug(*args, **kwargs)
+
     @property
     def _wps_manager(self):
         if self._wps_manager_if is None:
@@ -397,16 +405,10 @@ class Device(IWDDBusAbstract):
 =

     @property
     def autoconnect(self):
-        if not self._station_debug:
-            self._station_debug =3D StationDebug(self._object_path)
-
         return self._station_debug.autoconnect
 =

     @autoconnect.setter
     def autoconnect(self, value):
-        if not self._station_debug:
-            self._station_debug =3D StationDebug(self._object_path)
-
         self._station_debug._prop_proxy.Set(IWD_STATION_DEBUG_INTERFACE,
                                             'AutoConnect', value)
 =

@@ -602,27 +604,15 @@ class Device(IWDDBusAbstract):
         self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
 =

     def connect_bssid(self, address):
-        self._station_debug_if =3D dbus.Interface(self._bus.get_object(IWD=
_SERVICE,
-                                                self.device_path),
-                                                IWD_STATION_DEBUG_INTERFAC=
E)
-        self._station_debug_if.ConnectBssid(dbus.ByteArray.fromhex(address=
.replace(':', '')))
+        self._station_debug.connect_bssid(address)
 =

     def roam(self, address):
-        self._station_debug_if =3D dbus.Interface(self._bus.get_object(IWD=
_SERVICE,
-                                                self.device_path),
-                                                IWD_STATION_DEBUG_INTERFAC=
E)
-        self._station_debug_if.Roam(dbus.ByteArray.fromhex(address.replace=
(':', '')))
+        self._station_debug.roam(address)
 =

     def debug_scan(self, frequencies):
-        if not self._station_debug:
-            self._station_debug =3D StationDebug(self._object_path)
-
         self._station_debug.scan(frequencies)
 =

     def wait_for_event(self, event, timeout=3D10):
-        if not self._station_debug:
-            self._station_debug =3D StationDebug(self._object_path)
-
         self._station_debug.wait_for_event(event, timeout)
 =

     def __str__(self, prefix =3D ''):
-- =

2.31.1

--===============1302689563303271484==--

