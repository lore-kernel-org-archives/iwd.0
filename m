Content-Type: multipart/mixed; boundary="===============5463679477329944783=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] test-runner: fix logging, verbose, and process output
Date: Tue, 26 Jan 2021 09:46:56 -0800
Message-ID: <20210126174657.867692-3-prestwoj@gmail.com>
In-Reply-To: <20210126174657.867692-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5463679477329944783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There were some major problems related to logging and process
output. Tests which required output from start_process would
break if used with '--log/--verbose'. This is because we relied
on 'communicate' to retrieve the process output, but Popen does
not store process output when stdout/stderr are anything other
than PIPE.

Intead, in the case of logging or outfiles, we can simply read
from the file we just wrote to.

For an explicit --verbose application we must handle things
slightly different. A keyword argument was added to Process,
'need_out' which will ensure the process output is kept
regardless of --log or --verbose.

Now a user should be able to use --log/--verbose without any
tests failing.
---
 autotests/util/hostapd.py |  2 +-
 tools/test-runner         | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 3f48bd57..019d23ba 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -152,7 +152,7 @@ class HostapdCLI:
         ctx.start_process(self.cmdline + ['enable'], wait=3DTrue)
 =

     def list_sta(self):
-        proc =3D ctx.start_process(self.cmdline + ['list_sta'], wait=3DTru=
e)
+        proc =3D ctx.start_process(self.cmdline + ['list_sta'], wait=3DTru=
e, need_out=3DTrue)
 =

         if not proc.out:
             return []
diff --git a/tools/test-runner b/tools/test-runner
index c0fc85ed..3a766ef5 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -162,7 +162,7 @@ class Process:
 		test exits.
 	'''
 	def __init__(self, args, wait=3DFalse, multi_test=3DFalse, env=3DNone, ct=
x=3DNone, check=3DFalse,
-				outfile=3DNone, namespace=3DNone):
+				outfile=3DNone, namespace=3DNone, need_out=3DFalse):
 		self.args =3D args
 		self.wait =3D wait
 		self.name =3D args[0]
@@ -171,14 +171,13 @@ class Process:
 		self.stderr =3D subprocess.PIPE
 		self.ret =3D None
 		self.ctx =3D ctx
+		set_stdout =3D False
 =

 		if namespace:
 			self.args =3D ['ip', 'netns', 'exec', namespace]
 			self.args.extend(args)
 =

 		if ctx:
-			set_stdout =3D False
-
 			if ctx.is_verbose(args[0]):
 				print("Verbose on for %s" % args[0])
 				set_stdout =3D True
@@ -204,12 +203,12 @@ class Process:
 						os.chown(test_dir, int(ctx.args.log_uid), \
 								int(ctx.args.log_gid))
 =

-					self.stdout =3D open('%s/%s' % (test_dir, args[0]), 'w')
-					self.stderr =3D open('%s/%s' % (test_dir, args[0]), 'w')
+					self.stdout =3D open('%s/%s' % (test_dir, args[0]), 'w+')
+					self.stderr =3D open('%s/%s' % (test_dir, args[0]), 'w+')
 				elif outfile:
 					self.stdout =3D open(outfile, 'w')
 					self.stderr =3D open(outfile, 'w')
-				else:
+				elif not need_out:
 					self.stdout =3D sys.__stdout__
 					self.stderr =3D sys.__stderr__
 =

@@ -224,11 +223,16 @@ class Process:
 =

 		self.pid.wait()
 =

-		self.out, _ =3D self.pid.communicate()
-		self.ret =3D self.pid.returncode
+		if ctx and ctx.args.log or outfile:
+			self.stdout.seek(0)
+			self.out =3D self.stdout.read()
+		else:
+			self.out, _ =3D self.pid.communicate()
 =

-		if self.out:
-			self.out =3D self.out.decode('utf-8')
+			if self.out:
+				self.out =3D self.out.decode('utf-8')
+
+		self.ret =3D self.pid.returncode
 =

 		print("%s returned %d" % (args[0], self.ret))
 		if check and self.ret !=3D 0:
-- =

2.26.2

--===============5463679477329944783==--

