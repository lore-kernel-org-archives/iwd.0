Content-Type: multipart/mixed; boundary="===============5622262651363392962=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 25/26] auto-t: fix testPreauth-roam
Date: Thu, 10 Sep 2020 11:58:54 -0700
Message-ID: <20200910185855.27833-25-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5622262651363392962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changed to wait for DeviceState instead of network object as well
as moved hwsim rules ahead of the IWD initializer to avoid IWD
scanning before the rules are fully in place.
---
 autotests/testPreauth-roam/connection_test.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/test=
Preauth-roam/connection_test.py
index 839e04b0..5eee3078 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -44,14 +44,14 @@ class Test(unittest.TestCase):
         bss_hostapd[1].set_neighbor(bss_radio[0].addresses[0], 'TestPreaut=
h',
                 bss0_nr)
 =

-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
-
         # Check that iwd selects BSS 0 first
         rule0.signal =3D -2500
         rule1.signal =3D -3500
 =

+        wd =3D IWD()
+
+        device =3D wd.list_devices(1)[0]
+
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

@@ -76,8 +76,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(bss_hostapd[0].list_sta())
         self.assertFalse(bss_hostapd[1].list_sta())
-- =

2.21.3

--===============5622262651363392962==--

