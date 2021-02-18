Content-Type: multipart/mixed; boundary="===============1949012365560084438=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] test-runner: start dmesg process with start_process
Date: Thu, 18 Feb 2021 12:19:27 -0800
Message-ID: <20210218201933.1406654-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1949012365560084438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This avoids the need to pass in the context explicitly.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 965b0a57..70694e47 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1178,7 +1178,7 @@ def run_auto_tests(ctx, args):
 =

 	# Write out kernel log
 	if ctx.args.log:
-		Process(["dmesg"], ctx=3Dctx, wait=3DTrue)
+		ctx.start_process(["dmesg"], wait=3DTrue)
 =

 def run_unit_tests(ctx, args):
 	os.chdir(args.testhome + '/unit')
-- =

2.26.2

--===============1949012365560084438==--

