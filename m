Content-Type: multipart/mixed; boundary="===============2658340641849260428=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] ap: Support working without passphrase
Date: Wed, 16 Sep 2020 11:17:50 +0200
Message-ID: <20200916091754.516851-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200916091754.516851-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2658340641849260428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a "psk" setting to allow the user to pass the binary PSK directly
instead of generating it from the passphrase and the SSID.  In that case
we'll only send the PSK to WSC enrollees.
---
 src/ap.c | 48 +++++++++++++++++++++++++++++-------------------
 src/ap.h |  3 ++-
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 7c135150..626c983b 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -62,7 +62,6 @@ struct ap_state {
 	enum ie_rsn_cipher_suite group_cipher;
 	uint32_t beacon_interval;
 	struct l_uintset *rates;
-	uint8_t pmk[32];
 	uint32_t start_stop_cmd_id;
 	uint32_t mlme_watch;
 	uint8_t gtk[CRYPTO_MAX_GTK_LEN];
@@ -114,11 +113,8 @@ void ap_config_free(struct ap_config *config)
 =

 	l_free(config->ssid);
 =

-	if (config->psk) {
-		explicit_bzero(config->psk, strlen(config->psk));
-		l_free(config->psk);
-	}
-
+	explicit_bzero(config->passphrase, sizeof(config->passphrase));
+	explicit_bzero(config->psk, sizeof(config->psk));
 	l_free(config->authorized_macs);
 	l_free(config->wsc_name);
 	l_free(config);
@@ -177,8 +173,6 @@ static void ap_reset(struct ap_state *ap)
 {
 	struct netdev *netdev =3D ap->netdev;
 =

-	explicit_bzero(ap->pmk, sizeof(ap->pmk));
-
 	if (ap->mlme_watch)
 		l_genl_family_unregister(ap->nl80211, ap->mlme_watch);
 =

@@ -652,7 +646,7 @@ static void ap_start_rsna(struct sta_state *sta, const =
uint8_t *gtk_rsc)
 	handshake_state_set_authenticator(sta->hs, true);
 	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
-	handshake_state_set_pmk(sta->hs, sta->ap->pmk, 32);
+	handshake_state_set_pmk(sta->hs, sta->ap->config->psk, 32);
 =

 	if (gtk_rsc)
 		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
@@ -795,8 +789,14 @@ static void ap_start_eap_wsc(struct sta_state *sta)
 				WSC_CONFIGURATION_METHOD_PUSH_BUTTON);
 	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-SSID",
 				ap->config->ssid);
-	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-Passphrase",
-				ap->config->psk);
+
+	if (ap->config->passphrase[0])
+		l_settings_set_string(sta->wsc_settings,
+					"WSC", "WPA2-Passphrase",
+					ap->config->passphrase);
+	else
+		l_settings_set_bytes(sta->wsc_settings,
+					"WSC", "WPA2-PSK", ap->config->psk, 32);
 =

 	sta->hs =3D netdev_handshake_state_new(ap->netdev);
 	handshake_state_set_authenticator(sta->hs, true);
@@ -2038,11 +2038,11 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
  * @ops.handle_event is required and must react to AP_EVENT_START_FAILED
  * and AP_EVENT_STOPPING by forgetting the ap_state struct, which is
  * going to be freed automatically.
- * In the @config struct only .ssid and .psk need to be non-NULL,
- * other fields are optional.  If @ap_start succeeds, the returned
- * ap_state takes ownership of @config and the caller shouldn't
- * free it or any of the memory pointed to by its members (they
- * also can't be static).
+ * In the @config struct the .ssid field is required and one of
+ * .passphrase and .psk must be filled in.  All other fields are optional.
+ * If @ap_start succeeds, the returned ap_state takes ownership of
+ * @config and the caller shouldn't free it or any of the memory pointed
+ * to by its members (which also can't be static).
  */
 struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
 				const struct ap_ops *ops, void *user_data)
@@ -2052,6 +2052,13 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 	struct l_genl_msg *cmd;
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
 =

+	if (L_WARN_ON(!config->ssid))
+		return NULL;
+
+	if (L_WARN_ON(!config->passphrase[0] && util_mem_is_zero(config->psk,
+							sizeof(config->psk))))
+		return NULL;
+
 	ap =3D l_new(struct ap_state, 1);
 	ap->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
 	ap->config =3D config;
@@ -2098,8 +2105,11 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 =

 	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
 =

-	if (crypto_psk_from_passphrase(config->psk, (uint8_t *) config->ssid,
-					strlen(config->ssid), ap->pmk) < 0)
+	if (config->passphrase[0] &&
+			crypto_psk_from_passphrase(config->passphrase,
+						(uint8_t *) config->ssid,
+						strlen(config->ssid),
+						config->psk) < 0)
 		goto error;
 =

 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
@@ -2396,7 +2406,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 =

 	config =3D l_new(struct ap_config, 1);
 	config->ssid =3D l_strdup(ssid);
-	config->psk =3D l_strdup(wpa2_psk);
+	l_strlcpy(config->passphrase, wpa2_psk, sizeof(config->passphrase));
 =

 	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, ap_if);
 	if (!ap_if->ap) {
diff --git a/src/ap.h b/src/ap.h
index bbfecd6d..a39797aa 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -56,7 +56,8 @@ typedef void (*ap_stopped_func_t)(void *user_data);
 =

 struct ap_config {
 	char *ssid;
-	char *psk;
+	char passphrase[64];
+	uint8_t psk[32];
 	uint8_t channel;
 	uint8_t *authorized_macs;
 	unsigned int authorized_macs_num;
-- =

2.25.1

--===============2658340641849260428==--

