Content-Type: multipart/mixed; boundary="===============1003032190634492970=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 01/10] test-runner: isolate Process/Namespace into utils
Date: Wed, 06 Apr 2022 12:14:44 -0700
Message-ID: <20220406191453.978426-1-prestwoj@gmail.com>

--===============1003032190634492970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Way too many classes have a dependency on the TestContext class, in
most cases only for is_verbose. This patch removes the dependency from
Process and Namespace classes.

For Process, the test arguments can be parsed in the class itself which
will allow for this class to be completely isolated into its own file.

The Namespace class was already relatively isolated. Both were moved
into utils.py which makes 'run-tests' quite a bit nicer to look at and
more fitting to its name.
---
 tools/run-tests | 470 +-----------------------------------------------
 tools/utils.py  | 455 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+), 461 deletions(-)
 create mode 100644 tools/utils.py

diff --git a/tools/run-tests b/tools/run-tests
index 0534a12f..4291250a 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -2,7 +2,6 @@
 =

 import os
 import shutil
-import fcntl
 import sys
 import subprocess
 import atexit
@@ -14,17 +13,16 @@ import multiprocessing
 import re
 import traceback
 =

-from runner import Runner
-
 from configparser import ConfigParser
 from prettytable import PrettyTable
 from termcolor import colored
 from glob import glob
 from collections import namedtuple
-from time import sleep
 import dbus.mainloop.glib
 from gi.repository import GLib
-from weakref import WeakValueDictionary
+
+from runner import Runner
+from utils import Process, Namespace
 =

 config =3D None
 intf_id =3D 0
@@ -81,241 +79,6 @@ def find_binary(list):
 			return path
 	return None
 =

