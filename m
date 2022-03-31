Content-Type: multipart/mixed; boundary="===============6934431294506223955=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 09/14] auto-t: fix testBSSBlacklist typo
Date: Thu, 31 Mar 2022 16:16:36 -0700
Message-ID: <20220331231641.484200-9-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============6934431294506223955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The property is 'enabled' not 'enable'
---
 autotests/testBSSBlacklist/connection_test.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 8e239f44..9631a322 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -110,11 +110,11 @@ class Test(unittest.TestCase):
 =

         # Have both APs drop all packets, both should get blacklisted
         rule0.drop =3D True
-        rule0.enable =3D True
+        rule0.enabled =3D True
         rule1.drop =3D True
-        rule1.enable =3D True
+        rule1.enabled =3D True
         rule2.drop =3D True
-        rule2.enable =3D True
+        rule2.enabled =3D True
 =

         with self.assertRaises(iwd.FailedEx):
             ordered_network.network_object.connect()
-- =

2.34.1

--===============6934431294506223955==--

