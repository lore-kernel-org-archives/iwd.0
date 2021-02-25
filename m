Content-Type: multipart/mixed; boundary="===============7033692939312247254=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/17] test-runner: move process cleanup into kill()
Date: Thu, 25 Feb 2021 14:01:02 -0800
Message-ID: <20210225220106.1728411-13-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7033692939312247254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This moves all the de-init code into kill(), which fixes a few
reference issues causing processes to hang around longer than
desired. If the process terminates on its own and/or the last
reference is lost __del__ will kill the process and clean up.
---
 tools/test-runner | 48 +++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 80bdae30..ae02578e 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -161,6 +161,7 @@ class Process:
 	'''
 	def __init__(self, args, wait=3DFalse, env=3DNone, ctx=3DNone, check=3DFa=
lse,
 				outfile=3DNone, namespace=3DNone, need_out=3DFalse, cleanup=3DNone):
+		self.killed =3D False
 		self.args =3D args
 		self.wait =3D wait
 		self.name =3D args[0]
@@ -238,6 +239,7 @@ class Process:
 			return
 =

 		self.pid.wait()
+		self.killed =3D True
 =

 		self.stdout.seek(self.io_position)
 		self.out =3D self.stdout.read()
@@ -282,34 +284,49 @@ class Process:
 =

 	def __del__(self):
 		print("Del process %s" % self.args)
-		self.stdout.close()
 =

-		if self.io_watch:
-			GLib.source_remove(self.io_watch)
+		if not self.killed:
+			self.kill()
 =

-		for f in self.write_fds:
-			f.close()
-
-		try:
-			os.remove(self.output_name)
-		except:
-			pass
-
-		if self.cleanup:
-			self.cleanup()
+		os.remove(self.output_name)
 =

 	def kill(self, force=3DFalse):
 		print("Killing process %s" % self.args)
 =

+		if self.killed:
+			return
+
 		if force:
-			os.kill(self.pid.pid, signal.SIGKILL)
-		else:
 			self.pid.kill()
+		else:
+			self.pid.terminate()
 =

 		self.pid.wait(timeout=3D15)
 		self.pid =3D None
+
+		if self.ctx and self in self.ctx.processes:
+			self.ctx.processes.remove(self)
+
+		self.ctx =3D None
+
+		for f in self.write_fds:
+			f.close()
+
 		self.write_fds =3D []
 =

+		if self.io_watch:
+			GLib.source_remove(self.io_watch)
+			self.io_watch =3D None
+
+		if self.cleanup:
+			self.cleanup()
+
+		self.cleanup =3D None
+
+		self.stdout.close()
+
+		self.killed =3D True
+
 	def wait_for_socket(self, socket, wait):
 		waited =3D 0
 		while not os.path.exists(socket):
@@ -607,7 +624,6 @@ class Namespace:
 =

 	def stop_process(self, p, force=3DFalse):
 		p.kill(force)
-		self.processes.remove(p)
 =

 	def is_process_running(self, process):
 		for p in self.processes:
-- =

2.26.2

--===============7033692939312247254==--

