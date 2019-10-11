Content-Type: multipart/mixed; boundary="===============2019207058307248724=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/12] manager: remove white/black list from argument
Date: Fri, 11 Oct 2019 12:29:26 -0700
Message-ID: <20191011192933.13550-5-prestwoj@gmail.com>
In-Reply-To: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2019207058307248724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead we add getters for these lists that manager_init can use.
---
 src/iwd.h     |  6 ++++--
 src/main.c    | 12 +++++++++++-
 src/manager.c |  5 +++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/iwd.h b/src/iwd.h
index 7ae7e4b4..1fa1e25a 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -30,10 +30,12 @@ struct l_genl *iwd_get_genl(void);
 =

 void netdev_shutdown(void);
 =

-bool manager_init(struct l_genl_family *in,
-			const char *if_whitelist, const char *if_blacklist);
+bool manager_init(struct l_genl_family *in);
 void manager_exit(void);
 =

+const char *iwd_get_iface_whitelist(void);
+const char *iwd_get_iface_blacklist(void);
+
 struct iwd_module_desc {
 	const char *name;
 	int (*init)(void);
diff --git a/src/main.c b/src/main.c
index 08bf38a3..d4915412 100644
--- a/src/main.c
+++ b/src/main.c
@@ -102,6 +102,16 @@ struct l_genl *iwd_get_genl(void)
 	return genl;
 }
 =

+const char *iwd_get_iface_whitelist(void)
+{
+	return interfaces;
+}
+
+const char *iwd_get_iface_blacklist(void)
+{
+	return nointerfaces;
+}
+
 static void usage(void)
 {
 	printf("iwd - Wireless daemon\n"
@@ -154,7 +164,7 @@ static void nl80211_appeared(const struct l_genl_family=
_info *info,
 =

 	plugin_init(plugins, noplugins);
 =

-	manager_init(nl80211, interfaces, nointerfaces);
+	manager_init(nl80211);
 =

 	if (!wiphy_init(nl80211, phys, nophys))
 		l_error("Unable to init wiphy functionality");
diff --git a/src/manager.c b/src/manager.c
index 1a04b071..e731cf9d 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -584,14 +584,15 @@ static void manager_config_notify(struct l_genl_msg *=
msg, void *user_data)
 	}
 }
 =

-bool manager_init(struct l_genl_family *in,
-			const char *if_whitelist, const char *if_blacklist)
+bool manager_init(struct l_genl_family *in)
 {
 	const struct l_settings *config =3D iwd_get_config();
 	struct l_genl_msg *msg;
 	unsigned int wiphy_dump;
 	unsigned int interface_dump;
 	const char *randomize_str;
+	const char *if_whitelist =3D iwd_get_iface_whitelist();
+	const char *if_blacklist =3D iwd_get_iface_blacklist();
 =

 	nl80211 =3D in;
 =

-- =

2.17.1

--===============2019207058307248724==--

