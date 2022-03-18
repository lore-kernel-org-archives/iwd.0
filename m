Content-Type: multipart/mixed; boundary="===============7376518049209078898=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: remove waitstatus_to_exitcode for better compatibility
Date: Fri, 18 Mar 2022 16:26:54 -0700
Message-ID: <20220318232654.759228-1-prestwoj@gmail.com>

--===============7376518049209078898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was added in Python 3.9 which isn't always supported. Instead use
the old way of checking the return status.
---
 autotests/testNetconfig/connection_test.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 8eeffbbd..17788011 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -41,7 +41,8 @@ class Test(unittest.TestCase):
 =

         time.sleep(2)
         ret =3D os.system('ip addr show ' + device.name + ' | grep \'inet6=
 3ffe:501:ffff:100::\'')
-        self.assertEqual(os.waitstatus_to_exitcode(ret), 0)
+        self.assertTrue(os.WIFEXITED(ret))
+        self.assertEqual(os.WEXITSTATUS(ret), 0)
 =

         device.disconnect()
 =

-- =

2.34.1

--===============7376518049209078898==--

