Content-Type: multipart/mixed; boundary="===============9135671841132038517=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] auto-t: iwd.py: make scan_if_needed True by default
Date: Thu, 12 Aug 2021 13:38:09 -0700
Message-ID: <20210812203812.738060-4-prestwoj@gmail.com>
In-Reply-To: <20210812203812.738060-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9135671841132038517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a common block of code in nearly every test which is incorrect,
most likely a copy-paste from long ago. It goes something like:

wd.wait_for_object_condition(device, 'not obj.scanning')
device.scan()
wd.wait_for_object_condition(device, 'not obj.scanning')

network =3D device.get_ordered_network("ssid")

The problem here is that sometimes the scanning property does not get
updated fast enough before device.scan() returns, meaning get_ordered_netwo=
rk
comes up with nothing. Some tests pass scan_if_needed=3DTrue which 'fixes'
this but ends up re-scanning after the original scan finishes.

To put this to rest scan_if_needed is now defaulted to True, and no
explicit scan should be needed.
---
 autotests/util/iwd.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 5d041e57..f5c224b8 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -410,7 +410,7 @@ class Device(IWDDBusAbstract):
 =

         self._wait_for_async_op()
 =

-    def get_ordered_networks(self, scan_if_needed =3D False):
+    def get_ordered_networks(self, scan_if_needed =3D True):
         '''Return the list of networks found in the most recent
            scan, sorted by their user interface importance
            score as calculated by iwd.  If the device is
@@ -432,7 +432,13 @@ class Device(IWDDBusAbstract):
         elif not scan_if_needed:
             return None
 =

-        self.scan()
+        condition =3D 'not obj.scanning'
+        IWD._wait_for_object_condition(self, condition)
+
+        try:
+            self.scan()
+        except InProgressEx:
+            pass
 =

         condition =3D 'obj.scanning'
         IWD._wait_for_object_condition(self, condition)
@@ -448,7 +454,7 @@ class Device(IWDDBusAbstract):
 =

         return None
 =

-    def get_ordered_network(self, network, scan_if_needed =3D False):
+    def get_ordered_network(self, network, scan_if_needed =3D True):
         '''Returns a single network from ordered network call, or None if =
the
            network wasn't found. If the network is not found an exception =
is
            raised, this removes the need to extra asserts in autotests.
-- =

2.31.1

--===============9135671841132038517==--

