Content-Type: multipart/mixed; boundary="===============6829392695485842708=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] test-runner: resolve --kernel absolute path
Date: Wed, 06 Apr 2022 15:08:56 -0700
Message-ID: <20220406220856.996243-2-prestwoj@gmail.com>
In-Reply-To: 20220406220856.996243-1-prestwoj@gmail.com

--===============6829392695485842708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This only posed a problem oddly if the kernel binary was in the same
directory as test-runner. Resolving the absolute path with the
argument parser resolves the issue.
---
 tools/runner.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/runner.py b/tools/runner.py
index 1f087d6c..1cb01d29 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -183,7 +183,7 @@ class RunnerArgParse(RunnerCoreArgParse):
 				default=3DNone)
 		self.add_argument('--kernel', '-k',
 				metavar=3D'<kernel>',
-				type=3Dstr,
+				type=3Dos.path.abspath,
 				help=3D'Path to kernel/uml image',
 				dest=3D'kernel',
 				default=3DNone)
-- =

2.34.1

--===============6829392695485842708==--

