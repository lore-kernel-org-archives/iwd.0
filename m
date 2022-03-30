Content-Type: multipart/mixed; boundary="===============7040748121747831601=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: use full_scan=True on testBSSBlacklist
Date: Wed, 30 Mar 2022 14:17:59 -0700
Message-ID: <20220330211759.1948562-1-prestwoj@gmail.com>

--===============7040748121747831601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test was missed during the test-wide change.
---
 autotests/testBSSBlacklist/connection_test.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 1bc9e604..8e239f44 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -101,7 +101,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        ordered_network =3D device.get_ordered_network("TestBlacklist")
+        ordered_network =3D device.get_ordered_network("TestBlacklist", fu=
ll_scan=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -148,7 +148,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        ordered_network =3D device.get_ordered_network("TestBlacklist")
+        ordered_network =3D device.get_ordered_network("TestBlacklist", fu=
ll_scan=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -188,7 +188,7 @@ class Test(unittest.TestCase):
 =

         devices[1].disconnect()
 =

-        ordered_network =3D device.get_ordered_network("TestBlacklist")
+        ordered_network =3D device.get_ordered_network("TestBlacklist", fu=
ll_scan=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

-- =

2.34.1

--===============7040748121747831601==--

