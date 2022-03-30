Content-Type: multipart/mixed; boundary="===============8604668553673961898=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/7] test-runner: rename test-runner, add run-tests
Date: Wed, 30 Mar 2022 15:20:53 -0700
Message-ID: <20220330222057.2160244-3-prestwoj@gmail.com>
In-Reply-To: 20220330222057.2160244-1-prestwoj@gmail.com

--===============8604668553673961898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to keep all test-runner dev scripts working and to work with
the new runner.py system some file renaming was required.

test-runner was renamed to run-tests
A new test-runner was added which only creates the Runner() class.
---
 tools/run-tests   | 1526 +++++++++++++++++++++++++++++++++++++++++++++
 tools/test-runner | 1525 +-------------------------------------------
 2 files changed, 1527 insertions(+), 1524 deletions(-)
 create mode 100755 tools/run-tests

diff --git a/tools/run-tests b/tools/run-tests
new file mode 100755
index 00000000..716126d0
--- /dev/null
+++ b/tools/run-tests
@@ -0,0 +1,1526 @@
+#!/usr/bin/python3
+
+import os
+import shutil
+import fcntl
+import sys
+import subprocess
+import atexit
+import time
+import unittest
+import importlib
+from unittest.result import TestResult
+import multiprocessing
+import re
+import traceback
+
+from runner import Runner
+
+from configparser import ConfigParser
+from prettytable import PrettyTable
+from termcolor import colored
+from glob import glob
+from collections import namedtuple
+from time import sleep
+import dbus.mainloop.glib
+from gi.repository import GLib
+from weakref import WeakValueDictionary
+
+config =3D None
+intf_id =3D 0
+
+TEST_MAX_TIMEOUT =3D 240
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+def dbg(*s, **kwargs):
+	'''
+		Allows prints if stdout has been re-directed
+	'''
+	print(*s, **kwargs, file=3Dsys.__stdout__)
+
+def exit_vm():
+	if config:
+		for p in Process.get_all():
+			print("Process %s still running!" % p.args[0])
+			p.kill()
+
+		if config.ctx and config.ctx.results:
+			success =3D print_results(config.ctx.results)
+		else:
+			success =3D False
+
+		if config.ctx.args.result:
+			result =3D 'PASS' if success else 'FAIL'
+			with open(config.ctx.args.result, 'w') as f:
+				f.write(result)
+
+	os.sync()
+
+	runner.stop()
+
+def path_exists(path):
+	'''
+		Searches PATH as well as absolute paths.
+	'''
+	if shutil.which(path):
+		return True
+	try:
+		os.stat(path)
+	except:
+		return False
+	return True
+
+def find_binary(list):
+	'''
+		Returns a binary from 'list' if its found in PATH or on a
+		valid absolute path.
+	'''
+	for path in list:
+		if path_exists(path):
+			return path
+	return None
+
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
+class Process(subprocess.Popen):
+	processes =3D WeakValueDictionary()
+	ctx =3D None
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
+		if not self.ctx:
+			global config
+			self.ctx =3D config.ctx
+
+		if self.ctx.is_verbose(args[0], log=3DFalse):
+			self.verbose =3D True
+
+		if namespace:
+			args =3D ['ip', 'netns', 'exec', namespace] + args
+
+		if outfile:
+			# outfile is only used by iwmon, in which case we don't want
+			# to append to an existing file.
+			self._append_outfile(outfile, append=3DFalse)
+
+		if self.ctx.args.log:
+			logfile =3D '%s/%s/%s' % (self.ctx.args.log,
+						os.path.basename(os.getcwd()),
+						args[0])
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
+	@classmethod
+	def get_all(cls):
+		return cls.processes.values()
+
+	@classmethod
+	def kill_all(cls):
+		for p in cls.processes.values():
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
+		if not path_exists(dir):
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
+			dbg("Process %s did not complete in 15 seconds!" % self.name)
+			super().kill()
+
+		self._cleanup()
+
+	def __str__(self):
+		return str(self.args) + '\n'
+
+class Interface:
+	def __init__(self, name, config):
+		self.name =3D name
+		self.ctrl_interface =3D '/var/run/hostapd/' + name
+		self.config =3D config
+
+	def __del__(self):
+		Process(['iw', 'dev', self.name, 'del']).wait()
+
+	def set_interface_state(self, state):
+		Process(['ip', 'link', 'set', self.name, state]).wait()
+
+class Radio:
+	def __init__(self, name):
+		self.name =3D name
+		# hostapd will reset this if this radio is used by it
+		self.use =3D 'iwd'
+		self.interface =3D None
+
+	def __del__(self):
+		print("Removing radio %s" % self.name)
+		self.interface =3D None
+
+	def create_interface(self, config, use):
+		global intf_id
+
+		ifname =3D 'wln%s' % intf_id
+
+		intf_id +=3D 1
+
+		self.interface =3D Interface(ifname, config)
+		self.use =3D use
+
+		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
+				'type', 'managed']).wait()
+
+		return self.interface
+
+	def __str__(self):
+		ret =3D self.name + ':\n'
+		ret +=3D '\tUsed By: %s ' % self.use
+		if self.interface:
+			ret +=3D '(%s)' % self.interface.name
+
+		ret +=3D '\n'
+
+		return ret
+
+class VirtualRadio(Radio):
+	'''
+		A subclass of 'Radio' specific to mac80211_hwsim radios.
+
+		TODO: Using D-Bus to create and destroy radios is more desireable
+		than the command line.
+	'''
+
+	def __init__(self, name, cfg=3DNone):
+		global config
+
+		self.disable_cipher =3D None
+		self.disable_iftype =3D None
+
+		self.hwsim =3D config.hwsim.Hwsim()
+
+		if cfg:
+			self.disable_iftype =3D cfg.get('iftype_disable', None)
+			self.disable_cipher =3D cfg.get('cipher_disable', None)
+
+		self._radio =3D self.hwsim.radios.create(name, p2p_device=3DTrue,
+					iftype_disable=3Dself.disable_iftype,
+					cipher_disable=3Dself.disable_cipher)
+
+		super().__init__(self._radio.name)
+
+	def __del__(self):
+		super().__del__()
+
+		# If the radio was moved into a namespace this will fail
+		try:
+			self._radio.remove()
+		except:
+			pass
+
+		self._radio =3D None
+
+	def __str__(self):
+		ret =3D super().__str__()
+
+		if self.disable_iftype:
+			ret +=3D '\tDisabled interface types: %s\n' % self.disable_iftype
+
+		if self.disable_cipher:
+			ret +=3D '\tDisabled ciphers: %s\n' % self.disable_cipher
+
+		ret +=3D '\tPath: %s' % self._radio.path
+
+		ret +=3D '\n'
+
+		return ret
+
+class HostapdInstance:
+	'''
+		A single instance of hostapd. In reality all hostapd instances
+		are started as a single process. This class just makes things
+		convenient for communicating with one of the hostapd APs.
+	'''
+	def __init__(self, config, radio):
+		self.radio =3D radio
+		self.config =3D config
+		self.cli =3D None
+
+		self.intf =3D radio.create_interface(self.config, 'hostapd')
+		self.intf.set_interface_state('up')
+
+	def __del__(self):
+		print("Removing HostapdInstance %s" % self.config)
+		self.intf.set_interface_state('down')
+		self.radio =3D None
+		self.intf =3D None
+
+	def __str__(self):
+		ret =3D 'Hostapd (%s)\n' % self.intf.name
+		ret +=3D '\tConfig: %s\n' % self.config
+
+		return ret
+
+class Hostapd:
+	'''
+		A set of running hostapd instances. This is really just a single
+		process since hostapd can be started with multiple config files.
+	'''
+	def __init__(self, ctx, radios, configs, radius):
+		self.ctx =3D ctx
+
+		if len(configs) !=3D len(radios):
+			raise Exception("Config (%d) and radio (%d) list length not equal" % \
+						(len(configs), len(radios)))
+
+		print("Initializing hostapd instances")
+
+		Process(['ip', 'link', 'set', 'eth0', 'up']).wait()
+		Process(['ip', 'link', 'set', 'eth1', 'up']).wait()
+
+		self.global_ctrl_iface =3D '/var/run/hostapd/ctrl'
+
+		self.instances =3D [HostapdInstance(c, r) for c, r in zip(configs, radio=
s)]
+
+		ifaces =3D [rad.interface.name for rad in radios]
+		ifaces =3D ','.join(ifaces)
+
+		args =3D ['hostapd', '-g', self.global_ctrl_iface]
+
+		if ifaces:
+			args.extend(['-i', ifaces])
+
+		#
+		# Config files should already be present in /tmp. This appends
+		# ctrl_interface and does any variable replacement. Currently
+		# this is just any $ifaceN occurrences.
+		#
+		for c in configs:
+			full_path =3D '/tmp/%s' % c
+			args.append(full_path)
+
+			self._rewrite_config(full_path)
+
+		if radius:
+			args.append(radius)
+
+		if ctx.is_verbose('hostapd'):
+			args.append('-d')
+
+		self.process =3D Process(args)
+
+		self.process.wait_for_socket(self.global_ctrl_iface, 30)
+
+		for hapd in self.instances:
+			self.process.wait_for_socket(hapd.intf.ctrl_interface, 30)
+
+	def attach_cli(self):
+		global config
+
+		for hapd in self.instances:
+			hapd.cli =3D config.hostapd.HostapdCLI(config=3Dhapd.config)
+
+	def _rewrite_config(self, config):
+		'''
+			Replaces any $ifaceN values with the correct interface
+			names as well as appends the ctrl_interface path to
+			the config file.
+		'''
+		with open(config, 'r+') as f:
+			data =3D f.read()
+			to_replace =3D []
+			for match in re.finditer(r'\$iface[0-9]+', data):
+				tag =3D data[match.start():match.end()]
+				idx =3D tag.split('iface')[1]
+
+				to_replace.append((tag, self.instances[int(idx)].intf.name))
+
+			for r in to_replace:
+				data =3D data.replace(r[0], r[1], 1)
+
+			data +=3D '\nctrl_interface=3D/var/run/hostapd\n'
+
+			f.write(data)
+
+	def __getitem__(self, config):
+		if not config:
+			return self.instances[0]
+
+		for hapd in self.instances:
+			if hapd.config =3D=3D config:
+				return hapd
+
+		return None
+
+	def __del__(self):
+		print("Removing Hostapd")
+		try:
+			os.remove(self.global_ctrl_iface)
+		except:
+			print("Failed to remove %s" % self.global_ctrl_iface)
+
+		self.instances =3D None
+
+		# Hostapd may have already been stopped
+		if self.process:
+			self.ctx.stop_process(self.process)
+
+		self.ctx =3D None
+
+		# Hostapd creates simdb sockets for EAP-SIM/AKA tests but does not
+		# clean them up.
+		for f in glob("/tmp/eap_sim_db*"):
+			os.remove(f)
+
+dbus_count =3D 0
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
+		if self.is_verbose(args[0]):
+			args.append('-d')
+
+		env =3D os.environ.copy()
+
+		env['CONFIGURATION_DIRECTORY'] =3D config_dir
+		env['STATE_DIRECTORY'] =3D storage_dir
+
+		if self.is_verbose('iwd-dhcp'):
+			env['IWD_DHCP_DEBUG'] =3D '1'
+
+		if self.is_verbose('iwd-tls'):
+			env['IWD_TLS_DEBUG'] =3D '1'
+
+		if self.is_verbose('iwd-acd'):
+			env['IWD_ACD_DEBUG'] =3D '1'
+
+		return self.start_process(args, env=3Denv)
+
+	def is_verbose(self, process, log=3DTrue):
+		process =3D os.path.basename(process)
+
+		if self.args is None:
+			return False
+
+		# every process is verbose when logging is enabled
+		if log and self.args.log:
+			return True
+
+		if process in self.args.verbose:
+			return True
+
+		# Special case here to enable verbose output with valgrind running
+		if process =3D=3D 'valgrind' and 'iwd' in self.args.verbose:
+			return True
+
+		# Handle any glob matches
+		for item in self.args.verbose:
+			if process in glob(item):
+				return True
+
+		return False
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
+			context.iteration(may_block=3DFalse)
+
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
+			sleep(0.1)
+
+			if done.value =3D=3D True:
+				if isinstance(exception, Exception):
+					raise exception
+				elif type(exception) =3D=3D bool and exception:
+					raise TimeoutError("Timeout on non_block_wait")
+				else:
+					return
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
+
+class BarChart():
+	def __init__(self, height=3D10, max_width=3D80):
+		self._height =3D height
+		self._max_width =3D max_width
+		self._values =3D []
+		self._max_value =3D 0
+		self._min_value =3D 0
+
+	def add_value(self, value):
+		if len(self._values) =3D=3D 0:
+			self._max_value =3D int(1.01 * value)
+			self._min_value =3D int(0.99 * value)
+		elif value > self._max_value:
+			self._max_value =3D int(1.01 * value)
+		elif value < self._min_value:
+			self._min_value =3D int(0.99 * value)
+
+		self._values.append(value)
+
+	def _value_to_stars(self, value):
+		# Need to scale value (range of min_value -> max_value) to
+		# a range of 0 -> height
+		#
+		# Scaled =3D ((value - min_value) / ( max_value - min_value)) * (Height =
- 0) + 0
+
+		return int(((value - self._min_value) /
+			(self._max_value - self._min_value)) * self._height)
+
+	def __str__(self):
+		# Need to map value from range 0 - self._height
+		ret =3D ''
+
+		for i, value in enumerate(self._values):
+			stars =3D self._value_to_stars(value)
+			ret +=3D '[%3u] ' % i + '%-10s' % ('*' * stars) + '\t\t\t%d\n' % value
+
+		ret +=3D '\n'
+
+		return ret
+
+
+class TestContext(Namespace):
+	'''
+		Contains all information for a given set of tests being run
+		such as processes, radios, interfaces and test results.
+	'''
+	def __init__(self, args):
+		self.name =3D None
+		self.args =3D args
+		self.hw_config =3D None
+		self.hostapd =3D None
+		self.wpas_interfaces =3D None
+		self.cur_radio_id =3D 0
+		self.cur_iface_id =3D 0
+		self.radios =3D []
+		self.loopback_started =3D False
+		self.results =3D {}
+		self.mainloop =3D GLib.MainLoop()
+		self.namespaces =3D []
+		self._last_mem_available =3D 0
+		self._mem_chart =3D BarChart()
+
+	def start_dbus_monitor(self):
+		if not self.is_verbose('dbus-monitor'):
+			return
+
+		self.start_process(['dbus-monitor', '--address', self.dbus_address])
+
+	def start_haveged(self):
+		self.start_process(['haveged', '-F'])
+
+	def create_radios(self):
+		setup =3D self.hw_config['SETUP']
+		nradios =3D int(setup['num_radios'])
+		args =3D ['hwsim']
+
+		if self.hw_config['SETUP'].get('hwsim_medium', 'no') in ['no', '0', 'fal=
se']:
+			# register hwsim as medium
+			args.extend(['--no-register'])
+
+		self.start_process(args)
+		self.non_block_wait(self._bus.name_has_owner, 20, 'net.connman.hwsim',
+					exception=3DTimeoutError('net.connman.hwsim did not appear'))
+
+		for i in range(nradios):
+			name =3D 'rad%u' % i
+
+			# Get any [radX] sections. These are for configuring
+			# any special radios. This no longer requires a
+			# radio_conf list, we just assume radios start rad0
+			# and increment.
+			rad_config =3D None
+			if self.hw_config.has_section(name):
+				rad_config =3D self.hw_config[name]
+
+			self.radios.append(VirtualRadio(name, rad_config))
+			self.cur_radio_id +=3D 1
+
+	def discover_radios(self):
+		import pyroute2
+
+		phys =3D []
+
+		try:
+			iw =3D pyroute2.iwutil.IW()
+		except:
+			iw =3D pyroute2.IW()
+
+		attrs =3D [phy['attrs'] for phy in iw.list_wiphy()]
+
+		for attr in attrs:
+			for key, value in attr:
+				if key =3D=3D 'NL80211_ATTR_WIPHY_NAME':
+					if value not in phys:
+						phys.append(value)
+					break
+
+		print('Discovered radios: %s' % str(phys))
+		self.radios =3D [Radio(name) for name in phys]
+
+	def start_radios(self):
+		reg_domain =3D self.hw_config['SETUP'].get('reg_domain', None)
+		if reg_domain:
+			Process(['iw', 'reg', 'set', reg_domain]).wait()
+
+		if self.args.hw:
+			self.discover_radios()
+		else:
+			self.create_radios()
+
+	def start_hostapd(self):
+		if not 'HOSTAPD' in self.hw_config:
+			return
+
+		settings =3D self.hw_config['HOSTAPD']
+
+		if self.args.hw:
+			# Just grab the first N radios. It gets rather
+			# complicated trying to map radX radios specified in
+			# hw.conf so any passed through physical adapters are
+			# just given to hostapd/IWD as they appear during
+			# discovery.
+			#
+			# TODO: It may be desireable to map PCI/USB adapters to
+			#       specific radX radios specified in the config but
+			#       there are really 2 separate use cases here.
+			#       1. You want to test a *specific* radio with IWD
+			#          or hostapd. For this you would want radX
+			#          to map to a specific radio
+			#       2. You have many adapters in use to run multiple
+			#          tests. In this case you would not care what
+			#          was using each radio, just that there was
+			#          enough to run all tests.
+			nradios =3D 0
+			for k, _ in settings.items():
+				if k =3D=3D 'radius_server':
+					continue
+				nradios +=3D 1
+
+			hapd_radios =3D self.radios[:nradios]
+
+		else:
+			hapd_radios =3D [rad for rad in self.radios if rad.name in settings]
+
+		hapd_configs =3D [conf for rad, conf in settings.items() if rad !=3D 'ra=
dius_server']
+
+		radius_config =3D settings.get('radius_server', None)
+
+		self.hostapd =3D Hostapd(self, hapd_radios, hapd_configs, radius_config)
+		self.hostapd.attach_cli()
+
+	def get_frequencies(self):
+		frequencies =3D []
+
+		for hapd in self.hostapd.instances:
+			frequencies.append(hapd.cli.frequency)
+
+		return frequencies
+
+	def start_wpas_interfaces(self):
+
+		if 'WPA_SUPPLICANT' not in self.hw_config:
+			return
+
+		settings =3D self.hw_config['WPA_SUPPLICANT']
+
+		if self.args.hw:
+			nradios =3D len(settings.items())
+
+			wpas_radios =3D self.radios[:nradios]
+			self.wpas_interfaces =3D []
+
+			#
+			# Physical radios most likely will use a different name
+			# than 'rad#' but the config file is referenced by these
+			# 'rad#' names. Iterate through both the settings and
+			# physical radios to create interfaces associated with
+			# each config file.
+			#
+			for vrad, hwrad in zip(settings.items(), wpas_radios):
+				self.wpas_interfaces.append(hwrad.create_interface(vrad[1], 'wpas'))
+
+		else:
+			wpas_radios =3D [rad for rad in self.radios if rad.name in settings]
+			self.wpas_interfaces =3D [rad.create_interface(settings[rad.name], 'wpa=
s') \
+						for rad in wpas_radios]
+
+	def start_ofono(self):
+		sim_keys =3D self.hw_config['SETUP'].get('sim_keys', None)
+		if not sim_keys:
+			print("Ofono not requred")
+			return
+		elif sim_keys !=3D 'ofono':
+			os.environ['IWD_SIM_KEYS'] =3D sim_keys
+			return
+
+		if not find_binary(['ofonod']) or not find_binary(['phonesim']):
+			print("Ofono or Phonesim not found, skipping test")
+			return
+
+		Process(['ip', 'link', 'set', 'lo', 'up']).wait()
+
+		os.environ['OFONO_PHONESIM_CONFIG'] =3D '/tmp/phonesim.conf'
+
+		phonesim_args =3D ['phonesim', '-p', '12345', '/usr/share/phonesim/defau=
lt.xml']
+
+		self.start_process(phonesim_args)
+
+		#
+		# TODO:
+		# Is there something to wait for? Without this phonesim rejects
+		# connections on all but the fist test.
+		#
+		time.sleep(3)
+
+		ofono_args =3D ['ofonod', '-n', '--plugin=3Datmodem,phonesim']
+		if self.is_verbose('ofonod'):
+			ofono_args.append('-d')
+
+		self.start_process(ofono_args)
+
+		print("Ofono started")
+
+	def create_namespaces(self):
+		if not self.hw_config.has_section('NameSpaces'):
+			return
+
+		for key, value in self.hw_config.items('NameSpaces'):
+			radio_names =3D value.split(',')
+			# Gather up radio objects for this namespace
+			radios =3D [rad for rad in self.radios if rad.name in radio_names]
+
+			# Remove radios from 'root' namespace
+			self.radios =3D list(set(self.radios) - set(radios))
+
+			self.namespaces.append(Namespace(self.args, key, radios))
+
+	def get_namespace(self, ns):
+		for n in self.namespaces:
+			if n.name =3D=3D ns:
+				return n
+
+		return None
+
+	def stop_test_processes(self):
+		for n in self.namespaces:
+			n.reset()
+
+		self.namespaces =3D []
+		self.hostapd =3D None
+		self.wpas_interfaces =3D None
+
+		self.reset()
+
+	def meminfo_to_dict(self):
+		def removesuffix(string, suffix):
+			if string.endswith(suffix):
+				return string[:-len(suffix)]
+			return string
+
+		ret =3D {}
+
+		with open('/proc/meminfo', 'r') as f:
+			data =3D f.read().strip().split('\n')
+
+		for l in data:
+			entry =3D l.split(':')
+			ret[entry[0]] =3D int(removesuffix(entry[1], 'kB'))
+
+		return ret
+
+	def __str__(self):
+		ret =3D 'Arguments:\n'
+		for arg in vars(self.args):
+			ret +=3D '\t --%s %s\n' % (arg, str(getattr(self.args, arg)))
+
+		ret +=3D 'Hostapd:\n'
+		if self.hostapd:
+			for h in self.hostapd.instances:
+				ret +=3D '\t%s\n' % str(h)
+		else:
+			ret +=3D '\tNo Hostapd instances\n'
+
+		info =3D self.meminfo_to_dict()
+		self._mem_chart.add_value(info['MemAvailable'])
+
+		ret +=3D 'Available Memory: %u kB\n' % info['MemAvailable']
+		ret +=3D 'Last Test Delta: %+d kB\n' % (info['MemAvailable'] - self._las=
t_mem_available)
+		ret +=3D 'Per-test Usage:\n'
+		ret +=3D str(self._mem_chart)
+
+		self._last_mem_available =3D info['MemAvailable']
+
+		ret +=3D super().__str__()
+
+		for n in self.namespaces:
+			ret +=3D n.__str__()
+
+		return ret
+
+def build_unit_list(args):
+	'''
+		Build list of unit tests based on passed arguments. This first
+		checks for literal names provided in the arguments, then if
+		no matches were found, checks for a glob match.
+	'''
+	tests =3D []
+	test_root =3D args.testhome + '/unit'
+
+	for unit in args.unit_tests.split(','):
+		path =3D '%s/%s' % (test_root, unit)
+		if os.access(unit, os.X_OK):
+			tests.append(unit)
+		elif os.access(path, os.X_OK):
+			tests.append(path)
+		else:
+			# Full list or glob, first build up valid list of tests
+			matches =3D glob(path)
+			if matches =3D=3D []:
+				raise Exception("Could not find test %s" % unit)
+
+			matches =3D [exe for exe in matches if os.access(exe, os.X_OK)]
+
+			tests.extend(matches)
+
+	return sorted(tests)
+
+def build_test_list(args):
+	'''
+		Build list of auto test directories based on passed arguments.
+		First check for absolute paths, then look in <iwd>/autotests,
+		then glob match.
+	'''
+	tests =3D []
+	test_root =3D args.testhome + '/autotests'
+
+	# Run all tests
+	if not args.autotests:
+		# Get list of all autotests (committed in git)
+		tests =3D os.popen('git -C %s ls-files autotests/ | cut -f2 -d"/" \
+					| grep "test*" | uniq' % args.testhome).read() \
+					.strip().split('\n')
+		tests =3D [test_root + '/' + t for t in tests]
+	else:
+		print("Generating partial test list")
+
+		full_list =3D sorted(os.listdir(test_root))
+
+		for t in args.autotests.split(','):
+			path =3D '%s/%s' % (test_root, t)
+			if t.endswith('+'):
+				t =3D t.split('+')[0]
+				i =3D full_list.index(t)
+
+				tests =3D [test_root + '/' + x for x in full_list[i:] \
+							if x.startswith('test')]
+			elif os.path.exists(t):
+				if t not in tests:
+					tests.append(t)
+			elif os.path.exists(path):
+				if path not in tests:
+					tests.append(path)
+			else:
+				matches =3D glob(path)
+				if matches =3D=3D []:
+					raise Exception("Could not find test %s" % t)
+
+				tests.extend(list(set(matches) - set(tests)))
+
+	return sorted(tests)
+
+SimpleResult =3D namedtuple('SimpleResult', 'run failures errors skipped t=
ime')
+
+def start_test(ctx, subtests, rqueue):
+	'''
+		Run an individual test. 'subtests' are parsed prior to calling
+		but these effectively make up a single test. 'rqueue' is the
+		results queue which is required since this is using
+		multiprocessing.
+	'''
+	run =3D 0
+	errors =3D 0
+	failures =3D 0
+	skipped =3D 0
+
+	start =3D time.time()
+	#
+	# Iterate through each individual python test.
+	#
+	for s in subtests:
+		loader =3D unittest.TestLoader()
+		try:
+			module =3D importlib.import_module(os.path.splitext(s)[0])
+		except OSError as e:
+			dbg(subprocess.check_output("cat /proc/buddyinfo", shell=3DTrue).decode=
('utf-8'))
+			dbg(subprocess.check_output("dmesg | tail -80", shell=3DTrue).decode('u=
tf-8'))
+			print(ctx)
+			raise e
+
+		subtest =3D loader.loadTestsFromModule(module)
+
+		# The test suite is being (ab)used to get a bit more granularity
+		# with individual tests. The 'normal' way to use unittest is to
+		# just create a test suite and run them. The problem here is that
+		# test results are queued and printed at the very end so its
+		# difficult to know *where* a test failed (python gives a stack
+		# trace but printing the exception/failure immediately shows
+		# where in the debug logs something failed). Moreso if there are
+		# several test functions inside a single python file they run
+		# as a single test and it is difficult (again) to know where
+		# something failed.
+
+		# Iterating through each python test file
+		for test in subtest:
+			limit_funcs =3D []
+
+			if ctx.args.sub_tests:
+				for i in ctx.args.sub_tests:
+					if len(i.split('.')) =3D=3D 2:
+						limit_funcs.append(i.split('.')[1])
+
+			# Iterating through individual test functions inside a
+			# Test() class. Due to the nature of unittest we have
+			# to jump through some hoops to set up the test class
+			# only once by turning the enumeration into a list, then
+			# enumerating (again) to keep track of the index (just
+			# enumerating the test class doesn't allow len() because
+			# it is not a list).
+			tlist =3D list(enumerate(test))
+			for index, t in enumerate(tlist):
+				# enumerate is returning a tuple, index 1 is our
+				# actual object.
+				t =3D t[1]
+
+				func, file =3D str(t).split(' ')
+				#
+				# TODO: There may be a better way of doing this
+				# but strigifying the test class gives us a string:
+				# <function> (<file>.<class>)
+				#
+				file =3D file.strip('()').split('.')[0] + '.py'
+
+				# Create an empty result here in case the test fails
+				result =3D TestResult()
+
+				try:
+					skip =3D len(limit_funcs) > 0 and func not in limit_funcs
+
+					# Set up class only on first test
+					if index =3D=3D 0:
+						if not skip:
+							dbg("%s\n\t%s RUNNING" % (file, str(func)), end=3D'')
+						t.setUpClass()
+					else:
+						if not skip:
+							dbg("\t%s RUNNING" % str(func), end=3D'')
+
+					sys.__stdout__.flush()
+
+					Process.write_separators("\n=3D=3D=3D=3D=3D=3D %s:%s =3D=3D=3D=3D=3D=
=3D\n\n" % (file, func))
+
+					if not skip:
+						# Run test (setUp/tearDown run automatically)
+						result =3D t()
+
+					# Tear down class only on last test
+					if index =3D=3D len(tlist) - 1:
+						t.tearDownClass()
+
+					if skip:
+						continue
+				except unittest.SkipTest as e:
+					result.skipped.append(t)
+				except Exception as e:
+					dbg('\n%s threw an uncaught exception:' % func)
+					traceback.print_exc(file=3Dsys.__stdout__)
+
+				run +=3D result.testsRun
+				errors +=3D len(result.errors)
+				failures +=3D len(result.failures)
+				skipped +=3D len(result.skipped)
+
+				if len(result.skipped) > 0:
+					dbg(colored(" SKIPPED", "cyan"))
+				elif run =3D=3D 0 or len(result.errors) > 0 or len(result.failures) > =
0:
+					dbg(colored(" FAILED", "red"))
+					for e in result.errors:
+						dbg(e[1])
+					for f in result.failures:
+						dbg(f[1])
+				else:
+					dbg(colored(" PASSED", "green"))
+
+		# Prevents future test modules with the same name (e.g.
+		# connection_test.py) from being loaded from the cache
+		sys.modules.pop(module.__name__)
+
+	#
+	# The multiprocessing queue is picky with what objects it will serialize
+	# and send between processes. Because of this we put the important bits
+	# of the result into our own 'SimpleResult' tuple.
+	#
+	sresult =3D SimpleResult(run=3Drun, failures=3Dfailures, errors=3Derrors,
+				skipped=3Dskipped, time=3Dtime.time() - start)
+	rqueue.put(sresult)
+
+	# This may not be required since we are manually popping sys.modules
+	importlib.invalidate_caches()
+
+def pre_test(ctx, test, copied):
+	'''
+		Copy test files, start processes, and any other pre test work.
+	'''
+	os.chdir(test)
+
+	dbg("\nStarting %s" % colored(os.path.basename(test), "white", attrs=3D['=
bold']))
+	if not os.path.exists(test + '/hw.conf'):
+		raise Exception("No hw.conf found for %s" % test)
+
+	ctx.hw_config =3D ConfigParser()
+	ctx.hw_config.read(test + '/hw.conf')
+	#
+	# We have two types of test files: tests and everything else. Rather
+	# than require each test to specify the files needing to be copied to
+	# /tmp (previously 'tmpfs_extra_stuff'), we just copy everything which
+	# isn't a test. There is really no reason not to do this as any file
+	# present in a test directory should be needed by the test.
+	#
+	# All files
+	files =3D os.listdir(test)
+	# Tests (starts or ends with 'test')
+	subtests =3D [f for f in files if f.startswith('test') or \
+			os.path.splitext(f)[0].endswith('test')]
+	# Everything else (except .py files)
+	to_copy =3D [f for f in list(set(files) - set(subtests)) if not f.endswit=
h('.py') \
+								and f !=3D '__pycache__']
+	for f in to_copy:
+		if os.path.isdir(f):
+			shutil.copytree(f, '/tmp/' + f)
+		else:
+			shutil.copy(f, '/tmp')
+		copied.append(f)
+
+	# Prune down any subtests if needed
+	if ctx.args.sub_tests:
+		ctx.args.sub_tests =3D ctx.args.sub_tests.split(',')
+
+		to_run =3D [x.split('.')[0] for x in ctx.args.sub_tests]
+		pruned =3D []
+
+		for s in subtests:
+			no_ext =3D s
+			# Handle <file>.<test function> format
+			if '.' in s:
+				no_ext =3D s.split('.')[0]
+
+			if no_ext in to_run:
+				pruned.append(no_ext + '.py')
+
+		subtests =3D pruned
+
+	if ctx.args.log:
+		ctx.start_process(['iwmon', '--nowiphy'])
+	elif ctx.args.monitor:
+		ctx.start_process(['iwmon'], outfile=3Dctx.args.monitor)
+
+	ctx.start_dbus()
+	ctx.start_haveged()
+	ctx.start_dbus_monitor()
+	ctx.start_radios()
+	ctx.create_namespaces()
+	ctx.start_hostapd()
+	ctx.start_wpas_interfaces()
+	ctx.start_ofono()
+
+	if ctx.hw_config.has_option('SETUP', 'start_iwd'):
+		start =3D ctx.hw_config.getboolean('SETUP', 'start_iwd')
+	else:
+		start =3D True
+
+	if start:
+		ctx.start_iwd()
+	else:
+		print("Not starting IWD from test-runner")
+
+	print(ctx)
+
+	sys.path.insert(1, test)
+
+	return sorted(subtests)
+
+def post_test(ctx, to_copy):
+	'''
+		Remove copied files, and stop test processes.
+	'''
+	try:
+		for f in to_copy:
+			if os.path.isdir('/tmp/' + f):
+				shutil.rmtree('/tmp/' + f)
+			else:
+				os.remove('/tmp/' + f)
+
+		Process(['ip', 'link', 'set', 'lo', 'down']).wait()
+	except Exception as e:
+		print("Exception thrown in post_test")
+	finally:
+		ctx.stop_test_processes()
+
+	if ctx.args.valgrind:
+		for f in os.listdir('/tmp'):
+			if f.startswith("valgrind.log."):
+				dbg(f)
+				with open('/tmp/' + f, 'r') as v:
+					dbg(v.read())
+				dbg("\n")
+				os.remove('/tmp/' + f)
+
+	# Special case for when logging is enabled
+	if os.path.isfile('/tmp/iwd-tls-debug-server-cert.pem'):
+		os.remove('/tmp/iwd-tls-debug-server-cert.pem')
+
+	allowed =3D ['phonesim.conf', 'certs', 'secrets', 'iwd']
+	for f in [f for f in os.listdir('/tmp') if f not in allowed]:
+		dbg("File %s was not cleaned up!" % f)
+		try:
+			os.remove('/tmp/' + f)
+		except:
+			pass
+
+def print_results(results):
+	table =3D PrettyTable(['Test', colored('Passed', 'green'), colored('Faile=
d', 'red'), \
+				colored('Skipped', 'cyan'), colored('Time', 'yellow')])
+
+	total_pass =3D 0
+	total_fail =3D 0
+	total_skip =3D 0
+	total_time =3D 0
+
+	for test, result in results.items():
+
+		if result.time =3D=3D TEST_MAX_TIMEOUT:
+			failed =3D "Timed out"
+			passed =3D "Timed out"
+		elif result.time =3D=3D 0:
+			failed =3D "Exception"
+			passed =3D "Exception"
+		else:
+			failed =3D result.failures + result.errors
+			passed =3D result.run - failed
+
+			total_pass +=3D passed
+			total_fail +=3D failed
+			total_skip +=3D result.skipped
+
+		total_time +=3D result.time
+
+		time =3D '%.2f' % result.time
+
+		table.add_row([test, colored(passed, 'green'), colored(failed, 'red'), \
+				colored(result.skipped, 'cyan'), colored(time, 'yellow')])
+
+	total_time =3D '%.2f' % total_time
+
+	table.add_row(['Total', colored(total_pass, 'green'), colored(total_fail,=
 'red'), \
+			colored(total_skip, 'cyan'), colored(total_time, 'yellow')])
+
+	dbg(table)
+
+	return total_fail =3D=3D 0
+
+def run_auto_tests(ctx, args):
+	tests =3D build_test_list(args)
+
+	for test in tests:
+		copied =3D []
+		try:
+			subtests =3D pre_test(ctx, test, copied)
+
+			if len(subtests) < 1:
+				dbg("No tests to run")
+				sys.exit()
+
+			rqueue =3D multiprocessing.Queue()
+			p =3D multiprocessing.Process(target=3Dstart_test, args=3D(ctx, subtest=
s, rqueue))
+			p.start()
+			# Rather than time each subtest we just time the total but
+			# mutiply the default time by the number of tests being run.
+			p.join(TEST_MAX_TIMEOUT * len(subtests))
+
+			if p.is_alive():
+				# Timeout
+				p.terminate()
+
+				ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D0,
+								failures=3D0, errors=3D0,
+								skipped=3D0, time=3DTEST_MAX_TIMEOUT)
+			else:
+				ctx.results[os.path.basename(test)] =3D rqueue.get()
+
+		except Exception as ex:
+			dbg("%s threw an uncaught exception" % test)
+			traceback.print_exc(file=3Dsys.__stdout__)
+			ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D0, failures=
=3D0,
+								errors=3D0, skipped=3D0, time=3D0)
+		finally:
+			post_test(ctx, copied)
+
+def run_unit_tests(ctx, args):
+	os.chdir(args.testhome + '/unit')
+	units =3D build_unit_list(args)
+
+	for u in units:
+		p =3D ctx.start_process([u]).wait()
+		if p.returncode !=3D 0:
+			dbg("Unit test %s failed" % os.path.basename(u))
+		else:
+			dbg("Unit test %s passed" % os.path.basename(u))
+
+def run_tests(args):
+	global config
+
+	os.chdir(args.testhome)
+
+	#
+	# This allows all autotest utils (iwd/hostapd/etc) to access the
+	# TestContext. Any other module or script (in the same interpreter) can
+	# simply import config.ctx and access all live test information,
+	# start/stop processes, see active radios etc.
+	#
+	config =3D importlib.import_module('config')
+	config.ctx =3D TestContext(args)
+
+	# Must import these after config so ctx gets set
+	config.hwsim =3D importlib.import_module('hwsim')
+	config.hostapd =3D importlib.import_module('hostapd')
+
+	# Start writing out kernel log
+	config.ctx.start_process(["dmesg", '--follow'])
+
+	if args.unit_tests is None:
+		run_auto_tests(config.ctx, args)
+	else:
+		run_unit_tests(config.ctx, args)
+
+runner =3D Runner()
+
+atexit.register(exit_vm)
+runner.prepare_environment()
+run_tests(runner.args)
+runner.cleanup_environment()
+
diff --git a/tools/test-runner b/tools/test-runner
index c6f7f550..e663108d 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1,1528 +1,5 @@
 #!/usr/bin/python3
 =

-import os
-import shutil
-import fcntl
-import sys
-import subprocess
-import atexit
-import time
-import unittest
-import importlib
-from unittest.result import TestResult
-import multiprocessing
-import re
-import traceback
-
 from runner import Runner
 =

-from configparser import ConfigParser
-from prettytable import PrettyTable
-from termcolor import colored
-from glob import glob
-from collections import namedtuple
-from time import sleep
-import dbus.mainloop.glib
-from gi.repository import GLib
-from weakref import WeakValueDictionary
-
-config =3D None
-intf_id =3D 0
-
-TEST_MAX_TIMEOUT =3D 240
-
-dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
-
-def dbg(*s, **kwargs):
-	'''
-		Allows prints if stdout has been re-directed
-	'''
-	print(*s, **kwargs, file=3Dsys.__stdout__)
-
-def exit_vm():
-	if config:
-		for p in Process.get_all():
-			print("Process %s still running!" % p.args[0])
-			p.kill()
-
-		if config.ctx and config.ctx.results:
-			success =3D print_results(config.ctx.results)
-		else:
-			success =3D False
-
-		if config.ctx and config.ctx.args.result:
-			result =3D 'PASS' if success else 'FAIL'
-			with open(config.ctx.args.result, 'w') as f:
-				f.write(result)
-
-	os.sync()
-
-	runner.stop()
-
-def path_exists(path):
-	'''
-		Searches PATH as well as absolute paths.
-	'''
-	if shutil.which(path):
-		return True
-	try:
-		os.stat(path)
-	except:
-		return False
-	return True
-
-def find_binary(list):
-	'''
-		Returns a binary from 'list' if its found in PATH or on a
-		valid absolute path.
-	'''
-	for path in list:
-		if path_exists(path):
-			return path
-	return None
-
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
-		if not self.ctx:
-			global config
-			self.ctx =3D config.ctx
-
-		if self.ctx.is_verbose(args[0], log=3DFalse):
-			self.verbose =3D True
-
-		if namespace:
-			args =3D ['ip', 'netns', 'exec', namespace] + args
-
-		if outfile:
-			# outfile is only used by iwmon, in which case we don't want
-			# to append to an existing file.
-			self._append_outfile(outfile, append=3DFalse)
-
-		if self.ctx.args.log:
-			logfile =3D '%s/%s/%s' % (self.ctx.args.log,
-						os.path.basename(os.getcwd()),
-						args[0])
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
-		dir =3D os.path.dirname(file)
-
-		if self.ctx.args.log_gid:
-			gid =3D int(self.ctx.args.log_gid)
-			uid =3D int(self.ctx.args.log_uid)
-
-		if not path_exists(dir):
-			os.mkdir(dir)
-			if self.ctx.args.log_gid:
-				os.chown(dir, uid, gid)
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
-			f =3D open(os.path.join(dir, file), mode)
-		except Exception as e:
-			traceback.print_exc()
-			sys.exit(0)
-
-		if self.ctx.args.log_gid:
-			os.fchown(f.fileno(), uid, gid)
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
-class Interface:
-	def __init__(self, name, config):
-		self.name =3D name
-		self.ctrl_interface =3D '/var/run/hostapd/' + name
-		self.config =3D config
-
-	def __del__(self):
-		Process(['iw', 'dev', self.name, 'del']).wait()
-
-	def set_interface_state(self, state):
-		Process(['ip', 'link', 'set', self.name, state]).wait()
-
-class Radio:
-	def __init__(self, name):
-		self.name =3D name
-		# hostapd will reset this if this radio is used by it
-		self.use =3D 'iwd'
-		self.interface =3D None
-
-	def __del__(self):
-		print("Removing radio %s" % self.name)
-		self.interface =3D None
-
-	def create_interface(self, config, use):
-		global intf_id
-
-		ifname =3D 'wln%s' % intf_id
-
-		intf_id +=3D 1
-
-		self.interface =3D Interface(ifname, config)
-		self.use =3D use
-
-		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
-				'type', 'managed']).wait()
-
-		return self.interface
-
-	def __str__(self):
-		ret =3D self.name + ':\n'
-		ret +=3D '\tUsed By: %s ' % self.use
-		if self.interface:
-			ret +=3D '(%s)' % self.interface.name
-
-		ret +=3D '\n'
-
-		return ret
-
-class VirtualRadio(Radio):
-	'''
-		A subclass of 'Radio' specific to mac80211_hwsim radios.
-
-		TODO: Using D-Bus to create and destroy radios is more desireable
-		than the command line.
-	'''
-
-	def __init__(self, name, cfg=3DNone):
-		global config
-
-		self.disable_cipher =3D None
-		self.disable_iftype =3D None
-
-		self.hwsim =3D config.hwsim.Hwsim()
-
-		if cfg:
-			self.disable_iftype =3D cfg.get('iftype_disable', None)
-			self.disable_cipher =3D cfg.get('cipher_disable', None)
-
-		self._radio =3D self.hwsim.radios.create(name, p2p_device=3DTrue,
-					iftype_disable=3Dself.disable_iftype,
-					cipher_disable=3Dself.disable_cipher)
-
-		super().__init__(self._radio.name)
-
-	def __del__(self):
-		super().__del__()
-
-		# If the radio was moved into a namespace this will fail
-		try:
-			self._radio.remove()
-		except:
-			pass
-
-		self._radio =3D None
-
-	def __str__(self):
-		ret =3D super().__str__()
-
-		if self.disable_iftype:
-			ret +=3D '\tDisabled interface types: %s\n' % self.disable_iftype
-
-		if self.disable_cipher:
-			ret +=3D '\tDisabled ciphers: %s\n' % self.disable_cipher
-
-		ret +=3D '\tPath: %s' % self._radio.path
-
-		ret +=3D '\n'
-
-		return ret
-
-class HostapdInstance:
-	'''
-		A single instance of hostapd. In reality all hostapd instances
-		are started as a single process. This class just makes things
-		convenient for communicating with one of the hostapd APs.
-	'''
-	def __init__(self, config, radio):
-		self.radio =3D radio
-		self.config =3D config
-		self.cli =3D None
-
-		self.intf =3D radio.create_interface(self.config, 'hostapd')
-		self.intf.set_interface_state('up')
-
-	def __del__(self):
-		print("Removing HostapdInstance %s" % self.config)
-		self.intf.set_interface_state('down')
-		self.radio =3D None
-		self.intf =3D None
-
-	def __str__(self):
-		ret =3D 'Hostapd (%s)\n' % self.intf.name
-		ret +=3D '\tConfig: %s\n' % self.config
-
-		return ret
-
-class Hostapd:
-	'''
-		A set of running hostapd instances. This is really just a single
-		process since hostapd can be started with multiple config files.
-	'''
-	def __init__(self, ctx, radios, configs, radius):
-		self.ctx =3D ctx
-
-		if len(configs) !=3D len(radios):
-			raise Exception("Config (%d) and radio (%d) list length not equal" % \
-						(len(configs), len(radios)))
-
-		print("Initializing hostapd instances")
-
-		Process(['ip', 'link', 'set', 'eth0', 'up']).wait()
-		Process(['ip', 'link', 'set', 'eth1', 'up']).wait()
-
-		self.global_ctrl_iface =3D '/var/run/hostapd/ctrl'
-
-		self.instances =3D [HostapdInstance(c, r) for c, r in zip(configs, radio=
s)]
-
-		ifaces =3D [rad.interface.name for rad in radios]
-		ifaces =3D ','.join(ifaces)
-
-		args =3D ['hostapd', '-g', self.global_ctrl_iface]
-
-		if ifaces:
-			args.extend(['-i', ifaces])
-
-		#
-		# Config files should already be present in /tmp. This appends
-		# ctrl_interface and does any variable replacement. Currently
-		# this is just any $ifaceN occurrences.
-		#
-		for c in configs:
-			full_path =3D '/tmp/%s' % c
-			args.append(full_path)
-
-			self._rewrite_config(full_path)
-
-		if radius:
-			args.append(radius)
-
-		if ctx.is_verbose('hostapd'):
-			args.append('-d')
-
-		self.process =3D Process(args)
-
-		self.process.wait_for_socket(self.global_ctrl_iface, 30)
-
-		for hapd in self.instances:
-			self.process.wait_for_socket(hapd.intf.ctrl_interface, 30)
-
-	def attach_cli(self):
-		global config
-
-		for hapd in self.instances:
-			hapd.cli =3D config.hostapd.HostapdCLI(config=3Dhapd.config)
-
-	def _rewrite_config(self, config):
-		'''
-			Replaces any $ifaceN values with the correct interface
-			names as well as appends the ctrl_interface path to
-			the config file.
-		'''
-		with open(config, 'r+') as f:
-			data =3D f.read()
-			to_replace =3D []
-			for match in re.finditer(r'\$iface[0-9]+', data):
-				tag =3D data[match.start():match.end()]
-				idx =3D tag.split('iface')[1]
-
-				to_replace.append((tag, self.instances[int(idx)].intf.name))
-
-			for r in to_replace:
-				data =3D data.replace(r[0], r[1], 1)
-
-			data +=3D '\nctrl_interface=3D/var/run/hostapd\n'
-
-			f.write(data)
-
-	def __getitem__(self, config):
-		if not config:
-			return self.instances[0]
-
-		for hapd in self.instances:
-			if hapd.config =3D=3D config:
-				return hapd
-
-		return None
-
-	def __del__(self):
-		print("Removing Hostapd")
-		try:
-			os.remove(self.global_ctrl_iface)
-		except:
-			print("Failed to remove %s" % self.global_ctrl_iface)
-
-		self.instances =3D None
-
-		# Hostapd may have already been stopped
-		if self.process:
-			self.ctx.stop_process(self.process)
-
-		self.ctx =3D None
-
-		# Hostapd creates simdb sockets for EAP-SIM/AKA tests but does not
-		# clean them up.
-		for f in glob("/tmp/eap_sim_db*"):
-			os.remove(f)
-
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
-		print("Removing namespace %s" % self.name)
-
-		Process(['ip', 'netns', 'del', self.name]).wait()
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
-			context.iteration(may_block=3DFalse)
-
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
-			sleep(0.1)
-
-			if done.value =3D=3D True:
-				if isinstance(exception, Exception):
-					raise exception
-				elif type(exception) =3D=3D bool and exception:
-					raise TimeoutError("Timeout on non_block_wait")
-				else:
-					return
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
-class BarChart():
-	def __init__(self, height=3D10, max_width=3D80):
-		self._height =3D height
-		self._max_width =3D max_width
-		self._values =3D []
-		self._max_value =3D 0
-		self._min_value =3D 0
-
-	def add_value(self, value):
-		if len(self._values) =3D=3D 0:
-			self._max_value =3D int(1.01 * value)
-			self._min_value =3D int(0.99 * value)
-		elif value > self._max_value:
-			self._max_value =3D int(1.01 * value)
-		elif value < self._min_value:
-			self._min_value =3D int(0.99 * value)
-
-		self._values.append(value)
-
-	def _value_to_stars(self, value):
-		# Need to scale value (range of min_value -> max_value) to
-		# a range of 0 -> height
-		#
-		# Scaled =3D ((value - min_value) / ( max_value - min_value)) * (Height =
- 0) + 0
-
-		return int(((value - self._min_value) /
-			(self._max_value - self._min_value)) * self._height)
-
-	def __str__(self):
-		# Need to map value from range 0 - self._height
-		ret =3D ''
-
-		for i, value in enumerate(self._values):
-			stars =3D self._value_to_stars(value)
-			ret +=3D '[%3u] ' % i + '%-10s' % ('*' * stars) + '\t\t\t%d\n' % value
-
-		ret +=3D '\n'
-
-		return ret
-
-
-class TestContext(Namespace):
-	'''
-		Contains all information for a given set of tests being run
-		such as processes, radios, interfaces and test results.
-	'''
-	def __init__(self, args):
-		self.name =3D None
-		self.args =3D args
-		self.hw_config =3D None
-		self.hostapd =3D None
-		self.wpas_interfaces =3D None
-		self.cur_radio_id =3D 0
-		self.cur_iface_id =3D 0
-		self.radios =3D []
-		self.loopback_started =3D False
-		self.results =3D {}
-		self.mainloop =3D GLib.MainLoop()
-		self.namespaces =3D []
-		self._last_mem_available =3D 0
-		self._mem_chart =3D BarChart()
-
-	def start_dbus_monitor(self):
-		if not self.is_verbose('dbus-monitor'):
-			return
-
-		self.start_process(['dbus-monitor', '--address', self.dbus_address])
-
-	def start_haveged(self):
-		self.start_process(['haveged', '-F'])
-
-	def create_radios(self):
-		setup =3D self.hw_config['SETUP']
-		nradios =3D int(setup['num_radios'])
-		args =3D ['hwsim']
-
-		if self.hw_config['SETUP'].get('hwsim_medium', 'no') in ['no', '0', 'fal=
se']:
-			# register hwsim as medium
-			args.extend(['--no-register'])
-
-		self.start_process(args)
-		self.non_block_wait(self._bus.name_has_owner, 20, 'net.connman.hwsim',
-					exception=3DTimeoutError('net.connman.hwsim did not appear'))
-
-		for i in range(nradios):
-			name =3D 'rad%u' % i
-
-			# Get any [radX] sections. These are for configuring
-			# any special radios. This no longer requires a
-			# radio_conf list, we just assume radios start rad0
-			# and increment.
-			rad_config =3D None
-			if self.hw_config.has_section(name):
-				rad_config =3D self.hw_config[name]
-
-			self.radios.append(VirtualRadio(name, rad_config))
-			self.cur_radio_id +=3D 1
-
-	def discover_radios(self):
-		import pyroute2
-
-		phys =3D []
-
-		try:
-			iw =3D pyroute2.iwutil.IW()
-		except:
-			iw =3D pyroute2.IW()
-
-		attrs =3D [phy['attrs'] for phy in iw.list_wiphy()]
-
-		for attr in attrs:
-			for key, value in attr:
-				if key =3D=3D 'NL80211_ATTR_WIPHY_NAME':
-					if value not in phys:
-						phys.append(value)
-					break
-
-		print('Discovered radios: %s' % str(phys))
-		self.radios =3D [Radio(name) for name in phys]
-
-	def start_radios(self):
-		reg_domain =3D self.hw_config['SETUP'].get('reg_domain', None)
-		if reg_domain:
-			Process(['iw', 'reg', 'set', reg_domain]).wait()
-
-		if self.args.hw:
-			self.discover_radios()
-		else:
-			self.create_radios()
-
-	def start_hostapd(self):
-		if not 'HOSTAPD' in self.hw_config:
-			return
-
-		settings =3D self.hw_config['HOSTAPD']
-
-		if self.args.hw:
-			# Just grab the first N radios. It gets rather
-			# complicated trying to map radX radios specified in
-			# hw.conf so any passed through physical adapters are
-			# just given to hostapd/IWD as they appear during
-			# discovery.
-			#
-			# TODO: It may be desireable to map PCI/USB adapters to
-			#       specific radX radios specified in the config but
-			#       there are really 2 separate use cases here.
-			#       1. You want to test a *specific* radio with IWD
-			#          or hostapd. For this you would want radX
-			#          to map to a specific radio
-			#       2. You have many adapters in use to run multiple
-			#          tests. In this case you would not care what
-			#          was using each radio, just that there was
-			#          enough to run all tests.
-			nradios =3D 0
-			for k, _ in settings.items():
-				if k =3D=3D 'radius_server':
-					continue
-				nradios +=3D 1
-
-			hapd_radios =3D self.radios[:nradios]
-
-		else:
-			hapd_radios =3D [rad for rad in self.radios if rad.name in settings]
-
-		hapd_configs =3D [conf for rad, conf in settings.items() if rad !=3D 'ra=
dius_server']
-
-		radius_config =3D settings.get('radius_server', None)
-
-		self.hostapd =3D Hostapd(self, hapd_radios, hapd_configs, radius_config)
-		self.hostapd.attach_cli()
-
-	def get_frequencies(self):
-		frequencies =3D []
-
-		for hapd in self.hostapd.instances:
-			frequencies.append(hapd.cli.frequency)
-
-		return frequencies
-
-	def start_wpas_interfaces(self):
-
-		if 'WPA_SUPPLICANT' not in self.hw_config:
-			return
-
-		settings =3D self.hw_config['WPA_SUPPLICANT']
-
-		if self.args.hw:
-			nradios =3D len(settings.items())
-
-			wpas_radios =3D self.radios[:nradios]
-			self.wpas_interfaces =3D []
-
-			#
-			# Physical radios most likely will use a different name
-			# than 'rad#' but the config file is referenced by these
-			# 'rad#' names. Iterate through both the settings and
-			# physical radios to create interfaces associated with
-			# each config file.
-			#
-			for vrad, hwrad in zip(settings.items(), wpas_radios):
-				self.wpas_interfaces.append(hwrad.create_interface(vrad[1], 'wpas'))
-
-		else:
-			wpas_radios =3D [rad for rad in self.radios if rad.name in settings]
-			self.wpas_interfaces =3D [rad.create_interface(settings[rad.name], 'wpa=
s') \
-						for rad in wpas_radios]
-
-	def start_ofono(self):
-		sim_keys =3D self.hw_config['SETUP'].get('sim_keys', None)
-		if not sim_keys:
-			print("Ofono not requred")
-			return
-		elif sim_keys !=3D 'ofono':
-			os.environ['IWD_SIM_KEYS'] =3D sim_keys
-			return
-
-		if not find_binary(['ofonod']) or not find_binary(['phonesim']):
-			print("Ofono or Phonesim not found, skipping test")
-			return
-
-		Process(['ip', 'link', 'set', 'lo', 'up']).wait()
-
-		os.environ['OFONO_PHONESIM_CONFIG'] =3D '/tmp/phonesim.conf'
-
-		phonesim_args =3D ['phonesim', '-p', '12345', '/usr/share/phonesim/defau=
lt.xml']
-
-		self.start_process(phonesim_args)
-
-		#
-		# TODO:
-		# Is there something to wait for? Without this phonesim rejects
-		# connections on all but the fist test.
-		#
-		time.sleep(3)
-
-		ofono_args =3D ['ofonod', '-n', '--plugin=3Datmodem,phonesim']
-		if self.is_verbose('ofonod'):
-			ofono_args.append('-d')
-
-		self.start_process(ofono_args)
-
-		print("Ofono started")
-
-	def create_namespaces(self):
-		if not self.hw_config.has_section('NameSpaces'):
-			return
-
-		for key, value in self.hw_config.items('NameSpaces'):
-			radio_names =3D value.split(',')
-			# Gather up radio objects for this namespace
-			radios =3D [rad for rad in self.radios if rad.name in radio_names]
-
-			# Remove radios from 'root' namespace
-			self.radios =3D list(set(self.radios) - set(radios))
-
-			self.namespaces.append(Namespace(self.args, key, radios))
-
-	def get_namespace(self, ns):
-		for n in self.namespaces:
-			if n.name =3D=3D ns:
-				return n
-
-		return None
-
-	def stop_test_processes(self):
-		for n in self.namespaces:
-			n.reset()
-
-		self.namespaces =3D []
-		self.hostapd =3D None
-		self.wpas_interfaces =3D None
-
-		self.reset()
-
-	def meminfo_to_dict(self):
-		def removesuffix(string, suffix):
-			if string.endswith(suffix):
-				return string[:-len(suffix)]
-			return string
-
-		ret =3D {}
-
-		with open('/proc/meminfo', 'r') as f:
-			data =3D f.read().strip().split('\n')
-
-		for l in data:
-			entry =3D l.split(':')
-			ret[entry[0]] =3D int(removesuffix(entry[1], 'kB'))
-
-		return ret
-
-	def __str__(self):
-		ret =3D 'Arguments:\n'
-		for arg in vars(self.args):
-			ret +=3D '\t --%s %s\n' % (arg, str(getattr(self.args, arg)))
-
-		ret +=3D 'Hostapd:\n'
-		if self.hostapd:
-			for h in self.hostapd.instances:
-				ret +=3D '\t%s\n' % str(h)
-		else:
-			ret +=3D '\tNo Hostapd instances\n'
-
-		info =3D self.meminfo_to_dict()
-		self._mem_chart.add_value(info['MemAvailable'])
-
-		ret +=3D 'Available Memory: %u kB\n' % info['MemAvailable']
-		ret +=3D 'Last Test Delta: %+d kB\n' % (info['MemAvailable'] - self._las=
t_mem_available)
-		ret +=3D 'Per-test Usage:\n'
-		ret +=3D str(self._mem_chart)
-
-		self._last_mem_available =3D info['MemAvailable']
-
-		ret +=3D super().__str__()
-
-		for n in self.namespaces:
-			ret +=3D n.__str__()
-
-		return ret
-
-def build_unit_list(args):
-	'''
-		Build list of unit tests based on passed arguments. This first
-		checks for literal names provided in the arguments, then if
-		no matches were found, checks for a glob match.
-	'''
-	tests =3D []
-	test_root =3D args.testhome + '/unit'
-
-	for unit in args.unit_tests.split(','):
-		path =3D '%s/%s' % (test_root, unit)
-		if os.access(unit, os.X_OK):
-			tests.append(unit)
-		elif os.access(path, os.X_OK):
-			tests.append(path)
-		else:
-			# Full list or glob, first build up valid list of tests
-			matches =3D glob(path)
-			if matches =3D=3D []:
-				raise Exception("Could not find test %s" % unit)
-
-			matches =3D [exe for exe in matches if os.access(exe, os.X_OK)]
-
-			tests.extend(matches)
-
-	return sorted(tests)
-
-def build_test_list(args):
-	'''
-		Build list of auto test directories based on passed arguments.
-		First check for absolute paths, then look in <iwd>/autotests,
-		then glob match.
-	'''
-	tests =3D []
-	test_root =3D args.testhome + '/autotests'
-
-	# Run all tests
-	if not args.autotests:
-		# Get list of all autotests (committed in git)
-		tests =3D os.popen('git -C %s ls-files autotests/ | cut -f2 -d"/" \
-					| grep "test*" | uniq' % args.testhome).read() \
-					.strip().split('\n')
-		tests =3D [test_root + '/' + t for t in tests]
-	else:
-		print("Generating partial test list")
-
-		full_list =3D sorted(os.listdir(test_root))
-
-		for t in args.autotests.split(','):
-			path =3D '%s/%s' % (test_root, t)
-			if t.endswith('+'):
-				t =3D t.split('+')[0]
-				i =3D full_list.index(t)
-
-				tests =3D [test_root + '/' + x for x in full_list[i:] \
-							if x.startswith('test')]
-			elif os.path.exists(t):
-				if t not in tests:
-					tests.append(t)
-			elif os.path.exists(path):
-				if path not in tests:
-					tests.append(path)
-			else:
-				matches =3D glob(path)
-				if matches =3D=3D []:
-					raise Exception("Could not find test %s" % t)
-
-				tests.extend(list(set(matches) - set(tests)))
-
-	return sorted(tests)
-
-SimpleResult =3D namedtuple('SimpleResult', 'run failures errors skipped t=
ime')
-
-def start_test(ctx, subtests, rqueue):
-	'''
-		Run an individual test. 'subtests' are parsed prior to calling
-		but these effectively make up a single test. 'rqueue' is the
-		results queue which is required since this is using
-		multiprocessing.
-	'''
-	run =3D 0
-	errors =3D 0
-	failures =3D 0
-	skipped =3D 0
-
-	start =3D time.time()
-	#
-	# Iterate through each individual python test.
-	#
-	for s in subtests:
-		loader =3D unittest.TestLoader()
-		try:
-			module =3D importlib.import_module(os.path.splitext(s)[0])
-		except OSError as e:
-			dbg(subprocess.check_output("cat /proc/buddyinfo", shell=3DTrue).decode=
('utf-8'))
-			dbg(subprocess.check_output("dmesg | tail -80", shell=3DTrue).decode('u=
tf-8'))
-			print(ctx)
-			raise e
-
-		subtest =3D loader.loadTestsFromModule(module)
-
-		# The test suite is being (ab)used to get a bit more granularity
-		# with individual tests. The 'normal' way to use unittest is to
-		# just create a test suite and run them. The problem here is that
-		# test results are queued and printed at the very end so its
-		# difficult to know *where* a test failed (python gives a stack
-		# trace but printing the exception/failure immediately shows
-		# where in the debug logs something failed). Moreso if there are
-		# several test functions inside a single python file they run
-		# as a single test and it is difficult (again) to know where
-		# something failed.
-
-		# Iterating through each python test file
-		for test in subtest:
-			limit_funcs =3D []
-
-			if ctx.args.sub_tests:
-				for i in ctx.args.sub_tests:
-					if len(i.split('.')) =3D=3D 2:
-						limit_funcs.append(i.split('.')[1])
-
-			# Iterating through individual test functions inside a
-			# Test() class. Due to the nature of unittest we have
-			# to jump through some hoops to set up the test class
-			# only once by turning the enumeration into a list, then
-			# enumerating (again) to keep track of the index (just
-			# enumerating the test class doesn't allow len() because
-			# it is not a list).
-			tlist =3D list(enumerate(test))
-			for index, t in enumerate(tlist):
-				# enumerate is returning a tuple, index 1 is our
-				# actual object.
-				t =3D t[1]
-
-				func, file =3D str(t).split(' ')
-				#
-				# TODO: There may be a better way of doing this
-				# but strigifying the test class gives us a string:
-				# <function> (<file>.<class>)
-				#
-				file =3D file.strip('()').split('.')[0] + '.py'
-
-				# Create an empty result here in case the test fails
-				result =3D TestResult()
-
-				try:
-					skip =3D len(limit_funcs) > 0 and func not in limit_funcs
-
-					# Set up class only on first test
-					if index =3D=3D 0:
-						if not skip:
-							dbg("%s\n\t%s RUNNING" % (file, str(func)), end=3D'')
-						t.setUpClass()
-					else:
-						if not skip:
-							dbg("\t%s RUNNING" % str(func), end=3D'')
-
-					sys.__stdout__.flush()
-
-					Process.write_separators("\n=3D=3D=3D=3D=3D=3D %s:%s =3D=3D=3D=3D=3D=
=3D\n\n" % (file, func))
-
-					if not skip:
-						# Run test (setUp/tearDown run automatically)
-						result =3D t()
-
-					# Tear down class only on last test
-					if index =3D=3D len(tlist) - 1:
-						t.tearDownClass()
-
-					if skip:
-						continue
-				except unittest.SkipTest as e:
-					result.skipped.append(t)
-				except Exception as e:
-					dbg('\n%s threw an uncaught exception:' % func)
-					traceback.print_exc(file=3Dsys.__stdout__)
-
-				run +=3D result.testsRun
-				errors +=3D len(result.errors)
-				failures +=3D len(result.failures)
-				skipped +=3D len(result.skipped)
-
-				if len(result.skipped) > 0:
-					dbg(colored(" SKIPPED", "cyan"))
-				elif run =3D=3D 0 or len(result.errors) > 0 or len(result.failures) > =
0:
-					dbg(colored(" FAILED", "red"))
-					for e in result.errors:
-						dbg(e[1])
-					for f in result.failures:
-						dbg(f[1])
-				else:
-					dbg(colored(" PASSED", "green"))
-
-		# Prevents future test modules with the same name (e.g.
-		# connection_test.py) from being loaded from the cache
-		sys.modules.pop(module.__name__)
-
-	#
-	# The multiprocessing queue is picky with what objects it will serialize
-	# and send between processes. Because of this we put the important bits
-	# of the result into our own 'SimpleResult' tuple.
-	#
-	sresult =3D SimpleResult(run=3Drun, failures=3Dfailures, errors=3Derrors,
-				skipped=3Dskipped, time=3Dtime.time() - start)
-	rqueue.put(sresult)
-
-	# This may not be required since we are manually popping sys.modules
-	importlib.invalidate_caches()
-
-def pre_test(ctx, test, copied):
-	'''
-		Copy test files, start processes, and any other pre test work.
-	'''
-	os.chdir(test)
-
-	dbg("\nStarting %s" % colored(os.path.basename(test), "white", attrs=3D['=
bold']))
-	if not os.path.exists(test + '/hw.conf'):
-		raise Exception("No hw.conf found for %s" % test)
-
-	ctx.hw_config =3D ConfigParser()
-	ctx.hw_config.read(test + '/hw.conf')
-	#
-	# We have two types of test files: tests and everything else. Rather
-	# than require each test to specify the files needing to be copied to
-	# /tmp (previously 'tmpfs_extra_stuff'), we just copy everything which
-	# isn't a test. There is really no reason not to do this as any file
-	# present in a test directory should be needed by the test.
-	#
-	# All files
-	files =3D os.listdir(test)
-	# Tests (starts or ends with 'test')
-	subtests =3D [f for f in files if f.startswith('test') or \
-			os.path.splitext(f)[0].endswith('test')]
-	# Everything else (except .py files)
-	to_copy =3D [f for f in list(set(files) - set(subtests)) if not f.endswit=
h('.py') \
-								and f !=3D '__pycache__']
-	for f in to_copy:
-		if os.path.isdir(f):
-			shutil.copytree(f, '/tmp/' + f)
-		else:
-			shutil.copy(f, '/tmp')
-		copied.append(f)
-
-	# Prune down any subtests if needed
-	if ctx.args.sub_tests:
-		ctx.args.sub_tests =3D ctx.args.sub_tests.split(',')
-
-		to_run =3D [x.split('.')[0] for x in ctx.args.sub_tests]
-		pruned =3D []
-
-		for s in subtests:
-			no_ext =3D s
-			# Handle <file>.<test function> format
-			if '.' in s:
-				no_ext =3D s.split('.')[0]
-
-			if no_ext in to_run:
-				pruned.append(no_ext + '.py')
-
-		subtests =3D pruned
-
-	if ctx.args.log:
-		ctx.start_process(['iwmon', '--nowiphy'])
-	elif ctx.args.monitor:
-		ctx.start_process(['iwmon'], outfile=3Dctx.args.monitor)
-
-	ctx.start_dbus()
-	ctx.start_haveged()
-	ctx.start_dbus_monitor()
-	ctx.start_radios()
-	ctx.create_namespaces()
-	ctx.start_hostapd()
-	ctx.start_wpas_interfaces()
-	ctx.start_ofono()
-
-	if ctx.hw_config.has_option('SETUP', 'start_iwd'):
-		start =3D ctx.hw_config.getboolean('SETUP', 'start_iwd')
-	else:
-		start =3D True
-
-	if start:
-		ctx.start_iwd()
-	else:
-		print("Not starting IWD from test-runner")
-
-	print(ctx)
-
-	sys.path.insert(1, test)
-
-	return sorted(subtests)
-
-def post_test(ctx, to_copy):
-	'''
-		Remove copied files, and stop test processes.
-	'''
-	try:
-		for f in to_copy:
-			if os.path.isdir('/tmp/' + f):
-				shutil.rmtree('/tmp/' + f)
-			else:
-				os.remove('/tmp/' + f)
-
-		Process(['ip', 'link', 'set', 'lo', 'down']).wait()
-	except Exception as e:
-		print("Exception thrown in post_test")
-	finally:
-		ctx.stop_test_processes()
-
-	if ctx.args.valgrind:
-		for f in os.listdir('/tmp'):
-			if f.startswith("valgrind.log."):
-				dbg(f)
-				with open('/tmp/' + f, 'r') as v:
-					dbg(v.read())
-				dbg("\n")
-				os.remove('/tmp/' + f)
-
-	# Special case for when logging is enabled
-	if os.path.isfile('/tmp/iwd-tls-debug-server-cert.pem'):
-		os.remove('/tmp/iwd-tls-debug-server-cert.pem')
-
-	allowed =3D ['phonesim.conf', 'certs', 'secrets', 'iwd']
-	for f in [f for f in os.listdir('/tmp') if f not in allowed]:
-		dbg("File %s was not cleaned up!" % f)
-		try:
-			os.remove('/tmp/' + f)
-		except:
-			pass
-
-def print_results(results):
-	table =3D PrettyTable(['Test', colored('Passed', 'green'), colored('Faile=
d', 'red'), \
-				colored('Skipped', 'cyan'), colored('Time', 'yellow')])
-
-	total_pass =3D 0
-	total_fail =3D 0
-	total_skip =3D 0
-	total_time =3D 0
-
-	for test, result in results.items():
-
-		if result.time =3D=3D TEST_MAX_TIMEOUT:
-			failed =3D "Timed out"
-			passed =3D "Timed out"
-		elif result.time =3D=3D 0:
-			failed =3D "Exception"
-			passed =3D "Exception"
-		else:
-			failed =3D result.failures + result.errors
-			passed =3D result.run - failed
-
-			total_pass +=3D passed
-			total_fail +=3D failed
-			total_skip +=3D result.skipped
-
-		total_time +=3D result.time
-
-		time =3D '%.2f' % result.time
-
-		table.add_row([test, colored(passed, 'green'), colored(failed, 'red'), \
-				colored(result.skipped, 'cyan'), colored(time, 'yellow')])
-
-	total_time =3D '%.2f' % total_time
-
-	table.add_row(['Total', colored(total_pass, 'green'), colored(total_fail,=
 'red'), \
-			colored(total_skip, 'cyan'), colored(total_time, 'yellow')])
-
-	dbg(table)
-
-	return total_fail =3D=3D 0
-
-def run_auto_tests(ctx, args):
-	tests =3D build_test_list(args)
-
-	for test in tests:
-		copied =3D []
-		try:
-			subtests =3D pre_test(ctx, test, copied)
-
-			if len(subtests) < 1:
-				dbg("No tests to run")
-				sys.exit()
-
-			rqueue =3D multiprocessing.Queue()
-			p =3D multiprocessing.Process(target=3Dstart_test, args=3D(ctx, subtest=
s, rqueue))
-			p.start()
-			# Rather than time each subtest we just time the total but
-			# mutiply the default time by the number of tests being run.
-			p.join(TEST_MAX_TIMEOUT * len(subtests))
-
-			if p.is_alive():
-				# Timeout
-				p.terminate()
-
-				ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D0,
-								failures=3D0, errors=3D0,
-								skipped=3D0, time=3DTEST_MAX_TIMEOUT)
-			else:
-				ctx.results[os.path.basename(test)] =3D rqueue.get()
-
-		except Exception as ex:
-			dbg("%s threw an uncaught exception" % test)
-			traceback.print_exc(file=3Dsys.__stdout__)
-			ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D0, failures=
=3D0,
-								errors=3D0, skipped=3D0, time=3D0)
-		finally:
-			post_test(ctx, copied)
-
-def run_unit_tests(ctx, args):
-	os.chdir(args.testhome + '/unit')
-	units =3D build_unit_list(args)
-
-	for u in units:
-		p =3D ctx.start_process([u]).wait()
-		if p.returncode !=3D 0:
-			dbg("Unit test %s failed" % os.path.basename(u))
-		else:
-			dbg("Unit test %s passed" % os.path.basename(u))
-
-def run_tests(args):
-	global config
-
-	os.chdir(args.testhome)
-
-	#
-	# This allows all autotest utils (iwd/hostapd/etc) to access the
-	# TestContext. Any other module or script (in the same interpreter) can
-	# simply import config.ctx and access all live test information,
-	# start/stop processes, see active radios etc.
-	#
-	config =3D importlib.import_module('config')
-	config.ctx =3D TestContext(args)
-
-	# Must import these after config so ctx gets set
-	config.hwsim =3D importlib.import_module('hwsim')
-	config.hostapd =3D importlib.import_module('hostapd')
-
-	# Start writing out kernel log
-	config.ctx.start_process(["dmesg", '--follow'])
-
-	if args.unit_tests is None:
-		run_auto_tests(config.ctx, args)
-	else:
-		run_unit_tests(config.ctx, args)
-
-runner =3D Runner(from_env=3DTrue)
-
-atexit.register(exit_vm)
-runner.prepare_environment()
-run_tests(runner.args)
-runner.cleanup_environment()
+Runner().start()
-- =

2.34.1

--===============8604668553673961898==--

