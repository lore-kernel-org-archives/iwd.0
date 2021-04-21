Content-Type: multipart/mixed; boundary="===============6119621627989636184=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: move AuthCenter to Setup/Tear down
Date: Wed, 21 Apr 2021 11:42:28 -0700
Message-ID: <20210421184228.2272285-2-prestwoj@gmail.com>
In-Reply-To: <20210421184228.2272285-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6119621627989636184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By moving the AuthCenter initializer to SetUpClass we can now
call stop() in TearDownClass which handles any exception the
test might throw.
---
 autotests/testEAP-AKA-ofono/connection_test.py     | 14 +++++---------
 .../testEAP-AKA-prime-ofono/connection_test.py     | 14 ++++----------
 autotests/testEAP-SIM-ofono/connection_test.py     | 14 +++++---------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/autotests/testEAP-AKA-ofono/connection_test.py b/autotests/tes=
tEAP-AKA-ofono/connection_test.py
index ff987709..e667aa8d 100644
--- a/autotests/testEAP-AKA-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-ofono/connection_test.py
@@ -12,10 +12,7 @@ from ofono import Ofono
 from config import ctx
 =

 class Test(unittest.TestCase):
-
     def test_connection_success(self):
-        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
         ofono =3D Ofono()
         ofono.enable_modem('/phonesim')
         ofono.wait_for_sim_auth()
@@ -40,11 +37,7 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        try:
-                ordered_network.network_object.connect()
-        except:
-                auth.stop()
-                raise
+        ordered_network.network_object.connect()
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -54,7 +47,6 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        auth.stop()
     @classmethod
     def setUpClass(cls):
         if not ctx.is_process_running('ofonod'):
@@ -62,9 +54,13 @@ class Test(unittest.TestCase):
 =

         IWD.copy_to_storage('ssidEAP-AKA.8021x')
 =

+        cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
 =

+        cls.auth.stop()
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-AKA-prime-ofono/connection_test.py b/autotes=
ts/testEAP-AKA-prime-ofono/connection_test.py
index 01dd8249..e6dfaee0 100644
--- a/autotests/testEAP-AKA-prime-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-prime-ofono/connection_test.py
@@ -12,10 +12,7 @@ from ofono import Ofono
 from config import ctx
 =

 class Test(unittest.TestCase):
-
     def test_connection_success(self):
-        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
         ofono =3D Ofono()
         ofono.enable_modem('/phonesim')
         ofono.wait_for_sim_auth()
@@ -40,11 +37,7 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        try:
-                ordered_network.network_object.connect()
-        except:
-                auth.stop()
-                raise
+        ordered_network.network_object.connect()
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -54,8 +47,6 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        auth.stop()
-
     @classmethod
     def setUpClass(cls):
         if not ctx.is_process_running('ofonod'):
@@ -63,9 +54,12 @@ class Test(unittest.TestCase):
 =

         IWD.copy_to_storage('ssidEAP-AKA.8021x')
 =

+        cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.auth.stop()
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-SIM-ofono/connection_test.py b/autotests/tes=
tEAP-SIM-ofono/connection_test.py
index dcb2dcbc..e6a2d290 100644
--- a/autotests/testEAP-SIM-ofono/connection_test.py
+++ b/autotests/testEAP-SIM-ofono/connection_test.py
@@ -14,8 +14,6 @@ from config import ctx
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
         ofono =3D Ofono()
         ofono.enable_modem('/phonesim')
         ofono.wait_for_sim_auth()
@@ -40,11 +38,7 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        try:
-                ordered_network.network_object.connect()
-        except:
-                auth.stop()
-                raise
+        ordered_network.network_object.connect()
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -54,8 +48,6 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        auth.stop()
-
     @classmethod
     def setUpClass(cls):
         if not ctx.is_process_running('ofonod'):
@@ -63,9 +55,13 @@ class Test(unittest.TestCase):
 =

         IWD.copy_to_storage('ssidEAP-SIM.8021x')
 =

+        cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
 =

+        cls.auth.stop()
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.26.2

--===============6119621627989636184==--

