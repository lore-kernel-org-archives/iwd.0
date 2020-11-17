Content-Type: multipart/mixed; boundary="===============6475426822782535955=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] auto-t: update utilities to use namespaces
Date: Tue, 17 Nov 2020 12:53:02 -0800
Message-ID: <20201117205304.3542997-2-prestwoj@gmail.com>
In-Reply-To: <20201117205304.3542997-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6475426822782535955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/ead.py   |  2 +-
 autotests/util/hwsim.py | 10 ++++-----
 autotests/util/iwd.py   | 49 +++++++++++++++++++++++------------------
 autotests/util/ofono.py |  5 +++--
 4 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/autotests/util/ead.py b/autotests/util/ead.py
index 356b0b9b..3a613bbe 100644
--- a/autotests/util/ead.py
+++ b/autotests/util/ead.py
@@ -75,7 +75,7 @@ class AdapterList(collections.Mapping):
             del self._dict[path]
 =

 class EAD(iwd.AsyncOpAbstract):
-    _bus =3D dbus.SystemBus()
+    _bus =3D ctx.get_bus()
 =

     _object_manager_if =3D None
     _adapters =3D None
diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 4f41952f..415bfc90 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -7,6 +7,7 @@ from abc import ABCMeta, abstractmethod
 from enum import Enum
 =

 import iwd
+from config import ctx
 =

 HWSIM_SERVICE =3D                 'net.connman.hwsim'
 HWSIM_RULE_MANAGER_INTERFACE =3D  'net.connman.hwsim.RuleManager'
@@ -20,9 +21,8 @@ HWSIM_AGENT_MANAGER_PATH =3D      '/'
 class HwsimDBusAbstract(iwd.AsyncOpAbstract):
     __metaclass__ =3D ABCMeta
 =

-    _bus =3D dbus.SystemBus()
-
-    def __init__(self, object_path, properties =3D None):
+    def __init__(self, object_path, properties =3D None, namespace=3Dctx):
+        self._bus =3D namespace.get_bus()
         self._object_path =3D object_path
         proxy =3D self._bus.get_object(HWSIM_SERVICE, self._object_path)
         self._iface =3D dbus.Interface(proxy, self._iface_name)
@@ -256,9 +256,9 @@ class RadioList(collections.Mapping):
         return obj
 =

 class Hwsim(iwd.AsyncOpAbstract):
-    _bus =3D dbus.SystemBus()
+    def __init__(self, namespace=3Dctx):
+        self._bus =3D namespace.get_bus()
 =

-    def __init__(self):
         self._rule_manager_if =3D dbus.Interface(
                 self._bus.get_object(HWSIM_SERVICE, '/'),
                 HWSIM_RULE_MANAGER_INTERFACE)
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index af3ecd05..bb4ecefa 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -122,9 +122,9 @@ class AsyncOpAbstract(object):
 class IWDDBusAbstract(AsyncOpAbstract):
     __metaclass__ =3D ABCMeta
 =

-    _bus =3D dbus.SystemBus()
+    def __init__(self, object_path =3D None, properties =3D None, service=
=3DIWD_SERVICE, namespace=3Dctx):
+        self._bus =3D namespace.get_bus()
 =

-    def __init__(self, object_path =3D None, properties =3D None, service=
=3DIWD_SERVICE):
         self._object_path =3D object_path
         proxy =3D self._bus.get_object(service, self._object_path)
         self._iface =3D dbus.Interface(proxy, self._iface_name)
@@ -190,7 +190,7 @@ class SignalAgent(dbus.service.Object):
     def __init__(self, passphrase =3D None):
         self._path =3D '/test/agent/' + str(int(round(time.time() * 1000)))
 =

-        dbus.service.Object.__init__(self, dbus.SystemBus(), self._path)
+        dbus.service.Object.__init__(self, ctx.get_bus(), self._path)
 =

     @property
     def path(self):
