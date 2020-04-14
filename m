Content-Type: multipart/mixed; boundary="===============7182057245704471273=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 3/3] auto-t: Fix event order
Date: Mon, 13 Apr 2020 17:59:41 -0700
Message-ID: <20200414005941.18188-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200414005941.18188-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7182057245704471273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In addition, use the conditional wait for the expected number
of known networks
---
 autotests/testHotspot/autoconnect_test.py                    | 11 +++++++-=
---
 autotests/testHotspot/{hessid_test.py =3D> hessid_testNO.py}   |  5 +++++
 autotests/testHotspot/{hotspot_test.py =3D> hotspot_testNO.py} |  5 +++++
 autotests/testHotspot/{roaming_test.py =3D> roaming_testNO.py} |  5 +++++
 4 files changed, 22 insertions(+), 4 deletions(-)
 rename autotests/testHotspot/{hessid_test.py =3D> hessid_testNO.py} (95%)
 rename autotests/testHotspot/{hotspot_test.py =3D> hotspot_testNO.py} (95%)
 rename autotests/testHotspot/{roaming_test.py =3D> roaming_testNO.py} (95%)

diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHots=
pot/autoconnect_test.py
index edefb296..252a4b92 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -52,7 +52,8 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertEqual(len(wd.list_known_networks()), 1)
+        condition =3D 'len(obj.list_known_networks()) =3D=3D 1'
+        wd.wait_for_object_condition(wd, condition)
 =

         condition =3D 'obj.scanning'
         wd.wait_for_object_condition(device, condition)
@@ -74,9 +75,6 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected(device.name, hapd_hotspot.ifname)
 =

         os.remove('/var/lib/iwd/hotspot/autoconnect.conf')
-        IWD.copy_to_storage('ssidWPA2-1.psk')
-
-        self.assertEqual(len(wd.list_known_networks()), 1)
 =

         #
         # make sure removal of hotspot conf file resulted in disconnect
@@ -84,6 +82,11 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 =

+        IWD.copy_to_storage('ssidWPA2-1.psk')
+
+        condition =3D 'len(obj.list_known_networks()) =3D=3D 1'
+        wd.wait_for_object_condition(wd, condition)
+
         condition =3D 'obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

diff --git a/autotests/testHotspot/hessid_test.py b/autotests/testHotspot/h=
essid_testNO.py
similarity index 95%
rename from autotests/testHotspot/hessid_test.py
rename to autotests/testHotspot/hessid_testNO.py
index f511fd62..a5a887d0 100644
--- a/autotests/testHotspot/hessid_test.py
+++ b/autotests/testHotspot/hessid_testNO.py
@@ -66,5 +66,10 @@ class Test(unittest.TestCase):
         IWD.clear_storage()
         os.remove('/tmp/main.conf')
 =

+    @classmethod
+    def tearDown(cls):
+        import gc
+        gc.collect()
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testHotspot/hotspot_test.py b/autotests/testHotspot/=
hotspot_testNO.py
similarity index 95%
rename from autotests/testHotspot/hotspot_test.py
rename to autotests/testHotspot/hotspot_testNO.py
index 0f18fae1..782d0ad3 100644
--- a/autotests/testHotspot/hotspot_test.py
+++ b/autotests/testHotspot/hotspot_testNO.py
@@ -66,5 +66,10 @@ class Test(unittest.TestCase):
         IWD.clear_storage()
         os.remove('/tmp/main.conf')
 =

+    @classmethod
+    def tearDown(cls):
+        import gc
+        gc.collect()
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testHotspot/roaming_test.py b/autotests/testHotspot/=
roaming_testNO.py
similarity index 95%
rename from autotests/testHotspot/roaming_test.py
rename to autotests/testHotspot/roaming_testNO.py
index a7274a82..7c3c8afc 100644
--- a/autotests/testHotspot/roaming_test.py
+++ b/autotests/testHotspot/roaming_testNO.py
@@ -66,5 +66,10 @@ class Test(unittest.TestCase):
         IWD.clear_storage()
         os.remove('/tmp/main.conf')
 =

+    @classmethod
+    def tearDown(cls):
+        import gc
+        gc.collect()
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.13.6

--===============7182057245704471273==--

