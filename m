Content-Type: multipart/mixed; boundary="===============2143363417931655629=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] auto-t: add test for fixed scanning crash
Date: Tue, 08 Feb 2022 09:35:39 -0800
Message-ID: <20220208173539.493712-2-prestwoj@gmail.com>
In-Reply-To: 20220208173539.493712-1-prestwoj@gmail.com

--===============2143363417931655629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This simulates the conditions that trigger a free-after-use which was
fixed with:

2c355db7 ("scan: remove periodic scans from queue on abort")

This behavior can be reproduced reliably using this test with the above
patch reverted.
---
 autotests/testScan/remove_iface_test.py | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 autotests/testScan/remove_iface_test.py

diff --git a/autotests/testScan/remove_iface_test.py b/autotests/testScan/r=
emove_iface_test.py
new file mode 100644
index 00000000..af36c1e8
--- /dev/null
+++ b/autotests/testScan/remove_iface_test.py
@@ -0,0 +1,32 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+import os
+
+sys.path.append('../util')
+from iwd import IWD
+from config import ctx
+
+class Test(unittest.TestCase):
+    def test_connection_success(self):
+        wd =3D IWD(True)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        device.autoconnect =3D True
+        device.scan(wait=3DFalse)
+
+        os.system('ifconfig %s down' % device.name)
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
-- =

2.31.1

--===============2143363417931655629==--

