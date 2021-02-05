Content-Type: multipart/mixed; boundary="===============4361289502898235311=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] ap: Pass vendor IEs between frames and the user
Date: Sat, 06 Feb 2021 00:46:48 +0100
Message-ID: <20210205234651.139105-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4361289502898235311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add API for the ap.h users to add extra vendor IEs to outgoing
management frames (beacons, etc.).  Pass the string IEs from the
incoming STA association frames to the user in the AP event data.

I drop ap_event_station_added_data.rsn_ie because that probably
wasn't going to ever be useful and the RSN IE is included in the
assoc_ies array in any case.
---
 src/ap.c | 233 ++++++++++++++++++++++++++++++++++++++++---------------
 src/ap.h |  15 +++-
 2 files changed, 186 insertions(+), 62 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 8ea26a0d..dbc624c2 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -75,6 +75,8 @@ struct ap_state {
 	uint16_t wsc_dpid;
 	uint8_t wsc_uuid_r[16];
 =

+	struct l_queue *vendor_ie_writers;
+
 	uint16_t last_aid;
 	struct l_queue *sta_states;
 =

@@ -99,6 +101,8 @@ struct sta_state {
 	struct l_uintset *rates;
 	uint32_t assoc_resp_cmd_id;
 	struct ap_state *ap;
+	uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 	uint8_t *assoc_rsne;
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
@@ -127,6 +131,12 @@ struct ap_ip_pool {
 	struct l_uintset *used;
 };
 =

+struct ap_vendor_ie_writer {
+	ap_get_vendor_ie_len get_len_func;
+	ap_write_vendor_ie write_func;
+	void *user_data;
+};
+
 struct ap_ip_pool pool;
 static uint32_t netdev_watch;
 struct l_netlink *rtnl;
@@ -279,7 +289,7 @@ static void ap_sta_free(void *data)
 	struct ap_state *ap =3D sta->ap;
 =

 	l_uintset_free(sta->rates);
-	l_free(sta->assoc_rsne);
+	l_free(sta->assoc_ies);
 =

 	if (sta->assoc_resp_cmd_id)
 		l_genl_family_cancel(ap->nl80211, sta->assoc_resp_cmd_id);
@@ -411,7 +421,8 @@ static void ap_new_rsna(struct sta_state *sta)
 	if (ap->ops->handle_event) {
 		struct ap_event_station_added_data event_data =3D {};
 		event_data.mac =3D sta->addr;
-		event_data.rsn_ie =3D sta->assoc_rsne;
+		event_data.assoc_ies =3D sta->assoc_ies;
+		event_data.assoc_ies_len =3D sta->assoc_ies_len;
 		ap->ops->handle_event(AP_EVENT_STATION_ADDED, &event_data,
 					ap->user_data);
 	}
@@ -463,11 +474,51 @@ static void ap_set_rsn_info(struct ap_state *ap, stru=
ct ie_rsn_info *rsn)
 	rsn->group_cipher =3D ap->group_cipher;
 }
 =

+static size_t ap_get_vendor_ies_len(struct ap_state *ap,
+					enum mpdu_management_subtype type)
+{
+	const struct l_queue_entry *entry;
+	size_t len =3D 0;
+
+	for (entry =3D l_queue_get_entries(ap->sta_states); entry;
+			entry =3D entry->next) {
+		struct ap_vendor_ie_writer *writer =3D entry->data;
+
+		len +=3D writer->get_len_func(type, writer->user_data);
+	}
+
+	return len;
+}
+
+static size_t ap_write_vendor_ies(struct ap_state *ap,
+					enum mpdu_management_subtype type,
+					uint8_t *out_buf)
+{
+	const struct l_queue_entry *entry;
+	size_t len =3D 0;
+
+	for (entry =3D l_queue_get_entries(ap->sta_states); entry;
+			entry =3D entry->next) {
+		struct ap_vendor_ie_writer *writer =3D entry->data;
+
+		len +=3D writer->write_func(type, out_buf + len,
+						writer->user_data);
+	}
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
@@ -533,15 +584,12 @@ static size_t ap_build_beacon_pr_head(struct ap_state=
 *ap,
 }
 =

 /* Beacon / Probe Response frame portion after the TIM IE */
-static size_t ap_build_beacon_pr_tail(struct ap_state *ap, bool pr,
+static size_t ap_build_beacon_pr_tail(struct ap_state *ap,
+					enum mpdu_management_subtype stype,
 					uint8_t *out_buf)
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

@@ -551,8 +599,71 @@ static size_t ap_build_beacon_pr_tail(struct ap_state =
*ap, bool pr,
 		return 0;
 	len =3D 2 + out_buf[1];
 =

+	len +=3D ap_write_vendor_ies(ap, stype, out_buf + len);
+	return len;
+}
+
+static void ap_set_beacon_cb(struct l_genl_msg *msg, void *user_data)
+{
+	int error =3D l_genl_msg_get_error(msg);
+
+	if (error < 0)
+		l_error("SET_BEACON failed: %s (%i)", strerror(-error), -error);
+}
+
+static void ap_update_beacon(struct ap_state *ap)
+{
+	struct l_genl_msg *cmd;
+	uint8_t head[256];
+	uint8_t tail[256 + ap_get_vendor_ies_len(ap,
+					MPDU_MANAGEMENT_SUBTYPE_BEACON)];
+	size_t head_len, tail_len;
+	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
+	static const uint8_t bcast_addr[6] =3D {
+		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	};
+
+	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						bcast_addr, head, sizeof(head));
+	tail_len =3D ap_build_beacon_pr_tail(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						tail);
+	if (L_WARN_ON(!head_len || !tail_len))
+		return;
+
+	cmd =3D l_genl_msg_new_sized(NL80211_CMD_SET_BEACON,
+					32 + head_len + tail_len);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_WDEV, 8, &wdev_id);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_BEACON_HEAD, head_len, head);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_BEACON_TAIL, tail_len, tail);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_IE, 0, "");
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_IE_PROBE_RESP, 0, "");
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_IE_ASSOC_RESP, 0, "");
+
+	if (l_genl_family_send(ap->nl80211, cmd, ap_set_beacon_cb, NULL, NULL))
+		return;
+
+	l_genl_msg_unref(cmd);
+	l_error("Issuing SET_BEACON failed");
+}
+
+static size_t ap_get_wsc_ie_len(enum mpdu_management_subtype type,
+				void *user_data)
+{
+	return 256;
+}
+
+static size_t ap_write_wsc_ie(enum mpdu_management_subtype type,
+				uint8_t *out_buf, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+	uint8_t *wsc_data;
+	size_t wsc_data_size;
+	uint8_t *wsc_ie;
+	size_t wsc_ie_size;
+	size_t len =3D 0;
+
 	/* WSC IE */
-	if (pr) {
+	if (type =3D=3D MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE) {
 		struct wsc_probe_response wsc_pr =3D {};
 =

 		wsc_pr.version2 =3D true;
@@ -633,46 +744,6 @@ static size_t ap_build_beacon_pr_tail(struct ap_state =
*ap, bool pr,
 	return len;
 }
 =

-static void ap_set_beacon_cb(struct l_genl_msg *msg, void *user_data)
-{
-	int error =3D l_genl_msg_get_error(msg);
-
-	if (error < 0)
-		l_error("SET_BEACON failed: %s (%i)", strerror(-error), -error);
-}
-
-static void ap_update_beacon(struct ap_state *ap)
-{
-	struct l_genl_msg *cmd;
-	uint8_t head[256], tail[256];
-	size_t head_len, tail_len;
-	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
-	static const uint8_t bcast_addr[6] =3D {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-	};
-
-	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
-						bcast_addr, head, sizeof(head));
-	tail_len =3D ap_build_beacon_pr_tail(ap, false, tail);
-	if (L_WARN_ON(!head_len || !tail_len))
-		return;
-
-	cmd =3D l_genl_msg_new_sized(NL80211_CMD_SET_BEACON,
-					32 + head_len + tail_len);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_WDEV, 8, &wdev_id);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_BEACON_HEAD, head_len, head);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_BEACON_TAIL, tail_len, tail);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_IE, 0, "");
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_IE_PROBE_RESP, 0, "");
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_IE_ASSOC_RESP, 0, "");
-
-	if (l_genl_family_send(ap->nl80211, cmd, ap_set_beacon_cb, NULL, NULL))
-		return;
-
-	l_genl_msg_unref(cmd);
-	l_error("Issuing SET_BEACON failed");
-}
-
 static void ap_wsc_exit_pbc(struct ap_state *ap)
 {
 	if (!ap->wsc_pbc_timeout)
@@ -1194,7 +1265,10 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, s=
truct sta_state *sta,
 				bool reassoc, frame_xchg_cb_t callback)
 {
 	const uint8_t *addr =3D netdev_get_address(ap->netdev);
-	uint8_t mpdu_buf[128];
+	enum mpdu_management_subtype stype =3D reassoc ?
+		MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE :
+		MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE;
+	uint8_t mpdu_buf[128 + ap_get_vendor_ies_len(ap, stype)];
 	struct mmpdu_header *mpdu =3D (void *) mpdu_buf;
 	struct mmpdu_association_response *resp;
 	size_t ies_len =3D 0;
@@ -1206,9 +1280,7 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, st=
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
@@ -1270,6 +1342,8 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, st=
ruct sta_state *sta,
 		l_free(wsc_ie);
 	}
 =

