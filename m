Content-Type: multipart/mixed; boundary="===============2446041268314921507=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 16/18] auto-t: remove FT-over-DS test,
 and rename testFT-PSK-roam
Date: Thu, 12 Aug 2021 13:22:05 -0700
Message-ID: <20210812202207.737053-16-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2446041268314921507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testFT-PSK-over-DS/connection_test.py     | 151 ------------------
 .../testFT-PSK-over-DS/ft-psk-ccmp-1.conf     |  41 -----
 .../testFT-PSK-over-DS/ft-psk-ccmp-2.conf     |  41 -----
 autotests/testFT-PSK-roam/hw.conf             |   7 -
 autotests/testFT-PSK-roam/main.conf           |   2 -
 .../TestFT.psk                                |   0
 .../connection_test.py                        |   0
 .../ft-psk-ccmp-1.conf                        |   0
 .../ft-psk-ccmp-2.conf                        |   0
 .../hw.conf                                   |   0
 .../main.conf                                 |   0
 11 files changed, 242 deletions(-)
 delete mode 100644 autotests/testFT-PSK-over-DS/connection_test.py
 delete mode 100644 autotests/testFT-PSK-over-DS/ft-psk-ccmp-1.conf
 delete mode 100644 autotests/testFT-PSK-over-DS/ft-psk-ccmp-2.conf
 delete mode 100644 autotests/testFT-PSK-roam/hw.conf
 delete mode 100644 autotests/testFT-PSK-roam/main.conf
 rename autotests/{testFT-PSK-roam =3D> testPSK-roam}/TestFT.psk (100%)
 rename autotests/{testFT-PSK-roam =3D> testPSK-roam}/connection_test.py (1=
00%)
 rename autotests/{testFT-PSK-roam =3D> testPSK-roam}/ft-psk-ccmp-1.conf (1=
00%)
 rename autotests/{testFT-PSK-roam =3D> testPSK-roam}/ft-psk-ccmp-2.conf (1=
00%)
 rename autotests/{testFT-PSK-over-DS =3D> testPSK-roam}/hw.conf (100%)
 rename autotests/{testFT-PSK-over-DS =3D> testPSK-roam}/main.conf (100%)

