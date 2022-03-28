Content-Type: multipart/mixed; boundary="===============4931794287715047114=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 10/13] auto-t: do a full scan when getting network
Date: Mon, 28 Mar 2022 10:28:39 -0700
Message-ID: <20220328172842.1660272-11-prestwoj@gmail.com>
In-Reply-To: 20220328172842.1660272-1-prestwoj@gmail.com

--===============4931794287715047114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This ensures the network will be scanned for again if not found.
---
 autotests/testOWE-transition/connection_test.py | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/autotests/testOWE-transition/connection_test.py b/autotests/te=
stOWE-transition/connection_test.py
index aeaea70a..ff5ea811 100644
--- a/autotests/testOWE-transition/connection_test.py
+++ b/autotests/testOWE-transition/connection_test.py
@@ -20,18 +20,7 @@ class Test(unittest.TestCase):
 =

         if not autoconnect:
             if not connect_hidden:
-                condition =3D 'not obj.scanning'
-                wd.wait_for_object_condition(device, condition)
-
-                device.scan()
-
-                condition =3D 'obj.scanning'
-                wd.wait_for_object_condition(device, condition)
-
-                condition =3D 'not obj.scanning'
-                wd.wait_for_object_condition(device, condition)
-
-                network =3D device.get_ordered_network('transition', scan_=
if_needed=3DFalse)
+                network =3D device.get_ordered_network('transition', full_=
scan=3DTrue)
 =

                 network.network_object.connect()
             else:
-- =

2.34.1

--===============4931794287715047114==--

