Content-Type: multipart/mixed; boundary="===============1607965200680709230=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/6] auto-t: iwd.py: add DPP utilities
Date: Tue, 04 Jan 2022 10:18:55 -0800
Message-ID: <20220104181857.103331-4-prestwoj@gmail.com>
In-Reply-To: 20220104181857.103331-1-prestwoj@gmail.com

--===============1607965200680709230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 34af1127..4e69c7e8 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -40,6 +40,7 @@ IWD_P2P_PEER_INTERFACE =3D        'net.connman.iwd.p2p.Pe=
er'
 IWD_P2P_SERVICE_MANAGER_INTERFACE =3D 'net.connman.iwd.p2p.ServiceManager'
 IWD_P2P_WFD_INTERFACE =3D         'net.connman.iwd.p2p.Display'
 IWD_STATION_DEBUG_INTERFACE =3D   'net.connman.iwd.StationDebug'
+IWD_DPP_INTERFACE =3D             'net.connman.iwd.DeviceProvisioning'
 =

 IWD_AGENT_MANAGER_PATH =3D        '/net/connman/iwd'
 IWD_TOP_LEVEL_PATH =3D            '/'
@@ -270,6 +271,20 @@ class StationDebug(IWDDBusAbstract):
             self._last_event_data =3D None
             self._last_event =3D None
 =

+class DeviceProvisioning(IWDDBusAbstract):
+    '''
+        Class represents net.connman.iwd.DeviceProvisioning
+    '''
+    _iface_name =3D IWD_DPP_INTERFACE
+
+    def start_enrollee(self):
+        return self._iface.StartEnrollee()
+
+    def start_configurator(self):
+        return self._iface.StartConfigurator()
+
+    def stop(self):
+        self._iface.Stop()
 =

 class Device(IWDDBusAbstract):
     '''
@@ -283,6 +298,7 @@ class Device(IWDDBusAbstract):
         self._station_if =3D None
         self._station_props =3D None
         self._station_debug_obj =3D None
+        self._dpp_obj =3D None
 =

         IWDDBusAbstract.__init__(self, *args, **kwargs)
 =

@@ -303,6 +319,17 @@ class Device(IWDDBusAbstract):
                                             IWD_STATION_INTERFACE)
         return self._station_if
 =

+    @property
+    def _device_provisioning(self):
+        if self._properties['Mode'] !=3D 'station':
+            self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
+
+        if self._dpp_obj is None:
+            self._dpp_obj =3D DeviceProvisioning(object_path=3Dself._objec=
t_path,
+                                                namespace=3Dself._namespac=
e)
+
+        return self._dpp_obj
+
     @property
     def _station_debug(self):
         if self._properties['Mode'] !=3D 'station':
@@ -637,6 +664,15 @@ class Device(IWDDBusAbstract):
     def wait_for_event(self, event, timeout=3D10):
         self._station_debug.wait_for_event(event, timeout)
 =

+    def dpp_start_enrollee(self):
+        return self._device_provisioning.start_enrollee()
+
+    def dpp_start_configurator(self):
+        return self._device_provisioning.start_configurator()
+
+    def dpp_stop(self):
+        return self._device_provisioning.stop()
+
     def __str__(self, prefix =3D ''):
         return prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-- =

2.31.1

--===============1607965200680709230==--

