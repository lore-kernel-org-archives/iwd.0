Content-Type: multipart/mixed; boundary="===============3174013077842024750=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] test-runner: fix process output truncation
Date: Thu, 22 Apr 2021 10:37:42 -0700
Message-ID: <20210422173746.2324850-3-prestwoj@gmail.com>
In-Reply-To: <20210422173746.2324850-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3174013077842024750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There was a bug with process output where the last bit of data would
never make it into stdout or log files. This was due to the IO watch
being cleaned up when the process was killed and never allowing it
to finish writing any pending data.

Now the IO watch implementation has been moved out into its own
function (io_process) which is now used to write the final bits of
data out on process exit.
---
 tools/test-runner | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index c3a5ff89..799953de 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -244,31 +244,22 @@ class Process:
 =

 		self.pid.wait(timeout=3D5)
 		self.killed =3D True
+		self.ret =3D self.pid.returncode
 =

 		self.stdout.seek(self.io_position)
 		self.out =3D self.stdout.read()
 		self.stdout.seek(0, 2)
-		self.ret =3D self.pid.returncode
 =

-		#
-		# No IO callback for wait/check=3DTrue processes so write out
-		# the data to any FD's now.
-		#
 		if len(self.write_fds) > 0:
-			for fd in self.write_fds:
-				fd.write(self.out)
-				fd.close()
+			self.process_io(self.stdout)
 =

-			self.write_fds =3D []
-
-		if self.verbose:
-			sys.__stdout__.write(self.out)
+		self.write_fds =3D []
 =

 		print("%s returned %d" % (args[0], self.ret))
 		if check and self.ret !=3D 0:
 			raise subprocess.CalledProcessError(returncode=3Dself.ret, cmd=3Dself.a=
rgs)
 =

-	def io_callback(self, source, cb_condition):
+	def process_io(self, source):
 		#
 		# The file will have already been written to, meaning the seek
 		# position points to EOF. This is why the position is saved so
@@ -286,20 +277,27 @@ class Process:
 =

 		for f in self.write_fds:
 			f.write(data)
+			f.flush()
 =

 		if self.verbose:
 			sys.__stdout__.write(data)
+			sys.__stdout__.flush()
 =

 		return True
 =

+	def io_callback(self, source, cb_condition):
+		return self.process_io(source)
+
 	def __del__(self):
 		print("Del process %s" % self.args)
 =

+		os.remove(self.output_name)
+
+		self.stdout.close()
+
 		if not self.killed:
 			self.kill()
 =

-		os.remove(self.output_name)
-
 	def kill(self, force=3DFalse):
 		print("Killing process %s" % self.args)
 =

@@ -319,8 +317,10 @@ class Process:
 =

 		self.ctx =3D None
 =

-		for f in self.write_fds:
-			f.close()
+		self.process_io(self.stdout)
+
+		if self.cleanup:
+			self.cleanup()
 =

 		self.write_fds =3D []
 =

@@ -328,13 +328,7 @@ class Process:
 			GLib.source_remove(self.io_watch)
 			self.io_watch =3D None
 =

-		if self.cleanup:
-			self.cleanup()
-
 		self.cleanup =3D None
-
-		self.stdout.close()
-
 		self.killed =3D True
 =

 	def wait_for_socket(self, socket, wait):
-- =

2.26.2

--===============3174013077842024750==--

