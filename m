Content-Type: multipart/mixed; boundary="===============4206639482767161503=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] ap: Use frame-xchg when sending frames
Date: Mon, 21 Sep 2020 21:04:25 +0200
Message-ID: <20200921190425.615855-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200921190425.615855-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4206639482767161503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert ap_send_mgmt_frame() to use frame_xchg_start for sending frames,
this fixes among other things the ACK-received checks.

One side effect is that we're no longer sending Probe Responses with the
don't-wait-for-ack flag because frame-xchg doesn't support it, but other
AP implementations don't use that flag either.

Another side-effect is that we do use the no-cck-rate flag
unconditionally, something we may want to fix but would need to add
another parameter to frame-xchg.
---
 src/ap.c | 86 ++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index da2a3a82..3c4ae907 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -543,36 +543,20 @@ static void ap_wsc_exit_pbc(struct ap_state *ap)
 =

 static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					const struct mmpdu_header *frame,
-					size_t frame_len, bool wait_ack,
-					l_genl_msg_func_t callback,
+					size_t frame_len,
+					frame_xchg_cb_t callback,
 					void *user_data)
 {
-	struct l_genl_msg *msg;
-	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
-	uint32_t id;
 	uint32_t ch_freq =3D scan_channel_to_freq(ap->config->channel,
 						SCAN_BAND_2_4_GHZ);
+	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
+	struct iovec iov[2];
 =

-	msg =3D l_genl_msg_new_sized(NL80211_CMD_FRAME, 128 + frame_len);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &ch_freq);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME, frame_len, frame);
-	if (!wait_ack)
-		l_genl_msg_append_attr(msg, NL80211_ATTR_DONT_WAIT_FOR_ACK,
-					0, NULL);
-
-	if (ap->config->no_cck_rates)
-		l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0,
-					NULL);
-
-
-	id =3D l_genl_family_send(ap->nl80211, msg, callback, user_data, NULL);
-
-	if (!id)
-		l_genl_msg_unref(msg);
-
-	return id;
+	iov[0].iov_base =3D (void *) frame;
+	iov[0].iov_len =3D frame_len;
+	iov[1].iov_base =3D NULL;
+	return frame_xchg_start(wdev_id, iov, ch_freq, 0, 0, 0, 0,
+					callback, user_data, NULL, NULL);
 }
 =

 static void ap_start_handshake(struct sta_state *sta, bool use_eapol_start)
@@ -1013,16 +997,19 @@ static bool ap_common_rates(struct l_uintset *ap_rat=
es,
 	return false;
 }
 =

