Content-Type: multipart/mixed; boundary="===============0629065051294970456=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 07/10] test-runner: Unify QEMU/UML logging code
Date: Wed, 06 Apr 2022 12:14:50 -0700
Message-ID: <20220406191453.978426-7-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============0629065051294970456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MountInfo tuple was changed to explicitly take a source string. This
is redundant for UML and system mounts since the fstype/source are the same,
but it allows QEMU to specify the '9p' fstype and use MountInfo rather than
calling mount() explicitly.

This also moves logging cleanup into _prepare_mounts so both UML and QEMU
can use it.
---
 tools/runner.py | 73 +++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index d303af7e..1c1f6eed 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -24,19 +24,19 @@ MS_STRICTATIME =3D 1 << 24
 STDIN_FILENO =3D 0
 TIOCSTTY =3D 0x540E
 =

-MountInfo =3D namedtuple('MountInfo', 'fstype target options flags')
+MountInfo =3D namedtuple('MountInfo', 'fstype source target options flags')
 DevInfo =3D namedtuple('DevInfo', 'target linkpath')
 =

 mounts_common =3D [
-	MountInfo('sysfs', '/sys', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
-	MountInfo('proc', '/proc', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
-	MountInfo('devpts', '/dev/pts', 'mode=3D0620', MS_NOSUID|MS_NOEXEC),
-	MountInfo('tmpfs', '/dev/shm', 'mode=3D1777',
+	MountInfo('sysfs', 'sysfs', '/sys', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
+	MountInfo('proc', 'proc', '/proc', '', MS_NOSUID|MS_NOEXEC|MS_NODEV),
+	MountInfo('devpts', 'devpts', '/dev/pts', 'mode=3D0620', MS_NOSUID|MS_NOE=
XEC),
+	MountInfo('tmpfs', 'tmpfs', '/dev/shm', 'mode=3D1777',
 					MS_NOSUID|MS_NODEV|MS_STRICTATIME),
-	MountInfo('tmpfs', '/run', 'mode=3D0755',
+	MountInfo('tmpfs', 'tmpfs', '/run', 'mode=3D0755',
 					MS_NOSUID|MS_NODEV|MS_STRICTATIME),
-	MountInfo('tmpfs', '/tmp', '', 0),
-	MountInfo('tmpfs', '/usr/share/dbus-1', 'mode=3D0755',
+	MountInfo('tmpfs', 'tmpfs', '/tmp', '', 0),
+	MountInfo('tmpfs', 'tmpfs', '/usr/share/dbus-1', 'mode=3D0755',
 					MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_STRICTATIME),
 ]
 =

@@ -279,6 +279,16 @@ class RunnerAbstract:
 		copytree(self.args.testhome + '/autotests/misc/secrets', '/tmp/secrets')
 		copy(self.args.testhome + '/autotests/misc/phonesim/phonesim.conf', '/tm=
p')
 =

+		# Clear out any log files from other test runs
+		if self.args.log:
+			for f in [os.path.join(self.args.log, file) for file in os.listdir(self=
.args.log)]:
+				print("removing %s" % f)
+
+				if os.path.isdir(f):
+					rmtree(f)
+				else:
+					os.remove(f)
+
 	def cleanup_environment(self):
 		rmtree('/tmp/iwd')
 		rmtree('/tmp/certs')
@@ -295,7 +305,7 @@ class RunnerAbstract:
 			except:
 				os.mkdir(entry.target, 755)
 =

-			mount(entry.fstype, entry.target, entry.fstype, entry.flags,
+			mount(entry.source, entry.target, entry.fstype, entry.flags,
 				entry.options)
 =

 		for entry in dev_table:
@@ -463,32 +473,25 @@ class QemuRunner(RunnerAbstract):
 		self.cmdline =3D qemu_cmdline
 =

 	def prepare_environment(self):
-		mounts =3D [ MountInfo('debugfs', '/sys/kernel/debug', '', 0) ]
-
-		self._prepare_mounts(extra=3Dmounts)
-
-		super().prepare_environment()
-
-		fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
+		mounts =3D [ MountInfo('debugfs', 'debugfs', '/sys/kernel/debug', '', 0)=
 ]
 =

 		if self.args.log:
-			mount('logdir', self.args.log, '9p', 0,
-					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240')
-			# Clear out any log files from other test runs
-			for f in glob('%s/*' % self.args.log):
-				print("removing %s" % f)
+			mounts.append(MountInfo('9p', 'logdir', self.args.log,
+					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240', 0))
 =

-				if os.path.isdir(f):
-					rmtree(f)
-				else:
-					os.remove(f)
 		if self.args.monitor:
-			mount('mondir', self.args.monitor_parent, '9p', 0,
-					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240')
+			mounts.append(MountInfo('9p', 'mondir', self.args.monitor_parent,
+					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240', 0))
 =

 		if self.args.result:
-			mount('resultdir', self.args.result_parent, '9p', 0,
-					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240')
+			mounts.append(MountInfo('9p', 'resultdir', self.args.result_parent,
+					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240', 0))
+
+		self._prepare_mounts(extra=3Dmounts)
+
+		super().prepare_environment()
+
+		fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
 =

 	def stop(self):
 		RB_AUTOBOOT =3D 0x01234567
@@ -525,16 +528,16 @@ class UmlRunner(RunnerAbstract):
 		mounts =3D []
 =

 		if self.args.log:
-			mounts.append(MountInfo('hostfs', self.args.log,
-							self.args.log, 0))
+			mounts.append(MountInfo('hostfs', 'hostfs', self.args.log,
+						self.args.log, 0))
 =

 		if self.args.monitor:
-			mounts.append(MountInfo('hostfs', self.args.monitor_parent,
-							self.args.monitor_parent, 0))
+			mounts.append(MountInfo('hostfs', 'hostfs', self.args.monitor_parent,
+						self.args.monitor_parent, 0))
 =

 		if self.args.result:
-			mounts.append(MountInfo('hostfs', self.args.result_parent,
-							self.args.result_parent, 0))
+			mounts.append(MountInfo('hostfs', 'hostfs', self.args.result_parent,
+						self.args.result_parent, 0))
 =

 		self._prepare_mounts(extra=3Dmounts)
 =

-- =

2.34.1

--===============0629065051294970456==--