diff --git a/autotests/testFT-PSK-over-DS/connection_test.py b/autotests/te=
stFT-PSK-over-DS/connection_test.py
deleted file mode 100644
index 7be5924f..00000000
--- a/autotests/testFT-PSK-over-DS/connection_test.py
+++ /dev/null
@@ -1,151 +0,0 @@
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
-        psk_agent =3D PSKAgent("EasilyGuessedPassword")
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
-        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.=
address)
-
-        # list_sta actually reports any authenticated stations. Due to the
-        # nature of FT-over-DS IWD should authenticate to all stations with
-        # the same mobility domain. This means both APs should show our st=
ation.
-        self.assertTrue(self.bss_hostapd[0].list_sta())
-        self.assertTrue(self.bss_hostapd[1].list_sta())
-
-        wd.unregister_psk_agent(psk_agent)
-
-        testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
-        self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name))
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
-                          (self.bss_hostapd[0].ifname, device.name))
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
-        hwsim =3D Hwsim()
-
-        cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config=3D'ft-psk-ccmp-2.conf') ]
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
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-PSK-over-DS/ft-psk-ccmp-1.conf b/autotests/te=
stFT-PSK-over-DS/ft-psk-ccmp-1.conf
deleted file mode 100644
index e75aac74..00000000
--- a/autotests/testFT-PSK-over-DS/ft-psk-ccmp-1.conf
+++ /dev/null
@@ -1,41 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DTestFT
-utf8_ssid=3D1
-ctrl_interface=3D/var/run/hostapd
-
-r1_key_holder=3D120000000001
-nas_identifier=3Ddummy1
-
-wpa=3D2
-# Can support WPA-PSK and FT-PSK (space separated list) and/or EAP at the =
same
-# time but we want to force FT
-wpa_key_mgmt=3DFT-PSK
-wpa_pairwise=3DCCMP
-wpa_passphrase=3DEasilyGuessedPassword
-wpa_ptk_rekey=3D30
-wpa_group_rekey=3D80
-ieee80211w=3D1
-rsn_preauth=3D1
-rsn_preauth_interfaces=3Dlo
-disable_pmksa_caching=3D0
-# Allow PMK cache to be shared opportunistically among configured interfac=
es
-# and BSSes (i.e., all configurations within a single hostapd process).
-okc=3D1
-mobility_domain=3D1234
-reassociation_deadline=3D60000
-r0kh=3D12:00:00:00:00:01 dummy1 000102030405060708090a0b0c0d0e0f
-r0kh=3D12:00:00:00:00:02 dummy2 000102030405060708090a0b0c0d0e0f
-r1kh=3D12:00:00:00:00:01 00:00:00:00:00:01 000102030405060708090a0b0c0d0e0f
-r1kh=3D12:00:00:00:00:02 00:00:00:00:00:02 000102030405060708090a0b0c0d0e0f
-# Push mode only needed for 8021x, not PSK mode since msk already known
-pmk_r1_push=3D0
-# Allow locally generated FT response so we don't have to configure push/p=
ull
-# between BSSes running as separate hostapd processes as in the test-runner
-# case.  Only works with FT-PSK, otherwise brctl needs to be installed and
-# CONFIG_BRIDGE enabled in the kernel.
-ft_psk_generate_local=3D1
-ft_over_ds=3D1
-ap_table_expiration_time=3D36000
-ap_table_max_size=3D10
-rrm_neighbor_report=3D1
diff --git a/autotests/testFT-PSK-over-DS/ft-psk-ccmp-2.conf b/autotests/te=
stFT-PSK-over-DS/ft-psk-ccmp-2.conf
deleted file mode 100644
index e9ee6a70..00000000
--- a/autotests/testFT-PSK-over-DS/ft-psk-ccmp-2.conf
+++ /dev/null
@@ -1,41 +0,0 @@
-hw_mode=3Dg
-channel=3D2
-ssid=3DTestFT
-utf8_ssid=3D1
-ctrl_interface=3D/var/run/hostapd
-
-r1_key_holder=3D120000000002
-nas_identifier=3Ddummy2
-
-wpa=3D2
-# Can support WPA-PSK and FT-PSK (space separated list) and/or EAP at the =
same
-# time but we want to force FT
-wpa_key_mgmt=3DFT-PSK
-wpa_pairwise=3DCCMP
-wpa_passphrase=3DEasilyGuessedPassword
-wpa_ptk_rekey=3D30
-wpa_group_rekey=3D80
-ieee80211w=3D1
-rsn_preauth=3D1
-rsn_preauth_interfaces=3Dlo
-disable_pmksa_caching=3D0
-# Allow PMK cache to be shared opportunistically among configured interfac=
es
-# and BSSes (i.e., all configurations within a single hostapd process).
-okc=3D1
-mobility_domain=3D1234
-reassociation_deadline=3D60000
-r0kh=3D12:00:00:00:00:01 dummy1 000102030405060708090a0b0c0d0e0f
-r0kh=3D12:00:00:00:00:02 dummy2 000102030405060708090a0b0c0d0e0f
-r1kh=3D12:00:00:00:00:01 00:00:00:00:00:01 000102030405060708090a0b0c0d0e0f
-r1kh=3D12:00:00:00:00:02 00:00:00:00:00:02 000102030405060708090a0b0c0d0e0f
-# Push mode only needed for 8021x, not PSK mode since msk already known
-pmk_r1_push=3D0
-# Allow locally generated FT response so we don't have to configure push/p=
ull
-# between BSSes running as separate hostapd processes as in the test-runner
-# case.  Only works with FT-PSK, otherwise brctl needs to be installed and
-# CONFIG_BRIDGE enabled in the kernel.
-ft_psk_generate_local=3D1
-ft_over_ds=3D1
-ap_table_expiration_time=3D36000
-ap_table_max_size=3D10
-rrm_neighbor_report=3D1
diff --git a/autotests/testFT-PSK-roam/hw.conf b/autotests/testFT-PSK-roam/=
hw.conf
deleted file mode 100644
index 3fc77613..00000000
--- a/autotests/testFT-PSK-roam/hw.conf
+++ /dev/null
@@ -1,7 +0,0 @@
-[SETUP]
-num_radios=3D3
-start_iwd=3D0
-
-[HOSTAPD]
-rad0=3Dft-psk-ccmp-1.conf
-rad1=3Dft-psk-ccmp-2.conf
diff --git a/autotests/testFT-PSK-roam/main.conf b/autotests/testFT-PSK-roa=
m/main.conf
deleted file mode 100644
index 9452fb6b..00000000
--- a/autotests/testFT-PSK-roam/main.conf
+++ /dev/null
@@ -1,2 +0,0 @@
-[Scan]
-DisableMacAddressRandomization=3Dtrue
diff --git a/autotests/testFT-PSK-roam/TestFT.psk b/autotests/testPSK-roam/=
TestFT.psk
similarity index 100%
rename from autotests/testFT-PSK-roam/TestFT.psk
rename to autotests/testPSK-roam/TestFT.psk
diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testP=
SK-roam/connection_test.py
similarity index 100%
rename from autotests/testFT-PSK-roam/connection_test.py
rename to autotests/testPSK-roam/connection_test.py
diff --git a/autotests/testFT-PSK-roam/ft-psk-ccmp-1.conf b/autotests/testP=
SK-roam/ft-psk-ccmp-1.conf
similarity index 100%
rename from autotests/testFT-PSK-roam/ft-psk-ccmp-1.conf
rename to autotests/testPSK-roam/ft-psk-ccmp-1.conf
diff --git a/autotests/testFT-PSK-roam/ft-psk-ccmp-2.conf b/autotests/testP=
SK-roam/ft-psk-ccmp-2.conf
similarity index 100%
rename from autotests/testFT-PSK-roam/ft-psk-ccmp-2.conf
rename to autotests/testPSK-roam/ft-psk-ccmp-2.conf
diff --git a/autotests/testFT-PSK-over-DS/hw.conf b/autotests/testPSK-roam/=
hw.conf
similarity index 100%
rename from autotests/testFT-PSK-over-DS/hw.conf
rename to autotests/testPSK-roam/hw.conf
diff --git a/autotests/testFT-PSK-over-DS/main.conf b/autotests/testPSK-roa=
m/main.conf
similarity index 100%
rename from autotests/testFT-PSK-over-DS/main.conf
rename to autotests/testPSK-roam/main.conf
-- =

2.31.1

--===============2446041268314921507==--

