Content-Type: multipart/mixed; boundary="===============3621759536545886120=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/5] test-runner: resolve absolute path for --start argument
Date: Tue, 05 Apr 2022 11:30:09 -0700
Message-ID: <20220405183011.856403-3-prestwoj@gmail.com>
In-Reply-To: 20220405183011.856403-1-prestwoj@gmail.com

--===============3621759536545886120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/runner.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/runner.py b/tools/runner.py
index f244016f..fc1cab44 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -211,6 +211,8 @@ class Runner:
 				args.start =3D os.path.abspath('tools/run-tests')
 			else:
 				raise Exception("Cannot locate run-tests binary")
+		else:
+			args.start =3D os.path.abspath(args.start)
 =

 		# If no runner is specified but we have a kernel image assume
 		# if the kernel is executable its UML, otherwise qemu
-- =

2.34.1

--===============3621759536545886120==--

