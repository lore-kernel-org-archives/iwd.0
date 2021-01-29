Content-Type: multipart/mixed; boundary="===============5073866402175909615=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH v3] auto-t: add test for stopping periodic roam retries
Date: Fri, 29 Jan 2021 12:06:15 +0000
Message-ID: <20210129120613.2162754-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5073866402175909615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
v2 -> v3:
- Removed unnecessary waits
---
 autotests/testRoamRetry/stop_retry_test.py | 131 +++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 autotests/testRoamRetry/stop_retry_test.py

diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoa=
mRetry/stop_retry_test.py
new file mode 100644
index 00000000..a2729d6c
--- /dev/null
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -0,0 +1,131 @@
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
+    # Test that we do not periodically retry roaming if the transision loo=
ks
+    # like this: LOW [roam] [new bss] HIGH.
+    def test_stop_retry(self):
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
+        rule1.signal =3D -5000
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
+        # Now push the signal below the RSSI threshold and check that iwd
+        # connects to BSS 1
+        rule0.signal =3D -8000
+
+        condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        wd.wait_for_object_condition(device, condition)
+
+        # Check that iwd is on BSS 1 once out of roaming state and doesn't
+        # go through 'disconnected', 'autoconnect', 'connecting' in between
+        condition =3D 'obj.state !=3D DeviceState.roaming'
+        wd.wait_for_object_condition(device, condition)
+
+        self.assertEqual(device.state, iwd.DeviceState.connected)
+        self.assertTrue(bss_hostapd[1].list_sta())
+
+        # Now make sure that we don't roam anymore. In order to catch this=
 via
+        # DeviceState, a suitable roaming target needs to be available. So=
 jack
+        # up the RSSI of BSS 0 again. The retry interval is 60 seconds, so=
 we
+        # should have roamed within that timeframe. Wait just a little lon=
ger
+        # to account for the slowness of the autotest environment.
+        rule0.signal =3D -2000
+
+        condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        self.assertRaises(TimeoutError, wd.wait_for_object_condition, devi=
ce,
+                          condition, max_wait=3D70)
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
-- =

2.29.2
--===============5073866402175909615==--

