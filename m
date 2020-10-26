Content-Type: multipart/mixed; boundary="===============8089394326937846554=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 3/6] ap: add error out param to ap_start
Date: Mon, 26 Oct 2020 11:05:41 -0700
Message-ID: <20201026180544.2130802-3-prestwoj@gmail.com>
In-Reply-To: <20201026180544.2130802-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8089394326937846554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows the caller to extract a bit more information about what
exactly went wrong.
---
 src/ap.c  | 18 +++++++++++++++---
 src/ap.h  |  3 ++-
 src/p2p.c |  2 +-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 3c4ae907..b10b65ae 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2033,12 +2033,17 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
  * to by its members (which also can't be static).
  */
 struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
-				const struct ap_ops *ops, void *user_data)
+				const struct ap_ops *ops, int *err_out,
+				void *user_data)
 {
 	struct ap_state *ap;
 	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
 	struct l_genl_msg *cmd;
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
+	int err =3D -EINVAL;
+
+	if (err_out)
+		*err_out =3D err;
 =

 	if (L_WARN_ON(!config->ssid))
 		return NULL;
@@ -2146,9 +2151,15 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 		goto error;
 	}
 =

+	if (err_out)
+		*err_out =3D 0;
+
 	return ap;
 =

 error:
+	if (err_out)
+		*err_out =3D err;
+
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
 	l_free(ap);
@@ -2382,6 +2393,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 	struct ap_if_data *ap_if =3D user_data;
 	const char *ssid, *wpa2_passphrase;
 	struct ap_config *config;
+	int err;
 =

 	if (ap_if->ap && ap_if->ap->started)
 		return dbus_error_already_exists(message);
@@ -2398,10 +2410,10 @@ static struct l_dbus_message *ap_dbus_start(struct =
l_dbus *dbus,
 	l_strlcpy(config->passphrase, wpa2_passphrase,
 			sizeof(config->passphrase));
 =

-	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, ap_if);
+	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err, ap_if);
 	if (!ap_if->ap) {
 		ap_config_free(config);
-		return dbus_error_invalid_args(message);
+		return dbus_error_from_errno(err, message);
 	}
 =

 	ap_if->pending =3D l_dbus_message_ref(message);
diff --git a/src/ap.h b/src/ap.h
index a39797aa..1f2d438a 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -74,7 +74,8 @@ struct ap_ops {
 void ap_config_free(struct ap_config *config);
 =

 struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
-				const struct ap_ops *ops, void *user_data);
+				const struct ap_ops *ops, int *err,
+				void *user_data);
 void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
 			void *user_data);
 void ap_free(struct ap_state *ap);
diff --git a/src/p2p.c b/src/p2p.c
index 417ce3d6..6932033c 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -754,7 +754,7 @@ static void p2p_group_start(struct p2p_device *dev)
 	dev->capability.group_caps |=3D P2P_GROUP_CAP_GO;
 	dev->capability.group_caps |=3D P2P_GROUP_CAP_GROUP_FORMATION;
 =

-	dev->group =3D ap_start(dev->conn_netdev, config, &p2p_go_ops, dev);
+	dev->group =3D ap_start(dev->conn_netdev, config, &p2p_go_ops, NULL, dev);
 	if (!dev->group) {
 		ap_config_free(config);
 		p2p_connect_failed(dev);
-- =

2.26.2

--===============8089394326937846554==--

