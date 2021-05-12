Content-Type: multipart/mixed; boundary="===============8025913158181437709=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/11] netdev: remove callback/userdata/timeout from
 FT-over-DS action
Date: Wed, 12 May 2021 14:46:06 -0700
Message-ID: <20210512214610.361080-7-prestwoj@gmail.com>
In-Reply-To: <20210512214610.361080-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8025913158181437709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since netdev maintains the list of FT over DS info structs there is not
any need for station to get callbacks when the initial action frame
is received, or not. This removes the need for the callback handler,
user data, and response timeout.
---
 src/netdev.c  | 38 +-------------------------------------
 src/netdev.h  |  4 +---
 src/station.c |  2 +-
 3 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index c194e78f..55a63dd2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -95,9 +95,6 @@ struct netdev_handshake_state {
 struct netdev_ft_over_ds_info {
 	struct ft_ds_info super;
 	struct netdev *netdev;
-	struct l_timeout *timeout;
-	netdev_ft_over_ds_cb_t cb;
-	void *user_data;
 =

 	bool parsed : 1;
 };
@@ -3760,9 +3757,6 @@ static void prepare_ft(struct netdev *netdev, struct =
scan_bss *target_bss)
 static void netdev_ft_over_ds_auth_failed(struct netdev_ft_over_ds_info *i=
nfo,
 						uint16_t status)
 {
-	if (info->cb)
-		info->cb(info->netdev, status, info->super.aa, info->user_data);
-
 	l_queue_remove(info->netdev->ft_ds_list, info);
 	ft_ds_info_free(&info->super);
 }
@@ -3822,14 +3816,8 @@ static void netdev_ft_response_frame_event(const str=
uct mmpdu_header *hdr,
 	if (ret < 0)
 		goto ft_error;
 =

-	l_timeout_remove(info->timeout);
-	info->timeout =3D NULL;
-
 	info->parsed =3D true;
 =

-	if (info->cb)
-		info->cb(netdev, 0, info->super.aa, info->user_data);
-
 	return;
 =

 ft_error:
@@ -3958,34 +3946,16 @@ static void netdev_ft_request_cb(struct l_genl_msg =
*msg, void *user_data)
 	}
 }
 =

-static void netdev_ft_over_ds_timeout(struct l_timeout *timeout,
-					void *user_data)
-{
-	struct netdev_ft_over_ds_info *info =3D user_data;
-
-	l_timeout_remove(info->timeout);
-	info->timeout =3D NULL;
-
-	l_debug("");
-
-	netdev_ft_over_ds_auth_failed(info, MMPDU_STATUS_CODE_UNSPECIFIED);
-}
-
 static void netdev_ft_ds_info_free(struct ft_ds_info *ft)
 {
 	struct netdev_ft_over_ds_info *info =3D l_container_of(ft,
 					struct netdev_ft_over_ds_info, super);
 =

-	if (info->timeout)
-		l_timeout_remove(info->timeout);
-
 	l_free(info);
 }
 =

 int netdev_fast_transition_over_ds_action(struct netdev *netdev,
-					const struct scan_bss *target_bss,
-					netdev_ft_over_ds_cb_t cb,
-					void *user_data)
+					const struct scan_bss *target_bss)
 {
 	struct netdev_ft_over_ds_info *info;
 	uint8_t ft_req[14];
@@ -4013,9 +3983,6 @@ int netdev_fast_transition_over_ds_action(struct netd=
ev *netdev,
 	l_getrandom(info->super.snonce, 32);
 	info->super.free =3D netdev_ft_ds_info_free;
 =

-	info->cb =3D cb;
-	info->user_data =3D user_data;
-
 	ft_req[0] =3D 6; /* FT category */
 	ft_req[1] =3D 1; /* FT Request action */
 	memcpy(ft_req + 2, netdev->addr, 6);
@@ -4037,9 +4004,6 @@ int netdev_fast_transition_over_ds_action(struct netd=
ev *netdev,
 =

 	l_queue_push_head(netdev->ft_ds_list, info);
 =

-	info->timeout =3D l_timeout_create_ms(300, netdev_ft_over_ds_timeout,
-						info, NULL);
-
 	netdev_send_action_framev(netdev, netdev->handshake->aa, iovs, 2,
 					netdev->frequency,
 					netdev_ft_request_cb,
diff --git a/src/netdev.h b/src/netdev.h
index 987504f6..f625957b 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -163,9 +163,7 @@ int netdev_reassociate(struct netdev *netdev, struct sc=
an_bss *target_bss,
 int netdev_fast_transition(struct netdev *netdev, struct scan_bss *target_=
bss,
 				netdev_connect_cb_t cb);
 int netdev_fast_transition_over_ds_action(struct netdev *netdev,
-					const struct scan_bss *target_bss,
-					netdev_ft_over_ds_cb_t cb,
-					void *user_data);
+					const struct scan_bss *target_bss);
 int netdev_fast_transition_over_ds(struct netdev *netdev,
 					struct scan_bss *target_bss,
 					netdev_connect_cb_t cb);
diff --git a/src/station.c b/src/station.c
index 4407cd74..f64d352f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2492,7 +2492,7 @@ static void station_ft_ds_action_start(struct station=
 *station)
 		*/
 		if (station_can_fast_transition(hs, bss))
 			netdev_fast_transition_over_ds_action(station->netdev,
-							bss, NULL, NULL);
+							bss);
 	}
 }
 =

-- =

2.31.1

--===============8025913158181437709==--