-static void ap_success_assoc_resp_cb(struct l_genl_msg *msg, void *user_da=
ta)
+static void ap_success_assoc_resp_cb(int err, void *user_data)
 {
 	struct sta_state *sta =3D user_data;
 	struct ap_state *ap =3D sta->ap;
 =

 	sta->assoc_resp_cmd_id =3D 0;
 =

-	if (l_genl_msg_get_error(msg) < 0) {
-		l_error("AP (Re)Association Response not sent or not ACKed: %i",
-			l_genl_msg_get_error(msg));
+	if (err) {
+		if (err =3D=3D -ECOMM)
+			l_error("AP (Re)Association Response received no ACK");
+		else
+			l_error("AP (Re)Association Response not sent %s (%i)",
+				strerror(-err), -err);
 =

 		/* If we were in State 3 or 4 go to back to State 2 */
 		if (sta->associated)
@@ -1038,11 +1025,14 @@ static void ap_success_assoc_resp_cb(struct l_genl_=
msg *msg, void *user_data)
 	l_info("AP (Re)Association Response ACK received");
 }
 =

-static void ap_fail_assoc_resp_cb(struct l_genl_msg *msg, void *user_data)
+static void ap_fail_assoc_resp_cb(int err, void *user_data)
 {
-	if (l_genl_msg_get_error(msg) < 0)
-		l_error("AP (Re)Association Response with an error status not "
-			"sent or not ACKed: %i", l_genl_msg_get_error(msg));
+	if (err =3D=3D -ECOMM)
+		l_error("AP (Re)Association Response with an error status "
+			"received no ACK");
+	else if (err)
+		l_error("AP (Re)Association Response with an error status "
+			"not sent: %s (%i)", strerror(-err), -err);
 	else
 		l_info("AP (Re)Association Response with an error status "
 			"delivered OK");
@@ -1051,7 +1041,7 @@ static void ap_fail_assoc_resp_cb(struct l_genl_msg *=
msg, void *user_data)
 static uint32_t ap_assoc_resp(struct ap_state *ap, struct sta_state *sta,
 				const uint8_t *dest,
 				enum mmpdu_reason_code status_code,
-				bool reassoc, l_genl_msg_func_t callback)
+				bool reassoc, frame_xchg_cb_t callback)
 {
 	const uint8_t *addr =3D netdev_get_address(ap->netdev);
 	uint8_t mpdu_buf[128];
@@ -1132,7 +1122,7 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, st=
ruct sta_state *sta,
 =

 send_frame:
 	return ap_send_mgmt_frame(ap, mpdu, resp->ies + ies_len - mpdu_buf,
-					true, callback, sta);
+					callback, sta);
 }
 =

 static int ap_parse_supported_rates(struct ie_tlv_iter *iter,
@@ -1606,13 +1596,15 @@ static void ap_process_wsc_probe_req(struct ap_stat=
e *ap, const uint8_t *from,
 	}
 }
 =

-static void ap_probe_resp_cb(struct l_genl_msg *msg, void *user_data)
+static void ap_probe_resp_cb(int err, void *user_data)
 {
-	if (l_genl_msg_get_error(msg) < 0)
-		l_error("AP Probe Response not sent: %i",
-			l_genl_msg_get_error(msg));
+	if (err =3D=3D -ECOMM)
+		l_error("AP Probe Response received no ACK");
+	else if (err)
+		l_error("AP Probe Response not sent: %s (%i)",
+			strerror(-err), -err);
 	else
-		l_info("AP Probe Response sent OK");
+		l_info("AP Probe Response delivered OK");
 }
 =

 /*
@@ -1723,7 +1715,7 @@ static void ap_probe_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 					hdr->address_2, resp, sizeof(resp));
 	len +=3D ap_build_beacon_pr_tail(ap, true, resp + len);
 =

-	ap_send_mgmt_frame(ap, (struct mmpdu_header *) resp, len, false,
+	ap_send_mgmt_frame(ap, (struct mmpdu_header *) resp, len,
 				ap_probe_resp_cb, NULL);
 }
 =

@@ -1757,11 +1749,13 @@ static void ap_disassoc_cb(const struct mmpdu_heade=
r *hdr, const void *body,
 	ap_del_station(sta, L_LE16_TO_CPU(disassoc->reason_code), true);
 }
 =

-static void ap_auth_reply_cb(struct l_genl_msg *msg, void *user_data)
+static void ap_auth_reply_cb(int err, void *user_data)
 {
-	if (l_genl_msg_get_error(msg) < 0)
-		l_error("AP Authentication frame 2 not sent or not ACKed: %i",
-			l_genl_msg_get_error(msg));
+	if (err =3D=3D -ECOMM)
+		l_error("AP Authentication frame 2 received no ACK");
+	else if (err)
+		l_error("AP Authentication frame 2 not sent: %s (%i)",
+			strerror(-err), -err);
 	else
 		l_info("AP Authentication frame 2 ACKed by STA");
 }
@@ -1790,7 +1784,7 @@ static void ap_auth_reply(struct ap_state *ap, const =
uint8_t *dest,
 	auth->transaction_sequence =3D L_CPU_TO_LE16(2);
 	auth->status =3D L_CPU_TO_LE16(status_code);
 =

-	ap_send_mgmt_frame(ap, mpdu, (uint8_t *) auth + 6 - mpdu_buf, true,
+	ap_send_mgmt_frame(ap, mpdu, (uint8_t *) auth + 6 - mpdu_buf,
 				ap_auth_reply_cb, NULL);
 }
 =

-- =

2.25.1

--===============4206639482767161503==--

