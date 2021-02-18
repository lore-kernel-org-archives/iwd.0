Content-Type: multipart/mixed; boundary="===============8420794552934844567=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] test-runner: refactor Process class
Date: Thu, 18 Feb 2021 12:19:30 -0800
Message-ID: <20210218201933.1406654-4-prestwoj@gmail.com>
In-Reply-To: <20210218201933.1406654-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8420794552934844567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The process class was quite hard to understand, and somewhat
fragile when multiple output options were needed like verbose
and logging, and in some cases even an additional output file.

To make things simpler we can have all processes output to a
temporary file (/tmp/<name>-out) and set a GLib IO watch on
that file. When the IO watch callback fires any additional
files (stdout, log files, output files) can be written to.

For wait=3DTrue processes we do not use an IO watch, but do
the same thing once the process exits, write to any additional
output files using the process output we already have.
---
 tools/test-runner | 134 ++++++++++++++++++++++++++++++----------------
 1 file changed, 88 insertions(+), 46 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 8bf8d363..0649109b 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -167,54 +167,67 @@ class Process:
 		self.wait =3D wait
 		self.name =3D args[0]
 		self.multi_test =3D multi_test
-		self.stdout =3D subprocess.PIPE
-		self.stderr =3D subprocess.PIPE
 		self.ret =3D None
 		self.ctx =3D ctx
-		set_stdout =3D False
+		self.write_fds =3D []
+		self.io_watch =3D None
 =

 		if namespace:
 			self.args =3D ['ip', 'netns', 'exec', namespace]
 			self.args.extend(args)
 =

-		if ctx:
-			if ctx.is_verbose(args[0]):
-				print("Verbose on for %s" % args[0])
-				set_stdout =3D True
+		#
+		# For simplicity all processes will write to a temp file
+		# (/tmp/<name>-out). If any verbose options are required this file
+		# will get an IO watch and write out any bytes to the needed FDs.
+		#
+		self.stdout =3D open('/tmp/%s-out' % self.name, 'a+')
+		self.io_position =3D self.stdout.tell()
 =

-			if os.path.basename(args[0]) =3D=3D ctx.args.gdb:
-				self.args =3D ['gdb', '--args']
-				self.args.extend(args)
-				set_stdout =3D True
+		if ctx:
+			# Verbose requested, add stdout/stderr to write FD list
+			if self.name in ctx.args.verbose:
+				self.write_fds.append(sys.__stdout__)
+				self.write_fds.append(sys.__stderr__)
 =

+			# Add output file to FD list
 			if outfile:
-				set_stdout =3D True
-
-			# Anything labeled as multi_test isn't important to
-			# log. These are processes such as dbus-daemon and
-			# haveged.
-			if set_stdout:
-				if ctx.args.log:
-					test =3D os.path.basename(os.getcwd())
-					test_dir =3D '%s/%s' % (ctx.args.log, test)
-
-					if not path_exists(test_dir):
-						os.mkdir(test_dir)
-						os.chown(test_dir, int(ctx.args.log_uid), \
+				try:
+					f =3D open(outfile, 'w')
+				except Exception as e:
+					dbg(e)
+					exit(0)
+
+				if ctx.args.log_uid:
+					os.fchown(f.fileno(), int(ctx.args.log_uid), int(ctx.args.log_gid))
+
+				self.write_fds.append(f)
+
+			# Add log file to FD list
+			if ctx.args.log:
+				test =3D os.path.basename(os.getcwd())
+				test_dir =3D '%s/%s' % (ctx.args.log, test)
+
+				if not path_exists(test_dir):
+					os.mkdir(test_dir)
+					os.chown(test_dir, int(ctx.args.log_uid),
 								int(ctx.args.log_gid))
 =

-					self.stdout =3D open('%s/%s' % (test_dir, args[0]), 'w+')
-					self.stderr =3D open('%s/%s' % (test_dir, args[0]), 'w+')
-				elif outfile:
-					self.stdout =3D open(outfile, 'w')
-					self.stderr =3D open(outfile, 'w')
-				elif not need_out:
-					self.stdout =3D sys.__stdout__
-					self.stderr =3D sys.__stderr__
+				f =3D open('%s/%s' % (test_dir, args[0]), 'a+')
+				os.fchown(f.fileno(), int(ctx.args.log_uid), int(ctx.args.log_gid))
+				self.write_fds.append(f)
 =

-		self.pid =3D subprocess.Popen(self.args, stdout=3Dself.stdout, \
-							stderr=3Dself.stderr, env=3Denv, \
-							cwd=3Dos.getcwd())
+			#
+			# Only add an IO watch for long running processes. If
+			# the process is being waited for, the log/outfile bits
+			# will be handled after the process exists.
+			#
+			if self.write_fds !=3D [] and not wait and not check:
+				self.io_watch =3D GLib.io_add_watch(self.stdout, GLib.IO_IN,
+								self.io_callback)
+
+		self.pid =3D subprocess.Popen(self.args, stdout=3Dself.stdout, stderr=3D=
subprocess.STDOUT,
+						env=3Denv, cwd=3Dos.getcwd())
 =

 		print("Starting process {}".format(self.pid.args))
 =

@@ -223,25 +236,54 @@ class Process:
 =

 		self.pid.wait()
 =

-		if ctx and ctx.args.log or outfile:
-			self.stdout.seek(0)
-			self.out =3D self.stdout.read()
-		else:
-			self.out, _ =3D self.pid.communicate()
-
-			if self.out:
-				self.out =3D self.out.decode('utf-8')
-
+		self.stdout.seek(self.io_position)
+		self.out =3D self.stdout.read()
+		self.stdout.seek(0, 2)
 		self.ret =3D self.pid.returncode
 =

+		#
+		# No IO callback for wait/check=3DTrue processes so write out
+		# the data to any FD's now.
+		#
+		if len(self.write_fds) > 0:
+			for fd in self.write_fds:
+				fd.write(self.out)
+
 		print("%s returned %d" % (args[0], self.ret))
 		if check and self.ret !=3D 0:
 			raise subprocess.CalledProcessError(returncode=3Dself.ret, cmd=3Dself.a=
rgs)
 =

+	def io_callback(self, source, cb_condition):
+		#
+		# The file will have already been written to, meaning the seek
+		# position points to EOF. This is why the position is saved so
+		# we can seek to where we were last time, read data, and seek
+		# back to EOF.
+		#
+		source.seek(self.io_position)
+		data =3D source.read()
+
+		self.io_position +=3D len(data)
+		source.seek(self.io_position)
+
+		if len(data) =3D=3D 0:
+			return True
+
+		for f in self.write_fds:
+			f.write(data)
+
+		return True
+
 	def __del__(self):
 		print("Del process %s" % self.args)
-		self.stdout =3D None
-		self.stderr =3D None
+		self.stdout.close()
+
+		if self.io_watch:
+			GLib.source_remove(self.io_watch)
+
+		if self.write_fds !=3D []:
+			for f in self.write_fds:
+				f.close()
 =

 	def kill(self, force=3DFalse):
 		print("Killing process %s" % self.args)
-- =

2.26.2

--===============8420794552934844567==--

