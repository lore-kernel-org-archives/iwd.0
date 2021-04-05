Content-Type: multipart/mixed; boundary="===============3058620062572154660=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] auto-t: add timeout test to SAE
Date: Mon, 05 Apr 2021 15:40:26 -0700
Message-ID: <20210405224027.1052197-4-prestwoj@gmail.com>
In-Reply-To: <20210405224027.1052197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3058620062572154660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This tests the timeout handling in SAE for both authenticate
and associate frames.
---
 autotests/testSAE/hw.conf         |  1 -
 autotests/testSAE/timeout_test.py | 83 +++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testSAE/timeout_test.py

diff --git a/autotests/testSAE/hw.conf b/autotests/testSAE/hw.conf
index 86f42630..15bc3a55 100644
--- a/autotests/testSAE/hw.conf
+++ b/autotests/testSAE/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D7
 start_iwd=3D0
-hwsim_medium=3Dno
 =

 [HOSTAPD]
 rad0=3DssidSAE.conf
diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_=
test.py
new file mode 100644
index 00000000..70462cec
--- /dev/null
+++ b/autotests/testSAE/timeout_test.py
@@ -0,0 +1,83 @@
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
+from hwsim import Hwsim
+
+class Test(unittest.TestCase):
+
+    def validate_connection(self, wd):
+        hwsim =3D Hwsim()
+        bss_radio =3D hwsim.get_radio('rad0')
+
+        psk_agent =3D PSKAgent(["secret123", "secret123"])
+        wd.register_psk_agent(psk_agent)
+
+        devices =3D wd.list_devices(4)
+
+        # These devices aren't used in this test, this makes logs a bit ni=
cer
+        # since these devices would presumably start autoconnecting.
+        devices[1].disconnect()
+        devices[2].disconnect()
+        devices[3].disconnect()
+
+        self.assertIsNotNone(devices)
+        device =3D devices[0]
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        device.scan()
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        network =3D device.get_ordered_network('ssidSAE')
+
+        self.assertEqual(network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(network.network_object, condition)
+
+        rule0 =3D hwsim.rules.create()
+        rule0.source =3D bss_radio.addresses[0]
+        rule0.bidirectional =3D True
+        rule0.drop =3D True
+        rule0.prefix =3D 'b0'
+
+        wd.wait(1)
+        print(rule0)
+
+        with self.assertRaises(iwd.FailedEx):
+            network.network_object.connect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(network.network_object, condition)
+
+        rule0.prefix =3D '00'
+        with self.assertRaises(iwd.FailedEx):
+            network.network_object.connect()
+
+        wd.unregister_psk_agent(psk_agent)
+
+    def test_connection_success(self):
+        wd =3D IWD(True)
+
+        self.validate_connection(wd)
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
-- =

2.26.2

--===============3058620062572154660==--

