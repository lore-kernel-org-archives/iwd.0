Content-Type: multipart/mixed; boundary="===============8346760999796439698=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] ap: Write extra frame IEs from the user
Date: Wed, 10 Mar 2021 23:06:32 +0100
Message-ID: <20210310220635.944104-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210310220635.944104-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8346760999796439698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add an API for the ap.h users to add extra IEs to outgoing management
frames: beacons, etc.
---
Changes in this version:
 - a "client_frame" parameter is added to the callbacks so that the
   ap_state API user can also react to IEs such as the P2P IE from
   the client, and write its own IEs based on the contents.  The P2P
   IE for example should only be in a Probe Response if the Probe
   Request had one also.
   I gave up on the idea of having multiple callbacks for multiple
   frame types as in the end it is more limited.
 - a single callback can be registered in the ap_ops structure,
   dropped the method for dynamically registering those callbacks.
 - buffers for the frames are l_malloc'd instead of being on the stack.

 src/ap.c | 107 +++++++++++++++++++++++++++++++++++++++++++++----------
 src/ap.h |  23 ++++++++++++
 2 files changed, 111 insertions(+), 19 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index eeab3408..a79a71ca 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -466,11 +466,48 @@ static void ap_set_rsn_info(struct ap_state *ap, stru=
ct ie_rsn_info *rsn)
 	rsn->group_cipher =3D ap->group_cipher;
 }
 =

