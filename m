Content-Type: multipart/mixed; boundary="===============8818972991189504821=="
MIME-Version: 1.0
From: Peter Seiderer <ps.report at gmx.net>
To: iwd at lists.01.org
Subject: [PATCH v1] dpp: fix implicit declaration of function explicit_bzero
 warning
Date: Mon, 10 Jan 2022 22:32:18 +0100
Message-ID: <20220110213218.12896-1-ps.report@gmx.net>

--===============8818972991189504821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

- add missing src/missing.h include for explicit_bzero, fixes uclibc
  compile/linking

Fixes:

  src/dpp.c:166:2: warning: implicit declaration of function =E2=80=98expli=
cit_bzero=E2=80=99 [-Wimplicit-function-declaration]
    166 |  explicit_bzero(dpp->r_nonce, dpp->nonce_len);
        |  ^~~~~~~~~~~~~~
---
 src/dpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dpp.c b/src/dpp.c
index 84e89f6c..8091ded1 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -30,6 +30,7 @@
 =

 #include "linux/nl80211.h"
 =

+#include "src/missing.h"
 #include "src/dbus.h"
 #include "src/netdev.h"
 #include "src/module.h"
-- =

2.34.1


--===============8818972991189504821==--

