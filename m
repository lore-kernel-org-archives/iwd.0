Content-Type: multipart/mixed; boundary="===============0276539574872684106=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/6] test-runner: remove root user requirement from
 log/monitor/result
Date: Wed, 25 May 2022 12:37:24 -0700
Message-ID: <20220525193729.336896-1-prestwoj@gmail.com>

--===============0276539574872684106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Certain aspects of QEMU like mounting host directories may still require
root access but for UML this is not the case. To handle both cases first
check if SUDO_UID/GID are set and use those to obtain the actual users
ID's. Otherwise if running as non-root use the UID/GID of the user
directly.
---
 tools/runner.py | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index 1739b786..7c177f1f 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -305,18 +305,12 @@ class RunnerAbstract:
 =

 	# For QEMU/UML --log, --monitor, --result
 	def _prepare_outfiles(self):
-		gid =3D None
 		append_gid_uid =3D False
 =

-		if os.environ.get('SUDO_GID', None):
-			uid =3D int(os.environ['SUDO_UID'])
-			gid =3D int(os.environ['SUDO_GID'])
+		uid =3D int(os.environ.get('SUDO_UID', os.getuid()))
+		gid =3D int(os.environ.get('SUDO_GID', os.getgid()))
 =

 		if self.args.log:
-			if os.getuid() !=3D 0:
-				print("--log can only be used as root user")
-				quit()
-
 			append_gid_uid =3D True
 =

 			if not os.path.exists(self.args.log):
@@ -326,20 +320,12 @@ class RunnerAbstract:
 				os.chown(self.args.log, uid, gid)
 =

 		if self.args.monitor:
-			if os.getuid() !=3D 0:
-				print("--monitor can only be used as root user")
-				quit()
-
 			append_gid_uid =3D True
 =

 			self.args.monitor_parent =3D os.path.abspath(
 						os.path.join(self.args.monitor, os.pardir))
 =

 		if self.args.result:
-			if os.getuid() !=3D 0:
-				print("--result can only be used as root user")
-				quit()
-
 			append_gid_uid =3D True
 =

 			self.args.result_parent =3D os.path.abspath(
-- =

2.34.1

--===============0276539574872684106==--

