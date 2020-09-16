Content-Type: multipart/mixed; boundary="===============1915349142571044774=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] treewide: Use l_settings_{set,get}_bytes
Date: Wed, 16 Sep 2020 11:17:54 +0200
Message-ID: <20200916091754.516851-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200916091754.516851-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1915349142571044774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c           | 14 ++++----------
 src/eap-mschapv2.c | 39 ++++++++++++---------------------------
 src/eap-wsc.c      | 23 +++++++++--------------
 src/hotspot.c      | 26 ++++++++++++++------------
 src/network.c      | 30 +++++++++++++++---------------
 src/wsc.c          | 13 ++++---------
 unit/test-wsc.c    | 36 +++++++++++-------------------------
 7 files changed, 69 insertions(+), 112 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 4f90323b..da2a3a82 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -768,21 +768,15 @@ static void ap_start_eap_wsc(struct sta_state *sta)
 	 */
 	bool wait_for_eapol_start =3D !sta->wsc_v2;
 =

-	L_AUTO_FREE_VAR(char *, uuid_r_str) =3D NULL;
-	L_AUTO_FREE_VAR(char *, uuid_e_str) =3D NULL;
-
-	uuid_r_str =3D l_util_hexstring(ap->wsc_uuid_r, 16);
-	uuid_e_str =3D l_util_hexstring(sta->wsc_uuid_e, 16);
-
 	sta->wsc_settings =3D l_settings_new();
 	l_settings_set_string(sta->wsc_settings, "Security", "EAP-Method",
 				"WSC-R");
 	l_settings_set_string(sta->wsc_settings, "WSC", "EnrolleeMAC",
 				util_address_to_string(sta->addr));
