Content-Type: multipart/mixed; boundary="===============9213920696991847986=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/16] eap-wsc: Registrar mode settings loading
Date: Thu, 13 Aug 2020 02:53:33 +0200
Message-ID: <20200813005338.295108-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005338.295108-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9213920696991847986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Alongside the current EAP-WSC enrollee side support, add the initial
part of registrar side.  In the same file, register a new method with
the name string of "WSC-R".  In this patch only the load_settings
method is added.  validate_identity and handle_response are added in
later patches.
---
 src/eap-wsc.c | 433 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 325 insertions(+), 108 deletions(-)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index ca915471..2770c87a 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -57,28 +57,40 @@ enum wsc_flag {
 };
 =

 enum state {
+	/* Enrollee states */
 	STATE_EXPECT_START =3D 0,
 	STATE_EXPECT_M2,
 	STATE_EXPECT_M4,
 	STATE_EXPECT_M6,
 	STATE_EXPECT_M8,
 	STATE_FINISHED,
+	/* Registrar states */
+	STATE_EXPECT_IDENTITY,
+	STATE_EXPECT_M1,
+	STATE_EXPECT_M3,
+	STATE_EXPECT_M5,
+	STATE_EXPECT_M7,
+	STATE_EXPECT_DONE,
 };
 =

 static struct l_key *dh5_generator;
 static struct l_key *dh5_prime;
 =

 struct eap_wsc_state {
+	bool registrar;
 	struct wsc_m1 *m1;
 	struct wsc_m2 *m2;
+	struct wsc_credential wpa2_cred;
+	struct wsc_credential open_cred;
 	uint8_t *sent_pdu;
 	size_t sent_len;
 	struct l_key *private;
 	char *device_password;
-	uint8_t e_snonce1[16];
-	uint8_t e_snonce2[16];
+	uint8_t local_snonce1[16];
+	uint8_t local_snonce2[16];
 	uint8_t iv1[16];
 	uint8_t iv2[16];
+	uint8_t iv3[16];
 	uint8_t psk1[16];
 	uint8_t psk2[16];
 	uint8_t r_hash2[32];
@@ -305,10 +317,12 @@ static void eap_wsc_free(struct eap_state *eap)
 	l_free(wsc->m1);
 	l_free(wsc->m2);
 =

-	explicit_bzero(wsc->e_snonce1, 16);
-	explicit_bzero(wsc->e_snonce2, 16);
+	explicit_bzero(wsc->local_snonce1, 16);
+	explicit_bzero(wsc->local_snonce2, 16);
 	explicit_bzero(wsc->psk1, 16);
 	explicit_bzero(wsc->psk2, 16);
+	explicit_bzero(&wsc->wpa2_cred, sizeof(struct wsc_credential));
+	explicit_bzero(&wsc->open_cred, sizeof(struct wsc_credential));
 =

 	l_free(wsc);
 }
