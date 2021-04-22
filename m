Content-Type: multipart/mixed; boundary="===============4274472585686107079=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] auto-t: add more cleanup to ofono based tests (again)
Date: Thu, 22 Apr 2021 10:37:43 -0700
Message-ID: <20210422173746.2324850-4-prestwoj@gmail.com>
In-Reply-To: <20210422173746.2324850-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4274472585686107079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The AuthCenter was still not being fully cleaned up in these
tests. It was being stopped but there was still a reference being
held which prevented __del__ from being called.
---
 autotests/testEAP-AKA-ofono/connection_test.py       |  1 +
 autotests/testEAP-AKA-prime-ofono/connection_test.py |  1 +
 autotests/testEAP-PEAP-SIM/connection_test.py        | 12 ++++++------
 autotests/testEAP-SIM-ofono/connection_test.py       |  1 +
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/autotests/testEAP-AKA-ofono/connection_test.py b/autotests/tes=
tEAP-AKA-ofono/connection_test.py
index e667aa8d..7b1a8c37 100644
--- a/autotests/testEAP-AKA-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-ofono/connection_test.py
@@ -61,6 +61,7 @@ class Test(unittest.TestCase):
         IWD.clear_storage()
 =

         cls.auth.stop()
+        cls.auth =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-AKA-prime-ofono/connection_test.py b/autotes=
ts/testEAP-AKA-prime-ofono/connection_test.py
index e6dfaee0..dc8f04bf 100644
--- a/autotests/testEAP-AKA-prime-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-prime-ofono/connection_test.py
@@ -60,6 +60,7 @@ class Test(unittest.TestCase):
     def tearDownClass(cls):
         IWD.clear_storage()
         cls.auth.stop()
+        cls.auth =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAP-SIM/connection_test.py b/autotests/test=
EAP-PEAP-SIM/connection_test.py
index 37398c15..4183e65e 100644
--- a/autotests/testEAP-PEAP-SIM/connection_test.py
+++ b/autotests/testEAP-PEAP-SIM/connection_test.py
@@ -44,26 +44,26 @@ class Test(unittest.TestCase):
 =

 =

     def test_connection_success(self):
-        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
         ofono =3D Ofono()
         ofono.enable_modem('/phonesim')
         ofono.wait_for_sim_auth()
 =

         wd =3D IWD(True)
 =

-        try:
-            self.validate_connection(wd)
-        finally:
-            auth.stop()
+        self.validate_connection(wd)
 =

     @classmethod
     def setUpClass(cls):
+        cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
+
         IWD.copy_to_storage('ssidEAP-PEAP-SIM.8021x')
 =

     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
 =

+        cls.auth.stop()
+        cls.auth =3D None
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-SIM-ofono/connection_test.py b/autotests/tes=
tEAP-SIM-ofono/connection_test.py
index e6a2d290..9f5f2734 100644
--- a/autotests/testEAP-SIM-ofono/connection_test.py
+++ b/autotests/testEAP-SIM-ofono/connection_test.py
@@ -62,6 +62,7 @@ class Test(unittest.TestCase):
         IWD.clear_storage()
 =

         cls.auth.stop()
+        cls.auth =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.26.2

--===============4274472585686107079==--

