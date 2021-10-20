Content-Type: multipart/mixed; boundary="===============2146546955422182863=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/4] auto-t: update blacklist test to use 'enable' on rules
Date: Wed, 20 Oct 2021 13:53:28 -0700
Message-ID: <20211020205331.734405-1-prestwoj@gmail.com>

--===============2146546955422182863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testBSSBlacklist/connection_test.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index bfcf0523..6a12174d 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -110,8 +110,11 @@ class Test(unittest.TestCase):
 =

         # Have both APs drop all packets, both should get blacklisted
         rule0.drop =3D True
+        rule0.enable =3D True
         rule1.drop =3D True
+        rule1.enable =3D True
         rule2.drop =3D True
+        rule2.enable =3D True
 =

         with self.assertRaises(iwd.FailedEx):
             ordered_network.network_object.connect()
-- =

2.31.1

--===============2146546955422182863==--