@@ -541,9 +555,9 @@ static void eap_wsc_send_m7(struct eap_state *eap,
 	size_t encrypted_len;
 	bool r;
 =

-	memcpy(m7es.e_snonce2, wsc->e_snonce2, sizeof(wsc->e_snonce2));
+	memcpy(m7es.e_snonce2, wsc->local_snonce2, sizeof(wsc->local_snonce2));
 	pdu =3D wsc_build_m7_encrypted_settings(&m7es, &pdu_len);
-	explicit_bzero(m7es.e_snonce2, sizeof(wsc->e_snonce2));
+	explicit_bzero(m7es.e_snonce2, sizeof(wsc->local_snonce2));
 	if (!pdu)
 		return;
 =

@@ -642,9 +656,9 @@ static void eap_wsc_send_m5(struct eap_state *eap,
 	size_t encrypted_len;
 	bool r;
 =

-	memcpy(m5es.e_snonce1, wsc->e_snonce1, sizeof(wsc->e_snonce1));
+	memcpy(m5es.e_snonce1, wsc->local_snonce1, sizeof(wsc->local_snonce1));
 	pdu =3D wsc_build_m5_encrypted_settings(&m5es, &pdu_len);
-	explicit_bzero(m5es.e_snonce1, sizeof(wsc->e_snonce1));
+	explicit_bzero(m5es.e_snonce1, sizeof(wsc->local_snonce1));
 	if (!pdu)
 		return;
 =

@@ -773,8 +787,8 @@ static void eap_wsc_send_m3(struct eap_state *eap,
 	 * E-Hash1 =3D HMACAuthKey(E-S1 || PSK1 || PKE || PKR)
 	 * E-Hash2 =3D HMACAuthKey(E-S2 || PSK2 || PKE || PKR)
 	 */
-	iov[0].iov_base =3D wsc->e_snonce1;
-	iov[0].iov_len =3D sizeof(wsc->e_snonce1);
+	iov[0].iov_base =3D wsc->local_snonce1;
+	iov[0].iov_len =3D sizeof(wsc->local_snonce1);
 	iov[1].iov_base =3D wsc->psk1;
 	iov[1].iov_len =3D sizeof(wsc->psk1);
 	iov[2].iov_base =3D wsc->m1->public_key;
@@ -785,8 +799,8 @@ static void eap_wsc_send_m3(struct eap_state *eap,
 	l_checksum_get_digest(wsc->hmac_auth_key,
 					m3.e_hash1, sizeof(m3.e_hash1));
 =

-	iov[0].iov_base =3D wsc->e_snonce2;
-	iov[0].iov_len =3D sizeof(wsc->e_snonce2);
+	iov[0].iov_base =3D wsc->local_snonce2;
+	iov[0].iov_len =3D sizeof(wsc->local_snonce2);
 	iov[1].iov_base =3D wsc->psk2;
 	iov[1].iov_len =3D sizeof(wsc->psk2);
 	l_checksum_updatev(wsc->hmac_auth_key, iov, 4);
@@ -1211,129 +1225,165 @@ static bool load_constrained_string(struct l_sett=
ings *settings,
 	return true;
 }
 =

-static bool eap_wsc_load_settings(struct eap_state *eap,
-					struct l_settings *settings,
-					const char *prefix)
+static bool load_device_data(struct l_settings *settings,
+				char *manufacturer,
+				char *model_name,
+				char *model_number,
+				char *serial_number,
+				struct wsc_primary_device_type *dev_type,
+				char *device_name,
+				uint8_t *rf_bands,
+				uint32_t *os_version)
 {
-	struct eap_wsc_state *wsc;
-	const char *v;
-	uint8_t private_key[192];
-	size_t len;
+	struct wsc_m1 *m1;
 	unsigned int u32;
 =

-	wsc =3D l_new(struct eap_wsc_state, 1);
-
-	wsc->m1 =3D l_new(struct wsc_m1, 1);
-	wsc->m1->version2 =3D true;
-
-	v =3D l_settings_get_value(settings, "WSC", "EnrolleeMAC");
-	if (!v)
-		goto err;
-
-	if (!util_string_to_address(v, wsc->m1->addr))
-		goto err;
-
-	if (!wsc_uuid_from_addr(wsc->m1->addr, wsc->m1->uuid_e))
-		goto err;
-
-	if (!load_hexencoded(settings, "EnrolleeNonce",
-						wsc->m1->enrollee_nonce, 16))
-		l_getrandom(wsc->m1->enrollee_nonce, 16);
-
-	if (load_hexencoded(settings, "PrivateKey", private_key, 192)) {
-		if (!l_key_validate_dh_payload(private_key, 192,
-						crypto_dh5_prime,
-						crypto_dh5_prime_size)) {
-			explicit_bzero(private_key, 192);
-			goto err;
-		}
-
-		wsc->private =3D l_key_new(L_KEY_RAW, private_key, 192);
-		explicit_bzero(private_key, 192);
-	} else
-		wsc->private =3D l_key_generate_dh_private(crypto_dh5_prime,
-							crypto_dh5_prime_size);
-
-	if (!wsc->private)
-		goto err;
-
-	len =3D sizeof(wsc->m1->public_key);
-	if (!l_key_compute_dh_public(dh5_generator, wsc->private, dh5_prime,
-						wsc->m1->public_key, &len))
-		goto err;
-
-	if (len !=3D sizeof(wsc->m1->public_key))
-		goto err;
-
-	wsc->m1->auth_type_flags =3D WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL |
-					WSC_AUTHENTICATION_TYPE_WPA_PERSONAL |
-					WSC_AUTHENTICATION_TYPE_OPEN;
-	wsc->m1->encryption_type_flags =3D WSC_ENCRYPTION_TYPE_NONE |
-						WSC_ENCRYPTION_TYPE_AES_TKIP;
-	wsc->m1->connection_type_flags =3D WSC_CONNECTION_TYPE_ESS;
-
-	if (!l_settings_get_uint(settings, "WSC",
-						"ConfigurationMethods", &u32))
-		u32 =3D WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN;
-
-	wsc->m1->config_methods =3D u32;
-	wsc->m1->state =3D WSC_STATE_NOT_CONFIGURED;
-
 	if (!load_constrained_string(settings, "Manufacturer",
-			wsc->m1->manufacturer, sizeof(wsc->m1->manufacturer)))
-		strcpy(wsc->m1->manufacturer, " ");
+				manufacturer, sizeof(m1->manufacturer)))
+		strcpy(manufacturer, " ");
 =

 	if (!load_constrained_string(settings, "ModelName",
-			wsc->m1->model_name, sizeof(wsc->m1->model_name)))
-		strcpy(wsc->m1->model_name, " ");
+				model_name, sizeof(m1->model_name)))
+		strcpy(model_name, " ");
 =

 	if (!load_constrained_string(settings, "ModelNumber",
-			wsc->m1->model_number, sizeof(wsc->m1->model_number)))
-		strcpy(wsc->m1->model_number, " ");
+				model_number, sizeof(m1->model_number)))
+		strcpy(model_number, " ");
 =

 	if (!load_constrained_string(settings, "SerialNumber",
-			wsc->m1->serial_number, sizeof(wsc->m1->serial_number)))
-		strcpy(wsc->m1->serial_number, " ");
+				serial_number, sizeof(m1->serial_number)))
+		strcpy(serial_number, " ");
 =