-	l_settings_set_string(sta->wsc_settings, "WSC", "UUID-R",
-				uuid_r_str);
-	l_settings_set_string(sta->wsc_settings, "WSC", "UUID-E",
-				uuid_e_str);
+	l_settings_set_bytes(sta->wsc_settings, "WSC", "UUID-R",
+				ap->wsc_uuid_r, 16);
+	l_settings_set_bytes(sta->wsc_settings, "WSC", "UUID-E",
+				sta->wsc_uuid_e, 16);
 	l_settings_set_uint(sta->wsc_settings, "WSC", "RFBand",
 				WSC_RF_BAND_2_4_GHZ);
 	l_settings_set_uint(sta->wsc_settings, "WSC", "ConfigurationMethods",
diff --git a/src/eap-mschapv2.c b/src/eap-mschapv2.c
index 49b5335c..7eac260b 100644
--- a/src/eap-mschapv2.c
+++ b/src/eap-mschapv2.c
@@ -428,13 +428,14 @@ static int eap_mschapv2_check_settings(struct l_setti=
ngs *settings,
 					const char *prefix,
 					struct l_queue **out_missing)
 {
-	const char *password_hash;
+	L_AUTO_FREE_VAR(uint8_t *, password_hash) =3D NULL;
 	L_AUTO_FREE_VAR(char *, password) =3D NULL;
 	L_AUTO_FREE_VAR(char *, identity);
 	const struct eap_secret_info *secret;
 	char setting[64], setting2[64];
 	uint8_t hash[16];
 	int r =3D 0;
+	size_t hash_len;
 =

 	snprintf(setting, sizeof(setting), "%sIdentity", prefix);
 	identity =3D l_settings_get_string(settings, "Security", setting);
@@ -460,8 +461,8 @@ static int eap_mschapv2_check_settings(struct l_setting=
s *settings,
 	password =3D l_settings_get_string(settings, "Security", setting2);
 =

 	snprintf(setting, sizeof(setting), "%sPassword-Hash", prefix);
-	password_hash =3D l_settings_get_value(settings, "Security",
-						setting);
+	password_hash =3D l_settings_get_bytes(settings, "Security",
+						setting, &hash_len);
 =

 	if (password && password_hash) {
 		l_error("Exactly one of (%s, %s) must be present",
@@ -471,16 +472,7 @@ static int eap_mschapv2_check_settings(struct l_settin=
gs *settings,
 	}
 =

 	if (password_hash) {
-		unsigned char *tmp;
-		size_t len;
-
-		tmp =3D l_util_from_hexstring(password_hash, &len);
-		if (tmp)
-			explicit_bzero(tmp, len);
-
-		l_free(tmp);
-
-		if (!tmp || len !=3D 16) {
+		if (hash_len !=3D 16) {
 			l_error("Property %s is not a 16-byte hexstring",
 				setting);
 			return -EINVAL;
@@ -534,22 +526,15 @@ static bool eap_mschapv2_load_settings(struct eap_sta=
te *eap,
 		set_password_from_string(state, password);
 		explicit_bzero(password, strlen(password));
 	} else {
-		unsigned char *tmp;
-		size_t len;
-		const char *hash_str;
+		size_t hash_len;
+		uint8_t *hash;
 =

 		snprintf(setting, sizeof(setting), "%sPassword-Hash", prefix);
-		hash_str =3D l_settings_get_value(settings, "Security", setting);
-		if (!hash_str)
-			goto error;
-
-		tmp =3D l_util_from_hexstring(hash_str, &len);
-		if (!tmp)
-			goto error;
-
-		memcpy(state->password_hash, tmp, len);
-		explicit_bzero(tmp, len);
-		l_free(tmp);
+		hash =3D l_settings_get_bytes(settings, "Security", setting,
+						&hash_len);
+		memcpy(state->password_hash, hash, 16);
+		explicit_bzero(hash, 16);
+		l_free(hash);
 	}
 =

 	eap_set_data(eap, state);
diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 5b87924a..817cf82f 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -1718,27 +1718,22 @@ static void eap_wsc_handle_retransmit(struct eap_st=
ate *eap,
 static bool load_hexencoded(struct l_settings *settings, const char *key,
 						uint8_t *to, size_t len)
 {
-	const char *v;
-	size_t decoded_len;
-	unsigned char *decoded;
+	uint8_t *v;
+	size_t v_len;
 =

-	v =3D l_settings_get_value(settings, "WSC", key);
+	v =3D l_settings_get_bytes(settings, "WSC", key, &v_len);
 	if (!v)
 		return false;
 =

-	decoded =3D l_util_from_hexstring(v, &decoded_len);
-	if (!decoded)
-		return false;
-
-	if (decoded_len !=3D len) {
-		explicit_bzero(decoded, decoded_len);
-		l_free(decoded);
+	if (v_len !=3D len) {
+		explicit_bzero(v, v_len);
+		l_free(v);
 		return false;
 	}
 =

-	memcpy(to, decoded, len);
-	explicit_bzero(decoded, decoded_len);
-	l_free(decoded);
+	memcpy(to, v, len);
+	explicit_bzero(v, v_len);
+	l_free(v);
 =

 	return true;
 }
diff --git a/src/hotspot.c b/src/hotspot.c
index 0db42eb0..ea11d59a 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -319,7 +319,8 @@ static struct hs20_config *hs20_config_new(struct l_set=
tings *settings,
 	struct hs20_config *config;
 	char *hessid_str;
 	char **nai_realms =3D NULL;
-	const char *rc_str;
+	size_t rc_len;
+	uint8_t *rc;
 	char *name;
 	bool autoconnect;
 =

@@ -329,7 +330,8 @@ static struct hs20_config *hs20_config_new(struct l_set=
tings *settings,
 	nai_realms =3D l_settings_get_string_list(settings, "Hotspot",
 						"NAIRealmNames", ',');
 =

-	rc_str =3D l_settings_get_value(settings, "Hotspot", "RoamingConsortium");
+	rc =3D l_settings_get_bytes(settings, "Hotspot", "RoamingConsortium",
+								&rc_len);
 =

 	if (!l_settings_get_bool(settings, "Settings", "AutoConnect",
 								&autoconnect))
@@ -337,7 +339,7 @@ static struct hs20_config *hs20_config_new(struct l_set=
tings *settings,
 =

 	name =3D l_settings_get_string(settings, "Hotspot", "Name");
 =

-	if ((!hessid_str && !nai_realms && !rc_str) || !name) {
+	if ((!hessid_str && !nai_realms && !rc) || !name) {
 		l_error("Could not parse hotspot config %s", filename);
 		goto free_values;
 	}
@@ -357,22 +359,21 @@ static struct hs20_config *hs20_config_new(struct l_s=
ettings *settings,
 	if (nai_realms)
 		config->nai_realms =3D nai_realms;
 =

-	if (rc_str) {
-		config->rc =3D l_util_from_hexstring(rc_str,
-							&config->rc_len);
+	if (rc) {
 		/*
 		 * WiFi Alliance Hotspot 2.0 Spec - Section 3.1.4
 		 *
 		 * "The Consortium OI field is 3 or 5-octet field set to a value
 		 * of a roaming consortium OI"
 		 */
-		if (config->rc && config->rc_len !=3D 3 &&
-						config->rc_len !=3D 5) {
-			l_warn("invalid RoamingConsortium length %zu",
-					config->rc_len);
-			l_free(config->rc);
-			config->rc =3D NULL;
+		if (rc && rc_len !=3D 3 && rc_len !=3D 5) {
+			l_warn("invalid RoamingConsortium length %zu", rc_len);
+			l_free(rc);
+			rc =3D NULL;
 		}
+
+		config->rc =3D rc;
+		config->rc_len =3D rc_len;
 	}
 =

 	config->super.is_autoconnectable =3D autoconnect;
@@ -392,6 +393,7 @@ free_values:
 	l_strv_free(nai_realms);
 	l_free(hessid_str);
 	l_free(name);
+	l_free(rc);
 =

 	return NULL;
 }
diff --git a/src/network.c b/src/network.c
index a7d59ca0..3e856aa1 100644
--- a/src/network.c
+++ b/src/network.c
@@ -374,16 +374,18 @@ static int network_load_psk(struct network *network, =
bool need_passphrase)
 {
 	const char *ssid =3D network_get_ssid(network);
 	enum security security =3D network_get_security(network);
-	size_t len;
-	const char *psk =3D l_settings_get_value(network->settings,
-						"Security", "PreSharedKey");
+	size_t psk_len;
+	uint8_t *psk =3D l_settings_get_bytes(network->settings, "Security",
+						"PreSharedKey", &psk_len);
 	char *passphrase =3D l_settings_get_string(network->settings,
 						"Security", "Passphrase");
 	int r;
 =

 	/* PSK can be generated from the passphrase but not the other way */
-	if ((!psk || need_passphrase) && !passphrase)
+	if ((!psk || need_passphrase) && !passphrase) {
+		l_free(psk);
 		return -ENOKEY;
+	}
 =

 	network_reset_passphrase(network);
 	network_reset_psk(network);
@@ -392,11 +394,10 @@ static int network_load_psk(struct network *network, =
bool need_passphrase)
 	if (psk) {
 		char *path;
 =

-		network->psk =3D l_util_from_hexstring(psk, &len);
-		if (network->psk && len =3D=3D 32)
+		if (psk_len =3D=3D 32) {
+			network->psk =3D psk;
 			return 0;
-
-		network_reset_psk(network);
+		}
 =

 		path =3D storage_get_network_file_path(security, ssid);
 		l_error("%s: invalid PreSharedKey format", path);
@@ -439,15 +440,14 @@ void network_sync_psk(struct network *network)
 	fs_settings =3D storage_network_open(SECURITY_PSK, ssid);
 =

 	if (network->psk) {
-		char *hex =3D l_util_hexstring(network->psk, 32);
-		l_settings_set_value(network->settings, "Security",
-						"PreSharedKey", hex);
+		l_settings_set_bytes(network->settings, "Security",
+						"PreSharedKey",
+						network->psk, 32);
 =

 		if (fs_settings)
-			l_settings_set_value(fs_settings, "Security",
-						"PreSharedKey", hex);
-
-		l_free(hex);
+			l_settings_set_bytes(fs_settings, "Security",
+						"PreSharedKey",
+						network->psk, 32);
 	}
 =

 	if (network->passphrase) {
diff --git a/src/wsc.c b/src/wsc.c
index fa91f459..66ddb8bf 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -536,15 +536,10 @@ static void wsc_store_credentials(struct wsc_credenti=
als_info *creds,
 		l_debug("Storing credential for '%s(%s)'", ssid,
 						security_to_str(security));
 =

-		if (security =3D=3D SECURITY_PSK) {
-			char *hex =3D l_util_hexstring(creds[i].psk,
-						sizeof(creds[i].psk));
-
-			l_settings_set_value(settings, "Security",
-							"PreSharedKey", hex);
-			explicit_bzero(hex, strlen(hex));
-			l_free(hex);
-		}
+		if (security =3D=3D SECURITY_PSK)
+			l_settings_set_bytes(settings, "Security",
+						"PreSharedKey", creds[i].psk,
+                                                sizeof(creds[i].psk));
 =

 		storage_network_sync(security, ssid, settings);
 		l_settings_free(settings);
diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index 2063244c..f2e9b864 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -2005,7 +2005,6 @@ static void wsc_test_pbc_handshake(const void *data)
 	struct verify_data verify;
 	struct handshake_state *hs;
 	struct eapol_sm *sm;
-	char *hex;
 	struct l_settings *settings;
 =

 	eap_init();
@@ -2037,16 +2036,11 @@ static void wsc_test_pbc_handshake(const void *data)
 					"0-00000000-0");
 	l_settings_set_string(settings, "WSC", "EnrolleeMAC",
 					util_address_to_string(sta_address));
-
-	hex =3D l_util_hexstring(m1_data_2.expected.enrollee_nonce, 16);
-	l_settings_set_string(settings, "WSC", "EnrolleeNonce", hex);
-	l_free(hex);
-
-	hex =3D l_util_hexstring(m1_data_2.private_key,
-						m1_data_2.private_key_size);
-	l_settings_set_string(settings, "WSC", "PrivateKey", hex);
-	l_free(hex);
-
+	l_settings_set_bytes(settings, "WSC", "EnrolleeNonce",
+				m1_data_2.expected.enrollee_nonce, 16);
+	l_settings_set_bytes(settings, "WSC", "PrivateKey",
+				m1_data_2.private_key,
+				m1_data_2.private_key_size);
 	l_settings_set_string(settings, "WSC", "E-SNonce1",
 					"fdbb480ee6f572f3591cc3b364f2185b");
 	l_settings_set_string(settings, "WSC", "E-SNonce2",
@@ -2111,7 +2105,6 @@ static void wsc_test_retransmission_no_fragmentation(=
const void *data)
 	struct verify_data verify;
 	struct handshake_state *hs;
 	struct eapol_sm *sm;
-	char *hex;
 	struct l_settings *settings;
 =

 	eap_init();
@@ -2143,16 +2136,11 @@ static void wsc_test_retransmission_no_fragmentatio=
n(const void *data)
 					"0-00000000-0");
 	l_settings_set_string(settings, "WSC", "EnrolleeMAC",
 					util_address_to_string(sta_address));
-
-	hex =3D l_util_hexstring(m1_data_2.expected.enrollee_nonce, 16);
-	l_settings_set_string(settings, "WSC", "EnrolleeNonce", hex);
-	l_free(hex);
-
-	hex =3D l_util_hexstring(m1_data_2.private_key,
-						m1_data_2.private_key_size);
-	l_settings_set_string(settings, "WSC", "PrivateKey", hex);
-	l_free(hex);
-
+	l_settings_set_bytes(settings, "WSC", "EnrolleeNonce",
+				m1_data_2.expected.enrollee_nonce, 16);
+	l_settings_set_bytes(settings, "WSC", "PrivateKey",
+				m1_data_2.private_key,
+				m1_data_2.private_key_size);
 	l_settings_set_string(settings, "WSC", "E-SNonce1",
 					"fdbb480ee6f572f3591cc3b364f2185b");
 	l_settings_set_string(settings, "WSC", "E-SNonce2",
@@ -2479,11 +2467,9 @@ static void wsc_r_test_pbc_handshake(const void *dat=
a)
 		.expected_creds =3D *expected_creds,
 	};
 	uint8_t uuid_e[16];
-	L_AUTO_FREE_VAR(char *, uuid_e_str) =3D NULL;
 	char ssid_str[33];
 =

 	wsc_uuid_from_addr(s.sta_address, uuid_e);
-	uuid_e_str =3D l_util_hexstring(uuid_e, 16);
 =

 	memcpy(wsc_data.expected_creds.addr, s.sta_address, 6);
 	memset(wsc_data.expected_creds.ssid + expected_creds->ssid_len, 0,
@@ -2500,7 +2486,7 @@ static void wsc_r_test_pbc_handshake(const void *data)
 					strlen(ap_8021x_str));
 	l_settings_set_string(ap_8021x_settings, "WSC", "EnrolleeMAC",
 				util_address_to_string(s.sta_address));
-	l_settings_set_string(ap_8021x_settings, "WSC", "UUID-E", uuid_e_str);
+	l_settings_set_bytes(ap_8021x_settings, "WSC", "UUID-E", uuid_e, 16);
 =

 	if (expected_creds->auth_type =3D=3D WSC_AUTHENTICATION_TYPE_WPA2_PERSONA=
L) {
 		l_settings_set_string(ap_8021x_settings, "WSC",
-- =

2.25.1

--===============1915349142571044774==--

