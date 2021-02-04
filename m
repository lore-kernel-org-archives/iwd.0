Content-Type: multipart/mixed; boundary="===============3392865164284710197=="
MIME-Version: 1.0
From: Mauro Condarelli <mc5686@mclink.it>
Subject: [PATCH] Fix missing `#include "missing.h"`.
Date: Thu, 04 Feb 2021 10:29:37 +0100
Message-ID: <20210204092937.1726283-1-mc5686@mclink.it>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3392865164284710197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If explicit_bzero() is not available (e.g.: with uClibc) build fails
because of:

ell/cert.c: In function =E2=80=98cert_key_from_pkcs8_encrypted_private_key_=
info=E2=80=99:
ell/cert.c:665:2: warning: implicit declaration of function =E2=80=98explic=
it_bzero=E2=80=99 [-Wimplicit-function-declaration]
  665 |  explicit_bzero(decrypted, data_len);
      |  ^~~~~~~~~~~~~~

in spite of correct detection:

checking for explicit_bzero... no

and:

...
/* Define to 1 if you have the `explicit_bzero' function. */
/* #undef HAVE_EXPLICIT_BZERO */
...

Fix is adding `#include "missing.h"` as it is done in simila files.

Signed-off-by: Mauro Condarelli <mc5686@mclink.it>
---
 ell/cert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ell/cert.c b/ell/cert.c
index c26051f..b54c7b1 100644
--- a/ell/cert.c
+++ b/ell/cert.c
@@ -33,6 +33,7 @@
 #include "pem-private.h"
 #include "cert.h"
 #include "cert-private.h"
+#include "missing.h"
 =

 #define X509_CERTIFICATE_POS			0
 #define   X509_TBSCERTIFICATE_POS		  0
-- =

2.25.1

--===============3392865164284710197==--

