Content-Type: multipart/mixed; boundary="===============6152559224188180344=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 08/13] auto-t: do full scan for testSAE
Date: Mon, 28 Mar 2022 10:28:37 -0700
Message-ID: <20220328172842.1660272-9-prestwoj@gmail.com>
In-Reply-To: 20220328172842.1660272-1-prestwoj@gmail.com

--===============6152559224188180344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will ensure the IWD scans until the network is found.
---
 autotests/testSAE/connection_test.py | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/conne=
ction_test.py
index 75f5c12d..c67f8c83 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -23,19 +23,7 @@ class Test(unittest.TestCase):
 =

         device.disconnect()
 =

-        wd.wait_for_object_condition(device, 'not obj.scanning')
-
-        device.debug_scan([2412])
-
-        wd.wait_for_object_condition(device, 'obj.scanning')
-        wd.wait_for_object_condition(device, 'not obj.scanning')
-
-        #
-        # An explicit scan was done prior due to hostapd options changing.
-        # Because of this scan_if_needed is set to False to avoid a redund=
ant
-        # scan
-        #
-        network =3D device.get_ordered_network('ssidSAE', scan_if_needed=
=3DFalse)
+        network =3D device.get_ordered_network('ssidSAE', full_scan=3DTrue)
 =

         self.assertEqual(network.type, NetworkType.psk)
 =

-- =

2.34.1

--===============6152559224188180344==--

