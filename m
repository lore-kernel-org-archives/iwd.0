Content-Type: multipart/mixed; boundary="===============1676918781833391328=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 02/14] test-runner: remove environment specific code
Date: Thu, 31 Mar 2022 16:16:29 -0700
Message-ID: <20220331231641.484200-2-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============1676918781833391328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This removes all the Qemu/environment related code as this has been
moved into runner.py.
---
 tools/test-runner | 506 ++--------------------------------------------
 1 file changed, 17 insertions(+), 489 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 81624953..c6f7f550 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1,24 +1,21 @@
 #!/usr/bin/python3
 =

-import argparse
 import os
 import shutil
-import ctypes
 import fcntl
-import shlex
 import sys
 import subprocess
 import atexit
 import time
 import unittest
 import importlib
-import signal
 from unittest.result import TestResult
-import pyroute2
 import multiprocessing
 import re
 import traceback
 =

+from runner import Runner
+
 from configparser import ConfigParser
 from prettytable import PrettyTable
 from termcolor import colored
@@ -29,19 +26,6 @@ import dbus.mainloop.glib
 from gi.repository import GLib
 from weakref import WeakValueDictionary
 =

-libc =3D ctypes.cdll['libc.so.6']
-libc.mount.argtypes =3D (ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p=
, \
-			ctypes.c_ulong, ctypes.c_char_p)
-
-# Using ctypes to load the libc library is somewhat low level. Because of =
this
-# we need to define our own flags/options for use with mounting.
-MS_NOSUID =3D 2
-MS_NODEV =3D 4
-MS_NOEXEC =3D 8
-MS_STRICTATIME =3D 1 << 24
-STDIN_FILENO =3D 0
-TIOCSTTY =3D 0x540E
-
 config =3D None
 intf_id =3D 0
 =

@@ -73,14 +57,7 @@ def exit_vm():
 =

 	os.sync()
 =

-	RB_AUTOBOOT =3D 0x01234567
-	#
-	# Calling 'reboot' or 'shutdown' from a shell (e.g. os.system('reboot'))
-	# is not the same the POSIX reboot() and will cause a kernel panic since
-	# we are the init process. The libc.reboot() allows the VM to exit
-	# gracefully.
-	#
-	libc.reboot(RB_AUTOBOOT)
+	runner.stop()
 =

 def path_exists(path):
 	'''
@@ -104,38 +81,6 @@ def find_binary(list):
 			return path
 	return None
 =

-def mount(source, target, fs, flags, options=3D''):
-	'''
-		Python wrapper for libc mount()
-	'''
-	ret =3D libc.mount(source.encode(), target.encode(), fs.encode(), flags,
-				options.encode())
-	if ret < 0:
-		errno =3D ctypes.get_errno()
-		raise Exception("Could not mount %s (%d)" % (target, errno))
-
-MountInfo =3D namedtuple('MountInfo', 'fstype target options flags')
-
-mount_table =3D [
-	MountInfo('sysfs', '/sys', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
-	MountInfo('proc', '/proc', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
-	MountInfo('devpts', '/dev/pts', 'mode=3D0620', MS_NOSUID|MS_NOEXEC),
-	MountInfo('tmpfs', '/dev/shm', 'mode=3D1777', MS_NOSUID|MS_NODEV|MS_STRIC=
TATIME),
-	MountInfo('tmpfs', '/run', 'mode=3D0755', MS_NOSUID|MS_NODEV|MS_STRICTATI=
ME),
-	MountInfo('tmpfs', '/tmp', '', 0),
-	MountInfo('tmpfs', '/usr/share/dbus-1', 'mode=3D0755', MS_NOSUID|MS_NOEXE=
C|MS_NODEV|MS_STRICTATIME),
-	MountInfo('debugfs', '/sys/kernel/debug', '', 0)
-]
-
-DevInfo =3D namedtuple('DevInfo', 'target linkpath')
-
-dev_table =3D [
-	DevInfo('/proc/self/fd', '/dev/fd'),
-	DevInfo('/proc/self/fd/0', '/dev/stdin'),
-	DevInfo('/proc/self/fd/1', '/dev/stdout'),
-	DevInfo('/proc/self/fd/2', '/dev/stderr')
-]
-
 # Partial DBus config. The remainder (<listen>) will be filled in for each
 # namespace that is created so each individual dbus-daemon has its own soc=
ket
 # and address.
@@ -910,6 +855,8 @@ class TestContext(Namespace):
 			self.cur_radio_id +=3D 1
 =

 	def discover_radios(self):
+		import pyroute2
+
 		phys =3D []
 =

 		try:
@@ -1129,27 +1076,6 @@ class TestContext(Namespace):
 =

 		return ret
 =

-def prepare_sandbox():
-	print('Preparing sandbox')
-
-	for entry in mount_table:
-		try:
-			os.lstat(entry.target)
-		except:
-			os.mkdir(entry.target, 755)
-
-		mount(entry.fstype, entry.target, entry.fstype, entry.flags,
-			entry.options)
-
-	for entry in dev_table:
-		os.symlink(entry.target, entry.linkpath)
-
-	os.mkdir('/tmp/iwd')
-
-	os.setsid()
-
-	fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
-
 def build_unit_list(args):
 	'''
 		Build list of unit tests based on passed arguments. This first
