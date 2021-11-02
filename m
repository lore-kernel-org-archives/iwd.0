Content-Type: multipart/mixed; boundary="===============3910134191773127413=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] auto-t: iwd.py: fix re-scanning bug on
 get_ordered_networks
Date: Tue, 02 Nov 2021 12:57:50 -0700
Message-ID: <20211102195752.381604-2-prestwoj@gmail.com>
In-Reply-To: 20211102195752.381604-1-prestwoj@gmail.com

--===============3910134191773127413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Certain scenarios coupled with lost beacons could result in OrderedNetwork
being initialized many times until the dbus library reached its maximum
signal registrations. This could happen where there are two networks,
IWD finds one in a scan but continues to scan for the other and the beacons
are lost. The way get_ordered_networks was written it returns early if any
networks are found. Since get_ordered_network (not plural) uses
get_ordered_networks() in a loop this caused OrderedNetwork's to be created
rapidly until python raises an exception.

To fix this, pass an optional list of networks being looked for to
get_ordered_networks. Only if all the networks in the list are found will
it return early, otherwise it will continue to scan.
---
 autotests/util/iwd.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index d6a7fe06..5e1e2721 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -437,7 +437,7 @@ class Device(IWDDBusAbstract):
 =

         self._wait_for_async_op()
 =

-    def get_ordered_networks(self, scan_if_needed =3D True, full_scan =3D =
False):
+    def get_ordered_networks(self, scan_if_needed =3D True, full_scan =3D =
False, list =3D []):
         '''Return the list of networks found in the most recent
            scan, sorted by their user interface importance
            score as calculated by iwd.  If the device is
@@ -454,7 +454,10 @@ class Device(IWDDBusAbstract):
             ordered_network =3D OrderedNetwork(bus_obj, self._bus, self._n=
amespace)
             ordered_networks.append(ordered_network)
 =

-        if len(ordered_networks) > 0:
+        names =3D [x.name for x in ordered_networks]
+
+        # all() will always return true if 'list' is empty
+        if all(x in names for x in list) and len(names) > 0:
             return ordered_networks
         elif not scan_if_needed:
             return None
@@ -489,8 +492,8 @@ class Device(IWDDBusAbstract):
            network wasn't found. If the network is not found an exception =
is
            raised, this removes the need to extra asserts in autotests.
         '''
-        def wait_for_network(self, network, scan_if_needed):
-            networks =3D self.get_ordered_networks(scan_if_needed)
+        def wait_for_network(self, network, scan_if_needed, full_scan):
+            networks =3D self.get_ordered_networks(scan_if_needed, full_sc=
an, list=3D[network])
 =

             if not networks:
                 # No point in continuing if we aren't going to re-scan
@@ -505,7 +508,7 @@ class Device(IWDDBusAbstract):
 =

             return False
 =

-        return ctx.non_block_wait(wait_for_network, 30, self, network, sca=
n_if_needed,
+        return ctx.non_block_wait(wait_for_network, 30, self, network, sca=
n_if_needed, full_scan,
                                     exception=3DException("Network %s not =
found" % network))
 =

     def wps_push_button(self):
-- =

2.31.1

--===============3910134191773127413==--

