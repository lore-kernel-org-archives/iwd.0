Content-Type: multipart/mixed; boundary="===============6797305132676802442=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 22/26] auto-t: fix testAPRoam
Date: Thu, 10 Sep 2020 11:58:51 -0700
Message-ID: <20200910185855.27833-22-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6797305132676802442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test occationally fails due to no hwsim rules. Basically we
were just expecting iwd to connect to one of 3 access points but
the ranking was equal, so it chose the first in the scan list.

Now a signal strength is assigned to each AP to steer IWD into
connecting to the expected AP.
---
 autotests/testAPRoam/connection_test.py | 29 +++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam=
/connection_test.py
index 308bbc28..3f6296b7 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -24,6 +24,22 @@ class Test(unittest.TestCase):
                        hwsim.get_radio('rad1'),
                        hwsim.get_radio('rad2') ]
 =

+        rule0 =3D hwsim.rules.create()
+        rule0.source =3D bss_radio[0].addresses[0]
+        rule0.bidirectional =3D True
+
+        rule1 =3D hwsim.rules.create()
+        rule1.source =3D bss_radio[1].addresses[0]
+        rule1.bidirectional =3D True
+
+        rule2 =3D hwsim.rules.create()
+        rule2.source =3D bss_radio[2].addresses[0]
+        rule2.bidirectional =3D True
+
+        rule0.signal =3D -2000
+        rule1.signal =3D -2500
+        rule2.signal =3D -3000
+
         wd =3D IWD()
 =

         psk_agent =3D PSKAgent("secret123")
@@ -49,8 +65,10 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED')
 =

         self.assertTrue(bss_hostapd[0].list_sta())
         self.assertFalse(bss_hostapd[1].list_sta())
@@ -65,6 +83,9 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state !=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
 =

+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(bss_hostapd[1].list_sta())
         device.disconnect()
@@ -74,6 +95,10 @@ class Test(unittest.TestCase):
 =

         wd.unregister_psk_agent(psk_agent)
 =

+        rule0.remove()
+        rule1.remove()
+        rule2.remove()
+
     @classmethod
     def setUpClass(cls):
         pass
-- =

2.21.3

--===============6797305132676802442==--

