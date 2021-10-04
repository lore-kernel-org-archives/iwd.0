Content-Type: multipart/mixed; boundary="===============1740357748592079857=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 11/12] auto-t: Add test for extended key IDs
Date: Mon, 04 Oct 2021 09:49:01 -0700
Message-ID: <20211004164902.2274318-11-prestwoj@gmail.com>
In-Reply-To: 20211004164902.2274318-1-prestwoj@gmail.com

--===============1740357748592079857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testWPA2-ext-key-id/connection_test.py    | 65 +++++++++++++++++++
 autotests/testWPA2-ext-key-id/hw.conf         |  5 ++
 autotests/testWPA2-ext-key-id/ssidCCMP.conf   | 11 ++++
 3 files changed, 81 insertions(+)
 create mode 100644 autotests/testWPA2-ext-key-id/connection_test.py
 create mode 100644 autotests/testWPA2-ext-key-id/hw.conf
 create mode 100644 autotests/testWPA2-ext-key-id/ssidCCMP.conf

diff --git a/autotests/testWPA2-ext-key-id/connection_test.py b/autotests/t=
estWPA2-ext-key-id/connection_test.py
new file mode 100644
index 00000000..6361d9bd
--- /dev/null
+++ b/autotests/testWPA2-ext-key-id/connection_test.py
@@ -0,0 +1,65 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+
+    def test_connection_success(self):
+        hapd =3D HostapdCLI('ssidCCMP.conf')
+        wd =3D IWD()
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
index 00000000..fad15b88
--- /dev/null
+++ b/autotests/testWPA2-ext-key-id/hw.conf
@@ -0,0 +1,5 @@
+[SETUP]
+num_radios=3D2
+
+[HOSTAPD]
+rad0=3DssidCCMP.conf
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

--===============1740357748592079857==--

