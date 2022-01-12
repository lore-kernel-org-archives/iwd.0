Content-Type: multipart/mixed; boundary="===============6498931876029337742=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/7] dpp: support retransmitting frames with no ACK
Date: Wed, 12 Jan 2022 10:08:40 -0800
Message-ID: <20220112180845.1240661-2-prestwoj@gmail.com>
In-Reply-To: 20220112180845.1240661-1-prestwoj@gmail.com

--===============6498931876029337742==
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
 src/dpp.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index 17d0bd90..5f24de57 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -52,10 +52,15 @@
 #include "src/scan.h"
 #include "src/network.h"
 #include "src/handshake.h"
+#include "src/nl80211util.h"
+
+#define DPP_FRAME_MAX_RETRIES 5
 =

 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
 static uint8_t broadcast[] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+static struct l_queue *dpp_list;
+static uint32_t mlme_watch;
 =

 enum dpp_state {
 	DPP_STATE_NOTHING,
@@ -118,6 +123,8 @@ struct dpp_sm {
 =

 	struct dpp_configuration *config;
 	uint32_t connect_scan_id;
+	uint64_t frame_cookie;
+	uint8_t frame_retry;
 =

 	struct l_dbus_message *pending;
 };
@@ -174,6 +181,8 @@ static void dpp_reset(struct dpp_sm *dpp)
 =

 	dpp->state =3D DPP_STATE_NOTHING;
 	dpp->new_freq =3D 0;
+	dpp->frame_retry =3D 0;
+	dpp->frame_cookie =3D 0;
 =

 	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
@@ -209,8 +218,16 @@ static void dpp_free(struct dpp_sm *dpp)
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

 static void dpp_send_frame(struct dpp_sm *dpp,
@@ -1576,6 +1593,59 @@ static void dpp_handle_frame(const struct mmpdu_head=
er *frame,
 	}
 }
 =

+static bool match_wdev(const void *a, const void *b)
+{
+	const struct dpp_sm *dpp =3D a;
+	const uint64_t *wdev_id =3D b;
+
+	return *wdev_id =3D=3D dpp->wdev_id;
+}
+
+static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct dpp_sm *dpp;
+	uint64_t wdev_id =3D 0;
+	uint64_t cookie =3D 0;
+	bool ack =3D false;
+	struct iovec iov;
+	uint8_t cmd =3D l_genl_msg_get_command(msg);
+
+	if (cmd !=3D NL80211_CMD_FRAME_TX_STATUS)
+		return;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_WDEV, &wdev_id,
+				NL80211_ATTR_COOKIE, &cookie,
+				NL80211_ATTR_ACK, &ack,
+				NL80211_ATTR_FRAME, &iov,
+				NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	dpp =3D l_queue_find(dpp_list, match_wdev, &wdev_id);
+	if (!dpp)
+		return;
+
+	if (dpp->state <=3D DPP_STATE_PRESENCE)
+		return;
+
+	/*
+	 * Only want to handle the no-ACK case. Re-transmitting an ACKed
+	 * frame likely wont do any good, at least in the case of DPP.
+	 */
+	if (dpp->frame_cookie !=3D cookie || ack)
+		return;
+
+	if (dpp->frame_retry > DPP_FRAME_MAX_RETRIES) {
+		dpp_reset(dpp);
+		return;
+	}
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
@@ -1613,6 +1683,8 @@ static void dpp_create(struct netdev *netdev)
 				dpp_conf_request_prefix,
 				sizeof(dpp_conf_request_prefix),
 				dpp_handle_config_request_frame, dpp, NULL);
+
+	l_queue_push_tail(dpp_list, dpp);
 }
 =

 static void dpp_netdev_watch(struct netdev *netdev,
@@ -1819,6 +1891,8 @@ static void dpp_destroy_interface(void *user_data)
 {
 	struct dpp_sm *dpp =3D user_data;
 =

+	l_queue_remove(dpp_list, dpp);
+
 	dpp_free(dpp);
 }
 =

@@ -1835,6 +1909,12 @@ static int dpp_init(void)
 	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_INTERFACE,
 					dpp_setup_interface,
 					dpp_destroy_interface, false);
+
+	mlme_watch =3D l_genl_family_register(nl80211, "mlme", dpp_mlme_notify,
+						NULL, NULL);
+
+	dpp_list =3D l_queue_new();
+
 	return 0;
 }
 =

@@ -1843,6 +1923,11 @@ static void dpp_exit(void)
 	l_debug("");
 =

 	netdev_watch_remove(netdev_watch);
+
+	l_genl_family_unregister(nl80211, mlme_watch);
+	mlme_watch =3D 0;
+
+	l_queue_destroy(dpp_list, (l_queue_destroy_func_t) dpp_free);
 }
 =

 IWD_MODULE(dpp, dpp_init, dpp_exit);
-- =

2.31.1

--===============6498931876029337742==--

