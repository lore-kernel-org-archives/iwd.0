Content-Type: multipart/mixed; boundary="===============0553783203133065247=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] test-runner: set msize for --monitor
Date: Thu, 29 Jul 2021 15:21:49 -0700
Message-ID: <20210729222154.159542-4-prestwoj@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0553783203133065247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was added for logging but --monitor suffers the same warning
without setting msize as well.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index fa3c434f..2d4b6b5a 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1379,7 +1379,7 @@ def run_tests():
 				os.remove(f)
 	elif args.monitor:
 		parent =3D os.path.abspath(os.path.join(args.monitor, os.pardir))
-		mount('mondir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L')
+		mount('mondir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,msiz=
e=3D10240')
 =

 	if config.ctx.args.unit_tests is None:
 		run_auto_tests(config.ctx, args)
-- =

2.31.1

--===============0553783203133065247==--

