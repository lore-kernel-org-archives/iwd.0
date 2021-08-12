Content-Type: multipart/mixed; boundary="===============7850687096283080251=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/18] auto-t: combine testFT-FILS* tests
Date: Thu, 12 Aug 2021 13:22:01 -0700
Message-ID: <20210812202207.737053-12-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7850687096283080251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This combines the SHA256 and SHA384 tests into one, as well as
utilizes the new connect_bssid() and roam() APIs for much faster
test execution.
---
 autotests/testFT-FILS-SHA256/TestFT.8021x     |  2 +
 .../testFT-FILS-SHA256/connection_test.py     | 85 +++++++++----------
 .../testFT-FILS-SHA384/connection_test.py     |  6 +-
 3 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/autotests/testFT-FILS-SHA256/TestFT.8021x b/autotests/testFT-F=
ILS-SHA256/TestFT.8021x
index 6fd3e0e8..3b16769b 100644
--- a/autotests/testFT-FILS-SHA256/TestFT.8021x
+++ b/autotests/testFT-FILS-SHA256/TestFT.8021x
@@ -1,5 +1,7 @@
 [Security]
 EAP-Method=3DPWD
+EAP-Identity=3Duser(a)example.com
+EAP-Password=3Dsecret123
 =

 [Settings]
 AutoConnect=3DFalse
diff --git a/autotests/testFT-FILS-SHA256/connection_test.py b/autotests/te=
stFT-FILS-SHA256/connection_test.py
index a1c24578..b136cb7b 100644
--- a/autotests/testFT-FILS-SHA256/connection_test.py
+++ b/autotests/testFT-FILS-SHA256/connection_test.py
@@ -4,41 +4,21 @@ import unittest
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
-    def test_roam_success(self):
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
-        wd =3D IWD(True)
-
-        psk_agent =3D PSKAgent('user(a)example.com', ('user(a)example.com',
-                                                                  'secret1=
23'))
-        wd.register_psk_agent(psk_agent)
-
+    def validate_connection(self, wd):
         device =3D wd.list_devices(1)[0]
 =

         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

+        # Scanning is unavoidable in this case since both FILS-SHA256 and
+        # FILS-SHA384 are tested. Without a new scan the cached scan resul=
ts
+        # would cause IWD to choose an incorrect AKM for the second test.
         device.scan()
 =

         condition =3D 'obj.scanning'
@@ -50,15 +30,11 @@ class Test(unittest.TestCase):
         ordered_network =3D device.get_ordered_network('TestFT')
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
@@ -69,7 +45,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
+                          (self.bss_hostapd[1].ifname, device.name, True, =
True))
 =

         device.disconnect()
 =

@@ -80,10 +56,8 @@ class Test(unittest.TestCase):
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
 =

-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
+        # TODO: verify FILS was actually used on this second connection
+        device.connect_bssid(self.bss_hostapd[0].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -94,7 +68,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
+                          (self.bss_hostapd[1].ifname, device.name, True, =
True))
 =

         # Check that iwd starts transition to BSS 1 in less than 10 second=
s.
         # The 10 seconds is longer than needed to scan on just two channels
@@ -102,7 +76,8 @@ class Test(unittest.TestCase):
         # by mac80211_hwsim will not finish.  If this times out then, but
         # device_roam_trigger_cb has happened, it probably means that
         # Neighbor Reports are broken.
-        rule0.signal =3D -8000
+        #rule0.signal =3D -8000
+        device.roam(self.bss_hostapd[1].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
@@ -118,7 +93,33 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[0].ifname, device.name))
+                          (self.bss_hostapd[0].ifname, device.name, True, =
True))
+
+    def test_fils_ft_roam_sha256(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-EAP FILS-SHA256 =
FT-FILS-SHA256')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-EAP FILS-SHA256 =
FT-FILS-SHA256')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd)
+
+    def test_fils_ft_roam_sha384(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-EAP FILS-SHA384 =
FT-FILS-SHA384')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-EAP FILS-SHA384 =
FT-FILS-SHA384')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd)
 =

     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
@@ -126,21 +127,13 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
 =

-        hwsim =3D Hwsim()
-        for rule in list(hwsim.rules.keys()):
-            del hwsim.rules[rule]
-
     @classmethod
     def setUpClass(cls):
         os.system('ifconfig lo up')
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
@@ -167,7 +160,7 @@ class Test(unittest.TestCase):
     def tearDownClass(cls):
         IWD.clear_storage()
         cls.bss_hostapd =3D None
-        cls.bss_radio =3D None
+        #cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-FILS-SHA384/connection_test.py b/autotests/te=
stFT-FILS-SHA384/connection_test.py
index 465b9c98..a7752c98 100644
--- a/autotests/testFT-FILS-SHA384/connection_test.py
+++ b/autotests/testFT-FILS-SHA384/connection_test.py
@@ -69,7 +69,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
+                          (self.bss_hostapd[1].ifname, device.name, True, =
True))
 =

         device.disconnect()
 =

@@ -94,7 +94,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
+                          (self.bss_hostapd[1].ifname, device.name, True, =
True))
 =

         # Check that iwd starts transition to BSS 1 in less than 10 second=
s.
         # The 10 seconds is longer than needed to scan on just two channels
@@ -118,7 +118,7 @@ class Test(unittest.TestCase):
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
-- =

2.31.1

--===============7850687096283080251==--

