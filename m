Content-Type: multipart/mixed; boundary="===============5586103083606624971=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 7/7] auto-t: test-wide replacement of assertTrue(list_sta())
Date: Wed, 30 Mar 2022 13:23:15 -0700
Message-ID: <20220330202315.1881335-7-prestwoj@gmail.com>
In-Reply-To: 20220330202315.1881335-1-prestwoj@gmail.com

--===============5586103083606624971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Any test using assertTrue(hostapd.list_sta()) improperly has been
replaced with wait_for_event(). There were a few places where this
was actually ok (i.e. IWD is already connected) but most needed to
be changed since the check was just after IWD connected and hostapd's
list_sta() API may not return a fully updated list.
---
 autotests/testAPRoam/connection_test.py        | 5 ++---
 autotests/testFT-8021x-roam/connection_test.py | 4 ++--
 autotests/testFT-FILS/connection_test.py       | 8 +++++---
 autotests/testOWE/connection_test.py           | 2 +-
 autotests/testPreauth-roam/connection_test.py  | 4 ++--
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam=
/connection_test.py
index c7037231..41d70f3a 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -36,7 +36,6 @@ class Test(unittest.TestCase):
 =

         bss_hostapd[0].wait_for_event('AP-STA-CONNECTED')
 =

-        self.assertTrue(bss_hostapd[0].list_sta())
         self.assertFalse(bss_hostapd[1].list_sta())
 =

         bss_hostapd[0].send_bss_transition(device.address,
@@ -51,8 +50,8 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
-        self.assertTrue(bss_hostapd[1].list_sta())
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
+
         device.disconnect()
 =

         condition =3D 'not obj.connected'
diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index 652677a9..6853bdb0 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -27,7 +27,7 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertTrue(self.bss_hostapd[0].list_sta())
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.=
address)
         self.assertFalse(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
@@ -46,7 +46,7 @@ class Test(unittest.TestCase):
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
diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FI=
LS/connection_test.py
index 4aef8db6..c1deb77c 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -28,7 +28,8 @@ class Test(unittest.TestCase):
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
@@ -51,7 +52,8 @@ class Test(unittest.TestCase):
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
@@ -77,7 +79,7 @@ class Test(unittest.TestCase):
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
diff --git a/autotests/testOWE/connection_test.py b/autotests/testOWE/conne=
ction_test.py
index baef4d49..391d8cf5 100644
--- a/autotests/testOWE/connection_test.py
+++ b/autotests/testOWE/connection_test.py
@@ -60,7 +60,7 @@ class Test(unittest.TestCase):
         to_condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertTrue(hapd1.list_sta())
+        hapd1.wait_for_event('AP-STA-CONNECTED %s' % device.address)
 =

         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(hapd1.ifname, device.name)
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/test=
Preauth-roam/connection_test.py
index 61f095d3..26475698 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -49,7 +49,7 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertTrue(bss_hostapd[0].list_sta())
+        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
         self.assertFalse(bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
@@ -70,7 +70,7 @@ class Test(unittest.TestCase):
         to_condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertTrue(bss_hostapd[1].list_sta())
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.addre=
ss)
 =

         testutil.test_iface_operstate(device.name)
         testutil.test_ifaces_connected(bss_hostapd[1].ifname, device.name)
-- =

2.34.1

--===============5586103083606624971==--

