Content-Type: multipart/mixed; boundary="===============5567026405170847771=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/2] auto-t: use scan_if_needed for testConnectAutoconnect
Date: Wed, 06 May 2020 12:35:02 -0700
Message-ID: <20200506193502.14443-2-prestwoj@gmail.com>
In-Reply-To: <20200506193502.14443-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5567026405170847771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In certain cases the autoconnect portion of each subtest was connecting
to the network so fast that the check for obj.scanning was never successful
since IWD was already connected (and in turn not scanning). Since the
autoconnect path will wait for the device to be connected there really isn't
a reason to wait for any scanning conditions. The normal connect path does
need to wait for scanning though, and for this we can now use the new
scan_if_needed parameter to get_ordered_networks.
---
 autotests/testConnectAutoconnect/validation.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/autotests/testConnectAutoconnect/validation.py b/autotests/tes=
tConnectAutoconnect/validation.py
index 43cbaf02..6db479a9 100644
--- a/autotests/testConnectAutoconnect/validation.py
+++ b/autotests/testConnectAutoconnect/validation.py
@@ -12,7 +12,7 @@ from iwd import NetworkType
 class TestConnectAutoConnect(unittest.TestCase):
 =

     def check_connect(self, wd, device, ssid, throws):
-        ordered_network =3D device.get_ordered_network(ssid)
+        ordered_network =3D device.get_ordered_network(ssid, scan_if_neede=
d=3DTrue)
 =

         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
@@ -54,12 +54,6 @@ class TestConnectAutoConnect(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         if autoconnect:
             self.check_autoconnect(wd, device, ssid, throws)
         else:
-- =

2.21.1

--===============5567026405170847771==--

