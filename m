Content-Type: multipart/mixed; boundary="===============8808445970715475849=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 3/3] auto-t: roam test to simulate reported crash
Date: Wed, 19 Jan 2022 14:26:52 -0800
Message-ID: <20220119222652.2299217-3-prestwoj@gmail.com>
In-Reply-To: 20220119222652.2299217-1-prestwoj@gmail.com

--===============8808445970715475849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During investigation another separate crash was found. The original is
caused by a disconnect event coming in after a neighbor report scan
was completed (roam failed) during the full roam scan.

The second crash is caused by a disconnect coming in during a full
roam scan when no neighbor report scan was ever issued.
---
 autotests/testPSK-roam/connection_test.py     |   2 +
 autotests/testPSK-roam/main.conf              |   3 +
 .../testPSK-roam/roam_ap_disconnect_test.py   | 101 ++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 autotests/testPSK-roam/roam_ap_disconnect_test.py

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index 8d9b22ad..92fdeb04 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -203,6 +203,8 @@ class Test(unittest.TestCase):
     def tearDownClass(cls):
         IWD.clear_storage()
         cls.bss_hostapd =3D None
+        cls.rule0.enabled =3D False
+        cls.rule0.remove()
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testPSK-roam/main.conf b/autotests/testPSK-roam/main=
.conf
index 9452fb6b..3d93ff57 100644
--- a/autotests/testPSK-roam/main.conf
+++ b/autotests/testPSK-roam/main.conf
@@ -1,2 +1,5 @@
 [Scan]
 DisableMacAddressRandomization=3Dtrue
+
+[General]
+RoamRetryInterval=3D1
diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/=
testPSK-roam/roam_ap_disconnect_test.py
new file mode 100644
index 00000000..9cef3090
--- /dev/null
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -0,0 +1,101 @@
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
+    def validate(self):
+        wd =3D IWD(True)
+        device =3D wd.list_devices(1)[0]
+
+        ordered_network =3D device.get_ordered_network('TestFT', full_scan=
=3DTrue)
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
+        device.wait_for_event('no-roam-candidates', timeout=3D30)
+        device.wait_for_event('roam-scan-triggered', timeout=3D30)
+
+        # Hostapd sends disconnect
+        self.bss_hostapd[0].disable()
+
+        # IWD should recover, and not crash
+        condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    def test_ap_disconnect_no_neighbors(self):
+        self.validate()
+
+    def test_ap_disconnect_neighbors(self):
+        self.bss_hostapd[0].set_neighbor('12:00:00:00:00:02', 'TestFT',
+                '1200000000028f0000005102060603000000')
+        self.bss_hostapd[1].set_neighbor('12:00:00:00:00:01', 'TestFT',
+                '1200000000018f0000005101060603000000')
+
+        self.validate()
+
+    def setUp(self):
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+    def tearDown(self):
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
+
+        self.bss_hostapd[0].remove_neighbor(self.bss_hostapd[1].bssid)
+        self.bss_hostapd[1].remove_neighbor(self.bss_hostapd[0].bssid)
+
+    @classmethod
+    def setUpClass(cls):
+        hwsim =3D Hwsim()
+
+        IWD.copy_to_storage('TestFT.psk')
+
+        cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-psk-ccmp-1.conf'),
+                            HostapdCLI(config=3D'ft-psk-ccmp-2.conf') ]
+        cls.bss_hostapd[1].disable()
+
+        cls.bss_hostapd[0].set_value('ocv', '0')
+        cls.bss_hostapd[0].set_value('ieee80211w', '0')
+
+        cls.rule0 =3D hwsim.rules.create()
+        cls.rule0.source =3D 'any'
+        cls.rule0.bidirectional =3D True
+        cls.rule0.signal =3D -8000
+        cls.rule0.enabled =3D True
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
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd =3D None
+        cls.rule0.remove()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
-- =

2.31.1

--===============8808445970715475849==--

