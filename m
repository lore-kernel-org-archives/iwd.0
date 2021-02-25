Content-Type: multipart/mixed; boundary="===============1057702498946741846=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/17] auto-t: release radio/hostapd instances from cls
Date: Thu, 25 Feb 2021 14:00:54 -0800
Message-ID: <20210225220106.1728411-5-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1057702498946741846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The cls object is part of the unittest framework and its lifespan
is out of test-runner's control. Setting objects into the cls
object sometimes keeps those objects around longer than desired.
Its best to unset anything set in cls when the test is tore down.
---
 autotests/testEAP-WPS-Frag/wps_frag_test.py     | 1 +
 autotests/testEAP-WPS/four_digit_pin_test.py    | 1 +
 autotests/testEAP-WPS/pin_test.py               | 1 +
 autotests/testEAP-WPS/push_button_test.py       | 1 +
 autotests/testFT-8021x-roam/connection_test.py  | 2 ++
 autotests/testFT-FILS-SHA256/connection_test.py | 2 ++
 autotests/testFT-FILS-SHA384/connection_test.py | 3 +++
 autotests/testFT-PSK-over-DS/connection_test.py | 2 ++
 autotests/testFT-PSK-roam/connection_test.py    | 2 ++
 autotests/testFT-SAE-roam/connection_test.py    | 2 ++
 10 files changed, 17 insertions(+)

diff --git a/autotests/testEAP-WPS-Frag/wps_frag_test.py b/autotests/testEA=
P-WPS-Frag/wps_frag_test.py
index b9be0159..dcaf1ae2 100644
--- a/autotests/testEAP-WPS-Frag/wps_frag_test.py
+++ b/autotests/testEAP-WPS-Frag/wps_frag_test.py
@@ -38,6 +38,7 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.hostapd =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-WPS/four_digit_pin_test.py b/autotests/testE=
AP-WPS/four_digit_pin_test.py
index 10afaa5d..7bdb57cb 100644
--- a/autotests/testEAP-WPS/four_digit_pin_test.py
+++ b/autotests/testEAP-WPS/four_digit_pin_test.py
@@ -43,6 +43,7 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.hostapd =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-WPS/pin_test.py b/autotests/testEAP-WPS/pin_=
test.py
index 706dc20b..e2fef335 100644
--- a/autotests/testEAP-WPS/pin_test.py
+++ b/autotests/testEAP-WPS/pin_test.py
@@ -46,6 +46,7 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.hostapd =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-WPS/push_button_test.py b/autotests/testEAP-=
WPS/push_button_test.py
index f82a56b5..08463f15 100644
--- a/autotests/testEAP-WPS/push_button_test.py
+++ b/autotests/testEAP-WPS/push_button_test.py
@@ -41,6 +41,7 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.hostapd =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index c50c90ee..f83c430d 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -143,6 +143,8 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.bss_hostapd =3D None
+        cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-FILS-SHA256/connection_test.py b/autotests/te=
stFT-FILS-SHA256/connection_test.py
index 81201e08..c9e8ac7d 100644
--- a/autotests/testFT-FILS-SHA256/connection_test.py
+++ b/autotests/testFT-FILS-SHA256/connection_test.py
@@ -174,6 +174,8 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.bss_hostapd =3D None
+        cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-FILS-SHA384/connection_test.py b/autotests/te=
stFT-FILS-SHA384/connection_test.py
index 81201e08..0495d77e 100644
--- a/autotests/testFT-FILS-SHA384/connection_test.py
+++ b/autotests/testFT-FILS-SHA384/connection_test.py
@@ -174,6 +174,9 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.bss_hostapd =3D None
+        cls.bss_radio =3D None
+
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-PSK-over-DS/connection_test.py b/autotests/te=
stFT-PSK-over-DS/connection_test.py
index ad186d07..4c751841 100644
--- a/autotests/testFT-PSK-over-DS/connection_test.py
+++ b/autotests/testFT-PSK-over-DS/connection_test.py
@@ -147,6 +147,8 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.bss_hostapd =3D None
+        cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index c0eec0ae..37c6da18 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -140,6 +140,8 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.bss_hostapd =3D None
+        cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testFT-SAE-roam/connection_test.py b/autotests/testF=
T-SAE-roam/connection_test.py
index f2c694dd..da1ef731 100644
--- a/autotests/testFT-SAE-roam/connection_test.py
+++ b/autotests/testFT-SAE-roam/connection_test.py
@@ -197,6 +197,8 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.bss_hostapd =3D None
+        cls.bss_radio =3D None
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.26.2

--===============1057702498946741846==--