-# Partial DBus config. The remainder (<listen>) will be filled in for each
-# namespace that is created so each individual dbus-daemon has its own soc=
ket
-# and address.
-dbus_config =3D '''
-<!DOCTYPE busconfig PUBLIC \
-"-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN" \
-"http://www.freedesktop.org/standards/dbus/1.0/\
-busconfig.dtd\">
-<busconfig>
-<type>system</type>
-<limit name=3D\"reply_timeout\">2147483647</limit>
-<auth>ANONYMOUS</auth>
-<allow_anonymous/>
-<policy context=3D\"default\">
-<allow user=3D\"*\"/>
-<allow own=3D\"*\"/>
-<allow send_type=3D\"method_call\"/>
-<allow send_type=3D\"signal\"/>
-<allow send_type=3D\"method_return\"/>
-<allow send_type=3D\"error\"/>
-<allow receive_type=3D\"method_call\"/>
-<allow receive_type=3D\"signal\"/>
-<allow receive_type=3D\"method_return\"/>
-<allow receive_type=3D\"error\"/>
-<allow send_destination=3D\"*\" eavesdrop=3D\"true\"/>
-<allow eavesdrop=3D\"true\"/>
-</policy>
-'''
-
-class Process(subprocess.Popen):
-	processes =3D WeakValueDictionary()
-	ctx =3D None
-
-	def __new__(cls, *args, **kwargs):
-		obj =3D super().__new__(cls)
-		cls.processes[id(obj)] =3D obj
-		return obj
-
-	def __init__(self, args, namespace=3DNone, outfile=3DNone, env=3DNone, ch=
eck=3DFalse, cleanup=3DNone):
-		self.write_fds =3D []
-		self.io_watch =3D None
-		self.cleanup =3D cleanup
-		self.verbose =3D False
-		self.out =3D ''
-		self.hup =3D False
-		self.killed =3D False
-		self.namespace =3D namespace
-
-		logfile =3D args[0]
-
-		if not self.ctx:
-			global config
-			self.ctx =3D config.ctx
-
-		if self.ctx.is_verbose(args[0], log=3DFalse):
-			self.verbose =3D True
-
-		if namespace:
-			args =3D ['ip', 'netns', 'exec', namespace] + args
-			logfile +=3D '-%s' % namespace
-
-		if outfile:
-			# outfile is only used by iwmon, in which case we don't want
-			# to append to an existing file.
-			self._append_outfile(outfile, append=3DFalse)
-
-		if self.ctx.args.log:
-			testdir =3D os.getcwd()
-
-			# Special case any processes started prior to a test
-			# (i.e. from testhome). Put these in the root log directory
-			if testdir =3D=3D self.ctx.args.testhome:
-				testdir =3D '.'
-			else:
-				testdir =3D os.path.basename(testdir)
-
-			logfile =3D '%s/%s/%s' % (self.ctx.args.log, testdir, logfile)
-			self._append_outfile(logfile)
-
-		super().__init__(args, stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.STD=
OUT,
-					env=3Denv, cwd=3Dos.getcwd())
-
-		# Set as non-blocking so read() in the IO callback doesn't block forever
-		fl =3D fcntl.fcntl(self.stdout, fcntl.F_GETFL)
-		fcntl.fcntl(self.stdout, fcntl.F_SETFL, fl | os.O_NONBLOCK)
-
-		self.io_watch =3D GLib.io_add_watch(self.stdout, GLib.IO_IN |
-						GLib.IO_HUP | GLib.IO_ERR, self.process_io)
-
-		print("Starting process {}".format(self.args))
-
-		if check:
-			self.wait(10)
-			self.killed =3D True
-			if self.returncode !=3D 0:
-				raise subprocess.CalledProcessError(returncode=3Dself.returncode,
-									cmd=3Dargs)
-
-	@classmethod
-	def get_all(cls):
-		return cls.processes.values()
-
-	@classmethod
-	def kill_all(cls):
-		for p in cls.processes.values():
-			if p.args[0] =3D=3D 'dmesg':
-				continue
-
-			p.kill()
-
-	@staticmethod
-	def _write_io(instance, data, stdout=3DTrue):
-		for f in instance.write_fds:
-			f.write(data)
-
-			# Write out a separator so multiple process calls per
-			# test are easer to read.
-			if instance.hup:
-				f.write("Terminated: {}\n\n".format(instance.args))
-
-			f.flush()
-
-		if instance.verbose and stdout:
-			sys.__stdout__.write(data)
-			sys.__stdout__.flush()
-
-	@classmethod
-	def write_separators(cls, sep):
-		for proc in cls.processes.values():
-			if proc.killed:
-				continue
-
-			cls._write_io(proc, sep, stdout=3DFalse)
-
-	def process_io(self, source, condition):
-		if condition & GLib.IO_HUP:
-			self.hup =3D True
-
-		data =3D source.read()
-
-		if not data:
-			return True
-
-		data =3D data.decode('utf-8')
-
-		# Save data away in case the caller needs it (e.g. list_sta)
-		self.out +=3D data
-
-		self._write_io(self, data)
-
-		return True
-
-	def _append_outfile(self, file, append=3DTrue):
-		gid =3D int(os.environ.get('SUDO_GID', os.getgid()))
-		uid =3D int(os.environ.get('SUDO_UID', os.getuid()))
-		dir =3D os.path.dirname(file)
-
-		if not path_exists(dir):
-			os.mkdir(dir)
-			os.chown(dir, uid, gid)
-
-		file =3D os.path.join(dir,file)
-
-		# If the out file exists, append. Useful for processes like
-		# hostapd_cli where it is called multiple times independently.
-		if os.path.isfile(file) and append:
-			mode =3D 'a'
-		else:
-			mode =3D 'w'
-
-		try:
-			f =3D open(file, mode)
-		except Exception as e:
-			traceback.print_exc()
-			sys.exit(0)
-
-		os.fchown(f.fileno(), uid, gid)
-
-		self.write_fds.append(f)
-
-	def wait_for_socket(self, socket, wait):
-		Namespace.non_block_wait(os.path.exists, wait, socket)
-
-	# Wait for both process termination and HUP signal
-	def __wait(self, timeout):
-		try:
-			super().wait(timeout)
-			if not self.hup:
-				return False
-
-			return True
-		except:
-			return False
-
-	# Override wait() so it can do so non-blocking
-	def wait(self, timeout=3D10):
-		Namespace.non_block_wait(self.__wait, timeout, 1)
-		self._cleanup()
-
-	def _cleanup(self):
-		if self.cleanup:
-			self.cleanup()
-
-		self.write_fds =3D []
-
-		if self.io_watch:
-			GLib.source_remove(self.io_watch)
-			self.io_watch =3D None
-
-		self.cleanup =3D None
-		self.killed =3D True
-
-	# Override kill()
-	def kill(self, force=3DFalse):
-		if self.killed:
-			return
-
-		print("Killing process {}".format(self.args))
-
-		if force:
-			super().kill()
-		else:
-			self.terminate()
-
-		try:
-			self.wait(timeout=3D15)
-		except:
-			dbg("Process %s did not complete in 15 seconds!" % self.name)
-			super().kill()
-
-		self._cleanup()
-
-	def __str__(self):
-		return str(self.args) + '\n'
-
 class Interface:
 	def __init__(self, name, config):
 		self.name =3D name
