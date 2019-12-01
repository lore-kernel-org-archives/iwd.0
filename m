Content-Type: multipart/mixed; boundary="===============3083548579344265870=="
MIME-Version: 1.0
From: Michael Forney <mforney@mforney.org>
Subject: [PATCH] build: Make ln usage POSIX-compatible
Date: Sun, 01 Dec 2019 14:56:01 -0800
Message-ID: <20191201225601.27554-1-mforney@mforney.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3083548579344265870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not all ln(1) implementations support the -t option.
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 1d572db5..54656c76 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -614,7 +614,7 @@ ell/internal: Makefile
 	$(AM_V_at)$(MKDIR_P) ell
 	$(AM_V_GEN)for f in $(ell_headers) $(ell_sources) ; do \
 		if [ ! -f $$f ] ; then \
-			$(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \
+			$(LN_S) -f $(abs_srcdir)/../ell/$$f $$f ; \
 		fi \
 	done > $@
 =

-- =

2.20.1

--===============3083548579344265870==--

