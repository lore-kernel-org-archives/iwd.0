Content-Type: multipart/mixed; boundary="===============8139649178842305102=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 08/10] test-runner: fix ctrl-c for UML
Date: Wed, 06 Apr 2022 12:14:51 -0700
Message-ID: <20220406191453.978426-8-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============8139649178842305102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The TIOCSTTY ioctl was not shared between UML and QEMU which prevented
any console input from making it into UML. This fixes that, and now
ctrl-c can be used to stop UML test execution.
---
 tools/runner.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index 1c1f6eed..1f087d6c 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -289,6 +289,8 @@ class RunnerAbstract:
 				else:
 					os.remove(f)
 =

+		fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
+
 	def cleanup_environment(self):
 		rmtree('/tmp/iwd')
 		rmtree('/tmp/certs')
@@ -491,8 +493,6 @@ class QemuRunner(RunnerAbstract):
 =

 		super().prepare_environment()
 =

-		fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
-
 	def stop(self):
 		RB_AUTOBOOT =3D 0x01234567
 		#
-- =

2.34.1

--===============8139649178842305102==--

