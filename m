Content-Type: multipart/mixed; boundary="===============1629374014332395267=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH] build: fix ell/shared build failure
Date: Mon, 19 Apr 2021 11:45:50 +0000
Message-ID: <20210419114546.840331-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1629374014332395267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the following build error:

  $ /path/to/iwd/configure --disable-dependency-tracking
  $ make
    GEN      ell/shared
  /bin/sh: line 5: ell/shared: No such file or directory
  make: *** [Makefile:3656: ell/shared] Error 1

The error can also arise if building with --enable-external-ell.

Fixes: ed05585063f2 ("build: Always link in the ell/useful.h header file")
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 644f3556..68035e46 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -625,6 +625,7 @@ unit/tls-settings.8021x: unit/cert-ca.pem unit/cert-cli=
ent.pem unit/cert-client-
 BUILT_SOURCES =3D $(ell_built_sources) src/builtin.h
 =

 ell/shared: Makefile
+	$(AM_V_at)$(MKDIR_P) ell
 	$(AM_V_GEN)for f in $(ell_shared) ; do \
 		if [ ! -f $$f ] ; then \
 			$(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \
-- =

2.30.2
--===============1629374014332395267==--

