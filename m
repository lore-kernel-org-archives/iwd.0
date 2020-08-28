Content-Type: multipart/mixed; boundary="===============5437885229721771213=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/8] ap: Push Button mode API and beacon changes
Date: Fri, 28 Aug 2020 14:46:46 +0200
Message-ID: <20200828124649.78677-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200828124649.78677-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5437885229721771213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds the API for putting the AP in Push Button mode, which we'll
need to P2P GO side but may be useful on its own too.  A WSC IE is added
to our beacons and probe responses indicating whether the PBC mode is
active.
---
 src/ap.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/ap.h |  15 ++++
 2 files changed, 217 insertions(+), 3 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index fa7d030a..ce776553 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -45,6 +45,7 @@
 #include "src/dbus.h"
 #include "src/nl80211util.h"
 #include "src/frame-xchg.h"
+#include "src/wscutil.h"
 #include "src/ap.h"
 =

 struct ap_state {
@@ -64,6 +65,9 @@ struct ap_state {
 	uint32_t mlme_watch;
 	uint8_t gtk[CRYPTO_MAX_GTK_LEN];
 	uint8_t gtk_index;
+	struct l_timeout *wsc_pbc_timeout;
+	uint16_t wsc_dpid;
+	uint8_t wsc_uuid_r[16];
 =

 	uint16_t last_aid;
 	struct l_queue *sta_states;
@@ -103,6 +107,7 @@ void ap_config_free(struct ap_config *config)
 	}
 =

 	l_free(config->authorized_macs);
+	l_free(config->wsc_name);
 	l_free(config);
 }
 =

@@ -358,10 +363,15 @@ static size_t ap_build_beacon_pr_head(struct ap_state=
 *ap,
 }
 =

 /* Beacon / Probe Response frame portion after the TIM IE */
-static size_t ap_build_beacon_pr_tail(struct ap_state *ap, uint8_t *out_bu=
f)
+static size_t ap_build_beacon_pr_tail(struct ap_state *ap, bool pr,
+					uint8_t *out_buf)
 {
 	size_t len;
 	struct ie_rsn_info rsn;
+	uint8_t *wsc_data;
+	size_t wsc_data_size;
+	uint8_t *wsc_ie;
+	size_t wsc_ie_size;
 =

 	/* TODO: Country IE between TIM IE and RSNE */
 =

@@ -371,9 +381,140 @@ static size_t ap_build_beacon_pr_tail(struct ap_state=
 *ap, uint8_t *out_buf)
 		return 0;
 	len =3D 2 + out_buf[1];
 =

+	/* WSC IE */
+	if (pr) {
+		struct wsc_probe_response wsc_pr =3D {};
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
+	} else {
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
+	}
+
+	if (!wsc_data)
+		return 0;
+
+	wsc_ie =3D ie_tlv_encapsulate_wsc_payload(wsc_data, wsc_data_size,
+						&wsc_ie_size);
+	l_free(wsc_data);
+
+	if (!wsc_ie)
+		return 0;
+
+	memcpy(out_buf + len, wsc_ie, wsc_ie_size);
+	len +=3D wsc_ie_size;
+	l_free(wsc_ie);
+
 	return len;
 }
 =

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
+	uint8_t head[256], tail[256];
+	size_t head_len, tail_len;
+	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
+	static const uint8_t bcast_addr[6] =3D {
+		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	};
+
+	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						bcast_addr, head, sizeof(head));
+	tail_len =3D ap_build_beacon_pr_tail(ap, false, tail);
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
+static void ap_wsc_exit_pbc(struct ap_state *ap)
+{
+	if (!ap->wsc_pbc_timeout)
+		return;
+
+	l_timeout_remove(ap->wsc_pbc_timeout);
+	ap->wsc_dpid =3D 0;
+	ap_update_beacon(ap);
+
+	ap->event_func(AP_EVENT_PBC_MODE_EXIT, NULL, ap->user_data);
+}
+
 static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					const struct mmpdu_header *frame,
 					size_t frame_len, bool wait_ack,
@@ -1069,6 +1210,9 @@ bad_frame:
 		l_error("Sending error Reassociation Response failed");
 }
 =