+static size_t ap_get_extra_ies_len(struct ap_state *ap,
+					enum mpdu_management_subtype type,
+					const struct mmpdu_header *client_frame,
+					size_t client_frame_len)
+{
+	size_t len =3D 0;
+
+	if (ap->ops->get_extra_ies_len)
+		len +=3D ap->ops->get_extra_ies_len(type, client_frame,
+							client_frame_len,
+							ap->user_data);
+
+	return len;
+}
+
+static size_t ap_write_extra_ies(struct ap_state *ap,
+					enum mpdu_management_subtype type,
+					const struct mmpdu_header *client_frame,
+					size_t client_frame_len,
+					uint8_t *out_buf)
+{
+	size_t len =3D 0;
+
+	if (ap->ops->write_extra_ies)
+		len +=3D ap->ops->write_extra_ies(type,
+						client_frame, client_frame_len,
+						out_buf + len, ap->user_data);
+
+	return len;
+}
+
 /*
  * Build a Beacon frame or a Probe Response frame's header and body until
  * the TIM IE.  Except for the optional TIM IE which is inserted by the
  * kernel when needed, our contents for both frames are the same.
  * See Beacon format in 8.3.3.2 and Probe Response format in 8.3.3.10.
+ *
+ * 802.11-2016, Section 9.4.2.1:
+ * "The frame body components specified for many management subtypes result
+ * in elements ordered by ascending values of the Element ID field and then
+ * the Element ID Extension field (when present), with the exception of the
+ * MIC Management element (9.4.2.55)."
  */
 static size_t ap_build_beacon_pr_head(struct ap_state *ap,
 					enum mpdu_management_subtype stype,
@@ -536,8 +573,10 @@ static size_t ap_build_beacon_pr_head(struct ap_state =
*ap,
 }
 =

 /* Beacon / Probe Response frame portion after the TIM IE */
-static size_t ap_build_beacon_pr_tail(struct ap_state *ap, bool pr,
-					uint8_t *out_buf)
+static size_t ap_build_beacon_pr_tail(struct ap_state *ap,
+					enum mpdu_management_subtype stype,
+					const struct mmpdu_header *req,
+					size_t req_len, uint8_t *out_buf)
 {
 	size_t len;
 	struct ie_rsn_info rsn;
@@ -633,6 +672,7 @@ static size_t ap_build_beacon_pr_tail(struct ap_state *=
ap, bool pr,
 	len +=3D wsc_ie_size;
 	l_free(wsc_ie);
 =

+	len +=3D ap_write_extra_ies(ap, stype, req, req_len, out_buf + len);
 	return len;
 }
 =

@@ -647,7 +687,11 @@ static void ap_set_beacon_cb(struct l_genl_msg *msg, v=
oid *user_data)
 void ap_update_beacon(struct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
-	uint8_t head[256], tail[256];
+	uint8_t head[256];
+	L_AUTO_FREE_VAR(uint8_t *, tail) =3D
+		l_malloc(256 + ap_get_extra_ies_len(ap,
+						MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						NULL, 0));
 	size_t head_len, tail_len;
 	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
 	static const uint8_t bcast_addr[6] =3D {
@@ -659,7 +703,8 @@ void ap_update_beacon(struct ap_state *ap)
 =

 	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
-	tail_len =3D ap_build_beacon_pr_tail(ap, false, tail);
+	tail_len =3D ap_build_beacon_pr_tail(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						NULL, 0, tail);
 	if (L_WARN_ON(!head_len || !tail_len))
 		return;
 =

@@ -1197,10 +1242,15 @@ static void ap_fail_assoc_resp_cb(int err, void *us=
er_data)
 static uint32_t ap_assoc_resp(struct ap_state *ap, struct sta_state *sta,
 				const uint8_t *dest,
 				enum mmpdu_reason_code status_code,
-				bool reassoc, frame_xchg_cb_t callback)
+				bool reassoc, const struct mmpdu_header *req,
+				size_t req_len, frame_xchg_cb_t callback)
 {
 	const uint8_t *addr =3D netdev_get_address(ap->netdev);
-	uint8_t mpdu_buf[128];
+	enum mpdu_management_subtype stype =3D reassoc ?
+		MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE :
+		MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE;
+	L_AUTO_FREE_VAR(uint8_t *, mpdu_buf) =3D
+		l_malloc(128 + ap_get_extra_ies_len(ap, stype, req, req_len));
 	struct mmpdu_header *mpdu =3D (void *) mpdu_buf;
 	struct mmpdu_association_response *resp;
 	size_t ies_len =3D 0;
@@ -1212,9 +1262,7 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, st=
ruct sta_state *sta,
 	/* Header */
 	mpdu->fc.protocol_version =3D 0;
 	mpdu->fc.type =3D MPDU_TYPE_MANAGEMENT;
-	mpdu->fc.subtype =3D reassoc ?
-		MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE :
-		MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE;
+	mpdu->fc.subtype =3D stype;
 	memcpy(mpdu->address_1, dest, 6);	/* DA */
 	memcpy(mpdu->address_2, addr, 6);	/* SA */
 	memcpy(mpdu->address_3, addr, 6);	/* BSSID */
@@ -1276,6 +1324,9 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, st=
ruct sta_state *sta,
 		l_free(wsc_ie);
 	}
 =

+	ies_len +=3D ap_write_extra_ies(ap, stype, req, req_len,
+					resp->ies + ies_len);
+
 send_frame:
 	return ap_send_mgmt_frame(ap, mpdu, resp->ies + ies_len - mpdu_buf,
 					callback, sta);
@@ -1351,8 +1402,9 @@ static int ap_parse_supported_rates(struct ie_tlv_ite=
r *iter,
  */
 static void ap_assoc_reassoc(struct sta_state *sta, bool reassoc,
 				const struct mmpdu_field_capability *capability,
-				uint16_t listen_interval, const uint8_t *ies,
-				size_t ies_len)
+				uint16_t listen_interval,
+				const uint8_t *ies, size_t ies_len,
+				const struct mmpdu_header *req)
 {
 	struct ap_state *ap =3D sta->ap;
 	const char *ssid =3D NULL;
@@ -1541,6 +1593,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 	}
 =

 	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, 0, reassoc,
+						req, (void *) ies + ies_len -
+						(void *) req,
 						ap_success_assoc_resp_cb);
 	if (!sta->assoc_resp_cmd_id)
 		l_error("Sending success (Re)Association Response failed");
@@ -1572,6 +1626,7 @@ bad_frame:
 	l_free(wsc_data);
 =

 	if (!ap_assoc_resp(ap, sta, sta->addr, err, reassoc,
+				req, (void *) ies + ies_len - (void *) req,
 				ap_fail_assoc_resp_cb))
 		l_error("Sending error (Re)Association Response failed");
 }
@@ -1596,7 +1651,8 @@ static void ap_assoc_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 	if (!sta) {
 		if (!ap_assoc_resp(ap, NULL, from,
 				MMPDU_REASON_CODE_STA_REQ_ASSOC_WITHOUT_AUTH,
-				false, ap_fail_assoc_resp_cb))
+				false, hdr, body + body_len - (void *) hdr,
+				ap_fail_assoc_resp_cb))
 			l_error("Sending error Association Response failed");
 =

 		return;
@@ -1604,7 +1660,7 @@ static void ap_assoc_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 =

 	ap_assoc_reassoc(sta, false, &req->capability,
 				L_LE16_TO_CPU(req->listen_interval),
-				req->ies, body_len - sizeof(*req));
+				req->ies, body_len - sizeof(*req), hdr);
 }
 =

 /* 802.11-2016 9.3.3.8 */
