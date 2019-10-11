Content-Type: multipart/mixed; boundary="===============2790782892189248068=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/12] manager: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 12:29:27 -0700
Message-ID: <20191011192933.13550-6-prestwoj@gmail.com>
In-Reply-To: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2790782892189248068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Converts manager into an IWD module.
---
 src/iwd.h     |  3 ---
 src/main.c    |  3 ---
 src/manager.c | 25 ++++++++++++++++++-------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/src/iwd.h b/src/iwd.h
index 1fa1e25a..8814c244 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -30,9 +30,6 @@ struct l_genl *iwd_get_genl(void);
 =

 void netdev_shutdown(void);
 =

-bool manager_init(struct l_genl_family *in);
-void manager_exit(void);
-
 const char *iwd_get_iface_whitelist(void);
 const char *iwd_get_iface_blacklist(void);
 =

diff --git a/src/main.c b/src/main.c
index d4915412..761d869e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -164,8 +164,6 @@ static void nl80211_appeared(const struct l_genl_family=
_info *info,
 =

 	plugin_init(plugins, noplugins);
 =

-	manager_init(nl80211);
-
 	if (!wiphy_init(nl80211, phys, nophys))
 		l_error("Unable to init wiphy functionality");
 }
@@ -500,7 +498,6 @@ int main(int argc, char *argv[])
 	eap_exit();
 =

 	if (nl80211) {
-		manager_exit();
 		wiphy_exit();
 		l_genl_family_free(nl80211);
 	}
diff --git a/src/manager.c b/src/manager.c
index e731cf9d..f1e50421 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -584,8 +584,9 @@ static void manager_config_notify(struct l_genl_msg *ms=
g, void *user_data)
 	}
 }
 =

-bool manager_init(struct l_genl_family *in)
+static int manager_init(void)
 {
+	struct l_genl *genl =3D iwd_get_genl();
 	const struct l_settings *config =3D iwd_get_config();
 	struct l_genl_msg *msg;
 	unsigned int wiphy_dump;
@@ -594,7 +595,7 @@ bool manager_init(struct l_genl_family *in)
 	const char *if_whitelist =3D iwd_get_iface_whitelist();
 	const char *if_blacklist =3D iwd_get_iface_blacklist();
 =

-	nl80211 =3D in;
+	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
 =

 	if (if_whitelist)
 		whitelist_filter =3D l_strsplit(if_whitelist, ',');
@@ -607,7 +608,7 @@ bool manager_init(struct l_genl_family *in)
 	if (!l_genl_family_register(nl80211, "config", manager_config_notify,
 					NULL, NULL)) {
 		l_error("Registering for config notifications failed");
-		return false;
+		goto error;
 	}
 =

 	msg =3D l_genl_msg_new_sized(NL80211_CMD_GET_WIPHY, 128);
@@ -618,7 +619,7 @@ bool manager_init(struct l_genl_family *in)
 	if (!wiphy_dump) {
 		l_error("Initial wiphy information dump failed");
 		l_genl_msg_unref(msg);
-		return false;
+		goto error;
 	}
 =

 	msg =3D l_genl_msg_new(NL80211_CMD_GET_INTERFACE);
@@ -630,7 +631,7 @@ bool manager_init(struct l_genl_family *in)
 		l_error("Initial interface information dump failed");
 		l_genl_msg_unref(msg);
 		l_genl_family_cancel(nl80211, wiphy_dump);
-		return false;
+		goto error;
 	}
 =

 	randomize_str =3D
@@ -638,10 +639,17 @@ bool manager_init(struct l_genl_family *in)
 	if (randomize_str && !strcmp(randomize_str, "once"))
 		randomize =3D true;
 =

-	return true;
+	return 0;
+
+error:
+	l_queue_destroy(pending_wiphys, NULL);
+	l_genl_family_free(nl80211);
+	nl80211 =3D NULL;
+
+	return -EIO;
 }
 =

-void manager_exit(void)
+static void manager_exit(void)
 {
 	l_strfreev(whitelist_filter);
 	l_strfreev(blacklist_filter);
@@ -649,6 +657,9 @@ void manager_exit(void)
 	l_queue_destroy(pending_wiphys, wiphy_setup_state_free);
 	pending_wiphys =3D NULL;
 =

+	l_genl_family_free(nl80211);
 	nl80211 =3D NULL;
 	randomize =3D false;
 }
+
+IWD_MODULE(manager, manager_init, manager_exit);
-- =

2.17.1

--===============2790782892189248068==--

