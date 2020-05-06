Content-Type: multipart/mixed; boundary="===============0146818813715359399=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] auto-t: explicitly scan in testConnectAutoconnect
Date: Wed, 06 May 2020 10:39:48 -0700
Message-ID: <20200506173948.8581-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0146818813715359399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In certain cases the autoconnect portion of each subtest was connecting
to the network so fast that the check for obj.scanning was never successful
since IWD was already connected (and in turn not scanning). Since the
autoconnect path will wait for the device to be connected there really isn't
a reason to wait for any scanning conditions. The normal connect path does
need to wait for scanning though, and for this an explicit call to scan was
added to ensure the network list gets populated.
---
 autotests/testConnectAutoconnect/validation.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/autotests/testConnectAutoconnect/validation.py b/autotests/tes=
tConnectAutoconnect/validation.py
index 43cbaf02..757a88ab 100644
--- a/autotests/testConnectAutoconnect/validation.py
+++ b/autotests/testConnectAutoconnect/validation.py
@@ -12,6 +12,14 @@ from iwd import NetworkType
 class TestConnectAutoConnect(unittest.TestCase):
 =

     def check_connect(self, wd, device, ssid, throws):
+        device.scan()
+
+        condition =3D 'obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
         ordered_network =3D device.get_ordered_network(ssid)
 =

         condition =3D 'not obj.connected'
@@ -54,12 +62,6 @@ class TestConnectAutoConnect(unittest.TestCase):
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

--===============0146818813715359399==--

