Content-Type: multipart/mixed; boundary="===============6150846419198741383=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 14/15] tools: post test-runner rewrite cleanup
Date: Fri, 28 Aug 2020 11:47:38 -0700
Message-ID: <20200828184739.8616-15-prestwoj@gmail.com>
In-Reply-To: <20200828184739.8616-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6150846419198741383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Removed test-runner.c, and renamed py_runner to test-runner. Removed
tools/test-runner from .gitignore.

This was done as a separate commit to avoid a nasty diff between the
existing test runner, and the new python version
---
 .gitignore                          | 1 -
 Makefile.am                         | 7 -------
 tools/{py_runner.py =3D> test-runner} | 0
 3 files changed, 8 deletions(-)
 rename tools/{py_runner.py =3D> test-runner} (100%)

diff --git a/.gitignore b/.gitignore
index 93fec4f7..33405af8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,7 +33,6 @@ wired/ead.8
 wired/ead.service
 tools/hwsim
 tools/hwsim.1
-tools/test-runner
 tools/probe-req
 unit/test-cmac-aes
 unit/test-arc4
diff --git a/Makefile.am b/Makefile.am
index e83dbeee..5f16920f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -366,13 +366,6 @@ man_MANS +=3D tools/hwsim.1
 endif
 endif
 =

-if TOOLS
-noinst_PROGRAMS +=3D tools/test-runner
-
-tools_test_runner_SOURCES =3D tools/test-runner.c
-tools_test_runner_LDADD =3D $(ell_ldadd)
-endif
-
 unit_tests =3D unit/test-cmac-aes \
 		unit/test-hmac-md5 unit/test-hmac-sha1 unit/test-hmac-sha256 \
 		unit/test-prf-sha1 unit/test-kdf-sha256 \
diff --git a/tools/py_runner.py b/tools/test-runner
similarity index 100%
rename from tools/py_runner.py
rename to tools/test-runner
-- =

2.21.1

--===============6150846419198741383==--

