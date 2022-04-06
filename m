Content-Type: multipart/mixed; boundary="===============1631504957540700066=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 03/10] test-runner: simplify start_iwd handling
Date: Wed, 06 Apr 2022 12:14:46 -0700
Message-ID: <20220406191453.978426-3-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============1631504957540700066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace two separate if blocks to handle the default value
with fallback=3DTrue.
---
 tools/run-tests | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index a95a7494..5f405e67 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -886,15 +886,8 @@ def pre_test(ctx, test, copied):
 	ctx.start_wpas_interfaces()
 	ctx.start_ofono()
 =

-	if ctx.hw_config.has_option('SETUP', 'start_iwd'):
-		start =3D ctx.hw_config.getboolean('SETUP', 'start_iwd')
-	else:
-		start =3D True
-
-	if start:
+	if ctx.hw_config.getboolean('SETUP', 'start_iwd', fallback=3DTrue):
 		ctx.start_iwd()
-	else:
-		print("Not starting IWD from test-runner")
 =

 	print(ctx)
 =

-- =

2.34.1

--===============1631504957540700066==--

