Content-Type: multipart/mixed; boundary="===============4442377150103267667=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: add option to specify subtests to run
Date: Thu, 05 Nov 2020 10:18:59 -0800
Message-ID: <20201105181859.2935831-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4442377150103267667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

You can now specify a limited list of subtests to run out of a
full auto-test using --sub-tests,-S. This option is limited in
that it is only meant to be used with a single autotest (since
it doesn't make much sense otherwise).

The subtest can be specified both with or without the file
extension.

Example usage:

./test-runner -A testAP -S failure_test,dhcp_test.py

This will only run the two subtests and exclude any other *.py
tests present in the test directory.
---
 tools/test-runner | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index b4840fa4..d140b253 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -892,6 +892,18 @@ def pre_test(ctx, test):
 		else:
 			shutil.copy(f, '/tmp')
 =

+	# Prune down any subtests if needed
+	if ctx.args.sub_tests:
+		ctx.args.sub_tests =3D ','.join(ctx.args.sub_tests)
+		pruned =3D []
+
+		for s in subtests:
+			# Allow test name both with and without the extension
+			if s in ctx.args.sub_tests or os.path.splitext(s)[0] in ctx.args.sub_te=
sts:
+				pruned.append(s)
+
+		subtests =3D pruned
+
 	ctx.start_dbus_monitor()
 	ctx.start_radios()
 	ctx.start_hostapd()
@@ -996,6 +1008,10 @@ def run_auto_tests(ctx, args):
 		try:
 			copied, subtests =3D pre_test(ctx, test)
 =

+			if len(subtests) < 1:
+				dbg("No tests to run")
+				exit()
+
 			rqueue =3D multiprocessing.Queue()
 			p =3D multiprocessing.Process(target=3Dstart_test, args=3D(ctx, subtest=
s, rqueue))
 			p.start()
@@ -1060,6 +1076,7 @@ def run_tests():
 	parser.add_argument('--log-uid')
 	parser.add_argument('--hw')
 	parser.add_argument('--monitor')
+	parser.add_argument('--sub_tests')
 =

 	args =3D parser.parse_args(options)
 =

@@ -1128,6 +1145,9 @@ class Main:
 				help=3D'Use physical adapters for tests (passthrough)')
 		self.parser.add_argument('--monitor', '-m', type=3Dstr,
 				help=3D'Enables iwmon output to file')
+		self.parser.add_argument('--sub-tests', '-S', metavar=3D'<subtests>',
+				type=3Dstr, nargs=3D1, help=3D'List of subtests to run',
+				default=3DNone, dest=3D'sub_tests')
 =

 		# Prevent --autotest/--unittest from being used together
 		auto_unit_group =3D self.parser.add_mutually_exclusive_group()
@@ -1153,10 +1173,22 @@ class Main:
 =

 		self.args =3D self.parser.parse_args()
 =

+		if self.args.auto_tests:
+			self.args.auto_tests =3D self.args.auto_tests[0].split(',')
+
 		if self.args.log and self.args.unit_tests:
 			dbg("Cannot use --log with --unit-tests")
 			quit()
 =

+		if self.args.sub_tests:
+			if not self.args.auto_tests:
+				dbg("--sub-tests must be used with --auto-tests")
+				quit()
+
+			if len(self.args.auto_tests) > 1:
+				dbg("--sub-tests must be used with a single auto test")
+				quit()
+
 	def start(self):
 		usb_adapters =3D None
 =

@@ -1220,6 +1252,9 @@ class Main:
 		if self.args.auto_tests:
 			options +=3D ' --auto_tests %s' % ','.join(self.args.auto_tests)
 =

+		if self.args.sub_tests:
+			options +=3D ' --sub_tests %s' % ','.join(self.args.sub_tests)
+
 		if self.args.log:
 			if os.environ.get('SUDO_GID', None) is None:
 				print("--log can only be used as root user")
@@ -1242,6 +1277,7 @@ class Main:
 =

 		denylist =3D [
 			'auto_tests',
+			'sub_tests',
 			'qemu',
 			'kernel'
 		]
-- =

2.26.2

--===============4442377150103267667==--

