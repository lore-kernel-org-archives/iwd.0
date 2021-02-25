Content-Type: multipart/mixed; boundary="===============4097156059147006806=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/17] auto-t: testEAD: stop ead when test finishes
Date: Thu, 25 Feb 2021 14:00:50 -0800
Message-ID: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4097156059147006806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testEAD/connection_test.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/autotests/testEAD/connection_test.py b/autotests/testEAD/conne=
ction_test.py
index bdf242b6..7f23f0d6 100644
--- a/autotests/testEAD/connection_test.py
+++ b/autotests/testEAD/connection_test.py
@@ -3,6 +3,7 @@
 import unittest
 import sys
 import os
+import shutil
 =

 sys.path.append('../util')
 from iwd import IWD
@@ -14,7 +15,7 @@ class Test(unittest.TestCase):
     def test_connection_success(self):
         env =3D os.environ.copy()
         env['STATE_DIRECTORY'] =3D '/tmp/ead'
-        ctx.start_process(['ead', '-i', 'eth1', '-d'], env=3Denv)
+        p =3D ctx.start_process(['ead', '-i', 'eth1', '-d'], env=3Denv)
 =

         ead =3D EAD()
 =

@@ -26,6 +27,7 @@ class Test(unittest.TestCase):
         condition =3D 'obj.authenticated =3D=3D True'
         ead.wait_for_object_condition(adapter, condition)
 =

+        ctx.stop_process(p)
     @classmethod
     def setUpClass(cls):
         os.mkdir('/tmp/ead')
@@ -36,5 +38,7 @@ class Test(unittest.TestCase):
     def tearDownClass(cls):
         IWD.clear_storage(storage_dir=3D'/tmp/ead')
 =

+        shutil.rmtree('/tmp/ead')
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.26.2

--===============4097156059147006806==--

