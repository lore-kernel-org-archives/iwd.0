Content-Type: multipart/mixed; boundary="===============6310954867573922890=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] auto-t: add auth/assoc timeouts to testOWE
Date: Mon, 05 Apr 2021 15:40:27 -0700
Message-ID: <20210405224027.1052197-5-prestwoj@gmail.com>
In-Reply-To: <20210405224027.1052197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6310954867573922890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testOWE/timeout_test.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/autotests/testOWE/timeout_test.py b/autotests/testOWE/timeout_=
test.py
index d02432e9..39c2d429 100644
--- a/autotests/testOWE/timeout_test.py
+++ b/autotests/testOWE/timeout_test.py
@@ -45,6 +45,14 @@ class Test(unittest.TestCase):
         rule0.source =3D bss_radio.addresses[0]
         rule0.bidirectional =3D True
         rule0.drop =3D True
+        rule0.prefix =3D 'b0'
+
+        # Test Authenticate (b0) and Association (00) timeouts
+
+        with self.assertRaises(iwd.FailedEx):
+            ordered_network.network_object.connect()
+
+        rule0.prefix =3D '00'
 =

         with self.assertRaises(iwd.FailedEx):
             ordered_network.network_object.connect()
-- =

2.26.2

--===============6310954867573922890==--

