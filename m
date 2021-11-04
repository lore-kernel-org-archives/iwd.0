Content-Type: multipart/mixed; boundary="===============7950313554535992090=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/5] auto-t: add a DGAF Disable hotspot test
Date: Thu, 04 Nov 2021 10:57:58 -0700
Message-ID: <20211104175758.532953-5-prestwoj@gmail.com>
In-Reply-To: 20211104175758.532953-1-prestwoj@gmail.com

--===============7950313554535992090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testHotspot/hotspot_test.py | 31 +++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/autotests/testHotspot/hotspot_test.py b/autotests/testHotspot/=
hotspot_test.py
index 054a1a8f..ed9ee830 100644
--- a/autotests/testHotspot/hotspot_test.py
+++ b/autotests/testHotspot/hotspot_test.py
@@ -14,11 +14,7 @@ import testutil
 =

 class Test(unittest.TestCase):
 =

-    def test_connection_success(self):
-        wd =3D self.wd
-
-        hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
-
+    def validate_connection(self, wd, hapd, dgaf_disable=3DFalse):
         psk_agent =3D PSKAgent('abc', ('domain\\user', 'testpasswd'))
         wd.register_psk_agent(psk_agent)
 =

@@ -38,7 +34,16 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
-        testutil.test_ifaces_connected(device.name, hapd.ifname)
+
+        if not dgaf_disable:
+            testutil.test_ifaces_connected(device.name, hapd.ifname)
+        else:
+            # This is expected to fail with group traffic
+            with self.assertRaises(Exception):
+                testutil.test_ifaces_connected(device.name, hapd.ifname, e=
xpect_fail=3DTrue)
+
+            # Now try again without testing group traffic
+            testutil.test_ifaces_connected(device.name, hapd.ifname, group=
=3DFalse)
 =

         device.disconnect()
 =

@@ -47,6 +52,20 @@ class Test(unittest.TestCase):
 =

         wd.unregister_psk_agent(psk_agent)
 =

+    def test_hotspot(self):
+        hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
+        hapd.set_value('disable_dgaf', '0')
+        hapd.reload()
+
+        self.validate_connection(self.wd, hapd)
+
+    def test_dgaf_disabled(self):
+        hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
+        hapd.set_value('disable_dgaf', '1')
+        hapd.reload()
+
+        self.validate_connection(self.wd, hapd, dgaf_disable=3DTrue)
+
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_hotspot('example.conf')
-- =

2.31.1

--===============7950313554535992090==--

