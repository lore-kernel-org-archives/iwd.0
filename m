Content-Type: multipart/mixed; boundary="===============5173044104991252350=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 11/11] test-runner: start iwmon first
Date: Fri, 25 Feb 2022 09:58:10 -0800
Message-ID: <20220225175810.2914413-11-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============5173044104991252350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This aids in debugging if iwd/hostapd/etc fail to start correctly.
---
 tools/test-runner | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 64407a41..0b749238 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1327,6 +1327,11 @@ def pre_test(ctx, test, copied):
 =

 		subtests =3D pruned
 =

+	if ctx.args.log:
+		ctx.start_process(['iwmon', '--nowiphy'])
+	elif ctx.args.monitor:
+		ctx.start_process(['iwmon'], outfile=3Dctx.args.monitor)
+
 	ctx.start_dbus()
 	ctx.start_haveged()
 	ctx.start_dbus_monitor()
@@ -1336,11 +1341,6 @@ def pre_test(ctx, test, copied):
 	ctx.start_wpas_interfaces()
 	ctx.start_ofono()
 =

-	if ctx.args.log:
-		ctx.start_process(['iwmon', '--nowiphy'])
-	elif ctx.args.monitor:
-		ctx.start_process(['iwmon', '--nowiphy'], outfile=3Dctx.args.monitor)
-
 	if ctx.hw_config.has_option('SETUP', 'start_iwd'):
 		start =3D ctx.hw_config.getboolean('SETUP', 'start_iwd')
 	else:
-- =

2.34.1

--===============5173044104991252350==--

