Content-Type: multipart/mixed; boundary="===============1476241374043310554=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/18] auto-t: remove testFT-FILS-SHA384
Date: Thu, 12 Aug 2021 13:22:03 -0700
Message-ID: <20210812202207.737053-14-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1476241374043310554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testFT-FILS-SHA384/TestFT.8021x     |   5 -
 .../testFT-FILS-SHA384/connection_test.py     | 174 ------------------
 .../testFT-FILS-SHA384/ft-eap-ccmp-1.conf     |  42 -----
 .../testFT-FILS-SHA384/ft-eap-ccmp-2.conf     |  42 -----
 autotests/testFT-FILS-SHA384/hw.conf          |   8 -
 autotests/testFT-FILS-SHA384/main.conf        |   2 -
 autotests/testFT-FILS-SHA384/pwd.eap_user     |   1 -
 autotests/testFT-FILS-SHA384/radius.conf      |  15 --
 8 files changed, 289 deletions(-)
 delete mode 100644 autotests/testFT-FILS-SHA384/TestFT.8021x
 delete mode 100644 autotests/testFT-FILS-SHA384/connection_test.py
 delete mode 100644 autotests/testFT-FILS-SHA384/ft-eap-ccmp-1.conf
 delete mode 100644 autotests/testFT-FILS-SHA384/ft-eap-ccmp-2.conf
 delete mode 100644 autotests/testFT-FILS-SHA384/hw.conf
 delete mode 100644 autotests/testFT-FILS-SHA384/main.conf
 delete mode 100644 autotests/testFT-FILS-SHA384/pwd.eap_user
 delete mode 100644 autotests/testFT-FILS-SHA384/radius.conf

