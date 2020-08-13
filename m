Content-Type: multipart/mixed; boundary="===============7772754226520460296=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/16] eap-wsc: Handle the M{1,3,5,7} messages
Date: Thu, 13 Aug 2020 02:53:35 +0200
Message-ID: <20200813005338.295108-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005338.295108-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7772754226520460296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parse, validate and respond to the M1, M3, M5 and M7 messages and send
the M2, M4, M6 and M8.
---
 src/eap-wsc.c | 496 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 496 insertions(+)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 34de6033..60396003 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -954,6 +954,483 @@ clear_keys:
 	explicit_bzero(&keys, sizeof(keys));
 }
 =

+static void eap_wsc_r_send_m8(struct eap_state *eap,
+				const uint8_t *m7_pdu, size_t m7_len)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+	struct wsc_m8_encrypted_settings m8es =3D {};
+	struct wsc_m8 m8;
+	uint8_t *pdu;
+	size_t pdu_len;
+	/* At least: 2 * credential, 12 for Authenticator, 16 for IV + up to 16 p=
ad */
+	uint8_t encrypted[1024];
+	size_t encrypted_len;
+	bool r;
+	struct wsc_credential creds[2];
+	unsigned int creds_cnt =3D 0;
+	unsigned int auth_types =3D
+		wsc->m1->auth_type_flags & wsc->m2->auth_type_flags;
+
+	if (auth_types & WSC_AUTHENTICATION_TYPE_OPEN)
+		memcpy(&creds[creds_cnt++], &wsc->open_cred,
+			sizeof(struct wsc_credential));
+
+	if (auth_types & WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL)
+		memcpy(&creds[creds_cnt++], &wsc->wpa2_cred,
+			sizeof(struct wsc_credential));
+
+	pdu =3D wsc_build_m8_encrypted_settings(&m8es, creds, creds_cnt,
+						&pdu_len);
+	explicit_bzero(creds, creds_cnt * sizeof(struct wsc_credential));
+	if (!pdu)
+		return;
+
+	keywrap_authenticator_put(wsc, pdu, pdu_len);
+	r =3D encrypted_settings_encrypt(wsc, wsc->iv3, pdu, pdu_len,
+						encrypted, &encrypted_len);
+	explicit_bzero(pdu, pdu_len);
+	l_free(pdu);
+
+	if (!r)
+		return;
+
+	m8.version2 =3D true;
+	memcpy(m8.enrollee_nonce, wsc->m1->enrollee_nonce,
+						sizeof(m8.enrollee_nonce));
+
+	pdu =3D wsc_build_m8(&m8, encrypted, encrypted_len, &pdu_len);
+	if (!pdu)
+		return;
+
+	authenticator_put(wsc, m7_pdu, m7_len, pdu, pdu_len);
+	eap_wsc_send_message(eap, pdu, pdu_len);
+	wsc->state =3D STATE_EXPECT_DONE;
+}
+
+static void eap_wsc_r_handle_m7(struct eap_state *eap,
+					const uint8_t *pdu, size_t len)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+	struct wsc_m7 m7;
+	struct iovec encrypted;
+	uint8_t *decrypted;
+	size_t decrypted_len;
+	struct wsc_m7_encrypted_settings m7es;
+	enum wsc_configuration_error error =3D WSC_CONFIGURATION_ERROR_NO_ERROR;
+
+	/* Spec unclear what to do here, see comments in eap_wsc_send_nack */
+	if (wsc_parse_m7(pdu, len, &m7, &encrypted) !=3D 0)
+		goto send_nack;
+
+	if (memcmp(m7.registrar_nonce, wsc->m2->registrar_nonce,
+						sizeof(m7.registrar_nonce)))
+		goto send_nack;
+
+	if (!authenticator_check(wsc, pdu, len))
+		return;
+
+	decrypted =3D encrypted_settings_decrypt(wsc, encrypted.iov_base,
+							encrypted.iov_len,
+							&decrypted_len);
+	if (!decrypted) {
+		error =3D WSC_CONFIGURATION_ERROR_DECRYPTION_CRC_FAILURE;
+		goto send_nack;
+	}
+
+	if (wsc_parse_m7_encrypted_settings(decrypted, decrypted_len, &m7es)) {
+		error =3D WSC_CONFIGURATION_ERROR_DECRYPTION_CRC_FAILURE;
+		goto cleanup;
+	}
+
+	if (!keywrap_authenticator_check(wsc, decrypted, decrypted_len)) {
+		error =3D WSC_CONFIGURATION_ERROR_DECRYPTION_CRC_FAILURE;
+		goto cleanup;
+	}
+
+	/* We have E-SNonce2, verify E-Hash2 stored in eap_wsc_r_handle_m3 */
+	if (!x_hash_check(wsc, m7es.e_snonce2, wsc->psk2, wsc->e_hash2)) {
+		error =3D WSC_CONFIGURATION_ERROR_DEVICE_PASSWORD_AUTH_FAILURE;
+		goto cleanup;
+	}
+
+	eap_wsc_r_send_m8(eap, pdu, len);
+
+cleanup:
+	explicit_bzero(&m7es, sizeof(m7es));
+	explicit_bzero(decrypted, decrypted_len);
+	l_free(decrypted);
+
+	if (!error)
+		return;
+
+send_nack:
+	eap_wsc_send_nack(eap, error);
+}
+
+static void eap_wsc_r_send_m6(struct eap_state *eap,
+				const uint8_t *m5_pdu, size_t m5_len)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+	struct wsc_m6_encrypted_settings m6es;
+	struct wsc_m6 m6;
+	uint8_t *pdu;
+	size_t pdu_len;
+	/* 20 for SNonce, 12 for Authenticator, 16 for IV + up to 16 pad */
+	uint8_t encrypted[64];
+	size_t encrypted_len;
+	bool r;
+
+	memcpy(m6es.r_snonce2, wsc->local_snonce2, sizeof(wsc->local_snonce2));
+	pdu =3D wsc_build_m6_encrypted_settings(&m6es, &pdu_len);
+	explicit_bzero(m6es.r_snonce2, sizeof(wsc->local_snonce2));
+	if (!pdu)
+		return;
+
+	keywrap_authenticator_put(wsc, pdu, pdu_len);
+	r =3D encrypted_settings_encrypt(wsc, wsc->iv2, pdu, pdu_len,
+						encrypted, &encrypted_len);
+	explicit_bzero(pdu, pdu_len);
+	l_free(pdu);
+
+	if (!r)
+		return;
+
+	m6.version2 =3D true;
+	memcpy(m6.enrollee_nonce, wsc->m1->enrollee_nonce,
+						sizeof(m6.enrollee_nonce));
+
+	pdu =3D wsc_build_m6(&m6, encrypted, encrypted_len, &pdu_len);
+	if (!pdu)
+		return;
+
+	authenticator_put(wsc, m5_pdu, m5_len, pdu, pdu_len);
+	eap_wsc_send_message(eap, pdu, pdu_len);
+	wsc->state =3D STATE_EXPECT_M7;
+}
+
+static void eap_wsc_r_handle_m5(struct eap_state *eap,
+					const uint8_t *pdu, size_t len)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+	struct wsc_m5 m5;
+	struct iovec encrypted;
+	uint8_t *decrypted;
+	size_t decrypted_len;
+	struct wsc_m5_encrypted_settings m5es;
+	enum wsc_configuration_error error =3D WSC_CONFIGURATION_ERROR_NO_ERROR;
+
+	/* Spec unclear what to do here, see comments in eap_wsc_send_nack */
+	if (wsc_parse_m5(pdu, len, &m5, &encrypted) !=3D 0)
+		goto send_nack;
+
+	if (memcmp(m5.registrar_nonce, wsc->m2->registrar_nonce,
+						sizeof(m5.registrar_nonce)))
+		goto send_nack;
+
+	if (!authenticator_check(wsc, pdu, len))
+		return;
+
+	decrypted =3D encrypted_settings_decrypt(wsc, encrypted.iov_base,
+							encrypted.iov_len,
+							&decrypted_len);
+	if (!decrypted) {
+		error =3D WSC_CONFIGURATION_ERROR_DECRYPTION_CRC_FAILURE;
+		goto send_nack;
+	}
+
+	if (wsc_parse_m5_encrypted_settings(decrypted, decrypted_len, &m5es)) {
+		error =3D WSC_CONFIGURATION_ERROR_DECRYPTION_CRC_FAILURE;
+		goto cleanup;
+	}
+
+	if (!keywrap_authenticator_check(wsc, decrypted, decrypted_len)) {
+		error =3D WSC_CONFIGURATION_ERROR_DECRYPTION_CRC_FAILURE;
+		goto cleanup;
+	}
+
+	/* We have E-SNonce1, verify E-Hash1 stored in eap_wsc_r_handle_m3 */
+	if (!x_hash_check(wsc, m5es.e_snonce1, wsc->psk1, wsc->e_hash1)) {
+		error =3D WSC_CONFIGURATION_ERROR_DEVICE_PASSWORD_AUTH_FAILURE;
+		goto cleanup;
+	}
+
+	eap_wsc_r_send_m6(eap, pdu, len);
+
+cleanup:
+	explicit_bzero(&m5es, sizeof(m5es));
+	explicit_bzero(decrypted, decrypted_len);
+	l_free(decrypted);
+
+	if (!error)
+		return;
+
+send_nack:
+	eap_wsc_send_nack(eap, error);
+}
+
+static void eap_wsc_r_send_m4(struct eap_state *eap,
+				const uint8_t *m3_pdu, size_t m3_len)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+	struct wsc_m4_encrypted_settings m4es;
+	struct wsc_m4 m4;
+	uint8_t *pdu;
+	size_t pdu_len;
+	/* 20 for SNonce, 12 for Authenticator, 16 for IV + up to 16 pad */
+	uint8_t encrypted[64];
+	size_t encrypted_len;
+	bool r;
+	size_t len;
+	size_t len_half1;
+	struct iovec iov[4];
+
+	memcpy(m4es.r_snonce1, wsc->local_snonce1, sizeof(wsc->local_snonce1));
+	pdu =3D wsc_build_m4_encrypted_settings(&m4es, &pdu_len);
+	explicit_bzero(m4es.r_snonce1, sizeof(wsc->local_snonce1));
+	if (!pdu)
+		return;
+
+	keywrap_authenticator_put(wsc, pdu, pdu_len);
+	r =3D encrypted_settings_encrypt(wsc, wsc->iv1, pdu, pdu_len,
+						encrypted, &encrypted_len);
+	explicit_bzero(pdu, pdu_len);
+	l_free(pdu);
+
+	if (!r)
+		return;
+
+	len =3D strlen(wsc->device_password);
+
+	/* WSC 2.0.5, Section 7.4:
+	 * In case the UTF8 representation of the DevicePassword length is an
+	 * odd number (N), the first half of DevicePassword will have length
+	 * of N/2+1 and the second half of the DevicePassword will have length
+	 * of N/2.
+	 */
+	len_half1 =3D (len + 1) / 2;
+
+	l_checksum_update(wsc->hmac_auth_key, wsc->device_password, len_half1);
+	l_checksum_get_digest(wsc->hmac_auth_key, wsc->psk1, sizeof(wsc->psk1));
+
+	l_checksum_update(wsc->hmac_auth_key, wsc->device_password + len_half1,
+					len / 2);
+	l_checksum_get_digest(wsc->hmac_auth_key, wsc->psk2, sizeof(wsc->psk2));
+
+	m4.version2 =3D true;
+	memcpy(m4.enrollee_nonce, wsc->m1->enrollee_nonce,
+						sizeof(m4.enrollee_nonce));
+
+	/* WSC 2.0.5, Section 7.4:
+	 * The Registrar creates two 128-bit secret nonces, R-S1, R-S2 and then
+	 * computes:
+	 * R-Hash1 =3D HMACAuthKey(R-S1 || PSK1 || PKE || PKR)
+	 * R-Hash2 =3D HMACAuthKey(R-S2 || PSK2 || PKE || PKR)
+	 */
+	iov[0].iov_base =3D wsc->local_snonce1;
+	iov[0].iov_len =3D sizeof(wsc->local_snonce1);
+	iov[1].iov_base =3D wsc->psk1;
+	iov[1].iov_len =3D sizeof(wsc->psk1);
+	iov[2].iov_base =3D wsc->m1->public_key;
+	iov[2].iov_len =3D sizeof(wsc->m1->public_key);
+	iov[3].iov_base =3D wsc->m2->public_key;
+	iov[3].iov_len =3D sizeof(wsc->m2->public_key);
+	l_checksum_updatev(wsc->hmac_auth_key, iov, 4);
+	l_checksum_get_digest(wsc->hmac_auth_key,
+					m4.r_hash1, sizeof(m4.r_hash1));
+
+	iov[0].iov_base =3D wsc->local_snonce2;
+	iov[0].iov_len =3D sizeof(wsc->local_snonce2);
+	iov[1].iov_base =3D wsc->psk2;
+	iov[1].iov_len =3D sizeof(wsc->psk2);
+	l_checksum_updatev(wsc->hmac_auth_key, iov, 4);
+	l_checksum_get_digest(wsc->hmac_auth_key,
+					m4.r_hash2, sizeof(m4.r_hash2));
+
+	pdu =3D wsc_build_m4(&m4, encrypted, encrypted_len, &pdu_len);
+	if (!pdu)
+		return;
+
+	authenticator_put(wsc, m3_pdu, m3_len, pdu, pdu_len);
+	eap_wsc_send_message(eap, pdu, pdu_len);
+	wsc->state =3D STATE_EXPECT_M5;
+}
+
+static void eap_wsc_r_handle_m3(struct eap_state *eap,
+					const uint8_t *pdu, size_t len)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+	struct wsc_m3 m3;
+
+	if (wsc_parse_m3(pdu, len, &m3) !=3D 0)
+		goto send_nack;
+
+	if (memcmp(m3.registrar_nonce, wsc->m2->registrar_nonce,
+						sizeof(m3.registrar_nonce)))
+		goto send_nack;
+
+	if (!authenticator_check(wsc, pdu, len))
+		return;
+
+	/* We can't verify these until we receive the E-S1/E-S2 in M5/M7 */
+	memcpy(wsc->e_hash1, m3.e_hash1, sizeof(m3.e_hash1));
+	memcpy(wsc->e_hash2, m3.e_hash2, sizeof(m3.e_hash2));
+
+	eap_wsc_r_send_m4(eap, pdu, len);
+	return;
+
+send_nack:
+	/* Spec unclear what to do here, see comments in eap_wsc_send_nack */
+	eap_wsc_send_nack(eap, WSC_CONFIGURATION_ERROR_NO_ERROR);
+}
+
+static void eap_wsc_r_send_m2(struct eap_state *eap,
+				const uint8_t *m1_pdu, size_t m1_len)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+	uint8_t *pdu;
+	size_t pdu_len;
+
+	wsc->m2->version2 =3D true;
+	memcpy(wsc->m2->enrollee_nonce, wsc->m1->enrollee_nonce, 16);
+	wsc->m2->association_state =3D WSC_ASSOCIATION_STATE_NOT_ASSOCIATED;
+	wsc->m2->configuration_error =3D WSC_CONFIGURATION_ERROR_NO_ERROR;
+
+	pdu =3D wsc_build_m2(wsc->m2, &pdu_len);
+	if (!pdu)
+		return;
+
+	authenticator_put(wsc, m1_pdu, m1_len, pdu, pdu_len);
+	eap_wsc_send_message(eap, pdu, pdu_len);
+	wsc->state =3D STATE_EXPECT_M3;
+}
+
+static void eap_wsc_r_handle_m1(struct eap_state *eap,
+					const uint8_t *pdu, size_t len)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+	struct l_key *remote_public;
+	uint8_t shared_secret[192] =3D { 0 };
+	size_t shared_secret_len =3D sizeof(shared_secret);
+	struct l_checksum *sha256;
+	uint8_t dhkey[32];
+	struct l_checksum *hmac_sha256;
+	struct iovec iov[3];
+	uint8_t kdk[32];
+	struct wsc_session_key keys;
+	bool r;
+	uint8_t expected_enrollee_mac[6];
+	uint8_t expected_uuid_e[16];
+
+	memcpy(expected_enrollee_mac, wsc->m1->addr, 6);
+	memcpy(expected_uuid_e, wsc->m1->uuid_e, 16);
+
+	/* Spec unclear what to do here, see comments in eap_wsc_send_nack */
+	if (wsc_parse_m1(pdu, len, wsc->m1) !=3D 0) {
+		eap_wsc_send_nack(eap, WSC_CONFIGURATION_ERROR_NO_ERROR);
+		return;
+	}
+
+	if (memcmp(expected_enrollee_mac, wsc->m1->addr, 6) ||
+			memcmp(expected_uuid_e, wsc->m1->uuid_e, 16)) {
+		eap_wsc_send_nack(eap,
+			WSC_CONFIGURATION_ERROR_MULTIPLE_PBC_SESSIONS_DETECTED);
+		eap_method_error(eap);
+		return;
+	}
+
+	if (wsc->m1->state !=3D WSC_STATE_NOT_CONFIGURED ||
+			!(wsc->m1->auth_type_flags &
+				wsc->m2->auth_type_flags) ||
+			!(wsc->m1->encryption_type_flags &
+				wsc->m2->encryption_type_flags) ||
+			!(wsc->m1->connection_type_flags &
+				wsc->m2->connection_type_flags) ||
+			!(wsc->m1->config_methods &
+				wsc->m2->config_methods) ||
+			!(wsc->m1->rf_bands & wsc->m2->rf_bands)) {
+		eap_wsc_send_nack(eap, WSC_CONFIGURATION_ERROR_NO_ERROR);
+		return;
+	}
+
+	if (wsc->m1->configuration_error !=3D WSC_CONFIGURATION_ERROR_NO_ERROR ||
+			wsc->m1->device_password_id !=3D
+			wsc->m2->device_password_id) {
+		eap_wsc_send_nack(eap, WSC_CONFIGURATION_ERROR_NO_ERROR);
+		return;
+	}
+
+	/* m1->request_to_enroll not checked */
+
+	if (!l_key_validate_dh_payload(wsc->m1->public_key,
+					sizeof(wsc->m1->public_key),
+					crypto_dh5_prime,
+					crypto_dh5_prime_size))
+		return;
+
+	/*
+	 * Done validating the M1, we can now derive the keys for most of
+	 * the rest of the registration protocol.
+	 */
+
+	remote_public =3D l_key_new(L_KEY_RAW, wsc->m1->public_key,
+						sizeof(wsc->m1->public_key));
+	if (!remote_public)
+		return;
+
+	r =3D l_key_compute_dh_secret(remote_public, wsc->private, dh5_prime,
+					shared_secret, &shared_secret_len);
+	l_key_free(remote_public);
+
+	if (!r)
+		return;
+
+	sha256 =3D l_checksum_new(L_CHECKSUM_SHA256);
+	if (!sha256)
+		return;
+
+	l_checksum_update(sha256, shared_secret, shared_secret_len);
+	explicit_bzero(shared_secret, shared_secret_len);
+	l_checksum_get_digest(sha256, dhkey, sizeof(dhkey));
+	l_checksum_free(sha256);
+
+	hmac_sha256 =3D l_checksum_new_hmac(L_CHECKSUM_SHA256,
+							dhkey, sizeof(dhkey));
+	explicit_bzero(dhkey, sizeof(dhkey));
+
+	if (!hmac_sha256)
+		return;
+
+	iov[0].iov_base =3D wsc->m1->enrollee_nonce;
+	iov[0].iov_len =3D 16;
+	iov[1].iov_base =3D wsc->m1->addr;
+	iov[1].iov_len =3D 6;
+	iov[2].iov_base =3D wsc->m2->registrar_nonce;
+	iov[2].iov_len =3D 16;
+
+	l_checksum_updatev(hmac_sha256, iov, 3);
+	l_checksum_get_digest(hmac_sha256, kdk, sizeof(kdk));
+	l_checksum_free(hmac_sha256);
+
+	r =3D wsc_kdf(kdk, &keys, sizeof(keys));
+	explicit_bzero(kdk, sizeof(kdk));
+	if (!r)
+		return;
+
+	wsc->hmac_auth_key =3D l_checksum_new_hmac(L_CHECKSUM_SHA256,
+						keys.auth_key,
+						sizeof(keys.auth_key));
+
+	/*
+	 * AuthKey is uploaded into the kernel, once we upload KeyWrapKey,
+	 * the keys variable is no longer useful.  Make sure to wipe it
+	 */
+	wsc->aes_cbc_128 =3D l_cipher_new(L_CIPHER_AES_CBC, keys.keywrap_key,
+						sizeof(keys.keywrap_key));
+	explicit_bzero(&keys, sizeof(keys));
+
+	eap_wsc_r_send_m2(eap, pdu, len);
+}
+
 static void eap_wsc_handle_nack(struct eap_state *eap,
 					const uint8_t *pdu, size_t len)
 {
@@ -1130,6 +1607,7 @@ static void eap_wsc_handle_message(struct eap_state *=
eap,
 		return;
 =

 	switch (wsc->state) {
+	/* Enrollee state machine */
 	case STATE_EXPECT_START:
 		return;
 	case STATE_EXPECT_M2:
@@ -1147,6 +1625,24 @@ static void eap_wsc_handle_message(struct eap_state =
*eap,
 	case STATE_FINISHED:
 		eap_wsc_send_nack(eap, WSC_CONFIGURATION_ERROR_NO_ERROR);
 		return;
+
+	/* Registrar state machine */
+	case STATE_EXPECT_M1:
+		eap_wsc_r_handle_m1(eap, pkt, len);
+		break;
+	case STATE_EXPECT_M3:
+		eap_wsc_r_handle_m3(eap, pkt, len);
+		break;
+	case STATE_EXPECT_M5:
+		eap_wsc_r_handle_m5(eap, pkt, len);
+		break;
+	case STATE_EXPECT_M7:
+		eap_wsc_r_handle_m7(eap, pkt, len);
+		break;
+	case STATE_EXPECT_IDENTITY:
+	case STATE_EXPECT_DONE:
+		eap_wsc_send_nack(eap, WSC_CONFIGURATION_ERROR_NO_ERROR);
+		return;
 	}
 =

 	if (wsc->rx_pdu_buf) {
-- =

2.25.1

--===============7772754226520460296==--

