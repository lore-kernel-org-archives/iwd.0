Content-Type: multipart/mixed; boundary="===============2024788098692484471=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] test-runner: inherit Popen by Process class
Date: Wed, 25 Aug 2021 15:17:23 -0700
Message-ID: <20210825221726.784086-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2024788098692484471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Procss class was doing quite a bit of what Popen already does like
storing the return code and process arguments. In addition the Process
class ended up storing a Popen object which was frequently accessed.

For both simplicity and memory savings have Process inherit Popen and
add the additional functionality test-runner needs like stdout
processing to output files and the console.

To do this Popen.wait() needed to be overridden to to prevent blocking
as well as wait for the HUP signal so we are sure all the process
output was written. kill() was also overritten to perform cleanup.

The most intrusive change was removing wait as a kwarg, and instead
requiring the caller to call wait(). This doesn't change much in
terms of complexity to the caller, but simplifies the __init__
routine of Process.

Some convenient improvements:
 - Separate multiple process instance output (Terminate: <args> will
   be written to outfiles each time a process dies.)
 - Append to outfile if the same process is started again
 - Wait for HUP before returning from wait(). This allows any remaining
   output to be written without the need to manually call process_io.
 - Store ctx as a class variable so callers don't need to pass it in
   (e.g. when using Process directly rather than start_process)
---
 tools/test-runner | 228 +++++++++++++++++++++++-----------------------
 1 file changed, 112 insertions(+), 116 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index d7ff3d15..8b244e99 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -57,7 +57,7 @@ def dbg(*s, **kwargs):
 def exit_vm():
 	if config:
 		for p in config.ctx.processes:
-			print("Process %s still running!" % p.name)
+			print("Process %s still running!" % p.args[0])
 			p.kill()
 			p =3D None
 =

