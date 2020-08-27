Content-Type: multipart/mixed; boundary="===============3232831415175643374=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/16] auto-t: introduce pure python test-runner re-write
Date: Thu, 27 Aug 2020 10:32:16 -0700
Message-ID: <20200827173229.26466-3-prestwoj@gmail.com>
In-Reply-To: <20200827173229.26466-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3232831415175643374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch completely re-writes test-runner in Python. This was done
because the existing C test-runner had some clunky work arounds and
maintaining or adding new features was starting to become a huge pain.

There were a few aspects of test-runner which continually had to
be dealt with when adding any new functionality:

 * Argument parsing: Adding new arguments to test-runner wasn't so
   bad, but if you wanted those arguments passed into the VM it
   became a huge pain. Arguments needed to be parsed, then re-formatted
   into the qemu command line, then re-parsed in a special order
   (backwards) once in the VM. The burden for adding new arguments was
   quite high so it was avoided (at least by me) at all costs.
 * The separation between C and Python: The tests are all written in
   python, but the executables, radios, and interfaces were all created
   from C. The way we solved this was by encoding the require info as
   environment variables, then parsing those from Python. It worked,
   but it was, again, a huge pain.
 * Process management: It started with all processes being launched
   from C, but eventually tests required the ability to start IWD, or
   kill hostapd ungracefully in order to test certain functionality.
   Since the processes were tracked in C, Python had no way of
   signalling that it killed a process and when it started one C had
   no idea. This was mitigated (basically by killall), but it was
   no where close to an elegant solution.

Re-writing test-runner in python solves all these problems and will
be much easier to maintain.

 * Argument parsing: Now all arguments are forwarded automatically
   to the VM. The ArgParse library takes care of parsing and each
   argument is stored in a dictionary.
 * Separation between C and Python: No more C, so no more separation.
 * Process management: Python will now manage all processes. This
   allows a test to kill, restart, or start a new process and not
   have to remember the PID or to kill it after the test.

There are a few more important aspects of the python implementation
that should now be considered when writing new tests:

 * The IWD constructor now has different default arugments. IWD
   will always be started unless specified and the configuration
   directory will always be /tmp
 * Any non *.py file in the test directory will be copied to /tmp.
   This avoids the need for 'tmpfs_extra_stuff' completely.
 * ctrl_interface will automatically be appended to every hostapd
   config. There is no need to include this in a config file from
   now on.
 * Test cleanup is extremely important. All tests get run in the
   same interpreter now and the tests themselves are actually loaded
   as python modules. This means e.g. if you somehow kept a reference
   to IWD() any subsequent tests would not start since IWD is still
   running.
 * For debugging, the test context can be printed which shows running
   processes, radios, and interfaces.

Three non-native python modules were used: PrettyTable, colored, and
pyroute2

$ pip3 install prettytable
$ pip3 install termcolor
$ pip3 install pyroute2
---
 autotests/util/config.py |    6 +
 tools/py_runner.py       | 1245 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 1251 insertions(+)
 create mode 100644 autotests/util/config.py
 create mode 100755 tools/py_runner.py

diff --git a/autotests/util/config.py b/autotests/util/config.py
new file mode 100644
index 00000000..be8edbfc
--- /dev/null
+++ b/autotests/util/config.py
@@ -0,0 +1,6 @@
+#
+# Acts as a global store for test information. 'ctx' is set by the creator=
 of
