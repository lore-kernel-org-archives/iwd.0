Content-Type: multipart/mixed; boundary="===============5871612757291631462=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] netdev: add user_data to netdev_send_action_frame[v]
Date: Tue, 27 Apr 2021 12:49:39 -0700
Message-ID: <20210427194945.49731-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5871612757291631462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes this internal API a bit more usable by removing the
restriction of always having netdev as the user_data.
---
 src/netdev.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 1190399d..2dae07df 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3524,7 +3524,8 @@ static uint32_t netdev_send_action_framev(struct netd=
ev *netdev,
 					const uint8_t *to,
 					struct iovec *iov, size_t iov_len,
 					uint32_t freq,
-					l_genl_msg_func_t callback)
+					l_genl_msg_func_t callback,
+					void *user_data)
 {
 	uint32_t id;
 	struct l_genl_msg *msg =3D nl80211_build_cmd_frame(netdev->index,
@@ -3532,7 +3533,7 @@ static uint32_t netdev_send_action_framev(struct netd=
ev *netdev,
 								to, freq,
 								iov, iov_len);
 =

-	id =3D l_genl_family_send(nl80211, msg, callback, netdev, NULL);
+	id =3D l_genl_family_send(nl80211, msg, callback, user_data, NULL);
 =

 	if (!id)
 		l_genl_msg_unref(msg);
@@ -3544,14 +3545,16 @@ static uint32_t netdev_send_action_frame(struct net=
dev *netdev,
 					const uint8_t *to,
 					const uint8_t *body, size_t body_len,
 					uint32_t freq,
-					l_genl_msg_func_t callback)
+					l_genl_msg_func_t callback,
+					void *user_data)
 {
 	struct iovec iov[1];
 =

 	iov[0].iov_base =3D (void *)body;
 	iov[0].iov_len =3D body_len;
 =

-	return netdev_send_action_framev(netdev, to, iov, 1, freq, callback);
+	return netdev_send_action_framev(netdev, to, iov, 1, freq, callback,
+						user_data);
 }
 =

 static void netdev_cmd_authenticate_ft_cb(struct l_genl_msg *msg,
@@ -3754,7 +3757,8 @@ static void netdev_ft_over_ds_tx_authenticate(struct =
iovec *iov,
 =

 	netdev_send_action_framev(netdev, netdev->prev_bssid, iovs, iov_len + 1,
 					netdev->prev_frequency,
-					netdev_ft_request_cb);
+					netdev_ft_request_cb,
+					netdev);
 }
 =

 static bool netdev_ft_work_ready(struct wiphy_radio_work_item *item)
@@ -3920,7 +3924,8 @@ int netdev_neighbor_report_req(struct netdev *netdev,
 	if (!netdev_send_action_frame(netdev, netdev->handshake->aa,
 					action_frame, sizeof(action_frame),
 					netdev->frequency,
-					netdev_neighbor_report_req_cb))
+					netdev_neighbor_report_req_cb,
+					netdev))
 		return -EIO;
 =

 	netdev->neighbor_report_cb =3D cb;
@@ -4007,7 +4012,7 @@ static void netdev_sa_query_req_frame_event(const str=
uct mmpdu_header *hdr,
 	if (!netdev_send_action_frame(netdev, netdev->handshake->aa,
 			sa_resp, sizeof(sa_resp),
 			netdev->frequency,
-			netdev_sa_query_resp_cb)) {
+			netdev_sa_query_resp_cb, netdev)) {
 		l_error("error sending SA Query response");
 		return;
 	}
@@ -4146,7 +4151,7 @@ static void netdev_unprot_disconnect_event(struct l_g=
enl_msg *msg,
 	if (!netdev_send_action_frame(netdev, netdev->handshake->aa,
 			action_frame, sizeof(action_frame),
 			netdev->frequency,
-			netdev_sa_query_req_cb)) {
+			netdev_sa_query_req_cb, netdev)) {
 		l_error("error sending SA Query action frame");
 		return;
 	}
-- =

2.26.2

--===============5871612757291631462==--

