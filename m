Content-Type: multipart/mixed; boundary="===============4530422305718865844=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/2] auto-t: add AP test with DHCP server
Date: Thu, 22 Oct 2020 09:38:57 -0700
Message-ID: <20201022163857.1836746-2-prestwoj@gmail.com>
In-Reply-To: <20201022163857.1836746-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4530422305718865844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testAP-DHCP/connection_test.py | 73 ++++++++++++++++++++++++
 autotests/testAP-DHCP/failure_test.py    | 54 ++++++++++++++++++
 autotests/testAP-DHCP/hw.conf            |  3 +
 autotests/testAP-DHCP/main.conf          |  5 ++
 4 files changed, 135 insertions(+)
 create mode 100644 autotests/testAP-DHCP/connection_test.py
 create mode 100644 autotests/testAP-DHCP/failure_test.py
 create mode 100644 autotests/testAP-DHCP/hw.conf
 create mode 100644 autotests/testAP-DHCP/main.conf

v3:
 * Removed setting the IP since this is now done automatically

diff --git a/autotests/testAP-DHCP/connection_test.py b/autotests/testAP-DH=
CP/connection_test.py
new file mode 100644
index 00000000..dd4466cd
--- /dev/null
+++ b/autotests/testAP-DHCP/connection_test.py
@@ -0,0 +1,73 @@
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
+        wd =3D IWD(True)
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
+            wd.unregister_psk_agent(psk_agent)
+
+            dev2.disconnect()
+
+            condition =3D 'not obj.connected'
+            wd.wait_for_object_condition(networks['TestAP2'].network_objec=
t,
+                                         condition)
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
diff --git a/autotests/testAP-DHCP/failure_test.py b/autotests/testAP-DHCP/=
failure_test.py
new file mode 100644
index 00000000..0c2f4e41
--- /dev/null
+++ b/autotests/testAP-DHCP/failure_test.py
@@ -0,0 +1,54 @@
+#! /usr/bin/python3
+
+import unittest
+import sys, os
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from config import ctx
+import testutil
+
+class Test(unittest.TestCase):
+    def test_connection_failure(self):
+        wd =3D IWD(True)
+
+        dev1, dev2 =3D wd.list_devices(2)
+
+        dev1.start_ap('TestAP2', 'Password2')
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
+            networks =3D { n.name: n for n in ordered_networks }
+            self.assertEqual(networks['TestAP2'].type, NetworkType.psk)
+
+            psk_agent =3D PSKAgent('InvalidPassword')
+            wd.register_psk_agent(psk_agent)
+
+            with self.assertRaises(iwd.FailedEx):
+                networks['TestAP2'].network_object.connect()
+
+            wd.unregister_psk_agent(psk_agent)
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
diff --git a/autotests/testAP-DHCP/hw.conf b/autotests/testAP-DHCP/hw.conf
new file mode 100644
index 00000000..c6553537
--- /dev/null
+++ b/autotests/testAP-DHCP/hw.conf
@@ -0,0 +1,3 @@
+[SETUP]
+num_radios=3D2
+start_iwd=3D0
diff --git a/autotests/testAP-DHCP/main.conf b/autotests/testAP-DHCP/main.c=
onf
new file mode 100644
index 00000000..25ebe4ff
--- /dev/null
+++ b/autotests/testAP-DHCP/main.conf
@@ -0,0 +1,5 @@
+[Scan]
+DisableMacAddressRandomization=3Dtrue
+
+[General]
+EnableNetworkConfiguration=3Dtrue
-- =

2.26.2

--===============4530422305718865844==--

