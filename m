Content-Type: multipart/mixed; boundary="===============1844868497942251018=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/8] auto-t: use wait_for_event in testBSSBlacklist
Date: Tue, 22 Mar 2022 15:51:09 -0700
Message-ID: <20220322225113.1023688-4-prestwoj@gmail.com>
In-Reply-To: 20220322225113.1023688-1-prestwoj@gmail.com

--===============1844868497942251018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Depending on timing hostapd may not show a station with list_sta().
Instead use wait_for_event.
---
 autotests/testBSSBlacklist/connection_test.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 6a12174d..df3bd507 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -33,7 +33,7 @@ class Test(unittest.TestCase):
 =

         dev1, dev2 =3D wd.list_devices(2)
 =

-        ordered_network =3D dev1.get_ordered_network("TestBlacklist")
+        ordered_network =3D dev1.get_ordered_network("TestBlacklist", full=
_scan=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -45,12 +45,12 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(dev1, condition)
 =

-        self.assertIn(dev1.address, bss_hostapd[2].list_sta())
+        bss_hostapd[2].wait_for_event('AP-STA-CONNECTED %s' % dev1.address)
 =

         # dev1 now connected, this should max out the first AP, causing th=
e next
         # connection to fail to this AP.
 =

-        ordered_network =3D dev2.get_ordered_network("TestBlacklist")
+        ordered_network =3D dev2.get_ordered_network("TestBlacklist", full=
_scan=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -64,7 +64,7 @@ class Test(unittest.TestCase):
 =

         # We should have temporarily blacklisted the first BSS, and connec=
ted
         # to this one.
-        self.assertIn(dev2.address, bss_hostapd[1].list_sta())
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % dev2.address)
 =

         # Now check that the first BSS is still not blacklisted. We can
         # disconnect dev1, opening up the AP for more connections
@@ -83,7 +83,7 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(dev2, condition)
 =

-        self.assertIn(dev2.address, bss_hostapd[2].list_sta())
+        bss_hostapd[2].wait_for_event('AP-STA-CONNECTED %s' % dev2.address)
 =

         wd.unregister_psk_agent(psk_agent)
 =

@@ -134,7 +134,7 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertIn(device.address, bss_hostapd[0].list_sta())
+        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         wd.unregister_psk_agent(psk_agent)
 =

@@ -214,7 +214,7 @@ class Test(unittest.TestCase):
         # should automatically try the next BSS in the list, which is
         # bss_hostapd[1]
         self.assertNotIn(device.address, bss_hostapd[0].list_sta())
-        self.assertIn(device.address, bss_hostapd[1].list_sta())
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         rule0.drop =3D False
 =

@@ -234,7 +234,7 @@ class Test(unittest.TestCase):
 =

         # Same as before, make sure we didn't connect to the blacklisted A=
P.
         self.assertNotIn(device.address, bss_hostapd[0].list_sta())
-        self.assertIn(device.address, bss_hostapd[1].list_sta())
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         # Wait for the blacklist to expire (10 seconds)
         elapsed =3D time.time() - start
@@ -264,7 +264,7 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertIn(device.address, bss_hostapd[0].list_sta())
+        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         self.wd.unregister_psk_agent(psk_agent)
 =

-- =

2.34.1

--===============1844868497942251018==--

