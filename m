Content-Type: multipart/mixed; boundary="===============2396506769933477123=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] test-runner: fix testhome mounting for QEMU
Date: Fri, 03 Jun 2022 15:02:45 -0700
Message-ID: <20220603220245.227338-1-prestwoj@gmail.com>

--===============2396506769933477123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was lazily copied from UML but really made no sense in the context
of QEMU. First QEMU needs the virtfs option to define the mount tag and
in addition a 9p mount should be used rather than 'hostfs'.
---
 tools/runner.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index bf28d9ad..ccc931ff 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -434,6 +434,11 @@ class QemuRunner(RunnerAbstract):
 			for addr in pci_adapters:
 				qemu_cmdline.extend(['-device', 'vfio-pci,host=3D%s' % addr])
 =

+		qemu_cmdline.extend([
+			'-virtfs',
+			'local,path=3D%s,%s' % (args.testhome, mount_options('homedir'))
+		])
+
 		if args.log:
 			#
 			# Creates a virtfs device that can be mounted. This mount
@@ -466,8 +471,8 @@ class QemuRunner(RunnerAbstract):
 	def prepare_environment(self):
 		mounts =3D [ MountInfo('debugfs', 'debugfs', '/sys/kernel/debug', '', 0)=
 ]
 =

-		mounts.append(MountInfo('hostfs', 'hostfs', self.args.testhome,
-					self.args.testhome, 0))
+		mounts.append(MountInfo('9p', 'homedir', self.args.testhome,
+					'trans=3Dvirtio,version=3D9p2000.L,msize=3D10240', 0))
 =

 		if self.args.log:
 			mounts.append(MountInfo('9p', 'logdir', self.args.log,
-- =

2.34.1

--===============2396506769933477123==--

