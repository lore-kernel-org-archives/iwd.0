Content-Type: multipart/mixed; boundary="===============0148231904164873362=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: remove beacon loss tests
Date: Tue, 03 Nov 2020 12:51:29 -0800
Message-ID: <20201103205129.2744888-3-prestwoj@gmail.com>
In-Reply-To: <20201103205129.2744888-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0148231904164873362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testFT-8021x-roam/connection_test.py      | 76 -----------------
 autotests/testFT-PSK-roam/connection_test.py  | 83 -------------------
 2 files changed, 159 deletions(-)

diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index 2dfe9ce5..6e905f0d 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -92,82 +92,6 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name))
 =

-    def test_roam_on_beacon_loss(self):
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
-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
-
-        # Check that iwd selects BSS 0 first
-        rule0.signal =3D -2000
-        rule1.signal =3D -2500
-
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
-        ordered_network =3D device.get_ordered_network("TestFT")
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-        self.assertEqual(ordered_network.signal_strength, -2000)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        self.assertFalse(self.bss_hostapd[0].list_sta())
-        self.assertFalse(self.bss_hostapd[1].list_sta())
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        self.assertTrue(self.bss_hostapd[0].list_sta())
-        self.assertFalse(self.bss_hostapd[1].list_sta())
-
-        testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
-        self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
-
-        # Check that iwd starts transition to BSS 1 in less than 20 seconds
-        # from a beacon loss event
-        rule0.drop =3D True
-        rule0.signal =3D -3000
-        wd.wait(2)
-        rule0.drop =3D False
-
-        condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
-        # Check that iwd is on BSS 1 once out of roaming state and doesn't
-        # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
-        self.assertEqual(device.state, iwd.DeviceState.connected)
-        self.assertTrue(self.bss_hostapd[1].list_sta())
-
-        testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
-        self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[0].ifname, device.name))
-
     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" down')
diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index 2d65c925..8e69fcd5 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -98,89 +98,6 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name))
 =

-    def test_roam_on_beacon_loss(self):
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
-        device =3D wd.list_devices(1)[0]
-        # prevent autoconnect
-        device.disconnect()
-
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
-        ordered_network =3D device.get_ordered_network("TestFT")
-        self.assertEqual(ordered_network.type, NetworkType.psk)
-        self.assertEqual(ordered_network.signal_strength, -2000)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        self.assertFalse(self.bss_hostapd[0].list_sta())
-        self.assertFalse(self.bss_hostapd[1].list_sta())
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        self.assertTrue(self.bss_hostapd[0].list_sta())
-        self.assertFalse(self.bss_hostapd[1].list_sta())
-
-        wd.unregister_psk_agent(psk_agent)
-
-        testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
-        self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
-
-        # Check that iwd starts transition to BSS 1 in less than 20 seconds
-        # from a beacon loss event
-        rule0.drop =3D True
-        rule0.signal =3D -3000
-        wd.wait(2)
-        rule0.drop =3D False
-
-        condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 20)
-
-        # Check that iwd is on BSS 1 once out of roaming state and doesn't
-        # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
-
-        self.assertEqual(device.state, iwd.DeviceState.connected)
-        self.assertTrue(self.bss_hostapd[1].list_sta())
-
-        testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
-        self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[0].ifname, device.name))
-
     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" down')
-- =

2.26.2

--===============0148231904164873362==--

