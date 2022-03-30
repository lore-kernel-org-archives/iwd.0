Content-Type: multipart/mixed; boundary="===============1180189965818733692=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/7] test-runner: add initial UmlRunner implementation
Date: Wed, 30 Mar 2022 15:20:54 -0700
Message-ID: <20220330222057.2160244-4-prestwoj@gmail.com>
In-Reply-To: 20220330222057.2160244-1-prestwoj@gmail.com

--===============1180189965818733692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows test-runner to run inside a UML binary which has some
advantages, specifically time-travel/infinite CPU speed. This should
fix any scheduler related failures we have on slower systems.

Currently this runner does not suppor the same features as the Qemu
runner, specifically:

 - No hardware passthrough
 - No logging/monitor (UML -> host mounting isn't implemented yet)
---
 tools/runner.py | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/runner.py b/tools/runner.py
index 743d74b1..33c10917 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -213,7 +213,9 @@ class Runner:
 			else:
 				args.runner =3D 'qemu'
 =

-		if args.runner =3D=3D 'qemu':
+		if args.runner =3D=3D 'uml':
+			return UmlRunner(args)
+		elif args.runner =3D=3D 'qemu':
 			return QemuRunner(args)
 		else:
 			raise Exception("Unknown runner %s" % args.runner)
@@ -483,3 +485,29 @@ class QemuRunner(RunnerAbstract):
 		# gracefully.
 		#
 		libc.reboot(RB_AUTOBOOT)
+
+class UmlRunner(RunnerAbstract):
+	name =3D "UML Runner"
+
+	def __init__(self, args):
+		super().__init__(args)
+
+		if len(sys.argv) <=3D 1:
+			return
+
+		if not which(args.kernel):
+			raise Exception('Cannot locate UML binary %s' % args.kernel)
+
+		kern_log =3D "ignore_loglevel" if "kernel" in args.verbose else "quiet"
+
+		cmd =3D [args.kernel, 'rootfstype=3Dhostfs', 'ro', 'mem=3D256M', 'mac802=
11_hwsim.radios=3D0',
+				'time-travel=3Dinf-cpu', 'eth0=3Dmcast', 'eth1=3Dmcast',
+				'%s '% kern_log, 'init=3D%s' % args.start]
+		cmd.extend(args.to_cmd().split(' '))
+
+		self.cmdline =3D cmd
+
+	def prepare_environment(self):
+		self._prepare_mounts()
+
+		super().prepare_environment()
-- =

2.34.1

--===============1180189965818733692==--

