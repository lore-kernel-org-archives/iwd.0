Content-Type: multipart/mixed; boundary="===============1526162708526832614=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 03/13] auto-t: remove waitstatus_to_exitcode for better
 compatibility
Date: Mon, 28 Mar 2022 10:28:32 -0700
Message-ID: <20220328172842.1660272-4-prestwoj@gmail.com>
In-Reply-To: 20220328172842.1660272-1-prestwoj@gmail.com

--===============1526162708526832614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was added in Python 3.9 which isn't always supported. Instead use
the subprocess module which automatically checks the command output.
---
 autotests/testNetconfig/connection_test.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 8eeffbbd..91c6eb6b 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -12,6 +12,7 @@ from hostapd import HostapdCLI
 import testutil
 from config import ctx
 import os, time
+import subprocess
 =

 class Test(unittest.TestCase):
 =

@@ -40,8 +41,8 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected()
 =

         time.sleep(2)
-        ret =3D os.system('ip addr show ' + device.name + ' | grep \'inet6=
 3ffe:501:ffff:100::\'')
-        self.assertEqual(os.waitstatus_to_exitcode(ret), 0)
+        subprocess.check_output('ip addr show ' + device.name + \
+                            ' | grep \'inet6 3ffe:501:ffff:100::\'', shell=
=3DTrue)
 =

         device.disconnect()
 =

-- =

2.34.1

--===============1526162708526832614==--

