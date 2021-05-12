Content-Type: multipart/mixed; boundary="===============4333214580816445979=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] netdev: handle multiple concurrent FT-over-DS action
 frames
Date: Wed, 12 May 2021 12:21:41 -0700
Message-ID: <20210512192144.348398-4-prestwoj@gmail.com>
In-Reply-To: <20210512192144.348398-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4333214580816445979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The beauty of FT-over-DS is that a station can send and receive
action frames to many APs to prepare for a future roam. Each
AP authenticates the station and when a roam happens the station
can immediately move to reassociation.

To handle this a queue of netdev_ft_over_ds_info structs is used
instead of a single entry. Using the new ft.c parser APIs these
info structs can be looked up when responses come in. For now
the timeouts/callbacks are kept but these will be removed as it
really does not matter if the AP sends a response (keeps station
happy until the next patch).
---
 src/netdev.c | 112 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 41 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 65627b9f..c194e78f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -169,7 +169,7 @@ struct netdev {
 	struct l_genl_msg *auth_cmd;
 	struct wiphy_radio_work_item work;
 =

-	struct netdev_ft_over_ds_info *ft_ds_info;
+	struct l_queue *ft_ds_list;
 =

 	bool connected : 1;
 	bool associated : 1;
@@ -687,6 +687,13 @@ static void netdev_preauth_destroy(void *data)
 	l_free(state);
 }
 =

+static void netdev_ft_ds_entry_free(void *data)
+{
+	struct netdev_ft_over_ds_info *info =3D data;
+
+	ft_ds_info_free(&info->super);
+}
+
 static void netdev_connect_free(struct netdev *netdev)
 {
 	if (netdev->work.id)
@@ -754,8 +761,10 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->disconnect_cmd_id =3D 0;
 	}
 =

-	if (netdev->ft_ds_info)
-		ft_ds_info_free(&netdev->ft_ds_info->super);
+	if (netdev->ft_ds_list) {
+		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
+		netdev->ft_ds_list =3D NULL;
+	}
 }
 =

 static void netdev_connect_failed(struct netdev *netdev,
@@ -854,6 +863,11 @@ static void netdev_free(void *data)
 		netdev->disconnect_idle =3D NULL;
 	}
 =

+	if (netdev->ft_ds_list) {
+		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
+		netdev->ft_ds_list =3D NULL;
+	}
+
 	if (netdev->events_ready)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 					netdev, NETDEV_WATCH_EVENT_DEL);
@@ -1286,6 +1300,11 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->fw_roam_bss =3D NULL;
 	}
 =

+	if (netdev->ft_ds_list) {
+		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
+		netdev->ft_ds_list =3D NULL;
+	}
+
 	if (netdev->connect_cb) {
 		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
 					netdev->user_data);
@@ -3442,12 +3461,6 @@ int netdev_reassociate(struct netdev *netdev, struct=
 scan_bss *target_bss,
 	if (err < 0)
 		return err;
 =

-	/* In case of a previous failed over-DS attempt */
-	if (netdev->ft_ds_info) {
-		ft_ds_info_free(&netdev->ft_ds_info->super);
-		netdev->ft_ds_info =3D NULL;
-	}
-
 	memcpy(netdev->prev_bssid, orig_bss->addr, ETH_ALEN);
 =

 	netdev->associated =3D false;
@@ -3676,12 +3689,6 @@ static int netdev_ft_tx_associate(struct iovec *ie_i=
ov, size_t iov_len,
 		return -EIO;
 	}
 =

-	/* No need to keep this around at this point */
-	if (netdev->ft_ds_info) {
-		ft_ds_info_free(&netdev->ft_ds_info->super);
-		netdev->ft_ds_info =3D NULL;
-	}
-
 	return 0;
 }
 =

@@ -3756,9 +3763,26 @@ static void netdev_ft_over_ds_auth_failed(struct net=
dev_ft_over_ds_info *info,
 	if (info->cb)
 		info->cb(info->netdev, status, info->super.aa, info->user_data);
 =

+	l_queue_remove(info->netdev->ft_ds_list, info);
 	ft_ds_info_free(&info->super);
+}
 =

-	info->netdev->ft_ds_info =3D NULL;
+struct ft_ds_finder {
+	const uint8_t *spa;
+	const uint8_t *aa;
+};
+
+static bool match_ft_ds_info(const void *a, const void *b)
+{
+	const struct netdev_ft_over_ds_info *info =3D a;
+	const struct ft_ds_finder *finder =3D b;
+
+	if (memcmp(info->super.spa, finder->spa, 6))
+		return false;
+	if (memcmp(info->super.aa, finder->aa, 6))
+		return false;
+
+	return true;
 }
 =

 static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