+# of the TestContext (test-runner).
+#
+
+ctx =3D {}
diff --git a/tools/py_runner.py b/tools/py_runner.py
new file mode 100755
index 00000000..67863c2d
--- /dev/null
+++ b/tools/py_runner.py
@@ -0,0 +1,1245 @@
+#!/bin/python3
+
+import argparse
+import os
+import shutil
+import ctypes
+import fcntl
+import shlex
+import sys
+import subprocess
+import atexit
+import time
+import unittest
+import importlib
+import signal
+import pyroute2
+import multiprocessing
+import re
+
+from configparser import ConfigParser
+from prettytable import PrettyTable
+from termcolor import colored
+from glob import glob
+from collections import namedtuple
+from time import sleep
+
+libc =3D ctypes.cdll['libc.so.6']
+libc.mount.argtypes =3D (ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p=
, \
+			ctypes.c_ulong, ctypes.c_char_p)
+
+# Using ctypes to load the libc library is somewhat low level. Because of =
this
+# we need to define our own flags/options for use with mounting.
+MS_NOSUID =3D 2
+MS_NODEV =3D 4
+MS_NOEXEC =3D 8
+MS_STRICTATIME =3D 1 << 24
+STDIN_FILENO =3D 0
+TIOCSTTY =3D 0x540E
+
+config =3D None
+intf_id =3D 0
+
+TEST_MAX_TIMEOUT =3D 45
+
+def dbg(*s):
+	'''
+		Allows prints if stdout has been re-directed
+	'''
+	print(*s, file=3Dsys.__stdout__)
+
+def exit_vm():
+	if config:
+		for p in config.ctx.processes:
+			print("Process %s still running!" % p.name)
+
+	os.sync()
+
+	RB_AUTOBOOT =3D 0x01234567
+	#
+	# Calling 'reboot' or 'shutdown' from a shell (e.g. os.system('reboot'))
+	# is not the same the POSIX reboot() and will cause a kernel panic since
+	# we are the init process. The libc.reboot() allows the VM to exit
+	# gracefully.
+	#
+	libc.reboot(RB_AUTOBOOT)
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
+def mount(source, target, fs, flags, options=3D''):
+	'''
+		Python wrapper for libc mount()
+	'''
+	ret =3D libc.mount(source.encode(), target.encode(), fs.encode(), flags,
+				options.encode())
+	if ret < 0:
+		errno =3D ctypes.get_errno()
+		raise Exception("Could not mount %s (%d)" % (target, errno))
+
+MountInfo =3D namedtuple('MountInfo', 'fstype target options flags')
+
+mount_table =3D [
+	MountInfo('sysfs', '/sys', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
+	MountInfo('proc', '/proc', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
+	MountInfo('devpts', '/dev/pts', 'mode=3D0620', MS_NOSUID|MS_NOEXEC),
+	MountInfo('tmpfs', '/dev/shm', 'mode=3D1777', MS_NOSUID|MS_NODEV|MS_STRIC=
TATIME),
+	MountInfo('tmpfs', '/run', 'mode=3D0755', MS_NOSUID|MS_NODEV|MS_STRICTATI=
ME),
+	MountInfo('tmpfs', '/var/lib/iwd', 'mode=3D0755', 0),
+	MountInfo('tmpfs', '/tmp', '', 0),
+	MountInfo('tmpfs', '/usr/share/dbus-1', 'mode=3D0755', MS_NOSUID|MS_NOEXE=
C|MS_NODEV|MS_STRICTATIME),
+	MountInfo('debugfs', '/sys/kernel/debug', '', 0)
+]
+
+DevInfo =3D namedtuple('DevInfo', 'target linkpath')
+
+dev_table =3D [
+	DevInfo('/proc/self/fd', '/dev/fd'),
+	DevInfo('/proc/self/fd/0', '/dev/stdin'),
+	DevInfo('/proc/self/fd/1', '/dev/stdout'),
+	DevInfo('/proc/self/fd/2', '/dev/stderr')
+]
+
+dbus_config =3D '''
+<!DOCTYPE busconfig PUBLIC \
+"-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN" \
+"http://www.freedesktop.org/standards/dbus/1.0/\
+busconfig.dtd\">
+<busconfig>
+<type>system</type>
+<listen>unix:path=3D/run/dbus/system_bus_socket</listen>
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
+</policy>
+</busconfig>
+'''
+class Process:
+	'''
+		Start a process. If 'wait' is True the constructor will start
+		the process and wait for it to exit. No PID is tracked in this
+		case. If 'multi_test' is True this indicates the process is
+		run over the entire test run and will not be killed after each
+		test exits.
+	'''
+	def __init__(self, args, wait=3DFalse, multi_test=3DFalse, env=3DNone, ct=
x=3DNone):
+		self.args =3D args
+		self.wait =3D wait
+		self.name =3D args[0]
+		self.multi_test =3D multi_test
+		self.stdout =3D subprocess.PIPE
+		self.stderr =3D subprocess.PIPE
+		self.ret =3D None
+		self.ctx =3D ctx
+
+		if ctx:
+			set_stdout =3D False
+
+			if ctx.is_verbose(args[0]):
+				dbg("Verbose on for %s" % args[0])
+				set_stdout =3D True
+
+			if os.path.basename(args[0]) =3D=3D ctx.args.gdb:
+				self.args =3D ['gdb', '--args']
+				self.args.extend(args)
+				set_stdout =3D True
+
+			# Anything labeled as multi_test isn't important to
+			# log. These are processes such as dbus-daemon and
+			# haveged.
+			if set_stdout:
+				if ctx.args.log:
+					test =3D os.path.basename(os.getcwd())
+					test_dir =3D '%s/%s' % (ctx.args.log, test)
+
+					if not path_exists(test_dir):
+						os.mkdir(test_dir)
+						os.chown(test_dir, int(ctx.args.log_uid), \
+								int(ctx.args.log_gid))
+
+					self.stdout =3D open('%s/%s' % (test_dir, args[0]), 'w')
+					self.stderr =3D open('%s/%s' % (test_dir, args[0]), 'w')
+				else:
+					self.stdout =3D sys.__stdout__
+					self.stderr =3D sys.__stderr__
+
+		if not wait:
+			self.pid =3D subprocess.Popen(self.args, stdout=3Dself.stdout, \
+							stderr=3Dself.stderr, env=3Denv, \
+							cwd=3Dos.getcwd())
+			print("Starting process {}".format(self.pid.args))
+		else:
+			self.ret =3D subprocess.call(self.args, stdout=3Dself.stdout, \
+							stderr=3Dself.stderr)
+			print("%s returned %d" % (args[0], self.ret))
+
+	def __del__(self):
+		print("Del process %s" % self.args)
+		if self.ctx and self.ctx.args.log:
+			self.stdout.close()
+			self.stderr.close()
+
+	def kill(self, force=3DFalse):
+		print("Killing process %s" % self.args)
+
+		if force:
+			os.kill(self.pid.pid, signal.SIGKILL)
+		else:
+			self.pid.kill()
+
+		self.pid.wait(timeout=3D15)
+
+	def wait_for_socket(self, socket, wait):
+		waited =3D 0
+		while not os.path.exists(socket):
+			sleep(0.5)
+			waited +=3D 0.5
+			if waited > wait:
+				raise Exception("Timed out waiting for socket")
+
+class Interface:
+	def __init__(self, name, config):
+		self.name =3D name
+		self.ctrl_interface =3D '/var/run/hostapd/' + name
+		self.config =3D config
+
+	def __del__(self):
+		Process(['iw', 'dev', self.name, 'del'], True)
+
+	def set_interface_state(self, state):
+		Process(['ifconfig', self.name, state], True)
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
+	def create_interface(self, hapd):
+		global intf_id
+
+		ifname =3D 'wln%s' % intf_id
+
+		intf_id +=3D 1
+
+		self.interface =3D Interface(ifname, hapd.config)
+		# IWD does not use interfaces in test-runner so any created
+		# interface is assumed to be used by hostapd.
+		self.use =3D 'hostapd'
+
+		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
+				'type', 'managed'], True)
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
+	def __init__(self, name, config=3DNone):
+		super().__init__(name)
+
+		self.disable_cipher =3D None
+		self.disable_iftype =3D None
+
+		args =3D ['hwsim', '--create', '--name', self.name, '--nointerface']
+
+		if config:
+			self.disable_iftype =3D config.get('iftype_disable', False)
+			if self.disable_iftype:
+				args.append('--iftype-disable')
+				args.append(self.disable_iftype)
+
+			self.disable_cipher =3D config.get('cipher_disable', False)
+			if self.disable_cipher:
+				args.append('--cipher-disable')
+				args.append(self.disable_cipher)
+
+		p =3D Process(args, wait=3DTrue)
+
+		if p.ret < 0:
+			raise Exception('Failed to create radio (%d)' % p.ret)
+
+		self.id =3D p.ret
+
+	def __del__(self):
+		super().__del__()
+
+		Process(['hwsim', '--destroy=3D%s' % self.id])
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
+
+		self.intf =3D radio.create_interface(self)
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
+		if len(configs) !=3D len(radios):
+			raise Exception("Config (%d) and radio (%d) list length not equal" % \
+						(len(configs), len(radios)))
+
+		print("Initializing hostapd instances")
+
+		self.global_ctrl_iface =3D '/var/run/hostapd/ctrl'
+
+		self.instances =3D [HostapdInstance(c, r) for c, r in zip(configs, radio=
s)]
+
+		ifaces =3D [rad.interface.name for rad in radios]
+		ifaces =3D ','.join(ifaces)
+
+		args =3D ['hostapd', '-i', ifaces, '-g', self.global_ctrl_iface]
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
+		self.process =3D ctx.start_process(args)
+
+		self.process.wait_for_socket(self.global_ctrl_iface, 10)
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
+			dbg("Failed to remove %s" % self.global_ctrl_iface)
+
+		self.instances =3D None
+		self.process.kill()
+
+class TestContext:
+	'''
+		Contains all information for a given set of tests being run
+		such as processes, radios, interfaces and test results.
+	'''
+	def __init__(self, args):
+		self.processes =3D []
+		self.args =3D args
+		self.hw_config =3D None
+		self.hostapd =3D None
+		self.cur_radio_id =3D 0
+		self.cur_iface_id =3D 0
+		self.radios =3D []
+		self.loopback_started =3D False
+		self.iwd_extra_options =3D None
+		self.results =3D {}
+
+	def start_process(self, args, wait=3DFalse, multi_test=3DFalse, env=3DNon=
e):
+		p =3D Process(args, wait, multi_test, env, ctx=3Dself)
+
+		if not wait:
+			self.processes.append(p)
+
+		return p
+
+	def start_dbus(self):
+		with open('/usr/share/dbus-1/system.conf', 'w+') as f:
+			f.write(dbus_config)
+
+		os.mkdir('/run/dbus', 755)
+
+		self.start_process(['dbus-daemon', '--system', '--nosyslog'], multi_test=
=3DTrue)
+
+	def start_dbus_monitor(self):
+		if not self.is_verbose('dbus-monitor'):
+			return
+
+		self.start_process(['dbus-monitor', '--system'])
+
+	def start_haveged(self):
+		self.start_process(['haveged'], multi_test=3DTrue)
+
+	def create_radios(self):
+		setup =3D self.hw_config['SETUP']
+		nradios =3D int(setup['num_radios'])
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
+		# register hwsim as medium
+		self.start_process(['hwsim'])
+
+	def discover_radios(self):
+		phys =3D []
+		iw =3D pyroute2.iwutil.IW()
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
+			Process(['iw', 'reg', 'set', reg_domain], True)
+
+		if self.args.hw:
+			self.discover_radios()
+		else:
+			self.create_radios()
+
+	def start_iwd(self, config_dir =3D '/tmp'):
+		args =3D []
+		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
+
+		if self.args.valgrind:
+			args.extend(['valgrind', '--leak-check=3Dfull', '--log-file=3D%s' % \
+					'/tmp/valgrind.log'])
+
+		args.extend(['iwd', '-p', iwd_radios])
+
+		if self.is_verbose(args[0]):
+			args.append('-d')
+
+		if self.iwd_extra_options:
+			args.append(self.iwd_extra_options)
+
+		env =3D os.environ.copy()
+		env['CONFIGURATION_DIRECTORY'] =3D config_dir
+		env['STATE_DIRECTORY'] =3D '/var/lib/iwd'
+
+		pid =3D self.start_process(args, env=3Denv)
+		return pid
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
+
+	def start_ofono(self):
+		sim_keys =3D self.hw_config['SETUP'].get('sim_keys', None)
+		if not sim_keys:
+			print("Ofono not requred")
+			return
+		elif sim_keys !=3D 'ofono':
+			os.environ['IWD_SIM_KEYS'] =3D sim_keys
+			self.iwd_extra_options =3D '--plugin=3Dsim_hardcoded'
+			return
+
+		if not find_binary(['ofonod']) or not find_binary(['phonesim']):
+			print("Ofono or Phonesim not found, skipping test")
+			return
+
+		Process(['ifconfig', 'lo', 'up'], wait=3DTrue)
+
+		self.iwd_extra_options =3D '--plugin=3Dofono'
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
+	def is_verbose(self, process):
+		process =3D os.path.basename(process)
+
+		if self.args is None:
+			return False
+
+		# every process is verbose when logging is enabled
+		if self.args.log:
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
+	def stop_process(self, p, force=3DFalse):
+		p.kill(force)
+		self.processes.remove(p)
+
+	def stop_test_processes(self):
+		self.radios =3D []
+		self.hostapd =3D None
+		self.iwd_extra_options =3D None
+
+		for p in [p for p in self.processes if p.multi_test is False]:
+			print("Killing process %s" % p.name)
+			self.stop_process(p)
+
+	def is_process_running(self, process):
+		for p in self.processes:
+			if p.name =3D=3D process:
+				return True
+		return False
+
+	def __str__(self):
+		ret =3D 'Arguments:\n'
+		for arg in vars(self.args):
+			ret +=3D '\t --%s %s\n' % (arg, str(getattr(self.args, arg)))
+
+		ret +=3D 'Processes:\n'
+		for p in self.processes:
+			ret +=3D '\t%s\n' % str(p.args)
+
+		ret +=3D 'Radios:\n'
+		if len(self.radios) > 0:
+			for r in self.radios:
+				ret +=3D '\t%s\n' % str(r)
+		else:
+			ret +=3D '\tNo Radios\n'
+
+		ret +=3D 'Hostapd:\n'
+		if self.hostapd:
+			for h in self.hostapd.instances:
+				ret +=3D '\t%s\n' % str(h)
+		else:
+			ret +=3D '\tNo Hostapd instances\n'
+
+		return ret
+
+def prepare_sandbox():
+	print('Preparing sandbox')
+
+	for entry in mount_table:
+		try:
+			os.lstat(entry.target)
+		except:
+			os.mkdir(entry.target, 755)
+
+		mount(entry.fstype, entry.target, entry.fstype, entry.flags,
+			entry.options)
+
+	for entry in dev_table:
+		os.symlink(entry.target, entry.linkpath)
+
+	os.setsid()
+
+	fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
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
+	if not args.auto_tests:
+		# --shell with no tests implies 'shell' test
+		if args.shell:
+			return [test_root + '/shell']
+
+		tests =3D os.listdir(test_root)
+		# Pair down any non-tests and append full path
+		tests =3D [test_root + '/' + t for t in tests if t.startswith('test')]
+	else:
+		print("Generating partial test list")
+		for t in args.auto_tests.split(','):
+			path =3D '%s/%s' % (test_root, t)
+			# Full test path specified
+			if os.path.exists(t):
+				tests.append(t)
+			elif os.path.exists(path):
+				tests.append(path)
+			else:
+				matches =3D glob(path)
+				if matches =3D=3D []:
+					raise Exception("Could not find test %s" % t)
+
+				tests.extend(matches)
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
+	suite =3D unittest.TestSuite()
+
+	#
+	# Iterate through each individual python test.
+	#
+	for s in subtests:
+		loader =3D unittest.TestLoader()
+		subtest =3D importlib.import_module(os.path.splitext(s)[0])
+		suite.addTests(loader.loadTestsFromModule(subtest))
+
+		# Prevents future test modules with the same name (e.g.
+		# connection_test.py) from being loaded from the cache
+		sys.modules.pop(subtest.__name__)
+
+	start =3D time.time()
+	runner =3D unittest.TextTestRunner()
+	result =3D runner.run(suite)
+	#
+	# The multiprocessing queue is picky with what objects it will serialize
+	# and send between processes. Because of this we put the important bits
+	# of the result into our own 'SimpleResult' tuple.
+	#
+	sresult =3D SimpleResult(run=3Dresult.testsRun, failures=3Dlen(result.fai=
lures),
+				errors=3Dlen(result.errors), skipped=3Dlen(result.skipped),
+				time=3Dtime.time() - start)
+	rqueue.put(sresult)
+
+	# This may not be required since we are manually popping sys.modules
+	importlib.invalidate_caches()
+
+def pre_test(ctx, test):
+	'''
+		Copy test files, start processes, and any other pre test work.
+	'''
+	os.chdir(test)
+
+	dbg("Starting test %s" % test)
+	if not os.path.exists(test + '/hw.conf'):
+		print("No hw.conf found for %s" % test)
+		exit()
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
h('.py')]
+	for f in to_copy:
+		if os.path.isdir(f):
+			shutil.copytree(f, '/tmp/' + f)
+		else:
+			shutil.copy(f, '/tmp')
+
+	ctx.start_dbus_monitor()
+	ctx.start_radios()
+	ctx.start_hostapd()
+	ctx.start_ofono()
+
+	print(ctx)
+
+	sys.path.insert(1, test)
+
+	return (to_copy, subtests)
+
+def post_test(ctx, to_copy):
+	'''
+		Remove copied files, and stop test processes.
+	'''
+	for f in to_copy:
+		if os.path.isdir('/tmp/' + f):
+			shutil.rmtree('/tmp/' + f)
+		else:
+			os.remove('/tmp/' + f)
+
+	Process(['ifconfig', 'lo', 'down'], wait=3DTrue)
+
+	ctx.stop_test_processes()
+	if ctx.args.valgrind:
+		with open('/tmp/valgrind.log', 'r') as f:
+				dbg(f.read())
+		dbg("\n")
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
+		if result.time !=3D TEST_MAX_TIMEOUT:
+			failed =3D result.failures + result.errors
+			passed =3D result.run - failed
+
+			total_pass +=3D passed
+			total_fail +=3D failed
+			total_skip +=3D result.skipped
+		else:
+			failed =3D "Timed out"
+			passed =3D "Timed out"
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
+def run_auto_tests(ctx, args):
+	tests =3D build_test_list(args)
+
+	ctx.start_dbus()
+	ctx.start_haveged()
+
+	# Copy autotests/misc/{certs,secrets,phonesim} so any test can refer to t=
hem
+	shutil.copytree(args.testhome + '/autotests/misc/certs', '/tmp/certs')
+	shutil.copytree(args.testhome + '/autotests/misc/secrets', '/tmp/secrets')
+	shutil.copy(args.testhome + '/autotests/misc/phonesim/phonesim.conf', '/t=
mp')
+
+	if args.shell:
+		#
+		# Shell really isn't meant to be used with multiple tests. If
+		# a set of tests was passed in just start out in the first.
+		#
+		os.chdir(tests[0])
+		os.system('/bin/bash')
+		exit()
+
+	for test in tests:
+		copied, subtests =3D pre_test(ctx, test)
+
+		rqueue =3D multiprocessing.Queue()
+		p =3D multiprocessing.Process(target=3Dstart_test, args=3D(ctx, subtests=
, rqueue))
+		p.start()
+		# Rather than time each subtest we just time the total but
+		# mutiply the default time by the number of tests being run.
+		p.join(TEST_MAX_TIMEOUT * len(subtests))
+
+		if p.is_alive():
+			# Timeout
+			p.terminate()
+
+			ctx.results[os.path.basename(test)] =3D SimpleResult(run=3D0,
+								failures=3D0, errors=3D0,
+								skipped=3D0, time=3DTEST_MAX_TIMEOUT)
+		else:
+			ctx.results[os.path.basename(test)] =3D rqueue.get()
+
+		post_test(ctx, copied)
+
+	# Write out kernel log
+	if ctx.args.log:
+		Process(["dmesg"], ctx=3Dctx, wait=3DTrue)
+
+	print_results(ctx.results)
+
+def run_unit_tests(ctx, args):
+	os.chdir(args.testhome + '/unit')
+	units =3D build_unit_list(args)
+
+	for u in units:
+		if ctx.start_process([u], wait=3DTrue).ret !=3D 0:
+			dbg("Unit test %s failed" % os.path.basename(u))
+		else:
+			dbg("Unit test %s passed" % os.path.basename(u))
+
+def run_tests():
+	global config
+
+	with open('/proc/cmdline', 'r') as f:
+		cmdline =3D f.read()
+
+	start =3D cmdline.find('--testhome')
+
+	options =3D shlex.split(cmdline[start:])
+
+	parser =3D argparse.ArgumentParser()
+	parser.add_argument('--testhome')
+	parser.add_argument('--auto_tests')
+	parser.add_argument('--unit_tests')
+	parser.add_argument('--verbose', default=3D[])
+	parser.add_argument('--debug')
+	parser.add_argument('--path')
+	parser.add_argument('--valgrind')
+	parser.add_argument('--gdb')
+	parser.add_argument('--shell')
+	parser.add_argument('--log')
+	parser.add_argument('--log-gid')
+	parser.add_argument('--log-uid')
+	parser.add_argument('--hw')
+
+	args =3D parser.parse_args(options)
+
+	#
+	# This prevents any print() calls in this script from printing unless
+	# --debug is passed. For an 'always print' option use dbg()
+	#
+	if not args.debug:
+		sys.stdout =3D open(os.devnull, 'w')
+
+	os.environ['PATH'] =3D args.path
+	os.environ['PATH'] +=3D ':' + args.testhome + '/src'
+
+	sys.path.append(args.testhome + '/autotests/util')
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
+	if args.log:
+		mount('logdir', args.log, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L')
+
+	if config.ctx.args.unit_tests is None:
+		run_auto_tests(config.ctx, args)
+	else:
+		run_unit_tests(config.ctx, args)
+
+class Main:
+	def __init__(self):
+		self.parser =3D argparse.ArgumentParser(
+				description=3D'IWD Test Runner')
+
+		self.parser.add_argument('--qemu', '-q',
+				metavar=3D'<QEMU binary>', type=3Dstr,
+				help=3D'QEMU binary to use',
+				dest=3D'qemu')
+		self.parser.add_argument('--kernel', '-k', metavar=3D'<kernel>',
+				type=3Dstr,
+				help=3D'Path to kernel image',
+				dest=3D'kernel')
+		self.parser.add_argument('--verbose', '-v', metavar=3D'<list>',
+				type=3Dstr,
+				help=3D'Comma separated list of applications',
+				dest=3D'verbose',
+				default=3D[])
+		self.parser.add_argument('--debug', '-d',
+				action=3D'store_true',
+				help=3D'Enable test-runner debugging',
+				dest=3D'debug')
+		self.parser.add_argument('--shell', '-s', action=3D'store_true',
+				help=3D'Boot into shell', dest=3D'shell')
+		self.parser.add_argument('--log', '-l', type=3Dstr,
+				help=3D'Directory for log files')
+		self.parser.add_argument('--hw', '-w', type=3Dstr, nargs=3D1,
+				help=3D'Use physical adapters for tests (passthrough)')
+
+		# Prevent --autotest/--unittest from being used together
+		auto_unit_group =3D self.parser.add_mutually_exclusive_group()
+		auto_unit_group.add_argument('--auto-tests', '-A',
+				metavar=3D'<tests>', type=3Dstr, nargs=3D1,
+				help=3D'List of tests to run',
+				default=3DNone,
+				dest=3D'auto_tests')
+		auto_unit_group.add_argument('--unit-tests', '-U',
+				metavar=3D'<tests>', type=3Dstr, nargs=3D'?',
+				const=3D'*',
+				help=3D'List of unit tests to run',
+				dest=3D'unit_tests')
+
+		# Prevent --valgrind/--gdb from being used together
+		valgrind_gdb_group =3D self.parser.add_mutually_exclusive_group()
+		valgrind_gdb_group.add_argument('--gdb', '-g', metavar=3D'<exec>',
+				type=3Dstr, nargs=3D1,
+				help=3D'Run gdb on specified executable',
+				dest=3D'gdb')
+		valgrind_gdb_group.add_argument('--valgrind', '-V', action=3D'store_true=
',
+				help=3D'Run valgrind on IWD', dest=3D'valgrind')
+
+		self.args =3D self.parser.parse_args()
+
+		print(self.args)
+
+		if self.args.log and self.args.unit_tests:
+			dbg("Cannot use --log with --unit-tests")
+			quit()
+
+	def start(self):
+		usb_adapters =3D None
+
+		qemu_table =3D [
+			'qemu-system-x86_64',
+			'/usr/bin/qemu-system-x86_64'
+		]
+
+		kernel_table =3D [
+			'bzImage',
+			'arch/x86/boot/bzImage',
+			'vmlinux',
+			'arch/x86/boot/vmlinux'
+		]
+
+		if self.args.qemu is None:
+			qemu_binary =3D find_binary(qemu_table)
+		else:
+			if path_exists(self.args.qemu):
+				qemu_binary =3D self.args.qemu
+			else:
+				print("QEMU binary %s does not exist" % \
+						self.args.qemu)
+				quit()
+
+		if self.args.kernel is None:
+			kernel_binary =3D find_binary(kernel_table)
+		else:
+			if path_exists(self.args.kernel):
+				kernel_binary =3D self.args.kernel
+			else:
+				print("Kernel image %s does not exist" % \
+						self.args.kernel)
+				quit()
+
+		if self.args.hw:
+			hw_conf =3D ConfigParser()
+			hw_conf.read(self.args.hw)
+			# TODO: Parse PCI adapters
+			if hw_conf.has_section('USBAdapters'):
+				# The actual key name of the adapter
+				# doesn't matter since all we need is the
+				# bus/address. This gets named by the kernel
+				# anyways once in the VM.
+				usb_adapters =3D [v for v in hw_conf['USBAdapters'].values()]
+
+		#
+		# Additional arguments not provided to test-runner which are
+		# needed once booted into the kernel.
+		#
+		options =3D 'init=3D%s' % os.path.realpath(sys.argv[0])
+
+		# Support running from top level as well as tools
+		if os.getcwd().endswith('tools'):
+			options +=3D ' --testhome %s/../' % os.getcwd()
+		else:
+			options +=3D ' --testhome %s' % os.getcwd()
+
+		options +=3D ' --path "%s"' % os.environ['PATH']
+
+		if self.args.auto_tests:
+			options +=3D ' --auto_tests %s' % ','.join(self.args.auto_tests)
+
+		if self.args.log:
+			if os.environ.get('SUDO_GID', None) is None:
+				print("--log can only be used as root user")
+				quit()
+
+			self.args.log =3D os.path.abspath(self.args.log)
+			uid =3D int(os.environ['SUDO_UID'])
+			gid =3D int(os.environ['SUDO_GID'])
+
+			if not path_exists(self.args.log):
+				os.mkdir(self.args.log)
+				os.chown(self.args.log, uid, gid)
+
+			options +=3D ' --log-gid %u' % gid
+			options +=3D ' --log-uid %u' % uid
+
+		denylist =3D [
+			'auto_tests',
+			'qemu',
+			'kernel'
+		]
+
+		#
+		# This passes through most of the command line options to
+		# the kernel command line. Some are not relevant (e.g. qemu)
+		# so similar options are added in the denylist above. This excludes
+		# any unset options which are assumed to be None or False. This
+		# is done so default arguments can be filled once in the VM. If
+		# we pass and basic types (None, False etc.) they are turned into
+		# a string representation ('None', 'False', etc.) which is not
+		# desirable.
+		#
+		for arg in vars(self.args):
+			if arg in denylist or getattr(self.args, arg) in [None, False, []]:
+				continue
+			options +=3D ' --%s %s' % (arg, str(getattr(self.args, arg)))
+
+		kern_log =3D "ignore_loglevel" if "kernel" in self.args.verbose else "qu=
iet"
+
+		qemu_cmdline =3D [
+			qemu_binary,
+			'-machine', 'type=3Dq35,accel=3Dkvm:tcg',
+			'-nodefaults', '-no-user-config', '-monitor', 'none',
+			'-display', 'none', '-m', '192M', '-nographic', '-vga',
+			'none', '-net', 'none', '-no-acpi', '-no-hpet',
+			'-no-reboot', '-fsdev',
+			'local,id=3Dfsdev-root,path=3D/,readonly,security_model=3Dnone',
+			'-device',
+			'virtio-9p-pci,fsdev=3Dfsdev-root,mount_tag=3D/dev/root',
+			'-chardev', 'stdio,id=3Dchardev-serial0,signal=3Doff',
+			'-device', 'pci-serial,chardev=3Dchardev-serial0',
+			'-device', 'virtio-rng-pci',
+			'-kernel',
+			kernel_binary,
+			'-append',
+			'console=3DttyS0,115200n8 earlyprintk=3Dserial \
+				rootfstype=3D9p root=3D/dev/root \
+				rootflags=3Dtrans=3Dvirtio,version=3D9p2000.u \
+				acpi=3Doff pci=3Dnoacpi %s ro \
+				mac80211_hwsim.radios=3D0 %s' % (kern_log, options),
+			'-cpu', 'host'
+		]
+
+		if usb_adapters:
+			for bus, addr in [s.split(',') for s in usb_adapters]:
+				qemu_cmdline.extend(['-usb',
+							'-device',
+							'usb-host,hostbus=3D%s,hostaddr=3D%s' % \
+							(bus, addr)])
+		if self.args.log:
+			#
+			# Creates a virtfs device that can be mounted. This mount
+			# will point back to the provided log directory and is
+			# writable unlike the rest of the mounted file system.
+			#
+			qemu_cmdline.extend([
+				'-virtfs',
+				'local,path=3D%s,mount_tag=3Dlogdir,security_model=3Dpassthrough,id=3D=
logdir' \
+						% self.args.log
+			])
+
+		os.execlp(qemu_cmdline[0], *qemu_cmdline)
+
+if __name__ =3D=3D '__main__':
+	if os.getpid() =3D=3D 1 and os.getppid() =3D=3D 0:
+		atexit.register(exit_vm)
+		prepare_sandbox()
+		run_tests()
+
+		exit()
+
+	main =3D Main()
+	main.start()
-- =

2.21.1

--===============3232831415175643374==--

