Content-Type: multipart/mixed; boundary="===============2255103859445242511=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/11] wiphy: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 10:24:13 -0700
Message-ID: <20191011172417.23328-7-prestwoj@gmail.com>
In-Reply-To: <20191011172417.23328-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2255103859445242511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This converts wiphy into an IWD module. nl80211 was completely removed
from main.c as it is no longer passed with manager or wiphy.
---
 src/iwd.h   |  2 ++
 src/main.c  | 25 ++++++++++++++-----------
 src/wiphy.c | 20 ++++++++++++--------
 src/wiphy.h |  4 ----
 4 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/src/iwd.h b/src/iwd.h
index 8814c244..1b64e5a7 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -32,6 +32,8 @@ void netdev_shutdown(void);
 =

 const char *iwd_get_iface_whitelist(void);
 const char *iwd_get_iface_blacklist(void);
+const char *iwd_get_phy_whitelist(void);
+const char *iwd_get_phy_blacklist(void);
 =

 struct iwd_module_desc {
 	const char *name;
diff --git a/src/main.c b/src/main.c
index 4b114efd..9d0da143 100644
--- a/src/main.c
+++ b/src/main.c
@@ -46,7 +46,6 @@
 #include "src/backtrace.h"
 =

 static struct l_genl *genl;
-static struct l_genl_family *nl80211;
 static struct l_settings *iwd_config;
 static struct l_timeout *timeout;
 static const char *interfaces;
@@ -57,6 +56,7 @@ static const char *plugins;
 static const char *noplugins;
 static const char *debugopt;
 static bool terminating;
+static bool nl80211_complete;
 =

 static void main_loop_quit(struct l_timeout *timeout, void *user_data)
 {
@@ -70,7 +70,7 @@ static void iwd_shutdown(void)
 =

 	terminating =3D true;
 =

-	if (!nl80211) {
+	if (!nl80211_complete) {
 		l_main_quit();
 		return;
 	}
@@ -112,6 +112,16 @@ const char *iwd_get_iface_blacklist(void)
 	return nointerfaces;
 }
 =

+const char *iwd_get_phy_whitelist(void)
+{
+	return phys;
+}
+
+const char *iwd_get_phy_blacklist(void)
+{
+	return nophys;
+}
+
 static void usage(void)
 {
 	printf("iwd - Wireless daemon\n"
@@ -155,15 +165,13 @@ static void nl80211_appeared(const struct l_genl_fami=
ly_info *info,
 							void *user_data)
 {
 	l_debug("Found nl80211 interface");
-	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
+
+	nl80211_complete =3D true;
 =

 	if (iwd_modules_init() < 0) {
 		l_main_quit();
 		return;
 	}
-
-	if (!wiphy_init(nl80211, phys, nophys))
-		l_error("Unable to init wiphy functionality");
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
@@ -496,11 +504,6 @@ int main(int argc, char *argv[])
 =

 	eap_exit();
 =

-	if (nl80211) {
-		wiphy_exit();
-		l_genl_family_free(nl80211);
-	}
-
 	dbus_exit();
 	l_dbus_destroy(dbus);
 	storage_cleanup_dirs();
diff --git a/src/wiphy.c b/src/wiphy.c
index b672afd4..169631af 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1150,12 +1150,16 @@ static void setup_wiphy_interface(struct l_dbus_int=
erface *interface)
 					NULL);
 }
 =

-bool wiphy_init(struct l_genl_family *in, const char *whitelist,
-							const char *blacklist)
+static int wiphy_init(void)
 {
+	struct l_genl *genl =3D iwd_get_genl();
 	const struct l_settings *config =3D iwd_get_config();
 	const char *s =3D l_settings_get_value(config, "General",
 							"mac_randomize_bytes");
+	const char *whitelist =3D iwd_get_phy_whitelist();
+	const char *blacklist =3D iwd_get_phy_blacklist();
+
+	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
 =

 	if (s && !strcmp(s, "nic"))
 		mac_randomize_bytes =3D 3;
@@ -1169,8 +1173,6 @@ bool wiphy_init(struct l_genl_family *in, const char =
*whitelist,
 		l_queue_destroy(wiphy_list, NULL);
 	}
 =

-	nl80211 =3D in;
-
 	wiphy_list =3D l_queue_new();
 =

 	rfkill_watch_add(wiphy_rfkill_cb, NULL);
@@ -1190,10 +1192,10 @@ bool wiphy_init(struct l_genl_family *in, const cha=
r *whitelist,
 	if (blacklist)
 		blacklist_filter =3D l_strsplit(blacklist, ',');
 =

-	return true;
+	return 0;
 }
 =

-bool wiphy_exit(void)
+static void wiphy_exit(void)
 {
 	l_strfreev(whitelist_filter);
 	l_strfreev(blacklist_filter);
@@ -1201,12 +1203,14 @@ bool wiphy_exit(void)
 	l_queue_destroy(wiphy_list, wiphy_free);
 	wiphy_list =3D NULL;
 =

+	l_genl_family_free(nl80211);
 	nl80211 =3D NULL;
 	mac_randomize_bytes =3D 6;
 =

 	l_dbus_unregister_interface(dbus_get_bus(), IWD_WIPHY_INTERFACE);
 =

 	l_hwdb_unref(hwdb);
-
-	return true;
 }
+
+IWD_MODULE(wiphy, wiphy_init, wiphy_exit);
+IWD_MODULE_DEPENDS(wiphy, rfkill);
diff --git a/src/wiphy.h b/src/wiphy.h
index 10cf5373..61e1caf8 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -81,7 +81,3 @@ uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func, void *user_data,
 				wiphy_destroy_func_t destroy);
 bool wiphy_state_watch_remove(struct wiphy *wiphy, uint32_t id);
-
-bool wiphy_init(struct l_genl_family *in, const char *whitelist,
-							const char *blacklist);
-bool wiphy_exit(void);
-- =

2.17.1

--===============2255103859445242511==--

