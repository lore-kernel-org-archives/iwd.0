Content-Type: multipart/mixed; boundary="===============9127392575076826581=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/12] wiphy: remove white/blacklist from wiphy_init
Date: Fri, 11 Oct 2019 12:29:28 -0700
Message-ID: <20191011192933.13550-7-prestwoj@gmail.com>
In-Reply-To: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9127392575076826581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

wiphy will now use getters for the phy white/black list.
---
 src/iwd.h   |  3 +++
 src/main.c  | 12 +++++++++++-
 src/wiphy.c |  5 +++--
 src/wiphy.h |  3 +--
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/iwd.h b/src/iwd.h
index 8814c244..6073fae5 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -33,6 +33,9 @@ void netdev_shutdown(void);
 const char *iwd_get_iface_whitelist(void);
 const char *iwd_get_iface_blacklist(void);
 =

+const char *iwd_get_phy_whitelist(void);
+const char *iwd_get_phy_blacklist(void);
+
 struct iwd_module_desc {
 	const char *name;
 	int (*init)(void);
diff --git a/src/main.c b/src/main.c
index 761d869e..50a1499d 100644
--- a/src/main.c
+++ b/src/main.c
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
@@ -164,7 +174,7 @@ static void nl80211_appeared(const struct l_genl_family=
_info *info,
 =

 	plugin_init(plugins, noplugins);
 =

-	if (!wiphy_init(nl80211, phys, nophys))
+	if (!wiphy_init(nl80211))
 		l_error("Unable to init wiphy functionality");
 }
 =

diff --git a/src/wiphy.c b/src/wiphy.c
index b672afd4..3316a084 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1150,12 +1150,13 @@ static void setup_wiphy_interface(struct l_dbus_int=
erface *interface)
 					NULL);
 }
 =

-bool wiphy_init(struct l_genl_family *in, const char *whitelist,
-							const char *blacklist)
+bool wiphy_init(struct l_genl_family *in)
 {
 	const struct l_settings *config =3D iwd_get_config();
 	const char *s =3D l_settings_get_value(config, "General",
 							"mac_randomize_bytes");
+	const char *whitelist =3D iwd_get_phy_whitelist();
+	const char *blacklist =3D iwd_get_phy_blacklist();
 =

 	if (s && !strcmp(s, "nic"))
 		mac_randomize_bytes =3D 3;
diff --git a/src/wiphy.h b/src/wiphy.h
index 10cf5373..ac94585f 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -82,6 +82,5 @@ uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_destroy_func_t destroy);
 bool wiphy_state_watch_remove(struct wiphy *wiphy, uint32_t id);
 =

-bool wiphy_init(struct l_genl_family *in, const char *whitelist,
-							const char *blacklist);
+bool wiphy_init(struct l_genl_family *in);
 bool wiphy_exit(void);
-- =

2.17.1

--===============9127392575076826581==--

