Content-Type: multipart/mixed; boundary="===============7001284559961533819=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/5] test-runner: extend -S option
Date: Tue, 17 Aug 2021 09:44:57 -0700
Message-ID: <20210817164501.195027-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7001284559961533819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The -S/--sub-tests option allows the user to specify a test file
from inside an autotest. Inside this file there may also be many
test functions. This option is being extended to allow running
a single test function inside a test file. For example:

* Runs all test functions inside connection_test.py *
./test-runner -A some_test -S connection_test

* Runs only connection_test.py test_connect_success() *
./test-runner -A some_test -S connection_test.test_connect_success
---
 tools/test-runner | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index dcb1ba5e..895d4299 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1139,6 +1139,13 @@ def start_test(ctx, subtests, rqueue):
 =

 		# Iterating through each python test file
 		for test in subtest:
+			limit_funcs =3D []
+
+			if ctx.args.sub_tests:
+				for i in ctx.args.sub_tests:
+					if len(i.split('.')) =3D=3D 2:
+						limit_funcs.append(i.split('.')[1])
+
 			# Iterating through individual test functions inside a
 			# Test() class. Due to the nature of unittest we have
 			# to jump through some hoops to set up the test class
@@ -1164,21 +1171,29 @@ def start_test(ctx, subtests, rqueue):
 				result =3D TestResult()
 =

 				try:
+					skip =3D len(limit_funcs) > 0 and func not in limit_funcs
+
 					# Set up class only on first test
 					if index =3D=3D 0:
-						dbg("%s\n\t%s RUNNING" % (file, str(func)), end=3D'')
+						if not skip:
+							dbg("%s\n\t%s RUNNING" % (file, str(func)), end=3D'')
 						t.setUpClass()
 					else:
-						dbg("\t%s RUNNING" % str(func), end=3D'')
+						if not skip:
+							dbg("\t%s RUNNING" % str(func), end=3D'')
 =

 					sys.__stdout__.flush()
 =

-					# Run test (setUp/tearDown run automatically)
-					result =3D t()
+					if not skip:
+						# Run test (setUp/tearDown run automatically)
+						result =3D t()
 =

 					# Tear down class only on last test
 					if index =3D=3D len(tlist) - 1:
 						t.tearDownClass()
+
+					if skip:
+						continue
 				except unittest.SkipTest as e:
 					result.skipped.append(t)
 				except Exception as e:
@@ -1256,9 +1271,13 @@ def pre_test(ctx, test, copied):
 		pruned =3D []
 =

 		for s in subtests:
-			# Allow test name both with and without the extension
-			if s in ctx.args.sub_tests or os.path.splitext(s)[0] in ctx.args.sub_te=
sts:
-				pruned.append(s)
+			file =3D s
+			# Handle <file>.<test function> format
+			if '.' in s:
+				file =3D s.split('.')[0] + '.py'
+
+			if file =3D=3D s:
+				pruned.append(file)
 =

 		subtests =3D pruned
 =

-- =

2.31.1

--===============7001284559961533819==--