@@ -1187,11 +1113,7 @@ def build_test_list(args):
 	test_root =3D args.testhome + '/autotests'
 =

 	# Run all tests
-	if not args.auto_tests:
-		# --shell with no tests implies 'shell' test
-		if args.shell:
-			return [test_root + '/shell']
-
+	if not args.autotests:
 		# Get list of all autotests (committed in git)
 		tests =3D os.popen('git -C %s ls-files autotests/ | cut -f2 -d"/" \
 					| grep "test*" | uniq' % args.testhome).read() \
@@ -1202,7 +1124,7 @@ def build_test_list(args):
 =

 		full_list =3D sorted(os.listdir(test_root))
 =

-		for t in args.auto_tests.split(','):
+		for t in args.autotests.split(','):
 			path =3D '%s/%s' % (test_root, t)
 			if t.endswith('+'):
 				t =3D t.split('+')[0]
@@ -1527,26 +1449,11 @@ def print_results(results):
 def run_auto_tests(ctx, args):
 	tests =3D build_test_list(args)
 =

-	# Copy autotests/misc/{certs,secrets,phonesim} so any test can refer to t=
hem
-	shutil.copytree(args.testhome + '/autotests/misc/certs', '/tmp/certs')
-	shutil.copytree(args.testhome + '/autotests/misc/secrets', '/tmp/secrets')
-	shutil.copy(args.testhome + '/autotests/misc/phonesim/phonesim.conf', '/t=
mp')
-
 	for test in tests:
 		copied =3D []
 		try:
 			subtests =3D pre_test(ctx, test, copied)
 =

-			if args.shell:
-				#
-				# Shell really isn't meant to be used with multiple tests. If
-				# a set of tests was passed in just start out in the first.
-				#
-				os.chdir(tests[0])
-				os.environ['DBUS_SYSTEM_BUS_ADDRESS'] =3D ctx.dbus_address
-				os.system('/bin/bash')
-				sys.exit()
-
 			if len(subtests) < 1:
 				dbg("No tests to run")
 				sys.exit()
@@ -1576,11 +1483,6 @@ def run_auto_tests(ctx, args):
 		finally:
 			post_test(ctx, copied)
 =

-	shutil.rmtree('/tmp/iwd')
-	shutil.rmtree('/tmp/certs')
-	shutil.rmtree('/tmp/secrets')
-	os.remove('/tmp/phonesim.conf')
-
 def run_unit_tests(ctx, args):
 	os.chdir(args.testhome + '/unit')
 	units =3D build_unit_list(args)
@@ -1592,54 +1494,10 @@ def run_unit_tests(ctx, args):
 		else:
 			dbg("Unit test %s passed" % os.path.basename(u))
 =

-def run_tests():
+def run_tests(args):
 	global config
 =

-	with open('/proc/cmdline', 'r') as f:
-		cmdline =3D f.read()
-
-	start =3D cmdline.find('--testhome')
-
-	options =3D shlex.split(cmdline[start:])
-
-	parser =3D argparse.ArgumentParser()
-	parser.add_argument('--testhome')
-	parser.add_argument('--auto_tests')
-	parser.add_argument('--unit_tests')
-	parser.add_argument('--verbose', default=3D[])
-	parser.add_argument('--debug')
-	parser.add_argument('--path')
-	parser.add_argument('--valgrind')
-	parser.add_argument('--gdb')
-	parser.add_argument('--shell')
-	parser.add_argument('--log')
-	parser.add_argument('--log-gid')
-	parser.add_argument('--log-uid')
-	parser.add_argument('--hw')
-	parser.add_argument('--monitor')
-	parser.add_argument('--sub_tests')
-	parser.add_argument('--result')
-
-	args =3D parser.parse_args(options)
-
-	#
-	# This prevents any print() calls in this script from printing unless
-	# --debug is passed. For an 'always print' option use dbg()
-	#
-	if not args.debug:
-		sys.stdout =3D open(os.devnull, 'w')
-
-	if args.verbose !=3D []:
-		args.verbose =3D args.verbose.split(',')
-
-	os.environ['PATH'] =3D '%s/src' % args.testhome
-	os.environ['PATH'] +=3D ':%s/tools' % args.testhome
-	os.environ['PATH'] +=3D ':%s/client' % args.testhome
-	os.environ['PATH'] +=3D ':%s/monitor' % args.testhome
-	os.environ['PATH'] +=3D ':%s/wired' % args.testhome
-	os.environ['PATH'] +=3D ':' + args.path
-
-	sys.path.append(args.testhome + '/autotests/util')
+	os.chdir(args.testhome)
 =

 	#
 	# This allows all autotest utils (iwd/hostapd/etc) to access the
@@ -1654,347 +1512,17 @@ def run_tests():
 	config.hwsim =3D importlib.import_module('hwsim')
 	config.hostapd =3D importlib.import_module('hostapd')
 =

-	if args.log:
-		mount('logdir', args.log, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,ms=
ize=3D10240')
-		# Clear out any log files from other test runs
-		for f in glob('%s/*' % args.log):
-			print("removing %s" % f)
-
-			if os.path.isdir(f):
-				shutil.rmtree(f)
-			else:
-				os.remove(f)
-
-		# Start writing out kernel log
-		config.ctx.start_process(["dmesg", '--follow'])
-	elif args.monitor:
-		parent =3D os.path.abspath(os.path.join(args.monitor, os.pardir))
-		mount('mondir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,msiz=
e=3D10240')
+	# Start writing out kernel log
+	config.ctx.start_process(["dmesg", '--follow'])
 =

-	if args.result:
-		parent =3D os.path.abspath(os.path.join(args.result, os.pardir))
-		mount('resultdir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,m=
size=3D10240')
-
-	if config.ctx.args.unit_tests is None:
+	if args.unit_tests is None:
 		run_auto_tests(config.ctx, args)
 	else:
 		run_unit_tests(config.ctx, args)
 =

-class Main:
-	def __init__(self):
-		self.parser =3D argparse.ArgumentParser(
-				description=3D'IWD Test Runner')
-
-		self.parser.add_argument('--qemu', '-q',
-				metavar=3D'<QEMU binary>', type=3Dstr,
-				help=3D'QEMU binary to use',
-				dest=3D'qemu',
-				default=3DNone)
-		self.parser.add_argument('--kernel', '-k', metavar=3D'<kernel>',
-				type=3Dstr,
-				help=3D'Path to kernel image',
-				dest=3D'kernel',
-				default=3DNone)
-		self.parser.add_argument('--verbose', '-v', metavar=3D'<list>',
-				type=3Dstr,
-				help=3D'Comma separated list of applications',
-				dest=3D'verbose',
-				default=3D[])
-		self.parser.add_argument('--debug', '-d',
-				action=3D'store_true',
-				help=3D'Enable test-runner debugging',
-				dest=3D'debug')
-		self.parser.add_argument('--shell', '-s', action=3D'store_true',
-				help=3D'Boot into shell', dest=3D'shell')
-		self.parser.add_argument('--log', '-l', type=3Dstr,
-				help=3D'Directory for log files')
-		self.parser.add_argument('--hw', '-w', type=3Dstr, nargs=3D1,
-				help=3D'Use physical adapters for tests (passthrough)')
-		self.parser.add_argument('--monitor', '-m', type=3Dstr,
-				help=3D'Enables iwmon output to file')
-		self.parser.add_argument('--sub-tests', '-S', metavar=3D'<subtests>',
-				type=3Dstr, nargs=3D1, help=3D'List of subtests to run',
-				default=3DNone, dest=3D'sub_tests')
-		self.parser.add_argument('--result', '-r', type=3Dstr,
-				help=3D'Writes PASS/FAIL to results file')
-
-		# Prevent --autotest/--unittest from being used together
-		auto_unit_group =3D self.parser.add_mutually_exclusive_group()
-		auto_unit_group.add_argument('--auto-tests', '-A',
-				metavar=3D'<tests>', type=3Dstr, nargs=3D1,
-				help=3D'List of tests to run',
-				default=3DNone,
-				dest=3D'auto_tests')
-		auto_unit_group.add_argument('--unit-tests', '-U',
-				metavar=3D'<tests>', type=3Dstr, nargs=3D'?',
-				const=3D'*',
-				help=3D'List of unit tests to run',
-				dest=3D'unit_tests')
-
-		# Prevent --valgrind/--gdb from being used together
-		valgrind_gdb_group =3D self.parser.add_mutually_exclusive_group()
-		valgrind_gdb_group.add_argument('--gdb', '-g', metavar=3D'<exec>',
-				type=3Dstr, nargs=3D1,
-				help=3D'Run gdb on specified executable',
-				dest=3D'gdb')
-		valgrind_gdb_group.add_argument('--valgrind', '-V', action=3D'store_true=
',
-				help=3D'Run valgrind on IWD', dest=3D'valgrind')
-
-		self.args =3D self.parser.parse_args()
-
-		if self.args.auto_tests:
-			self.args.auto_tests =3D self.args.auto_tests[0].split(',')
-
-		if self.args.sub_tests:
-			self.args.sub_tests =3D self.args.sub_tests[0].split(',')
-
-		if self.args.log and self.args.unit_tests:
-			dbg("Cannot use --log with --unit-tests")
-			quit()
-
-		if self.args.sub_tests:
-			if not self.args.auto_tests:
-				dbg("--sub-tests must be used with --auto-tests")
-				quit()
-
-			if len(self.args.auto_tests) > 1:
-				dbg("--sub-tests must be used with a single auto test")
-				quit()
-
-	def start(self):
-		usb_adapters =3D None
-		pci_adapters =3D None
-
-		qemu_table =3D [
-			'qemu-system-x86_64',
-			'/usr/bin/qemu-system-x86_64'
-		]
-
-		kernel_table =3D [
-			'bzImage',
-			'arch/x86/boot/bzImage',
-			'vmlinux',
-			'arch/x86/boot/vmlinux'
-		]
-
-		if self.args.qemu is None:
-			qemu_binary =3D find_binary(qemu_table)
-			if not qemu_binary:
-				print("Could not find qemu binary")
-				quit()
-		else:
-			if path_exists(self.args.qemu):
-				qemu_binary =3D self.args.qemu
-			else:
-				print("QEMU binary %s does not exist" % \
-						self.args.qemu)
-				quit()
-
-		if self.args.kernel is None:
-			kernel_binary =3D find_binary(kernel_table)
-			if not kernel_binary:
-				print("Could not find kernel image")
-				quit()
-		else:
-			if path_exists(self.args.kernel):
-				kernel_binary =3D self.args.kernel
-			else:
-				print("Kernel image %s does not exist" % \
-						self.args.kernel)
-				quit()
-
-		if self.args.hw:
-			hw_conf =3D ConfigParser()
-			hw_conf.read(self.args.hw)
-
-			if hw_conf.has_section('USBAdapters'):
-				# The actual key name of the adapter
-				# doesn't matter since all we need is the
-				# bus/address. This gets named by the kernel
-				# anyways once in the VM.
-				usb_adapters =3D [v for v in hw_conf['USBAdapters'].values()]
-
-			if hw_conf.has_section('PCIAdapters'):
-				pci_adapters =3D [v for v in hw_conf['PCIAdapters'].values()]
-
-		#
-		# Additional arguments not provided to test-runner which are
-		# needed once booted into the kernel.
-		#
-		options =3D 'init=3D%s' % os.path.realpath(sys.argv[0])
-
-		# Support running from top level as well as tools
-		if os.getcwd().endswith('tools'):
-			options +=3D ' --testhome %s/../' % os.getcwd()
-		else:
-			options +=3D ' --testhome %s' % os.getcwd()
-
-		options +=3D ' --path "%s"' % os.environ['PATH']
-
-		if self.args.auto_tests:
-			options +=3D ' --auto_tests %s' % ','.join(self.args.auto_tests)
-
-		if self.args.sub_tests:
-			options +=3D ' --sub_tests %s' % ','.join(self.args.sub_tests)
-
-		gid =3D None
-		if os.environ.get('SUDO_GID', None):
-			uid =3D int(os.environ['SUDO_UID'])
-			gid =3D int(os.environ['SUDO_GID'])
-
-		append_gid_uid =3D False
-
-		if self.args.log:
-			if os.getuid() !=3D 0:
-				print("--log can only be used as root user")
-				quit()
-
-			self.args.log =3D os.path.abspath(self.args.log)
-			append_gid_uid =3D True
-
-			if not path_exists(self.args.log):
-				os.mkdir(self.args.log)
-				if gid:
-					os.chown(self.args.log, uid, gid)
-
-		if self.args.monitor:
-			if os.getuid() !=3D 0:
-				print("--monitor can only be used as root user")
-				quit()
+runner =3D Runner(from_env=3DTrue)
 =

-			self.args.monitor =3D os.path.abspath(self.args.monitor)
-			mon_parent_dir =3D os.path.abspath(os.path.join(self.args.monitor, os.p=
ardir))
-			append_gid_uid =3D True
-
-		if self.args.result:
-			if os.getuid() !=3D 0:
-				print("--result can only be used as root user")
-				quit()
-
-			self.args.result =3D os.path.abspath(self.args.result)
-			result_parent_dir =3D os.path.abspath(os.path.join(self.args.result, os=
.pardir))
-			append_gid_uid =3D True
-
-		if append_gid_uid and gid:
-			options +=3D ' --log-gid %u' % (gid,)
-			options +=3D ' --log-uid %u' % (uid,)
-
-		denylist =3D [
-			'auto_tests',
-			'sub_tests',
-			'qemu',
-			'kernel'
-		]
-
-		nproc =3D multiprocessing.cpu_count()
-
-		#
-		# Specially handle CPU systems with minimal cores, otherwise
-		# use half the host cores.
-		#
-		if nproc < 2:
-			smp =3D 1
-		else:
-			smp =3D int(nproc / 2)
-
-		ram =3D 256
-
-		print("Using %d cores, %d RAM for VM" % (smp, ram))
-
-		#
-		# This passes through most of the command line options to
-		# the kernel command line. Some are not relevant (e.g. qemu)
-		# so similar options are added in the denylist above. This excludes
-		# any unset options which are assumed to be None or False. This
-		# is done so default arguments can be filled once in the VM. If
-		# we pass and basic types (None, False etc.) they are turned into
-		# a string representation ('None', 'False', etc.) which is not
-		# desirable.
-		#
-		for arg in vars(self.args):
-			if arg in denylist or getattr(self.args, arg) in [None, False, []]:
-				continue
-			options +=3D ' --%s %s' % (arg, str(getattr(self.args, arg)))
-
-		kern_log =3D "ignore_loglevel" if "kernel" in self.args.verbose else "qu=
iet"
-
-		qemu_cmdline =3D [
-			qemu_binary,
-			'-machine', 'type=3Dq35,accel=3Dkvm:tcg',
-			'-nodefaults', '-no-user-config', '-monitor', 'none',
-			'-display', 'none', '-m', '%dM' % ram, '-nographic', '-vga',
-			'none', '-no-acpi', '-no-hpet',
-			'-no-reboot', '-fsdev',
-			'local,id=3Dfsdev-root,path=3D/,readonly=3Don,security_model=3Dnone,mul=
tidevs=3Dremap',
-			'-device',
-			'virtio-9p-pci,fsdev=3Dfsdev-root,mount_tag=3D/dev/root',
-			'-chardev', 'stdio,id=3Dchardev-serial0,signal=3Doff',
-			'-device', 'pci-serial,chardev=3Dchardev-serial0',
-			'-device', 'virtio-rng-pci',
-			'-kernel',
-			kernel_binary,
-			'-append',
-			'console=3DttyS0,115200n8 earlyprintk=3Dserial \
-				rootfstype=3D9p root=3D/dev/root \
-				rootflags=3Dtrans=3Dvirtio \
-				acpi=3Doff pci=3Dnoacpi %s ro \
-				mac80211_hwsim.radios=3D0 %s' % (kern_log, options),
-			'-smp', str(smp)
-		]
-
-		# Add two ethernet devices for testing EAD
-		qemu_cmdline.extend([
-				'-net', 'nic,model=3Dvirtio',
-				'-net', 'nic,model=3Dvirtio',
-				'-net', 'user'
-		])
-
-		if usb_adapters:
-			for bus, addr in [s.split(',') for s in usb_adapters]:
-				qemu_cmdline.extend(['-usb',
-							'-device',
-							'usb-host,hostbus=3D%s,hostaddr=3D%s' % \
-							(bus, addr)])
-		if pci_adapters:
-			qemu_cmdline.extend(['-enable-kvm'])
-			for addr in pci_adapters:
-				qemu_cmdline.extend(['-device', 'vfio-pci,host=3D%s' % addr])
-
-		if self.args.log:
-			#
-			# Creates a virtfs device that can be mounted. This mount
-			# will point back to the provided log directory and is
-			# writable unlike the rest of the mounted file system.
-			#
-			qemu_cmdline.extend([
-				'-virtfs',
-				'local,path=3D%s,mount_tag=3Dlogdir,security_model=3Dpassthrough,id=3D=
logdir' \
-						% self.args.log
-			])
-
-		if self.args.monitor:
-			qemu_cmdline.extend([
-				'-virtfs',
-				'local,path=3D%s,mount_tag=3Dmondir,security_model=3Dpassthrough,id=3D=
mondir' \
-						% mon_parent_dir
-			])
-
-		if self.args.result:
-			qemu_cmdline.extend([
-				'-virtfs',
-				'local,path=3D%s,mount_tag=3Dresultdir,security_model=3Dpassthrough,id=
=3Dresultdir' \
-						% result_parent_dir
-			])
-
-		os.execlp(qemu_cmdline[0], *qemu_cmdline)
-
-if __name__ =3D=3D '__main__':
-	if os.getpid() =3D=3D 1 and os.getppid() =3D=3D 0:
-		atexit.register(exit_vm)
-		prepare_sandbox()
-		run_tests()
-
-		sys.exit()
-
-	main =3D Main()
-	main.start()
+atexit.register(exit_vm)
+runner.prepare_environment()
+run_tests(runner.args)
+runner.cleanup_environment()
-- =

2.34.1

--===============1676918781833391328==--

