Content-Type: multipart/mixed; boundary="===============5132327307998949986=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 09/26] auto-t: fix testSAE autoconnect_test.py
Date: Thu, 10 Sep 2020 11:58:38 -0700
Message-ID: <20200910185855.27833-9-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5132327307998949986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test was unreliable since it was assuming a periodic scan would
happen at just the right time. Instead since we are expecting autoconnect
we can just wait for DeviceState.connected then after we are connected
verify the network was correct.
---
 autotests/testSAE/autoconnect_test.py | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/auto=
connect_test.py
index a45fd09d..0613d91e 100644
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

-- =

2.21.3

--===============5132327307998949986==--

