Content-Type: multipart/mixed; boundary="===============3734729204168791898=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/3] auto-t: add AP test with DHCP server
Date: Thu, 22 Oct 2020 12:15:44 -0700
Message-ID: <20201022191544.1848338-3-prestwoj@gmail.com>
In-Reply-To: <20201022191544.1848338-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3734729204168791898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The existing AP tests needed to be modified to start IWD from
python since the DHCP test uses a different main.conf.

Also removed some stale hw.conf options that are no longer used.
---
 autotests/testAP/connection_test.py |  2 +-
 autotests/testAP/dhcp/main.conf     |  5 ++
 autotests/testAP/dhcp_test.py       | 77 +++++++++++++++++++++++++++++
 autotests/testAP/failure_test.py    |  2 +-
 autotests/testAP/hw.conf            |  3 +-
 5 files changed, 85 insertions(+), 4 deletions(-)
 create mode 100644 autotests/testAP/dhcp/main.conf
 create mode 100644 autotests/testAP/dhcp_test.py

v4:
 * Added a new sub-test to testAP rather than a completely new test
 * validate IP configuration after connection

diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connect=
ion_test.py
index c3744c55..754ce952 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -38,7 +38,7 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

     def test_connection_success(self):
-        wd =3D IWD()
+        wd =3D IWD(True)
 =

         dev1, dev2 =3D wd.list_devices(2)
 =

diff --git a/autotests/testAP/dhcp/main.conf b/autotests/testAP/dhcp/main.c=
onf
new file mode 100644
index 00000000..25ebe4ff
--- /dev/null
+++ b/autotests/testAP/dhcp/main.conf
@@ -0,0 +1,5 @@
+[Scan]
+DisableMacAddressRandomization=3Dtrue
+
+[General]
+EnableNetworkConfiguration=3Dtrue
diff --git a/autotests/testAP/dhcp_test.py b/autotests/testAP/dhcp_test.py
new file mode 100644
index 00000000..8d11a6e8
--- /dev/null
+++ b/autotests/testAP/dhcp_test.py
@@ -0,0 +1,77 @@
+#! /usr/bin/python3
+
+import unittest
+import sys, os
+
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from config import ctx
+import testutil
+
+class Test(unittest.TestCase):
+    def test_connection_success(self):
+        wd =3D IWD(True, '/tmp/dhcp')
+
+        dev1, dev2 =3D wd.list_devices(2)
+
+        dev1.start_ap('TestAP2', "Password2")
+
+        try:
+            condition =3D 'not obj.scanning'
+            wd.wait_for_object_condition(dev2, condition)
+            dev2.scan()
+            condition =3D 'obj.scanning'
+            wd.wait_for_object_condition(dev2, condition)
+            condition =3D 'not obj.scanning'
+            wd.wait_for_object_condition(dev2, condition)
+
+            ordered_networks =3D dev2.get_ordered_networks()
+
+            networks =3D { n.name: n for n in ordered_networks }
+            self.assertEqual(networks['TestAP2'].type, NetworkType.psk)
+
+            psk_agent =3D PSKAgent('Password2')
+            wd.register_psk_agent(psk_agent)
+
+            try:
+                dev2.disconnect()
+
+                condition =3D 'not obj.connected'
+                wd.wait_for_object_condition(dev2, condition)
+            except:
+                pass
+
+            networks['TestAP2'].network_object.connect()
+
+            condition =3D 'obj.state =3D=3D DeviceState.connected'
+            wd.wait_for_object_condition(dev2, condition)
+
+            testutil.test_iface_operstate(dev2.name)
+            testutil.test_ifaces_connected(dev1.name, dev2.name, group=3DF=
alse)
+
+            testutil.test_ip_address_match(dev1.name, "192.168.1.1")
+            testutil.test_ip_address_match(dev2.name, "192.168.1.2")
+
+            wd.unregister_psk_agent(psk_agent)
+
+            dev2.disconnect()
+
+            condition =3D 'not obj.connected'
+            wd.wait_for_object_condition(networks['TestAP2'].network_objec=
t,
+                                         condition)
+
+        finally:
+            dev1.stop_ap()
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index 4959802f..fc5cb6a7 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -39,7 +39,7 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

     def test_connection_failure(self):
-        wd =3D IWD()
+        wd =3D IWD(True)
 =

         dev1, dev2 =3D wd.list_devices(2)
 =

diff --git a/autotests/testAP/hw.conf b/autotests/testAP/hw.conf
index 96a2bbb1..6b8b2aeb 100644
--- a/autotests/testAP/hw.conf
+++ b/autotests/testAP/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dmain.conf
+start_iwd=3D0
 =

 [HOSTAPD]
 rad0=3Dpsk-ccmp.conf
-- =

2.26.2

--===============3734729204168791898==--

