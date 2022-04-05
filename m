Content-Type: multipart/mixed; boundary="===============5070922151942245060=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/2] test-runner: add logging, monitor, and results to UML
Date: Tue, 05 Apr 2022 15:40:30 -0700
Message-ID: <20220405224030.884883-2-prestwoj@gmail.com>
In-Reply-To: 20220405224030.884883-1-prestwoj@gmail.com

--===============5070922151942245060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commonizes some mounting code between QEMU and UML to allow exporting
of files to the host environment. UML does this with a hostfs mount while
QEMU still uses 9p.

The common code sanitizing the inputs has been put into _prepare_outfiles
and _prepare_mounts was modified to take an 'extra' arugment containing
additional mount points.

The results and monitor parent directories are now passed into the environm=
ent
via arguments, and these are hidden from the help text (in addition to test=
home)
---
 tools/runner.py | 147 +++++++++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 64 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index 8e1ac1d7..d303af7e 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -1,7 +1,6 @@
 #!/usr/bin/python3
 =

-from argparse import ArgumentParser
-from argparse import Namespace
+from argparse import ArgumentParser, Namespace, SUPPRESS
 from configparser import ConfigParser
 from collections import namedtuple
 from shutil import copy, copytree, which, rmtree
@@ -124,7 +123,9 @@ class RunnerCoreArgParse(ArgumentParser):
 		self.add_argument('--hw', '-w',
 				type=3Dstr,
 				help=3D'Use physical adapters for tests (passthrough)')
-		self.add_argument('--testhome')
+		self.add_argument('--testhome', help=3DSUPPRESS)
+		self.add_argument('--monitor_parent', help=3DSUPPRESS)
+		self.add_argument('--result_parent', help=3DSUPPRESS)
 =

 		# Prevent --autotest/--unittest from being used together
 		auto_unit_group =3D self.add_mutually_exclusive_group()
@@ -287,8 +288,8 @@ class RunnerAbstract:
 		os.sync()
 =

 	# For QEMU/UML runners
-	def _prepare_mounts(self):
-		for entry in mounts_common:
+	def _prepare_mounts(self, extra=3D[]):
+		for entry in mounts_common + extra:
 			try:
 				os.lstat(entry.target)
 			except:
@@ -302,6 +303,52 @@ class RunnerAbstract:
 =

 		os.setsid()
 =

+	# For QEMU/UML --log, --monitor, --result
+	def _prepare_outfiles(self):
+		gid =3D None
+		append_gid_uid =3D False
+
+		if os.environ.get('SUDO_GID', None):
+			uid =3D int(os.environ['SUDO_UID'])
+			gid =3D int(os.environ['SUDO_GID'])
+
+		if self.args.log:
+			if os.getuid() !=3D 0:
+				print("--log can only be used as root user")
+				quit()
+
+			append_gid_uid =3D True
+
+			if not os.path.exists(self.args.log):
+				os.mkdir(self.args.log)
+
+			if gid:
+				os.chown(self.args.log, uid, gid)
+
+		if self.args.monitor:
+			if os.getuid() !=3D 0:
+				print("--monitor can only be used as root user")
+				quit()
+
+			append_gid_uid =3D True
+
+			self.args.monitor_parent =3D os.path.abspath(
+						os.path.join(self.args.monitor, os.pardir))
+
+		if self.args.result:
+			if os.getuid() !=3D 0:
+				print("--result can only be used as root user")
+				quit()
+
+			append_gid_uid =3D True
+
+			self.args.result_parent =3D os.path.abspath(
+						os.path.join(self.args.result, os.pardir))
+
+		if append_gid_uid:
+			self.args.SUDO_UID =3D uid
+			self.args.SUDO_GID =3D gid
+
 	def stop(self):
 		exit()
 =

@@ -314,8 +361,6 @@ class QemuRunner(RunnerAbstract):
 =

 		usb_adapters =3D None
 		pci_adapters =3D None
-		gid =3D None
-		append_gid_uid =3D False
 =

 		super().__init__(args)
 =

@@ -328,6 +373,8 @@ class QemuRunner(RunnerAbstract):
 		if not args.kernel or not os.path.exists(args.kernel):
 			raise Exception('Cannot locate kernel image %s' % args.kernel)
 =

+		self._prepare_outfiles()
+
 		if args.hw:
 			hw_conf =3D ConfigParser()
 			hw_conf.read(args.hw)
@@ -342,50 +389,6 @@ class QemuRunner(RunnerAbstract):
 			if hw_conf.has_section('PCIAdapters'):
 				pci_adapters =3D [v for v in hw_conf['PCIAdapters'].values()]
 =

