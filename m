Content-Type: multipart/mixed; boundary="===============6043722149956643280=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/8] auto-t: fixup testRoamRetry for better timing reliability
Date: Tue, 22 Mar 2022 15:51:08 -0700
Message-ID: <20220322225113.1023688-3-prestwoj@gmail.com>
In-Reply-To: 20220322225113.1023688-1-prestwoj@gmail.com

--===============6043722149956643280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change a few critical checks that were failing sometimes:
 - A few asserts were changed to wait_for_object_condition
 - A 15 second timeout was removed (default used instead)
 - Do a full scan at beginning of each test to clear any
   cached BSS's. The second test run was getting stale results
   and the RSSI values were not expected.
---
 autotests/testRoamRetry/fast_retry_test.py | 13 ++++++-------
 autotests/testRoamRetry/stop_retry_test.py |  7 +++----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoa=
mRetry/fast_retry_test.py
index c7de5055..b45daada 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -63,7 +63,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        ordered_network =3D device.get_ordered_network('TestRoamRetry')
+        ordered_network =3D device.get_ordered_network('TestRoamRetry', fu=
ll_scan=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -75,18 +75,18 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertTrue(bss_hostapd[0].list_sta())
-        self.assertFalse(bss_hostapd[1].list_sta())
+        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         wd.wait(5)
 =

         # Now push the signal LOW, wait for iwd to attempt a roam, fail, a=
nd
-        # schedule another attempt for 60 seconds later
+        # schedule another attempt
         rule0.signal =3D -8000
 =

         device.wait_for_event('no-roam-candidates')
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
+
         self.assertTrue(bss_hostapd[0].list_sta())
         self.assertFalse(bss_hostapd[1].list_sta())
 =

@@ -101,12 +101,11 @@ class Test(unittest.TestCase):
         wd.wait(1)
 =

         # Assert low signal for BSS 0, check that iwd starts transition to=
 BSS 1
-        # in less than 10 seconds.
         rule0.signal =3D -8000
         rule1.signal =3D -2000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, max_wait=3D15)
+        wd.wait_for_object_condition(device, condition)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
@@ -114,7 +113,7 @@ class Test(unittest.TestCase):
         to_condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertTrue(bss_hostapd[1].list_sta())
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         device.disconnect()
 =

diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoa=
mRetry/stop_retry_test.py
index f2f95990..3957d12d 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -62,7 +62,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        ordered_network =3D device.get_ordered_network('TestRoamRetry')
+        ordered_network =3D device.get_ordered_network('TestRoamRetry', fu=
ll_scan=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -74,8 +74,7 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertTrue(bss_hostapd[0].list_sta())
-        self.assertFalse(bss_hostapd[1].list_sta())
+        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         # Now push the signal below the RSSI threshold and check that iwd
         # connects to BSS 1
@@ -90,7 +89,7 @@ class Test(unittest.TestCase):
         to_condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertTrue(bss_hostapd[1].list_sta())
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         # Now make sure that we don't roam anymore. In order to catch this=
 via
         # DeviceState, a suitable roaming target needs to be available. So=
 jack
-- =

2.34.1

--===============6043722149956643280==--

