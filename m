Content-Type: multipart/mixed; boundary="===============1993892469962769524=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 6/8] netdev: start SA Query on channel switch event
Date: Tue, 19 Oct 2021 11:19:08 -0700
Message-ID: <20211019181910.558043-6-prestwoj@gmail.com>
In-Reply-To: 20211019181910.558043-1-prestwoj@gmail.com

--===============1993892469962769524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

802.11 requires an STA initiate the SA Query procedure on channel
switch events. This patch refactors sending the SA Query into its
own routine and starts the procedure when the channel switch event
comes in.

In addition the OCI needs to be verified, so the channel info is
parsed and set into the handshakes chandef.
---
 src/netdev.c | 171 +++++++++++++++++++++++++--------------------------
 1 file changed, 83 insertions(+), 88 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 11805ac0..7e2922b0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4872,6 +4872,77 @@ static int netdev_build_oci(struct netdev *netdev, u=
int8_t *out)
 	return oci_from_chandef(netdev->handshake->chandef, out + 3);
 }
 =

+static void netdev_sa_query_timeout(struct l_timeout *timeout,
+		void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+	struct l_genl_msg *msg;
+
+	l_info("SA Query timed out, connection is invalid.  Disconnecting...");
+
+	l_timeout_remove(netdev->sa_query_timeout);
+	netdev->sa_query_timeout =3D NULL;
+
+	msg =3D netdev_build_cmd_disconnect(netdev,
+			MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID);
+	netdev->disconnect_cmd_id =3D l_genl_family_send(nl80211, msg,
+			netdev_disconnect_cb, netdev, NULL);
+}
+
+static void netdev_sa_query_req_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+	int err =3D l_genl_msg_get_error(msg);
+	const char *ext_error;
+
+	if (err >=3D 0)
+		return;
+
+	ext_error =3D l_genl_msg_get_extended_error(msg);
+	l_debug("error sending SA Query request: %s",
+			ext_error ? ext_error : strerror(-err));
+
+	l_timeout_remove(netdev->sa_query_timeout);
+	netdev->sa_query_timeout =3D NULL;
+}
+
+static bool netdev_send_sa_query_request(struct netdev *netdev)
+{
+	uint8_t req[10];
+	uint8_t *ptr =3D req;
+
+	ptr[0] =3D 0x08; /* Category: SA Query */
+	ptr[1] =3D 0x00; /* SA Query Action: Request */
+
+	/* Transaction ID */
+	l_getrandom(ptr + 2, 2);
+
+	ptr +=3D 4;
+
+	if (netdev->handshake->supplicant_ocvc &&
+					netdev->handshake->authenticator_ocvc) {
+		if (netdev_build_oci(netdev, ptr) < 0) {
+			l_debug("Could not build OCI");
+			return false;
+		}
+
+		ptr +=3D 6;
+	}
+
+	if (!netdev_send_action_frame(netdev, netdev->handshake->aa, req,
+			ptr - req, netdev->frequency,
+			netdev_sa_query_req_cb, netdev)) {
+		l_error("error sending SA Query action frame");
+		return false;
+	}
+
+	netdev->sa_query_id =3D l_get_u16(req + 2);
+	netdev->sa_query_timeout =3D l_timeout_create(3,
+			netdev_sa_query_timeout, netdev, NULL);
+
+	return true;
+}
+
 static void netdev_sa_query_req_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
 					int rssi, void *user_data)
@@ -5029,40 +5100,6 @@ keep_alive:
 	netdev->sa_query_timeout =3D NULL;
 }
 =

