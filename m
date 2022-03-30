Content-Type: multipart/mixed; boundary="===============6881944769571440840=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] test-runner: Fix checks in exit_vm
Date: Wed, 30 Mar 2022 19:33:58 +0200
Message-ID: <20220330173400.259961-2-andrew.zaborowski@intel.com>
In-Reply-To: 20220330173400.259961-1-andrew.zaborowski@intel.com

--===============6881944769571440840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We check that config is not None but then access config.ctx outside of
that if block anyway.  Then we do the same for config.ctx and
config.ctx.args.  Nest the if blocks for the checks to be useful.
---
 tools/test-runner | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 9bc66419..4ab42317 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -61,15 +61,15 @@ def exit_vm():
 			print("Process %s still running!" % p.args[0])
 			p.kill()
 =

-	if config.ctx and config.ctx.results:
-		success =3D print_results(config.ctx.results)
-	else:
-		success =3D False
+		if config.ctx and config.ctx.results:
+			success =3D print_results(config.ctx.results)
+		else:
+			success =3D False
 =

-	if config.ctx.args.result:
-		result =3D 'PASS' if success else 'FAIL'
-		with open(config.ctx.args.result, 'w') as f:
-			f.write(result)
+		if config.ctx and config.ctx.args.result:
+			result =3D 'PASS' if success else 'FAIL'
+			with open(config.ctx.args.result, 'w') as f:
+				f.write(result)
 =

 	os.sync()
 =

-- =

2.32.0

--===============6881944769571440840==--

