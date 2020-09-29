Content-Type: multipart/mixed; boundary="===============7309593585316718449=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/8] autotests: Basic P2P python API
Date: Tue, 29 Sep 2020 18:37:14 +0200
Message-ID: <20200929163717.754459-11-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7309593585316718449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a basic wrapper for the P2P-related DBus interfaces similar to the
existing classes in iwd.py.  WFD is not included.
---
 autotests/util/iwd.py | 121 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index ef843a95..7e3676d9 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -35,6 +35,10 @@ IWD_SIGNAL_AGENT_INTERFACE =3D    'net.connman.iwd.Signa=
lLevelAgent'
 IWD_AP_INTERFACE =3D              'net.connman.iwd.AccessPoint'
 IWD_ADHOC_INTERFACE =3D           'net.connman.iwd.AdHoc'
 IWD_STATION_INTERFACE =3D         'net.connman.iwd.Station'
+IWD_P2P_INTERFACE =3D             'net.connman.iwd.p2p.Device'
+IWD_P2P_PEER_INTERFACE =3D        'net.connman.iwd.p2p.Peer'
+IWD_P2P_SERVICE_MANAGER_INTERFACE =3D 'net.connman.iwd.p2p.ServiceManager'
+IWD_P2P_WFD_INTERFACE =3D         'net.connman.iwd.p2p.Display'
 =

 IWD_AGENT_MANAGER_PATH =3D        '/net/connman/iwd'
 IWD_TOP_LEVEL_PATH =3D            '/'
@@ -767,9 +771,107 @@ class PSKAgent(dbus.service.Object):
         return passwd
 =

 =

+class P2PDevice(IWDDBusAbstract):
+    _iface_name =3D IWD_P2P_INTERFACE
+
+    def __init__(self, *args, **kwargs):
+        self._discovery_request =3D False
+        self._peer_dict =3D {}
+        IWDDBusAbstract.__init__(self, *args, **kwargs)
+
+    @property
+    def name(self):
+        return str(self._properties['Name'])
+
+    @name.setter
+    def name(self, name):
+        self._prop_proxy.Set(self._iface_name, 'Name', name)
+
+    @property
+    def enabled(self):
+        return bool(self._properties['Enabled'])
+
+    @enabled.setter
+    def enabled(self, enabled):
+        self._prop_proxy.Set(self._iface_name, 'Enabled', enabled)
+
+    @property
+    def discovery_request(self):
+        return self._discovery_request
+
+    @discovery_request.setter
+    def discovery_request(self, req):
+        if self._discovery_request =3D=3D bool(req):
+            return
+
+        if bool(req):
+            self._iface.RequestDiscovery()
+        else:
+            self._iface.ReleaseDiscovery()
+
+        self._discovery_request =3D bool(req)
+
+    def get_peers(self):
+        old_dict =3D self._peer_dict
+        self._peer_dict =3D {}
+
+        for path, rssi in self._iface.GetPeers():
+            self._peer_dict[path] =3D old_dict[path] if path in old_dict e=
lse P2PPeer(path)
+            self._peer_dict[path].rssi =3D rssi
+
+        return self._peer_dict
+
+
+class P2PPeer(IWDDBusAbstract):
+    _iface_name =3D IWD_P2P_PEER_INTERFACE
+
+    @property
+    def name(self):
+        return str(self._properties['Name'])
+
+    @property
+    def category(self):
+        return str(self._properties['DeviceCategory'])
+
+    @property
+    def subcategory(self):
+        return str(self._properties['DeviceSubcategory'])
+
+    @property
+    def connected(self):
+        return bool(self._properties['Connected'])
+
+    @property
+    def connected_interface(self):
+        return str(self._properties['ConnectedInterface'])
+
+    @property
+    def connected_ip(self):
+        return str(self._properties['ConnectedIP'])
+
+    def connect(self, wait=3DTrue, pin=3DNone):
+        if pin is None:
+            self._iface.PushButton(dbus_interface=3DIWD_WSC_INTERFACE,
+                            reply_handler=3Dself._success,
+                            error_handler=3Dself._failure)
+        else:
+            self._iface.StartPin(pin,
+                            dbus_interface=3DIWD_WSC_INTERFACE,
+                            reply_handler=3Dself._success,
+                            error_handler=3Dself._failure)
+
+        if wait:
+            self._wait_for_async_op()
+            return (self.connected_interface, self.connected_ip)
+
+    def disconnect(self):
+        self._iface.Disconnect()
+
+
 class DeviceList(collections.Mapping):
     def __init__(self, iwd):
         self._dict =3D {}
+        self._p2p_dict =3D {}
 =

         iwd._object_manager.connect_to_signal("InterfacesAdded",
                                                self._interfaces_added_hand=
ler)
@@ -782,6 +884,8 @@ class DeviceList(collections.Mapping):
             for interface in objects[path]:
                 if interface =3D=3D IWD_DEVICE_INTERFACE:
                     self._dict[path] =3D Device(path, objects[path][interf=
ace])
+                elif interface =3D=3D IWD_P2P_INTERFACE:
+                    self._p2p_dict[path] =3D P2PDevice(path, objects[path]=
[interface])
 =

     def __getitem__(self, key):
         return self._dict.__getitem__(key)
@@ -798,10 +902,18 @@ class DeviceList(collections.Mapping):
     def _interfaces_added_handler(self, path, interfaces):
         if IWD_DEVICE_INTERFACE in interfaces:
             self._dict[path] =3D Device(path, interfaces[IWD_DEVICE_INTERF=
ACE])
+        elif IWD_P2P_INTERFACE in interfaces:
+            self._p2p_dict[path] =3D P2PDevice(path, interfaces[IWD_P2P_IN=
TERFACE])
 =

     def _interfaces_removed_handler(self, path, interfaces):
         if IWD_DEVICE_INTERFACE in interfaces:
             del self._dict[path]
+        elif IWD_P2P_INTERFACE in interfaces:
+            del self._p2p_dict[path]
+
+    @property
+    def p2p_dict(self):
+        return self._p2p_dict
 =

 =

 class IWD(AsyncOpAbstract):
@@ -943,9 +1055,9 @@ class IWD(AsyncOpAbstract):
     def remove_from_storage(file_name):
         os.system('rm -rf ' + IWD_STORAGE_DIR + '/\'' + file_name + '\'')
 =

-    def list_devices(self, wait_to_appear =3D 0, max_wait =3D 50):
+    def list_devices(self, wait_to_appear =3D 0, max_wait =3D 50, p2p =3D =
False):
         if not wait_to_appear:
-            return list(self._devices.values())
+            return list(self._devices.values() if not p2p else self._devic=
es.p2p_dict.values())
 =

         self._wait_timed_out =3D False
         def wait_timeout_cb():
@@ -963,7 +1075,10 @@ class IWD(AsyncOpAbstract):
             if not self._wait_timed_out:
                 GLib.source_remove(timeout)
 =

-        return list(self._devices.values())
+        return list(self._devices.values() if not p2p else self._devices.p=
2p_dict.values())
+
+    def list_p2p_devices(self, *args, **kwargs):
+        return self.list_devices(*args, **kwargs, p2p=3DTrue)
 =

     def list_known_networks(self):
         '''Returns the list of KnownNetwork objects.'''
-- =

2.25.1

--===============7309593585316718449==--