-	if (!load_primary_device_type(settings,
-					&wsc->m1->primary_device_type)) {
+	if (!load_primary_device_type(settings, dev_type)) {
 		/* Make ourselves a WFA standard PC by default */
-		wsc->m1->primary_device_type.category =3D 1;
-		memcpy(wsc->m1->primary_device_type.oui, wsc_wfa_oui, 3);
-		wsc->m1->primary_device_type.oui_type =3D 0x04;
-		wsc->m1->primary_device_type.subcategory =3D 1;
+		dev_type->category =3D 1;
+		memcpy(dev_type->oui, wsc_wfa_oui, 3);
+		dev_type->oui_type =3D 0x04;
+		dev_type->subcategory =3D 1;
 	}
 =

 	if (!load_constrained_string(settings, "DeviceName",
-			wsc->m1->device_name, sizeof(wsc->m1->device_name)))
-		strcpy(wsc->m1->device_name, " ");
+				device_name, sizeof(m1->device_name)))
+		strcpy(device_name, " ");
 =

 	if (!l_settings_get_uint(settings, "WSC", "RFBand", &u32))
-		goto err;
+		return false;
 =

 	switch (u32) {
 	case WSC_RF_BAND_2_4_GHZ:
 	case WSC_RF_BAND_5_0_GHZ:
 	case WSC_RF_BAND_60_GHZ:
-		wsc->m1->rf_bands =3D u32;
+		*rf_bands =3D u32;
 		break;
 	default:
-		goto err;
+		return false;
 	}
 =

-	wsc->m1->association_state =3D WSC_ASSOCIATION_STATE_NOT_ASSOCIATED;
-	wsc->m1->configuration_error =3D WSC_CONFIGURATION_ERROR_NO_ERROR;
-
-	if (!l_settings_get_uint(settings, "WSC",
-						"OSVersion", &u32))
+	if (!l_settings_get_uint(settings, "WSC", "OSVersion", &u32))
 		u32 =3D 0;
 =

