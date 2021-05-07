Content-Type: multipart/mixed; boundary="===============7633739460277172976=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 7/7] test-runner: remove stale file after test
Date: Fri, 07 May 2021 13:26:20 -0700
Message-ID: <20210507202620.93540-7-prestwoj@gmail.com>
In-Reply-To: <20210507202620.93540-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7633739460277172976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

test-runner will print out if files were left behind after a
test which lets the developer know something was not cleaned
up. But in this case test-runner should also remove these files
so they are not left, and printed, for each subsequent test.
---
 tools/test-runner | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/test-runner b/tools/test-runner
index dd4cbf82..892e63ff 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1186,6 +1186,7 @@ def post_test(ctx, to_copy):
 	allowed =3D ['phonesim.conf', 'certs', 'secrets', 'iwd']
 	for f in [f for f in os.listdir('/tmp') if f not in allowed]:
 		dbg("File %s was not cleaned up!" % f)
+		os.remove('/tmp/' + f)
 =

 	if ctx.args.valgrind:
 		with open('/tmp/valgrind.log', 'r') as f:
-- =

2.31.1

--===============7633739460277172976==--

