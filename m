Content-Type: multipart/mixed; boundary="===============2653349549683470215=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] test-runner: Don't require SUDO_GID to be set for logs
Date: Wed, 30 Mar 2022 19:33:59 +0200
Message-ID: <20220330173400.259961-3-andrew.zaborowski@intel.com>
In-Reply-To: 20220330173400.259961-1-andrew.zaborowski@intel.com

--===============2653349549683470215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Base the root user check on os.getuid() instead of SUDO_GID so as not to
implicitly require sudo.  SUDO_GID being set doesn't guarantee that the
effective user is root either since you can sudo to non-root accounts.
---
 tools/test-runner | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 4ab42317..b443d91e 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -276,13 +276,16 @@ class Process(subprocess.Popen):
 		return True
 =

 	def _append_outfile(self, file, append=3DTrue):
-		gid =3D int(self.ctx.args.log_gid)
-		uid =3D int(self.ctx.args.log_uid)
 		dir =3D os.path.dirname(file)
 =

+		if self.ctx.args.log_gid:
+			gid =3D int(self.ctx.args.log_gid)
+			uid =3D int(self.ctx.args.log_uid)
+
 		if not path_exists(dir):
 			os.mkdir(dir)
-			os.chown(dir, uid, gid)
+			if self.ctx.args.log_gid:
+				os.chown(dir, uid, gid)
 =

 		file =3D os.path.join(dir,file)
 =

@@ -299,7 +302,8 @@ class Process(subprocess.Popen):
 			traceback.print_exc()
 			exit(0)
 =

-		os.fchown(f.fileno(), uid, gid)
+		if self.ctx.args.log_gid:
+			os.fchown(f.fileno(), uid, gid)
 =

 		self.write_fds.append(f)
 =

@@ -1833,46 +1837,47 @@ class Main:
 		if self.args.sub_tests:
 			options +=3D ' --sub_tests %s' % ','.join(self.args.sub_tests)
 =

+		gid =3D None
+		if os.environ.get('SUDO_GID', None):
+			uid =3D int(os.environ['SUDO_UID'])
+			gid =3D int(os.environ['SUDO_GID'])
+
+		append_gid_uid =3D False
+
 		if self.args.log:
-			if os.environ.get('SUDO_GID', None) is None:
+			if os.getuid() !=3D 0:
 				print("--log can only be used as root user")
 				quit()
 =

 			self.args.log =3D os.path.abspath(self.args.log)
-			uid =3D int(os.environ['SUDO_UID'])
-			gid =3D int(os.environ['SUDO_GID'])
+			append_gid_uid =3D True
 =

 			if not path_exists(self.args.log):
 				os.mkdir(self.args.log)
-				os.chown(self.args.log, uid, gid)
-
-			options +=3D ' --log-gid %u' % gid
-			options +=3D ' --log-uid %u' % uid
+				if gid:
+					os.chown(self.args.log, uid, gid)
 =

 		if self.args.monitor:
-			if os.environ.get('SUDO_GID', None) is None:
+			if os.getuid() !=3D 0:
 				print("--monitor can only be used as root user")
 				quit()
 =

 			self.args.monitor =3D os.path.abspath(self.args.monitor)
 			mon_parent_dir =3D os.path.abspath(os.path.join(self.args.monitor, os.p=
ardir))
-
-			options +=3D ' --log-gid %u' % int(os.environ['SUDO_GID'])
-			options +=3D ' --log-uid %u' % int(os.environ['SUDO_UID'])
+			append_gid_uid =3D True
 =

 		if self.args.result:
-			if os.environ.get('SUDO_GID', None) is None:
+			if os.getuid() !=3D 0:
 				print("--result can only be used as root user")
 				quit()
 =

 			self.args.result =3D os.path.abspath(self.args.result)
 			result_parent_dir =3D os.path.abspath(os.path.join(self.args.result, os=
.pardir))
+			append_gid_uid =3D True
 =

-			if '--log-gid' not in options:
-				options +=3D ' --log-gid %u' % int(os.environ['SUDO_GID'])
-
-			if '--log-uid' not in options:
-				options +=3D ' --log-uid %u' % int(os.environ['SUDO_UID'])
+		if append_gid_uid and gid:
+			options +=3D ' --log-gid %u' % (gid,)
+			options +=3D ' --log-uid %u' % (uid,)
 =

 		denylist =3D [
 			'auto_tests',
-- =

2.32.0

--===============2653349549683470215==--

