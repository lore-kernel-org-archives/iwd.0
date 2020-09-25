Content-Type: multipart/mixed; boundary="===============0938443051747705647=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: add iwmon options
Date: Fri, 25 Sep 2020 13:52:33 -0700
Message-ID: <20200925205233.14909-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0938443051747705647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This extends test-runner to also use iwmon if --log is enabled.
For this case the iwmon log will be found inside each test
log directory.

A new option, --monitor <file> was added in case full logging isn't
desired (potentially for timing issues) but a iwmon log is needed.
Be aware that when --monitor is used test-runner will mount the
entire parent directory. test-runner itself will only write to the
file specified, but just know that the parent directory is available
as read-write inside the VM.

--log takes precedence over --monitor, meaning the iwmon log will
be written to <logdir>/<test>/iwmon instead of the file specified
with --monitor if both options are provided.
---
 tools/test-runner | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 6443af15..94c10199 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -163,7 +163,8 @@ class Process:
 		run over the entire test run and will not be killed after each
 		test exits.
 	'''
-	def __init__(self, args, wait=3DFalse, multi_test=3DFalse, env=3DNone, ct=
x=3DNone, check=3DFalse):
+	def __init__(self, args, wait=3DFalse, multi_test=3DFalse, env=3DNone, ct=
x=3DNone, check=3DFalse,
+				outfile=3DNone):
 		self.args =3D args
 		self.wait =3D wait
 		self.name =3D args[0]
@@ -185,6 +186,9 @@ class Process:
 				self.args.extend(args)
 				set_stdout =3D True
 =

+			if outfile:
+				set_stdout =3D True
+
 			# Anything labeled as multi_test isn't important to
 			# log. These are processes such as dbus-daemon and
 			# haveged.
@@ -200,6 +204,9 @@ class Process:
 =

 					self.stdout =3D open('%s/%s' % (test_dir, args[0]), 'w')
 					self.stderr =3D open('%s/%s' % (test_dir, args[0]), 'w')
+				elif outfile:
+					self.stdout =3D open(outfile, 'w')
+					self.stderr =3D open(outfile, 'w')
 				else:
 					self.stdout =3D sys.__stdout__
 					self.stderr =3D sys.__stderr__
@@ -872,6 +879,11 @@ def pre_test(ctx, test):
 	ctx.start_hostapd()
 	ctx.start_ofono()
 =

+	if ctx.args.log:
+		ctx.start_process(['iwmon'])
+	elif ctx.args.monitor:
+		ctx.start_process(['iwmon'], outfile=3Dctx.args.monitor)
+
 	if ctx.hw_config.has_option('SETUP', 'start_iwd'):
 		start =3D ctx.hw_config.getboolean('SETUP', 'start_iwd')
 	else:
@@ -1028,6 +1040,7 @@ def run_tests():
 	parser.add_argument('--log-gid')
 	parser.add_argument('--log-uid')
 	parser.add_argument('--hw')
+	parser.add_argument('--monitor')
 =

 	args =3D parser.parse_args(options)
 =

@@ -1057,6 +1070,9 @@ def run_tests():
 =

 	if args.log:
 		mount('logdir', args.log, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L')
+	elif args.monitor:
+		parent =3D os.path.abspath(os.path.join(args.monitor, os.pardir))
+		mount('mondir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L')
 =

 	if config.ctx.args.unit_tests is None:
 		run_auto_tests(config.ctx, args)
@@ -1091,6 +1107,8 @@ class Main:
 				help=3D'Directory for log files')
 		self.parser.add_argument('--hw', '-w', type=3Dstr, nargs=3D1,
 				help=3D'Use physical adapters for tests (passthrough)')
+		self.parser.add_argument('--monitor', '-m', type=3Dstr,
+				help=3D'Enables iwmon output to file')
 =

 		# Prevent --autotest/--unittest from being used together
 		auto_unit_group =3D self.parser.add_mutually_exclusive_group()
@@ -1199,6 +1217,10 @@ class Main:
 			options +=3D ' --log-gid %u' % gid
 			options +=3D ' --log-uid %u' % uid
 =

+		if self.args.monitor:
+			self.args.monitor =3D os.path.abspath(self.args.monitor)
+			mon_parent_dir =3D os.path.abspath(os.path.join(self.args.monitor, os.p=
ardir))
+
 		denylist =3D [
 			'auto_tests',
 			'qemu',
@@ -1271,6 +1293,13 @@ class Main:
 						% self.args.log
 			])
 =

+		if self.args.monitor:
+			qemu_cmdline.extend([
+				'-virtfs',
+				'local,path=3D%s,mount_tag=3Dmondir,security_model=3Dpassthrough,id=3D=
mondir' \
+						% mon_parent_dir
+			])
+
 		os.execlp(qemu_cmdline[0], *qemu_cmdline)
 =

 if __name__ =3D=3D '__main__':
-- =

2.26.2

--===============0938443051747705647==--

