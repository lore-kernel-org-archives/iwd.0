Content-Type: multipart/mixed; boundary="===============0798145186581726155=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/12] netdev: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 12:29:23 -0700
Message-ID: <20191011192933.13550-2-prestwoj@gmail.com>
In-Reply-To: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0798145186581726155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since iwd_modules_init is now defered until nl80211_appeared, we can
assume the nl80211 object is available. This removes the need for
netdev_set_nl80211 completely.
---
 src/iwd.h    |  3 ---
 src/main.c   |  8 +-------
 src/netdev.c | 25 +++++++++++++------------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/src/iwd.h b/src/iwd.h
index 8bb4f64f..7ae7e4b4 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -28,9 +28,6 @@ struct l_genl_family;
 const struct l_settings *iwd_get_config(void);
 struct l_genl *iwd_get_genl(void);
 =

-bool netdev_init(void);
-void netdev_exit(void);
-void netdev_set_nl80211(struct l_genl_family *nl80211);
 void netdev_shutdown(void);
 =

 bool manager_init(struct l_genl_family *in,
diff --git a/src/main.c b/src/main.c
index 0e6fad14..4ff5f010 100644
--- a/src/main.c
+++ b/src/main.c
@@ -159,8 +159,6 @@ static void nl80211_appeared(const struct l_genl_family=
_info *info,
 =

 	if (!wiphy_init(nl80211, phys, nophys))
 		l_error("Unable to init wiphy functionality");
-
-	netdev_set_nl80211(nl80211);
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
@@ -486,15 +484,11 @@ int main(int argc, char *argv[])
 	eap_init(eap_mtu);
 	eapol_init();
 =

-	if (!netdev_init())
-		goto fail_netdev;
-
 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
 	plugin_exit();
 =

 	iwd_modules_exit();
-	netdev_exit();
-fail_netdev:
+
 	eapol_exit();
 	eap_exit();
 =

diff --git a/src/netdev.c b/src/netdev.c
index 773f0795..1828f5d0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4755,20 +4755,22 @@ bool netdev_watch_remove(uint32_t id)
 	return watchlist_remove(&netdev_watches, id);
 }
 =

-bool netdev_init(void)
+static int netdev_init(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
 	const struct l_settings *settings =3D iwd_get_config();
 =

+	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
+
 	if (rtnl)
-		return false;
+		return -EALREADY;
 =

 	l_debug("Opening route netlink socket");
 =

 	rtnl =3D l_netlink_new(NETLINK_ROUTE);
 	if (!rtnl) {
 		l_error("Failed to open route netlink socket");
-		return false;
+		return -EIO;
 	}
 =

 	if (getenv("IWD_RTNL_DEBUG"))
@@ -4778,7 +4780,7 @@ bool netdev_init(void)
 				netdev_link_notify, NULL, NULL)) {
 		l_error("Failed to register for RTNL link notifications");
 		l_netlink_destroy(rtnl);
-		return false;
+		return -EIO;
 	}
 =

 	if (!l_settings_get_int(settings, "General", "roam_rssi_threshold",
@@ -4801,19 +4803,14 @@ bool netdev_init(void)
 	if (!unicast_watch)
 		l_error("Registering for unicast notification failed");
 =

-	return true;
-}
-
-void netdev_set_nl80211(struct l_genl_family *in)
-{
-	nl80211 =3D in;
-
 	if (!l_genl_family_register(nl80211, "mlme", netdev_mlme_notify,
 								NULL, NULL))
 		l_error("Registering for MLME notification failed");
+
+	return 0;
 }
 =

-void netdev_exit(void)
+static void netdev_exit(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
 =

@@ -4823,6 +4820,8 @@ void netdev_exit(void)
 	l_genl_remove_unicast_watch(genl, unicast_watch);
 =

 	watchlist_destroy(&netdev_watches);
+
+	l_genl_family_free(nl80211);
 	nl80211 =3D NULL;
 =

 	l_debug("Closing route netlink socket");
@@ -4840,3 +4839,5 @@ void netdev_shutdown(void)
 	l_queue_destroy(netdev_list, netdev_free);
 	netdev_list =3D NULL;
 }
+
+IWD_MODULE(netdev, netdev_init, netdev_exit);
-- =

2.17.1

--===============0798145186581726155==--