@@ -159,102 +159,61 @@ busconfig.dtd\">
 <allow eavesdrop=3D\"true\"/>
 </policy>
 '''
-class Process:
-	'''
-		Start a process. If 'wait' is True the constructor will start
-		the process and wait for it to exit. No PID is tracked in this
-		case.
-	'''
-	def __init__(self, args, wait=3DFalse, env=3DNone, ctx=3DNone, check=3DFa=
lse,
-				outfile=3DNone, namespace=3DNone, need_out=3DFalse, cleanup=3DNone):
-		self.killed =3D False
-		self.args =3D args
-		self.wait =3D wait
-		self.name =3D args[0]
-		self.ret =3D None
-		self.ctx =3D ctx
+
+class Process(subprocess.Popen):
+	ctx =3D None
+
+	def __init__(self, args, namespace=3DNone, outfile=3DNone, env=3DNone, ch=
eck=3DFalse, cleanup=3DNone):
 		self.write_fds =3D []
 		self.io_watch =3D None
 		self.cleanup =3D cleanup
 		self.verbose =3D False
 		self.out =3D ''
+		self.hup =3D False
+		self.killed =3D False
 =

-		if namespace:
-			self.args =3D ['ip', 'netns', 'exec', namespace]
-			self.args.extend(args)
-
-		if ctx:
-			# Verbose requested, add stdout/stderr to write FD list.
-			# This will end up always returning true if logging is
-			# on which isn't desired so pass log=3DFalse as to only
-			# allow stdout to processes listed in --verbose.
-			if ctx.is_verbose(self.name, log=3DFalse):
-				self.verbose =3D True
-
-			# Add output file to FD list
-			if outfile:
-				try:
-					f =3D open(outfile, 'w')
-				except Exception as e:
-					dbg(e)
-					exit(0)
-
-				if ctx.args.log_uid:
-					os.fchown(f.fileno(), int(ctx.args.log_uid), int(ctx.args.log_gid))
+		if not self.ctx:
+			global config
+			self.ctx =3D config.ctx
 =

-				self.write_fds.append(f)
+		if namespace:
+			args =3D ['ip', 'netns', 'exec', namespace] + args
 =

-			# Add log file to FD list
-			if ctx.args.log:
-				test =3D os.path.basename(os.getcwd())
-				test_dir =3D '%s/%s' % (ctx.args.log, test)
+		if self.ctx.is_verbose(args[0], log=3DFalse):
+			self.verbose =3D True
 =

-				if not path_exists(test_dir):
-					os.mkdir(test_dir)
-					os.chown(test_dir, int(ctx.args.log_uid),
-								int(ctx.args.log_gid))
+		if outfile:
+			self._append_outfile(outfile)
 =

-				f =3D open('%s/%s' % (test_dir, args[0]), 'a+')
-				os.fchown(f.fileno(), int(ctx.args.log_uid), int(ctx.args.log_gid))
-				self.write_fds.append(f)
+		if self.ctx.args.log:
+			logfile =3D '%s/%s/%s' % (self.ctx.args.log,
+						os.path.basename(os.getcwd()),
+						args[0])
+			self._append_outfile(logfile)
 =

-		self.pid =3D subprocess.Popen(self.args, stdout=3Dsubprocess.PIPE,
-						stderr=3Dsubprocess.STDOUT,
-						env=3Denv, cwd=3Dos.getcwd())
+		super().__init__(args, stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.STD=
OUT,
+					env=3Denv, cwd=3Dos.getcwd())
 =

 		# Set as non-blocking so read() in the IO callback doesn't block forever
-		fl =3D fcntl.fcntl(self.pid.stdout, fcntl.F_GETFL)
-		fcntl.fcntl(self.pid.stdout, fcntl.F_SETFL, fl | os.O_NONBLOCK)
+		fl =3D fcntl.fcntl(self.stdout, fcntl.F_GETFL)
+		fcntl.fcntl(self.stdout, fcntl.F_SETFL, fl | os.O_NONBLOCK)
 =

-		if not wait and not check:
-			self.io_watch =3D GLib.io_add_watch(self.pid.stdout, GLib.IO_IN |
-						GLib.IO_HUP | GLib.IO_ERR, self.io_callback)
+		self.io_watch =3D GLib.io_add_watch(self.stdout, GLib.IO_IN |
+						GLib.IO_HUP | GLib.IO_ERR, self.process_io)
 =

-		print("Starting process {}".format(self.pid.args))
+		print("Starting process {}".format(self.args))
 =

-		if not wait and not check:
-			return
-
-		Namespace.non_block_wait(self.wait_for_process, 10, 1)
-		self.killed =3D True
-		self.ret =3D self.pid.returncode
+		if check:
+			self.wait(10)
+			self.killed =3D True
+			if self.returncode !=3D 0:
+				raise subprocess.CalledProcessError(returncode=3Dself.returncode,
+									cmd=3Dargs)
 =

-		self.process_io(self.pid.stdout)
+	def process_io(self, source, condition):
+		if condition & GLib.IO_HUP:
+			self.hup =3D True
 =

-		self.write_fds =3D []
-
-		print("%s returned %d" % (args[0], self.ret))
-		if check and self.ret !=3D 0:
-			raise subprocess.CalledProcessError(returncode=3Dself.ret, cmd=3Dself.a=
rgs)
-
-	def wait_for_process(self, timeout):
-		try:
-			self.pid.wait(timeout)
-			return True
-		except:
-			return False
-
-	def process_io(self, source):
 		data =3D source.read()
 =

 		if not data:
@@ -267,6 +226,12 @@ class Process:
 =

 		for f in self.write_fds:
 			f.write(data)
+
+			# Write out a separator so multiple process calls per
+			# test are easer to read.
+			if self.hup:
+				f.write("Terminated: {}\n\n".format(self.args))
+
 			f.flush()
 =

 		if self.verbose:
@@ -275,42 +240,73 @@ class Process:
 =

 		return True
 =

-	def io_callback(self, source, cb_condition):
-		return self.process_io(source)
+	def _append_outfile(self, file):
+		gid =3D int(self.ctx.args.log_gid)
+		uid =3D int(self.ctx.args.log_uid)
+		dir =3D os.path.dirname(file)
 =

-	def __del__(self):
-		print("Del process %s" % self.args)
+		if not path_exists(dir):
+			os.mkdir(dir)
+			os.chown(dir, uid, gid)
 =

-		if not self.killed:
-			self.kill()
+		file =3D os.path.join(dir,file)
 =

-	def kill(self, force=3DFalse):
-		print("Killing process %s" % self.args)
+		# If the out file exists, append. Useful for processes like
+		# hostapd_cli where it is called multiple times independently.
+		if os.path.isfile(file):
+			mode =3D 'a'
+		else:
+			mode =3D 'w'
+
+		try:
+			f =3D open(os.path.join(dir, file), mode)
+		except Exception as e:
+			traceback.print_exc()
+			exit(0)
+
+		os.fchown(f.fileno(), uid, gid)
+
+		self.write_fds.append(f)
+
+	def wait_for_socket(self, socket, wait):
+		Namespace.non_block_wait(os.path.exists, wait, socket)
+
+	# Wait for both process termination and HUP signal
+	def __wait(self, timeout):
+		try:
+			super().wait(timeout)
+			if not self.hup:
+				return False
+
+			return True
+		except:
+			return False
+
+	# Override wait() so it can do so non-blocking
+	def wait(self, timeout=3D10):
+		Namespace.non_block_wait(self.__wait, timeout, 1)
 =

+	# Override kill()
+	def kill(self, force=3DFalse):
 		if self.killed:
 			return
 =

+		print("Killing process {}".format(self.args))
+
 		if force:
-			self.pid.kill()
+			super().kill()
 		else:
-			self.pid.terminate()
+			self.terminate()
 =

 		try:
-			self.pid.wait(timeout=3D15)
+			self.wait(timeout=3D15)
 		except:
 			dbg("Process %s did not complete in 15 seconds!" % self.name)
-			self.pid.kill()
-
-		if self.ctx and self in self.ctx.processes:
-			self.ctx.processes.remove(self)
+			super().kill()
 =

 		if self.cleanup:
 			self.cleanup()
 =

-		self.process_io(self.pid.stdout)
-
-		self.ctx =3D None
-		self.pid =3D None
 		self.write_fds =3D []
 =

 		if self.io_watch:
@@ -320,8 +316,8 @@ class Process:
 		self.cleanup =3D None
 		self.killed =3D True
 =

-	def wait_for_socket(self, socket, wait):
-		Namespace.non_block_wait(os.path.exists, wait, socket)
+		if self in self.ctx.processes:
+			self.ctx.processes.remove(self)
 =

 	def __str__(self):
 		return str(self.args) + '\n'
@@ -333,10 +329,10 @@ class Interface:
 		self.config =3D config
 =

 	def __del__(self):
-		Process(['iw', 'dev', self.name, 'del'], True)
+		Process(['iw', 'dev', self.name, 'del']).wait()
 =

 	def set_interface_state(self, state):
-		Process(['ifconfig', self.name, state], True)
+		Process(['ifconfig', self.name, state]).wait()
 =

 class Radio:
 	def __init__(self, name):
@@ -360,7 +356,7 @@ class Radio:
 		self.use =3D use
 =

 		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
-				'type', 'managed'], True)
+				'type', 'managed']).wait()
 =

 		return self.interface
 =

@@ -463,8 +459,8 @@ class Hostapd:
 =

 		print("Initializing hostapd instances")
 =

-		ctx.start_process(['ip', 'link', 'set', 'eth0', 'up'], wait=3DTrue)
-		ctx.start_process(['ip', 'link', 'set', 'eth1', 'up'], wait=3DTrue)
+		ctx.start_process(['ip', 'link', 'set', 'eth0', 'up']).wait()
+		ctx.start_process(['ip', 'link', 'set', 'eth1', 'up']).wait()
 =

 		self.global_ctrl_iface =3D '/var/run/hostapd/ctrl'
 =

@@ -575,9 +571,9 @@ class Namespace:
 		self.radios =3D radios
 		self.args =3D args
 =

-		Process(['ip', 'netns', 'add', name], wait=3DTrue)
+		Process(['ip', 'netns', 'add', name]).wait()
 		for r in radios:
-			Process(['iw', 'phy', r.name, 'set', 'netns', 'name', name], wait=3DTru=
e)
+			Process(['iw', 'phy', r.name, 'set', 'netns', 'name', name]).wait()
 =

 		self.start_dbus()
 =

@@ -590,7 +586,6 @@ class Namespace:
 		self.radios =3D []
 =

 		for p in list(self.processes):
-			print("Killing process %s" % p.name)
 			p.kill()
 =

 		self.processes =3D []
@@ -598,7 +593,7 @@ class Namespace:
 	def __del__(self):
 		print("Removing namespace %s" % self.name)
 =

-		Process(['ip', 'netns', 'del', self.name], wait=3DTrue)
+		Process(['ip', 'netns', 'del', self.name]).wait()
 =

 	def get_bus(self):
 		return self._bus
@@ -617,7 +612,7 @@ class Namespace:
 			# In case this process needs DBus...
 			env['DBUS_SYSTEM_BUS_ADDRESS'] =3D self.dbus_address
 =

-		p =3D Process(args, ctx=3Dself, namespace=3Dns, env=3Denv, **kwargs)
+		p =3D Process(args, namespace=3Dns, env=3Denv, **kwargs)
 =

 		if not kwargs.get('wait', False):
 			self.processes.append(p)
@@ -629,7 +624,7 @@ class Namespace:
 =

 	def is_process_running(self, process):
 		for p in self.processes:
-			if p.name =3D=3D process:
+			if p.args[0] =3D=3D process:
 				return True
 		return False
 =

@@ -654,7 +649,7 @@ class Namespace:
 			f.write('</busconfig>\n')
 =

 		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % self.dbu=
s_cfg],
-					wait=3DFalse, cleanup=3Dself._cleanup_dbus)
+					cleanup=3Dself._cleanup_dbus)
 =

 		p.wait_for_socket(self.dbus_address.split('=3D')[1], 5)
 =

@@ -865,7 +860,7 @@ class TestContext(Namespace):
 	def start_radios(self):
 		reg_domain =3D self.hw_config['SETUP'].get('reg_domain', None)
 		if reg_domain:
-			Process(['iw', 'reg', 'set', reg_domain], True)
+			Process(['iw', 'reg', 'set', reg_domain]).wait()
 =

 		if self.args.hw:
 			self.discover_radios()
@@ -942,7 +937,7 @@ class TestContext(Namespace):
 			print("Ofono or Phonesim not found, skipping test")
 			return
 =

-		Process(['ifconfig', 'lo', 'up'], wait=3DTrue)
+		Process(['ifconfig', 'lo', 'up']).wait()
 =

 		os.environ['OFONO_PHONESIM_CONFIG'] =3D '/tmp/phonesim.conf'
 =

@@ -1327,7 +1322,7 @@ def post_test(ctx, to_copy):
 			else:
 				os.remove('/tmp/' + f)
 =

-		Process(['ifconfig', 'lo', 'down'], wait=3DTrue)
+		Process(['ifconfig', 'lo', 'down']).wait()
 	except Exception as e:
 		print("Exception thrown in post_test")
 	finally:
@@ -1451,7 +1446,8 @@ def run_unit_tests(ctx, args):
 	units =3D build_unit_list(args)
 =

 	for u in units:
-		if ctx.start_process([u], wait=3DTrue).ret !=3D 0:
+		p =3D ctx.start_process([u]).wait()
+		if p.returncode !=3D 0:
 			dbg("Unit test %s failed" % os.path.basename(u))
 		else:
 			dbg("Unit test %s passed" % os.path.basename(u))
-- =

2.31.1

--===============2024788098692484471==--