diff --git a/autotests/testFT-FILS-SHA384/TestFT.8021x b/autotests/testFT-F=
ILS-SHA384/TestFT.8021x
deleted file mode 100644
index 6fd3e0e8..00000000
--- a/autotests/testFT-FILS-SHA384/TestFT.8021x
+++ /dev/null
@@ -1,5 +0,0 @@
-[Security]
-EAP-Method=3DPWD
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testFT-FILS-SHA384/connection_test.py b/autotests/te=
stFT-FILS-SHA384/connection_test.py
deleted file mode 100644
index a7752c98..00000000
--- a/autotests/testFT-FILS-SHA384/connection_test.py
+++ /dev/null
@@ -1,174 +0,0 @@
-#! /usr/bin/python3
-
-import unittest
-import sys, os
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-from hwsim import Hwsim
-from hostapd import HostapdCLI
-import testutil
-
-class Test(unittest.TestCase):
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
-        device =3D wd.list_devices(1)[0]
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
-        ordered_network =3D device.get_ordered_network('TestFT')
-
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
-                          (self.bss_hostapd[1].ifname, device.name, True, =
True))
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network =3D device.get_ordered_network('TestFT')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
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
-                          (self.bss_hostapd[1].ifname, device.name, True, =
True))
-
-        # Check that iwd starts transition to BSS 1 in less than 10 second=
s.
-        # The 10 seconds is longer than needed to scan on just two channels
-        # but short enough that a full scan on the 2.4 + 5.8 bands support=
ed
-        # by mac80211_hwsim will not finish.  If this times out then, but
-        # device_roam_trigger_cb has happened, it probably means that
-        # Neighbor Reports are broken.
-        rule0.signal =3D -8000
-
-        condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
-        # Check that iwd is on BSS 1 once out of roaming state and doesn't
-        # go through 'disconnected', 'autoconnect', 'connecting' in between
-        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_change(device, from_condition, to_condition)
-
-        self.assertTrue(self.bss_hostapd[1].list_sta())
-
-        testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
-        self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[0].ifname, device.name, True, =
True))
-
-    def tearDown(self):
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
-
-        hwsim =3D Hwsim()
-        for rule in list(hwsim.rules.keys()):
-            del hwsim.rules[rule]
-
-    @classmethod
-    def setUpClass(cls):
-        os.system('ifconfig lo up')
-        IWD.copy_to_storage('TestFT.8021x')
-
-        hwsim =3D Hwsim()
-
-        cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-eap-ccmp-1.conf'),
-                            HostapdCLI(config=3D'ft-eap-ccmp-2.conf') ]
-        cls.bss_radio =3D  [ hwsim.get_radio('rad0'),
-                           hwsim.get_radio('rad1') ]
-
-        # Set interface addresses to those expected by hostapd config files
-        os.system('ifconfig "' + cls.bss_hostapd[0].ifname +
-                '" down hw ether 12:00:00:00:00:01 up')
-        os.system('ifconfig "' + cls.bss_hostapd[1].ifname +
-                '" down hw ether 12:00:00:00:00:02 up')
-
-        cls.bss_hostapd[0].reload()
-        cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
-        cls.bss_hostapd[1].reload()
-        cls.bss_hostapd[1].wait_for_event("AP-ENABLED")
-
-        # Fill in the neighbor AP tables in both BSSes.  By default each
-        # instance knows only about current BSS, even inside one hostapd
-        # process.
-        # FT still works without the neighbor AP table but neighbor reports
-        # have to be disabled in the .conf files
-        cls.bss_hostapd[0].set_neighbor('12:00:00:00:00:02', 'TestFT',
-                '1200000000028f0000005102060603000000')
-        cls.bss_hostapd[1].set_neighbor('12:00:00:00:00:01', 'TestFT',
-                '1200000000018f0000005101060603000000')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-        cls.bss_hostapd =3D None
-        cls.bss_radio =3D None
-
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-FILS-SHA384/ft-eap-ccmp-1.conf b/autotests/te=
stFT-FILS-SHA384/ft-eap-ccmp-1.conf
deleted file mode 100644
index 61262c69..00000000
--- a/autotests/testFT-FILS-SHA384/ft-eap-ccmp-1.conf
+++ /dev/null
@@ -1,42 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DTestFT
-utf8_ssid=3D1
-ctrl_interface=3D/var/run/hostapd
-r1_key_holder=3D000000000001
-nas_identifier=3Ddummy1
-
-wpa=3D2
-# Can support WPA-EAP and FT-EAP (space separated list) at the same
-# time but we want to force FT
-wpa_key_mgmt=3DFT-EAP FILS-SHA384 FT-FILS-SHA384
-wpa_pairwise=3DCCMP
-ieee8021x=3D1
-
-fils_realm=3Dexample.com
-
-wpa_ptk_rekey=3D30
-wpa_group_rekey=3D80
-ieee80211w=3D1
-rsn_preauth=3D1
-disable_pmksa_caching=3D1
-# Allow PMK cache to be shared opportunistically among configured interfac=
es
-# and BSSes (i.e., all configurations within a single hostapd process).
-okc=3D1
-mobility_domain=3D1234
-reassociation_deadline=3D60000
-r0kh=3D12:00:00:00:00:01 nas1.w1.fi 000102030405060708090a0b0c0d0e0f
-r0kh=3D12:00:00:00:00:02 nas2.w1.fi 000102030405060708090a0b0c0d0e0f
-r1kh=3D12:00:00:00:00:01 00:00:00:00:00:01 000102030405060708090a0b0c0d0e0f
-r1kh=3D12:00:00:00:00:02 00:00:00:00:00:02 000102030405060708090a0b0c0d0e0f
-# Push mode only needed for 8021x, not PSK mode since msk already known
-pmk_r1_push=3D1
-ft_over_ds=3D0
-ap_table_expiration_time=3D36000
-ap_table_max_size=3D10
-rrm_neighbor_report=3D1
-
-auth_server_addr=3D127.0.0.1
-auth_server_port=3D1812
-auth_server_shared_secret=3Dsecret
-nas_identifier=3Dnas1.w1.fi
diff --git a/autotests/testFT-FILS-SHA384/ft-eap-ccmp-2.conf b/autotests/te=
stFT-FILS-SHA384/ft-eap-ccmp-2.conf
deleted file mode 100644
index a6bdf641..00000000
--- a/autotests/testFT-FILS-SHA384/ft-eap-ccmp-2.conf
+++ /dev/null
@@ -1,42 +0,0 @@
-hw_mode=3Dg
-channel=3D2
-ssid=3DTestFT
-utf8_ssid=3D1
-ctrl_interface=3D/var/run/hostapd
-r1_key_holder=3D000000000002
-nas_identifier=3Ddummy2
-
-wpa=3D2
-# Can support WPA-EAP and FT-EAP (space separated list) at the same
-# time but we want to force FT
-wpa_key_mgmt=3DWPA-EAP FT-FILS-SHA384
-wpa_pairwise=3DCCMP
-ieee8021x=3D1
-
-fils_realm=3Dexample.com
-
-wpa_ptk_rekey=3D30
-wpa_group_rekey=3D80
-ieee80211w=3D1
-rsn_preauth=3D1
-disable_pmksa_caching=3D1
-# Allow PMK cache to be shared opportunistically among configured interfac=
es
-# and BSSes (i.e., all configurations within a single hostapd process).
-okc=3D1
-mobility_domain=3D1234
-reassociation_deadline=3D60000
-r0kh=3D12:00:00:00:00:01 nas1.w1.fi 000102030405060708090a0b0c0d0e0f
-r0kh=3D12:00:00:00:00:02 nas2.w1.fi 000102030405060708090a0b0c0d0e0f
-r1kh=3D12:00:00:00:00:01 00:00:00:00:00:01 000102030405060708090a0b0c0d0e0f
-r1kh=3D12:00:00:00:00:02 00:00:00:00:00:02 000102030405060708090a0b0c0d0e0f
-# Push mode only needed for 8021x, not PSK mode since msk already known
-pmk_r1_push=3D1
-ft_over_ds=3D0
-ap_table_expiration_time=3D36000
-ap_table_max_size=3D10
-rrm_neighbor_report=3D1
-
-auth_server_addr=3D127.0.0.1
-auth_server_port=3D1812
-auth_server_shared_secret=3Dsecret
-nas_identifier=3Dnas2.w1.fi
diff --git a/autotests/testFT-FILS-SHA384/hw.conf b/autotests/testFT-FILS-S=
HA384/hw.conf
deleted file mode 100644
index 322f0862..00000000
--- a/autotests/testFT-FILS-SHA384/hw.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-[SETUP]
-num_radios=3D3
-start_iwd=3D0
-
-[HOSTAPD]
-rad0=3Dft-eap-ccmp-1.conf
-rad1=3Dft-eap-ccmp-2.conf
-radius_server=3Dradius.conf
diff --git a/autotests/testFT-FILS-SHA384/main.conf b/autotests/testFT-FILS=
-SHA384/main.conf
deleted file mode 100644
index 9452fb6b..00000000
--- a/autotests/testFT-FILS-SHA384/main.conf
+++ /dev/null
@@ -1,2 +0,0 @@
-[Scan]
-DisableMacAddressRandomization=3Dtrue
diff --git a/autotests/testFT-FILS-SHA384/pwd.eap_user b/autotests/testFT-F=
ILS-SHA384/pwd.eap_user
deleted file mode 100644
index 69079c24..00000000
--- a/autotests/testFT-FILS-SHA384/pwd.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"user(a)example.com"	PWD     "secret123"
diff --git a/autotests/testFT-FILS-SHA384/radius.conf b/autotests/testFT-FI=
LS-SHA384/radius.conf
deleted file mode 100644
index 4fcfdfff..00000000
--- a/autotests/testFT-FILS-SHA384/radius.conf
+++ /dev/null
@@ -1,15 +0,0 @@
-driver=3Dnone
-radius_server_clients=3D/tmp/certs/radius-clients.text
-radius_server_auth_port=3D1812
-eap_user_file=3D/tmp/pwd.eap_user
-eap_server=3D0
-eap_server_erp=3D1
-
-erp_send_reauth_start=3D1
-erp_domain=3Dexample.com
-fils_realm=3Dexample.com
-disable_pmksa_caching=3D1
-
-pwd_group=3D19
-wpa_group_rekey=3D30
-wpa_ptk_rekey=3D30
-- =

2.31.1

--===============1476241374043310554==--

