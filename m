Content-Type: multipart/mixed; boundary="===============3571585858535960158=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/18] test-runner: start IWD in developer mode
Date: Thu, 12 Aug 2021 13:21:51 -0700
Message-ID: <20210812202207.737053-2-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3571585858535960158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is being done to utilize the Roam() developer method
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 75e46444..7e789dd7 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -648,7 +648,7 @@ class Namespace:
 			args.extend(['valgrind', '--leak-check=3Dfull', '--track-origins=3Dyes',
 					'--log-file=3D/tmp/valgrind.log.%p'])
 =

-		args.extend(['iwd', '-p', iwd_radios])
+		args.extend(['iwd', '-p', iwd_radios, '-E'])
 =

 		if self.is_verbose(args[0]):
 			args.append('-d')
-- =

2.31.1

--===============3571585858535960158==--

