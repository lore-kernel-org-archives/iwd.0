Content-Type: multipart/mixed; boundary="===============6882917953194778526=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] auto-t: add RRM autotest
Date: Tue, 29 Oct 2019 10:50:43 -0700
Message-ID: <20191029175043.27745-5-prestwoj@gmail.com>
In-Reply-To: <20191029175043.27745-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6882917953194778526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test merely verifies hostapd receieved our measurement reports
and verified they were valid. Hostapd does not verify the actual
beacon report body. Really, the only way to test this is on an
actual network which makes these requests.
---
 autotests/testRRM/connection_test.py | 114 +++++++++++++++++++++++++++
 autotests/testRRM/hw.conf            |   8 ++
 autotests/testRRM/ssidOther.conf     |  10 +++
 autotests/testRRM/ssidRRM.conf       |  13 +++
 4 files changed, 145 insertions(+)
 create mode 100644 autotests/testRRM/connection_test.py
 create mode 100644 autotests/testRRM/hw.conf
 create mode 100644 autotests/testRRM/ssidOther.conf
 create mode 100644 autotests/testRRM/ssidRRM.conf

diff --git a/autotests/testRRM/connection_test.py b/autotests/testRRM/conne=
ction_test.py
new file mode 100644
index 00000000..93fd6cb8
--- /dev/null
+++ b/autotests/testRRM/connection_test.py
@@ -0,0 +1,114 @@
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
+from hostapd import HostapdCLI
+import testutil
+
+from time import sleep
+
+# Table beacon with wildcard BSSID
+basic_beacon =3D '51000000000002ffffffffffff020100'
+# Table beacon with wildcard BSSID and SSID filter
+beacon_with_ssid =3D '51000000000002ffffffffffff02010000077373696452524d'
+# Passive beacon with wildcard BSSID
+beacon_passive =3D '510b0000000000ffffffffffff020100'
+# Active beacon with wildcard BSSID
+beacon_active =3D '510b0000000001ffffffffffff020100'
+
+class Test(unittest.TestCase):
+
+    def test_connection_success(self):
+        hapd =3D HostapdCLI(config=3D'ssidRRM.conf')
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
+        ordered_network =3D device.get_ordered_network('ssidRRM')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected()
+
+        hapd.wait_for_event('AP-STA-CONNECTED')
+
+        # This should return both APs
+        hapd.req_beacon(device.address, basic_beacon)
+
+        for e in ['BEACON-RESP-RX', 'BEACON-RESP-RX']:
+            event =3D hapd.wait_for_event(e)
+            if event:
+                print(event)
+
+        sleep(0.5)
+
+        # This should return just ssidRRM
+        hapd.req_beacon(device.address, beacon_with_ssid)
+        event =3D hapd.wait_for_event('BEACON-RESP-RX')
+        if event:
+            print(event)
+
+        sleep(0.5)
+
+        # This should passive scan on channel 11, returning otherSSID
+        hapd.req_beacon(device.address, beacon_passive)
+        # TODO: See if we are scanning here (scan not initiated from stati=
on)
+
+        event =3D hapd.wait_for_event('BEACON-RESP-RX')
+        if event:
+            print(event)
+
+        sleep(0.5)
+
+        # This should active scan on channel 11, returning otherSSID
+        hapd.req_beacon(device.address, beacon_active)
+        # TODO: See if we are scanning here (scan not initiated from stati=
on)
+
+        event =3D hapd.wait_for_event('BEACON-RESP-RX')
+        if event:
+            print(event)
+
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        wd.unregister_psk_agent(psk_agent)
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
diff --git a/autotests/testRRM/hw.conf b/autotests/testRRM/hw.conf
new file mode 100644
index 00000000..91c757ce
--- /dev/null
+++ b/autotests/testRRM/hw.conf
@@ -0,0 +1,8 @@
+[SETUP]
+num_radios=3D3
+max_test_exec_interval_sec=3D40
+reg_domain=3DUS
+
+[HOSTAPD]
+rad0=3DssidRRM.conf
+rad1=3DssidOther.conf
diff --git a/autotests/testRRM/ssidOther.conf b/autotests/testRRM/ssidOther=
.conf
new file mode 100644
index 00000000..e0f0fd40
--- /dev/null
+++ b/autotests/testRRM/ssidOther.conf
@@ -0,0 +1,10 @@
+ctrl_interface=3D/var/run/hostapd
+
+hw_mode=3Dg
+channel=3D11
+ssid=3DssidOther
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
+rrm_beacon_report=3D1
diff --git a/autotests/testRRM/ssidRRM.conf b/autotests/testRRM/ssidRRM.conf
new file mode 100644
index 00000000..233392f9
--- /dev/null
+++ b/autotests/testRRM/ssidRRM.conf
@@ -0,0 +1,13 @@
+ctrl_interface=3D/var/run/hostapd
+
+hw_mode=3Da
+ssid=3DssidRRM
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
+rrm_beacon_report=3D1
+ht_capab=3D[HT40+]
+
+ieee80211n=3D1
+channel=3D36
-- =

2.17.1

--===============6882917953194778526==--

