Content-Type: multipart/mixed; boundary="===============8464455527067624036=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 4/4] test-runner: Replace exit with sys.exit
Date: Wed, 30 Mar 2022 19:34:00 +0200
Message-ID: <20220330173400.259961-4-andrew.zaborowski@intel.com>
In-Reply-To: 20220330173400.259961-1-andrew.zaborowski@intel.com

--===============8464455527067624036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

exit comes from the site module which is "useful for the interactive
interpreter shell and should not be used in programs."
(https://docs.python.org/3/library/constants.html#constants-added-by-the-si=
te-module)
Replace with sys.exit().  I for an undefined error for exit in
exit_vm().
---
 tools/test-runner | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index b443d91e..81624953 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -300,7 +300,7 @@ class Process(subprocess.Popen):
 			f =3D open(os.path.join(dir, file), mode)
 		except Exception as e:
 			traceback.print_exc()
-			exit(0)
+			sys.exit(0)
 =

 		if self.ctx.args.log_gid:
 			os.fchown(f.fileno(), uid, gid)
@@ -1545,11 +1545,11 @@ def run_auto_tests(ctx, args):
 				os.chdir(tests[0])
 				os.environ['DBUS_SYSTEM_BUS_ADDRESS'] =3D ctx.dbus_address
 				os.system('/bin/bash')
-				exit()
+				sys.exit()
 =

 			if len(subtests) < 1:
 				dbg("No tests to run")
-				exit()
+				sys.exit()
 =

 			rqueue =3D multiprocessing.Queue()
 			p =3D multiprocessing.Process(target=3Dstart_test, args=3D(ctx, subtest=
s, rqueue))
@@ -1994,7 +1994,7 @@ if __name__ =3D=3D '__main__':
 		prepare_sandbox()
 		run_tests()
 =

-		exit()
+		sys.exit()
 =

 	main =3D Main()
 	main.start()
-- =

2.32.0

--===============8464455527067624036==--

