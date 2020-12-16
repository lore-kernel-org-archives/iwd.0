Content-Type: multipart/mixed; boundary="===============2584063977968369028=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] configure.ac: fix static build with readline
Date: Wed, 16 Dec 2020 08:02:55 +0100
Message-ID: <20201216070255.142413-1-fontaine.fabrice@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2584063977968369028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Retrieve the dependencies of readline through pkg-config (and fallback
to -lreadline) to avoid the following build failure:

/nvme/rc-buildroot-test/scripts/instance-0/output-1/host/opt/ext-toolchain/=
bin/../lib/gcc/x86_64-buildroot-linux-uclibc/8.3.0/../../../../x86_64-build=
root-linux-uclibc/bin/ld: /nvme/rc-buildroot-test/scripts/instance-0/output=
-1/host/bin/../x86_64-buildroot-linux-uclibc/sysroot/usr/lib/libreadline.a(=
display.o): in function `cr':
display.c:(.text+0x1ab): undefined reference to `tputs'

Fixes:
 - http://autobuild.buildroot.org/results/8fb1341f2f5094c346456b43b4fc04996=
c2e1485

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 Makefile.am  | 4 ++--
 configure.ac | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 3cd7eaa6..493d06cc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -288,7 +288,7 @@ client_iwctl_SOURCES =3D client/main.c \
 			client/network.h client/network.c \
 			client/properties.h client/properties.c \
 			client/wsc.c client/station.c
-client_iwctl_LDADD =3D $(ell_ldadd) -lreadline
+client_iwctl_LDADD =3D $(ell_ldadd) $(READLINE_LIBS)
 =

 if MANUAL_PAGES
 man_MANS +=3D client/iwctl.1
@@ -504,7 +504,7 @@ unit_test_client_SOURCES =3D unit/test-client.c \
 				client/display.h client/display.c \
 				client/network.h client/network.c \
 				client/properties.h client/properties.c
-unit_test_client_LDADD =3D $(ell_ldadd) -lreadline
+unit_test_client_LDADD =3D $(ell_ldadd) $(READLINE_LIBS)
 endif
 =

 unit_test_sae_SOURCES =3D unit/test-sae.c \
diff --git a/configure.ac b/configure.ac
index 7bd917a4..52f27ed9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -154,6 +154,9 @@ AC_ARG_ENABLE([client], AC_HELP_STRING([--disable-clien=
t],
 if (test "${enable_client}" !=3D "no"); then
 	AC_CHECK_HEADERS(readline/readline.h, enable_readline=3Dyes,
 			AC_MSG_ERROR(readline header files are required))
+	PKG_CHECK_MODULES(READLINE, readline, dummy=3Dyes, READLINE_LIBS=3D-lread=
line)
+	AC_SUBST(READLINE_CFLAGS)
+	AC_SUBST(READLINE_LIBS)
 fi
 AM_CONDITIONAL(CLIENT, test "${enable_client}" !=3D "no")
 =

-- =

2.29.2

--===============2584063977968369028==--