+	ies_len +=3D ap_write_vendor_ies(ap, stype, resp->ies + ies_len);
+
 send_frame:
 	return ap_send_mgmt_frame(ap, mpdu, resp->ies + ies_len - mpdu_buf,
 					callback, sta);
@@ -1471,6 +1545,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 		sta->wsc_v2 =3D wsc_req.version2;
 =

 		event_data.mac =3D sta->addr;
+		event_data.assoc_ies =3D ies;
+		event_data.assoc_ies_len =3D ies_len;
 		ap->ops->handle_event(AP_EVENT_REGISTRATION_START, &event_data,
 					ap->user_data);
 =

@@ -1521,13 +1597,16 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 =

 	sta->rates =3D rates;
 =

-	if (sta->assoc_rsne)
-		l_free(sta->assoc_rsne);
+	l_free(sta->assoc_ies);
 =

-	if (rsn)
-		sta->assoc_rsne =3D l_memdup(rsn, rsn[1] + 2);
-	else
+	if (rsn) {
+		sta->assoc_ies =3D l_memdup(ies, ies_len);
+		sta->assoc_ies_len =3D ies_len;
+		sta->assoc_rsne =3D sta->assoc_ies + (rsn - ies);
+	} else {
+		sta->assoc_ies =3D NULL;
 		sta->assoc_rsne =3D NULL;
+	}
 =

 	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, 0, reassoc,
 						ap_success_assoc_resp_cb);
