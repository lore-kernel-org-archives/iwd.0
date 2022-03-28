Content-Type: multipart/mixed; boundary="===============4800106430279077204=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 09/13] auto-t: use wait_for_event in testPSK-roam
Date: Mon, 28 Mar 2022 10:28:38 -0700
Message-ID: <20220328172842.1660272-10-prestwoj@gmail.com>
In-Reply-To: 20220328172842.1660272-1-prestwoj@gmail.com

--===============4800106430279077204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Depending on timing hostapd may not show a station with list_sta()
Instead use wait_for_event
---
 autotests/testPSK-roam/connection_test.py | 29 ++++-------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index 92fdeb04..f1b43130 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -16,20 +16,7 @@ class Test(unittest.TestCase):
     def validate_connection(self, wd, over_ds=3DFalse):
         device =3D wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        # Scanning is unavoidable in this case since several hostapd
-        # configurations are tested and changed mid-test
-        device.scan()
-
-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('TestFT')
+        ordered_network =3D device.get_ordered_network('TestFT', full_scan=
=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -44,15 +31,7 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertTrue(self.bss_hostapd[0].list_sta())
-
-        # list_sta actually reports any authenticated stations. Due to the
-        # nature of FT-over-DS IWD should authenticate to all stations with
-        # the same mobility domain. This means both APs should show our st=
ation.
-        if over_ds:
-            self.assertTrue(self.bss_hostapd[1].list_sta())
-        else:
-            self.assertFalse(self.bss_hostapd[1].list_sta())
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.=
address)
 =

         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
@@ -73,7 +52,7 @@ class Test(unittest.TestCase):
         to_condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertTrue(self.bss_hostapd[1].list_sta())
+        self.bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.=
address)
 =

         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
@@ -93,7 +72,7 @@ class Test(unittest.TestCase):
         to_condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertTrue(self.bss_hostapd[0].list_sta())
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.=
address)
 =

         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
-- =

2.34.1

--===============4800106430279077204==--

