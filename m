Content-Type: multipart/mixed; boundary="===============6491977864643705908=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/16] eap-wsc: Registrar mode message handling
Date: Thu, 13 Aug 2020 02:53:34 +0200
Message-ID: <20200813005338.295108-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005338.295108-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6491977864643705908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit has all the changes to modify and generalise the current
eap-wsc.c code to handle both the Enrollee and Registrar side of the
protocol, reusing existing functions and structures.
---
 src/eap-wsc.c | 134 +++++++++++++++++++++++++++++++++++++++-----------
 src/eap-wsc.h |   1 +
 2 files changed, 106 insertions(+), 29 deletions(-)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 2770c87a..34de6033 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -93,6 +93,8 @@ struct eap_wsc_state {
 	uint8_t iv3[16];
 	uint8_t psk1[16];
 	uint8_t psk2[16];
+	uint8_t e_hash1[32];
+	uint8_t e_hash2[32];
 	uint8_t r_hash2[32];
 	enum state state;
 	struct l_checksum *hmac_auth_key;
@@ -171,22 +173,26 @@ static inline void keywrap_authenticator_put(struct e=
ap_wsc_state *wsc,
 	l_checksum_get_digest(wsc->hmac_auth_key, pdu + len - 8, 8);
 }
 =

-static inline bool r_hash_check(struct eap_wsc_state *wsc,
-				uint8_t *r_snonce,
+static inline bool x_hash_check(struct eap_wsc_state *wsc,
+				uint8_t *x_snonce,
 				uint8_t *psk,
-				uint8_t *r_hash_expected)
+				uint8_t *x_hash_expected)
 {
 	struct iovec iov[4];
-	uint8_t r_hash[32];
+	uint8_t hash[32];
 =

 	/*
 	 * WSC 2.0.5, Section 7.4:
+	 * The Enrollee creates two 128-bit secret nonces, E-S1, E-S2 and
+	 * then computes
+	 * E-Hash1 =3D HMACAuthKey(E-S1 || PSK1 || PKE || PKR)
+	 * E-Hash2 =3D HMACAuthKey(E-S2 || PSK2 || PKE || PKR)
 	 * The Registrar creates two 128-bit secret nonces, R-S1, R-S2 and
 	 * then computes
 	 * R-Hash1 =3D HMACAuthKey(R-S1 || PSK1 || PKE || PKR)
 	 * R-Hash2 =3D HMACAuthKey(R-S2 || PSK2 || PKE || PKR)
 	 */
-	iov[0].iov_base =3D r_snonce;
+	iov[0].iov_base =3D x_snonce;
 	iov[0].iov_len =3D 16;
 	iov[1].iov_base =3D psk;
 	iov[1].iov_len =3D 16;
@@ -195,9 +201,9 @@ static inline bool r_hash_check(struct eap_wsc_state *w=
sc,
 	iov[3].iov_base =3D wsc->m2->public_key;
 	iov[3].iov_len =3D sizeof(wsc->m2->public_key);
 	l_checksum_updatev(wsc->hmac_auth_key, iov, 4);
-	l_checksum_get_digest(wsc->hmac_auth_key, r_hash, sizeof(r_hash));
+	l_checksum_get_digest(wsc->hmac_auth_key, hash, sizeof(hash));
 =

-	return !memcmp(r_hash, r_hash_expected, sizeof(r_hash));
+	return !memcmp(hash, x_hash_expected, sizeof(hash));
 }
 =

 static uint8_t *encrypted_settings_decrypt(struct eap_wsc_state *wsc,
@@ -327,6 +333,16 @@ static void eap_wsc_free(struct eap_state *eap)
 	l_free(wsc);
 }
 =

+static void eap_wsc_r_send_start(struct eap_state *eap)
+{
+	uint8_t buf[EAP_WSC_HEADER_LEN];
+
+	buf[12] =3D WSC_OP_START;
+	buf[13] =3D 0;
+
+	eap_method_new_request(eap, buf, EAP_WSC_HEADER_LEN);
+}
+
 static void eap_wsc_send_fragment(struct eap_state *eap)
 {
 	struct eap_wsc_state *wsc =3D eap_get_data(eap);
@@ -353,12 +369,16 @@ static void eap_wsc_send_fragment(struct eap_state *e=
ap)
 	}
 =

 	memcpy(buf + header_len, wsc->sent_pdu + wsc->tx_frag_offset, len);
-	eap_method_respond(eap, buf, header_len + len);
+
+	if (wsc->registrar)
+		eap_method_new_request(eap, buf, header_len + len);
+	else
+		eap_method_respond(eap, buf, header_len + len);
 =

 	wsc->tx_last_frag_len =3D len;
 }
 =

-static void eap_wsc_send_response(struct eap_state *eap,
+static void eap_wsc_send_message(struct eap_state *eap,
 						uint8_t *pdu, size_t pdu_len)
 {
 	struct eap_wsc_state *wsc =3D eap_get_data(eap);
@@ -373,7 +393,11 @@ static void eap_wsc_send_response(struct eap_state *ea=
p,
 		buf[13] =3D 0;
 		memcpy(buf + EAP_WSC_HEADER_LEN, pdu, pdu_len);
 =

-		eap_method_respond(eap, buf, msg_len);
+		if (wsc->registrar)
+			eap_method_new_request(eap, buf, msg_len);
+		else
+			eap_method_respond(eap, buf, msg_len);
+
 		l_free(buf);
 		return;
 	}
@@ -414,8 +438,11 @@ static void eap_wsc_send_nack(struct eap_state *eap,
 		return;
 =

 	nack.version2 =3D true;
-	memcpy(nack.enrollee_nonce, wsc->m1->enrollee_nonce,
+	if (wsc->state !=3D STATE_EXPECT_M1)
+		memcpy(nack.enrollee_nonce, wsc->m1->enrollee_nonce,
 						sizeof(nack.enrollee_nonce));
+	else
+		memset(nack.enrollee_nonce, 0, sizeof(nack.enrollee_nonce));
 =

 	if (wsc->m2)
 		memcpy(nack.registrar_nonce, wsc->m2->registrar_nonce,
@@ -433,7 +460,11 @@ static void eap_wsc_send_nack(struct eap_state *eap,
 	buf[13] =3D 0;
 	memcpy(buf + EAP_WSC_HEADER_LEN, pdu, pdu_len);
 =

-	eap_method_respond(eap, buf, pdu_len + EAP_WSC_HEADER_LEN);
+	if (wsc->registrar)
+		eap_method_new_request(eap, buf, pdu_len + EAP_WSC_HEADER_LEN);
+	else
+		eap_method_respond(eap, buf, pdu_len + EAP_WSC_HEADER_LEN);
+
 	l_free(pdu);
 }
 =

@@ -465,12 +496,16 @@ static void eap_wsc_send_done(struct eap_state *eap)
 =

 static void eap_wsc_send_frag_ack(struct eap_state *eap)
 {
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
 	uint8_t buf[EAP_WSC_HEADER_LEN];
 =

 	buf[12] =3D WSC_OP_FRAG_ACK;
 	buf[13] =3D 0;
 =

-	eap_method_respond(eap, buf, EAP_WSC_HEADER_LEN);
+	if (wsc->registrar)
+		eap_method_new_request(eap, buf, EAP_WSC_HEADER_LEN);
+	else
+		eap_method_respond(eap, buf, EAP_WSC_HEADER_LEN);
 }
 =

 static void eap_wsc_handle_m8(struct eap_state *eap,
@@ -579,7 +614,7 @@ static void eap_wsc_send_m7(struct eap_state *eap,
 		return;
 =

 	authenticator_put(wsc, m6_pdu, m6_len, pdu, pdu_len);
-	eap_wsc_send_response(eap, pdu, pdu_len);
+	eap_wsc_send_message(eap, pdu, pdu_len);
 	wsc->state =3D STATE_EXPECT_M8;
 }
 =

@@ -624,7 +659,7 @@ static void eap_wsc_handle_m6(struct eap_state *eap,
 	}
 =

 	/* We now have R-SNonce2, verify R-Hash2 stored in eap_wsc_handle_m4 */
-	if (!r_hash_check(wsc, m6es.r_snonce2, wsc->psk2, wsc->r_hash2)) {
+	if (!x_hash_check(wsc, m6es.r_snonce2, wsc->psk2, wsc->r_hash2)) {
 		error =3D WSC_CONFIGURATION_ERROR_DEVICE_PASSWORD_AUTH_FAILURE;
 		goto cleanup;
 	}
@@ -680,7 +715,7 @@ static void eap_wsc_send_m5(struct eap_state *eap,
 		return;
 =

 	authenticator_put(wsc, m4_pdu, m4_len, pdu, pdu_len);
-	eap_wsc_send_response(eap, pdu, pdu_len);
+	eap_wsc_send_message(eap, pdu, pdu_len);
 	wsc->state =3D STATE_EXPECT_M6;
 }
 =

@@ -725,7 +760,7 @@ static void eap_wsc_handle_m4(struct eap_state *eap,
 	}
 =

 	/* Since we have obtained R-SNonce1, we can now verify R-Hash1. */
-	if (!r_hash_check(wsc, m4es.r_snonce1, wsc->psk1, m4.r_hash1)) {
+	if (!x_hash_check(wsc, m4es.r_snonce1, wsc->psk1, m4.r_hash1)) {
 		error =3D WSC_CONFIGURATION_ERROR_DEVICE_PASSWORD_AUTH_FAILURE;
 		goto cleanup;
 	}
@@ -812,7 +847,7 @@ static void eap_wsc_send_m3(struct eap_state *eap,
 		return;
 =

 	authenticator_put(wsc, m2_pdu, m2_len, pdu, pdu_len);
-	eap_wsc_send_response(eap, pdu, pdu_len);
+	eap_wsc_send_message(eap, pdu, pdu_len);
 	wsc->state =3D STATE_EXPECT_M4;
 }
 =

@@ -928,7 +963,8 @@ static void eap_wsc_handle_nack(struct eap_state *eap,
 	if (wsc_parse_wsc_nack(pdu, len, &nack) !=3D 0)
 		return;
 =

-	if (memcmp(nack.enrollee_nonce, wsc->m1->enrollee_nonce,
+	if (wsc->state !=3D STATE_EXPECT_M1 && memcmp(nack.enrollee_nonce,
+						wsc->m1->enrollee_nonce,
 						sizeof(nack.enrollee_nonce)))
 		return;
 =

@@ -944,10 +980,13 @@ static void eap_wsc_handle_nack(struct eap_state *eap,
 	 * to.  Our choice is to reflect back what the request error code is
 	 * in the response.
 	 */
-	eap_wsc_send_nack(eap, nack.configuration_error);
+	if (!wsc->registrar)
+		eap_wsc_send_nack(eap, nack.configuration_error);
+
+	eap_method_error(eap);
 }
 =

-static void eap_wsc_handle_request(struct eap_state *eap,
+static void eap_wsc_handle_message(struct eap_state *eap,
 					const uint8_t *pkt, size_t len)
 {
 	struct eap_wsc_state *wsc =3D eap_get_data(eap);
@@ -957,6 +996,16 @@ static void eap_wsc_handle_request(struct eap_state *e=
ap,
 	size_t pdu_len;
 	size_t rx_header_offset =3D 0;
 =

+	/*
+	 * pkt[0:len] is an EAP-Request packet contents if !wsc->registrar
+	 * and an EAP-Response otherwise.  Most of the parsing is going to
+	 * be identical though.
+	 *
+	 * Since we have disjoint sets of enum state values between
+	 * Enrollee and Registrar, most of the time we don't need to look
+	 * at wsc->registrar.
+	 */
+
 	if (len < 2)
 		return;
 =

@@ -978,7 +1027,7 @@ static void eap_wsc_handle_request(struct eap_state *e=
ap,
 		if (!pdu)
 			return;
 =

-		eap_wsc_send_response(eap, pdu, pdu_len);
+		eap_wsc_send_message(eap, pdu, pdu_len);
 		wsc->state =3D STATE_EXPECT_M2;
 		return;
 	case WSC_OP_NACK:
@@ -988,8 +1037,21 @@ static void eap_wsc_handle_request(struct eap_state *=
eap,
 		eap_wsc_handle_nack(eap, pkt, len);
 		return;
 	case WSC_OP_ACK:
+		/* Not used in the in-band Enrollee Registration scenario */
+		return;
 	case WSC_OP_DONE:
-		/* Should never receive these as Enrollee */
+		if (wsc->state !=3D STATE_EXPECT_DONE)
+			return;
+
+		/*
+		 * Notify higher layers that the registration protocol has
+		 * finished successfully as the EAP result is going to
+		 * always be the same.  May not be strictly needed as the
+		 * higher layers get the real confirmation when the enrollee
+		 * uses the credentials on their next connection.
+		 */
+		eap_method_event(eap, EAP_WSC_EVENT_CREDENTIAL_SENT, NULL);
+		eap_method_error(eap);
 		return;
 	case WSC_OP_FRAG_ACK:
 		if (wsc->tx_last_frag_len &&
@@ -1046,16 +1108,14 @@ static void eap_wsc_handle_request(struct eap_state=
 *eap,
 		}
 =

 		if (flags & WSC_FLAG_MF) {
-			if (!wsc->rx_pdu_buf) {
-				eap_method_error(eap);
-				return;
-			}
+			if (!wsc->rx_pdu_buf)
+				goto invalid_frag;
 =

 			eap_wsc_send_frag_ack(eap);
 			return;
 		} else if (wsc->rx_pdu_buf) {
 			if (wsc->rx_pdu_buf_len !=3D wsc->rx_pdu_buf_offset) {
-				l_error("Request fragment pkt size mismatch");
+				l_error("Message fragment pkt size mismatch");
 				goto invalid_frag;
 			}
 =

@@ -1593,7 +1653,7 @@ static struct eap_method eap_wsc =3D {
 	.exports_msk =3D true,
 	.name =3D "WSC",
 	.free =3D eap_wsc_free,
-	.handle_request =3D eap_wsc_handle_request,
+	.handle_request =3D eap_wsc_handle_message,
 	.handle_retransmit =3D eap_wsc_handle_retransmit,
 	.load_settings =3D eap_wsc_load_settings,
 };
@@ -1605,6 +1665,20 @@ static bool eap_wsc_r_load_settings(struct eap_state=
 *eap,
 	return eap_wsc_load_common(eap, settings, true);
 }
 =

+static bool eap_wsc_r_validate_identity(struct eap_state *eap,
+					const char *identity)
+{
+	struct eap_wsc_state *wsc =3D eap_get_data(eap);
+
+	if (strcmp(identity, "WFA-SimpleConfig-Enrollee-1-0"))
+		return false;
+
+	/* Identity Request/Response done, directly send the WSC_Start */
+	eap_wsc_r_send_start(eap);
+	wsc->state =3D STATE_EXPECT_M1;
+	return true;
+}
+
 static struct eap_method eap_wsc_r =3D {
 	.name =3D "WSC-R",
 	.request_type =3D EAP_TYPE_EXPANDED,
@@ -1613,6 +1687,8 @@ static struct eap_method eap_wsc_r =3D {
 	.exports_msk =3D true,
 	.free =3D eap_wsc_free,
 	.load_settings =3D eap_wsc_r_load_settings,
+	.validate_identity =3D eap_wsc_r_validate_identity,
+	.handle_response =3D eap_wsc_handle_message,
 };
 =

 static int eap_wsc_init(void)
diff --git a/src/eap-wsc.h b/src/eap-wsc.h
index 886fce81..ac4b7077 100644
--- a/src/eap-wsc.h
+++ b/src/eap-wsc.h
@@ -22,4 +22,5 @@
 =

 enum EAP_WSC_EVENT {
 	EAP_WSC_EVENT_CREDENTIAL_OBTAINED	=3D 0x0050f200,
+	EAP_WSC_EVENT_CREDENTIAL_SENT		=3D 0x0050f201,
 };
-- =

2.25.1

--===============6491977864643705908==--

