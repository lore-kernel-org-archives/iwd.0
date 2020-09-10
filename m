Content-Type: multipart/mixed; boundary="===============8585151270317686741=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] src/ap.c: fix build with uclibc
Date: Thu, 10 Sep 2020 08:18:00 +0200
Message-ID: <20200910061800.497914-1-fontaine.fabrice@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8585151270317686741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

explicit_bzero is used in src/ap.c since commit
d55e00b31d7bccdbb2ea1cdeb0a749df77a51e47 but src/missing.h is not
included, as a result build with uclibc fails on:

/srv/storage/autobuild/run/instance-1/output-1/host/lib/gcc/xtensa-buildroo=
t-linux-uclibc/9.3.0/../../../../xtensa-buildroot-linux-uclibc/bin/ld: src/=
ap.o: in function `ap_probe_req_cb':
ap.c:(.text+0x23d8): undefined reference to `explicit_bzero'

Fixes:
 - http://autobuild.buildroot.org/results/c7a0096a269bfc52bd8e23d453d36d5bf=
b61441d

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 src/ap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ap.c b/src/ap.c
index c972cfcb..ac705c31 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -31,6 +31,7 @@
 =

 #include "linux/nl80211.h"
 =

+#include "src/missing.h"
 #include "src/iwd.h"
 #include "src/module.h"
 #include "src/scan.h"
-- =

2.28.0

--===============8585151270317686741==--

