Content-Type: multipart/mixed; boundary="===============5780353468621339362=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 05/14] test-runner: fix logging for namespaces and pre-test
 processes
Date: Thu, 31 Mar 2022 16:16:32 -0700
Message-ID: <20220331231641.484200-5-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============5780353468621339362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Namespace process logs were appearing under 'ip' (and also overwriting
actual 'ip' logs) since they were executed with 'ip netns exec <namespace>'.
Instead special case this and append '-<namespace>' to the log file name.

In addition processes executed prior to any tests were being put under
a folder (name of testhome directory). Now this case is detected and these
logs are put at the top level log directory.
---
 tools/run-tests | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 716126d0..94b71ea4 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -129,6 +129,8 @@ class Process(subprocess.Popen):
 		self.killed =3D False
 		self.namespace =3D namespace
 =

+		logfile =3D args[0]
+
 		if not self.ctx:
 			global config
 			self.ctx =3D config.ctx
@@ -138,6 +140,7 @@ class Process(subprocess.Popen):
 =

 		if namespace:
 			args =3D ['ip', 'netns', 'exec', namespace] + args
+			logfile +=3D '-%s' % namespace
 =

 		if outfile:
 			# outfile is only used by iwmon, in which case we don't want
@@ -145,9 +148,16 @@ class Process(subprocess.Popen):
 			self._append_outfile(outfile, append=3DFalse)
 =

 		if self.ctx.args.log:
-			logfile =3D '%s/%s/%s' % (self.ctx.args.log,
-						os.path.basename(os.getcwd()),
-						args[0])
+			testdir =3D os.getcwd()
+
+			# Special case any processes started prior to a test
+			# (i.e. from testhome). Put these in the root log directory
+			if testdir =3D=3D self.ctx.args.testhome:
+				testdir =3D '.'
+			else:
+				testdir =3D os.path.basename(testdir)
+
+			logfile =3D '%s/%s/%s' % (self.ctx.args.log, testdir, logfile)
 			self._append_outfile(logfile)
 =

 		super().__init__(args, stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.STD=
OUT,
-- =

2.34.1

--===============5780353468621339362==--

