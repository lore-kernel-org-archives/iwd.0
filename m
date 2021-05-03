Content-Type: multipart/mixed; boundary="===============4150966711515860791=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: increase RAM for valgrind
Date: Mon, 03 May 2021 14:30:41 -0700
Message-ID: <20210503213041.361836-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4150966711515860791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Certain tests like testAP spawn two IWD process in separate
namespaces. When --valrind is used this eats up quite a bit
of RAM and causes the VM to run out of memory and start
killing off processes.
---
 tools/test-runner | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index b890b3e7..dd4cbf82 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1570,7 +1570,15 @@ class Main:
 		else:
 			smp =3D int(nproc / 2)
 =

-		print("Using %d cores for VM" % smp)
+		#
+		# Increase RAM if valgrind is being used
+		#
+		if self.args.valgrind:
+			ram =3D 512
+		else:
+			ram =3D 256
+
+		print("Using %d cores, %d RAM for VM" % (smp, ram))
 =

 		#
 		# This passes through most of the command line options to
@@ -1593,7 +1601,7 @@ class Main:
 			qemu_binary,
 			'-machine', 'type=3Dq35,accel=3Dkvm:tcg',
 			'-nodefaults', '-no-user-config', '-monitor', 'none',
-			'-display', 'none', '-m', '256M', '-nographic', '-vga',
+			'-display', 'none', '-m', '%dM' % ram, '-nographic', '-vga',
 			'none', '-no-acpi', '-no-hpet',
 			'-no-reboot', '-fsdev',
 			'local,id=3Dfsdev-root,path=3D/,readonly,security_model=3Dnone,multidev=
s=3Dremap',
-- =

2.26.2

--===============4150966711515860791==--

