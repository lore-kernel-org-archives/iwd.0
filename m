Content-Type: multipart/mixed; boundary="===============7584530155350987592=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] src/p2p.c: fix build with uclibc
Date: Sat, 20 Jun 2020 15:19:54 +0200
Message-ID: <20200620131954.436598-1-fontaine.fabrice@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7584530155350987592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

explicit_bzero is used in src/p2p.c since commit
1675c765a3d66f3c626a1581a7bf514e1859b064 but src/missing.h is not
included, as a result build with uclibc fails on:

/home/naourr/work/instance-0/output-1/per-package/iwd/host/opt/ext-toolchai=
n/bin/../lib/gcc/mips64el-buildroot-linux-uclibc/5.5.0/../../../../mips64el=
-buildroot-linux-uclibc/bin/ld: src/p2p.o: in function `p2p_connection_rese=
t':
p2p.c:(.text+0x2cf4): undefined reference to `explicit_bzero'
/home/naourr/work/instance-0/output-1/per-package/iwd/host/opt/ext-toolchai=
n/bin/../lib/gcc/mips64el-buildroot-linux-uclibc/5.5.0/../../../../mips64el=
-buildroot-linux-uclibc/bin/ld: p2p.c:(.text+0x2cfc): undefined reference t=
o `explicit_bzero'

Fixes:
 - http://autobuild.buildroot.org/results/8bbf7e1d0929d0883c0c2445990f62f5a=
1d54163

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 src/p2p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/p2p.c b/src/p2p.c
index dc78b887..a759df5c 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -37,6 +37,7 @@
 =

 #include "linux/nl80211.h"
 =

+#include "src/missing.h"
 #include "src/iwd.h"
 #include "src/wiphy.h"
 #include "src/scan.h"
-- =

2.26.2

--===============7584530155350987592==--

