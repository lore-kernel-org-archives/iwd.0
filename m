Content-Type: multipart/mixed; boundary="===============0817495700827093835=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] test-runner: print uncaught test exceptions always
Date: Thu, 12 Aug 2021 16:07:14 -0700
Message-ID: <20210812230716.747378-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0817495700827093835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 1d148b13..f18ae538 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1259,8 +1259,8 @@ def run_auto_tests(ctx, args):
 				ctx.results[os.path.basename(test)] =3D rqueue.get()
 =

 		except Exception as ex:
-			print(ex)
-			print("Uncaught exception thrown for %s" % test)
+			dbg(ex)
+			dbg("Uncaught exception thrown for %s" % test)
 			ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D0, failures=
=3D0,
 								errors=3D0, skipped=3D0, time=3D0)
 		finally:
-- =

2.31.1

--===============0817495700827093835==--

