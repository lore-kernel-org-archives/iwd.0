Content-Type: multipart/mixed; boundary="===============7617962814301379241=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/8] auto-t: use wait_for_event in testSAE-roam
Date: Tue, 22 Mar 2022 15:51:10 -0700
Message-ID: <20220322225113.1023688-5-prestwoj@gmail.com>
In-Reply-To: 20220322225113.1023688-1-prestwoj@gmail.com

--===============7617962814301379241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Depending on timing hostapd may not show a station with list_sta().
Instead use wait_for_event.
---
 autotests/testSAE-roam/connection_test.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-=
roam/connection_test.py
index 2409e0d1..4c49eaf8 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -35,7 +35,8 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertTrue(self.bss_hostapd[0].list_sta())
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.=
address)
+
         self.assertFalse(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
@@ -54,7 +55,7 @@ class Test(unittest.TestCase):
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
@@ -72,8 +73,10 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state !=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
-        self.assertTrue(self.bss_hostapd[2].list_sta())
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        self.bss_hostapd[2].wait_for_event('AP-STA-CONNECTED %s' % device.=
address)
 =

         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(self.bss_hostapd[2].ifname, device.=
name)
-- =

2.34.1

--===============7617962814301379241==--

