Content-Type: multipart/mixed; boundary="===============3111300343830873623=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] test-runner: Drop unused parameter
Date: Sat, 07 Aug 2021 03:51:01 +0200
Message-ID: <20210807015101.311834-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3111300343830873623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 75e46444..f5ab7c58 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -164,7 +164,7 @@ class Process:
 		case.
 	'''
 	def __init__(self, args, wait=3DFalse, env=3DNone, ctx=3DNone, check=3DFa=
lse,
-				outfile=3DNone, namespace=3DNone, need_out=3DFalse, cleanup=3DNone):
+				outfile=3DNone, namespace=3DNone, cleanup=3DNone):
 		self.killed =3D False
 		self.args =3D args
 		self.wait =3D wait
-- =

2.30.2

--===============3111300343830873623==--