@@ -1774,7 +1853,8 @@ static void ap_probe_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 	struct ie_tlv_iter iter;
 	const uint8_t *bssid =3D netdev_get_address(ap->netdev);
 	bool match =3D false;
-	uint8_t resp[512];
+	uint8_t resp[512 + ap_get_vendor_ies_len(ap,
+				MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE)];
 	uint8_t *wsc_data;
 	ssize_t wsc_data_len;
 =

@@ -1864,7 +1944,9 @@ static void ap_probe_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 	len =3D ap_build_beacon_pr_head(ap,
 					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
 					hdr->address_2, resp, sizeof(resp));
-	len +=3D ap_build_beacon_pr_tail(ap, true, resp + len);
+	len +=3D ap_build_beacon_pr_tail(ap,
+					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
+					resp + len);
 =

 	ap_send_mgmt_frame(ap, (struct mmpdu_header *) resp, len,
 				ap_probe_resp_cb, NULL);
@@ -2102,7 +2184,9 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 {
 	struct l_genl_msg *cmd;
 =

-	uint8_t head[256], tail[256];
+	uint8_t head[256];
+	uint8_t tail[256 + ap_get_vendor_ies_len(ap,
+					MPDU_MANAGEMENT_SUBTYPE_BEACON)];
 	size_t head_len, tail_len;
 =

 	uint32_t dtim_period =3D 3;
@@ -2132,7 +2216,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 =

 	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
-	tail_len =3D ap_build_beacon_pr_tail(ap, false, tail);
+	tail_len =3D ap_build_beacon_pr_tail(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						tail);
 =

 	if (!head_len || !tail_len)
 		return NULL;
@@ -2697,6 +2782,7 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	}
 =

 	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
