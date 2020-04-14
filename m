Content-Type: multipart/mixed; boundary="===============1352055079353843750=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v3 3/3] auto-t: Fix event order
Date: Mon, 13 Apr 2020 18:16:45 -0700
Message-ID: <20200414011645.22321-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200414011645.22321-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1352055079353843750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In addition, use the conditional wait for the expected number
of known networks
---
 autotests/testHotspot/autoconnect_test.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHots=
pot/autoconnect_test.py
index edefb296..252a4b92 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -52,7 +52,8 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertEqual(len(wd.list_known_networks()), 1)
+        condition =3D 'len(obj.list_known_networks()) =3D=3D 1'
+        wd.wait_for_object_condition(wd, condition)
 =

         condition =3D 'obj.scanning'
         wd.wait_for_object_condition(device, condition)
@@ -74,9 +75,6 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected(device.name, hapd_hotspot.ifname)
 =

         os.remove('/var/lib/iwd/hotspot/autoconnect.conf')
-        IWD.copy_to_storage('ssidWPA2-1.psk')
-
-        self.assertEqual(len(wd.list_known_networks()), 1)
 =

         #
         # make sure removal of hotspot conf file resulted in disconnect
@@ -84,6 +82,11 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 =

+        IWD.copy_to_storage('ssidWPA2-1.psk')
+
+        condition =3D 'len(obj.list_known_networks()) =3D=3D 1'
+        wd.wait_for_object_condition(wd, condition)
+
         condition =3D 'obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

-- =

2.13.6

--===============1352055079353843750==--

