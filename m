Content-Type: multipart/mixed; boundary="===============9095005729433742322=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/3] test-runner: don't copy __pycache__ in tests
Date: Tue, 04 Jan 2022 09:37:36 -0800
Message-ID: <20220104173736.93682-3-prestwoj@gmail.com>
In-Reply-To: 20220104173736.93682-1-prestwoj@gmail.com

--===============9095005729433742322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is created by the python interpreter for speed optimization
but poses problems if copied to /tmp since previous tests may
have already copied it leading to an exception.
---
 tools/test-runner | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 4f16bd65..c35466c1 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1296,7 +1296,8 @@ def pre_test(ctx, test, copied):
 	subtests =3D [f for f in files if f.startswith('test') or \
 			os.path.splitext(f)[0].endswith('test')]
 	# Everything else (except .py files)
-	to_copy =3D [f for f in list(set(files) - set(subtests)) if not f.endswit=
h('.py')]
+	to_copy =3D [f for f in list(set(files) - set(subtests)) if not f.endswit=
h('.py') \
+								and f !=3D '__pycache__']
 	for f in to_copy:
 		if os.path.isdir(f):
 			shutil.copytree(f, '/tmp/' + f)
-- =

2.31.1

--===============9095005729433742322==--

