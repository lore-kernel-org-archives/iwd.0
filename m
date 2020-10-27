Content-Type: multipart/mixed; boundary="===============5418337919393888352=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 3/3] auto-t: add AP test with DHCP server
Date: Tue, 27 Oct 2020 12:57:49 -0700
Message-ID: <20201027195749.2266686-3-prestwoj@gmail.com>
In-Reply-To: <20201027195749.2266686-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5418337919393888352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The existing AP tests needed to be modified to start IWD from
python since the DHCP test uses a different main.conf.

Also removed some stale hw.conf options that are no longer used.
---
 autotests/testAP/connection_test.py |  2 +-
 autotests/testAP/dhcp/main.conf     |  6 ++
 autotests/testAP/dhcp_test.py       | 93 +++++++++++++++++++++++++++++
 autotests/testAP/failure_test.py    |  2 +-
 autotests/testAP/hw.conf            |  5 +-
 5 files changed, 103 insertions(+), 5 deletions(-)
 create mode 100644 autotests/testAP/dhcp/main.conf
 create mode 100644 autotests/testAP/dhcp_test.py

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
index 00000000..667de23c
--- /dev/null
+++ b/autotests/testAP/dhcp/main.conf
@@ -0,0 +1,6 @@
+[Scan]
+DisableMacAddressRandomization=3Dtrue
+
+[General]
+EnableNetworkConfiguration=3Dtrue
+APRanges=3D192.168.80.0/23
diff --git a/autotests/testAP/dhcp_test.py b/autotests/testAP/dhcp_test.py
new file mode 100644
index 00000000..bf52fb28
--- /dev/null
+++ b/autotests/testAP/dhcp_test.py
@@ -0,0 +1,93 @@
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
+        # dev1, dev3, and dev4 are all AP's
+        # The configured IP range only supports 2 subnets, so dev4 should =
fail
+        # to start AP.
+        dev1, dev2, dev3, dev4 =3D wd.list_devices(4)
+
+        dev1.start_ap('TestAP2', "Password2")
+        dev3.start_ap('TestAP3', 'Password3')
+
+        with self.assertRaises(iwd.AlreadyExistsEx):
+            dev4.start_ap('TestAP4', 'Password4')
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
+            testutil.test_ip_address_match(dev1.name, "192.168.80.1")
+            testutil.test_ip_address_match(dev2.name, "192.168.80.2")
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
+            # This should release the IP */
+            dev1.stop_ap()
+
+            # This should now succeed and the IP should match the old IP d=
ev1
+            # got initially.
+            dev4.start_ap('TestAP4', 'Password4')
+
+            testutil.test_ip_address_match(dev4.name, "192.168.80.1")
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
index 96a2bbb1..bac128b2 100644
--- a/autotests/testAP/hw.conf
+++ b/autotests/testAP/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
-num_radios=3D3
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dmain.conf
+num_radios=3D5
+start_iwd=3D0
 =

 [HOSTAPD]
 rad0=3Dpsk-ccmp.conf
-- =

2.26.2

--===============5418337919393888352==--

