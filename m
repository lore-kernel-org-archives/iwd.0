Content-Type: multipart/mixed; boundary="===============4882145018581149100=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/8] ap: Parse WSC PBC association request and build response
Date: Fri, 28 Aug 2020 14:46:48 +0200
Message-ID: <20200828124649.78677-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200828124649.78677-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4882145018581149100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check the conditions for PBC enrollee registration when we receive the
Association Request with WSC IE and indicate to the enrollee whether we
accept the association using a WSC IE in the Association Response.
After this, a NULL sta->assoc_rsne indicates that the station is not
establishing the RSNA and is a WSC enrollee.
---
 src/ap.c | 186 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 151 insertions(+), 35 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index df0a9942..d7d0bbad 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -91,6 +91,8 @@ struct sta_state {
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
 	uint32_t gtk_query_cmd_id;
+	uint8_t wsc_uuid_e[16];
+	bool wsc_v2;
 };
 =

 struct ap_wsc_pbc_probe_record {
@@ -906,7 +908,7 @@ static void ap_fail_assoc_resp_cb(struct l_genl_msg *ms=
g, void *user_data)
 }
 =

 static uint32_t ap_assoc_resp(struct ap_state *ap, struct sta_state *sta,
-				const uint8_t *dest, uint16_t aid,
+				const uint8_t *dest,
 				enum mmpdu_reason_code status_code,
 				bool reassoc, l_genl_msg_func_t callback)
 {
@@ -934,7 +936,7 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, stru=
ct sta_state *sta,
 	resp =3D (void *) mmpdu_body(mpdu);
 	l_put_le16(capability, &resp->capability);
 	resp->status_code =3D L_CPU_TO_LE16(status_code);
-	resp->aid =3D L_CPU_TO_LE16(aid | 0xc000);
+	resp->aid =3D sta ? L_CPU_TO_LE16(sta->aid | 0xc000) : 0;
 =

 	/* Supported Rates IE */
 	resp->ies[ies_len++] =3D IE_TYPE_SUPPORTED_RATES;
@@ -956,6 +958,38 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, str=
uct sta_state *sta,
 	resp->ies[ies_len++] =3D count;
 	ies_len +=3D count;
 =

+	if (sta && !sta->assoc_rsne) {
+		struct wsc_association_response wsc_resp =3D {};
+		uint8_t *wsc_data;
+		size_t wsc_data_len;
+		uint8_t *wsc_ie;
+		size_t wsc_ie_len;
+
+		wsc_resp.response_type =3D WSC_RESPONSE_TYPE_AP;
+		wsc_resp.version2 =3D sta->wsc_v2;
+
+		wsc_data =3D wsc_build_association_response(&wsc_resp,
+								&wsc_data_len);
+		if (!wsc_data) {
+			l_error("wsc_build_beacon error");
+			goto send_frame;
+		}
+
+		wsc_ie =3D ie_tlv_encapsulate_wsc_payload(wsc_data, wsc_data_len,
+							&wsc_ie_len);
+		l_free(wsc_data);
+
+		if (!wsc_ie) {
+			l_error("ie_tlv_encapsulate_wsc_payload error");
+			goto send_frame;
+		}
+
+		memcpy(resp->ies + ies_len, wsc_ie, wsc_ie_len);
+		ies_len +=3D wsc_ie_len;
+		l_free(wsc_ie);
+	}
+
+send_frame:
 	return ap_send_mgmt_frame(ap, mpdu, resp->ies + ies_len - mpdu_buf,
 					true, callback, sta);
 }
@@ -1030,8 +1064,8 @@ static int ap_parse_supported_rates(struct ie_tlv_ite=
r *iter,
  */
 static void ap_assoc_reassoc(struct sta_state *sta, bool reassoc,
 				const struct mmpdu_field_capability *capability,
-				uint16_t listen_interval,
-				struct ie_tlv_iter *ies)
+				uint16_t listen_interval, const uint8_t *ies,
+				size_t ies_len)
 {
 	struct ap_state *ap =3D sta->ap;
 	const char *ssid =3D NULL;
@@ -1040,6 +1074,9 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 	struct l_uintset *rates =3D NULL;
 	struct ie_rsn_info rsn_info;
 	int err;
+	struct ie_tlv_iter iter;
+	uint8_t *wsc_data =3D NULL;
+	ssize_t wsc_data_len;
 =

 	if (sta->assoc_resp_cmd_id)
 		return;
@@ -1049,16 +1086,20 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 		goto unsupported;
 	}
 =

