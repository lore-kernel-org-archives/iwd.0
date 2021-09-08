Content-Type: multipart/mixed; boundary="===============1569432855650915150=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] auto-t: change testSAE timeout_test to use prefix_offset
Date: Wed, 08 Sep 2021 15:47:42 -0700
Message-ID: <20210908224744.102156-3-prestwoj@gmail.com>
In-Reply-To: <20210908224744.102156-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1569432855650915150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes things more clear on what frames are being blocked
since it passes over header information to get to the actual
SAE payload.
---
 autotests/testSAE/timeout_test.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_=
test.py
index 1792f1c0..263f4e28 100644
--- a/autotests/testSAE/timeout_test.py
+++ b/autotests/testSAE/timeout_test.py
@@ -49,7 +49,8 @@ class Test(unittest.TestCase):
         rule0 =3D hwsim.rules.create()
         rule0.source =3D bss_radio.addresses[0]
         rule0.drop =3D True
-        rule0.prefix =3D 'b0'
+        rule0.prefix =3D '01 00 00 00 13 00'
+        rule0.prefix_offset =3D 26
         rule0.match_times =3D 1
         rule0.drop_ack =3D True
         rule0.enabled =3D True
@@ -57,6 +58,8 @@ class Test(unittest.TestCase):
         wd =3D IWD(True)
         self.validate_connection(wd)
 =

+        rule0.remove()
+
     @classmethod
     def setUpClass(cls):
         pass
-- =

2.31.1

--===============1569432855650915150==--

