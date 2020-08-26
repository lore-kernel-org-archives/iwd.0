Content-Type: multipart/mixed; boundary="===============9200423199287215404=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] ap: Move AP parameters to a struct
Date: Wed, 26 Aug 2020 02:18:53 +0200
Message-ID: <20200826001854.502627-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9200423199287215404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To limit the number of ap_start parameters, group basic AP config
parameters in the ap_config struct that is passed as a pointer and owned
by the ap_state.
---
 src/ap.c | 134 +++++++++++++++++++++++++++++++------------------------
 src/ap.h |  23 ++++++++--
 2 files changed, 96 insertions(+), 61 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 51ee23a8..ff8ced18 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -53,10 +53,7 @@ struct ap_state {
 	ap_event_func_t event_func;
 	ap_stopped_func_t stopped_func;
 	void *user_data;
-	char *ssid;
-	uint8_t channel;
-	uint8_t *authorized_macs;
-	int authorized_macs_num;
+	struct ap_config *config;
 =

 	unsigned int ciphers;
 	enum ie_rsn_cipher_suite group_cipher;
@@ -73,7 +70,6 @@ struct ap_state {
 =

 	bool started : 1;
 	bool gtk_set : 1;
-	bool no_cck_rates : 1;
 };
 =

 struct sta_state {
@@ -94,6 +90,30 @@ struct sta_state {
 =

 static uint32_t netdev_watch;
 =

+void ap_config_free(struct ap_config *config)
+{
+	if (unlikely(!config))
+		return;
+
+	l_free(config->ssid);
+
+	if (config->psk) {
+		explicit_bzero(config->psk, strlen(config->psk));
+		l_free(config->psk);
+	}
+
+	if (config->authorized_macs) {
+		uint8_t **mac;
+
+		for (mac =3D config->authorized_macs; *mac; mac++)
+			l_free(mac);
+
+		l_free(config->authorized_macs);
+	}
+
+	l_free(config);
+}
+
 static void ap_sta_free(void *data)
 {
 	struct sta_state *sta =3D data;
@@ -121,8 +141,6 @@ static void ap_reset(struct ap_state *ap)
 {
 	struct netdev *netdev =3D ap->netdev;
 =

-	l_free(ap->ssid);
-
 	explicit_bzero(ap->pmk, sizeof(ap->pmk));
 =

 	if (ap->mlme_watch)
@@ -138,7 +156,9 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->rates)
 		l_uintset_free(ap->rates);
 =

-	l_free(ap->authorized_macs);
+	ap_config_free(ap->config);
+	ap->config =3D NULL;
+
 	ap->started =3D false;
 }
 =

@@ -318,7 +338,8 @@ static size_t ap_build_beacon_pr_head(struct ap_state *=
ap,
 =

 	/* SSID IE */
 	ie_tlv_builder_next(&builder, IE_TYPE_SSID);
-	ie_tlv_builder_set_data(&builder, ap->ssid, strlen(ap->ssid));
+	ie_tlv_builder_set_data(&builder, ap->config->ssid,
+				strlen(ap->config->ssid));
 =

 	/* Supported Rates IE */
 	ie_tlv_builder_next(&builder, IE_TYPE_SUPPORTED_RATES);
@@ -343,7 +364,7 @@ static size_t ap_build_beacon_pr_head(struct ap_state *=
ap,
 =

 	/* DSSS Parameter Set IE for DSSS, HR, ERP and HT PHY rates */
 	ie_tlv_builder_next(&builder, IE_TYPE_DSSS_PARAMETER_SET);
-	ie_tlv_builder_set_data(&builder, &ap->channel, 1);
+	ie_tlv_builder_set_data(&builder, &ap->config->channel, 1);
 =

 	ie_tlv_builder_finalize(&builder, &len);
 	return 36 + len;
@@ -375,7 +396,8 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 	struct l_genl_msg *msg;
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
 	uint32_t id;
-	uint32_t ch_freq =3D scan_channel_to_freq(ap->channel, SCAN_BAND_2_4_GHZ);
+	uint32_t ch_freq =3D scan_channel_to_freq(ap->config->channel,
+						SCAN_BAND_2_4_GHZ);
 =

 	msg =3D l_genl_msg_new_sized(NL80211_CMD_FRAME, 128 + frame_len);
 =

@@ -386,7 +408,7 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 		l_genl_msg_append_attr(msg, NL80211_ATTR_DONT_WAIT_FOR_ACK,
 					0, NULL);
 =

-	if (ap->no_cck_rates)
+	if (ap->config->no_cck_rates)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0,
 					NULL);
 =

@@ -446,7 +468,8 @@ static void ap_start_rsna(struct sta_state *sta, const =
uint8_t *gtk_rsc)
 	sta->hs =3D netdev_handshake_state_new(netdev);
 =

 	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
-	handshake_state_set_ssid(sta->hs, (void *)ap->ssid, strlen(ap->ssid));
+	handshake_state_set_ssid(sta->hs, (void *) ap->config->ssid,
+					strlen(ap->config->ssid));
 	handshake_state_set_authenticator(sta->hs, true);
 	handshake_state_set_authenticator_ie(sta->hs, bss_rsne);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
@@ -900,8 +923,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, boo=
l reassoc,
 			break;
 		}
 =

-	if (!rates || !ssid || !rsn || ssid_len !=3D strlen(ap->ssid) ||
-			memcmp(ssid, ap->ssid, ssid_len)) {
+	if (!rates || !ssid || !rsn || ssid_len !=3D strlen(ap->config->ssid) ||
+			memcmp(ssid, ap->config->ssid, ssid_len)) {
 		err =3D MMPDU_REASON_CODE_INVALID_IE;
 		goto bad_frame;
 	}
@@ -1125,8 +1148,8 @@ static void ap_probe_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 =

 	if (!ssid || ssid_len =3D=3D 0) /* Wildcard SSID */
 		match =3D true;
-	else if (ssid && ssid_len =3D=3D strlen(ap->ssid) && /* Specific SSID */
-			!memcmp(ssid, ap->ssid, ssid_len))
+	else if (ssid && ssid_len =3D=3D strlen(ap->config->ssid) && /* One SSID =
*/
+			!memcmp(ssid, ap->config->ssid, ssid_len))
 		match =3D true;
 	else if (ssid_list) { /* SSID List */
 		ie_tlv_iter_init(&iter, ssid_list, ssid_list_len);
@@ -1138,15 +1161,16 @@ static void ap_probe_req_cb(const struct mmpdu_head=
er *hdr, const void *body,
 			ssid =3D (const char *) ie_tlv_iter_get_data(&iter);
 			ssid_len =3D ie_tlv_iter_get_length(&iter);
 =

-			if (ssid_len =3D=3D strlen(ap->ssid) &&
-					!memcmp(ssid, ap->ssid, ssid_len)) {
+			if (ssid_len =3D=3D strlen(ap->config->ssid) &&
+					!memcmp(ssid, ap->config->ssid,
+						ssid_len)) {
 				match =3D true;
 				break;
 			}
 		}
 	}
 =

-	if (dsss_channel !=3D 0 && dsss_channel !=3D ap->channel)
+	if (dsss_channel !=3D 0 && dsss_channel !=3D ap->config->channel)
 		match =3D false;
 =

 	if (!match)
@@ -1247,14 +1271,14 @@ static void ap_auth_cb(const struct mmpdu_header *h=
dr, const void *body,
 			memcmp(hdr->address_3, bssid, 6))
 		return;
 =

-	if (ap->authorized_macs) {
-		int i;
+	if (ap->config->authorized_macs) {
+		uint8_t *const *mac;
 =

-		for (i =3D 0; i < ap->authorized_macs_num; i++)
-			if (!memcmp(from, ap->authorized_macs + i * 6, 6))
+		for (mac =3D ap->config->authorized_macs; *mac; mac++)
+			if (!memcmp(from, *mac, 6))
 				break;
 =

-		if (i =3D=3D ap->authorized_macs_num) {
+		if (!*mac) {
 			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
 			return;
 		}
@@ -1374,7 +1398,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 	uint32_t nl_akm =3D CRYPTO_AKM_PSK;
 	uint32_t wpa_version =3D NL80211_WPA_VERSION_2;
 	uint32_t auth_type =3D NL80211_AUTHTYPE_OPEN_SYSTEM;
-	uint32_t ch_freq =3D scan_channel_to_freq(ap->channel, SCAN_BAND_2_4_GHZ);
+	uint32_t ch_freq =3D scan_channel_to_freq(ap->config->channel,
+						SCAN_BAND_2_4_GHZ);
 	uint32_t ch_width =3D NL80211_CHAN_WIDTH_20;
 =

 	static const uint8_t bcast_addr[6] =3D {
@@ -1389,7 +1414,7 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 		return NULL;
 =

 	cmd =3D l_genl_msg_new_sized(NL80211_CMD_START_AP, 256 + head_len +
-					tail_len + strlen(ap->ssid));
+					tail_len + strlen(ap->config->ssid));
 =

 	/* SET_BEACON attrs */
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_BEACON_HEAD, head_len, head);
@@ -1403,8 +1428,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 				&ap->beacon_interval);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_DTIM_PERIOD, 4, &dtim_period);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_IFINDEX, 4, &ifindex);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID, strlen(ap->ssid),
-				ap->ssid);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID, strlen(ap->config->ssid),
+				ap->config->ssid);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_HIDDEN_SSID, 4,
 				&hidden_ssid);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_CIPHER_SUITES_PAIRWISE, 4,
@@ -1462,11 +1487,14 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
  * @event_func is required and must react to AP_EVENT_START_FAILED
  * and AP_EVENT_STOPPING by forgetting the ap_state struct, which
  * is going to be freed automatically.
- * @channel is optional.
+ * In the @config struct only .ssid and .psk need to be non-NUL,
+ * other fields are optional.  If @ap_start succeeds, the returned
+ * ap_state takes ownership of @config and the caller shouldn't
+ * free it or any of the memory pointed to by its members (they
+ * also can't be static).  In principle there's no reason that the
+ * caller shouldn't read/update some of the members though.
  */
-struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
-				const char *psk, int channel, bool no_cck_rates,
-				const uint8_t **authorized_macs,
+struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
 				ap_event_func_t event_func, void *user_data)
 {
 	struct ap_state *ap;
@@ -1476,30 +1504,14 @@ struct ap_state *ap_start(struct netdev *netdev, co=
nst char *ssid,
 =

 	ap =3D l_new(struct ap_state, 1);
 	ap->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
-	ap->ssid =3D l_strdup(ssid);
+	ap->config =3D config;
 	ap->netdev =3D netdev;
-	ap->no_cck_rates =3D no_cck_rates;
 	ap->event_func =3D event_func;
 	ap->user_data =3D user_data;
 =

-	if (channel)
-		ap->channel =3D channel;
-	else {
+	if (!config->channel)
 		/* TODO: Start a Get Survey to decide the channel */
-		ap->channel =3D 6;
-	}
-
-	if (authorized_macs) {
-		int i;
-
-		for (i =3D 0; authorized_macs[i]; i++);
-		ap->authorized_macs =3D l_malloc(i * 6);
-		ap->authorized_macs_num =3D i;
-
-		for (i =3D 0; authorized_macs[i]; i++)
-			memcpy(ap->authorized_macs + i * 6, authorized_macs[i],
-				6);
-	}
+		config->channel =3D 6;
 =

 	/* TODO: Add all ciphers supported by wiphy */
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
@@ -1507,7 +1519,7 @@ struct ap_state *ap_start(struct netdev *netdev, cons=
t char *ssid,
 	ap->beacon_interval =3D 100;
 =

 	/* TODO: Pick from actual supported rates */
-	if (no_cck_rates) {
+	if (config->no_cck_rates) {
 		l_uintset_put(ap->rates, 12); /* 6 Mbps*/
 		l_uintset_put(ap->rates, 18); /* 9 Mbps*/
 		l_uintset_put(ap->rates, 24); /* 12 Mbps*/
@@ -1523,8 +1535,8 @@ struct ap_state *ap_start(struct netdev *netdev, cons=
t char *ssid,
 		l_uintset_put(ap->rates, 22); /* 11 Mbps*/
 	}
 =

-	if (crypto_psk_from_passphrase(psk, (uint8_t *) ssid, strlen(ssid),
-					ap->pmk) < 0)
+	if (crypto_psk_from_passphrase(config->psk, (uint8_t *) config->ssid,
+					strlen(config->ssid), ap->pmk) < 0)
 		goto error;
 =

 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
@@ -1757,6 +1769,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 {
 	struct ap_if_data *ap_if =3D user_data;
 	const char *ssid, *wpa2_psk;
+	struct ap_config *config;
 =

 	if (ap_if->ap && ap_if->ap->started)
 		return dbus_error_already_exists(message);
@@ -1767,10 +1780,15 @@ static struct l_dbus_message *ap_dbus_start(struct =
l_dbus *dbus,
 	if (!l_dbus_message_get_arguments(message, "ss", &ssid, &wpa2_psk))
 		return dbus_error_invalid_args(message);
 =

-	ap_if->ap =3D ap_start(ap_if->netdev, ssid, wpa2_psk, 0, false, NULL,
-				ap_if_event_func, ap_if);
-	if (!ap_if->ap)
+	config =3D l_new(struct ap_config, 1);
+	config->ssid =3D l_strdup(ssid);
+	config->psk =3D l_strdup(wpa2_psk);
+
+	ap_if->ap =3D ap_start(ap_if->netdev, config, ap_if_event_func, ap_if);
+	if (!ap_if->ap) {
+		ap_config_free(config);
 		return dbus_error_invalid_args(message);
+	}
 =

 	ap_if->pending =3D l_dbus_message_ref(message);
 	return NULL;
diff --git a/src/ap.h b/src/ap.h
index b007b657..3ca9467f 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -41,13 +41,30 @@ struct ap_event_station_removed_data {
 	enum mmpdu_reason_code reason;
 };
 =

+struct ap_event_registration_started_data {
+	const uint8_t *mac;
+	const struct iovec *assoc_ies;
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
 =

-struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
-				const char *psk, int channel, bool no_cck_rates,
-				const uint8_t **authorized_macs,
+struct ap_config {
+	char *ssid;
+	char *psk;
+	uint8_t channel;
+	uint8_t **authorized_macs;
+	bool no_cck_rates : 1;
+};
+
+void ap_config_free(struct ap_config *config);
+
+struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
 				ap_event_func_t event_func, void *user_data);
 void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
 			void *user_data);
-- =

2.25.1

--===============9200423199287215404==--

