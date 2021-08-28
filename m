Content-Type: multipart/mixed; boundary="===============1234513883044256818=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] test-runner: Fix verbose check for processes in namespaces
Date: Sat, 28 Aug 2021 05:10:54 +0200
Message-ID: <20210828031054.28451-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1234513883044256818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check whether verbose output is enabled for process name arg[0] before
prepending the "ip netns exec" part to arg since arg[0] is going to be
"ip" after that.
---
 tools/test-runner | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 8b244e99..42f140bf 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -176,12 +176,12 @@ class Process(subprocess.Popen):
 			global config
 			self.ctx =3D config.ctx
 =

-		if namespace:
-			args =3D ['ip', 'netns', 'exec', namespace] + args
-
 		if self.ctx.is_verbose(args[0], log=3DFalse):
 			self.verbose =3D True
 =

+		if namespace:
+			args =3D ['ip', 'netns', 'exec', namespace] + args
+
 		if outfile:
 			self._append_outfile(outfile)
 =

-- =

2.30.2

--===============1234513883044256818==--

