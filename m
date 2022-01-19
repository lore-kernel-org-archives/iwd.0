Content-Type: multipart/mixed; boundary="===============2071868551532920536=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: roam test to simulate reported crash
Date: Wed, 19 Jan 2022 09:55:34 -0800
Message-ID: <20220119175534.2257300-1-prestwoj@gmail.com>

--===============2071868551532920536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The crash itself is caused by new roam scans overwriting the previous
scan ID. To simulate this both BSS's are set to very low signal strength
which will cause IWD to attempt a roam but find no better BSS candidates.
IWD will then attempt a roam scan again. During this we kill hostapd which
sends a disconnect and should trigger a crash without the fix.
---
 .../testPSK-roam/roam_ap_disconnect_test.py   | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 autotests/testPSK-roam/roam_ap_disconnect_test.py

diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/=
testPSK-roam/roam_ap_disconnect_test.py
new file mode 100644
index 00000000..f11fe5bb
--- /dev/null
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -0,0 +1,96 @@
+#! /usr/bin/python3
+
+import unittest
+import sys, os
+
+sys.path.append('../util')
+from iwd import IWD
+from iwd import NetworkType
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+
+class Test(unittest.TestCase):
+    #
+    # Tests a crash reported where multiple roam scans combined with an AP
+    # disconnect result in a crash getting scan results.
+    #
+    def test_ap_disconnect(self):
+        wd =3D IWD(True)
+        device =3D wd.list_devices(1)[0]
+
+        ordered_network =3D device.get_ordered_network('TestFT')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        device.connect_bssid(self.bss_hostapd[0].bssid)
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        # Since both BSS's have low signal, the roam should fail and trigg=
er
+        # another roam scan.
+        device.wait_for_event('no-roam-candidates')
+
+        # Hostapd sends disconnect
+        self.bss_hostapd[0].disable()
+
+        # IWD should recover, and not crash
+        condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    def tearDown(self):
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
+
+    @classmethod
+    def setUpClass(cls):
+        hwsim =3D Hwsim()
+
+        IWD.copy_to_storage('TestFT.psk')
+
+        cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-psk-ccmp-1.conf'),
+                            HostapdCLI(config=3D'ft-psk-ccmp-2.conf') ]
+
+        cls.rule0 =3D hwsim.rules.create()
+        cls.rule0.source =3D cls.bss_hostapd[0].bssid
+        cls.rule0.signal =3D -8000
+        cls.rule0.enabled =3D True
+
+        cls.rule1 =3D hwsim.rules.create()
+        cls.rule1.source =3D cls.bss_hostapd[1].bssid
+        cls.rule1.signal =3D -9000
+        cls.rule1.enabled =3D True
+
+        # Set interface addresses to those expected by hostapd config files
+        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" dow=
n')
+        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" add=
r 12:00:00:00:00:01 up')
+        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" dow=
n')
+        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" add=
r 12:00:00:00:00:02 up')
+
+        cls.bss_hostapd[0].reload()
+        cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        cls.bss_hostapd[1].reload()
+        cls.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        # Fill in the neighbor AP tables in both BSSes.  By default each
+        # instance knows only about current BSS, even inside one hostapd
+        # process.
+        # FT still works without the neighbor AP table but neighbor reports
+        # have to be disabled in the .conf files
+        cls.bss_hostapd[0].set_neighbor('12:00:00:00:00:02', 'TestFT',
+                '1200000000028f0000005102060603000000')
+        cls.bss_hostapd[1].set_neighbor('12:00:00:00:00:01', 'TestFT',
+                '1200000000018f0000005101060603000000')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd =3D None
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
-- =

2.31.1

--===============2071868551532920536==--