-static void netdev_sa_query_req_cb(struct l_genl_msg *msg, void *user_data)
-{
-	struct netdev *netdev =3D user_data;
-	int err =3D l_genl_msg_get_error(msg);
-	const char *ext_error;
-
-	if (err >=3D 0)
-		return;
-
-	ext_error =3D l_genl_msg_get_extended_error(msg);
-	l_debug("error sending SA Query request: %s",
-			ext_error ? ext_error : strerror(-err));
-
-	l_timeout_remove(netdev->sa_query_timeout);
-	netdev->sa_query_timeout =3D NULL;
-}
-
-static void netdev_sa_query_timeout(struct l_timeout *timeout,
-		void *user_data)
-{
-	struct netdev *netdev =3D user_data;
-	struct l_genl_msg *msg;
-
-	l_info("SA Query timed out, connection is invalid.  Disconnecting...");
-
-	l_timeout_remove(netdev->sa_query_timeout);
-	netdev->sa_query_timeout =3D NULL;
-
-	msg =3D netdev_build_cmd_disconnect(netdev,
-			MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID);
-	netdev->disconnect_cmd_id =3D l_genl_family_send(nl80211, msg,
-			netdev_disconnect_cb, netdev, NULL);
-}
-
 static void netdev_unprot_disconnect_event(struct l_genl_msg *msg,
 		struct netdev *netdev)
 {
@@ -5071,8 +5108,6 @@ static void netdev_unprot_disconnect_event(struct l_g=
enl_msg *msg,
 	uint16_t type;
 	uint16_t len;
 	const void *data;
-	uint8_t action_frame[10];
-	uint8_t *ptr =3D action_frame;
 	uint8_t reason_code;
 =

 	if (!netdev->connected)
@@ -5116,35 +5151,7 @@ static void netdev_unprot_disconnect_event(struct l_=
genl_msg *msg,
 		return;
 	}
 =

-	ptr[0] =3D 0x08; /* Category: SA Query */
-	ptr[1] =3D 0x00; /* SA Query Action: Request */
-
-	/* Transaction ID */
-	l_getrandom(ptr + 2, 2);
-
-	ptr +=3D 4;
-
-	if (netdev->handshake->supplicant_ocvc &&
-					netdev->handshake->authenticator_ocvc) {
-		if (netdev_build_oci(netdev, ptr) < 0) {
-			l_debug("Could not build OCI");
-			return;
-		}
-
-		ptr +=3D 6;
-	}
-
-	if (!netdev_send_action_frame(netdev, netdev->handshake->aa,
-			action_frame, ptr - action_frame,
-			netdev->frequency,
-			netdev_sa_query_req_cb, netdev)) {
-		l_error("error sending SA Query action frame");
-		return;
-	}
-
-	netdev->sa_query_id =3D l_get_u16(action_frame + 2);
-	netdev->sa_query_timeout =3D l_timeout_create(3,
-			netdev_sa_query_timeout, netdev, NULL);
+	netdev_send_sa_query_request(netdev);
 }
 =

 static void netdev_station_event(struct l_genl_msg *msg,
@@ -5345,39 +5352,27 @@ failed:
 static void netdev_channel_switch_event(struct l_genl_msg *msg,
 					struct netdev *netdev)
 {
-	struct l_genl_attr attr;
-	uint16_t type, len;
-	const void *data;
-	uint32_t *freq =3D NULL;
-
-	l_debug("");
+	_auto_(l_free) struct band_chandef *chandef =3D
+						l_new(struct band_chandef, 1);
 =

-	if (!l_genl_attr_init(&attr, msg))
+	if (nl80211_parse_chandef(msg, chandef) < 0) {
+		l_debug("Couldn't parse operating channel info.");
 		return;
-
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		switch (type) {
-		case NL80211_ATTR_WIPHY_FREQ:
-			if (len !=3D 4)
-				continue;
-
-			freq =3D (uint32_t *) data;
-			break;
-		}
 	}
 =

-	if (!freq)
-		return;
+	netdev->frequency =3D chandef->frequency;
+
+	l_debug("Channel switch event, frequency: %u", netdev->frequency);
 =

-	l_debug("Channel switch event, frequency: %u", *freq);
+	handshake_state_set_chandef(netdev->handshake, l_steal_ptr(chandef));
 =

-	netdev->frequency =3D *freq;
+	netdev_send_sa_query_request(netdev);
 =

 	if (!netdev->event_filter)
 		return;
 =

-	netdev->event_filter(netdev, NETDEV_EVENT_CHANNEL_SWITCHED, freq,
-				netdev->user_data);
+	netdev->event_filter(netdev, NETDEV_EVENT_CHANNEL_SWITCHED,
+				&netdev->frequency, netdev->user_data);
 }
 =

 static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
-- =

2.31.1

--===============1993892469962769524==--

