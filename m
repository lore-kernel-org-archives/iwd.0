Content-Type: multipart/mixed; boundary="===============8759748019803079543=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/2] auto-t: roam test to simulate reported crash
Date: Wed, 19 Jan 2022 12:59:11 -0800
Message-ID: <20220119205911.2281616-2-prestwoj@gmail.com>
In-Reply-To: 20220119205911.2281616-1-prestwoj@gmail.com

--===============8759748019803079543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The crash itself is caused by new roam scans overwriting the previous
scan ID. To simulate this both BSS's are set to very low signal strength
which will cause IWD to attempt a roam but find no better BSS candidates.
IWD will then attempt a roam scan again. During this we kill hostapd which
sends a disconnect and should trigger a crash without the fix.
---
 autotests/testPSK-roam/connection_test.py     |  2 +
 autotests/testPSK-roam/main.conf              |  3 +
 .../testPSK-roam/roam_ap_disconnect_test.py   | 80 +++++++++++++++++++
 3 files changed, 85 insertions(+)
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
index 00000000..eee7077e
--- /dev/null
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -0,0 +1,80 @@
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
+        self.bss_hostapd[0].deauthenticate(device.address)
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
+        cls.bss_hostapd[0].reload()
+        cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
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

--===============8759748019803079543==--

