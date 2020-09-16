Content-Type: multipart/mixed; boundary="===============4071829705404019292=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] plugins: remove dependency on ELL plugins
Date: Wed, 16 Sep 2020 10:08:08 -0700
Message-ID: <20200916170814.660095-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4071829705404019292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There has been a desire to remove the ELL plugin dependency from
IWD which is the only consumer of the plugin API. This removes
the dependency and prepares the tree for converting the existing
ofono and sim_hardcoded plugins into regular modules.
---
 Makefile.am                      |  5 ++---
 src/main.c                       | 16 ----------------
 {plugins =3D> src}/ofono.c         |  0
 {plugins =3D> src}/sim_hardcoded.c |  0
 4 files changed, 2 insertions(+), 19 deletions(-)
 rename {plugins =3D> src}/ofono.c (100%)
 rename {plugins =3D> src}/sim_hardcoded.c (100%)

diff --git a/Makefile.am b/Makefile.am
index 5f16920f..e327874b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -185,7 +185,6 @@ if DAEMON
 libexec_PROGRAMS +=3D src/iwd
 =

 src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.h src/missing.h \
-					src/plugin.h src/plugin.c \
 					src/netdev.h src/netdev.c \
 					src/wiphy.h src/wiphy.c \
 					src/device.c \
@@ -237,12 +236,12 @@ src_iwd_DEPENDENCIES =3D $(ell_dependencies)
 =

 if SIM_HARDCODED
 builtin_modules +=3D sim_hardcoded
-builtin_sources +=3D plugins/sim_hardcoded.c
+builtin_sources +=3D src/sim_hardcoded.c
 endif
 =

 if OFONO
 builtin_modules +=3D ofono
-builtin_sources +=3D plugins/ofono.c
+builtin_sources +=3D src/ofono.c
 endif
 =

 if DBUS_POLICY
diff --git a/src/main.c b/src/main.c
index 3216f508..2ee6188c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -40,7 +40,6 @@
 #include "src/eap.h"
 #include "src/eapol.h"
 #include "src/rfkill.h"
-#include "src/plugin.h"
 #include "src/storage.h"
 #include "src/anqp.h"
 =

@@ -54,8 +53,6 @@ static const char *interfaces;
 static const char *nointerfaces;
 static const char *phys;
 static const char *nophys;
-static const char *plugins;
-static const char *noplugins;
 static const char *debugopt;
 static bool terminating;
 static bool nl80211_complete;
@@ -140,8 +137,6 @@ static void usage(void)
 		"\t-I, --nointerfaces     Interfaces to ignore\n"
 		"\t-p, --phys             Phys to manage\n"
 		"\t-P, --nophys           Phys to ignore\n"
-		"\t-l, --plugin           Plugins to include\n"
-		"\t-L, --noplugin         Plugins to exclude\n"
 		"\t-d, --debug            Enable debug output\n"
 		"\t-v, --version          Show version\n"
 		"\t-h, --help             Show help options\n");
@@ -154,8 +149,6 @@ static const struct option main_options[] =3D {
 	{ "nointerfaces", required_argument, NULL, 'I' },
 	{ "phys",         required_argument, NULL, 'p' },
 	{ "nophys",       required_argument, NULL, 'P' },
-	{ "plugin",       required_argument, NULL, 'l' },
-	{ "noplugin",     required_argument, NULL, 'L' },
 	{ "debug",        optional_argument, NULL, 'd' },
 	{ "help",         no_argument,       NULL, 'h' },
 	{ }
@@ -179,8 +172,6 @@ static void nl80211_appeared(const struct l_genl_family=
_info *info,
 		l_main_quit();
 		return;
 	}
-
-	plugin_init(plugins, noplugins);
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
@@ -393,12 +384,6 @@ int main(int argc, char *argv[])
 		case 'P':
 			nophys =3D optarg;
 			break;
-		case 'l':
-			plugins =3D optarg;
-			break;
-		case 'L':
-			noplugins =3D optarg;
-			break;
 		case 'd':
 			if (optarg)
 				debugopt =3D optarg;
@@ -504,7 +489,6 @@ int main(int argc, char *argv[])
 =

 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
 =

-	plugin_exit();
 	iwd_modules_exit();
 	dbus_exit();
 	l_dbus_destroy(dbus);
diff --git a/plugins/ofono.c b/src/ofono.c
similarity index 100%
rename from plugins/ofono.c
rename to src/ofono.c
diff --git a/plugins/sim_hardcoded.c b/src/sim_hardcoded.c
similarity index 100%
rename from plugins/sim_hardcoded.c
rename to src/sim_hardcoded.c
-- =

2.26.2

--===============4071829705404019292==--

