Content-Type: multipart/mixed; boundary="===============9043982118355664837=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] test-runner: use type=os.path.abspath for argparse
Date: Tue, 05 Apr 2022 15:26:26 -0700
Message-ID: <20220405222627.883931-1-prestwoj@gmail.com>

--===============9043982118355664837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a convenient type which automatically resolves the argument
to an absolute path. Use this for any arguments expected to be
paths.
---
 tools/runner.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index 0068c74f..8e1ac1d7 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -97,7 +97,8 @@ class RunnerCoreArgParse(ArgumentParser):
 		self.add_argument('--start', '-s',
 				help=3D'Custom init process in virtual environment',
 				dest=3D'start',
-				default=3DNone)
+				default=3DNone,
+				type=3Dos.path.abspath)
 		self.add_argument('--verbose', '-v', metavar=3D'<list>',
 				type=3Dstr,
 				help=3D'Comma separated list of applications',
@@ -108,16 +109,17 @@ class RunnerCoreArgParse(ArgumentParser):
 				help=3D'Enable test-runner debugging',
 				dest=3D'dbg')
 		self.add_argument('--log', '-l',
-				type=3Dstr,
+				type=3Dos.path.abspath,
 				help=3D'Directory for log files')
 		self.add_argument('--monitor', '-m',
-				type=3Dstr,
+				type=3Dos.path.abspath,
 				help=3D'Enables iwmon output to file')
 		self.add_argument('--sub-tests', '-S',
 				metavar=3D'<subtests>',
 				type=3Dstr, nargs=3D1, help=3D'List of subtests to run',
 				default=3DNone, dest=3D'sub_tests')
-		self.add_argument('--result', '-e', type=3Dstr,
+		self.add_argument('--result', '-e',
+				type=3Dos.path.abspath,
 				help=3D'Writes PASS/FAIL to results file')
 		self.add_argument('--hw', '-w',
 				type=3Dstr,
@@ -211,8 +213,6 @@ class Runner:
 				args.start =3D os.path.abspath('tools/run-tests')
 			else:
 				raise Exception("Cannot locate run-tests binary")
-		else:
-			args.start =3D os.path.abspath(args.start)
 =

 		# If no runner is specified but we have a kernel image assume
 		# if the kernel is executable its UML, otherwise qemu
@@ -242,9 +242,6 @@ class RunnerAbstract:
 	def __init__(self, args):
 		self.args =3D args
 =

-		if self.args.log:
-			self.args.log =3D os.path.abspath(self.args.log)
-
 	def start(self):
 		print("Starting %s" % self.name)
 		os.execlpe(self.cmdline[0], *self.cmdline, self.env)
-- =

2.34.1

--===============9043982118355664837==--

