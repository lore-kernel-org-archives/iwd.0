Content-Type: multipart/mixed; boundary="===============0559869373548226916=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/9] test-runner: increase RAM to 384MB
Date: Thu, 29 Jul 2021 15:21:50 -0700
Message-ID: <20210729222154.159542-5-prestwoj@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0559869373548226916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Occationally python will fatally terminate trying to load a test
using importlib with an out of memory exception. Increasing RAM
allows reliable exection of all tests.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 2d4b6b5a..ff7d9586 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1585,7 +1585,7 @@ class Main:
 		if self.args.valgrind:
 			ram =3D 512
 		else:
-			ram =3D 256
+			ram =3D 384
 =

 		print("Using %d cores, %d RAM for VM" % (smp, ram))
 =

-- =

2.31.1

--===============0559869373548226916==--

