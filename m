Content-Type: multipart/mixed; boundary="===============3047702464566579238=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/15] auto-t: fix testSAE autoconnect_test.py
Date: Fri, 28 Aug 2020 09:40:45 -0700
Message-ID: <20200828164050.1456-11-prestwoj@gmail.com>
In-Reply-To: <20200828164050.1456-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3047702464566579238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test was unreliable since it was assuming a periodic scan would
happen at just the right time. Instead since we are expecting autoconnect
we can just wait for DeviceState.connected then after we are connected
verify the network was correct.
---
 autotests/testSAE/autoconnect_test.py | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/auto=
connect_test.py
index a45fd09d..2eb73b7f 100644
--- a/autotests/testSAE/autoconnect_test.py
+++ b/autotests/testSAE/autoconnect_test.py
@@ -23,20 +23,15 @@ class Test(unittest.TestCase):
         devices[2].disconnect()
         devices[3].disconnect()
 =

-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition, 30)
 =

-        condition =3D 'not obj.scanning'
+        condition =3D 'obj.connected_network is not None'
         wd.wait_for_object_condition(device, condition)
 =

         ordered_network =3D device.get_ordered_network('ssidSAE')
 =

-        self.assertEqual(ordered_network.type, NetworkType.psk)
-
-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        device.wait_for_connected()
+        self.assertTrue(ordered_network.network_object.connected)
 =

         device.disconnect()
 =

@@ -44,7 +39,7 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

     def test_connection_success(self):
-        wd =3D IWD(True)
+        wd =3D IWD()
 =

         self.validate_connection(wd)
 =

-- =

2.21.1

--===============3047702464566579238==--

