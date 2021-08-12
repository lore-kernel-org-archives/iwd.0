Content-Type: multipart/mixed; boundary="===============5270680031670354420=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 15/18] auto-t: use connect_bssid/roam APIs in testFT-PSK-roam
Date: Thu, 12 Aug 2021 13:22:04 -0700
Message-ID: <20210812202207.737053-15-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5270680031670354420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This also adds FT-over-DS into this test, as well as a reassociation
test for good measure.
---
 autotests/testFT-PSK-roam/TestFT.psk         |   5 +
 autotests/testFT-PSK-roam/connection_test.py | 106 +++++++++++--------
 2 files changed, 67 insertions(+), 44 deletions(-)
 create mode 100644 autotests/testFT-PSK-roam/TestFT.psk

diff --git a/autotests/testFT-PSK-roam/TestFT.psk b/autotests/testFT-PSK-ro=
am/TestFT.psk
new file mode 100644
index 00000000..acadaab9
--- /dev/null
+++ b/autotests/testFT-PSK-roam/TestFT.psk
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=3DEasilyGuessedPassword
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index 716d83c4..b4ead946 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -13,31 +13,14 @@ from hostapd import HostapdCLI
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
-        rule1.signal =3D -2500
-
-        wd =3D IWD(True)
-
-        psk_agent =3D PSKAgent("EasilyGuessedPassword")
-        wd.register_psk_agent(psk_agent)
-
+    def validate_connection(self, wd, over_ds=3DFalse):
         device =3D wd.list_devices(1)[0]
 =

         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

+        # Scanning is unavoidable in this case since several hostapd
+        # configurations are tested and changed mid-test
         device.scan()
 =

         condition =3D 'obj.scanning'
@@ -49,7 +32,6 @@ class Test(unittest.TestCase):
         ordered_network =3D device.get_ordered_network('TestFT')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
-        self.assertEqual(ordered_network.signal_strength, -2000)
 =

         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
@@ -57,28 +39,27 @@ class Test(unittest.TestCase):
         self.assertFalse(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
 =

-        ordered_network.network_object.connect()
+        device.connect_bssid(self.bss_hostapd[0].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
-        self.assertFalse(self.bss_hostapd[1].list_sta())
 =

-        wd.unregister_psk_agent(psk_agent)
+        # list_sta actually reports any authenticated stations. Due to the
+        # nature of FT-over-DS IWD should authenticate to all stations with
+        # the same mobility domain. This means both APs should show our st=
ation.
+        if over_ds:
+            self.assertTrue(self.bss_hostapd[1].list_sta())
+        else:
+            self.assertFalse(self.bss_hostapd[1].list_sta())
 =

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
@@ -94,10 +75,9 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[0].ifname, device.name))
+                          (self.bss_hostapd[0].ifname, device.name, True, =
True))
 =

-        rule0.signal =3D -2000
-        rule1.signal =3D -8000
+        device.roam(self.bss_hostapd[0].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
@@ -113,7 +93,52 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
+                          (self.bss_hostapd[1].ifname, device.name, True, =
True))
+
+    def test_ft_psk(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[0].set_value('ft_over_ds', '0')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[1].set_value('ft_over_ds', '0')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd)
+
+    def test_ft_psk_over_ds(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[0].set_value('ft_over_ds', '1')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[1].set_value('ft_over_ds', '1')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd, over_ds=3DTrue)
+
+    def test_reassociate_psk(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'WPA-PSK')
+        self.bss_hostapd[0].set_value('ft_over_ds', '0')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'WPA-PSK')
+        self.bss_hostapd[1].set_value('ft_over_ds', '0')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd)
 =

     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
@@ -121,18 +146,12 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
 =

-        hwsim =3D Hwsim()
-        for rule in list(hwsim.rules.keys()):
-            del hwsim.rules[rule]
-
     @classmethod
     def setUpClass(cls):
-        hwsim =3D Hwsim()
+        IWD.copy_to_storage('TestFT.psk')
 =

         cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-psk-ccmp-1.conf'),
                             HostapdCLI(config=3D'ft-psk-ccmp-2.conf') ]
-        cls.bss_radio =3D  [ hwsim.get_radio('rad0'),
-                           hwsim.get_radio('rad1') ]
 =

         # Set interface addresses to those expected by hostapd config files
         os.system('ifconfig "' + cls.bss_hostapd[0].ifname +
@@ -159,7 +178,6 @@ class Test(unittest.TestCase):
     def tearDownClass(cls):
         IWD.clear_storage()
         cls.bss_hostapd =3D None
-        cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.31.1

--===============5270680031670354420==--

