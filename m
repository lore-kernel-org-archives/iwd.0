Content-Type: multipart/mixed; boundary="===============1723712846291208084=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/8] ap: Support working without passphrase
Date: Fri, 11 Sep 2020 21:51:02 +0200
Message-ID: <20200911195103.385070-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200911195103.385070-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1723712846291208084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a "psk" setting to allow the user to pass the binary PSK directly
instead of generating it from the passphrase and the SSID.  In that case
we'll only send the PSK to WSC enrollees.
---
 src/ap.c | 40 ++++++++++++++++++++++++++--------------
 src/ap.h |  3 ++-
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 19c443c3..57b35b74 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -61,7 +61,6 @@ struct ap_state {
 	enum ie_rsn_cipher_suite group_cipher;
 	uint32_t beacon_interval;
 	struct l_uintset *rates;
-	uint8_t pmk[32];
 	uint32_t start_stop_cmd_id;
 	uint32_t mlme_watch;
 	uint8_t gtk[CRYPTO_MAX_GTK_LEN];
@@ -113,11 +112,12 @@ void ap_config_free(struct ap_config *config)
 =

 	l_free(config->ssid);
 =

-	if (config->psk) {
-		explicit_bzero(config->psk, strlen(config->psk));
-		l_free(config->psk);
+	if (config->passphrase) {
+		explicit_bzero(config->passphrase, strlen(config->passphrase));
+		l_free(config->passphrase);
 	}
 =

+	explicit_bzero(config->psk, 32);
 	l_free(config->authorized_macs);
 	l_free(config->wsc_name);
 	l_free(config);
@@ -176,8 +176,6 @@ static void ap_reset(struct ap_state *ap)
 {
 	struct netdev *netdev =3D ap->netdev;
 =

-	explicit_bzero(ap->pmk, sizeof(ap->pmk));
-
 	if (ap->mlme_watch)
 		l_genl_family_unregister(ap->nl80211, ap->mlme_watch);
 =

@@ -651,7 +649,7 @@ static void ap_start_rsna(struct sta_state *sta, const =
uint8_t *gtk_rsc)
 	handshake_state_set_authenticator(sta->hs, true);
 	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
-	handshake_state_set_pmk(sta->hs, sta->ap->pmk, 32);
+	handshake_state_set_pmk(sta->hs, sta->ap->config->psk, 32);
 =

 	if (gtk_rsc)
 		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
@@ -794,8 +792,18 @@ static void ap_start_eap_wsc(struct sta_state *sta)
 				WSC_CONFIGURATION_METHOD_PUSH_BUTTON);
 	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-SSID",
 				ap->config->ssid);
-	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-Passphrase",
-				ap->config->psk);
+
+	if (ap->config->passphrase)
+		l_settings_set_string(sta->wsc_settings,
+					"WSC", "WPA2-Passphrase",
+					ap->config->passphrase);
+	else {
+		L_AUTO_FREE_VAR(char *, psk_str) =3D
+			l_util_hexstring(ap->config->psk, 32);
+
+		l_settings_set_string(sta->wsc_settings,
+					"WSC", "WPA2-PSK", psk_str);
+	}
 =

 	sta->hs =3D netdev_handshake_state_new(ap->netdev);
 	handshake_state_set_authenticator(sta->hs, true);
@@ -2037,8 +2045,9 @@ static void ap_mlme_notify(struct l_genl_msg *msg, vo=
id *user_data)
  * @ops.handle_event is required and must react to AP_EVENT_START_FAILED
  * and AP_EVENT_STOPPING by forgetting the ap_state struct, which is
  * going to be freed automatically.
- * In the @config struct only .ssid and .psk need to be non-NULL,
- * other fields are optional.  If @ap_start succeeds, the returned
+ * In the @config struct only .ssid and either of .passprhase and .psk
+ * need to be present, other fields are optional.  If .psk is used
+ * whenever .passphrase is NULL.  If @ap_start succeeds, the returned
  * ap_state takes ownership of @config and the caller shouldn't
  * free it or any of the memory pointed to by its members (they
  * also can't be static).
@@ -2097,8 +2106,11 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 =

 	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
 =

-	if (crypto_psk_from_passphrase(config->psk, (uint8_t *) config->ssid,
-					strlen(config->ssid), ap->pmk) < 0)
+	if (!config->passphrase &&
+			crypto_psk_from_passphrase(config->passphrase,
+						(uint8_t *) config->ssid,
+						strlen(config->ssid),
+						config->psk) < 0)
 		goto error;
 =

 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
@@ -2395,7 +2407,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 =

 	config =3D l_new(struct ap_config, 1);
 	config->ssid =3D l_strdup(ssid);
-	config->psk =3D l_strdup(wpa2_psk);
+	config->passphrase =3D l_strdup(wpa2_psk);
 =

 	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, ap_if);
 	if (!ap_if->ap) {
diff --git a/src/ap.h b/src/ap.h
index bbfecd6d..4232a735 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -56,7 +56,8 @@ typedef void (*ap_stopped_func_t)(void *user_data);
 =

 struct ap_config {
 	char *ssid;
-	char *psk;
+	char *passphrase;
+	uint8_t psk[32];
 	uint8_t channel;
 	uint8_t *authorized_macs;
 	unsigned int authorized_macs_num;
-- =

2.25.1

--===============1723712846291208084==--

