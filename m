Content-Type: multipart/mixed; boundary="===============7957908526270591407=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] sae: fix missing reallocarray definition
Date: Wed, 26 Jan 2022 10:01:14 -0800
Message-ID: <20220126180114.3164052-1-prestwoj@gmail.com>

--===============7957908526270591407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Building on GCC 8 resulted in this compiler error. Newer versions seem
to find malloc.h without the include, but not on GCC 8.

src/sae.c:107:25: error: implicit declaration of function =E2=80=98realloca=
rray=E2=80=99; did you mean =E2=80=98realloc=E2=80=99? [-Werror=3Dimplicit-=
function-declaration]
   sm->rejected_groups =3D reallocarray(NULL, 2, sizeof(uint16_t));
---
 src/sae.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/sae.c b/src/sae.c
index dc07db4b..9515b455 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -24,6 +24,8 @@
 #include <config.h>
 #endif
 =

+#include <malloc.h>
+
 #include <ell/ell.h>
 =

 #include "src/missing.h"
-- =

2.31.1

--===============7957908526270591407==--

