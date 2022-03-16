Content-Type: multipart/mixed; boundary="===============5585578875382829262=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] test-runner: add option to write final status to file
Date: Wed, 16 Mar 2022 15:29:35 -0700
Message-ID: <20220316222935.596505-1-prestwoj@gmail.com>

--===============5585578875382829262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Running the tests inside a VM makes it difficult for the host to figure
out if the test actually failed or succeeded. For a human its easy to
read the results table, but for an automated system parsing this would
be fragile. This adds a new option --result <file> which writes PASS/FAIL
to the provided file once all tests are completed. Any failures results in
'FAIL' being written to the file.
---
 tools/test-runner | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 0b749238..b0ec87a2 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -62,7 +62,14 @@ def exit_vm():
 			p.kill()
 =

 	if config.ctx and config.ctx.results:
-		print_results(config.ctx.results)
+		success =3D print_results(config.ctx.results)
+	else:
+		success =3D False
+
+	if config.ctx.args.result:
+		result =3D 'PASS' if success else 'FAIL'
+		with open(config.ctx.args.result, 'w') as f:
+			f.write(result)
 =

 	os.sync()
 =

@@ -1434,6 +1441,8 @@ def print_results(results):
 =

 	dbg(table)
 =

+	return total_fail =3D=3D 0
+
 def run_auto_tests(ctx, args):
 	tests =3D build_test_list(args)
 =

@@ -1528,6 +1537,7 @@ def run_tests():
 	parser.add_argument('--hw')
 	parser.add_argument('--monitor')
 	parser.add_argument('--sub_tests')
+	parser.add_argument('--result')
 =

 	args =3D parser.parse_args(options)
 =

@@ -1580,6 +1590,10 @@ def run_tests():
 		parent =3D os.path.abspath(os.path.join(args.monitor, os.pardir))
 		mount('mondir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,msiz=
e=3D10240')
 =

+	if args.result:
+		parent =3D os.path.abspath(os.path.join(args.result, os.pardir))
+		mount('resultdir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,m=
size=3D10240')
+
 	if config.ctx.args.unit_tests is None:
 		run_auto_tests(config.ctx, args)
 	else:
@@ -1620,6 +1634,8 @@ class Main:
 		self.parser.add_argument('--sub-tests', '-S', metavar=3D'<subtests>',
 				type=3Dstr, nargs=3D1, help=3D'List of subtests to run',
 				default=3DNone, dest=3D'sub_tests')
+		self.parser.add_argument('--result', '-r', type=3Dstr,
+				help=3D'Writes PASS/FAIL to results file')
 =

 		# Prevent --autotest/--unittest from being used together
 		auto_unit_group =3D self.parser.add_mutually_exclusive_group()
@@ -1767,6 +1783,20 @@ class Main:
 			options +=3D ' --log-gid %u' % int(os.environ['SUDO_GID'])
 			options +=3D ' --log-uid %u' % int(os.environ['SUDO_UID'])
 =

+		if self.args.result:
+			if os.environ.get('SUDO_GID', None) is None:
+				print("--result can only be used as root user")
+				quit()
+
+			self.args.result =3D os.path.abspath(self.args.result)
+			result_parent_dir =3D os.path.abspath(os.path.join(self.args.result, os=
.pardir))
+
+			if '--log-gid' not in options:
+				options +=3D ' --log-gid %u' % int(os.environ['SUDO_GID'])
+
+			if '--log-uid' not in options:
+				options +=3D ' --log-uid %u' % int(os.environ['SUDO_UID'])
+
 		denylist =3D [
 			'auto_tests',
 			'sub_tests',
@@ -1873,6 +1903,13 @@ class Main:
 						% mon_parent_dir
 			])
 =

+		if self.args.result:
+			qemu_cmdline.extend([
+				'-virtfs',
+				'local,path=3D%s,mount_tag=3Dresultdir,security_model=3Dpassthrough,id=
=3Dresultdir' \
+						% result_parent_dir
+			])
+
 		os.execlp(qemu_cmdline[0], *qemu_cmdline)
 =

 if __name__ =3D=3D '__main__':
-- =

2.34.1

--===============5585578875382829262==--

