Content-Type: multipart/mixed; boundary="===============2233587237991747800=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: add profile based DHCP test
Date: Wed, 04 Nov 2020 08:48:10 -0800
Message-ID: <20201104164810.2777541-3-prestwoj@gmail.com>
In-Reply-To: <20201104164810.2777541-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2233587237991747800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testAP/dhcp/APConfig.ap    | 10 ++++
 autotests/testAP/dhcp_config_test.py | 79 ++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 autotests/testAP/dhcp/APConfig.ap
 create mode 100644 autotests/testAP/dhcp_config_test.py

diff --git a/autotests/testAP/dhcp/APConfig.ap b/autotests/testAP/dhcp/APCo=
nfig.ap
new file mode 100644
index 00000000..4e99dbde
--- /dev/null
+++ b/autotests/testAP/dhcp/APConfig.ap
@@ -0,0 +1,10 @@
+[Security]
+Passphrase=3Dpassword123
+
+[IPv4]
+Address=3D192.168.1.1
+Gateway=3D192.168.1.1
+Netmask=3D255.255.255.0
+DNSList=3D192.168.1.1,192.168.1.2
+LeaseTime=3D10
+IPRange=3D192.168.1.3,192.168.1.100
diff --git a/autotests/testAP/dhcp_config_test.py b/autotests/testAP/dhcp_c=
onfig_test.py
new file mode 100644
index 00000000..a278c3b7
--- /dev/null
+++ b/autotests/testAP/dhcp_config_test.py
@@ -0,0 +1,79 @@
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
+        # Using main.conf containing APRanges. The APConfig SSID should ov=
erride
+        # this range.
+        wd =3D IWD(True, '/tmp/dhcp')
+
+        dev1, dev2 =3D wd.list_devices(2)
+
+        dev1.start_ap('APConfig')
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
+            self.assertEqual(networks['APConfig'].type, NetworkType.psk)
+
+            psk_agent =3D PSKAgent('password123')
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
+            networks['APConfig'].network_object.connect()
+
+            condition =3D 'obj.state =3D=3D DeviceState.connected'
+            wd.wait_for_object_condition(dev2, condition)
+
+            testutil.test_iface_operstate(dev2.name)
+            testutil.test_ifaces_connected(dev1.name, dev2.name, group=3DF=
alse)
+
+            testutil.test_ip_address_match(dev1.name, "192.168.1.1")
+            testutil.test_ip_address_match(dev2.name, "192.168.1.3")
+
+            wd.unregister_psk_agent(psk_agent)
+
+            dev2.disconnect()
+
+            condition =3D 'not obj.connected'
+            wd.wait_for_object_condition(networks['APConfig'].network_obje=
ct,
+                                         condition)
+
+        finally:
+            dev1.stop_ap()
+
+    @classmethod
+    def setUpClass(cls):
+        IWD.copy_to_ap('dhcp/APConfig.ap')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
-- =

2.26.2

--===============2233587237991747800==--

