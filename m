Content-Type: multipart/mixed; boundary="===============4463343171979006087=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/7] testrunner: Fix /tmp files cleanup on error
Date: Mon, 25 Jan 2021 18:56:14 +0100
Message-ID: <20210125175617.2417412-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210125175617.2417412-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4463343171979006087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the list of files copied to /tmp was part of the return value from
pre_test(), if an exception occurred inside pre_test(), "copied" would
be undefined and the post_test(ctx, copied) call in the finally clause
cause another exception:

raceback (most recent call last):
  File "/home/balrog/repos/iwd/tools/test-runner", line 1508, in <module>
    run_tests()
  File "/home/balrog/repos/iwd/tools/test-runner", line 1242, in run_tests
    run_auto_tests(config.ctx, args)
  File "/home/balrog/repos/iwd/tools/test-runner", line 1166, in run_auto_t=
ests
    post_test(ctx, copied)
UnboundLocalError: local variable 'copied' referenced before assignment

(apart from not being able to clean up the files).  Pass "copied" as a
paremeter to pre_test instead.
---
 tools/test-runner | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 7bd15a28..3ba49953 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -973,7 +973,7 @@ def start_test(ctx, subtests, rqueue):
 	# This may not be required since we are manually popping sys.modules
 	importlib.invalidate_caches()
 =

-def pre_test(ctx, test):
+def pre_test(ctx, test, copied):
 	'''
 		Copy test files, start processes, and any other pre test work.
 	'''
@@ -1005,6 +1005,7 @@ def pre_test(ctx, test):
 			shutil.copytree(f, '/tmp/' + f)
 		else:
 			shutil.copy(f, '/tmp')
+		copied.append(f)
 =

 	# Prune down any subtests if needed
 	if ctx.args.sub_tests:
@@ -1044,7 +1045,7 @@ def pre_test(ctx, test):
 =

 	sys.path.insert(1, test)
 =

-	return (to_copy, sorted(subtests))
+	return sorted(subtests)
 =

 def post_test(ctx, to_copy):
 	'''
@@ -1119,8 +1120,9 @@ def run_auto_tests(ctx, args):
 	shutil.copy(args.testhome + '/autotests/misc/phonesim/phonesim.conf', '/t=
mp')
 =

 	for test in tests:
+		copied =3D []
 		try:
-			copied, subtests =3D pre_test(ctx, test)
+			subtests =3D pre_test(ctx, test, copied)
 =

 			if args.shell:
 				#
-- =

2.27.0

--===============4463343171979006087==--

