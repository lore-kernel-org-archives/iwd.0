Content-Type: multipart/mixed; boundary="===============7304417374743956149=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] test-runner: fix subtest option
Date: Wed, 18 Aug 2021 10:26:03 -0700
Message-ID: <20210818172603.266294-4-prestwoj@gmail.com>
In-Reply-To: <20210818172603.266294-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7304417374743956149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was not working correctly and would run all subtests when only a single
was requested
---
 tools/test-runner | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index dc65cca4..a19ce1d9 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1271,16 +1271,18 @@ def pre_test(ctx, test, copied):
 	# Prune down any subtests if needed
 	if ctx.args.sub_tests:
 		ctx.args.sub_tests =3D ctx.args.sub_tests.split(',')
+
+		to_run =3D [x.split('.')[0] for x in ctx.args.sub_tests]
 		pruned =3D []
 =

 		for s in subtests:
-			file =3D s
+			no_ext =3D s
 			# Handle <file>.<test function> format
 			if '.' in s:
-				file =3D s.split('.')[0] + '.py'
+				no_ext =3D s.split('.')[0]
 =

-			if file =3D=3D s:
-				pruned.append(file)
+			if no_ext in to_run:
+				pruned.append(no_ext + '.py')
 =

 		subtests =3D pruned
 =

-- =

2.31.1

--===============7304417374743956149==--

