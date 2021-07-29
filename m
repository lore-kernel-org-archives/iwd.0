Content-Type: multipart/mixed; boundary="===============0594274451604706119=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] test-runner: refactor process output code
Date: Thu, 29 Jul 2021 15:21:54 -0700
Message-ID: <20210729222154.159542-9-prestwoj@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0594274451604706119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Process class requires the ability to write out any processes
output to stdout, logging, or an explicit file, as well as store
it inside python for processing by test utilities. To accomplish
this each process was given a temporary file to write to, and that
file had an IO watch set on it. Any data that was written was then
read, and re-written out to where it needed to go. This ended up
being very buggy and quite complex due to needing to mess with
read/write pointers inside the file.

Popen already creates pipes to stdout if told, and they are accessable
via the p.stdout. Its then as simple as setting an IO watch on that
pipe and keeping the same code for reading out new data and writing
it to any files we want. This greatly reduces the complexity.
---
 tools/test-runner | 77 +++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 50 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index cb97657e..75e46444 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -175,24 +175,12 @@ class Process:
 		self.io_watch =3D None
 		self.cleanup =3D cleanup
 		self.verbose =3D False
-
-		if not namespace:
-			self.output_name =3D '/tmp/%s-out' % self.name
-		else:
-			self.output_name =3D '/tmp/%s-%s-out' % (self.name, namespace)
+		self.out =3D ''
 =

 		if namespace:
 			self.args =3D ['ip', 'netns', 'exec', namespace]
 			self.args.extend(args)
 =

-		#
-		# For simplicity all processes will write to a temp file
-		# (/tmp/<name>-out). If any verbose options are required this file
-		# will get an IO watch and write out any bytes to the needed FDs.
-		#
-		self.stdout =3D open(self.output_name, 'a+')
-		self.io_position =3D self.stdout.tell()
-
 		if ctx:
 			# Verbose requested, add stdout/stderr to write FD list.
 			# This will end up always returning true if logging is
@@ -228,18 +216,18 @@ class Process:
 				os.fchown(f.fileno(), int(ctx.args.log_uid), int(ctx.args.log_gid))
 				self.write_fds.append(f)
 =

-			#
-			# Only add an IO watch for long running processes. If
-			# the process is being waited for, the log/outfile bits
-			# will be handled after the process exists.
-			#
-			if self.write_fds !=3D [] and not wait and not check or self.verbose:
-				self.io_watch =3D GLib.io_add_watch(self.stdout, GLib.IO_IN,
-								self.io_callback)
-
-		self.pid =3D subprocess.Popen(self.args, stdout=3Dself.stdout, stderr=3D=
self.stdout,
+		self.pid =3D subprocess.Popen(self.args, stdout=3Dsubprocess.PIPE,
+						stderr=3Dsubprocess.STDOUT,
 						env=3Denv, cwd=3Dos.getcwd())
 =

+		# Set as non-blocking so read() in the IO callback doesn't block forever
+		fl =3D fcntl.fcntl(self.pid.stdout, fcntl.F_GETFL)
+		fcntl.fcntl(self.pid.stdout, fcntl.F_SETFL, fl | os.O_NONBLOCK)
+
+		if not wait and not check:
+			self.io_watch =3D GLib.io_add_watch(self.pid.stdout, GLib.IO_IN |
+						GLib.IO_HUP | GLib.IO_ERR, self.io_callback)
+
 		print("Starting process {}".format(self.pid.args))
 =

 		if not wait and not check:
@@ -249,12 +237,7 @@ class Process:
 		self.killed =3D True
 		self.ret =3D self.pid.returncode
 =

-		self.stdout.seek(self.io_position)
-		self.out =3D self.stdout.read()
-		self.stdout.seek(0, 2)
-
-		if len(self.write_fds) > 0:
-			self.process_io(self.stdout)
+		self.process_io(self.pid.stdout)
 =

 		self.write_fds =3D []
 =

@@ -263,21 +246,16 @@ class Process:
 			raise subprocess.CalledProcessError(returncode=3Dself.ret, cmd=3Dself.a=
rgs)
 =

 	def process_io(self, source):
-		#
-		# The file will have already been written to, meaning the seek
-		# position points to EOF. This is why the position is saved so
-		# we can seek to where we were last time, read data, and seek
-		# back to EOF.
-		#
-		source.seek(self.io_position)
 		data =3D source.read()
 =

-		self.io_position +=3D len(data)
-		source.seek(self.io_position)
-
-		if len(data) =3D=3D 0:
+		if not data:
 			return True
 =

+		data =3D data.decode('utf-8')
+
+		# Save data away in case the caller needs it (e.g. list_sta)
+		self.out +=3D data
+
 		for f in self.write_fds:
 			f.write(data)
 			f.flush()
@@ -294,10 +272,6 @@ class Process:
 	def __del__(self):
 		print("Del process %s" % self.args)
 =

-		os.remove(self.output_name)
-
-		self.stdout.close()
-
 		if not self.killed:
 			self.kill()
 =

@@ -312,19 +286,22 @@ class Process:
 		else:
 			self.pid.terminate()
 =

-		self.pid.wait(timeout=3D15)
-		self.pid =3D None
+		try:
+			self.pid.wait(timeout=3D15)
+		except:
+			dbg("Process %s did not complete in 15 seconds!" % self.name)
+			self.pid.kill()
 =

 		if self.ctx and self in self.ctx.processes:
 			self.ctx.processes.remove(self)
 =

-		self.ctx =3D None
-
-		self.process_io(self.stdout)
-
 		if self.cleanup:
 			self.cleanup()
 =

+		self.process_io(self.pid.stdout)
+
+		self.ctx =3D None
+		self.pid =3D None
 		self.write_fds =3D []
 =

 		if self.io_watch:
-- =

2.31.1

--===============0594274451604706119==--

