Content-Type: multipart/mixed; boundary="===============6728403985986107120=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] auto-t: do away with -1 test results
Date: Mon, 16 Nov 2020 14:25:13 -0800
Message-ID: <20201116222514.3486808-7-prestwoj@gmail.com>
In-Reply-To: <20201116222514.3486808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6728403985986107120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can result in strange test results since there was no less
than zero checks before subtracting the total tests from failed
tests. In case of an internal exception we can just set all values
to zero. This will be handled specially as we do for timeout
errors.
---
 tools/test-runner | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 61555b77..69e7fe7e 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -973,16 +973,20 @@ def print_results(results):
 	total_time =3D 0
 =

 	for test, result in results.items():
-		if result.time !=3D TEST_MAX_TIMEOUT:
+
+		if result.time =3D=3D TEST_MAX_TIMEOUT:
+			failed =3D "Timed out"
+			passed =3D "Timed out"
+		elif result.time =3D=3D 0:
+			failed =3D "Exception"
+			passed =3D "Exception"
+		else:
 			failed =3D result.failures + result.errors
 			passed =3D result.run - failed
 =

 			total_pass +=3D passed
 			total_fail +=3D failed
 			total_skip +=3D result.skipped
-		else:
-			failed =3D "Timed out"
-			passed =3D "Timed out"
 =

 		total_time +=3D result.time
 =

@@ -1046,8 +1050,8 @@ def run_auto_tests(ctx, args):
 		except Exception as ex:
 			print(ex)
 			print("Uncaught exception thrown for %s" % test)
-			ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D-1, failures=
=3D-1,
-								errors=3D-1, skipped=3D-1, time=3D-1)
+			ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D0, failures=
=3D0,
+								errors=3D0, skipped=3D0, time=3D0)
 		finally:
 			post_test(ctx, copied)
 =

-- =

2.26.2

--===============6728403985986107120==--

