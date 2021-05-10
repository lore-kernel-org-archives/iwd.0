Content-Type: multipart/mixed; boundary="===============2654387925555886999=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/11] ap: Move sending CMD_START_AP to common function
Date: Mon, 10 May 2021 10:57:56 +0200
Message-ID: <20210510085806.174213-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2654387925555886999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 59 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index a0420ed1..8851cb85 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2260,34 +2260,41 @@ static struct l_genl_msg *ap_build_cmd_start_ap(str=
uct ap_state *ap)
 	return cmd;
 }
 =

-static void ap_ifaddr4_added_cb(int error, uint16_t type, const void *data,
-				uint32_t len, void *user_data)
+static bool ap_start_send(struct ap_state *ap)
 {
-	struct ap_state *ap =3D user_data;
-	struct l_genl_msg *cmd;
-
-	ap->rtnl_add_cmd =3D 0;
+	struct l_genl_msg *cmd =3D ap_build_cmd_start_ap(ap);
 =

-	if (error) {
-		l_error("Failed to set IP address");
-		goto error;
+	if (!cmd) {
+		l_error("ap_build_cmd_start_ap failed");
+		return false;
 	}
 =

-	cmd =3D ap_build_cmd_start_ap(ap);
-	if (!cmd)
-		goto error;
-
 	ap->start_stop_cmd_id =3D l_genl_family_send(ap->nl80211, cmd,
 							ap_start_cb, ap, NULL);
 	if (!ap->start_stop_cmd_id) {
+		l_error("AP_START l_genl_family_send failed");
 		l_genl_msg_unref(cmd);
-		goto error;
+		return false;
 	}
 =

-	return;
+	return true;
+}
 =

-error:
-	ap_start_failed(ap);
+static void ap_ifaddr4_added_cb(int error, uint16_t type, const void *data,
+				uint32_t len, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+
+	ap->rtnl_add_cmd =3D 0;
+
+	if (error) {
+		l_error("Failed to set IP address");
+		ap_start_failed(ap);
+		return;
+	}
+
+	if (!ap_start_send(ap))
+		ap_start_failed(ap);
 }
 =

 static bool ap_parse_new_station_ies(const void *data, uint16_t len,
@@ -2858,7 +2865,6 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct l_settings *config,
 {
 	struct ap_state *ap;
 	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
-	struct l_genl_msg *cmd;
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
 	int err =3D -EINVAL;
 	bool wait_on_address =3D false;
@@ -2949,22 +2955,13 @@ struct ap_state *ap_start(struct netdev *netdev, st=
ruct l_settings *config,
 		return ap;
 	}
 =

-	cmd =3D ap_build_cmd_start_ap(ap);
-	if (!cmd)
-		goto error;
+	if (ap_start_send(ap)) {
+		if (err_out)
+			*err_out =3D 0;
 =

-	ap->start_stop_cmd_id =3D l_genl_family_send(ap->nl80211, cmd,
-							ap_start_cb, ap, NULL);
-	if (!ap->start_stop_cmd_id) {
-		l_genl_msg_unref(cmd);
-		goto error;
+		return ap;
 	}
 =

-	if (err_out)
-		*err_out =3D 0;
-
-	return ap;
-
 error:
 	if (err_out)
 		*err_out =3D err;
-- =

2.27.0

--===============2654387925555886999==--

