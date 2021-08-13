Content-Type: multipart/mixed; boundary="===============6759457230988189701=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] test-runner: fix test skipping
Date: Fri, 13 Aug 2021 14:49:25 -0700
Message-ID: <20210813214926.813767-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6759457230988189701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tests that called skipTest would result in an exception which would
hault execution as it was uncaught. In addition this wouldn't result
in an skipped test.

Now the actual test run is surrounded in a try/except block, skipped
exceptions are handled specifically, and a stack trace is printed if
some other exception occurs.
---
 tools/test-runner | 48 +++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 0ffaec77..3e898dd4 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -13,9 +13,11 @@ import time
 import unittest
 import importlib
 import signal
+from unittest.result import TestResult
 import pyroute2
 import multiprocessing
 import re
+import traceback
 =

 from configparser import ConfigParser
 from prettytable import PrettyTable
@@ -1156,34 +1158,44 @@ def start_test(ctx, subtests, rqueue):
 				#
 				file =3D file.strip('()').split('.')[0] + '.py'
 =

-				# Set up class only on first test
-				if index =3D=3D 0:
-					dbg(file)
-					t.setUpClass()
+				# Create an empty result here in case the test fails
+				result =3D TestResult()
 =

-				dbg("\t%s RUNNING" % str(func), end=3D'')
-				sys.__stdout__.flush()
-
-				# Run test (setUp/tearDown run automatically)
-				result =3D t()
-
-				# Tear down class only on last test
-				if index =3D=3D len(tlist) - 1:
-					t.tearDownClass()
+				try:
+					# Set up class only on first test
+					if index =3D=3D 0:
+						dbg("%s\n\t%s RUNNING" % (file, str(func)), end=3D'')
+						t.setUpClass()
+					else:
+						dbg("\t%s RUNNING" % str(func), end=3D'')
+
+					sys.__stdout__.flush()
+
+					# Run test (setUp/tearDown run automatically)
+					result =3D t()
+
+					# Tear down class only on last test
+					if index =3D=3D len(tlist) - 1:
+						t.tearDownClass()
+				except unittest.SkipTest as e:
+					result.skipped.append(t)
+				except Exception as e:
+					dbg('\n%s threw an uncaught exception:' % func)
+					traceback.print_exc(file=3Dsys.__stdout__)
 =

 				run +=3D result.testsRun
 				errors +=3D len(result.errors)
 				failures +=3D len(result.failures)
 				skipped +=3D len(result.skipped)
 =

-				if len(result.errors) > 0 or len(result.failures) > 0:
+				if len(result.skipped) > 0:
+					dbg(colored(" SKIPPED", "cyan"))
+				elif run =3D=3D 0 or len(result.errors) > 0 or len(result.failures) > =
0:
 					dbg(colored(" FAILED", "red"))
 					for e in result.errors:
 						dbg(e[1])
 					for f in result.failures:
 						dbg(f[1])
-				elif len(result.skipped) > 0:
-					dbg(colored(" SKIPPED", "cyan"))
 				else:
 					dbg(colored(" PASSED", "green"))
 =

@@ -1396,8 +1408,8 @@ def run_auto_tests(ctx, args):
 				ctx.results[os.path.basename(test)] =3D rqueue.get()
 =

 		except Exception as ex:
-			dbg(ex)
-			dbg("Uncaught exception thrown for %s" % test)
+			dbg("%s threw an uncaught exception" % test)
+			traceback.print_exc(file=3Dsys.__stdout__)
 			ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D0, failures=
=3D0,
 								errors=3D0, skipped=3D0, time=3D0)
 		finally:
-- =

2.31.1

--===============6759457230988189701==--

