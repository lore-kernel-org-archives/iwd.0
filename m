Content-Type: multipart/mixed; boundary="===============1199089072989037773=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/9] auto-t: pass namespace on to other IWD classes
Date: Thu, 10 Dec 2020 09:45:21 -0800
Message-ID: <20201210174525.874021-5-prestwoj@gmail.com>
In-Reply-To: <20201210174525.874021-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1199089072989037773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Certain classes were still using the default namespace. This
didn't matter yet since testAP was the only test using namespaces,
and the AP interface was the only one being used.

For an IWD station on a separate namespace all objects need to
be accessable, so the namespace is passed along to those as needed.
---
 autotests/util/iwd.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 844bb0db..9e653575 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -124,6 +124,7 @@ class IWDDBusAbstract(AsyncOpAbstract):
 =

     def __init__(self, object_path =3D None, properties =3D None, service=
=3DIWD_SERVICE, namespace=3Dctx):
         self._bus =3D namespace.get_bus()
+        self._namespace =3D namespace
 =

         self._object_path =3D object_path
         proxy =3D self._bus.get_object(service, self._object_path)
@@ -391,7 +392,7 @@ class Device(IWDDBusAbstract):
         '''
         ordered_networks =3D []
         for bus_obj in self._station.GetOrderedNetworks():
-            ordered_network =3D OrderedNetwork(bus_obj, self._bus)
+            ordered_network =3D OrderedNetwork(bus_obj, self._bus, self._n=
amespace)
             ordered_networks.append(ordered_network)
 =

         if len(ordered_networks) > 0:
@@ -407,7 +408,7 @@ class Device(IWDDBusAbstract):
         IWD._wait_for_object_condition(self, condition)
 =

         for bus_obj in self._station.GetOrderedNetworks():
-            ordered_network =3D OrderedNetwork(bus_obj, self._bus)
+            ordered_network =3D OrderedNetwork(bus_obj, self._bus, self._n=
amespace)
             ordered_networks.append(ordered_network)
 =

         if len(ordered_networks) > 0:
@@ -643,9 +644,9 @@ class KnownNetwork(IWDDBusAbstract):
 class OrderedNetwork(object):
     '''Represents a network found in the scan'''
 =

-    def __init__(self, o_n_tuple, bus):
+    def __init__(self, o_n_tuple, bus, namespace=3Dctx):
         self._bus =3D bus
-        self._network_object =3D Network(o_n_tuple[0])
+        self._network_object =3D Network(o_n_tuple[0], namespace=3Dnamespa=
ce)
         self._network_proxy =3D dbus.Interface(self._bus.get_object(IWD_SE=
RVICE,
                                         o_n_tuple[0]),
                                         DBUS_PROPERTIES)
-- =

2.26.2

--===============1199089072989037773==--

