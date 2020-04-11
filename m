Content-Type: multipart/mixed; boundary="===============3655100030939333106=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] frame-xchg.c: fix build with gcc 4.8
Date: Sat, 11 Apr 2020 23:30:35 +0200
Message-ID: <20200411213035.972026-1-fontaine.fabrice@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3655100030939333106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SOL_NETLINK is used since commit
87a198111af1ea67053895f7435fb99e3cdd2159 resulting in the following
build failure with gcc 4.8:

src/frame-xchg.c: In function 'frame_watch_group_io_read':
src/frame-xchg.c:328:27: error: 'SOL_NETLINK' undeclared (first use in this=
 function)
   if (cmsg->cmsg_level !=3D SOL_NETLINK)
                           ^
Fixes:
 - http://autobuild.buildroot.org/results/3485088b84111c271bbcfaf025aa4103c=
6452072

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 src/frame-xchg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 50351615..4c950fd3 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -42,6 +42,10 @@
 #include "src/netdev.h"
 #include "src/frame-xchg.h"
 =

+#ifndef SOL_NETLINK
+#define SOL_NETLINK 270
+#endif
+
 struct watch_group {
 	/*
 	 * Group IDs, except 0, are per wdev for user's convenience.
-- =

2.25.1

--===============3655100030939333106==--

