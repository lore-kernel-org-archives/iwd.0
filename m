Content-Type: multipart/mixed; boundary="===============5013004919256243163=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/13] auto-t: add AP test with DHCP server
Date: Tue, 20 Oct 2020 11:02:56 -0700
Message-ID: <20201020180256.1630120-13-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5013004919256243163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testAP-DHCP/TestAP2.ap         | 31 ++++++++++
 autotests/testAP-DHCP/connection_test.py | 76 ++++++++++++++++++++++++
 autotests/testAP-DHCP/failure_test.py    | 53 +++++++++++++++++
 autotests/testAP-DHCP/hw.conf            |  3 +
 autotests/testAP-DHCP/main.conf          |  5 ++
 5 files changed, 168 insertions(+)
 create mode 100644 autotests/testAP-DHCP/TestAP2.ap
 create mode 100644 autotests/testAP-DHCP/connection_test.py
 create mode 100644 autotests/testAP-DHCP/failure_test.py
 create mode 100644 autotests/testAP-DHCP/hw.conf
 create mode 100644 autotests/testAP-DHCP/main.conf

diff --git a/autotests/testAP-DHCP/TestAP2.ap b/autotests/testAP-DHCP/TestA=
P2.ap
new file mode 100644
index 00000000..dc1a3579
--- /dev/null
+++ b/autotests/testAP-DHCP/TestAP2.ap
@@ -0,0 +1,31 @@
+[Security]
+Passphrase=3DPassword2
+
+[IPv4]
+#
+# IP address of access point interface. If omitted the current interface IP
+# address will be used. If provided the IP will be changed to this address.
+#
+Address=3D192.168.1.1
+Netmask=3D255.255.255.0
+
+#
+# Gateway address for AP. If omitted [IPv4].Address will be used.
+#
+Gateway=3D192.168.1.1
+
+#
+# Optional list of DNS servers
+#
+DNSList=3D192.168.1.1,192.168.1.254
+
+#
+# Required IP range
+#
+IPRange=3D192.168.1.2,192.168.1.100
+
+#
+# Optional lease time. If omitted an infinite lease will be used.
+#
+LeaseTime=3D10
+
diff --git a/autotests/testAP-DHCP/connection_test.py b/autotests/testAP-DH=
CP/connection_test.py
new file mode 100644
index 00000000..8a79db6d
--- /dev/null
+++ b/autotests/testAP-DHCP/connection_test.py
@@ -0,0 +1,76 @@
+#! /usr/bin/python3
+
+import unittest
+import sys, os
+
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+import testutil
+
+class Test(unittest.TestCase):
+    def test_connection_success(self):
+
+        os.system('ls /tmp/iwd')
+        os.system('ls /tmp/iwd/ap')
+        wd =3D IWD(True)
+
+        dev1, dev2 =3D wd.list_devices(2)
+
+        dev1.start_ap('TestAP2')
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
+        IWD.copy_to_ap('TestAP2.ap')
+        os.system('ls /tmp/iwd/ap')
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
index 00000000..494fedda
--- /dev/null
+++ b/autotests/testAP-DHCP/failure_test.py
@@ -0,0 +1,53 @@
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
+import testutil
+
+class Test(unittest.TestCase):
+    def test_connection_failure(self):
+        wd =3D IWD(True)
+
+        dev1, dev2 =3D wd.list_devices(2)
+
+        dev1.start_ap('TestAP2')
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
+        IWD.copy_to_ap('TestAP2.ap')
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

--===============5013004919256243163==--

