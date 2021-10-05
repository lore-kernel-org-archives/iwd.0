Content-Type: multipart/mixed; boundary="===============1584729293824812671=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 10/11] auto-t: Add test for extended key IDs
Date: Tue, 05 Oct 2021 15:00:50 -0700
Message-ID: <20211005220051.4018694-10-prestwoj@gmail.com>
In-Reply-To: 20211005220051.4018694-1-prestwoj@gmail.com

--===============1584729293824812671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testWPA2-ext-key-id/connection_test.py    | 85 +++++++++++++++++++
 autotests/testWPA2-ext-key-id/hw.conf         |  6 ++
 autotests/testWPA2-ext-key-id/main_pae.conf   |  2 +
 autotests/testWPA2-ext-key-id/ssidCCMP.conf   | 11 +++
 4 files changed, 104 insertions(+)
 create mode 100644 autotests/testWPA2-ext-key-id/connection_test.py
 create mode 100644 autotests/testWPA2-ext-key-id/hw.conf
 create mode 100644 autotests/testWPA2-ext-key-id/main_pae.conf
 create mode 100644 autotests/testWPA2-ext-key-id/ssidCCMP.conf

diff --git a/autotests/testWPA2-ext-key-id/connection_test.py b/autotests/t=
estWPA2-ext-key-id/connection_test.py
new file mode 100644
index 00000000..56e976bb
--- /dev/null
+++ b/autotests/testWPA2-ext-key-id/connection_test.py
@@ -0,0 +1,85 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+import os
+
+sys.path.append('../util')
+from iwd import IWD_CONFIG_DIR
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+
+    def validate(self, wd):
+        hapd =3D HostapdCLI('ssidCCMP.conf')
+
+        psk_agent =3D PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        ordered_network =3D device.get_ordered_network('ssidCCMP')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected()
+
+        # Rekey 5 times just to make sure the key ID can be toggled back a=
nd
+        # forth without causing problems.
+        for i in range(5):
+            hapd.rekey(device.address)
+
+            testutil.test_iface_operstate()
+            testutil.test_ifaces_connected()
+
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        wd.unregister_psk_agent(psk_agent)
+
+    def test_ext_key_control_port(self):
+        self.wd =3D IWD(True)
+
+        self.validate(self.wd)
+
+    def test_ext_key_pae(self):
+        IWD.copy_to_storage('main_pae.conf', storage_dir=3DIWD_CONFIG_DIR,=
 name=3D'main.conf')
+
+        self.wd =3D IWD(True)
+
+        self.validate(self.wd)
+
+    def tearDown(self):
+        try:
+            os.system('rm -rf %s/main.conf' % IWD_CONFIG_DIR)
+        except:
+            pass
+
+        self.wd =3D None
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
diff --git a/autotests/testWPA2-ext-key-id/hw.conf b/autotests/testWPA2-ext=
-key-id/hw.conf
new file mode 100644
index 00000000..de81e1e2
--- /dev/null
+++ b/autotests/testWPA2-ext-key-id/hw.conf
@@ -0,0 +1,6 @@
+[SETUP]
+num_radios=3D2
+start_iwd=3D0
+
+[HOSTAPD]
+rad0=3DssidCCMP.conf
diff --git a/autotests/testWPA2-ext-key-id/main_pae.conf b/autotests/testWP=
A2-ext-key-id/main_pae.conf
new file mode 100644
index 00000000..8bcedda5
--- /dev/null
+++ b/autotests/testWPA2-ext-key-id/main_pae.conf
@@ -0,0 +1,2 @@
+[General]
+ControlPortOverNL80211=3Dfalse
diff --git a/autotests/testWPA2-ext-key-id/ssidCCMP.conf b/autotests/testWP=
A2-ext-key-id/ssidCCMP.conf
new file mode 100644
index 00000000..b52bfb7c
--- /dev/null
+++ b/autotests/testWPA2-ext-key-id/ssidCCMP.conf
@@ -0,0 +1,11 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidCCMP
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
+
+ieee80211w=3D2
+wpa_key_mgmt=3DWPA-PSK-SHA256
+extended_key_id=3D1
-- =

2.31.1

--===============1584729293824812671==--

