Content-Type: multipart/mixed; boundary="===============3490273277267185223=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 2/2] test-runner: Add missing 's' option to command line parser
Date: Sat, 07 Mar 2020 19:01:13 +0100
Message-ID: <20200307180113.30779-2-wagi@monom.org>
In-Reply-To: <20200307180113.30779-1-wagi@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3490273277267185223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index c4623d790446..804a1038be89 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -3104,7 +3104,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 =

-		opt =3D getopt_long(argc, argv, "A:q:k:v:g:l:UVdh", main_options,
+		opt =3D getopt_long(argc, argv, "A:q:k:v:g:sl:UVdh", main_options,
 									NULL);
 		if (opt < 0)
 			break;
-- =

2.25.1
--===============3490273277267185223==--

