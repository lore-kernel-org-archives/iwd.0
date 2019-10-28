Content-Type: multipart/mixed; boundary="===============1199878601916851064=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: fix random failures in testEAP-MSCHAPV2
Date: Mon, 28 Oct 2019 12:52:00 -0700
Message-ID: <20191028195201.21904-2-prestwoj@gmail.com>
In-Reply-To: <20191028195201.21904-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1199878601916851064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Its difficult to know 100%, but this random test failures appeared
to be caused by two issues. One was that get_ordered_network is being
checked for None, when it was returning a zero length array. Because
of this the scanning block was never executed in any cases. This was
fixed in the previous commit. The other issue was the disconnect at
the start of the tests. The disconnect will cause all pending scans
to cancel, which appeared to cause the scanning block below to be
skipped over quickly if the timing was right. Then, afterwards,
getting a single network failed because scanning was not complete.
---
 autotests/testEAP-MSCHAPV2/connection_test.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/autotests/testEAP-MSCHAPV2/connection_test.py b/autotests/test=
EAP-MSCHAPV2/connection_test.py
index d38f4b09..35926375 100644
--- a/autotests/testEAP-MSCHAPV2/connection_test.py
+++ b/autotests/testEAP-MSCHAPV2/connection_test.py
@@ -19,11 +19,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        try:
-            device.disconnect()
-        except:
-            pass
-
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

-- =

2.17.1

--===============1199878601916851064==--

