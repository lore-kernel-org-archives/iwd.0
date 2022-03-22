Content-Type: multipart/mixed; boundary="===============6867977275093638885=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/8] auto-t: iwd.py: fix full_scan argument
Date: Tue, 22 Mar 2022 15:51:07 -0700
Message-ID: <20220322225113.1023688-2-prestwoj@gmail.com>
In-Reply-To: 20220322225113.1023688-1-prestwoj@gmail.com

--===============6867977275093638885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was not being properly honored when existing networks were
already populated. This poses an issue for any test which uses
full_scan after setting radio values such as signal strength.
---
 autotests/util/iwd.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index d6620da5..253fe25e 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -492,17 +492,18 @@ class Device(IWDDBusAbstract):
            main sorting factor.
         '''
         ordered_networks =3D []
-        for bus_obj in self._station.GetOrderedNetworks():
-            ordered_network =3D OrderedNetwork(bus_obj, self._bus, self._n=
amespace)
-            ordered_networks.append(ordered_network)
-
-        names =3D [x.name for x in ordered_networks]
-
-        # all() will always return true if 'list' is empty
-        if all(x in names for x in list) and len(names) > 0:
-            return ordered_networks
-        elif not scan_if_needed:
-            return None
+        if not full_scan:
+            for bus_obj in self._station.GetOrderedNetworks():
+                ordered_network =3D OrderedNetwork(bus_obj, self._bus, sel=
f._namespace)
+                ordered_networks.append(ordered_network)
+
+            names =3D [x.name for x in ordered_networks]
+
+            # all() will always return true if 'list' is empty
+            if all(x in names for x in list) and len(names) > 0:
+                return ordered_networks
+            elif not scan_if_needed:
+                return None
 =

         condition =3D 'not obj.scanning'
         IWD._wait_for_object_condition(self, condition)
-- =

2.34.1

--===============6867977275093638885==--

