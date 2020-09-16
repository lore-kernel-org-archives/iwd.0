Content-Type: multipart/mixed; boundary="===============8267978863692334323=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/6] ofono: convert to module
Date: Wed, 16 Sep 2020 12:39:42 -0700
Message-ID: <20200916193945.683476-3-prestwoj@gmail.com>
In-Reply-To: <20200916193945.683476-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8267978863692334323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/ofono.c b/src/ofono.c
index 186dac71..3855edb3 100644
--- a/src/ofono.c
+++ b/src/ofono.c
@@ -30,11 +30,12 @@
 #include <errno.h>
 =

 #include <ell/ell.h>
-#include <ell/plugin.h>
 #include <ell/dbus.h>
 =

 #include "src/dbus.h"
 #include "src/simauth.h"
+#include "src/module.h"
+#include "src/iwd.h"
 =

 /*
  * This plugin takes care of all the communication with ofono in order to
@@ -783,5 +784,5 @@ static void ofono_exit(void)
 	l_dbus_remove_watch(dbus, ofono_watch);
 }
 =

-L_PLUGIN_DEFINE(__iwd_builtin_ofono, ofono, "oFono plugin", "1.0",
-		L_PLUGIN_PRIORITY_DEFAULT, ofono_init, ofono_exit)
+IWD_MODULE(ofono, ofono_init, ofono_exit);
+IWD_MODULE_DEPENDS(ofono, simauth);
-- =

2.26.2

--===============8267978863692334323==--

