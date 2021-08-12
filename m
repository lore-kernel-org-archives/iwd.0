Content-Type: multipart/mixed; boundary="===============3847748042499952605=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/18] auto-t: add reassociate test to FT-SAE-roam
Date: Thu, 12 Aug 2021 13:21:57 -0700
Message-ID: <20210812202207.737053-8-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3847748042499952605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This refactors to test both FT and reassociation.
---
 autotests/testFT-SAE-roam/TestFT.psk         |   5 +
 autotests/testFT-SAE-roam/connection_test.py | 109 ++++++++-----------
 2 files changed, 48 insertions(+), 66 deletions(-)
 create mode 100644 autotests/testFT-SAE-roam/TestFT.psk

diff --git a/autotests/testFT-SAE-roam/TestFT.psk b/autotests/testFT-SAE-ro=
am/TestFT.psk
new file mode 100644
index 00000000..acadaab9
--- /dev/null
+++ b/autotests/testFT-SAE-roam/TestFT.psk
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=3DEasilyGuessedPassword
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testFT-SAE-roam/connection_test.py b/autotests/testF=
T-SAE-roam/connection_test.py
index bea42856..da7413f9 100644
--- a/autotests/testFT-SAE-roam/connection_test.py
+++ b/autotests/testFT-SAE-roam/connection_test.py
@@ -8,37 +8,12 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hwsim import Hwsim
 from hostapd import HostapdCLI
 import testutil
 from config import ctx
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
-        rule2 =3D hwsim.rules.create()
-        rule2.source =3D self.bss_radio[2].addresses[0]
-        rule2.bidirectional =3D True
-
-        # Check that iwd selects BSS 0 first
-        rule0.signal =3D -2000
-        rule1.signal =3D -6900
-        rule2.signal =3D -7200
-
-        wd =3D IWD(True)
-
-        psk_agent =3D PSKAgent("EasilyGuessedPassword")
-        wd.register_psk_agent(psk_agent)
-
+    def validate_connection(self, wd, ft=3DTrue):
         device =3D wd.list_devices(1)[0]
 =

         condition =3D 'not obj.scanning'
@@ -52,18 +27,10 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

-        ordered_network =3D device.get_ordered_network('TestFT')
-
-        self.assertEqual(ordered_network.type, NetworkType.psk)
-        self.assertEqual(ordered_network.signal_strength, -2000)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
         self.assertFalse(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
 =

-        ordered_network.network_object.connect()
+        device.connect_bssid(self.bss_hostapd[0].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -71,20 +38,12 @@ class Test(unittest.TestCase):
         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
 =

-        wd.unregister_psk_agent(psk_agent)
-
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
@@ -95,22 +54,17 @@ class Test(unittest.TestCase):
         to_condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        rule1.signal =3D -2000
-
-        # wait for IWD's signal levels to recover
-        wd.wait(5)
-
         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[0].ifname, device.name))
+                          (self.bss_hostapd[0].ifname, device.name, True, =
True))
 =

-        # test FT-PSK after FT-SAE
-        rule1.signal =3D -8000
-        rule0.signal =3D -8000
-        rule2.signal =3D -1000
+        if not ft:
+                return
+
+        device.roam(self.bss_hostapd[2].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
@@ -124,7 +78,37 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[2].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                            (self.bss_hostapd[1].ifname, device.name))
+                            (self.bss_hostapd[1].ifname, device.name, True=
, True))
+
+    def test_ft_roam_success(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-SAE SAE')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-SAE SAE')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[2].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[2].reload()
+        self.bss_hostapd[2].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd, True)
+
+    def test_reassociate_roam_success(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'SAE')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'SAE')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[2].set_value('wpa_key_mgmt', 'WPA-PSK')
+        self.bss_hostapd[2].reload()
+        self.bss_hostapd[2].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd, False)
 =

     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
@@ -134,20 +118,11 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
         os.system('ifconfig "' + self.bss_hostapd[2].ifname + '" up')
 =

-        hwsim =3D Hwsim()
-        for rule in list(hwsim.rules.keys()):
-            del hwsim.rules[rule]
-
     @classmethod
     def setUpClass(cls):
-        hwsim =3D Hwsim()
-
         cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-sae-1.conf'),
                             HostapdCLI(config=3D'ft-sae-2.conf'),
                             HostapdCLI(config=3D'ft-psk-3.conf') ]
-        cls.bss_radio =3D  [ hwsim.get_radio('rad0'),
-                           hwsim.get_radio('rad1'),
-                           hwsim.get_radio('rad2') ]
 =

         ctx.start_process(['ifconfig', cls.bss_hostapd[0].ifname, 'down', =
'hw', \
                                 'ether', '12:00:00:00:00:01', 'up'], wait=
=3DTrue)
@@ -184,11 +159,13 @@ class Test(unittest.TestCase):
         cls.bss_hostapd[2].set_neighbor('12:00:00:00:00:02', 'TestFT',
                 '1200000000028f0000005101060603000000')
 =

+        IWD.copy_to_storage('TestFT.psk')
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+
         cls.bss_hostapd =3D None
-        cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.31.1

--===============3847748042499952605==--