@@ -391,7 +391,7 @@ class Device(IWDDBusAbstract):
         '''
         ordered_networks =3D []
         for bus_obj in self._station.GetOrderedNetworks():
-            ordered_network =3D OrderedNetwork(bus_obj)
+            ordered_network =3D OrderedNetwork(bus_obj, self._bus)
             ordered_networks.append(ordered_network)
 =

         if len(ordered_networks) > 0:
@@ -407,7 +407,7 @@ class Device(IWDDBusAbstract):
         IWD._wait_for_object_condition(self, condition)
 =

         for bus_obj in self._station.GetOrderedNetworks():
-            ordered_network =3D OrderedNetwork(bus_obj)
+            ordered_network =3D OrderedNetwork(bus_obj, self._bus)
             ordered_networks.append(ordered_network)
 =

         if len(ordered_networks) > 0:
@@ -643,9 +643,8 @@ class KnownNetwork(IWDDBusAbstract):
 class OrderedNetwork(object):
     '''Represents a network found in the scan'''
 =

-    _bus =3D dbus.SystemBus()
-
-    def __init__(self, o_n_tuple):
+    def __init__(self, o_n_tuple, bus):
+        self._bus =3D bus
         self._network_object =3D Network(o_n_tuple[0])
         self._network_proxy =3D dbus.Interface(self._bus.get_object(IWD_SE=
RVICE,
                                         o_n_tuple[0]),
@@ -707,7 +706,7 @@ agent_count =3D 0
 =

 class PSKAgent(dbus.service.Object):
 =

-    def __init__(self, passphrases=3D[], users=3D[]):
+    def __init__(self, passphrases=3D[], users=3D[], namespace=3Dctx):
         global agent_count
 =

         if type(passphrases) !=3D list:
@@ -720,7 +719,7 @@ class PSKAgent(dbus.service.Object):
 =

         agent_count +=3D 1
 =

-        dbus.service.Object.__init__(self, dbus.SystemBus(), self._path)
+        dbus.service.Object.__init__(self, namespace.get_bus(), self._path)
 =

     @property
     def path(self):
@@ -882,6 +881,7 @@ class DeviceList(collections.Mapping):
     def __init__(self, iwd):
         self._dict =3D {}
         self._p2p_dict =3D {}
+        self._namespace =3D iwd.namespace
 =

         iwd._object_manager.connect_to_signal("InterfacesAdded",
                                                self._interfaces_added_hand=
ler)
@@ -893,9 +893,11 @@ class DeviceList(collections.Mapping):
         for path in objects:
             for interface in objects[path]:
                 if interface =3D=3D IWD_DEVICE_INTERFACE:
-                    self._dict[path] =3D Device(path, objects[path][interf=
ace])
+                    self._dict[path] =3D Device(path, objects[path][interf=
ace],
+                                                namespace=3Dself._namespac=
e)
                 elif interface =3D=3D IWD_P2P_INTERFACE:
-                    self._p2p_dict[path] =3D P2PDevice(path, objects[path]=
[interface])
+                    self._p2p_dict[path] =3D P2PDevice(path, objects[path]=
[interface],
+                                                namespace=3Dself._namespac=
e)
 =

     def __getitem__(self, key):
         return self._dict.__getitem__(key)
@@ -911,9 +913,11 @@ class DeviceList(collections.Mapping):
 =

     def _interfaces_added_handler(self, path, interfaces):
         if IWD_DEVICE_INTERFACE in interfaces:
-            self._dict[path] =3D Device(path, interfaces[IWD_DEVICE_INTERF=
ACE])
+            self._dict[path] =3D Device(path, interfaces[IWD_DEVICE_INTERF=
ACE],
+                                            namespace=3Dself._namespace)
         elif IWD_P2P_INTERFACE in interfaces:
-            self._p2p_dict[path] =3D P2PDevice(path, interfaces[IWD_P2P_IN=
TERFACE])
+            self._p2p_dict[path] =3D P2PDevice(path, interfaces[IWD_P2P_IN=
TERFACE],
+                                            namespace=3Dself._namespace)
 =

     def _interfaces_removed_handler(self, path, interfaces):
         if IWD_DEVICE_INTERFACE in interfaces:
@@ -932,8 +936,6 @@ class IWD(AsyncOpAbstract):
         some tests do require starting IWD using this constructor (by pass=
ing
         start_iwd_daemon=3DTrue)
     '''
-    _bus =3D dbus.SystemBus()
-
     _object_manager_if =3D None
     _agent_manager_if =3D None
     _iwd_proc =3D None
@@ -941,19 +943,22 @@ class IWD(AsyncOpAbstract):
     _default_instance =3D None
     psk_agent =3D None
 =

-    def __init__(self, start_iwd_daemon =3D False, iwd_config_dir =3D '/tm=
p'):
-        if start_iwd_daemon and ctx.is_process_running('iwd'):
-            raise Exception("IWD requested to start but is already running=
")
+    def __init__(self, start_iwd_daemon =3D False, iwd_config_dir =3D '/tm=
p', namespace=3Dctx):
+        self.namespace =3D namespace
+        self._bus =3D namespace.get_bus()
 =

         if start_iwd_daemon:
-            self._iwd_proc =3D ctx.start_iwd(iwd_config_dir)
+            if self.namespace.is_process_running('iwd'):
+                raise Exception("IWD requested to start but is already run=
ning")
+
+            self._iwd_proc =3D self.namespace.start_iwd(iwd_config_dir)
 =

         tries =3D 0
         while not self._bus.name_has_owner(IWD_SERVICE):
             if not ctx.args.gdb:
                 if tries > 200:
                     if start_iwd_daemon:
-                        ctx.stop_process(self._iwd_proc)
+                        self.namespace.stop_process(self._iwd_proc)
                         self._iwd_proc =3D None
                     raise TimeoutError('IWD has failed to start')
                 tries +=3D 1
@@ -978,7 +983,7 @@ class IWD(AsyncOpAbstract):
         self._devices =3D None
 =

         if self._iwd_proc is not None:
-            ctx.stop_process(self._iwd_proc)
+            self.namespace.stop_process(self._iwd_proc)
             self._iwd_proc =3D None
 =

     @property
diff --git a/autotests/util/ofono.py b/autotests/util/ofono.py
index f1ed14ee..584a656a 100644
--- a/autotests/util/ofono.py
+++ b/autotests/util/ofono.py
@@ -1,12 +1,13 @@
 import dbus
 import time
 from gi.repository import GLib
+from config import ctx
 =

 SIM_AUTH_IFACE =3D 'org.ofono.SimAuthentication'
 =

 class Ofono(dbus.service.Object):
-    def __init__(self):
-        self._bus =3D dbus.SystemBus()
+    def __init__(self, namespace=3Dctx):
+        self._bus =3D namespace.get_bus()
 =

         tries =3D 0
 =

-- =

2.26.2

--===============6475426822782535955==--