-		if os.environ.get('SUDO_GID', None):
-			uid =3D int(os.environ['SUDO_UID'])
-			gid =3D int(os.environ['SUDO_GID'])
-
-		if args.log:
-			if os.getuid() !=3D 0:
-				print("--log can only be used as root user")
-				quit()
-
-			append_gid_uid =3D True
-
-			args.log =3D os.path.abspath(args.log)
-			if not os.path.exists(self.args.log):
-				os.mkdir(self.args.log)
-
-				if gid:
-					os.chown(self.args.log, uid, gid)
-
-		if args.monitor:
-			if os.getuid() !=3D 0:
-				print("--monitor can only be used as root user")
-				quit()
-
-			append_gid_uid =3D True
-
-			args.monitor =3D os.path.abspath(args.monitor)
-			monitor_parent_dir =3D os.path.abspath(os.path.join(self.args.monitor,
-										os.pardir))
-
-		if args.result:
-			if os.getuid() !=3D 0:
-				print("--result can only be used as root user")
-				quit()
-
-			append_gid_uid =3D True
-
-			args.result =3D os.path.abspath(args.result)
-			result_parent_dir =3D os.path.abspath(os.path.join(self.args.result,
-										os.pardir))
-
-		if append_gid_uid:
-			args.SUDO_UID =3D uid
-			args.SUDO_GID =3D gid
-
 		kern_log =3D "ignore_loglevel" if "kernel" in args.verbose else "quiet"
 =

 		qemu_cmdline =3D [
@@ -438,29 +441,31 @@ class QemuRunner(RunnerAbstract):
 			#
 			qemu_cmdline.extend([
 				'-virtfs',
-				'local,path=3D%s,%s' % (args.log, mount_options('logdir'))
+				'local,path=3D%s,%s' % (args.log,
+							mount_options('logdir'))
 			])
 =

 		if args.monitor:
 			qemu_cmdline.extend([
 				'-virtfs',
-				'local,path=3D%s,%s' % (monitor_parent_dir, mount_options('mondir'))
+				'local,path=3D%s,%s' % (self.args.monitor_parent,
+							mount_options('mondir'))
 			])
 =

 		if args.result:
 			qemu_cmdline.extend([
 				'-virtfs',
-				'local,path=3D%s,%s' % (result_parent_dir, mount_options('resultdir'))
+				'local,path=3D%s,%s' % (self.args.result_parent,
+							mount_options('resultdir'))
 			])
 =

+
 		self.cmdline =3D qemu_cmdline
 =

 	def prepare_environment(self):
-		mounts_common.extend([
-			MountInfo('debugfs', '/sys/kernel/debug', '', 0)
-		])
+		mounts =3D [ MountInfo('debugfs', '/sys/kernel/debug', '', 0) ]
 =

-		self._prepare_mounts()
+		self._prepare_mounts(extra=3Dmounts)
 =

 		super().prepare_environment()
 =

@@ -477,14 +482,12 @@ class QemuRunner(RunnerAbstract):
 					rmtree(f)
 				else:
 					os.remove(f)
-		elif self.args.monitor:
-			parent =3D os.path.abspath(os.path.join(self.args.monitor, os.pardir))
-			mount('mondir', parent, '9p', 0,
+		if self.args.monitor:
+			mount('mondir', self.args.monitor_parent, '9p', 0,
 					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240')
 =

 		if self.args.result:
-			parent =3D os.path.abspath(os.path.join(self.args.result, os.pardir))
-			mount('resultdir', parent, '9p', 0,
+			mount('resultdir', self.args.result_parent, '9p', 0,
 					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240')
 =

 	def stop(self):
@@ -507,6 +510,8 @@ class UmlRunner(RunnerAbstract):
 		if not which(args.kernel):
 			raise Exception('Cannot locate UML binary %s' % args.kernel)
 =

+		self._prepare_outfiles()
+
 		kern_log =3D "ignore_loglevel" if "kernel" in args.verbose else "quiet"
 =

 		cmd =3D [args.kernel, 'rootfstype=3Dhostfs', 'ro', 'mem=3D256M', 'mac802=
11_hwsim.radios=3D0',
@@ -517,7 +522,21 @@ class UmlRunner(RunnerAbstract):
 		self.cmdline =3D cmd
 =

 	def prepare_environment(self):
-		self._prepare_mounts()
+		mounts =3D []
+
+		if self.args.log:
+			mounts.append(MountInfo('hostfs', self.args.log,
+							self.args.log, 0))
+
+		if self.args.monitor:
+			mounts.append(MountInfo('hostfs', self.args.monitor_parent,
+							self.args.monitor_parent, 0))
+
+		if self.args.result:
+			mounts.append(MountInfo('hostfs', self.args.result_parent,
+							self.args.result_parent, 0))
+
+		self._prepare_mounts(extra=3Dmounts)
 =

 		super().prepare_environment()
 =

-- =

2.34.1

--===============5070922151942245060==--

