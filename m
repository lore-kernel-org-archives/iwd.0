Content-Type: multipart/mixed; boundary="===============5911229052845339569=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] sae: define _GNU_SOURCE for reallocarray definition
Date: Thu, 24 Feb 2022 10:00:37 -0800
Message-ID: <20220224180037.2797609-1-prestwoj@gmail.com>

--===============5911229052845339569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sae.c was failing to build on some platforms:

error: implicit declaration of function 'reallocarray'; did you mean 'reall=
oc'?
	[-Werror=3Dimplicit-function-declaration]
---
 src/sae.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/sae.c b/src/sae.c
index a4150628..859ec94b 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 =

+#define _GNU_SOURCE
 #include <stdlib.h>
 =

 #include <ell/ell.h>
-- =

2.34.1

--===============5911229052845339569==--

