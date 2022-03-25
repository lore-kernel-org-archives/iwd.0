Content-Type: multipart/mixed; boundary="===============3144462621279071463=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] src/storage.c: fix build with uclibc
Date: Fri, 25 Mar 2022 22:00:17 +0100
Message-ID: <20220325210017.525876-1-fontaine.fabrice@gmail.com>

--===============3144462621279071463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

explicit_bzero is used in src/storage.c since commit
01cd8587606bf2da1af245163150589834126c1c but src/missing.h is not
included, as a result build with uclibc fails on:

/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/powerpc-buildroo=
t-linux-uclibc/10.3.0/../../../../powerpc-buildroot-linux-uclibc/bin/ld: sr=
c/storage.o: in function `storage_init':
storage.c:(.text+0x13a4): undefined reference to `explicit_bzero'

Fixes:
 - http://autobuild.buildroot.org/results/2aff8d3d7c33c95e2c57f7c8a71e69939=
f0580a1

Signed-off-by: Fabrice Fontaine <fontaine.fabrice(a)gmail.com>
---
 src/storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/storage.c b/src/storage.c
index 82a72443..aa8066b1 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -44,6 +44,7 @@
 #include <ell/ell.h>
 #include "ell/useful.h"
 =

+#include "src/missing.h"
 #include "src/common.h"
 #include "src/storage.h"
 #include "src/crypto.h"
-- =

2.35.1

--===============3144462621279071463==--

