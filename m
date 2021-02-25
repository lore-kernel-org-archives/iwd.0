Content-Type: multipart/mixed; boundary="===============1870236005615651606=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/17] test-runner: cleanup output files/others in Process
Date: Thu, 25 Feb 2021 14:00:57 -0800
Message-ID: <20210225220106.1728411-8-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1870236005615651606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A cleanup parameter was added to __init__ which can be used
by processes which create any additional files or require more
a custom cleanup routine. Some additional house keeping was
done to make Process cleanup more robust.
---
 tools/test-runner | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index d63faf8c..2fb7a613 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -160,7 +160,7 @@ class Process:
 		case.
 	'''
 	def __init__(self, args, wait=3DFalse, env=3DNone, ctx=3DNone, check=3DFa=
lse,
-				outfile=3DNone, namespace=3DNone, need_out=3DFalse):
+				outfile=3DNone, namespace=3DNone, need_out=3DFalse, cleanup=3DNone):
 		self.args =3D args
 		self.wait =3D wait
 		self.name =3D args[0]
@@ -168,6 +168,7 @@ class Process:
 		self.ctx =3D ctx
 		self.write_fds =3D []
 		self.io_watch =3D None
+		self.cleanup =3D cleanup
 =

 		if not namespace:
 			self.output_name =3D '/tmp/%s-out' % self.name
@@ -250,6 +251,9 @@ class Process:
 		if len(self.write_fds) > 0:
 			for fd in self.write_fds:
 				fd.write(self.out)
+				fd.close()
+
+			self.write_fds =3D []
 =

 		print("%s returned %d" % (args[0], self.ret))
 		if check and self.ret !=3D 0:
@@ -283,11 +287,16 @@ class Process:
 		if self.io_watch:
 			GLib.source_remove(self.io_watch)
 =

-		if self.write_fds !=3D []:
-			for f in self.write_fds:
-				f.close()
+		for f in self.write_fds:
+			f.close()
+
+		try:
+			os.remove(self.output_name)
+		except:
+			pass
 =

-		os.remove(self.output_name)
+		if self.cleanup:
+			self.cleanup()
 =

 	def kill(self, force=3DFalse):
 		print("Killing process %s" % self.args)
@@ -298,6 +307,8 @@ class Process:
 			self.pid.kill()
 =

 		self.pid.wait(timeout=3D15)
+		self.pid =3D None
+		self.write_fds =3D []
 =

 	def wait_for_socket(self, socket, wait):
 		waited =3D 0
-- =

2.26.2

--===============1870236005615651606==--