-	wsc->m1->os_version =3D u32 & 0x7fffffff;
+	*os_version =3D u32 & 0x7fffffff;
+
+	return true;
+}
+
+static bool eap_wsc_load_common(struct eap_state *eap,
+					struct l_settings *settings,
+					bool registrar)
+{
+	struct eap_wsc_state *wsc;
+	const char *v;
+	uint8_t private_key[192];
+	size_t len;
+	unsigned int u32;
+	char *str;
+
+	wsc =3D l_new(struct eap_wsc_state, 1);
+	wsc->registrar =3D registrar;
+
+	if (registrar)
+		wsc->state =3D STATE_EXPECT_IDENTITY;
+	else
+		wsc->state =3D STATE_EXPECT_START;
+
+	/*
+	 * On the Enrollee we fill in all of the M1 data so that it's ready
+	 * to send.  On the Registrar we store some information in wsc->m1
+	 * for the actual M1's validation, and we fill in the elements of M2
+	 * that don't depend on the received M1 data.
+	 */
+	wsc->m1 =3D l_new(struct wsc_m1, 1);
+
+	if (registrar)
+		wsc->m2 =3D l_new(struct wsc_m2, 1);
+	else {
+		wsc->m1->version2 =3D true;
+		wsc->m1->state =3D WSC_STATE_NOT_CONFIGURED;
+		wsc->m1->association_state =3D WSC_ASSOCIATION_STATE_NOT_ASSOCIATED;
+		wsc->m1->configuration_error =3D WSC_CONFIGURATION_ERROR_NO_ERROR;
+
+		wsc->m1->auth_type_flags =3D
+					WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL |
+					WSC_AUTHENTICATION_TYPE_WPA_PERSONAL |
+					WSC_AUTHENTICATION_TYPE_OPEN;
+		wsc->m1->encryption_type_flags =3D WSC_ENCRYPTION_TYPE_NONE |
+						WSC_ENCRYPTION_TYPE_AES_TKIP;
+		wsc->m1->connection_type_flags =3D WSC_CONNECTION_TYPE_ESS;
+	}
+
+	v =3D l_settings_get_value(settings, "WSC", "EnrolleeMAC");
+	if (!v)
+		goto err;
+
+	if (!util_string_to_address(v, wsc->m1->addr))
+		goto err;
+
+	if (!wsc_uuid_from_addr(wsc->m1->addr, wsc->m1->uuid_e))
+		goto err;
+
+	if (registrar && !load_hexencoded(settings, "UUID-R",
+						wsc->m2->uuid_r, 16))
+		goto err;
+
+	if (!l_settings_get_uint(settings, "WSC", "ConfigurationMethods", &u32))
+		u32 =3D WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN;
+
+	if (!registrar)
+		wsc->m1->config_methods =3D u32;
+	else
+		wsc->m2->config_methods =3D u32;
+
+	if (!registrar) {
+		if (!load_device_data(settings,
+					wsc->m1->manufacturer,
+					wsc->m1->model_name,
+					wsc->m1->model_number,
+					wsc->m1->serial_number,
+					&wsc->m1->primary_device_type,
+					wsc->m1->device_name,
+					&wsc->m1->rf_bands,
+					&wsc->m1->os_version))
+			goto err;
+	} else {
+		if (!load_device_data(settings,
+					wsc->m2->manufacturer,
+					wsc->m2->model_name,
+					wsc->m2->model_number,
+					wsc->m2->serial_number,
+					&wsc->m2->primary_device_type,
+					wsc->m2->device_name,
+					&wsc->m2->rf_bands,
+					&wsc->m2->os_version))
+			goto err;
+	}
 =

 	if (!l_settings_get_uint(settings, "WSC", "DevicePasswordId", &u32))
 		u32 =3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON;
 =

-	wsc->m1->device_password_id =3D u32;
+	if (!registrar)
+		wsc->m1->device_password_id =3D u32;
+	else
+		wsc->m2->device_password_id =3D u32;
 =

 	wsc->device_password =3D l_settings_get_string(settings, "WSC",
 							"DevicePassword");
@@ -1361,11 +1411,141 @@ static bool eap_wsc_load_settings(struct eap_state=
 *eap,
 	} else
 		wsc->device_password =3D l_strdup("00000000");
 =

-	if (!load_hexencoded(settings, "E-SNonce1", wsc->e_snonce1, 16))
-		l_getrandom(wsc->e_snonce1, 16);
+	if (registrar) {
+		wsc->m2->auth_type_flags =3D 0;
 =

-	if (!load_hexencoded(settings, "E-SNonce2", wsc->e_snonce2, 16))
-		l_getrandom(wsc->e_snonce2, 16);
+		str =3D l_settings_get_string(settings, "WSC", "WPA2-SSID");
+		if (str) {
+			if (strlen(str) > 32)
+				goto err;
+
+			wsc->m2->auth_type_flags |=3D
+				WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL;
+			wsc->m2->encryption_type_flags |=3D
+				WSC_ENCRYPTION_TYPE_AES_TKIP;
+			wsc->wpa2_cred.auth_type =3D
+				WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL;
+			wsc->wpa2_cred.encryption_type =3D
+				WSC_ENCRYPTION_TYPE_AES_TKIP;
+
+			wsc->wpa2_cred.ssid_len =3D strlen(str);
+			memcpy(wsc->wpa2_cred.ssid, str,
+				wsc->wpa2_cred.ssid_len);
+			l_free(str);
+
+			str =3D l_settings_get_string(settings, "WSC",
+							"WPA2-Passphrase");
+			if (str) {
+				len =3D strlen(str);
+				if (len < 8 || len > 63) {
+					explicit_bzero(str, len);
+					goto err;
+				}
+
+				memcpy(wsc->wpa2_cred.network_key, str, len);
+				wsc->wpa2_cred.network_key_len =3D len;
+				explicit_bzero(str, len);
+			} else {
+				uint8_t buf[32];
+				int i;
+				static const char hexdigits[16] =3D
+					"0123456789ABCDEF";
+
+				if (!load_hexencoded(settings, "WPA2-PSK",
+							buf, 32))
+					goto err;
+
+				for (i =3D 0; i < 32; i++) {
+					wsc->wpa2_cred.network_key[i * 2] =3D
+						hexdigits[buf[i] >> 4];
+					wsc->wpa2_cred.network_key[i * 2 + 1] =3D
+						hexdigits[buf[i] & 15];
+				}
+
+				wsc->wpa2_cred.network_key_len =3D 64;
+				explicit_bzero(buf, 32);
+			}
+
+			memcpy(wsc->wpa2_cred.addr, wsc->m1->addr, 6);
+		}
+
+		str =3D l_settings_get_string(settings, "WSC", "Open-SSID");
+		if (str) {
+			if (strlen(str) > 32)
+				goto err;
+
+			wsc->m2->auth_type_flags |=3D
+				WSC_AUTHENTICATION_TYPE_OPEN;
+			wsc->m2->encryption_type_flags |=3D
+				WSC_ENCRYPTION_TYPE_NONE;
+			wsc->open_cred.auth_type =3D
+				WSC_AUTHENTICATION_TYPE_OPEN;
+			wsc->open_cred.encryption_type =3D
+				WSC_ENCRYPTION_TYPE_NONE;
+
+			wsc->open_cred.ssid_len =3D strlen(str);
+			memcpy(wsc->open_cred.ssid, str,
+				wsc->open_cred.ssid_len);
+			l_free(str);
+
+			wsc->open_cred.network_key_len =3D 0;
+
+			memcpy(wsc->open_cred.addr, wsc->m1->addr, 6);
+		}
+
+		if (!wsc->m2->auth_type_flags)
+			goto err;
+
+		wsc->m2->connection_type_flags =3D WSC_CONNECTION_TYPE_ESS;
+	}
+
+	/*
+	 * The settings we read below probably shouldn't be used except to
+	 * eliminate randomness in debugging/tests.
+	 */
+	if (registrar) {
+		if (!load_hexencoded(settings, "RegistrarNonce",
+						wsc->m2->registrar_nonce, 16))
+			l_getrandom(wsc->m2->registrar_nonce, 16);
+	} else {
+		if (!load_hexencoded(settings, "EnrolleeNonce",
+						wsc->m1->enrollee_nonce, 16))
+			l_getrandom(wsc->m1->enrollee_nonce, 16);
+	}
+
+	if (load_hexencoded(settings, "PrivateKey", private_key, 192)) {
+		if (!l_key_validate_dh_payload(private_key, 192,
+						crypto_dh5_prime,
+						crypto_dh5_prime_size)) {
+			explicit_bzero(private_key, 192);
+			goto err;
+		}
+
+		wsc->private =3D l_key_new(L_KEY_RAW, private_key, 192);
+		explicit_bzero(private_key, 192);
+	} else
+		wsc->private =3D l_key_generate_dh_private(crypto_dh5_prime,
+							crypto_dh5_prime_size);
+
+	if (!wsc->private)
+		goto err;
+
+	len =3D sizeof(wsc->m1->public_key);
+	if (!l_key_compute_dh_public(dh5_generator, wsc->private, dh5_prime,
+					registrar ? wsc->m2->public_key :
+					wsc->m1->public_key, &len))
+		goto err;
+
+	if (len !=3D sizeof(wsc->m1->public_key))
+		goto err;
+
+	if (!load_hexencoded(settings, registrar ? "R-SNonce1" : "E-SNonce1",
+							wsc->local_snonce1, 16))
+		l_getrandom(wsc->local_snonce1, 16);
+
+	if (!load_hexencoded(settings, registrar ? "R-SNonce2" : "E-SNonce2",
+							wsc->local_snonce2, 16))
+		l_getrandom(wsc->local_snonce2, 16);
 =

 	if (!load_hexencoded(settings, "IV1", wsc->iv1, 16))
 		l_getrandom(wsc->iv1, 16);
@@ -1373,6 +1553,9 @@ static bool eap_wsc_load_settings(struct eap_state *e=
ap,
 	if (!load_hexencoded(settings, "IV2", wsc->iv2, 16))
 		l_getrandom(wsc->iv2, 16);
 =

+	if (registrar && !load_hexencoded(settings, "IV3", wsc->iv3, 16))
+		l_getrandom(wsc->iv3, 16);
+
 	eap_set_data(eap, wsc);
 =

 	return true;
@@ -1387,12 +1570,22 @@ err:
 	if (wsc->private)
 		l_key_free(wsc->private);
 =

+	explicit_bzero(&wsc->wpa2_cred, sizeof(struct wsc_credential));
+	explicit_bzero(&wsc->open_cred, sizeof(struct wsc_credential));
 	l_free(wsc->m1);
+	l_free(wsc->m2);
 	l_free(wsc);
 =

 	return false;
 }
 =

+static bool eap_wsc_load_settings(struct eap_state *eap,
+					struct l_settings *settings,
+					const char *prefix)
+{
+	return eap_wsc_load_common(eap, settings, false);
+}
+
 static struct eap_method eap_wsc =3D {
 	.vendor_id =3D { 0x00, 0x37, 0x2a },
 	.vendor_type =3D 0x00000001,
@@ -1405,6 +1598,23 @@ static struct eap_method eap_wsc =3D {
 	.load_settings =3D eap_wsc_load_settings,
 };
 =

+static bool eap_wsc_r_load_settings(struct eap_state *eap,
+					struct l_settings *settings,
+					const char *prefix)
+{
+	return eap_wsc_load_common(eap, settings, true);
+}
+
+static struct eap_method eap_wsc_r =3D {
+	.name =3D "WSC-R",
+	.request_type =3D EAP_TYPE_EXPANDED,
+	.vendor_id =3D { 0x00, 0x37, 0x2a },
+	.vendor_type =3D 0x00000001,
+	.exports_msk =3D true,
+	.free =3D eap_wsc_free,
+	.load_settings =3D eap_wsc_r_load_settings,
+};
+
 static int eap_wsc_init(void)
 {
 	int r =3D -ENOTSUP;
@@ -1422,12 +1632,18 @@ static int eap_wsc_init(void)
 		goto fail_prime;
 =

 	r =3D eap_register_method(&eap_wsc);
+	if (r)
+		goto fail_register;
+
+	r =3D eap_register_method(&eap_wsc_r);
 	if (!r)
 		return 0;
 =

+	eap_unregister_method(&eap_wsc);
+
+fail_register:
 	l_key_free(dh5_prime);
 	dh5_prime =3D NULL;
-
 fail_prime:
 	l_key_free(dh5_generator);
 	dh5_generator =3D NULL;
@@ -1440,6 +1656,7 @@ static void eap_wsc_exit(void)
 	l_debug("");
 =

 	eap_unregister_method(&eap_wsc);
+	eap_unregister_method(&eap_wsc_r);
 =

 	l_key_free(dh5_prime);
 	l_key_free(dh5_generator);
-- =

2.25.1

--===============9213920696991847986==--

