Content-Type: multipart/mixed; boundary="===============7587604044301170110=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 4/4] auto-t: add oper class/band tests for OWE transition
Date: Wed, 22 Sep 2021 12:34:18 -0700
Message-ID: <20210922193418.13072-4-prestwoj@gmail.com>
In-Reply-To: 20210922193418.13072-1-prestwoj@gmail.com

--===============7587604044301170110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testOWE-transition/connection_test.py     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/autotests/testOWE-transition/connection_test.py b/autotests/te=
stOWE-transition/connection_test.py
index 7240e3a8..9555766e 100644
--- a/autotests/testOWE-transition/connection_test.py
+++ b/autotests/testOWE-transition/connection_test.py
@@ -196,6 +196,30 @@ class Test(unittest.TestCase):
         with self.assertRaises(iwd.NotFoundEx):
             self.validate(self.wd, self.hapd_owe, connect_hidden=3DTrue)
 =

+    def test_owe_transition_band_info(self):
+        self.hapd_open.set_value('vendor_elements', 'dd17506f9a1c02000000f=
1000a6f77652d68696464656e5103')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.set_value('channel', '3')
+        self.hapd_owe.reload()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        self.validate(self.wd, self.hapd_owe)
+
+    def test_owe_transition_wrong_band_info(self):
+        self.hapd_open.set_value('vendor_elements', 'dd17506f9a1c02000000f=
1000a6f77652d68696464656e5102')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.set_value('channel', '3')
+        self.hapd_owe.reload()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        self.validate(self.wd, self.hapd_open)
+
     def setUp(self):
         self.wd =3D IWD(True)
         self.hapd_owe =3D HostapdCLI(config=3D'ssidOWE.conf')
@@ -206,6 +230,8 @@ class Test(unittest.TestCase):
     def tearDown(self):
         IWD.clear_storage()
 =

+        self.hapd_owe.set_value('channel', '1')
+
         self.wd =3D None
         self.hapd_open =3D None
         self.hapd_owe =3D None
-- =

2.31.1

--===============7587604044301170110==--

