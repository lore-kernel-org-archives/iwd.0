Content-Type: multipart/mixed; boundary="===============3157662282043074076=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 11/14] auto-t: cleanup testRRM
Date: Thu, 31 Mar 2022 16:16:38 -0700
Message-ID: <20220331231641.484200-11-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============3157662282043074076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This removes prints which were never supposed to make it upstream as
well as changes sleep() to wd.wait() as well as increase the wait
period to fix issues with how fast UML runs the tests.
---
 autotests/testRRM/connection_test.py | 32 ++++++++++------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/autotests/testRRM/connection_test.py b/autotests/testRRM/conne=
ction_test.py
index 278c69ce..4d894958 100644
--- a/autotests/testRRM/connection_test.py
+++ b/autotests/testRRM/connection_test.py
@@ -11,8 +11,6 @@ from iwd import NetworkType
 from hostapd import HostapdCLI
 import testutil
 =

-from time import sleep
-
 # Table beacon with wildcard BSSID
 basic_beacon =3D '51000000000002ffffffffffff020100'
 # Table beacon with wildcard BSSID and SSID filter
@@ -53,51 +51,43 @@ class Test(unittest.TestCase):
 =

         hapd.wait_for_event('AP-STA-CONNECTED')
 =

+        wd.wait(1)
+
         # This should return both APs
         hapd.req_beacon(device.address, basic_beacon)
 =

         for e in ['BEACON-RESP-RX', 'BEACON-RESP-RX']:
-            event =3D hapd.wait_for_event(e)
-            if event:
-                print(event)
+            hapd.wait_for_event(e)
 =

-        sleep(0.5)
+        wd.wait(1)
 =

         # This should return just ssidRRM
         hapd.req_beacon(device.address, beacon_with_ssid)
-        event =3D hapd.wait_for_event('BEACON-RESP-RX')
-        if event:
-            print(event)
+        hapd.wait_for_event('BEACON-RESP-RX')
 =

-        sleep(0.5)
+        wd.wait(1)
 =

         # This should passive scan on channel 11, returning otherSSID
         hapd.req_beacon(device.address, beacon_passive)
         # TODO: See if we are scanning here (scan not initiated from stati=
on)
 =

-        event =3D hapd.wait_for_event('BEACON-RESP-RX')
-        if event:
-            print(event)
+        hapd.wait_for_event('BEACON-RESP-RX')
 =

-        sleep(0.5)
+        wd.wait(1)
 =

         # This should active scan on channel 11, returning otherSSID
         hapd.req_beacon(device.address, beacon_active)
         # TODO: See if we are scanning here (scan not initiated from stati=
on)
 =

-        event =3D hapd.wait_for_event('BEACON-RESP-RX')
-        if event:
-            print(event)
+        hapd.wait_for_event('BEACON-RESP-RX')
 =

-        sleep(0.5)
+        wd.wait(1)
 =

          # This should passive scan on channel 11, returning otherSSID
         hapd.req_beacon(device.address, beacon_passive_duration)
         # TODO: See if we are scanning here (scan not initiated from stati=
on)
 =

-        event =3D hapd.wait_for_event('BEACON-RESP-RX')
-        if event:
-            print(event)
+        hapd.wait_for_event('BEACON-RESP-RX')
 =

         device.disconnect()
 =

-- =

2.34.1

--===============3157662282043074076==--

