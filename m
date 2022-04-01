Content-Type: multipart/mixed; boundary="===============8784380160572964859=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] test-runner: fix kernel panic on exit for UML
Date: Fri, 01 Apr 2022 15:16:38 -0700
Message-ID: <20220401221639.704786-1-prestwoj@gmail.com>

--===============8784380160572964859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

UML requires RB_POWER_OFF rather than RB_AUTOBOOT (Qemu) in order
to avoid a kernel panic from killing init.
---
 tools/runner.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index 33c10917..5b6b0820 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -479,10 +479,8 @@ class QemuRunner(RunnerAbstract):
 	def stop(self):
 		RB_AUTOBOOT =3D 0x01234567
 		#
-		# Calling 'reboot' or 'shutdown' from a shell (e.g. os.system('reboot'))
-		# is not the same the POSIX reboot() and will cause a kernel panic since
-		# we are the init process. The libc.reboot() allows the VM to exit
-		# gracefully.
+		# Killing init() results in a kernel panic. For QEMU a graceful
+		# exit is achieved with RB_AUTOBOOT
 		#
 		libc.reboot(RB_AUTOBOOT)
 =

@@ -511,3 +509,11 @@ class UmlRunner(RunnerAbstract):
 		self._prepare_mounts()
 =

 		super().prepare_environment()
+
+	def stop(self):
+		RB_POWER_OFF =3D 0x4321fedc
+		#
+		# Killing init() results in a kernel panic. For UML a graceful
+		# exit is achieved with RB_POWER_OFF
+		#
+		libc.reboot(RB_POWER_OFF)
-- =

2.34.1

--===============8784380160572964859==--

