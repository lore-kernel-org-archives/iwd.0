Content-Type: multipart/mixed; boundary="===============0072494379946770996=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] test-runner: enable valgrind track origins
Date: Wed, 21 Oct 2020 14:36:51 -0700
Message-ID: <20201021213652.1791048-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0072494379946770996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This gives a more exact location to where a memory problem
is happening. It also uses more RAM so the VM was upgraded to
256MB from 192MB.
---
 tools/test-runner | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 8c06816c..10db4c78 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -557,8 +557,8 @@ class TestContext:
 		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
 =

 		if self.args.valgrind:
-			args.extend(['valgrind', '--leak-check=3Dfull', '--log-file=3D%s' % \
-					'/tmp/valgrind.log'])
+			args.extend(['valgrind', '--leak-check=3Dfull', '--track-origins=3Dyes',
+						'--log-file=3D/tmp/valgrind.log'])
 =

 		args.extend(['iwd', '-p', iwd_radios])
 =

@@ -1265,7 +1265,7 @@ class Main:
 			qemu_binary,
 			'-machine', 'type=3Dq35,accel=3Dkvm:tcg',
 			'-nodefaults', '-no-user-config', '-monitor', 'none',
-			'-display', 'none', '-m', '192M', '-nographic', '-vga',
+			'-display', 'none', '-m', '256M', '-nographic', '-vga',
 			'none', '-no-acpi', '-no-hpet',
 			'-no-reboot', '-fsdev',
 			'local,id=3Dfsdev-root,path=3D/,readonly,security_model=3Dnone,multidev=
s=3Dremap',
-- =

2.26.2

--===============0072494379946770996==--

