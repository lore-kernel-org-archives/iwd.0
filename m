Content-Type: multipart/mixed; boundary="===============8239241140364014813=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] test-runner: delay starting the shell until after pre_test
Date: Mon, 16 Nov 2020 14:25:10 -0800
Message-ID: <20201116222514.3486808-4-prestwoj@gmail.com>
In-Reply-To: <20201116222514.3486808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8239241140364014813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes --shell somewhat more useful by copying all the test
files and starting test processes before dumping the user into
a shell.
---
 tools/test-runner | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 77b2c9fc..610f1702 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1005,19 +1005,19 @@ def run_auto_tests(ctx, args):
 	shutil.copytree(args.testhome + '/autotests/misc/secrets', '/tmp/secrets')
 	shutil.copy(args.testhome + '/autotests/misc/phonesim/phonesim.conf', '/t=
mp')
 =

-	if args.shell:
-		#
-		# Shell really isn't meant to be used with multiple tests. If
-		# a set of tests was passed in just start out in the first.
-		#
-		os.chdir(tests[0])
-		os.system('/bin/bash')
-		exit()
-
 	for test in tests:
 		try:
 			copied, subtests =3D pre_test(ctx, test)
 =

+			if args.shell:
+				#
+				# Shell really isn't meant to be used with multiple tests. If
+				# a set of tests was passed in just start out in the first.
+				#
+				os.chdir(tests[0])
+				os.system('/bin/bash')
+				exit()
+
 			if len(subtests) < 1:
 				dbg("No tests to run")
 				exit()
-- =

2.26.2

--===============8239241140364014813==--

