Content-Type: multipart/mixed; boundary="===============0972082117748039833=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: remove requirement for /var/lib/{ead,iwd}
Date: Wed, 14 Oct 2020 09:55:57 -0700
Message-ID: <20201014165557.199884-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0972082117748039833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The host systems configuration directories for IWD/EAD were
being mounted in the virtual machine. This required that the
host create these directories before hand. Instead we can
just set up the system and IWD/EAD to use directories in /tmp
that we create when we start the VM. This avoids the need for
any host configuration.
---
 autotests/testEAD/connection_test.py | 11 ++++++++---
 autotests/util/iwd.py                | 10 +++++-----
 tools/test-runner                    |  6 +++---
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/autotests/testEAD/connection_test.py b/autotests/testEAD/conne=
ction_test.py
index c51d7237..bdf242b6 100644
--- a/autotests/testEAD/connection_test.py
+++ b/autotests/testEAD/connection_test.py
@@ -2,6 +2,7 @@
 =

 import unittest
 import sys
+import os
 =

 sys.path.append('../util')
 from iwd import IWD
@@ -11,7 +12,9 @@ from ead import EAD
 =

 class Test(unittest.TestCase):
     def test_connection_success(self):
-        ctx.start_process(['ead', '-i', 'eth1', '-d'])
+        env =3D os.environ.copy()
+        env['STATE_DIRECTORY'] =3D '/tmp/ead'
+        ctx.start_process(['ead', '-i', 'eth1', '-d'], env=3Denv)
 =

         ead =3D EAD()
 =

@@ -25,11 +28,13 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
-        IWD.copy_to_storage('default.8021x', storage_dir=3D'/var/lib/ead')
+        os.mkdir('/tmp/ead')
+
+        IWD.copy_to_storage('default.8021x', storage_dir=3D'/tmp/ead')
 =

     @classmethod
     def tearDownClass(cls):
-        IWD.clear_storage()
+        IWD.clear_storage(storage_dir=3D'/tmp/ead')
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index ef843a95..76d96289 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -17,8 +17,8 @@ from enum import Enum
 =

 from config import ctx
 =

-IWD_STORAGE_DIR =3D               '/var/lib/iwd'
-IWD_CONFIG_DIR =3D                '/etc/iwd'
+IWD_STORAGE_DIR =3D               '/tmp/iwd'
+IWD_CONFIG_DIR =3D                '/tmp'
 =

 DBUS_OBJECT_MANAGER =3D           'org.freedesktop.DBus.ObjectManager'
 DBUS_PROPERTIES =3D               'org.freedesktop.DBus.Properties'
@@ -909,9 +909,9 @@ class IWD(AsyncOpAbstract):
                 GLib.source_remove(timeout)
 =

     @staticmethod
-    def clear_storage():
-        os.system('rm -rf ' + IWD_STORAGE_DIR + '/*')
-        os.system('rm -rf ' + IWD_STORAGE_DIR + '/hotspot/*')
+    def clear_storage(storage_dir=3DIWD_STORAGE_DIR):
+        os.system('rm -rf ' + storage_dir + '/*')
+        os.system('rm -rf ' + storage_dir + '/hotspot/*')
 =

     @staticmethod
     def create_in_storage(file_name, file_content):
diff --git a/tools/test-runner b/tools/test-runner
index 3b9c1854..809a3905 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -112,8 +112,6 @@ mount_table =3D [
 	MountInfo('devpts', '/dev/pts', 'mode=3D0620', MS_NOSUID|MS_NOEXEC),
 	MountInfo('tmpfs', '/dev/shm', 'mode=3D1777', MS_NOSUID|MS_NODEV|MS_STRIC=
TATIME),
 	MountInfo('tmpfs', '/run', 'mode=3D0755', MS_NOSUID|MS_NODEV|MS_STRICTATI=
ME),
-	MountInfo('tmpfs', '/var/lib/iwd', 'mode=3D0755', 0),
-	MountInfo('tmpfs', '/var/lib/ead', 'mode=3D0755', 0),
 	MountInfo('tmpfs', '/tmp', '', 0),
 	MountInfo('tmpfs', '/usr/share/dbus-1', 'mode=3D0755', MS_NOSUID|MS_NOEXE=
C|MS_NODEV|MS_STRICTATIME),
 	MountInfo('debugfs', '/sys/kernel/debug', '', 0)
@@ -572,7 +570,7 @@ class TestContext:
 =

 		env =3D os.environ.copy()
 		env['CONFIGURATION_DIRECTORY'] =3D config_dir
-		env['STATE_DIRECTORY'] =3D '/var/lib/iwd'
+		env['STATE_DIRECTORY'] =3D '/tmp/iwd'
 =

 		if self.is_verbose('iwd-dhcp'):
 			env['IWD_DHCP_DEBUG'] =3D '1'
@@ -742,6 +740,8 @@ def prepare_sandbox():
 	for entry in dev_table:
 		os.symlink(entry.target, entry.linkpath)
 =

+	os.mkdir('/tmp/iwd')
+
 	os.setsid()
 =

 	fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
-- =

2.26.2

--===============0972082117748039833==--

