Content-Type: multipart/mixed; boundary="===============7569956060431169545=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] build: add pem-private.h to Makefile.am
Date: Fri, 04 Oct 2019 10:13:19 -0700
Message-ID: <20191004171319.27132-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7569956060431169545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 1e489bb3..00dc899c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -103,6 +103,7 @@ ell_sources =3D ell/private.h \
 			ell/base64.c \
 			ell/asn1-private.h \
 			ell/pem.c \
+			ell/pem-private.h \
 			ell/tls-private.h \
 			ell/tls.c \
 			ell/tls-record.c \
-- =

2.17.1

--===============7569956060431169545==--