+#define AP_WSC_PBC_MONITOR_TIME	120
+#define AP_WSC_PBC_WALK_TIME	120
+
 static void ap_probe_resp_cb(struct l_genl_msg *msg, void *user_data)
 {
 	if (l_genl_msg_get_error(msg) < 0)
@@ -1167,7 +1311,7 @@ static void ap_probe_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 	len =3D ap_build_beacon_pr_head(ap,
 					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
 					hdr->address_2, resp, sizeof(resp));
-	len +=3D ap_build_beacon_pr_tail(ap, resp + len);
+	len +=3D ap_build_beacon_pr_tail(ap, true, resp + len);
 =

 	ap_send_mgmt_frame(ap, (struct mmpdu_header *) resp, len, false,
 				ap_probe_resp_cb, NULL);
@@ -1397,7 +1541,7 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 =

 	head_len =3D ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
-	tail_len =3D ap_build_beacon_pr_tail(ap, tail);
+	tail_len =3D ap_build_beacon_pr_tail(ap, false, tail);
 =

 	if (!head_len || !tail_len)
 		return NULL;
@@ -1501,6 +1645,17 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 		/* TODO: Start a Get Survey to decide the channel */
 		config->channel =3D 6;
 =

+	if (!config->wsc_name)
+		config->wsc_name =3D l_strdup(config->ssid);
+
+	if (!config->wsc_primary_device_type.category) {
+		/* Make ourselves a WFA standard PC by default */
+		config->wsc_primary_device_type.category =3D 1;
+		memcpy(config->wsc_primary_device_type.oui, wsc_wfa_oui, 3);
+		config->wsc_primary_device_type.oui_type =3D 0x04;
+		config->wsc_primary_device_type.subcategory =3D 1;
+	}
+
 	/* TODO: Add all ciphers supported by wiphy */
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
@@ -1523,6 +1678,8 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 		l_uintset_put(ap->rates, 22); /* 11 Mbps*/
 	}
 =

+	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
+
 	if (crypto_psk_from_passphrase(config->psk, (uint8_t *) config->ssid,
 					strlen(config->ssid), ap->pmk) < 0)
 		goto error;
@@ -1702,6 +1859,45 @@ bool ap_station_disconnect(struct ap_state *ap, cons=
t uint8_t *mac,
 	return true;
 }
 =

+static void ap_wsc_pbc_timeout_cb(struct l_timeout *timeout, void *user_da=
ta)
+{
+	struct ap_state *ap =3D user_data;
+
+	l_debug("PBC mode timeout");
+	ap_wsc_exit_pbc(ap);
+}
+
+static void ap_wsc_pbc_timeout_destroy(void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+
+	ap->wsc_pbc_timeout =3D NULL;
+}
+
+bool ap_push_button(struct ap_state *ap)
+{
+	if (!ap->started)
+		return false;
+
+	/*
+	 * WSC v2.0.5 Section 11.3: "Multiple presses of the button are
+	 * permitted.  If a PBC button on an Enrollee or Registrar is
+	 * pressed again during Walk Time, the timers for that device are
+	 * restarted at that time [...]"
+	 */
+	if (ap->wsc_pbc_timeout) {
+		l_timeout_modify(ap->wsc_pbc_timeout, AP_WSC_PBC_WALK_TIME);
+		return true;
+	}
+
+	ap->wsc_pbc_timeout =3D l_timeout_create(AP_WSC_PBC_WALK_TIME,
+						ap_wsc_pbc_timeout_cb, ap,
+						ap_wsc_pbc_timeout_destroy);
+	ap->wsc_dpid =3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON;
+	ap_update_beacon(ap);
+	return true;
+}
+
 struct ap_if_data {
 	struct netdev *netdev;
 	struct ap_state *ap;
@@ -1747,6 +1943,9 @@ static void ap_if_event_func(enum ap_event_type type,=
 const void *event_data,
 =

 	case AP_EVENT_STATION_ADDED:
 	case AP_EVENT_STATION_REMOVED:
+	case AP_EVENT_REGISTRATION_START:
+	case AP_EVENT_REGISTRATION_SUCCESS:
+	case AP_EVENT_PBC_MODE_EXIT:
 		/* Ignored */
 		break;
 	}
diff --git a/src/ap.h b/src/ap.h
index 330ae011..cb5238d1 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -29,6 +29,9 @@ enum ap_event_type {
 	AP_EVENT_STOPPING,
 	AP_EVENT_STATION_ADDED,
 	AP_EVENT_STATION_REMOVED,
+	AP_EVENT_REGISTRATION_START,
+	AP_EVENT_REGISTRATION_SUCCESS,
+	AP_EVENT_PBC_MODE_EXIT,
 };
 =

 struct ap_event_station_added_data {
@@ -41,6 +44,14 @@ struct ap_event_station_removed_data {
 	enum mmpdu_reason_code reason;
 };
 =

+struct ap_event_registration_start_data {
+	const uint8_t *mac;
+};
+
+struct ap_event_registration_success_data {
+	const uint8_t *mac;
+};
+
 typedef void (*ap_event_func_t)(enum ap_event_type type, const void *event=
_data,
 				void *user_data);
 typedef void (*ap_stopped_func_t)(void *user_data);
@@ -51,6 +62,8 @@ struct ap_config {
 	uint8_t channel;
 	uint8_t *authorized_macs;
 	unsigned int authorized_macs_num;
+	char *wsc_name;
+	struct wsc_primary_device_type wsc_primary_device_type;
 	bool no_cck_rates : 1;
 };
 =

@@ -64,3 +77,5 @@ void ap_free(struct ap_state *ap);
 =

 bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
 				enum mmpdu_reason_code reason);
+
+bool ap_push_button(struct ap_state *ap);
-- =

2.25.1

--===============5437885229721771213==--

