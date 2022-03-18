Content-Type: multipart/mixed; boundary="===============6959969204449005789=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] test-runner: increase RAM size
Date: Fri, 18 Mar 2022 15:36:46 -0700
Message-ID: <20220318223646.756590-1-prestwoj@gmail.com>

--===============6959969204449005789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is explained in the comment, but until the issue can be
tracked down increase RAM.
---
 tools/test-runner | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index b0ec87a2..534f08f2 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1816,12 +1816,15 @@ class Main:
 			smp =3D int(nproc / 2)
 =

 		#
-		# Increase RAM if valgrind is being used
+		# TODO: Its unclear exactly what causes it (leak, fragmentation,
+		# or ?), but after many test runs the kernel starts running out
+		# of memory. This is sometimes non-fatal, e.g. a python call
+		# fails, but other times the kernel fully panics.
 		#
-		if self.args.valgrind:
-			ram =3D 512
-		else:
-			ram =3D 384
+		# For now increase the RAM which allows full test runs to
+		# complete.
+		#
+		ram =3D 1024
 =

 		print("Using %d cores, %d RAM for VM" % (smp, ram))
 =

-- =

2.34.1

--===============6959969204449005789==--

