Content-Type: multipart/mixed; boundary="===============6262960648193714158=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/6] auto-t: fix testSAE to continue if a test fails
Date: Tue, 28 Sep 2021 15:36:07 -0700
Message-ID: <20210928223609.1163537-4-prestwoj@gmail.com>
In-Reply-To: 20210928223609.1163537-1-prestwoj@gmail.com

--===============6262960648193714158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testSAE/connection_test.py | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/conne=
ction_test.py
index 88aa077e..75f5c12d 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -62,9 +62,7 @@ class Test(unittest.TestCase):
         self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
-        wd =3D IWD(True)
-        self.validate_connection(wd)
-        wd.clear_storage()
+        self.validate_connection(self.wd)
 =

     def test_SAE_force_group_19(self):
         self.hostapd.set_value('sae_pwe', '0')
@@ -74,9 +72,7 @@ class Test(unittest.TestCase):
         self.hostapd.set_value('vendor_elements', 'dd0cf4f5e80505000000000=
00000')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
-        wd =3D IWD(True)
-        self.validate_connection(wd)
-        wd.clear_storage()
+        self.validate_connection(self.wd)
 =

     def test_SAE_Group20(self):
         self.hostapd.set_value('sae_pwe', '0')
@@ -84,9 +80,7 @@ class Test(unittest.TestCase):
         self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
-        wd =3D IWD(True)
-        self.validate_connection(wd)
-        wd.clear_storage()
+        self.validate_connection(self.wd)
 =

     def test_SAE_H2E(self):
         self.hostapd.set_value('sae_pwe', '1')
@@ -94,9 +88,7 @@ class Test(unittest.TestCase):
         self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
-        wd =3D IWD(True)
-        self.validate_connection(wd)
-        wd.clear_storage()
+        self.validate_connection(self.wd)
 =

     def test_SAE_H2E_Group20(self):
         self.hostapd.set_value('sae_pwe', '1')
@@ -104,9 +96,14 @@ class Test(unittest.TestCase):
         self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
-        wd =3D IWD(True)
-        self.validate_connection(wd)
-        wd.clear_storage()
+        self.validate_connection(self.wd)
+
+    def setUp(self):
+        self.wd =3D IWD(True)
+
+    def tearDown(self):
+        self.wd.clear_storage()
+        self.wd =3D None
 =

     @classmethod
     def setUpClass(cls):
-- =

2.31.1

--===============6262960648193714158==--

