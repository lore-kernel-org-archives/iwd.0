Content-Type: multipart/mixed; boundary="===============7684197382204085605=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2] src/sae.c: fix build without reallocarray
Date: Sun, 19 Sep 2021 21:17:44 +0200
Message-ID: <20210919191744.3963258-1-fontaine.fabrice@gmail.com>

--===============7684197382204085605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

reallocarray has been added to glibc relatively recently (version 2.26,
from 2017) and apparently not all users run new enough glibc. Moreover,
reallocarray is not available with uclibc-ng. So use realloc if
reallocarray is not available to avoid the following build failure
raised since commit 891b78e9e892a3bcd800eb3a298e6380e9a15dd1:

/home/giuliobenetti/autobuild/run/instance-3/output-1/host/lib/gcc/xtensa-b=
uildroot-linux-uclibc/10.3.0/../../../../xtensa-buildroot-linux-uclibc/bin/=
ld: src/sae.o: in function `sae_rx_authenticate':
sae.c:(.text+0xd74): undefined reference to `reallocarray'

Fixes:
 - http://autobuild.buildroot.org/results/c6d3f86282c44645b4f1c61882dc63ccf=
c8eb35a
---
Changes v1 -> v2 (after review of Denis Kenzior):
 - Remove SoB
 - Add reallocarray to missing.h

 configure.ac  | 1 +
 src/missing.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/configure.ac b/configure.ac
index c6250401..51d9da93 100644
--- a/configure.ac
+++ b/configure.ac
@@ -129,6 +129,7 @@ AC_DEFINE_UNQUOTED(WIRED_STORAGEDIR, "${wired_storagedi=
r}",
 =

 AC_CHECK_FUNCS(explicit_bzero)
 AC_CHECK_FUNCS(rawmemchr)
+AC_CHECK_FUNCS(reallocarray)
 =

 AC_CHECK_HEADERS(linux/types.h linux/if_alg.h)
 =

diff --git a/src/missing.h b/src/missing.h
index 2cc80aee..a5b92952 100644
--- a/src/missing.h
+++ b/src/missing.h
@@ -37,3 +37,10 @@ _Pragma("GCC diagnostic ignored \"-Wstringop-overflow=3D=
\"")
 _Pragma("GCC diagnostic pop")
 }
 #endif
+
+#ifndef HAVE_REALLOCARRAY
+static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
+{
+	return realloc(ptr, nmemb * size);
+}
+#endif
-- =

2.33.0

--===============7684197382204085605==--

