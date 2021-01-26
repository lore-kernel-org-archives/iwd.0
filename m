Content-Type: multipart/mixed; boundary="===============4018701879769186137=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] test-runner: don't always print "verbose on for ..."
Date: Tue, 26 Jan 2021 09:46:55 -0800
Message-ID: <20210126174657.867692-2-prestwoj@gmail.com>
In-Reply-To: <20210126174657.867692-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4018701879769186137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This shouldn't have been a dbg print, but rather a normal print
which will only be printed when '-d' is used.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index fba589e3..c0fc85ed 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -180,7 +180,7 @@ class Process:
 			set_stdout =3D False
 =

 			if ctx.is_verbose(args[0]):
-				dbg("Verbose on for %s" % args[0])
+				print("Verbose on for %s" % args[0])
 				set_stdout =3D True
 =

 			if os.path.basename(args[0]) =3D=3D ctx.args.gdb:
-- =

2.26.2

--===============4018701879769186137==--

