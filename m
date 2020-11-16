Content-Type: multipart/mixed; boundary="===============5773649445637744188=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] auto-t: introduce new autotest syntax
Date: Mon, 16 Nov 2020 14:25:14 -0800
Message-ID: <20201116222514.3486808-8-prestwoj@gmail.com>
In-Reply-To: <20201116222514.3486808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5773649445637744188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes improperly written tests can end up causing future tests
to fail. For faster debugging you can now add a '+' after a given
autotest which will start that test and run all tests which come
alphabetically after it (as if you are running a full autotest suite).

Example:

./test-runner -A testWPA+

This will run testWPA, testWPA2, testWPA2-no-CCMP, testWPA2-SHA256,
and testWPA2withMFP.
---
 tools/test-runner | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 69e7fe7e..803d4da5 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -802,6 +802,7 @@ def build_test_list(args):
 	'''
 	tests =3D []
 	test_root =3D args.testhome + '/autotests'
+	full_list =3D sorted(os.listdir(test_root))
 =

 	# Run all tests
 	if not args.auto_tests:
@@ -809,15 +810,19 @@ def build_test_list(args):
 		if args.shell:
 			return [test_root + '/shell']
 =

-		tests =3D os.listdir(test_root)
 		# Pair down any non-tests and append full path
-		tests =3D [test_root + '/' + t for t in tests if t.startswith('test')]
+		tests =3D [test_root + '/' + t for t in full_list if t.startswith('test'=
)]
 	else:
 		print("Generating partial test list")
 		for t in args.auto_tests.split(','):
 			path =3D '%s/%s' % (test_root, t)
-			# Full test path specified
-			if os.path.exists(t):
+			if t.endswith('+'):
+				t =3D t.split('+')[0]
+				i =3D full_list.index(t)
+
+				tests =3D [test_root + '/' + x for x in full_list[i:] \
+							if x.startswith('test')]
+			elif os.path.exists(t):
 				tests.append(t)
 			elif os.path.exists(path):
 				tests.append(path)
-- =

2.26.2

--===============5773649445637744188==--

