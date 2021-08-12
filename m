Content-Type: multipart/mixed; boundary="===============7362323776983386496=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] test-runner: run individual test functions manually
Date: Thu, 12 Aug 2021 16:07:16 -0700
Message-ID: <20210812230716.747378-3-prestwoj@gmail.com>
In-Reply-To: <20210812230716.747378-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7362323776983386496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While losing the convenience of unittest this patch breaks out
each individual test function in order to run it manually and
get results. This vastly improves the user experience by seeing
which test file and function is being executed rather than simply
seeing "PASSED" for the entire test set.

In addition exceptions/failures are printed out as they happen
rather than at the end.
---
 tools/test-runner | 87 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 1ee2d6a6..bfa5d803 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1036,31 +1036,96 @@ def start_test(ctx, subtests, rqueue):
 		results queue which is required since this is using
 		multiprocessing.
 	'''
-	suite =3D unittest.TestSuite()
+	run =3D 0
+	errors =3D 0
+	failures =3D 0
+	skipped =3D 0
 =

+	start =3D time.time()
 	#
 	# Iterate through each individual python test.
 	#
 	for s in subtests:
 		loader =3D unittest.TestLoader()
-		subtest =3D importlib.import_module(os.path.splitext(s)[0])
-		suite.addTests(loader.loadTestsFromModule(subtest))
+		module =3D importlib.import_module(os.path.splitext(s)[0])
+		subtest =3D loader.loadTestsFromModule(module)
+
+		# The test suite is being (ab)used to get a bit more granularity
+		# with individual tests. The 'normal' way to use unittest is to
+		# just create a test suite and run them. The problem here is that
+		# test results are queued and printed at the very end so its
+		# difficult to know *where* a test failed (python gives a stack
+		# trace but printing the exception/failure immediately shows
+		# where in the debug logs something failed). Moreso if there are
+		# several test functions inside a single python file they run
+		# as a single test and it is difficult (again) to know where
+		# something failed.
+
+		# Iterating through each python test file
+		for test in subtest:
+			# Iterating through individual test functions inside a
+			# Test() class. Due to the nature of unittest we have
+			# to jump through some hoops to set up the test class
+			# only once by turning the enumeration into a list, then
+			# enumerating (again) to keep track of the index (just
+			# enumerating the test class doesn't allow len() because
+			# it is not a list).
+			tlist =3D list(enumerate(test))
+			for index, t in enumerate(tlist):
+				# enumerate is returning a tuple, index 1 is our
+				# actual object.
+				t =3D t[1]
+
+				func, file =3D str(t).split(' ')
+				#
+				# TODO: There may be a better way of doing this
+				# but strigifying the test class gives us a string:
+				# <function> (<file>.<class>)
+				#
+				file =3D file.strip('()').split('.')[0] + '.py'
+
+				# Set up class only on first test
+				if index =3D=3D 0:
+					dbg(file)
+					t.setUpClass()
+
+				dbg("\t%s RUNNING" % str(func), end=3D'')
+				sys.__stdout__.flush()
+
+				# Run test (setUp/tearDown run automatically)
+				result =3D t()
+
+				# Tear down class only on last test
+				if index =3D=3D len(tlist) - 1:
+					t.tearDownClass()
+
+				run +=3D result.testsRun
+				errors +=3D len(result.errors)
+				failures +=3D len(result.failures)
+				skipped +=3D len(result.skipped)
+
+				if len(result.errors) > 0 or len(result.failures) > 0:
+					dbg(colored(" FAILED", "red"))
+					for e in result.errors:
+						dbg(e[1])
+					for f in result.failures:
+						dbg(f[1])
+				elif len(result.skipped) > 0:
+					dbg(colored(" SKIPPED", "cyan"))
+				else:
+					dbg(colored(" PASSED", "green"))
 =

 		# Prevents future test modules with the same name (e.g.
 		# connection_test.py) from being loaded from the cache
-		sys.modules.pop(subtest.__name__)
+		sys.modules.pop(module.__name__)
 =

-	start =3D time.time()
-	runner =3D unittest.TextTestRunner()
-	result =3D runner.run(suite)
 	#
 	# The multiprocessing queue is picky with what objects it will serialize
 	# and send between processes. Because of this we put the important bits
 	# of the result into our own 'SimpleResult' tuple.
 	#
-	sresult =3D SimpleResult(run=3Dresult.testsRun, failures=3Dlen(result.fai=
lures),
-				errors=3Dlen(result.errors), skipped=3Dlen(result.skipped),
-				time=3Dtime.time() - start)
+	sresult =3D SimpleResult(run=3Drun, failures=3Dfailures, errors=3Derrors,
+				skipped=3Dskipped, time=3Dtime.time() - start)
 	rqueue.put(sresult)
 =

 	# This may not be required since we are manually popping sys.modules
@@ -1072,7 +1137,7 @@ def pre_test(ctx, test, copied):
 	'''
 	os.chdir(test)
 =

-	dbg("Starting test %s" % test)
+	dbg("\nStarting %s" % colored(os.path.basename(test), "white", attrs=3D['=
bold']))
 	if not os.path.exists(test + '/hw.conf'):
 		raise Exception("No hw.conf found for %s" % test)
 =

-- =

2.31.1

--===============7362323776983386496==--