+	ap_add_vendor_ie_writer(ap, ap_get_wsc_ie_len, ap_write_wsc_ie, ap);
 =

 	if (config->passphrase[0] &&
 			crypto_psk_from_passphrase(config->passphrase,
@@ -2876,9 +2962,34 @@ void ap_free(struct ap_state *ap)
 	l_genl_family_free(ap->nl80211);
 	if (ap->server)
 		l_dhcp_server_destroy(ap->server);
+
+	l_queue_destroy(ap->vendor_ie_writers, l_free);
 	l_free(ap);
 }
 =

+void ap_add_vendor_ie_writer(struct ap_state *ap,
+				ap_get_vendor_ie_len get_len_func,
+				ap_write_vendor_ie write_func,
+				void *user_data)
+{
+	struct ap_vendor_ie_writer *writer =3D
+		l_new(struct ap_vendor_ie_writer, 1);
+
+	writer->get_len_func =3D get_len_func;
+	writer->write_func =3D write_func;
+	writer->user_data =3D user_data;
+
+	if (!ap->vendor_ie_writers)
+		ap->vendor_ie_writers =3D l_queue_new();
+
+	/*
+	 * It doesn't look like vendor IEs need to be ordered in a specific
+	 * way so just append at the end, but if needed we can take an OUI
+	 * parameter and switch to inserting at the right place in the queue.
+	 */
+	l_queue_push_tail(ap->vendor_ie_writers, writer);
+}
+
 bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
 				enum mmpdu_reason_code reason)
 {
diff --git a/src/ap.h b/src/ap.h
index dc57a0bb..eb4f96df 100644
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
@@ -36,7 +37,8 @@ enum ap_event_type {
 =

 struct ap_event_station_added_data {
 	const uint8_t *mac;
-	const uint8_t *rsn_ie;
+	const uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 };
 =

 struct ap_event_station_removed_data {
@@ -46,6 +48,8 @@ struct ap_event_station_removed_data {
 =

 struct ap_event_registration_start_data {
 	const uint8_t *mac;
+	const uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 };
 =

 struct ap_event_registration_success_data {
@@ -53,6 +57,10 @@ struct ap_event_registration_success_data {
 };
 =

 typedef void (*ap_stopped_func_t)(void *user_data);
+typedef size_t (*ap_get_vendor_ie_len)(enum mpdu_management_subtype type,
+					void *user_data);
+typedef size_t (*ap_write_vendor_ie)(enum mpdu_management_subtype type,
+					uint8_t *out_buf, void *user_data);
 =

 struct ap_config {
 	char *ssid;
@@ -83,6 +91,11 @@ void ap_shutdown(struct ap_state *ap, ap_stopped_func_t =
stopped_func,
 			void *user_data);
 void ap_free(struct ap_state *ap);
 =

+void ap_add_vendor_ie_writer(struct ap_state *ap,
+				ap_get_vendor_ie_len get_len_func,
+				ap_write_vendor_ie write_func,
+				void *user_data);
+
 bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
 				enum mmpdu_reason_code reason);
 =

-- =

2.27.0

--===============4361289502898235311==--

