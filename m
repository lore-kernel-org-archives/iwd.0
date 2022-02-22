Content-Type: multipart/mixed; boundary="===============6027198888801762320=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v6 3/9] dpp: manually register for some frame watches
Date: Tue, 22 Feb 2022 14:02:26 -0800
Message-ID: <20220222220232.2475972-3-prestwoj@gmail.com>
In-Reply-To: 20220222220232.2475972-1-prestwoj@gmail.com

--===============6027198888801762320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The frame watch which covers the presence procedure (and most
frames for that matter) needs to support multicast frames for
presence to work. Doing this in frame-xchg seems like the right
choice but only ath9k supports multicast frame registration.
Because of this limited support DPP will register for these frames
manually.
---
 src/dpp.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 7 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index cedf5bfe..17c7425a 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -61,6 +61,7 @@ static struct l_genl_family *nl80211;
 static uint8_t broadcast[] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 static struct l_queue *dpp_list;
 static uint32_t mlme_watch;
+static uint32_t unicast_watch;
 =

 enum dpp_state {
 	DPP_STATE_NOTHING,
@@ -127,6 +128,8 @@ struct dpp_sm {
 	uint8_t frame_retry;
 =

 	struct l_dbus_message *pending;
+
+	bool mcast_support : 1;
 };
 =

 static void dpp_free_auth_data(struct dpp_sm *dpp)
@@ -1403,6 +1406,9 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 	const void *ad1 =3D body + 8;
 	uint32_t freq;
 =

+	if (util_is_broadcast_address(from))
+		return;
+
 	if (dpp->state !=3D DPP_STATE_PRESENCE)
 		return;
 =

@@ -1577,11 +1583,10 @@ auth_request_failed:
 	dpp_free_auth_data(dpp);
 }
 =

-static void dpp_handle_frame(const struct mmpdu_header *frame,
-				const void *body, size_t body_len,
-				int rssi, void *user_data)
+static void dpp_handle_frame(struct dpp_sm *dpp,
+				const struct mmpdu_header *frame,
+				const void *body, size_t body_len)
 {
-	struct dpp_sm *dpp =3D user_data;
 	const uint8_t *ptr;
 =

 	/*
@@ -1664,6 +1669,94 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 =

+static void dpp_unicast_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct dpp_sm *dpp;
+	const uint64_t *wdev_id =3D NULL;
+	struct l_genl_attr attr;
+	uint16_t type, len, frame_len;
+	const void *data;
+	const struct mmpdu_header *mpdu =3D NULL;
+	const uint8_t *body;
+
+	if (l_genl_msg_get_command(msg) !=3D NL80211_CMD_FRAME)
+		return;
+
+	if (!l_genl_attr_init(&attr, msg))
+		return;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_WDEV:
+			if (len !=3D 8)
+				break;
+
+			wdev_id =3D data;
+			break;
+
+		case NL80211_ATTR_FRAME:
+			mpdu =3D mpdu_validate(data, len);
+			if (!mpdu) {
+				l_warn("Frame didn't validate as MMPDU");
+				return;
+			}
+
+			frame_len =3D len;
+			break;
+		}
+	}
+
+	if (!wdev_id) {
+		l_warn("Bad wdev attribute");
+		return;
+	}
+
+	dpp =3D l_queue_find(dpp_list, match_wdev, wdev_id);
+	if (!dpp)
+		return;
+
+	if (!mpdu) {
+		l_warn("Missing frame data");
+		return;
+	}
+
+	body =3D mmpdu_body(mpdu);
+
+	dpp_handle_frame(dpp, mpdu, body,
+				(const uint8_t *) mpdu + frame_len - body);
+}
+
+static void dpp_frame_watch_cb(struct l_genl_msg *msg, void *user_data)
+{
+	if (l_genl_msg_get_error(msg) < 0)
+		l_error("Could not register frame watch type %04x: %i",
+			L_PTR_TO_UINT(user_data), l_genl_msg_get_error(msg));
+}
+
+/*
+ * Special case the frame watch which includes the presence frames since t=
hey
+ * require multicast support. This is only supported by ath9k, so adding
+ * general support to frame-xchg isn't desireable.
+ */
+static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
+				const uint8_t *prefix, size_t prefix_len)
+{
+	struct l_genl_msg *msg;
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_REGISTER_FRAME, 32 + prefix_len);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &dpp->wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
+				prefix_len, prefix);
+	if (dpp->mcast_support)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_RECEIVE_MULTICAST,
+					0, NULL);
+
+	l_genl_family_send(nl80211, msg, dpp_frame_watch_cb,
+					L_UINT_TO_PTR(frame_type), NULL);
+}
+
 static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
@@ -1678,6 +1771,9 @@ static void dpp_create(struct netdev *netdev)
 	dpp->curve =3D l_ecc_curve_from_ike_group(19);
 	dpp->key_len =3D l_ecc_curve_get_scalar_bytes(dpp->curve);
 	dpp->nonce_len =3D dpp_nonce_len_from_key_len(dpp->key_len);
+	dpp->mcast_support =3D wiphy_has_ext_feature(
+				wiphy_find_by_wdev(dpp->wdev_id),
+				NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 =

 	l_ecdh_generate_key_pair(dpp->curve, &dpp->boot_private,
 					&dpp->boot_public);
@@ -1690,9 +1786,8 @@ static void dpp_create(struct netdev *netdev)
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
 =

-	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0, dpp_prefix,
-				sizeof(dpp_prefix), dpp_handle_frame,
-				dpp, NULL);
+	dpp_frame_watch(dpp, 0x00d0, dpp_prefix, sizeof(dpp_prefix));
+
 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
 				dpp_conf_response_prefix,
 				sizeof(dpp_conf_response_prefix),
@@ -1935,6 +2030,11 @@ static int dpp_init(void)
 	mlme_watch =3D l_genl_family_register(nl80211, "mlme", dpp_mlme_notify,
 						NULL, NULL);
 =

+	unicast_watch =3D l_genl_add_unicast_watch(iwd_get_genl(),
+						NL80211_GENL_NAME,
+						dpp_unicast_notify,
+						NULL, NULL);
+
 	dpp_list =3D l_queue_new();
 =

 	return 0;
@@ -1948,6 +2048,8 @@ static void dpp_exit(void)
 =

 	netdev_watch_remove(netdev_watch);
 =

+	l_genl_remove_unicast_watch(iwd_get_genl(), unicast_watch);
+
 	l_genl_family_unregister(nl80211, mlme_watch);
 	mlme_watch =3D 0;
 =

-- =

2.34.1

--===============6027198888801762320==--

