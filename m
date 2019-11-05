Content-Type: multipart/mixed; boundary="===============1279683092400897920=="
MIME-Version: 1.0
From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Makefile.am: Avoid redirection of input and output files
Date: Mon, 04 Nov 2019 17:07:05 -0800
Message-ID: <20191105010705.2711040-1-raj.khem@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1279683092400897920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can cause a build race in a highly parallelised build where a director=
y is not yet created but
output file is being written using redirection e.g.

rst2man.py --strict --no-raw --no-generator --no-datestamp < ../git/monitor=
/iwmon.rst > monitor/iwmon.1
/bin/sh: monitor/iwmon.1: No such file or directory
make[1]: *** [Makefile:3544: monitor/iwmon.1] Error 1
---
 Makefile.am | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 823b7d02..21dd707c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -627,7 +627,7 @@ SED_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) && $(SE=
D) \
 =

 if RUN_RST2MAN
 RST2MAN_PROCESS =3D $(AM_V_GEN)$(RST2MAN) --strict --no-raw --no-generator=
 \
-			--no-datestamp < $< > $@
+			--no-datestamp
 else
 RST2MAN_PROCESS =3D $(AM_V_GEN)test -f $@ || \
 		{ echo "Generated manual page $@ does not exist"; false; }
@@ -637,13 +637,13 @@ endif
 	$(SED_PROCESS)
 =

 %.1: %.rst Makefile
-	$(RST2MAN_PROCESS)
+	$(RST2MAN_PROCESS) $< $@
 =

 %.5: %.rst Makefile
-	$(RST2MAN_PROCESS)
+	$(RST2MAN_PROCESS) $< $@
 =

 %.8: %.rst Makefile
-	$(RST2MAN_PROCESS)
+	$(RST2MAN_PROCESS) $< $@
 =

 install-data-local:
 if !SYSTEMD_SERVICE
-- =

2.24.0

--===============1279683092400897920==--

