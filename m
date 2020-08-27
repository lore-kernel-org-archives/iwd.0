Content-Type: multipart/mixed; boundary="===============8951987816275483804=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/11] ap: WSC Probe Request processing logic
Date: Thu, 27 Aug 2020 20:14:51 +0200
Message-ID: <20200827181453.61823-9-andrew.zaborowski@intel.com>
In-Reply-To: <20200827181453.61823-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8951987816275483804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement the caching of WSC probe requests -- when an Enrollee later
associates to start registration we need to have its Probe Request on
file.  Also use this cache for PBC "Session Overlap" detection.
---
 src/ap.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index b1e57a23..df29a2fb 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -65,6 +65,7 @@ struct ap_state {
 	uint32_t mlme_watch;
 	uint8_t gtk[CRYPTO_MAX_GTK_LEN];
 	uint8_t gtk_index;
+	struct l_queue *wsc_pbc_probes;
 	struct l_timeout *wsc_pbc_timeout;
 	uint16_t wsc_dpid;
 	uint8_t wsc_uuid_r[16];
@@ -92,6 +93,12 @@ struct sta_state {
 	uint32_t gtk_query_cmd_id;
 };
 =

+struct ap_wsc_pbc_probe_record {
+	uint8_t mac[6];
+	uint8_t uuid_e[16];
+	uint64_t timestamp;
+};
+
 static uint32_t netdev_watch;
 =

 void ap_config_free(struct ap_config *config)
@@ -165,6 +172,8 @@ static void ap_reset(struct ap_state *ap)
 	ap_config_free(ap->config);
 	ap->config =3D NULL;
 =

+	l_queue_destroy(ap->wsc_pbc_probes, l_free);
+
 	ap->started =3D false;
 }
 =

@@ -645,6 +654,24 @@ error:
 	ap_del_station(sta, MMPDU_REASON_CODE_UNSPECIFIED, true);
 }
 =

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
 static struct l_genl_msg *ap_build_cmd_del_key(struct ap_state *ap)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
@@ -1215,6 +1242,115 @@ bad_frame:
 #define AP_WSC_PBC_MONITOR_TIME	120
 #define AP_WSC_PBC_WALK_TIME	120
 =

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
 static void ap_probe_resp_cb(struct l_genl_msg *msg, void *user_data)
 {
 	if (l_genl_msg_get_error(msg) < 0)
@@ -1241,6 +1377,8 @@ static void ap_probe_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 	const uint8_t *bssid =3D netdev_get_address(ap->netdev);
 	bool match =3D false;
 	uint8_t resp[512];
+	uint8_t *wsc_data;
+	ssize_t wsc_data_len;
 =

 	l_info("AP Probe Request from %s",
 		util_address_to_string(hdr->address_2));
@@ -1310,6 +1448,18 @@ static void ap_probe_req_cb(const struct mmpdu_heade=
r *hdr, const void *body,
 	if (!match)
 		return;
 =

+	/*
+	 * Process the WSC IE first as it may cause us to exit "active PBC
+	 * mode" and that can be immediately reflected in our Probe Response.
+	 */
+	wsc_data =3D ie_tlv_extract_wsc_payload(req->ies, body_len - sizeof(*req),
+						&wsc_data_len);
+	if (wsc_data) {
+		ap_process_wsc_probe_req(ap, hdr->address_2,
+						wsc_data, wsc_data_len);
+		l_free(wsc_data);
+	}
+
 	len =3D ap_build_beacon_pr_head(ap,
 					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
 					hdr->address_2, resp, sizeof(resp));
@@ -1882,6 +2032,11 @@ bool ap_push_button(struct ap_state *ap)
 	if (!ap->started)
 		return false;
 =

+	if (l_queue_length(ap->wsc_pbc_probes) > 1) {
+		l_debug("Can't start PBC mode due to Session Overlap");
+		return false;
+	}
+
 	/*
 	 * WSC v2.0.5 Section 11.3: "Multiple presses of the button are
 	 * permitted.  If a PBC button on an Enrollee or Registrar is
-- =

2.25.1

--===============8951987816275483804==--

