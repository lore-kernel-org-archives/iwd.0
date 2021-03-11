Content-Type: multipart/mixed; boundary="===============7341263317173752499=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] ap: Handle most WSC IEs using ap_write_extra_ies
Date: Thu, 11 Mar 2021 14:07:24 +0100
Message-ID: <20210311130726.990523-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210311130726.990523-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7341263317173752499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make the WSC IE processing and writing more self-contained (i.e. so that
it can be more easily moved to a separate file if desired) by using the
new ap_write_extra_ies() mechanism.
---
 src/ap.c | 559 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 288 insertions(+), 271 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 1ee17e89..ece2ef3c 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -466,6 +466,289 @@ static void ap_set_rsn_info(struct ap_state *ap, stru=
ct ie_rsn_info *rsn)
 	rsn->group_cipher =3D ap->group_cipher;
 }
 =

+static void ap_wsc_exit_pbc(struct ap_state *ap)
+{
+	if (!ap->wsc_pbc_timeout)
+		return;
+
+	l_timeout_remove(ap->wsc_pbc_timeout);
+	ap->wsc_dpid =3D 0;
+	ap_update_beacon(ap);
+
+	ap->ops->handle_event(AP_EVENT_PBC_MODE_EXIT, NULL, ap->user_data);
+}
+
+struct ap_pbc_record_expiry_data {
+	uint64_t min_time;
+	const uint8_t *mac;
+};
+
+static bool ap_wsc_pbc_record_expire(void *data, void *user_data)
+{
+	struct ap_wsc_pbc_probe_record *record =3D data;
+	const struct ap_pbc_record_expiry_data *expiry_data =3D user_data;
+
+	if (record->timestamp > expiry_data->min_time &&
+			memcmp(record->mac, expiry_data->mac, 6))
+		return false;
+
+	l_free(record);
+	return true;
+}
+
+#define AP_WSC_PBC_MONITOR_TIME	120
+#define AP_WSC_PBC_WALK_TIME	120
+
+static void ap_process_wsc_probe_req(struct ap_state *ap, const uint8_t *f=
rom,
+					const uint8_t *wsc_data,
+					size_t wsc_data_len)
+{
+	struct wsc_probe_request req;
+	struct ap_pbc_record_expiry_data expiry_data;
+	struct ap_wsc_pbc_probe_record *record;
+	uint64_t now;
+	bool empty;
+	uint8_t first_sta_addr[6] =3D {};
+	const struct l_queue_entry *entry;
+
+	if (wsc_parse_probe_request(wsc_data, wsc_data_len, &req) < 0)
+		return;
+
+	if (!(req.config_methods & WSC_CONFIGURATION_METHOD_PUSH_BUTTON))
+		return;
+
+	if (req.device_password_id !=3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON)
+		return;
+
+	/* Save the address of the first enrollee record */
+	record =3D l_queue_peek_head(ap->wsc_pbc_probes);
+	if (record)
+		memcpy(first_sta_addr, record->mac, 6);
+
+	now =3D l_time_now();
+
+	/*
+	 * Expire entries older than PBC Monitor Time.  While there also drop
+	 * older entries from the same Enrollee that sent us this new Probe
+	 * Request.  It's unclear whether we should also match by the UUID-E.
+	 */
+	expiry_data.min_time =3D now - AP_WSC_PBC_MONITOR_TIME * 1000000;
+	expiry_data.mac =3D from;
+	l_queue_foreach_remove(ap->wsc_pbc_probes, ap_wsc_pbc_record_expire,
+				&expiry_data);
+
+	empty =3D l_queue_isempty(ap->wsc_pbc_probes);
+
+	if (!ap->wsc_pbc_probes)
+		ap->wsc_pbc_probes =3D l_queue_new();
+
+	/* Add new record */
+	record =3D l_new(struct ap_wsc_pbc_probe_record, 1);
+	memcpy(record->mac, from, 6);
+	memcpy(record->uuid_e, req.uuid_e, sizeof(record->uuid_e));
+	record->timestamp =3D now;
+	l_queue_push_tail(ap->wsc_pbc_probes, record);
+
+	/*
+	 * If queue was non-empty and we've added one more record then we
+	 * now have seen more than one PBC enrollee during the PBC Monitor
+	 * Time and must exit "active PBC mode" due to "session overlap".
+	 * WSC v2.0.5 Section 11.3:
+	 * "Within the PBC Monitor Time, if the Registrar receives PBC
+	 * probe requests from more than one Enrollee [...] then the
+	 * Registrar SHALL signal a "session overlap" error.  As a result,
+	 * the Registrar shall refuse to enter active PBC mode and shall
+	 * also refuse to perform a PBC-based Registration Protocol
+	 * exchange [...]"
+	 */
+	if (empty)
+		return;
+
+	if (ap->wsc_pbc_timeout) {
+		l_debug("Exiting PBC mode due to Session Overlap");
+		ap_wsc_exit_pbc(ap);
+	}
+
+	/*
+	 * "If the Registrar is engaged in PBC Registration Protocol
+	 * exchange with an Enrollee and receives a Probe Request or M1
+	 * Message from another Enrollee, then the Registrar should
+	 * signal a "session overlap" error".
+	 *
+	 * For simplicity just interrupt the handshake with that enrollee.
+	 */
+	for (entry =3D l_queue_get_entries(ap->sta_states); entry;
+			entry =3D entry->next) {
+		struct sta_state *sta =3D entry->data;
+
+		if (!sta->associated || sta->assoc_rsne)
+			continue;
+
+		/*
+		 * Check whether this enrollee is in PBC Registration
+		 * Protocol by comparing its mac with the first (and only)
+		 * record we had in ap->wsc_pbc_probes.  If we had more
+		 * than one record we wouldn't have been in
+		 * "active PBC mode".
+		 */
+		if (memcmp(sta->addr, first_sta_addr, 6) ||
+				!memcmp(sta->addr, from, 6))
+			continue;
+
+		l_debug("Interrupting handshake with %s due to Session Overlap",
+			util_address_to_string(sta->addr));
+
+		if (sta->hs) {
+			netdev_handshake_failed(sta->hs,
+					MMPDU_REASON_CODE_DISASSOC_AP_BUSY);
+			sta->sm =3D NULL;
+		}
+
+		ap_remove_sta(sta);
+	}
+}
+
+static size_t ap_get_wsc_ie_len(struct ap_state *ap,
+				enum mpdu_management_subtype type,
+				const struct mmpdu_header *client_frame,
+				size_t client_frame_len)
+{
+	return 256;
+}
+
+static size_t ap_write_wsc_ie(struct ap_state *ap,
+				enum mpdu_management_subtype type,
+				const struct mmpdu_header *client_frame,
+				size_t client_frame_len,
+				uint8_t *out_buf)
+{
+	const uint8_t *from =3D client_frame->address_2;
+	uint8_t *wsc_data;
+	size_t wsc_data_size;
+	uint8_t *wsc_ie;
+	size_t wsc_ie_size;
+	size_t len =3D 0;
+
+	/* WSC IE */
+	if (type =3D=3D MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE) {
+		struct wsc_probe_response wsc_pr =3D {};
+		const struct mmpdu_probe_request *req =3D
+			mmpdu_body(client_frame);
+		size_t req_ies_len =3D (void *) client_frame + client_frame_len -
+			(void *) req->ies;
+		ssize_t req_wsc_data_size;
+
+		/*
+		 * Process the client Probe Request WSC IE first as it may
+		 * cause us to exit "active PBC mode" and that will be
+		 * immediately reflected in our Probe Response WSC IE.
+		 */
+		wsc_data =3D ie_tlv_extract_wsc_payload(req->ies, req_ies_len,
+							&req_wsc_data_size);
+		if (wsc_data) {
+			ap_process_wsc_probe_req(ap, from, wsc_data,
+							req_wsc_data_size);
+			l_free(wsc_data);
+		}
+
+		wsc_pr.version2 =3D true;
+		wsc_pr.state =3D WSC_STATE_CONFIGURED;
+
+		if (ap->wsc_pbc_timeout) {
+			wsc_pr.selected_registrar =3D true;
+			wsc_pr.device_password_id =3D ap->wsc_dpid;
+			wsc_pr.selected_reg_config_methods =3D
+				WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
+		}
+
+		wsc_pr.response_type =3D WSC_RESPONSE_TYPE_AP;
+		memcpy(wsc_pr.uuid_e, ap->wsc_uuid_r, sizeof(wsc_pr.uuid_e));
+		wsc_pr.primary_device_type =3D
+			ap->config->wsc_primary_device_type;
+
+		if (ap->config->wsc_name)
+			l_strlcpy(wsc_pr.device_name, ap->config->wsc_name,
+					sizeof(wsc_pr.device_name));
+
+		wsc_pr.config_methods =3D
+			WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
+
+		if (ap->config->authorized_macs_num) {
+			size_t len;
+
+			len =3D ap->config->authorized_macs_num * 6;
+			if (len > sizeof(wsc_pr.authorized_macs))
+				len =3D sizeof(wsc_pr.authorized_macs);
+
+			memcpy(wsc_pr.authorized_macs,
+				ap->config->authorized_macs, len);
+		}
+
+		wsc_data =3D wsc_build_probe_response(&wsc_pr, &wsc_data_size);
+	} else if (type =3D=3D MPDU_MANAGEMENT_SUBTYPE_BEACON) {
+		struct wsc_beacon wsc_beacon =3D {};
+
+		wsc_beacon.version2 =3D true;
+		wsc_beacon.state =3D WSC_STATE_CONFIGURED;
+
+		if (ap->wsc_pbc_timeout) {
+			wsc_beacon.selected_registrar =3D true;
+			wsc_beacon.device_password_id =3D ap->wsc_dpid;
+			wsc_beacon.selected_reg_config_methods =3D
+				WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
+		}
+
+		if (ap->config->authorized_macs_num) {
+			size_t len;
+
+			len =3D ap->config->authorized_macs_num * 6;
+			if (len > sizeof(wsc_beacon.authorized_macs))
+				len =3D sizeof(wsc_beacon.authorized_macs);
+
+			memcpy(wsc_beacon.authorized_macs,
+				ap->config->authorized_macs, len);
+		}
+
+		wsc_data =3D wsc_build_beacon(&wsc_beacon, &wsc_data_size);
+	} else if (L_IN_SET(type, MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE,
+			MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE)) {
+		struct wsc_association_response wsc_resp =3D {};
+		struct sta_state *sta =3D
+			l_queue_find(ap->sta_states, ap_sta_match_addr, from);
+
+		if (!sta || sta->assoc_rsne)
+			return 0;
+
+		wsc_resp.response_type =3D WSC_RESPONSE_TYPE_AP;
+		wsc_resp.version2 =3D sta->wsc_v2;
+
+		wsc_data =3D wsc_build_association_response(&wsc_resp,
+								&wsc_data_size);
+	} else
+		return 0;
+
+	if (!wsc_data) {
+		l_error("wsc_build_<mgmt-subtype> error (stype 0x%x)", type);
+		return 0;
+	}
+
+	wsc_ie =3D ie_tlv_encapsulate_wsc_payload(wsc_data, wsc_data_size,
+						&wsc_ie_size);
+	l_free(wsc_data);
+
+	if (!wsc_ie) {
+		l_error("ie_tlv_encapsulate_wsc_payload error (stype 0x%x)",
+			type);
+		return 0;
+	}
+
+	memcpy(out_buf + len, wsc_ie, wsc_ie_size);
+	len +=3D wsc_ie_size;
+	l_free(wsc_ie);
+
+	return len;
+}
+
 static size_t ap_get_extra_ies_len(struct ap_state *ap,
 					enum mpdu_management_subtype type,
 					const struct mmpdu_header *client_frame,
@@ -473,6 +756,8 @@ static size_t ap_get_extra_ies_len(struct ap_state *ap,
 {
 	size_t len =3D 0;
 =

+	len +=3D ap_get_wsc_ie_len(ap, type, client_frame, client_frame_len);
+
 	if (ap->ops->get_extra_ies_len)
 		len +=3D ap->ops->get_extra_ies_len(type, client_frame,
 							client_frame_len,
@@ -489,6 +774,9 @@ static size_t ap_write_extra_ies(struct ap_state *ap,
 {
 	size_t len =3D 0;
 =

+	len +=3D ap_write_wsc_ie(ap, type, client_frame, client_frame_len,
+				out_buf + len);
+
 	if (ap->ops->write_extra_ies)
 		len +=3D ap->ops->write_extra_ies(type,
 						client_frame, client_frame_len,
@@ -580,10 +868,6 @@ static size_t ap_build_beacon_pr_tail(struct ap_state =
*ap,
 {
 	size_t len;
 	struct ie_rsn_info rsn;
-	uint8_t *wsc_data;
-	size_t wsc_data_size;
-	uint8_t *wsc_ie;
-	size_t wsc_ie_size;
 =

 	/* TODO: Country IE between TIM IE and RSNE */
 =

@@ -593,85 +877,6 @@ static size_t ap_build_beacon_pr_tail(struct ap_state =
*ap,
 		return 0;
 	len =3D 2 + out_buf[1];
 =

-	/* WSC IE */
-	if (stype =3D=3D MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE) {
-		struct wsc_probe_response wsc_pr =3D {};
-
-		wsc_pr.version2 =3D true;
-		wsc_pr.state =3D WSC_STATE_CONFIGURED;
-
-		if (ap->wsc_pbc_timeout) {
-			wsc_pr.selected_registrar =3D true;
-			wsc_pr.device_password_id =3D ap->wsc_dpid;
-			wsc_pr.selected_reg_config_methods =3D
-				WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
-		}
-
-		wsc_pr.response_type =3D WSC_RESPONSE_TYPE_AP;
-		memcpy(wsc_pr.uuid_e, ap->wsc_uuid_r, sizeof(wsc_pr.uuid_e));
-		wsc_pr.primary_device_type =3D
-			ap->config->wsc_primary_device_type;
-
-		if (ap->config->wsc_name)
-			l_strlcpy(wsc_pr.device_name, ap->config->wsc_name,
-					sizeof(wsc_pr.device_name));
-
-		wsc_pr.config_methods =3D
-			WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
-
-		if (ap->config->authorized_macs_num) {
-			size_t len;
-
-			len =3D ap->config->authorized_macs_num * 6;
-			if (len > sizeof(wsc_pr.authorized_macs))
-				len =3D sizeof(wsc_pr.authorized_macs);
-
-			memcpy(wsc_pr.authorized_macs,
-				ap->config->authorized_macs, len);
-		}
-
-		wsc_data =3D wsc_build_probe_response(&wsc_pr, &wsc_data_size);
-	} else {
-		struct wsc_beacon wsc_beacon =3D {};
-
-		wsc_beacon.version2 =3D true;
-		wsc_beacon.state =3D WSC_STATE_CONFIGURED;
-
-		if (ap->wsc_pbc_timeout) {
-			wsc_beacon.selected_registrar =3D true;
-			wsc_beacon.device_password_id =3D ap->wsc_dpid;
-			wsc_beacon.selected_reg_config_methods =3D
-				WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
-		}
-
-		if (ap->config->authorized_macs_num) {
-			size_t len;
-
-			len =3D ap->config->authorized_macs_num * 6;
-			if (len > sizeof(wsc_beacon.authorized_macs))
-				len =3D sizeof(wsc_beacon.authorized_macs);
-
-			memcpy(wsc_beacon.authorized_macs,
-				ap->config->authorized_macs, len);
-		}
-
-		wsc_data =3D wsc_build_beacon(&wsc_beacon, &wsc_data_size);
-	}
-
-	if (!wsc_data)
-		return 0;
-
-	wsc_ie =3D ie_tlv_encapsulate_wsc_payload(wsc_data, wsc_data_size,
-						&wsc_ie_size);
-	l_free(wsc_data);
-
-	if (!wsc_ie)
-		return 0;
-
-	memcpy(out_buf + len, wsc_ie, wsc_ie_size);
-	len +=3D wsc_ie_size;
-	l_free(wsc_ie);
-
 	len +=3D ap_write_extra_ies(ap, stype, req, req_len, out_buf + len);
 	return len;
 }
@@ -724,18 +929,6 @@ void ap_update_beacon(struct ap_state *ap)
 	l_error("Issuing SET_BEACON failed");
 }
 =

-static void ap_wsc_exit_pbc(struct ap_state *ap)
-{
-	if (!ap->wsc_pbc_timeout)
-		return;
-
-	l_timeout_remove(ap->wsc_pbc_timeout);
-	ap->wsc_dpid =3D 0;
-	ap_update_beacon(ap);
-
-	ap->ops->handle_event(AP_EVENT_PBC_MODE_EXIT, NULL, ap->user_data);
-}
-
 static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					const struct mmpdu_header *frame,
 					size_t frame_len,
@@ -858,24 +1051,6 @@ error:
 	ap_del_station(sta, MMPDU_REASON_CODE_UNSPECIFIED, true);
 }
 =

-struct ap_pbc_record_expiry_data {
-	uint64_t min_time;
-	const uint8_t *mac;
-};
-
-static bool ap_wsc_pbc_record_expire(void *data, void *user_data)
-{
-	struct ap_wsc_pbc_probe_record *record =3D data;
-	const struct ap_pbc_record_expiry_data *expiry_data =3D user_data;
-
-	if (record->timestamp > expiry_data->min_time &&
-			memcmp(record->mac, expiry_data->mac, 6))
-		return false;
-
-	l_free(record);
-	return true;
-}
-
 static void ap_stop_handshake_schedule(struct sta_state *sta)
 {
 	if (sta->stop_handshake_work)
@@ -1293,41 +1468,9 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, s=
truct sta_state *sta,
 	resp->ies[ies_len++] =3D count;
 	ies_len +=3D count;
 =

-	if (sta && !sta->assoc_rsne) {
-		struct wsc_association_response wsc_resp =3D {};
-		uint8_t *wsc_data;
-		size_t wsc_data_len;
-		uint8_t *wsc_ie;
-		size_t wsc_ie_len;
-
-		wsc_resp.response_type =3D WSC_RESPONSE_TYPE_AP;
-		wsc_resp.version2 =3D sta->wsc_v2;
-
-		wsc_data =3D wsc_build_association_response(&wsc_resp,
-								&wsc_data_len);
-		if (!wsc_data) {
-			l_error("wsc_build_beacon error");
-			goto send_frame;
-		}
-
-		wsc_ie =3D ie_tlv_encapsulate_wsc_payload(wsc_data, wsc_data_len,
-							&wsc_ie_len);
-		l_free(wsc_data);
-
-		if (!wsc_ie) {
-			l_error("ie_tlv_encapsulate_wsc_payload error");
-			goto send_frame;
-		}
-
-		memcpy(resp->ies + ies_len, wsc_ie, wsc_ie_len);
-		ies_len +=3D wsc_ie_len;
-		l_free(wsc_ie);
-	}
-
 	ies_len +=3D ap_write_extra_ies(ap, stype, req, req_len,
 					resp->ies + ies_len);
 =

-send_frame:
 	return ap_send_mgmt_frame(ap, mpdu, resp->ies + ies_len - mpdu_buf,
 					callback, sta);
 }
@@ -1704,118 +1847,6 @@ bad_frame:
 		l_error("Sending error Reassociation Response failed");
 }
 =

-#define AP_WSC_PBC_MONITOR_TIME	120
-#define AP_WSC_PBC_WALK_TIME	120
-
-static void ap_process_wsc_probe_req(struct ap_state *ap, const uint8_t *f=
rom,
-					const uint8_t *wsc_data,
-					size_t wsc_data_len)
-{
-	struct wsc_probe_request req;
-	struct ap_pbc_record_expiry_data expiry_data;
-	struct ap_wsc_pbc_probe_record *record;
-	uint64_t now;
-	bool empty;
-	uint8_t first_sta_addr[6] =3D {};
-	const struct l_queue_entry *entry;
-
-	if (wsc_parse_probe_request(wsc_data, wsc_data_len, &req) < 0)
-		return;
-
-	if (!(req.config_methods & WSC_CONFIGURATION_METHOD_PUSH_BUTTON))
-		return;
-
-	if (req.device_password_id !=3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON)
-		return;
-
-	/* Save the address of the first enrollee record */
-	record =3D l_queue_peek_head(ap->wsc_pbc_probes);
-	if (record)
-		memcpy(first_sta_addr, record->mac, 6);
-
-	now =3D l_time_now();
-
-	/*
-	 * Expire entries older than PBC Monitor Time.  While there also drop
-	 * older entries from the same Enrollee that sent us this new Probe
-	 * Request.  It's unclear whether we should also match by the UUID-E.
-	 */
-	expiry_data.min_time =3D now - AP_WSC_PBC_MONITOR_TIME * 1000000;
-	expiry_data.mac =3D from;
-	l_queue_foreach_remove(ap->wsc_pbc_probes, ap_wsc_pbc_record_expire,
-				&expiry_data);
-
-	empty =3D l_queue_isempty(ap->wsc_pbc_probes);
-
-	if (!ap->wsc_pbc_probes)
-		ap->wsc_pbc_probes =3D l_queue_new();
-
-	/* Add new record */
-	record =3D l_new(struct ap_wsc_pbc_probe_record, 1);
-	memcpy(record->mac, from, 6);
-	memcpy(record->uuid_e, req.uuid_e, sizeof(record->uuid_e));
-	record->timestamp =3D now;
-	l_queue_push_tail(ap->wsc_pbc_probes, record);
-
-	/*
-	 * If queue was non-empty and we've added one more record then we
-	 * now have seen more than one PBC enrollee during the PBC Monitor
-	 * Time and must exit "active PBC mode" due to "session overlap".
-	 * WSC v2.0.5 Section 11.3:
-	 * "Within the PBC Monitor Time, if the Registrar receives PBC
-	 * probe requests from more than one Enrollee [...] then the
-	 * Registrar SHALL signal a "session overlap" error.  As a result,
-	 * the Registrar shall refuse to enter active PBC mode and shall
-	 * also refuse to perform a PBC-based Registration Protocol
-	 * exchange [...]"
-	 */
-	if (empty)
-		return;
-
-	if (ap->wsc_pbc_timeout) {
-		l_debug("Exiting PBC mode due to Session Overlap");
-		ap_wsc_exit_pbc(ap);
-	}
-
-	/*
-	 * "If the Registrar is engaged in PBC Registration Protocol
-	 * exchange with an Enrollee and receives a Probe Request or M1
-	 * Message from another Enrollee, then the Registrar should
-	 * signal a "session overlap" error".
-	 *
-	 * For simplicity just interrupt the handshake with that enrollee.
-	 */
-	for (entry =3D l_queue_get_entries(ap->sta_states); entry;
-			entry =3D entry->next) {
-		struct sta_state *sta =3D entry->data;
-
-		if (!sta->associated || sta->assoc_rsne)
-			continue;
-
-		/*
-		 * Check whether this enrollee is in PBC Registration
-		 * Protocol by comparing its mac with the first (and only)
-		 * record we had in ap->wsc_pbc_probes.  If we had more
-		 * than one record we wouldn't have been in
-		 * "active PBC mode".
-		 */
-		if (memcmp(sta->addr, first_sta_addr, 6) ||
-				!memcmp(sta->addr, from, 6))
-			continue;
-
-		l_debug("Interrupting handshake with %s due to Session Overlap",
-			util_address_to_string(sta->addr));
-
-		if (sta->hs) {
-			netdev_handshake_failed(sta->hs,
-					MMPDU_REASON_CODE_DISASSOC_AP_BUSY);
-			sta->sm =3D NULL;
-		}
-
-		ap_remove_sta(sta);
-	}
-}
-
 static void ap_probe_resp_cb(int err, void *user_data)
 {
 	if (err =3D=3D -ECOMM)
@@ -1847,8 +1878,6 @@ static void ap_probe_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 		l_malloc(512 + ap_get_extra_ies_len(ap,
 				MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE, hdr,
 				body + body_len - (void *) hdr));
-	uint8_t *wsc_data;
-	ssize_t wsc_data_len;
 =

 	l_info("AP Probe Request from %s",
 		util_address_to_string(hdr->address_2));
@@ -1921,18 +1950,6 @@ static void ap_probe_req_cb(const struct mmpdu_heade=
r *hdr, const void *body,
 	if (!match)
 		return;
 =

-	/*
-	 * Process the WSC IE first as it may cause us to exit "active PBC
-	 * mode" and that can be immediately reflected in our Probe Response.
-	 */
-	wsc_data =3D ie_tlv_extract_wsc_payload(req->ies, body_len - sizeof(*req),
-						&wsc_data_len);
-	if (wsc_data) {
-		ap_process_wsc_probe_req(ap, hdr->address_2,
-						wsc_data, wsc_data_len);
-		l_free(wsc_data);
-	}
-
 	len =3D ap_build_beacon_pr_head(ap,
 					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
 					hdr->address_2, resp, sizeof(resp));
-- =

2.27.0

--===============7341263317173752499==--