@@ -1638,11 +1694,13 @@ static void ap_reassoc_req_cb(const struct mmpdu_he=
ader *hdr, const void *body,
 =

 	ap_assoc_reassoc(sta, true, &req->capability,
 				L_LE16_TO_CPU(req->listen_interval),
-				req->ies, body_len - sizeof(*req));
+				req->ies, body_len - sizeof(*req), hdr);
 	return;
 =

 bad_frame:
-	if (!ap_assoc_resp(ap, NULL, from, err, true, ap_fail_assoc_resp_cb))
+	if (!ap_assoc_resp(ap, NULL, from, err, true,
+				hdr, body + body_len - (void *) hdr,
+				ap_fail_assoc_resp_cb))
 		l_error("Sending error Reassociation Response failed");
 }
 =

@@ -1785,7 +1843,10 @@ static void ap_probe_req_cb(const struct mmpdu_heade=
r *hdr, const void *body,
 	struct ie_tlv_iter iter;
 	const uint8_t *bssid =3D netdev_get_address(ap->netdev);
 	bool match =3D false;
-	uint8_t resp[512];
+	L_AUTO_FREE_VAR(uint8_t *, resp) =3D
+		l_malloc(512 + ap_get_extra_ies_len(ap,
+				MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE, hdr,
+				body + body_len - (void *) hdr));
 	uint8_t *wsc_data;
 	ssize_t wsc_data_len;
 =

@@ -1875,7 +1936,10 @@ static void ap_probe_req_cb(const struct mmpdu_heade=
r *hdr, const void *body,
 	len =3D ap_build_beacon_pr_head(ap,
 					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
 					hdr->address_2, resp, sizeof(resp));
-	len +=3D ap_build_beacon_pr_tail(ap, true, resp + len);
+	len +=3D ap_build_beacon_pr_tail(ap,
+					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
+					hdr, body + body_len - (void *) hdr,
+					resp + len);
 =

 	ap_send_mgmt_frame(ap, (struct mmpdu_header *) resp, len,
 				ap_probe_resp_cb, NULL);
@@ -2108,7 +2172,11 @@ static struct l_genl_msg *ap_build_cmd_start_ap(stru=
ct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
 =

-	uint8_t head[256], tail[256];
+	uint8_t head[256];
+	L_AUTO_FREE_VAR(uint8_t *, tail) =3D
+		l_malloc(256 + ap_get_extra_ies_len(ap,
+						MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						NULL, 0));
 	size_t head_len, tail_len;
 =

 	uint32_t dtim_period =3D 3;
@@ -2138,7 +2206,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 =

 	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
-	tail_len =3D ap_build_beacon_pr_tail(ap, false, tail);
+	tail_len =3D ap_build_beacon_pr_tail(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						NULL, 0, tail);
 =

 	if (!head_len || !tail_len)
 		return NULL;
diff --git a/src/ap.h b/src/ap.h
index 0bdbf0bb..729a6648 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -22,6 +22,7 @@
 =

 struct ap_state;
 struct iovec;
+enum mpdu_management_subtype;
 =

 enum ap_event_type {
 	AP_EVENT_START_FAILED,
@@ -75,6 +76,28 @@ struct ap_config {
 struct ap_ops {
 	void (*handle_event)(enum ap_event_type type, const void *event_data,
 				void *user_data);
+	/*
+	 * If .write_extra_ies is provided, this callback must return an upper
+	 * bound on the buffer space needed for the extra IEs to be sent in
+	 * the frame of given type and, if it's not a beacon frame, in
+	 * response to a given client frame.
+	 */
+	size_t (*get_extra_ies_len)(enum mpdu_management_subtype type,
+					const struct mmpdu_header *client_frame,
+					size_t client_frame_len,
+					void *user_data);
+	/*
+	 * If not null, writes extra IEs to be added to the outgoing frame of
+	 * given type and, if it's not a beacon frame, in reponse to a given
+	 * client frame.  May also react to the extra IEs in that frame.
+	 * Returns the number of bytes written which must be less than or
+	 * equal to the number returned by .get_extra_ies_len when called
+	 * with the same parameters.
+	 */
+	size_t (*write_extra_ies)(enum mpdu_management_subtype type,
+					const struct mmpdu_header *client_frame,
+					size_t client_frame_len,
+					uint8_t *out_buf, void *user_data);
 };
 =

 void ap_config_free(struct ap_config *config);
-- =

2.27.0

--===============8346760999796439698==--

