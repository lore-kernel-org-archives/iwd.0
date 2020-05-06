Content-Type: multipart/mixed; boundary="===============2237805772496970186=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/2] auto-t: add optional scan argument to
 get_ordered_network(s)
Date: Wed, 06 May 2020 14:32:14 -0700
Message-ID: <20200506213215.17533-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2237805772496970186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a very common block of code inside many autotests
which goes something like:

device.scan()
condition =3D 'obj.scanning'
wd.wait_for_object_condition(device, condition)
condition =3D 'not obj.scanning'
wd.wait_for_object_condition(device, condition)
network =3D device.get_ordered_network('an-ssid')

When you see the same pattern in nearly all the tests this shows
we need a helper. Basic autotests which merely check that a
connection succeeded should not need to write the same code again
and again. This code ends up being copy-pasted which can lead to
bugs.

There is also a code pattern which attempts to get ordered
networks, and if this fails it scans and tries again. This, while
not optimal, does prevent unneeded scanning by first checking if
any networks already exist.

This patch solves both the code reuse issue as well as the recovery
if get_ordered_network(s) fails. A new optional parameter was
added to get_ordered_network(s) which is False by default. If True
get_ordered_network(s) will perform a scan if the initial call
yields no networks. Tests will now be able to simply call
get_ordered_network(s) without performing a scan before hand.
---
 autotests/util/iwd.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 9bbb7278..c8d11f91 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -360,7 +360,7 @@ class Device(IWDDBusAbstract):
 =

         self._wait_for_async_op()
 =

-    def get_ordered_networks(self):
+    def get_ordered_networks(self, scan_if_needed =3D False):
         '''Return the list of networks found in the most recent
            scan, sorted by their user interface importance
            score as calculated by iwd.  If the device is
@@ -377,17 +377,32 @@ class Device(IWDDBusAbstract):
             ordered_network =3D OrderedNetwork(bus_obj)
             ordered_networks.append(ordered_network)
 =

-        if len(ordered_networks) =3D=3D 0:
+        if len(ordered_networks) > 0:
+            return ordered_networks
+        elif not scan_if_needed:
             return None
 =

+        iwd =3D IWD.get_instance()
+
+        self.scan()
+
+        condition =3D 'obj.scanning'
+        iwd.wait_for_object_condition(self, condition)
+        condition =3D 'not obj.scanning'
+        iwd.wait_for_object_condition(self, condition)
+
+        for bus_obj in self._station.GetOrderedNetworks():
+            ordered_network =3D OrderedNetwork(bus_obj)
+            ordered_networks.append(ordered_network)
+
         return ordered_networks
 =

-    def get_ordered_network(self, network):
+    def get_ordered_network(self, network, scan_if_needed =3D False):
         '''Returns a single network from ordered network call, or None if =
the
            network wasn't found. If the network is not found an exception =
is
            raised, this removes the need to extra asserts in autotests.
         '''
-        ordered_networks =3D self.get_ordered_networks()
+        ordered_networks =3D self.get_ordered_networks(scan_if_needed)
 =

         if not ordered_networks:
             raise Exception('Network %s not found' % network)
-- =

2.21.1

--===============2237805772496970186==--

