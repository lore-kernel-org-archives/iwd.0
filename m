Content-Type: multipart/mixed; boundary="===============5319004063521143472=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/3] auto-t: iwd.py: remove StationDebug out of Device init
Date: Tue, 04 Jan 2022 09:37:34 -0800
Message-ID: <20220104173736.93682-1-prestwoj@gmail.com>

--===============5319004063521143472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since a Device class can represent multiple modes (AP, AdHoc, station)
move StationDebug out of the init and only create this class when it
is used (presumably only when the device is in station mode).

The StationDebug class is now created in a property method consistent
with 'station_if'. If Device is not in station mode it is automatically
switched if the test tries any StationDebug methods.

If the Device mode is changed from 'station' the StationDebug class
instance is destroyed.
---
 autotests/util/iwd.py | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index e95bd96d..7f511187 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -280,17 +280,13 @@ class Device(IWDDBusAbstract):
     '''
     _iface_name =3D IWD_DEVICE_INTERFACE
 =

-    def __init__(self, object_path =3D None, properties =3D None,
-                    service=3DIWD_SERVICE, namespace=3Dctx):
+    def __init__(self, *args, **kwargs):
         self._wps_manager_if =3D None
         self._station_if =3D None
         self._station_props =3D None
+        self._station_debug_obj =3D None
 =

-        IWDDBusAbstract.__init__(self, object_path, properties, service,
-                                    namespace)
-
-        self._station_debug =3D StationDebug(object_path=3Dobject_path,
-                                            namespace=3Dnamespace)
+        IWDDBusAbstract.__init__(self, *args, **kwargs)
 =

     @property
     def _wps_manager(self):
@@ -309,6 +305,17 @@ class Device(IWDDBusAbstract):
                                             IWD_STATION_INTERFACE)
         return self._station_if
 =

+    @property
+    def _station_debug(self):
+        if self._properties['Mode'] !=3D 'station':
+            self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
+
+        if self._station_debug_obj is None:
+            self._station_debug_obj =3D StationDebug(object_path=3Dself._o=
bject_path,
+                                                    namespace=3Dself._name=
space)
+
+        return self._station_debug_obj
+
     def _station_properties(self):
         if self._station_props is not None:
             return self._station_props
@@ -335,6 +342,9 @@ class Device(IWDDBusAbstract):
             for name, value in changed.items():
                 self._station_props[name] =3D value
 =

+                if name =3D=3D 'Mode' and value !=3D 'station':
+                    self._station_debug_obj =3D None
+
     @property
     def device_path(self):
         '''
-- =

2.31.1

--===============5319004063521143472==--

