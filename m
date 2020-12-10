Content-Type: multipart/mixed; boundary="===============1896846625890777985=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] build: add ell/acd.{c,h} to makefile
Date: Thu, 10 Dec 2020 09:45:17 -0800
Message-ID: <20201210174525.874021-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1896846625890777985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 1f0b0d30..3cd7eaa6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -61,7 +61,8 @@ ell_headers =3D ell/util.h \
 			ell/time.h \
 			ell/path.h \
 			ell/icmp6.h \
-			ell/dhcp6.h
+			ell/dhcp6.h \
+			ell/acd.h
 =

 ell_sources =3D ell/private.h \
 			ell/missing.h \
@@ -138,7 +139,8 @@ ell_sources =3D ell/private.h \
 			ell/icmp6.c \
 			ell/icmp6-private.h \
 			ell/dhcp6-lease.c \
-			ell/dhcp6-transport.c
+			ell/dhcp6-transport.c \
+			ell/acd.c
 =

 ell_libell_internal_la_SOURCES =3D $(ell_headers) $(ell_sources)
 endif
-- =

2.26.2

--===============1896846625890777985==--

