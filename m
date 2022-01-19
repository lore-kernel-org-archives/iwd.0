Content-Type: multipart/mixed; boundary="===============6068445098932143356=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] test-runner: set --show-leak-kinds=all
Date: Wed, 19 Jan 2022 15:04:52 -0800
Message-ID: <20220119230452.2306995-2-prestwoj@gmail.com>
In-Reply-To: 20220119230452.2306995-1-prestwoj@gmail.com

--===============6068445098932143356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This enables leak checks starting in main() which were previously
ignored.
---
 tools/test-runner | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/test-runner b/tools/test-runner
index c35466c1..7176deaf 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -673,6 +673,7 @@ class Namespace:
 =

 		if self.args.valgrind:
 			args.extend(['valgrind', '--leak-check=3Dfull', '--track-origins=3Dyes',
+					'--show-leak-kinds=3Dall',
 					'--log-file=3D/tmp/valgrind.log.%p'])
 =

 		args.extend(['iwd', '-p', iwd_radios, '-E'])
-- =

2.31.1

--===============6068445098932143356==--

