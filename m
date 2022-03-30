Content-Type: multipart/mixed; boundary="===============4983819335840966970=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/7] test-runner: Move environment setup into own module
Date: Wed, 30 Mar 2022 15:20:51 -0700
Message-ID: <20220330222057.2160244-1-prestwoj@gmail.com>

--===============4983819335840966970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This (as well as subsequent commits) will separate test-runner into two
parts:

1. Environment setup
2. Running tests

Spurred by interest in adding UML/host support, test-runner was in need
of a refactor to separate out the environment setup and actually running
the tests.

The environment (currently only Qemu) requires quite a bit of special
handling (ctypes mounting/reboot, 9p mounts, tons of kernel options etc)
which nobody writing tests should need to see or care about. This has all
been moved into 'runner.py'.

Running the tests (inside test-runner) won't change much.

The new 'runner.py' module adds an abstraction class which allows different
Runner's to be implemented, and setup their own environment as they see
fit. This is in preparation for UML and Host runners.
---
 tools/runner.py | 485 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 485 insertions(+)
 create mode 100644 tools/runner.py

diff --git a/tools/runner.py b/tools/runner.py
new file mode 100644
index 00000000..743d74b1
--- /dev/null
+++ b/tools/runner.py
@@ -0,0 +1,485 @@
+#!/usr/bin/python3
+
+from argparse import ArgumentParser
+from argparse import Namespace
+from configparser import ConfigParser
+from collections import namedtuple
+from shutil import copy, copytree, which, rmtree
+from glob import glob
+
+import os
+import ctypes
+import fcntl
+import sys
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
+MountInfo =3D namedtuple('MountInfo', 'fstype target options flags')
+DevInfo =3D namedtuple('DevInfo', 'target linkpath')
+
+mounts_common =3D [
+	MountInfo('sysfs', '/sys', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
+	MountInfo('proc', '/proc', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
+	MountInfo('devpts', '/dev/pts', 'mode=3D0620', MS_NOSUID|MS_NOEXEC),
+	MountInfo('tmpfs', '/dev/shm', 'mode=3D1777',
+					MS_NOSUID|MS_NODEV|MS_STRICTATIME),
+	MountInfo('tmpfs', '/run', 'mode=3D0755',
+					MS_NOSUID|MS_NODEV|MS_STRICTATIME),
+	MountInfo('tmpfs', '/tmp', '', 0),
+	MountInfo('tmpfs', '/usr/share/dbus-1', 'mode=3D0755',
+					MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_STRICTATIME),
+]
+
+dev_table =3D [
+	DevInfo('/proc/self/fd', '/dev/fd'),
+	DevInfo('/proc/self/fd/0', '/dev/stdin'),
+	DevInfo('/proc/self/fd/1', '/dev/stdout'),
+	DevInfo('/proc/self/fd/2', '/dev/stderr')
+]
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
+#
+# Custom argparse.Namespace class to stringify arguments in a way that can=
 be
+# directly passed to the test environment as kernel arguments. This also r=
emoves
+# any None, False, or [] arguments.
+#
+class RunnerNamespace(Namespace):
+	def __init__(self, *args, **kwargs):
+		super().__init__(*args, **kwargs)
+
+	def to_cmd(self):
+		ret =3D ''
+		for k, v in self.__dict__.items():
+			if v in [None, False, [], '']:
+				continue
+
+			ret +=3D '%s=3D%s ' % (k, str(v))
+
+		return ret.strip()
+
+#
+# The core arguments needed both inside and outside the test environment
+#
+class RunnerCoreArgParse(ArgumentParser):
+	def __init__(self, *args, **kwargs):
+		super().__init__(self, *args, **kwargs)
+
+		self.add_argument('--start', '-s',
+				help=3D'Custom init process in virtual environment',
+				dest=3D'start',
+				default=3DNone)
+		self.add_argument('--verbose', '-v', metavar=3D'<list>',
+				type=3Dstr,
+				help=3D'Comma separated list of applications',
+				dest=3D'verbose',
+				default=3D[])
+		self.add_argument('--debug', '--dbg', '-d',
+				action=3D'store_true',
+				help=3D'Enable test-runner debugging',
+				dest=3D'dbg')
+		self.add_argument('--log', '-l',
+				type=3Dstr,
+				help=3D'Directory for log files')
+		self.add_argument('--monitor', '-m',
+				type=3Dstr,
+				help=3D'Enables iwmon output to file')
+		self.add_argument('--sub-tests', '-S',
+				metavar=3D'<subtests>',
+				type=3Dstr, nargs=3D1, help=3D'List of subtests to run',
+				default=3DNone, dest=3D'sub_tests')
+		self.add_argument('--result', '-e', type=3Dstr,
+				help=3D'Writes PASS/FAIL to results file')
+		self.add_argument('--hw', '-w',
+				type=3Dstr,
+				help=3D'Use physical adapters for tests (passthrough)')
+		self.add_argument('--testhome')
+
+		# Prevent --autotest/--unittest from being used together
+		auto_unit_group =3D self.add_mutually_exclusive_group()
+		auto_unit_group.add_argument('--autotests', '-A',
+				metavar=3D'<tests>',
+				type=3Dstr,
+				help=3D'List of tests to run',
+				default=3DNone,
+				dest=3D'autotests')
+		auto_unit_group.add_argument('--unit-tests', '-U',
+				metavar=3D'<tests>',
+				type=3Dstr,
+				nargs=3D'?',
+				const=3D'*',
+				help=3D'List of unit tests to run',
+				dest=3D'unit_tests')
+
+		# Prevent --valgrind/--gdb from being used together
+		valgrind_gdb_group =3D self.add_mutually_exclusive_group()
+		valgrind_gdb_group.add_argument('--gdb', '-g',
+				metavar=3D'<exec>',
+				type=3Dstr,
+				nargs=3D1,
+				help=3D'Run gdb on specified executable',
+				dest=3D'gdb')
+		valgrind_gdb_group.add_argument('--valgrind', '-V',
+				action=3D'store_true',
+				help=3D'Run valgrind on IWD',
+				dest=3D'valgrind')
+
+	# Overwrite to use a custom namespace class and parse from env
+	def parse_args(self, *args, namespace=3DRunnerNamespace()):
+		if len(sys.argv) > 1:
+			return super().parse_args(*args, namespace=3Dnamespace)
+
+		options =3D []
+		for k, v in os.environ.items():
+			options.append('--' + k)
+			options.append(v)
+
+		return self.parse_known_args(args=3Doptions, namespace=3Dnamespace)[0]
+
+#
+# Arguments only needed outside the test environment
+#
+class RunnerArgParse(RunnerCoreArgParse):
+	def __init__(self, *args, **kwargs):
+		super().__init__(*args, **kwargs)
+
+		self.add_argument('--runner', '-r',
+				metavar=3D'<runner type>',
+				type=3Dstr,
+				help=3D'Type of runner to use (qemu, uml, host)',
+				dest=3D'runner',
+				default=3DNone)
+		self.add_argument('--kernel', '-k',
+				metavar=3D'<kernel>',
+				type=3Dstr,
+				help=3D'Path to kernel/uml image',
+				dest=3D'kernel',
+				default=3DNone)
+
+#
+# Class to sort out what type of runner this is, returns the RunnerAbstract
+# implementation.
+#
+class Runner:
+	def __new__(self):
+		parser =3D RunnerArgParse(description=3D'IWD Test Runner')
+
+		args =3D parser.parse_args()
+
+		# Common options
+		args.PATH =3D os.environ['PATH']
+
+		if 'testhome' not in args.to_cmd():
+			if os.getcwd().endswith('tools'):
+				args.testhome =3D '%s/../' % os.getcwd()
+			else:
+				args.testhome =3D os.getcwd()
+
+		if args.start is None:
+			if os.path.exists('run-tests'):
+				args.start =3D os.path.abspath('run-tests')
+			elif os.path.exists('tools/run-tests'):
+				args.start =3D os.path.abspath('tools/run-tests')
+			else:
+				raise Exception("Cannot locate run-tests binary")
+
+		# If no runner is specified but we have a kernel image assume
+		# if the kernel is executable its UML, otherwise qemu
+		if not args.runner:
+			if not args.kernel:
+				raise Exception("Please specify --runner/--kernel")
+
+			if os.access(args.kernel, os.X_OK):
+				args.runner =3D 'uml'
+			else:
+				args.runner =3D 'qemu'
+
+		if args.runner =3D=3D 'qemu':
+			return QemuRunner(args)
+		else:
+			raise Exception("Unknown runner %s" % args.runner)
+
+class RunnerAbstract:
+	cmdline =3D []
+	env =3D None
+	name =3D "unnamed"
+
+	def __init__(self, args):
+		self.args =3D args
+
+		if self.args.log:
+			self.args.log =3D os.path.abspath(self.args.log)
+
+	def start(self):
+		print("Starting %s" % self.name)
+		os.execlpe(self.cmdline[0], *self.cmdline, self.env)
+
+	def prepare_environment(self):
+		path =3D os.environ['PATH']
+		os.environ['PATH'] =3D '%s/src' % self.args.testhome
+		os.environ['PATH'] +=3D ':%s/tools' % self.args.testhome
+		os.environ['PATH'] +=3D ':%s/client' % self.args.testhome
+		os.environ['PATH'] +=3D ':%s/monitor' % self.args.testhome
+		os.environ['PATH'] +=3D ':%s/wired' % self.args.testhome
+		os.environ['PATH'] +=3D ':' + path
+
+		sys.path.append(self.args.testhome + '/autotests/util')
+
+		if not os.path.exists('/tmp/iwd'):
+			os.mkdir('/tmp/iwd')
+
+		#
+		# This prevents any print() calls in this script from printing unless
+		# --debug is passed. For an 'always print' option use dbg()
+		#
+		if not self.args.dbg:
+			sys.stdout =3D open(os.devnull, 'w')
+
+		# Copy autotests/misc/{certs,secrets,phonesim} so any test can refer to =
them
+		if os.path.exists('/tmp/certs'):
+			rmtree('/tmp/certs')
+
+		if os.path.exists('/tmp/secrets'):
+			rmtree('/tmp/secrets')
+
+		copytree(self.args.testhome + '/autotests/misc/certs', '/tmp/certs')
+		copytree(self.args.testhome + '/autotests/misc/secrets', '/tmp/secrets')
+		copy(self.args.testhome + '/autotests/misc/phonesim/phonesim.conf', '/tm=
p')
+
+	def cleanup_environment(self):
+		rmtree('/tmp/iwd')
+		rmtree('/tmp/certs')
+		rmtree('/tmp/secrets')
+		os.remove('/tmp/phonesim.conf')
+
+		os.sync()
+
+	# For QEMU/UML runners
+	def _prepare_mounts(self):
+		for entry in mounts_common:
+			try:
+				os.lstat(entry.target)
+			except:
+				os.mkdir(entry.target, 755)
+
+			mount(entry.fstype, entry.target, entry.fstype, entry.flags,
+				entry.options)
+
+		for entry in dev_table:
+			os.symlink(entry.target, entry.linkpath)
+
+		os.setsid()
+
+	def stop(self):
+		exit()
+
+class QemuRunner(RunnerAbstract):
+	name =3D "Qemu Runner"
+
+	def __init__(self, args):
+		def mount_options(id):
+			return 'mount_tag=3D%s,security_model=3Dpassthrough,id=3D%s' % (id, id)
+
+		usb_adapters =3D None
+		pci_adapters =3D None
+		gid =3D None
+		append_gid_uid =3D False
+
+		super().__init__(args)
+
+		if len(sys.argv) <=3D 1:
+			return
+
+		if not which('qemu-system-x86_64'):
+			raise Exception('Cannot locate qemu binary')
+
+		if not args.kernel or not os.path.exists(args.kernel):
+			raise Exception('Cannot locate kernel image %s' % args.kernel)
+
+		if args.hw:
+			hw_conf =3D ConfigParser()
+			hw_conf.read(args.hw)
+
+			if hw_conf.has_section('USBAdapters'):
+				# The actual key name of the adapter
+				# doesn't matter since all we need is the
+				# bus/address. This gets named by the kernel
+				# anyways once in the VM.
+				usb_adapters =3D [v for v in hw_conf['USBAdapters'].values()]
+
+			if hw_conf.has_section('PCIAdapters'):
+				pci_adapters =3D [v for v in hw_conf['PCIAdapters'].values()]
+
+		if os.environ.get('SUDO_GID', None):
+			uid =3D int(os.environ['SUDO_UID'])
+			gid =3D int(os.environ['SUDO_GID'])
+
+		if args.log:
+			if os.getuid() !=3D 0:
+				print("--log can only be used as root user")
+				quit()
+
+			append_gid_uid =3D True
+
+			args.log =3D os.path.abspath(args.log)
+			if not os.path.exists(self.args.log):
+				os.mkdir(self.args.log)
+
+				if gid:
+					os.chown(self.args.log, uid, gid)
+
+		if args.monitor:
+			if os.getuid() !=3D 0:
+				print("--monitor can only be used as root user")
+				quit()
+
+			append_gid_uid =3D True
+
+			args.monitor =3D os.path.abspath(args.monitor)
+			monitor_parent_dir =3D os.path.abspath(os.path.join(self.args.monitor,
+										os.pardir))
+
+		if args.result:
+			if os.getuid() !=3D 0:
+				print("--result can only be used as root user")
+				quit()
+
+			append_gid_uid =3D True
+
+			args.result =3D os.path.abspath(args.result)
+			result_parent_dir =3D os.path.abspath(os.path.join(self.args.result,
+										os.pardir))
+
+		if append_gid_uid:
+			args.SUDO_UID =3D uid
+			args.SUDO_GID =3D gid
+
+		kern_log =3D "ignore_loglevel" if "kernel" in args.verbose else "quiet"
+
+		qemu_cmdline =3D [
+			'qemu-system-x86_64',
+			'-machine', 'type=3Dq35,accel=3Dkvm:tcg',
+			'-nodefaults', '-no-user-config', '-monitor', 'none',
+			'-display', 'none', '-m', '256M', '-nographic', '-vga',
+			'none', '-no-acpi', '-no-hpet',
+			'-no-reboot', '-fsdev',
+			'local,id=3Dfsdev-root,path=3D/,readonly=3Don,security_model=3Dnone,mul=
tidevs=3Dremap',
+			'-device',
+			'virtio-9p-pci,fsdev=3Dfsdev-root,mount_tag=3D/dev/root',
+			'-chardev', 'stdio,id=3Dchardev-serial0,signal=3Doff',
+			'-device', 'pci-serial,chardev=3Dchardev-serial0',
+			'-device', 'virtio-rng-pci',
+			'-kernel', args.kernel,
+			'-smp', '2',
+			'-append',
+			'console=3DttyS0,115200n8 earlyprintk=3Dserial \
+				rootfstype=3D9p root=3D/dev/root \
+				rootflags=3Dtrans=3Dvirtio \
+				acpi=3Doff pci=3Dnoacpi %s ro \
+				mac80211_hwsim.radios=3D0 init=3D%s %s' %
+						(kern_log, args.start, args.to_cmd()),
+		]
+
+		# Add two ethernet devices for testing EAD
+		qemu_cmdline.extend([
+				'-net', 'nic,model=3Dvirtio',
+				'-net', 'nic,model=3Dvirtio',
+				'-net', 'user'
+		])
+
+		if usb_adapters:
+			for bus, addr in [s.split(',') for s in usb_adapters]:
+				qemu_cmdline.extend(['-usb',
+							'-device',
+							'usb-host,hostbus=3D%s,hostaddr=3D%s' % \
+							(bus, addr)])
+		if pci_adapters:
+			qemu_cmdline.extend(['-enable-kvm'])
+			for addr in pci_adapters:
+				qemu_cmdline.extend(['-device', 'vfio-pci,host=3D%s' % addr])
+
+		if args.log:
+			#
+			# Creates a virtfs device that can be mounted. This mount
+			# will point back to the provided log directory and is
+			# writable unlike the rest of the mounted file system.
+			#
+			qemu_cmdline.extend([
+				'-virtfs',
+				'local,path=3D%s,%s' % (args.log, mount_options('logdir'))
+			])
+
+		if args.monitor:
+			qemu_cmdline.extend([
+				'-virtfs',
+				'local,path=3D%s,%s' % (monitor_parent_dir, mount_options('mondir'))
+			])
+
+		if args.result:
+			qemu_cmdline.extend([
+				'-virtfs',
+				'local,path=3D%s,%s' % (result_parent_dir, mount_options('resultdir'))
+			])
+
+		self.cmdline =3D qemu_cmdline
+
+	def prepare_environment(self):
+		mounts_common.extend([
+			MountInfo('debugfs', '/sys/kernel/debug', '', 0)
+		])
+
+		self._prepare_mounts()
+
+		super().prepare_environment()
+
+		fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
+
+		if self.args.log:
+			mount('logdir', self.args.log, '9p', 0,
+					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240')
+			# Clear out any log files from other test runs
+			for f in glob('%s/*' % self.args.log):
+				print("removing %s" % f)
+
+				if os.path.isdir(f):
+					rmtree(f)
+				else:
+					os.remove(f)
+		elif self.args.monitor:
+			parent =3D os.path.abspath(os.path.join(self.args.monitor, os.pardir))
+			mount('mondir', parent, '9p', 0,
+					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240')
+
+		if self.args.result:
+			parent =3D os.path.abspath(os.path.join(self.args.result, os.pardir))
+			mount('resultdir', parent, '9p', 0,
+					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240')
+
+	def stop(self):
+		RB_AUTOBOOT =3D 0x01234567
+		#
+		# Calling 'reboot' or 'shutdown' from a shell (e.g. os.system('reboot'))
+		# is not the same the POSIX reboot() and will cause a kernel panic since
+		# we are the init process. The libc.reboot() allows the VM to exit
+		# gracefully.
+		#
+		libc.reboot(RB_AUTOBOOT)
-- =

2.34.1

--===============4983819335840966970==--

