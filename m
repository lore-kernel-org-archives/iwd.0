Content-Type: multipart/mixed; boundary="===============3819752807145688675=="
MIME-Version: 1.0
From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH V3] Makefile.am: Avoid redirection of input and output files
Date: Fri, 06 Mar 2020 11:22:53 -0800
Message-ID: <20200306192253.1758531-1-raj.khem@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3819752807145688675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ensure that directory is created before its written to

This can cause a build race in a highly parallelised build where a director=
y is not yet created but
output file is being written using redirection e.g.

rst2man.py --strict --no-raw --no-generator --no-datestamp < ../git/monitor=
/iwmon.rst > monitor/iwmon.1
/bin/sh: monitor/iwmon.1: No such file or directory
make[1]: *** [Makefile:3544: monitor/iwmon.1] Error 1

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
v2: create directory before emitting doc files into it
v3: No change, rebased on master

 Makefile.am | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9d378d3d..ac83376e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -631,8 +631,9 @@ SED_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) && $(SE=
D) \
 		< $< > $@
 =

 if RUN_RST2MAN
-RST2MAN_PROCESS =3D $(AM_V_GEN)$(RST2MAN) --strict --no-raw --no-generator=
 \
-			--no-datestamp $< $@
+RST2MAN_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
+			$(AM_V_GEN)$(RST2MAN) --strict --no-raw \
+			--no-generator --no-datestamp $< $@
 else
 RST2MAN_PROCESS =3D $(AM_V_GEN)test -f $@ || \
 		{ echo "Generated manual page $@ does not exist"; false; }
-- =

2.25.1

--===============3819752807145688675==--

