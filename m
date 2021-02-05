Content-Type: multipart/mixed; boundary="===============2614015302486376957=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] test-runner: print error if kernel/qemu path is not found
Date: Fri, 05 Feb 2021 15:53:08 -0800
Message-ID: <20210205235308.345635-3-prestwoj@gmail.com>
In-Reply-To: <20210205235308.345635-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2614015302486376957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 8b6a57a6..0321128c 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1264,11 +1264,13 @@ class Main:
 		self.parser.add_argument('--qemu', '-q',
 				metavar=3D'<QEMU binary>', type=3Dstr,
 				help=3D'QEMU binary to use',
-				dest=3D'qemu')
+				dest=3D'qemu',
+				default=3DNone)
 		self.parser.add_argument('--kernel', '-k', metavar=3D'<kernel>',
 				type=3Dstr,
 				help=3D'Path to kernel image',
-				dest=3D'kernel')
+				dest=3D'kernel',
+				default=3DNone)
 		self.parser.add_argument('--verbose', '-v', metavar=3D'<list>',
 				type=3Dstr,
 				help=3D'Comma separated list of applications',
@@ -1350,6 +1352,9 @@ class Main:
 =

 		if self.args.qemu is None:
 			qemu_binary =3D find_binary(qemu_table)
+			if not qemu_binary:
+				print("Could not find qemu binary")
+				quit()
 		else:
 			if path_exists(self.args.qemu):
 				qemu_binary =3D self.args.qemu
@@ -1360,6 +1365,9 @@ class Main:
 =

 		if self.args.kernel is None:
 			kernel_binary =3D find_binary(kernel_table)
+			if not kernel_binary:
+				print("Could not find kernel image")
+				quit()
 		else:
 			if path_exists(self.args.kernel):
 				kernel_binary =3D self.args.kernel
-- =

2.26.2

--===============2614015302486376957==--

