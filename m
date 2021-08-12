Content-Type: multipart/mixed; boundary="===============2536789383343248096=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/18] auto-t: update testFT-8021x-roam to use roam() API
Date: Thu, 12 Aug 2021 13:22:00 -0700
Message-ID: <20210812202207.737053-11-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2536789383343248096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testFT-8021x-roam/connection_test.py      | 56 ++-----------------
 1 file changed, 5 insertions(+), 51 deletions(-)

diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index aa8eddba..cd6ebbab 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -4,56 +4,25 @@ import unittest
 import sys, os
 =

 sys.path.append('../util')
-import iwd
 from iwd import IWD
 from iwd import NetworkType
-from hwsim import Hwsim
 from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
     def test_roam_success(self):
-        hwsim =3D Hwsim()
-
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D self.bss_radio[0].addresses[0]
-        rule0.bidirectional =3D True
-
-        rule1 =3D hwsim.rules.create()
-        rule1.source =3D self.bss_radio[1].addresses[0]
-        rule1.bidirectional =3D True
-
-        # Check that iwd selects BSS 0 first
-        rule0.signal =3D -2000
-        rule1.signal =3D -6900
-
         wd =3D IWD(True)
 =

         device =3D wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('TestFT')
+        ordered_network =3D device.get_ordered_network('TestFT', scan_if_n=
eeded=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
-        self.assertEqual(ordered_network.signal_strength, -2000)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

         self.assertFalse(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
 =

-        ordered_network.network_object.connect()
+        device.connect_bssid(self.bss_hostapd[0].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -64,15 +33,9 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
+                          (self.bss_hostapd[1].ifname, device.name, True, =
True))
 =

-        # Check that iwd starts transition to BSS 1 in less than 10 second=
s.
-        # The 10 seconds is longer than needed to scan on just two channels
-        # but short enough that a full scan on the 2.4 + 5.8 bands support=
ed
-        # by mac80211_hwsim will not finish.  If this times out then, but
-        # device_roam_trigger_cb has happened, it probably means that
-        # Neighbor Reports are broken.
-        rule0.signal =3D -8000
+        device.roam(self.bss_hostapd[1].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
@@ -88,7 +51,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[0].ifname, device.name))
+                          (self.bss_hostapd[0].ifname, device.name, True, =
True))
 =

     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
@@ -96,20 +59,12 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
 =

-        hwsim =3D Hwsim()
-        for rule in list(hwsim.rules.keys()):
-            del hwsim.rules[rule]
-
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('TestFT.8021x')
 =

-        hwsim =3D Hwsim()
-
         cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-eap-ccmp-1.conf'),
                             HostapdCLI(config=3D'ft-eap-ccmp-2.conf') ]
-        cls.bss_radio =3D  [ hwsim.get_radio('rad0'),
-                           hwsim.get_radio('rad1') ]
 =

         # Set interface addresses to those expected by hostapd config files
         os.system('ifconfig "' + cls.bss_hostapd[0].ifname +
@@ -136,7 +91,6 @@ class Test(unittest.TestCase):
     def tearDownClass(cls):
         IWD.clear_storage()
         cls.bss_hostapd =3D None
-        cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.31.1

--===============2536789383343248096==--

