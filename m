Content-Type: multipart/mixed; boundary="===============8971285729670879030=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] test-runner: print results even if test run is canceled
Date: Fri, 11 Sep 2020 11:11:30 -0700
Message-ID: <20200911181130.73148-3-prestwoj@gmail.com>
In-Reply-To: <20200911181130.73148-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8971285729670879030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index d7f831ac..a71b9ef6 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -58,6 +58,9 @@ def exit_vm():
 		for p in config.ctx.processes:
 			print("Process %s still running!" % p.name)
 =

+	if config.ctx and config.ctx.results:
+		print_results(config.ctx.results)
+
 	os.sync()
 =

 	RB_AUTOBOOT =3D 0x01234567
@@ -985,8 +988,6 @@ def run_auto_tests(ctx, args):
 	if ctx.args.log:
 		Process(["dmesg"], ctx=3Dctx, wait=3DTrue)
 =

-	print_results(ctx.results)
-
 def run_unit_tests(ctx, args):
 	os.chdir(args.testhome + '/unit')
 	units =3D build_unit_list(args)
-- =

2.26.2

--===============8971285729670879030==--

