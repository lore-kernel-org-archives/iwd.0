Content-Type: multipart/mixed; boundary="===============4889821231264760782=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 06/10] dpp: pass dpp_sm to dpp_send_frame
Date: Tue, 11 Jan 2022 16:55:54 -0800
Message-ID: <20220112005558.1158405-6-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============4889821231264760782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SM has the wdev_id already, so rather than using that or looking
up just pass the dpp_sm directly.
---
 src/dpp.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index e0ae8aa6..c22788e7 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -213,20 +213,20 @@ static void dpp_send_frame_cb(struct l_genl_msg *msg,=
 void *user_data)
 		l_error("Error sending frame");
 }
 =

-static void dpp_send_frame(uint64_t wdev_id, struct iovec *iov, size_t iov=
_len,
+static void dpp_send_frame(struct dpp_sm *dpp, struct iovec *iov, size_t i=
ov_len,
 			uint32_t freq)
 {
 	struct l_genl_msg *msg;
 =

 	msg =3D l_genl_msg_new_sized(NL80211_CMD_FRAME, 512);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &dpp->wdev_id);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &freq);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_OFFCHANNEL_TX_OK, 0, NULL);
 	l_genl_msg_append_attrv(msg, NL80211_ATTR_FRAME, iov, iov_len);
 =

 	l_debug("Sending frame on frequency %u", freq);
 =

-	if (!l_genl_family_send(nl80211, msg, dpp_send_frame_cb, NULL, NULL)) {
+	if (!l_genl_family_send(nl80211, msg, dpp_send_frame_cb, dpp, NULL)) {
 		l_error("Could not send CMD_FRAME");
 		l_genl_msg_unref(msg);
 	}
@@ -378,7 +378,7 @@ static void dpp_configuration_start(struct dpp_sm *dpp,=
 const uint8_t *addr)
 =

 	dpp->state =3D DPP_STATE_CONFIGURING;
 =

-	dpp_send_frame(dpp->wdev_id, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 =

 static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
@@ -401,7 +401,7 @@ static void send_config_result(struct dpp_sm *dpp, cons=
t uint8_t *to)
 	iov[1].iov_base =3D attrs;
 	iov[1].iov_len =3D ptr - attrs;
 =

-	dpp_send_frame(dpp->wdev_id, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 =

 static void dpp_write_config(struct dpp_configuration *config,
@@ -730,7 +730,7 @@ static void dpp_send_config_response(struct dpp_sm *dpp=
, uint8_t status)
 	iov[1].iov_base =3D attrs;
 	iov[1].iov_len =3D ptr - attrs;
 =

-	dpp_send_frame(dpp->wdev_id, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 =

 static void dpp_handle_config_request_frame(const struct mmpdu_header *fra=
me,
@@ -1033,8 +1033,7 @@ static void send_authenticate_response(struct dpp_sm =
*dpp)
 	iov[1].iov_base =3D attrs;
 	iov[1].iov_len =3D ptr - attrs;
 =

-	dpp_send_frame(netdev_get_wdev_id(dpp->netdev), iov, 2,
-				dpp->current_freq);
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 =

 static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
@@ -1200,8 +1199,7 @@ static void dpp_auth_request_failed(struct dpp_sm *dp=
p,
 	iov[1].iov_base =3D attrs;
 	iov[1].iov_len =3D ptr - attrs;
 =

-	dpp_send_frame(netdev_get_wdev_id(dpp->netdev), iov, 2,
-				dpp->current_freq);
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 =

 static bool dpp_check_roles(struct dpp_sm *dpp, uint8_t peer_capa)
@@ -1241,7 +1239,7 @@ static void dpp_presence_announce(struct dpp_sm *dpp)
 	l_debug("Sending presense annoucement on frequency %u and waiting %u",
 		dpp->current_freq, dpp->dwell);
 =

-	dpp_send_frame(netdev_get_wdev_id(netdev), iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 =

 static void dpp_roc_started(void *user_data)
-- =

2.31.1

--===============4889821231264760782==--

