Content-Type: multipart/mixed; boundary="===============0278542906851613646=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 18/26] auto-t: update testClientNonInteractive to use
 TestContext
Date: Thu, 10 Sep 2020 11:58:47 -0700
Message-ID: <20200910185855.27833-18-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0278542906851613646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes any iwctl output hidden unless enabled via the verbose
option.
---
 .../connect_command_test.py                   | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/autotests/testClientNonInteractive/connect_command_test.py b/a=
utotests/testClientNonInteractive/connect_command_test.py
index 886d7a76..a503bd24 100644
--- a/autotests/testClientNonInteractive/connect_command_test.py
+++ b/autotests/testClientNonInteractive/connect_command_test.py
@@ -8,6 +8,7 @@ import iwd
 from iwd import IWD
 import testutil
 import subprocess
+from config import ctx
 =

 class Test(unittest.TestCase):
 =

@@ -34,11 +35,10 @@ class Test(unittest.TestCase):
 =

         # Use --dontaks cmd-line option
         with self.assertRaises(subprocess.CalledProcessError):
-                        subprocess.check_call(['iwctl', '-d', 'station',
-                                                 device.name, 'connect', s=
sid])
+            ctx.start_process(['iwctl', 'd', 'station', device.name, 'conn=
ect', ssid],  check=3DTrue)
 =

-        subprocess.check_call(['iwctl', '-P', 'passphrase',
-                                'station', device.name, 'connect', ssid])
+        ctx.start_process(['iwctl', '-P', 'passphrase', 'station', device.=
name, 'connect', ssid],
+                                check=3DTrue)
 =

         self.check_connection_success(ssid)
 =

@@ -47,9 +47,8 @@ class Test(unittest.TestCase):
 =

         device =3D self.wd.list_devices(1)[0]
 =

-        subprocess.check_call(['iwctl', '-u', 'user', '-p', 'password',
-                                'station', device.name, 'connect', ssid])
-
+        ctx.start_process(['iwctl', '-u', 'user', '-p', 'password', 'stati=
on', \
+                            device.name, 'connect', ssid], check=3DTrue)
         self.check_connection_success(ssid)
 =

     def test_connection_with_password(self):
@@ -57,8 +56,8 @@ class Test(unittest.TestCase):
 =

         device =3D self.wd.list_devices(1)[0]
 =

-        subprocess.check_call(['iwctl', '-p', 'password',
-                                'station', device.name, 'connect', ssid])
+        ctx.start_process(['iwctl', '-p', 'password', 'station', device.na=
me, 'connect', ssid],
+                            check=3DTrue)
 =

         self.check_connection_success(ssid)
 =

@@ -68,8 +67,8 @@ class Test(unittest.TestCase):
         device =3D self.wd.list_devices(1)[0]
 =

         with self.assertRaises(subprocess.CalledProcessError):
-                subprocess.check_call(['iwctl', '-P', 'incorrect_passphras=
e',
-                                'station', device.name, 'connect', ssid])
+            ctx.start_process(['iwctl', '-P', 'incorrect_passphrase', 'sta=
tion', device.name, \
+                                'connect', ssid], check=3DTrue)
 =

     def test_invalid_command_line_option(self):
         ssid =3D 'ssidPassphrase'
@@ -77,14 +76,13 @@ class Test(unittest.TestCase):
         device =3D self.wd.list_devices(1)[0]
 =

         with self.assertRaises(subprocess.CalledProcessError):
-                subprocess.check_call(['iwctl', '-z',
-                                'station', device.name, 'connect', ssid])
+            ctx.start_process(['iwctl', '-z', 'station', device.name, 'con=
nect', ssid], check=3DTrue)
 =

     def test_invalid_command(self):
         device =3D self.wd.list_devices(1)[0]
 =

         with self.assertRaises(subprocess.CalledProcessError):
-                subprocess.check_call(['iwctl', 'inexistent', 'command'])
+            ctx.start_process(['iwctl', 'inexistent', 'command'], check=3D=
True)
 =

     @classmethod
     def setUpClass(cls):
-- =

2.21.3

--===============0278542906851613646==--

