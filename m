Content-Type: multipart/mixed; boundary="===============4608778109799744494=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 8/8] auto-t: Add channel switch test
Date: Tue, 19 Oct 2021 11:19:10 -0700
Message-ID: <20211019181910.558043-8-prestwoj@gmail.com>
In-Reply-To: 20211019181910.558043-1-prestwoj@gmail.com

--===============4608778109799744494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testChannelSwitch/connection_test.py      | 65 +++++++++++++++++++
 autotests/testChannelSwitch/hw.conf           |  5 ++
 autotests/testChannelSwitch/ssidCCMP.conf     |  7 ++
 3 files changed, 77 insertions(+)
 create mode 100644 autotests/testChannelSwitch/connection_test.py
 create mode 100644 autotests/testChannelSwitch/hw.conf
 create mode 100644 autotests/testChannelSwitch/ssidCCMP.conf

diff --git a/autotests/testChannelSwitch/connection_test.py b/autotests/tes=
tChannelSwitch/connection_test.py
new file mode 100644
index 00000000..e5421c69
--- /dev/null
+++ b/autotests/testChannelSwitch/connection_test.py
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
+        hapd =3D HostapdCLI()
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
+        hapd.chan_switch(2)
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected()
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
diff --git a/autotests/testChannelSwitch/hw.conf b/autotests/testChannelSwi=
tch/hw.conf
new file mode 100644
index 00000000..fad15b88
--- /dev/null
+++ b/autotests/testChannelSwitch/hw.conf
@@ -0,0 +1,5 @@
+[SETUP]
+num_radios=3D2
+
+[HOSTAPD]
+rad0=3DssidCCMP.conf
diff --git a/autotests/testChannelSwitch/ssidCCMP.conf b/autotests/testChan=
nelSwitch/ssidCCMP.conf
new file mode 100644
index 00000000..074e8228
--- /dev/null
+++ b/autotests/testChannelSwitch/ssidCCMP.conf
@@ -0,0 +1,7 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidCCMP
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
-- =

2.31.1

--===============4608778109799744494==--

