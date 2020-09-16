Content-Type: multipart/mixed; boundary="===============5836909403632547890=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] ofono: convert to module
Date: Wed, 16 Sep 2020 10:08:10 -0700
Message-ID: <20200916170814.660095-3-prestwoj@gmail.com>
In-Reply-To: <20200916170814.660095-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5836909403632547890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The only change (apart from IWD_MODULE) was to check main.conf
for SimAuthBackend=3Dofono.
---
 src/ofono.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/ofono.c b/src/ofono.c
index 186dac71..7b2e43ce 100644
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
@@ -765,7 +766,15 @@ static void ofono_disappeared(struct l_dbus *dbus, voi=
d *user_data)
 =

 static int ofono_init(void)
 {
-	struct l_dbus *dbus =3D dbus_get_bus();
+	const struct l_settings *settings =3D iwd_get_config();
+	struct l_dbus *dbus;
+
+	const char *value =3D l_settings_get_value(settings, "General",
+							"SimAuthBackend");
+	if (!value || strcmp(value, "ofono"))
+		return 0;
+
+	dbus =3D dbus_get_bus();
 =

 	ofono_watch =3D l_dbus_add_service_watch(dbus, "org.ofono", ofono_found,
 			ofono_disappeared, NULL, NULL);
@@ -783,5 +792,5 @@ static void ofono_exit(void)
 	l_dbus_remove_watch(dbus, ofono_watch);
 }
 =

-L_PLUGIN_DEFINE(__iwd_builtin_ofono, ofono, "oFono plugin", "1.0",
-		L_PLUGIN_PRIORITY_DEFAULT, ofono_init, ofono_exit)
+IWD_MODULE(ofono, ofono_init, ofono_exit);
+IWD_MODULE_DEPENDS(ofono, simauth);
-- =

2.26.2

--===============5836909403632547890==--

