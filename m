Content-Type: multipart/mixed; boundary="===============3134622245312128334=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 07/10] dpp: support retransmitting frames with no ACK
Date: Tue, 11 Jan 2022 16:55:55 -0800
Message-ID: <20220112005558.1158405-7-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============3134622245312128334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The DPP spec says nothing about how to handle re-transmits but it
was found in testing this can happen relatively easily for a few
reasons.

If the configurator requests a channel switch but does not get onto
the new channel quick enough the enrollee may have already sent the
authenticate response and it was missed. Also by nature of how the
kernel goes offchannel there are moments in time between ROC when
the card is idle and not receiving any frames.

Only frames where there was no ACK will be retransmitted. If the
peer received the frame and dropped it resending the same frame wont
do any good.
---
 src/dpp.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index c22788e7..a4cc315b 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -52,6 +52,9 @@
 #include "src/scan.h"
 #include "src/network.h"
 #include "src/handshake.h"
+#include "src/nl80211util.h"
+
+#define DPP_FRAME_MAX_RETRIES 5
 =

 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -118,6 +121,9 @@ struct dpp_sm {
 =

 	struct dpp_configuration *config;
 	uint32_t connect_scan_id;
+	uint64_t frame_cookie;
+	uint32_t mlme_watch;
+	uint8_t frame_retry;
 =

 	struct l_dbus_message *message;
 };
@@ -174,6 +180,7 @@ static void dpp_reset(struct dpp_sm *dpp)
 =

 	dpp->state =3D DPP_STATE_NOTHING;
 	dpp->new_freq =3D 0;
+	dpp->frame_retry =3D 0;
 =

 	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
@@ -204,13 +211,26 @@ static void dpp_free(struct dpp_sm *dpp)
 		dpp->boot_private =3D NULL;
 	}
 =

+	if (dpp->mlme_watch) {
+		l_genl_family_unregister(nl80211, dpp->mlme_watch);
+		dpp->mlme_watch =3D 0;
+	}
+
 	l_free(dpp);
 }
 =

 static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
 {
-	if (l_genl_msg_get_error(msg) < 0)
+	struct dpp_sm *dpp =3D user_data;
+
+	if (l_genl_msg_get_error(msg) < 0) {
 		l_error("Error sending frame");
+		return;
+	}
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_COOKIE, &dpp->frame_cookie,
+				NL80211_ATTR_UNSPEC) < 0)
+		l_error("Error parsing frame cookie");
 }
 =

 static void dpp_send_frame(struct dpp_sm *dpp, struct iovec *iov, size_t i=
ov_len,
@@ -1575,6 +1595,76 @@ static void dpp_handle_frame(const struct mmpdu_head=
er *frame,
 	}
 }
 =

+static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+	uint64_t wdev_id =3D 0;
+	uint64_t cookie =3D 0;
+	bool ack =3D false;
+	struct l_genl_attr attr;
+	const void *data;
+	uint16_t len;
+	uint16_t type;
+	const void *frame =3D NULL;
+	uint16_t frame_len =3D 0;
+	struct iovec iov;
+	uint8_t cmd =3D l_genl_msg_get_command(msg);
+
+	if (cmd !=3D NL80211_CMD_FRAME_TX_STATUS)
+		return;
+
+	if (dpp->state <=3D DPP_STATE_PRESENCE)
+		return;
+
+	l_genl_attr_init(&attr, msg);
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_WDEV:
+			if (len !=3D 8)
+				return;
+
+			wdev_id =3D l_get_u64(data);
+			break;
+		case NL80211_ATTR_COOKIE:
+			if (len !=3D 8)
+				return;
+
+			cookie =3D l_get_u64(data);
+			break;
+		case NL80211_ATTR_ACK:
+			ack =3D true;
+			break;
+		case NL80211_ATTR_FRAME:
+			frame =3D data;
+			frame_len =3D len;
+			break;
+		}
+	}
+
+	/*
+	 * Only want to handle the no-ACK case. Re-transmitting an ACKed
+	 * frame likely wont do any good, at least in the case of DPP.
+	 */
+	if (dpp->wdev_id !=3D wdev_id || dpp->frame_cookie !=3D cookie ||
+				ack || !frame)
+		return;
+
+	if (dpp->frame_retry > DPP_FRAME_MAX_RETRIES) {
+		dpp_reset(dpp);
+		return;
+	}
+
+	iov.iov_base =3D (void *)frame;
+	iov.iov_len =3D frame_len;
+
+	l_debug("No ACK from peer, re-transmitting");
+
+	dpp->frame_retry++;
+
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
+}
+
 static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
@@ -1612,6 +1702,9 @@ static void dpp_create(struct netdev *netdev)
 				dpp_conf_request_prefix,
 				sizeof(dpp_conf_request_prefix),
 				dpp_handle_config_request_frame, dpp, NULL);
+
+	dpp->mlme_watch =3D l_genl_family_register(nl80211, "mlme",
+						dpp_mlme_notify, dpp, NULL);
 }
 =

 static void dpp_netdev_watch(struct netdev *netdev,
-- =

2.31.1

--===============3134622245312128334==--

