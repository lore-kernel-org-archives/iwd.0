Content-Type: multipart/mixed; boundary="===============8959001077668038457=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] test-runner: fix --monitor option
Date: Wed, 01 Sep 2021 16:38:51 -0700
Message-ID: <20210901233852.2796740-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8959001077668038457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two issues:
 - log-gid/uid was not being set
 - the log file was being appended if it already existed
---
 tools/test-runner | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index fc57cd81..9e4d0780 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -183,7 +183,9 @@ class Process(subprocess.Popen):
 			args =3D ['ip', 'netns', 'exec', namespace] + args
 =

 		if outfile:
-			self._append_outfile(outfile)
+			# outfile is only used by iwmon, in which case we don't want
+			# to append to an existing file.
+			self._append_outfile(outfile, append=3DFalse)
 =

 		if self.ctx.args.log:
 			logfile =3D '%s/%s/%s' % (self.ctx.args.log,
@@ -240,7 +242,7 @@ class Process(subprocess.Popen):
 =

 		return True
 =

-	def _append_outfile(self, file):
+	def _append_outfile(self, file, append=3DTrue):
 		gid =3D int(self.ctx.args.log_gid)
 		uid =3D int(self.ctx.args.log_uid)
 		dir =3D os.path.dirname(file)
@@ -253,7 +255,7 @@ class Process(subprocess.Popen):
 =

 		# If the out file exists, append. Useful for processes like
 		# hostapd_cli where it is called multiple times independently.
-		if os.path.isfile(file):
+		if os.path.isfile(file) and append:
 			mode =3D 'a'
 		else:
 			mode =3D 'w'
@@ -1708,6 +1710,9 @@ class Main:
 			self.args.monitor =3D os.path.abspath(self.args.monitor)
 			mon_parent_dir =3D os.path.abspath(os.path.join(self.args.monitor, os.p=
ardir))
 =

+			options +=3D ' --log-gid %u' % int(os.environ['SUDO_GID'])
+			options +=3D ' --log-uid %u' % int(os.environ['SUDO_UID'])
+
 		denylist =3D [
 			'auto_tests',
 			'sub_tests',
-- =

2.31.1

--===============8959001077668038457==--

