Content-Type: multipart/mixed; boundary="===============1275778896261616752=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 17/18] auto-t: update testPreauth-roam to use
 connect_bssid/roam()
Date: Thu, 12 Aug 2021 13:22:06 -0700
Message-ID: <20210812202207.737053-17-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1275778896261616752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testPreauth-roam/connection_test.py | 53 ++++---------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/test=
Preauth-roam/connection_test.py
index f31b8b0a..545d4cba 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -4,69 +4,39 @@ import unittest
 import sys, os
 =

 sys.path.append('../util')
-import iwd
 from iwd import IWD
-from iwd import PSKAgent
 from iwd import NetworkType
-from hwsim import Hwsim
 from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
     def test_preauth_success(self):
-        hwsim =3D Hwsim()
-
         bss_hostapd =3D [ HostapdCLI(config=3D'eaptls-preauth-1.conf'),
                         HostapdCLI(config=3D'eaptls-preauth-2.conf') ]
-        bss_radio =3D  [ hwsim.get_radio('rad0'),
-                       hwsim.get_radio('rad1') ]
-
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D bss_radio[0].addresses[0]
-        rule0.bidirectional =3D True
 =

-        rule1 =3D hwsim.rules.create()
-        rule1.source =3D bss_radio[1].addresses[0]
-        rule1.bidirectional =3D True
+        bss0_addr =3D bss_hostapd[0].bssid
+        bss1_addr =3D bss_hostapd[1].bssid
 =

         # Fill in the neighbor AP tables in both BSSes.  By default each
         # instance knows only about current BSS, even inside one hostapd
         # process.
         # Roaming still works without the neighbor AP table but neighbor
         # reports have to be disabled in the .conf files
-        bss0_nr =3D ''.join(bss_radio[0].addresses[0].split(':')) + \
+        bss0_nr =3D ''.join(bss0_addr.split(':')) + \
                 '8f0000005101060603000000'
-        bss1_nr =3D ''.join(bss_radio[1].addresses[0].split(':')) + \
+        bss1_nr =3D ''.join(bss1_addr.split(':')) + \
                 '8f0000005102060603000000'
 =

-        bss_hostapd[0].set_neighbor(bss_radio[1].addresses[0], 'TestPreaut=
h',
-                bss1_nr)
-        bss_hostapd[1].set_neighbor(bss_radio[0].addresses[0], 'TestPreaut=
h',
-                bss0_nr)
-
-        # Check that iwd selects BSS 0 first
-        rule0.signal =3D -2500
-        rule1.signal =3D -6900
+        bss_hostapd[0].set_neighbor(bss1_addr, 'TestPreauth', bss1_nr)
+        bss_hostapd[1].set_neighbor(bss0_addr, 'TestPreauth', bss0_nr)
 =

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
-        ordered_network =3D device.get_ordered_network('TestPreauth')
+        ordered_network =3D device.get_ordered_network('TestPreauth', scan=
_if_needed=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
-        self.assertEqual(ordered_network.signal_strength, -2500)
 =

         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
@@ -74,7 +44,7 @@ class Test(unittest.TestCase):
         self.assertFalse(bss_hostapd[0].list_sta())
         self.assertFalse(bss_hostapd[1].list_sta())
 =

-        ordered_network.network_object.connect()
+        device.connect_bssid(bss0_addr)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -85,10 +55,9 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(bss_hostapd[0].ifname, device.name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          bss_hostapd[1].ifname, device.name)
+                          bss_hostapd[1].ifname, device.name, True, True)
 =

-        # Check that iwd starts transition to BSS 1 in less than 15 seconds
-        rule0.signal =3D -8000
+        device.roam(bss1_addr)
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
@@ -106,7 +75,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(bss_hostapd[1].ifname, device.name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (bss_hostapd[0].ifname, device.name))
+                          (bss_hostapd[0].ifname, device.name, True, True))
 =

         device.disconnect()
 =

-- =

2.31.1

--===============1275778896261616752==--

