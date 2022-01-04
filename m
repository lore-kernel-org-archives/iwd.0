Content-Type: multipart/mixed; boundary="===============7660449509419304222=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/3] test-runner: only include comitted tests for full test
 runs
Date: Tue, 04 Jan 2022 09:37:35 -0800
Message-ID: <20220104173736.93682-2-prestwoj@gmail.com>
In-Reply-To: 20220104173736.93682-1-prestwoj@gmail.com

--===============7660449509419304222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If specific tests are not specified with -A, only run tests tracked by
git for full test runs.
---
 tools/test-runner | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index b5c4f777..4f16bd65 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1100,7 +1100,6 @@ def build_test_list(args):
 	'''
 	tests =3D []
 	test_root =3D args.testhome + '/autotests'
-	full_list =3D sorted(os.listdir(test_root))
 =

 	# Run all tests
 	if not args.auto_tests:
@@ -1108,10 +1107,16 @@ def build_test_list(args):
 		if args.shell:
 			return [test_root + '/shell']
 =

-		# Pair down any non-tests and append full path
-		tests =3D [test_root + '/' + t for t in full_list if t.startswith('test'=
)]
+		# Get list of all autotests (committed in git)
+		tests =3D os.popen('git -C %s ls-files autotests/ | cut -f2 -d"/" \
+					| grep "test*" | uniq' % args.testhome).read() \
+					.strip().split('\n')
+		tests =3D [test_root + '/' + t for t in tests]
 	else:
 		print("Generating partial test list")
+
+		full_list =3D sorted(os.listdir(test_root))
+
 		for t in args.auto_tests.split(','):
 			path =3D '%s/%s' % (test_root, t)
 			if t.endswith('+'):
-- =

2.31.1

--===============7660449509419304222==--

