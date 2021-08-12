Content-Type: multipart/mixed; boundary="===============2787749230503857547=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] auto-t: iwd.py: add autoconnect property/StationDebug
Date: Thu, 12 Aug 2021 13:38:08 -0700
Message-ID: <20210812203812.738060-3-prestwoj@gmail.com>
In-Reply-To: <20210812203812.738060-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2787749230503857547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 1785081f..5d041e57 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -226,6 +226,21 @@ class AdHocDevice(IWDDBusAbstract):
     def connected_peers(self):
         return self._properties['ConnectedPeers']
 =

+class StationDebug(IWDDBusAbstract):
+    '''
+        Class represents net.connman.iwd.StationDebug
+    '''
+    _iface_name =3D IWD_STATION_DEBUG_INTERFACE
+
+    def __init__(self, *args, **kwargs):
+        self._debug_props =3D None
+        self._debug_iface =3D None
+
+        IWDDBusAbstract.__init__(self, *args, **kwargs)
+
+    @property
+    def autoconnect(self):
+        return self._properties['AutoConnect']
 =

 class Device(IWDDBusAbstract):
     '''
@@ -238,6 +253,7 @@ class Device(IWDDBusAbstract):
         self._wps_manager_if =3D None
         self._station_if =3D None
         self._station_props =3D None
+        self._station_debug =3D None
         IWDDBusAbstract.__init__(self, *args, **kwargs)
 =

     @property
@@ -354,6 +370,21 @@ class Device(IWDDBusAbstract):
         props =3D self._station_properties()
         return bool(props['Scanning'])
 =

+    @property
+    def autoconnect(self):
+        if not self._station_debug:
+            self._station_debug =3D StationDebug(self._object_path)
+
+        return self._station_debug.autoconnect
+
+    @autoconnect.setter
+    def autoconnect(self, value):
+        if not self._station_debug:
+            self._station_debug =3D StationDebug(self._object_path)
+
+        self._station_debug._prop_proxy.Set(IWD_STATION_DEBUG_INTERFACE,
+                                            'AutoConnect', value)
+
     def scan(self):
         '''Schedule a network scan.
 =

-- =

2.31.1

--===============2787749230503857547==--