@@ -447,9 +210,7 @@ class Hostapd:
 		A set of running hostapd instances. This is really just a single
 		process since hostapd can be started with multiple config files.
 	'''
-	def __init__(self, ctx, radios, configs, radius):
-		self.ctx =3D ctx
-
+	def __init__(self, radios, configs, radius):
 		if len(configs) !=3D len(radios):
 			raise Exception("Config (%d) and radio (%d) list length not equal" % \
 						(len(configs), len(radios)))
@@ -485,7 +246,7 @@ class Hostapd:
 		if radius:
 			args.append(radius)
 =

-		if ctx.is_verbose('hostapd'):
+		if Process.is_verbose('hostapd'):
 			args.append('-d')
 =

 		self.process =3D Process(args)
@@ -545,226 +306,13 @@ class Hostapd:
 =

 		# Hostapd may have already been stopped
 		if self.process:
-			self.ctx.stop_process(self.process)
-
-		self.ctx =3D None
+			self.process.kill()
 =

 		# Hostapd creates simdb sockets for EAP-SIM/AKA tests but does not
 		# clean them up.
 		for f in glob("/tmp/eap_sim_db*"):
 			os.remove(f)
 =

-dbus_count =3D 0
-
-class Namespace:
-	def __init__(self, args, name, radios):
-		self.dbus_address =3D None
-		self.name =3D name
-		self.radios =3D radios
-		self.args =3D args
-
-		Process(['ip', 'netns', 'add', name]).wait()
-		for r in radios:
-			Process(['iw', 'phy', r.name, 'set', 'netns', 'name', name]).wait()
-
-		self.start_dbus()
-
-	def reset(self):
-		self._bus =3D None
-
-		for r in self.radios:
-			r._radio =3D None
-
-		self.radios =3D []
-
-		Process.kill_all()
-
-	def __del__(self):
-		if self.name:
-			print("Removing namespace %s" % self.name)
-
-			Process(['ip', 'netns', 'del', self.name]).wait()
-
-	def get_bus(self):
-		return self._bus
-
-	def start_process(self, args, env=3DNone, **kwargs):
-		if not env:
-			env =3D os.environ.copy()
-
-		if hasattr(self, "dbus_address"):
-			# In case this process needs DBus...
-			env['DBUS_SYSTEM_BUS_ADDRESS'] =3D self.dbus_address
-
-		return Process(args, namespace=3Dself.name, env=3Denv, **kwargs)
-
-	def stop_process(self, p, force=3DFalse):
-		p.kill(force)
-
-	def is_process_running(self, process):
-		for p in Process.get_all():
-			if p.namespace =3D=3D self.name and p.args[0] =3D=3D process:
-				return True
-		return False
-
-	def _cleanup_dbus(self):
-		try:
-			os.remove(self.dbus_address.split('=3D')[1])
-		except:
-			pass
-
-		os.remove(self.dbus_cfg)
-
-	def start_dbus(self):
-		global dbus_count
-
-		self.dbus_address =3D 'unix:path=3D/tmp/dbus%d' % dbus_count
-		self.dbus_cfg =3D '/tmp/dbus%d.conf' % dbus_count
-		dbus_count +=3D 1
-
-		with open(self.dbus_cfg, 'w+') as f:
-			f.write(dbus_config)
-			f.write('<listen>%s</listen>\n' % self.dbus_address)
-			f.write('</busconfig>\n')
-
-		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % self.dbu=
s_cfg],
-					cleanup=3Dself._cleanup_dbus)
-
-		p.wait_for_socket(self.dbus_address.split('=3D')[1], 5)
-
-		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
-
-	def start_iwd(self, config_dir =3D '/tmp', storage_dir =3D '/tmp/iwd'):
-		args =3D []
-		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
-
-		if self.args.valgrind:
-			args.extend(['valgrind', '--leak-check=3Dfull', '--track-origins=3Dyes',
-					'--show-leak-kinds=3Dall',
-					'--log-file=3D/tmp/valgrind.log.%p'])
-
-		args.extend(['iwd', '-E'])
-
-		if iwd_radios !=3D '':
-			args.extend(['-p', iwd_radios])
-
-		if self.is_verbose(args[0]):
-			args.append('-d')
-
-		env =3D os.environ.copy()
-
-		env['CONFIGURATION_DIRECTORY'] =3D config_dir
-		env['STATE_DIRECTORY'] =3D storage_dir
-
-		if self.is_verbose('iwd-dhcp'):
-			env['IWD_DHCP_DEBUG'] =3D '1'
-
-		if self.is_verbose('iwd-tls'):
-			env['IWD_TLS_DEBUG'] =3D '1'
-
-		if self.is_verbose('iwd-acd'):
-			env['IWD_ACD_DEBUG'] =3D '1'
-
-		return self.start_process(args, env=3Denv)
-
-	def is_verbose(self, process, log=3DTrue):
-		process =3D os.path.basename(process)
-
-		if self.args is None:
-			return False
-
-		# every process is verbose when logging is enabled
-		if log and self.args.log:
-			return True
-
-		if process in self.args.verbose:
-			return True
-
-		# Special case here to enable verbose output with valgrind running
-		if process =3D=3D 'valgrind' and 'iwd' in self.args.verbose:
-			return True
-
-		# Handle any glob matches
-		for item in self.args.verbose:
-			if process in glob(item):
-				return True
-
-		return False
-
-	@staticmethod
-	def non_block_wait(func, timeout, *args, exception=3DTrue):
-		'''
-			Convenience function for waiting in a non blocking
-			manor using GLibs context iteration i.e. does not block
-			the main loop while waiting.
-
-			'func' will be called at least once and repeatedly until
-			either it returns success, throws an exception, or the
-			'timeout' expires.
-
-			'timeout' is the ultimate timeout in seconds
-
-			'*args' will be passed to 'func'
-
-			If 'exception' is an Exception type it will be raised.
-			If 'exception' is True a generic TimeoutError will be raised.
-			Any other value will not result in an exception.
-		'''
-		# Simple class for signaling the wait timeout
-		class Bool:
-			def __init__(self, value):
-				self.value =3D value
-
-		def wait_timeout_cb(done):
-			done.value =3D True
-			return False
-
-		mainloop =3D GLib.MainLoop()
-		done =3D Bool(False)
-
-		timeout =3D GLib.timeout_add_seconds(timeout, wait_timeout_cb, done)
-		context =3D mainloop.get_context()
-
-		while True:
-			try:
-				ret =3D func(*args)
-				if ret:
-					if not done.value:
-						GLib.source_remove(timeout)
-					return ret
-			except Exception as e:
-				if not done.value:
-					GLib.source_remove(timeout)
-				raise e
-
-			if done.value =3D=3D True:
-				if isinstance(exception, Exception):
-					raise exception
-				elif type(exception) =3D=3D bool and exception:
-					raise TimeoutError("Timeout on non_block_wait")
-				else:
-					return
-
-			context.iteration(may_block=3DTrue)
-
-	def __str__(self):
-		ret =3D 'Namespace: %s\n' % self.name
-		ret +=3D 'Processes:\n'
-		for p in Process.get_all():
-			ret +=3D '\t%s' % str(p)
-
-		ret +=3D 'Radios:\n'
-		if len(self.radios) > 0:
-			for r in self.radios:
-				ret +=3D '\t%s\n' % str(r)
-		else:
-			ret +=3D '\tNo Radios\n'
-
-		ret +=3D 'DBus Address: %s\n' % self.dbus_address
-		ret +=3D '=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n\n'
-
-		return ret
-
 class BarChart():
 	def __init__(self, height=3D10, max_width=3D80):
 		self._height =3D height
@@ -828,7 +376,7 @@ class TestContext(Namespace):
 		self._mem_chart =3D BarChart()
 =

 	def start_dbus_monitor(self):
-		if not self.is_verbose('dbus-monitor'):
+		if not Process.is_verbose('dbus-monitor'):
 			return
 =

 		self.start_process(['dbus-monitor', '--address', self.dbus_address])
@@ -933,7 +481,7 @@ class TestContext(Namespace):
 =

 		radius_config =3D settings.get('radius_server', None)
 =

-		self.hostapd =3D Hostapd(self, hapd_radios, hapd_configs, radius_config)
+		self.hostapd =3D Hostapd(hapd_radios, hapd_configs, radius_config)
 		self.hostapd.attach_cli()
 =

 	def get_frequencies(self):
@@ -1001,7 +549,7 @@ class TestContext(Namespace):
 		time.sleep(3)
 =

 		ofono_args =3D ['ofonod', '-n', '--plugin=3Datmodem,phonesim']
-		if self.is_verbose('ofonod'):
+		if Process.is_verbose('ofonod'):
 			ofono_args.append('-d')
 =

 		self.start_process(ofono_args)
diff --git a/tools/utils.py b/tools/utils.py
new file mode 100644
index 00000000..4c71e934
--- /dev/null
+++ b/tools/utils.py
@@ -0,0 +1,455 @@
+import os
+import subprocess
+import fcntl
+import sys
+import traceback
+import shutil
+import dbus
+
+from gi.repository import GLib
+from weakref import WeakValueDictionary
+from glob import glob
+
+from runner import RunnerCoreArgParse
+
+class Process(subprocess.Popen):
+	processes =3D WeakValueDictionary()
+	testargs =3D RunnerCoreArgParse().parse_args()
+
+	def __new__(cls, *args, **kwargs):
+		obj =3D super().__new__(cls)
+		cls.processes[id(obj)] =3D obj
+		return obj
+
+	def __init__(self, args, namespace=3DNone, outfile=3DNone, env=3DNone, ch=
eck=3DFalse, cleanup=3DNone):
+		self.write_fds =3D []
+		self.io_watch =3D None
+		self.cleanup =3D cleanup
+		self.verbose =3D False
+		self.out =3D ''
+		self.hup =3D False
+		self.killed =3D False
+		self.namespace =3D namespace
+
+		logfile =3D args[0]
+
+		if Process.is_verbose(args[0], log=3DFalse):
+			self.verbose =3D True
+
+		if namespace:
+			args =3D ['ip', 'netns', 'exec', namespace] + args
+			logfile +=3D '-%s' % namespace
+
+		if outfile:
+			# outfile is only used by iwmon, in which case we don't want
+			# to append to an existing file.
+			self._append_outfile(outfile, append=3DFalse)
+
+		if self.testargs.log:
+			testdir =3D os.getcwd()
+
+			# Special case any processes started prior to a test
+			# (i.e. from testhome). Put these in the root log directory
+			if testdir =3D=3D self.testargs.testhome:
+				testdir =3D '.'
+			else:
+				testdir =3D os.path.basename(testdir)
+
+			logfile =3D '%s/%s/%s' % (self.testargs.log, testdir, logfile)
+			self._append_outfile(logfile)
+
+		super().__init__(args, stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.STD=
OUT,
+					env=3Denv, cwd=3Dos.getcwd())
+
+		# Set as non-blocking so read() in the IO callback doesn't block forever
+		fl =3D fcntl.fcntl(self.stdout, fcntl.F_GETFL)
+		fcntl.fcntl(self.stdout, fcntl.F_SETFL, fl | os.O_NONBLOCK)
+
+		self.io_watch =3D GLib.io_add_watch(self.stdout, GLib.IO_IN |
+						GLib.IO_HUP | GLib.IO_ERR, self.process_io)
+
+		print("Starting process {}".format(self.args))
+
+		if check:
+			self.wait(10)
+			self.killed =3D True
+			if self.returncode !=3D 0:
+				raise subprocess.CalledProcessError(returncode=3Dself.returncode,
+									cmd=3Dargs)
+
+	@staticmethod
+	def is_verbose(process, log=3DTrue):
+		process =3D os.path.basename(process)
+
+		if Process.testargs is None:
+			return False
+
+		# every process is verbose when logging is enabled
+		if log and Process.testargs.log:
+			return True
+
+		if process in Process.testargs.verbose:
+			return True
+
+		# Special case here to enable verbose output with valgrind running
+		if process =3D=3D 'valgrind' and 'iwd' in Process.testargs.verbose:
+			return True
+
+		# Handle any glob matches
+		for item in Process.testargs.verbose:
+			if process in glob(item):
+				return True
+
+		return False
+
+	@classmethod
+	def get_all(cls):
+		return cls.processes.values()
+
+	@classmethod
+	def kill_all(cls):
+		for p in cls.processes.values():
+			if p.args[0] =3D=3D 'dmesg':
+				continue
+
+			p.kill()
+
+	@staticmethod
+	def _write_io(instance, data, stdout=3DTrue):
+		for f in instance.write_fds:
+			f.write(data)
+
+			# Write out a separator so multiple process calls per
+			# test are easer to read.
+			if instance.hup:
+				f.write("Terminated: {}\n\n".format(instance.args))
+
+			f.flush()
+
+		if instance.verbose and stdout:
+			sys.__stdout__.write(data)
+			sys.__stdout__.flush()
+
+	@classmethod
+	def write_separators(cls, sep):
+		for proc in cls.processes.values():
+			if proc.killed:
+				continue
+
+			cls._write_io(proc, sep, stdout=3DFalse)
+
+	def process_io(self, source, condition):
+		if condition & GLib.IO_HUP:
+			self.hup =3D True
+
+		data =3D source.read()
+
+		if not data:
+			return True
+
+		data =3D data.decode('utf-8')
+
+		# Save data away in case the caller needs it (e.g. list_sta)
+		self.out +=3D data
+
+		self._write_io(self, data)
+
+		return True
+
+	def _append_outfile(self, file, append=3DTrue):
+		gid =3D int(os.environ.get('SUDO_GID', os.getgid()))
+		uid =3D int(os.environ.get('SUDO_UID', os.getuid()))
+		dir =3D os.path.dirname(file)
+
+		if not os.path.exists(dir):
+			os.mkdir(dir)
+			os.chown(dir, uid, gid)
+
+		file =3D os.path.join(dir,file)
+
+		# If the out file exists, append. Useful for processes like
+		# hostapd_cli where it is called multiple times independently.
+		if os.path.isfile(file) and append:
+			mode =3D 'a'
+		else:
+			mode =3D 'w'
+
+		try:
+			f =3D open(file, mode)
+		except Exception as e:
+			traceback.print_exc()
+			sys.exit(0)
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
+		self._cleanup()
+
+	def _cleanup(self):
+		if self.cleanup:
+			self.cleanup()
+
+		self.write_fds =3D []
+
+		if self.io_watch:
+			GLib.source_remove(self.io_watch)
+			self.io_watch =3D None
+
+		self.cleanup =3D None
+		self.killed =3D True
+
+	# Override kill()
+	def kill(self, force=3DFalse):
+		if self.killed:
+			return
+
+		print("Killing process {}".format(self.args))
+
+		if force:
+			super().kill()
+		else:
+			self.terminate()
+
+		try:
+			self.wait(timeout=3D15)
+		except:
+			print("Process %s did not complete in 15 seconds!" % self.name)
+			super().kill()
+
+		self._cleanup()
+
+	def __str__(self):
+		return str(self.args) + '\n'
+
+dbus_count =3D 0
+# Partial DBus config. The remainder (<listen>) will be filled in for each
+# namespace that is created so each individual dbus-daemon has its own soc=
ket
+# and address.
+dbus_config =3D '''
+<!DOCTYPE busconfig PUBLIC \
+"-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN" \
+"http://www.freedesktop.org/standards/dbus/1.0/\
+busconfig.dtd\">
+<busconfig>
+<type>system</type>
+<limit name=3D\"reply_timeout\">2147483647</limit>
+<auth>ANONYMOUS</auth>
+<allow_anonymous/>
+<policy context=3D\"default\">
+<allow user=3D\"*\"/>
+<allow own=3D\"*\"/>
+<allow send_type=3D\"method_call\"/>
+<allow send_type=3D\"signal\"/>
+<allow send_type=3D\"method_return\"/>
+<allow send_type=3D\"error\"/>
+<allow receive_type=3D\"method_call\"/>
+<allow receive_type=3D\"signal\"/>
+<allow receive_type=3D\"method_return\"/>
+<allow receive_type=3D\"error\"/>
+<allow send_destination=3D\"*\" eavesdrop=3D\"true\"/>
+<allow eavesdrop=3D\"true\"/>
+</policy>
+'''
+
+class Namespace:
+	def __init__(self, args, name, radios):
+		self.dbus_address =3D None
+		self.name =3D name
+		self.radios =3D radios
+		self.args =3D args
+
+		Process(['ip', 'netns', 'add', name]).wait()
+		for r in radios:
+			Process(['iw', 'phy', r.name, 'set', 'netns', 'name', name]).wait()
+
+		self.start_dbus()
+
+	def reset(self):
+		self._bus =3D None
+
+		for r in self.radios:
+			r._radio =3D None
+
+		self.radios =3D []
+
+		Process.kill_all()
+
+	def __del__(self):
+		if self.name:
+			print("Removing namespace %s" % self.name)
+
+			Process(['ip', 'netns', 'del', self.name]).wait()
+
+	def get_bus(self):
+		return self._bus
+
+	def start_process(self, args, env=3DNone, **kwargs):
+		if not env:
+			env =3D os.environ.copy()
+
+		if hasattr(self, "dbus_address"):
+			# In case this process needs DBus...
+			env['DBUS_SYSTEM_BUS_ADDRESS'] =3D self.dbus_address
+
+		return Process(args, namespace=3Dself.name, env=3Denv, **kwargs)
+
+	def stop_process(self, p, force=3DFalse):
+		p.kill(force)
+
+	def is_process_running(self, process):
+		for p in Process.get_all():
+			if p.namespace =3D=3D self.name and p.args[0] =3D=3D process:
+				return True
+		return False
+
+	def _cleanup_dbus(self):
+		try:
+			os.remove(self.dbus_address.split('=3D')[1])
+		except:
+			pass
+
+		os.remove(self.dbus_cfg)
+
+	def start_dbus(self):
+		global dbus_count
+
+		self.dbus_address =3D 'unix:path=3D/tmp/dbus%d' % dbus_count
+		self.dbus_cfg =3D '/tmp/dbus%d.conf' % dbus_count
+		dbus_count +=3D 1
+
+		with open(self.dbus_cfg, 'w+') as f:
+			f.write(dbus_config)
+			f.write('<listen>%s</listen>\n' % self.dbus_address)
+			f.write('</busconfig>\n')
+
+		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % self.dbu=
s_cfg],
+					cleanup=3Dself._cleanup_dbus)
+
+		p.wait_for_socket(self.dbus_address.split('=3D')[1], 5)
+
+		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
+
+	def start_iwd(self, config_dir =3D '/tmp', storage_dir =3D '/tmp/iwd'):
+		args =3D []
+		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
+
+		if self.args.valgrind:
+			args.extend(['valgrind', '--leak-check=3Dfull', '--track-origins=3Dyes',
+					'--show-leak-kinds=3Dall',
+					'--log-file=3D/tmp/valgrind.log.%p'])
+
+		args.extend(['iwd', '-E'])
+
+		if iwd_radios !=3D '':
+			args.extend(['-p', iwd_radios])
+
+		if Process.is_verbose(args[0]):
+			args.append('-d')
+
+		env =3D os.environ.copy()
+
+		env['CONFIGURATION_DIRECTORY'] =3D config_dir
+		env['STATE_DIRECTORY'] =3D storage_dir
+
+		if Process.is_verbose('iwd-dhcp'):
+			env['IWD_DHCP_DEBUG'] =3D '1'
+
+		if Process.is_verbose('iwd-tls'):
+			env['IWD_TLS_DEBUG'] =3D '1'
+
+		if Process.is_verbose('iwd-acd'):
+			env['IWD_ACD_DEBUG'] =3D '1'
+
+		return self.start_process(args, env=3Denv)
+
+	@staticmethod
+	def non_block_wait(func, timeout, *args, exception=3DTrue):
+		'''
+			Convenience function for waiting in a non blocking
+			manor using GLibs context iteration i.e. does not block
+			the main loop while waiting.
+
+			'func' will be called at least once and repeatedly until
+			either it returns success, throws an exception, or the
+			'timeout' expires.
+
+			'timeout' is the ultimate timeout in seconds
+
+			'*args' will be passed to 'func'
+
+			If 'exception' is an Exception type it will be raised.
+			If 'exception' is True a generic TimeoutError will be raised.
+			Any other value will not result in an exception.
+		'''
+		# Simple class for signaling the wait timeout
+		class Bool:
+			def __init__(self, value):
+				self.value =3D value
+
+		def wait_timeout_cb(done):
+			done.value =3D True
+			return False
+
+		mainloop =3D GLib.MainLoop()
+		done =3D Bool(False)
+
+		timeout =3D GLib.timeout_add_seconds(timeout, wait_timeout_cb, done)
+		context =3D mainloop.get_context()
+
+		while True:
+			try:
+				ret =3D func(*args)
+				if ret:
+					if not done.value:
+						GLib.source_remove(timeout)
+					return ret
+			except Exception as e:
+				if not done.value:
+					GLib.source_remove(timeout)
+				raise e
+
+			if done.value =3D=3D True:
+				if isinstance(exception, Exception):
+					raise exception
+				elif type(exception) =3D=3D bool and exception:
+					raise TimeoutError("Timeout on non_block_wait")
+				else:
+					return
+
+			context.iteration(may_block=3DTrue)
+
+	def __str__(self):
+		ret =3D 'Namespace: %s\n' % self.name
+		ret +=3D 'Processes:\n'
+		for p in Process.get_all():
+			ret +=3D '\t%s' % str(p)
+
+		ret +=3D 'Radios:\n'
+		if len(self.radios) > 0:
+			for r in self.radios:
+				ret +=3D '\t%s\n' % str(r)
+		else:
+			ret +=3D '\tNo Radios\n'
+
+		ret +=3D 'DBus Address: %s\n' % self.dbus_address
+		ret +=3D '=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n\n'
+
+		return ret
-- =

2.34.1

--===============1003032190634492970==--