-	while (ie_tlv_iter_next(ies))
-		switch (ie_tlv_iter_get_tag(ies)) {
+	wsc_data =3D ie_tlv_extract_wsc_payload(ies, ies_len, &wsc_data_len);
+
+	ie_tlv_iter_init(&iter, ies, ies_len);
+
+	while (ie_tlv_iter_next(&iter))
+		switch (ie_tlv_iter_get_tag(&iter)) {
 		case IE_TYPE_SSID:
-			ssid =3D (const char *) ie_tlv_iter_get_data(ies);
-			ssid_len =3D ie_tlv_iter_get_length(ies);
+			ssid =3D (const char *) ie_tlv_iter_get_data(&iter);
+			ssid_len =3D ie_tlv_iter_get_length(&iter);
 			break;
 =

 		case IE_TYPE_SUPPORTED_RATES:
 		case IE_TYPE_EXTENDED_SUPPORTED_RATES:
-			if (ap_parse_supported_rates(ies, &rates) < 0) {
+			if (ap_parse_supported_rates(&iter, &rates) < 0) {
 				err =3D MMPDU_REASON_CODE_INVALID_IE;
 				goto bad_frame;
 			}
@@ -1066,16 +1107,26 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 			break;
 =

 		case IE_TYPE_RSN:
-			if (ie_parse_rsne(ies, &rsn_info) < 0) {
+			/*
+			 * WSC v2.0.5 Section 8.2:
+			 * "Note that during the WSC association [...] the
+			 * RSN IE and the WPA IE are irrelevant and shall be
+			 * ignored by both the station and AP."
+			 */
+			if (wsc_data)
+				break;
+
+			if (ie_parse_rsne(&iter, &rsn_info) < 0) {
 				err =3D MMPDU_REASON_CODE_INVALID_IE;
 				goto bad_frame;
 			}
 =

-			rsn =3D (const uint8_t *) ie_tlv_iter_get_data(ies) - 2;
+			rsn =3D (const uint8_t *) ie_tlv_iter_get_data(&iter) - 2;
 			break;
 		}
 =

-	if (!rates || !ssid || !rsn || ssid_len !=3D strlen(ap->config->ssid) ||
+	if (!rates || !ssid || (!wsc_data && !rsn) ||
+			ssid_len !=3D strlen(ap->config->ssid) ||
 			memcmp(ssid, ap->config->ssid, ssid_len)) {
 		err =3D MMPDU_REASON_CODE_INVALID_IE;
 		goto bad_frame;
@@ -1086,19 +1137,82 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 		goto unsupported;
 	}
 =

-	if (rsn_info.mfpr && rsn_info.spp_a_msdu_required) {
-		err =3D MMPDU_REASON_CODE_UNSPECIFIED;
-		goto unsupported;
-	}
+	/* Is the client requesting RSNA establishment or WSC registration */
+	if (!rsn) {
+		struct wsc_association_request wsc_req;
+		struct ap_event_registration_start_data event_data;
+		struct ap_wsc_pbc_probe_record *record;
 =

-	if (!(rsn_info.pairwise_ciphers & ap->ciphers)) {
-		err =3D MMPDU_REASON_CODE_INVALID_PAIRWISE_CIPHER;
-		goto unsupported;
-	}
+		if (wsc_parse_association_request(wsc_data, wsc_data_len,
+							&wsc_req) < 0) {
+			err =3D MMPDU_REASON_CODE_INVALID_IE;
+			goto bad_frame;
+		}
 =

-	if (rsn_info.akm_suites !=3D IE_RSN_AKM_SUITE_PSK) {
-		err =3D MMPDU_REASON_CODE_INVALID_AKMP;
-		goto unsupported;
+		l_free(wsc_data);
+		wsc_data =3D NULL;
+
+		if (wsc_req.request_type !=3D
+				WSC_REQUEST_TYPE_ENROLLEE_OPEN_8021X) {
+			err =3D MMPDU_REASON_CODE_INVALID_IE;
+			goto bad_frame;
+		}
+
+		if (!ap->wsc_pbc_timeout) {
+			l_debug("WSC association from %s but we're not in "
+				"PBC mode", util_address_to_string(sta->addr));
+			err =3D MMPDU_REASON_CODE_UNSPECIFIED;
+			goto bad_frame;
+		}
+
+		if (l_queue_isempty(ap->wsc_pbc_probes)) {
+			l_debug("%s tried to register as enrollee but we "
+				"don't have their Probe Request record",
+				util_address_to_string(sta->addr));
+			err =3D MMPDU_REASON_CODE_UNSPECIFIED;
+			goto bad_frame;
+		}
+
+		/*
+		 * For PBC, the Enrollee must have sent the only PBC Probe
+		 * Request within the monitor time and walk time.
+		 */
+		record =3D l_queue_peek_head(ap->wsc_pbc_probes);
+		if (memcmp(sta->addr, record->mac, 6)) {
+			l_debug("Session overlap during %s's attempt to "
+				"register as WSC enrollee",
+				util_address_to_string(sta->addr));
+			err =3D MMPDU_REASON_CODE_UNSPECIFIED;
+			goto bad_frame;
+		}
+
+		memcpy(sta->wsc_uuid_e, record->uuid_e, 16);
+		sta->wsc_v2 =3D wsc_req.version2;
+
+		event_data.mac =3D sta->addr;
+		ap->event_func(AP_EVENT_REGISTRATION_START, &event_data,
+				ap->user_data);
+
+		/*
+		 * Since we're starting the PBC Registration Protocol
+		 * we can now exit the "active PBC mode".
+		 */
+		ap_wsc_exit_pbc(ap);
+	} else {
+		if (rsn_info.mfpr && rsn_info.spp_a_msdu_required) {
+			err =3D MMPDU_REASON_CODE_UNSPECIFIED;
+			goto unsupported;
+		}
+
+		if (!(rsn_info.pairwise_ciphers & ap->ciphers)) {
+			err =3D MMPDU_REASON_CODE_INVALID_PAIRWISE_CIPHER;
+			goto unsupported;
+		}
+
+		if (rsn_info.akm_suites !=3D IE_RSN_AKM_SUITE_PSK) {
+			err =3D MMPDU_REASON_CODE_INVALID_AKMP;
+			goto unsupported;
+		}
 	}
 =

 	/* 802.11-2016 11.3.5.3 j) */
@@ -1128,10 +1242,12 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 	if (sta->assoc_rsne)
 		l_free(sta->assoc_rsne);
 =

-	sta->assoc_rsne =3D l_memdup(rsn, rsn[1] + 2);
+	if (rsn)
+		sta->assoc_rsne =3D l_memdup(rsn, rsn[1] + 2);
+	else
+		sta->assoc_rsne =3D NULL;
 =

-	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, sta->aid, 0,
-						reassoc,
+	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, 0, reassoc,
 						ap_success_assoc_resp_cb);
 	if (!sta->assoc_resp_cmd_id)
 		l_error("Sending success (Re)Association Response failed");
@@ -1160,7 +1276,9 @@ bad_frame:
 	if (rates)
 		l_uintset_free(rates);
 =

-	if (!ap_assoc_resp(ap, NULL, sta->addr, 0, err, reassoc,
+	l_free(wsc_data);
+
+	if (!ap_assoc_resp(ap, sta, sta->addr, err, reassoc,
 				ap_fail_assoc_resp_cb))
 		l_error("Sending error (Re)Association Response failed");
 }
@@ -1174,7 +1292,6 @@ static void ap_assoc_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 	const uint8_t *from =3D hdr->address_2;
 	const struct mmpdu_association_request *req =3D body;
 	const uint8_t *bssid =3D netdev_get_address(ap->netdev);
-	struct ie_tlv_iter iter;
 =

 	l_info("AP Association Request from %s", util_address_to_string(from));
 =

@@ -1184,7 +1301,7 @@ static void ap_assoc_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 =

 	sta =3D l_queue_find(ap->sta_states, ap_sta_match_addr, from);
 	if (!sta) {
-		if (!ap_assoc_resp(ap, NULL, from, 0,
+		if (!ap_assoc_resp(ap, NULL, from,
 				MMPDU_REASON_CODE_STA_REQ_ASSOC_WITHOUT_AUTH,
 				false, ap_fail_assoc_resp_cb))
 			l_error("Sending error Association Response failed");
@@ -1192,9 +1309,9 @@ static void ap_assoc_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 		return;
 	}
 =

-	ie_tlv_iter_init(&iter, req->ies, body_len - sizeof(*req));
 	ap_assoc_reassoc(sta, false, &req->capability,
-				L_LE16_TO_CPU(req->listen_interval), &iter);
+				L_LE16_TO_CPU(req->listen_interval),
+				req->ies, body_len - sizeof(*req));
 }
 =

 /* 802.11-2016 9.3.3.8 */
@@ -1206,7 +1323,6 @@ static void ap_reassoc_req_cb(const struct mmpdu_head=
er *hdr, const void *body,
 	const uint8_t *from =3D hdr->address_2;
 	const struct mmpdu_reassociation_request *req =3D body;
 	const uint8_t *bssid =3D netdev_get_address(ap->netdev);
-	struct ie_tlv_iter iter;
 	int err;
 =

 	l_info("AP Reassociation Request from %s",
@@ -1227,13 +1343,13 @@ static void ap_reassoc_req_cb(const struct mmpdu_he=
ader *hdr, const void *body,
 		goto bad_frame;
 	}
 =

-	ie_tlv_iter_init(&iter, req->ies, body_len - sizeof(*req));
 	ap_assoc_reassoc(sta, true, &req->capability,
-				L_LE16_TO_CPU(req->listen_interval), &iter);
+				L_LE16_TO_CPU(req->listen_interval),
+				req->ies, body_len - sizeof(*req));
 	return;
 =

 bad_frame:
-	if (!ap_assoc_resp(ap, NULL, from, 0, err, true, ap_fail_assoc_resp_cb))
+	if (!ap_assoc_resp(ap, NULL, from, err, true, ap_fail_assoc_resp_cb))
 		l_error("Sending error Reassociation Response failed");
 }
 =

-- =

2.25.1

--===============4882145018581149100==--

