Content-Type: multipart/mixed; boundary="===============4072530503443164317=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 1/5] auto-t: add test for roaming retry timing
Date: Wed, 27 Jan 2021 10:05:00 +0000
Message-ID: <20210127100457.341757-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4072530503443164317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Alvin =C5=A0ipraga <alvin@pqrs.dk>

Recent changes make iwd more eager to retry roaming if it has detected a
high RSSI since the last attempt. Add an autotest to verify this
behaviour.
---
 autotests/testRoamRetry/fast_retry_test.py | 145 +++++++++++++++++++++
 autotests/testRoamRetry/hw.conf            |   7 +
 autotests/testRoamRetry/ssid1.conf         |  11 ++
 autotests/testRoamRetry/ssid2.conf         |  11 ++
 4 files changed, 174 insertions(+)
 create mode 100644 autotests/testRoamRetry/fast_retry_test.py
 create mode 100644 autotests/testRoamRetry/hw.conf
 create mode 100644 autotests/testRoamRetry/ssid1.conf
 create mode 100644 autotests/testRoamRetry/ssid2.conf

diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoa=
mRetry/fast_retry_test.py
new file mode 100644
index 00000000..32d80002
--- /dev/null
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -0,0 +1,145 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+
+import testutil
+
+from hostapd import HostapdCLI
+from hwsim import Hwsim
+
+class Test(unittest.TestCase):
+    # Normally the time between a failed roam attempt and the next roam at=
tempt
+    # is 60 seconds (default RoamRetryInterval). Test that we retry roaming
+    # faster if the transision looks like this: LOW [roam] [same bss] HIGH=
 LOW.
+    def test_fast_retry(self):
+        hwsim =3D Hwsim()
+
+        bss_hostapd =3D [ HostapdCLI(config=3D'ssid1.conf'),
+                        HostapdCLI(config=3D'ssid2.conf') ]
+        bss_radio =3D  [ hwsim.get_radio('rad0'),
+                       hwsim.get_radio('rad1') ]
+
+        rule0 =3D hwsim.rules.create()
+        rule0.source =3D bss_radio[0].addresses[0]
+        rule0.bidirectional =3D True
+
+        rule1 =3D hwsim.rules.create()
+        rule1.source =3D bss_radio[1].addresses[0]
+        rule1.bidirectional =3D True
+
+        # Fill in the neighbor AP tables in both BSSes.  By default each
+        # instance knows only about current BSS, even inside one hostapd
+        # process.
+        # Roaming still works without the neighbor AP table but neighbor
+        # reports have to be disabled in the .conf files
+        bss0_nr =3D ''.join(bss_radio[0].addresses[0].split(':')) + \
+                '8f0000005101060603000000'
+        bss1_nr =3D ''.join(bss_radio[1].addresses[0].split(':')) + \
+                '8f0000005102060603000000'
+
+        bss_hostapd[0].set_neighbor(bss_radio[1].addresses[0], 'TestRoamRe=
try',
+                bss1_nr)
+        bss_hostapd[1].set_neighbor(bss_radio[0].addresses[0], 'TestRoamRe=
try',
+                bss0_nr)
+
+        # Start in the vicinity of BSS 0, check that iwd connects to BSS 0
+        rule0.signal =3D -2000
+        rule1.signal =3D -8500
+
+        wd =3D IWD()
+
+        psk_agent =3D PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        device.scan()
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        ordered_network =3D device.get_ordered_network('TestRoamRetry')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        self.assertTrue(bss_hostapd[0].list_sta())
+        self.assertFalse(bss_hostapd[1].list_sta())
+
+        wd.wait(5)
+
+        # Now push the signal LOW, wait for iwd to attempt a roam, fail, a=
nd
+        # schedule another attempt for 60 seconds later
+        rule0.signal =3D -8000
+
+        wd.wait(20)
+
+        self.assertEqual(device.state, iwd.DeviceState.connected)
+        self.assertTrue(bss_hostapd[0].list_sta())
+        self.assertFalse(bss_hostapd[1].list_sta())
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(bss_hostapd[0].ifname, device.name)
+
+        # Assert high signal for BSS 0 again. This clears the way for a fa=
ster
+        # roam attempt on LOW again
+        rule0.signal =3D -5000
+
+        # Wait a little for signal recognition
+        wd.wait(1)
+
+        # Assert low signal for BSS 0, check that iwd starts transition to=
 BSS 1
+        # in less than 10 seconds. Because of the neighbor report a scan s=
hould
+        # not be necessary.
+        rule0.signal =3D -8000
+        rule1.signal =3D -2000
+
+        condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        wd.wait_for_object_condition(device, condition, max_wait=3D10)
+
+        # Check that iwd is on BSS 1 once out of roaming state and doesn't
+        # go through 'disconnected', 'autoconnect', 'connecting' in between
+        condition =3D 'obj.state !=3D DeviceState.roaming'
+        wd.wait_for_object_condition(device, condition, max_wait=3D5)
+
+        self.assertEqual(device.state, iwd.DeviceState.connected)
+        self.assertTrue(bss_hostapd[1].list_sta())
+
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        wd.unregister_psk_agent(psk_agent)
+
+        rule0.remove()
+        rule1.remove()
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testRoamRetry/hw.conf b/autotests/testRoamRetry/hw.c=
onf
new file mode 100644
index 00000000..5dbe97b4
--- /dev/null
+++ b/autotests/testRoamRetry/hw.conf
@@ -0,0 +1,7 @@
+[SETUP]
+num_radios=3D3
+needs_hwsim=3D1
+
+[HOSTAPD]
+rad0=3Dssid1.conf
+rad1=3Dssid2.conf
diff --git a/autotests/testRoamRetry/ssid1.conf b/autotests/testRoamRetry/s=
sid1.conf
new file mode 100644
index 00000000..2c5cc8d6
--- /dev/null
+++ b/autotests/testRoamRetry/ssid1.conf
@@ -0,0 +1,11 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DTestRoamRetry
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
+
+ctrl_interface=3D/var/run/hostapd
+
+rrm_neighbor_report=3D1
diff --git a/autotests/testRoamRetry/ssid2.conf b/autotests/testRoamRetry/s=
sid2.conf
new file mode 100644
index 00000000..5626c032
--- /dev/null
+++ b/autotests/testRoamRetry/ssid2.conf
@@ -0,0 +1,11 @@
+hw_mode=3Dg
+channel=3D2
+ssid=3DTestRoamRetry
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
+
+ctrl_interface=3D/var/run/hostapd
+
+rrm_neighbor_report=3D1
-- =

2.29.2

--===============4072530503443164317==--