@@ -3766,41 +3790,41 @@ static void netdev_ft_response_frame_event(const st=
ruct mmpdu_header *hdr,
 					int rssi, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
-	struct netdev_ft_over_ds_info *info =3D netdev->ft_ds_info;
+	struct netdev_ft_over_ds_info *info;
 	int ret;
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
 	const uint8_t *aa;
 	const uint8_t *spa;
 	const uint8_t *ies;
 	size_t ies_len;
-
-	if (!info)
-		return;
+	struct ft_ds_finder finder;
 =

 	ret =3D ft_over_ds_parse_action_response(body, body_len, &spa, &aa,
 						&ies, &ies_len);
-	if (ret !=3D 0)
+	if (ret < 0)
 		return;
 =

-	if (memcmp(spa, info->super.spa, 6))
-		return;
-	if (memcmp(aa, info->super.aa, 6))
+	finder.spa =3D spa;
+	finder.aa =3D aa;
+
+	info =3D l_queue_find(netdev->ft_ds_list, match_ft_ds_info, &finder);
+	if (!info)
 		return;
 =

+	/* Lookup successful, now check the status code */
+	if (ret > 0) {
+		status_code =3D (uint16_t)ret;
+		goto ft_error;
+	}
+
 	ret =3D ft_over_ds_parse_action_ies(&info->super, netdev->handshake,
 						ies, ies_len);
 	if (ret < 0)
-		return;
+		goto ft_error;
 =

 	l_timeout_remove(info->timeout);
 	info->timeout =3D NULL;
 =

-	/* Now make sure the packet contained a success status code */
-	if (ret > 0) {
-		status_code =3D (uint16_t)ret;
-		goto ft_error;
-	}
-
 	info->parsed =3D true;
 =

 	if (info->cb)
@@ -3809,7 +3833,8 @@ static void netdev_ft_response_frame_event(const stru=
ct mmpdu_header *hdr,
 	return;
 =

 ft_error:
-	l_debug("FT-over-DS to "MAC" failed", MAC_STR(info->super.aa));
+	l_debug("FT-over-DS to "MAC" failed (%d)", MAC_STR(info->super.aa),
+			status_code);
 =

 	netdev_ft_over_ds_auth_failed(info, status_code);
 }
@@ -3887,10 +3912,8 @@ int netdev_fast_transition_over_ds(struct netdev *ne=
tdev,
 					struct scan_bss *target_bss,
 					netdev_connect_cb_t cb)
 {
-	struct netdev_ft_over_ds_info *info =3D netdev->ft_ds_info;
-
-	if (!info || !info->parsed)
-		return -ENOENT;
+	struct netdev_ft_over_ds_info *info;
+	struct ft_ds_finder finder;
 =

 	if (!netdev->operational)
 		return -ENOTCONN;
@@ -3900,6 +3923,14 @@ int netdev_fast_transition_over_ds(struct netdev *ne=
tdev,
 			l_get_le16(target_bss->mde))
 		return -EINVAL;
 =

+	finder.spa =3D netdev->addr;
+	finder.aa =3D target_bss->addr;
+
+	info =3D l_queue_find(netdev->ft_ds_list, match_ft_ds_info, &finder);
+
+	if (!info || !info->parsed)
+		return -ENOENT;
+
 	prepare_ft(netdev, target_bss);
 =

 	ft_over_ds_prepare_handshake(&info->super, netdev->handshake);
@@ -3963,10 +3994,6 @@ int netdev_fast_transition_over_ds_action(struct net=
dev *netdev,
 	uint8_t buf[512];
 	size_t len;
 =

-	/* TODO: Just allow single outstanding action frame for now */
-	if (netdev->ft_ds_info)
-		return -EALREADY;
-
 	if (!netdev->operational)
 		return -ENOTCONN;
 =

@@ -4005,7 +4032,10 @@ int netdev_fast_transition_over_ds_action(struct net=
dev *netdev,
 =

 	iovs[2].iov_base =3D NULL;
 =

-	netdev->ft_ds_info =3D info;
+	if (!netdev->ft_ds_list)
+		netdev->ft_ds_list =3D l_queue_new();
+
+	l_queue_push_head(netdev->ft_ds_list, info);
 =

 	info->timeout =3D l_timeout_create_ms(300, netdev_ft_over_ds_timeout,
 						info, NULL);
-- =

2.31.1

--===============4333214580816445979==--

