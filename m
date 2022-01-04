Content-Type: multipart/mixed; boundary="===============9132282404255317301=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/6] auto-t: add DPP autotests
Date: Tue, 04 Jan 2022 10:18:57 -0800
Message-ID: <20220104181857.103331-6-prestwoj@gmail.com>
In-Reply-To: 20220104181857.103331-1-prestwoj@gmail.com

--===============9132282404255317301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testDPP/connection_test.py | 73 ++++++++++++++++++++++++++++
 autotests/testDPP/hostapd.conf       |  7 +++
 autotests/testDPP/hw.conf            |  9 ++++
 autotests/testDPP/ssidCCMP.psk       |  2 +
 autotests/testDPP/wpas.conf          |  5 ++
 5 files changed, 96 insertions(+)
 create mode 100644 autotests/testDPP/connection_test.py
 create mode 100644 autotests/testDPP/hostapd.conf
 create mode 100644 autotests/testDPP/hw.conf
 create mode 100644 autotests/testDPP/ssidCCMP.psk
 create mode 100644 autotests/testDPP/wpas.conf

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/conne=
ction_test.py
new file mode 100644
index 00000000..43822c55
--- /dev/null
+++ b/autotests/testDPP/connection_test.py
@@ -0,0 +1,73 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+from iwd import IWD
+from wpas import Wpas
+from hostapd import HostapdCLI
+
+class Test(unittest.TestCase):
+
+    def test_iwd_as_enrollee(self):
+        wpas =3D Wpas('wpas.conf')
+
+        wd =3D IWD(True)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+        device.autoconnect =3D True
+
+        uri =3D device.dpp_start_enrollee()
+
+        wpas.dpp_configurator_create(uri)
+        wpas.dpp_configurator_start('ssidCCMP', 'secret123')
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        device.disconnect()
+        device.dpp_stop()
+
+        del wpas
+
+    def test_iwd_as_configurator(self):
+        IWD.copy_to_storage('ssidCCMP.psk')
+
+        wpas =3D Wpas('wpas.conf')
+        hapd =3D HostapdCLI('hostapd.conf')
+
+        wd =3D IWD(True)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+        device.autoconnect =3D True
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        uri =3D device.dpp_start_configurator()
+
+        wpas.dpp_enrollee_start(uri)
+
+        hapd.wait_for_event('AP-STA-CONNECTED 42:00:00:00:00:00')
+
+        device.disconnect()
+        device.dpp_stop()
+
+        del wpas
+
+    def tearDown(self):
+        IWD.clear_storage()
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        pass
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testDPP/hostapd.conf b/autotests/testDPP/hostapd.conf
new file mode 100644
index 00000000..074e8228
--- /dev/null
+++ b/autotests/testDPP/hostapd.conf
@@ -0,0 +1,7 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidCCMP
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
diff --git a/autotests/testDPP/hw.conf b/autotests/testDPP/hw.conf
new file mode 100644
index 00000000..478f0633
--- /dev/null
+++ b/autotests/testDPP/hw.conf
@@ -0,0 +1,9 @@
+[SETUP]
+num_radios=3D3
+start_iwd=3D0
+
+[WPA_SUPPLICANT]
+rad0=3Dwpas.conf
+
+[HOSTAPD]
+rad1=3Dhostapd.conf
diff --git a/autotests/testDPP/ssidCCMP.psk b/autotests/testDPP/ssidCCMP.psk
new file mode 100644
index 00000000..abafdb66
--- /dev/null
+++ b/autotests/testDPP/ssidCCMP.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=3Dsecret123
diff --git a/autotests/testDPP/wpas.conf b/autotests/testDPP/wpas.conf
new file mode 100644
index 00000000..5ec815b4
--- /dev/null
+++ b/autotests/testDPP/wpas.conf
@@ -0,0 +1,5 @@
+ctrl_interface=3D/tmp/rad1-p2p-wpas
+
+update_config=3D1
+pmf=3D2
+dpp_config_processing=3D2
-- =

2.31.1

--===============9132282404255317301==--

