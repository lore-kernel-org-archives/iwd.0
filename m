Content-Type: multipart/mixed; boundary="===============5318065141717333366=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/3] auto-t: Use proper connection status indicator
Date: Mon, 13 Apr 2020 17:40:45 -0700
Message-ID: <20200414004047.13678-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5318065141717333366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

'Connected' property of the network object is set before the connection
attempt is made and does not indicate a connection success. Therefore,
use device status property to identify the connection status of the device.
---
 autotests/testHotspot/autoconnect_test.py | 30 +++++++++++++--------------=
---
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHots=
pot/autoconnect_test.py
index 36ba92bf..936373f1 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -40,10 +40,8 @@ class Test(unittest.TestCase):
         # while there are hotspot networks in range. This should result in
         # autoconnect *after* ANQP is performed
         #
-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(wpa_network.network_object, condition)
-
-        sleep(2)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd_wpa.ifname)
@@ -53,10 +51,10 @@ class Test(unittest.TestCase):
         #
         os.remove("/var/lib/iwd/ssidWPA2-1.psk")
 =

-        self.assertEqual(len(wd.list_known_networks()), 1)
+        condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
 =

-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(wpa_network.network_object, condition)
+        self.assertEqual(len(wd.list_known_networks()), 1)
 =

         condition =3D 'obj.scanning'
         wd.wait_for_object_condition(device, condition)
@@ -71,10 +69,8 @@ class Test(unittest.TestCase):
         # Since there are no other provisioned networks, we should do ANQP=
 and
         # autoconnect to the hotspot network.
         #
-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(hotspot_network.network_object, condi=
tion)
-
-        sleep(2)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd_hotspot.ifname)
@@ -87,8 +83,8 @@ class Test(unittest.TestCase):
         #
         # make sure removal of hotspot conf file resulted in disconnect
         #
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(wpa_network.network_object, condition)
+        condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
 =

         condition =3D 'obj.scanning'
         wd.wait_for_object_condition(device, condition)
@@ -99,14 +95,14 @@ class Test(unittest.TestCase):
         hotspot_network =3D device.get_ordered_network("ssidWPA2-1")
         self.assertEqual(hotspot_network.type, NetworkType.psk)
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(hotspot_network.network_object, condi=
tion)
-
-        sleep(2)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd_wpa.ifname)
 =

+        device.disconnect()
+
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_hotspot('autoconnect.conf')
-- =

2.13.6

--===============5318065141717333366==--

