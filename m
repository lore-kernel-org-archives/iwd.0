Content-Type: multipart/mixed; boundary="===============2506709843226342730=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] sim_hardcoded: convert to module
Date: Wed, 16 Sep 2020 10:08:11 -0700
Message-ID: <20200916170814.660095-4-prestwoj@gmail.com>
In-Reply-To: <20200916170814.660095-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2506709843226342730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The only change	(apart from IWD_MODULE)	was to check main.conf
for SimAuthBackend=3Dhardcoded.
---
 src/sim_hardcoded.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/src/sim_hardcoded.c b/src/sim_hardcoded.c
index 463c39fe..cab5d4f5 100644
--- a/src/sim_hardcoded.c
+++ b/src/sim_hardcoded.c
@@ -27,9 +27,10 @@
 #include <errno.h>
 =

 #include <ell/ell.h>
-#include <ell/plugin.h>
 =

 #include "src/simauth.h"
+#include "src/module.h"
+#include "src/iwd.h"
 =

 struct hardcoded_sim {
 	char *identity;
@@ -263,7 +264,15 @@ static int sim_hardcoded_init(void)
 	const char *str;
 	size_t len;
 	struct l_settings *key_settings;
-	const char *config_path =3D getenv("IWD_SIM_KEYS");
+	const char *config_path;
+	const struct l_settings *settings =3D iwd_get_config();
+
+	const char *value =3D l_settings_get_value(settings, "General",
+							"SimAuthBackend");
+	if (!value || strcmp(value, "hardcoded"))
+		return 0;
+
+	config_path =3D getenv("IWD_SIM_KEYS");
 =

 	if (!config_path) {
 		l_debug("IWD_SIM_KEYS not set in env");
@@ -394,6 +403,5 @@ static void sim_hardcoded_exit(void)
 	l_free(sim);
 }
 =

-L_PLUGIN_DEFINE(__iwd_builtin_sim_hardcoded, sim_hardcoded,
-		"Hardcoded SIM driver", "1.0", L_PLUGIN_PRIORITY_DEFAULT,
-		sim_hardcoded_init, sim_hardcoded_exit)
+IWD_MODULE(sim_hardcoded, sim_hardcoded_init, sim_hardcoded_exit);
+IWD_MODULE_DEPENDS(sim_hardcoded, simauth);
-- =

2.26.2

--===============2506709843226342730==--

