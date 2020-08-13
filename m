Content-Type: multipart/mixed; boundary="===============2337683825618723523=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/16] eap: Simplify sending EAP method responses
Date: Thu, 13 Aug 2020 02:50:17 +0200
Message-ID: <20200813005026.294950-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005026.294950-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2337683825618723523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace the usage of eap_send_response() in the method implementations
with a new eap_method_respond that skips the redundant "type" parameter.
The new eap_send_packet is used inside eap_method_respond and will be
reused for sending request packets in authenticator side EAP methods.
---
 src/eap-aka.c        |  8 +++----
 src/eap-gtc.c        |  2 +-
 src/eap-md5.c        |  3 +--
 src/eap-mschapv2.c   |  4 ++--
 src/eap-private.h    |  5 +---
 src/eap-pwd.c        |  9 ++++----
 src/eap-sim.c        |  6 ++---
 src/eap-tls-common.c |  7 +++---
 src/eap-wsc.c        | 14 +++++------
 src/eap.c            | 55 ++++++++++++++++++++++++++------------------
 src/simutil.c        |  2 +-
 11 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/src/eap-aka.c b/src/eap-aka.c
index 3c815dfd..3ac0b662 100644
--- a/src/eap-aka.c
+++ b/src/eap-aka.c
@@ -206,7 +206,7 @@ static void check_milenage_cb(const uint8_t *res, const=
 uint8_t *ck,
 		pos +=3D eap_sim_add_attribute(pos, EAP_SIM_AT_AUTS,
 				EAP_SIM_PAD_NONE, auts, EAP_AKA_AUTS_LEN);
 =

-		eap_send_response(eap, aka->type, response, 24);
+		eap_method_respond(eap, response, 24);
 =

 		return;
 	}
@@ -285,7 +285,7 @@ static void check_milenage_cb(const uint8_t *res, const=
 uint8_t *ck,
 	l_free(aka->chal_pkt);
 	aka->chal_pkt =3D NULL;
 =

-	eap_send_response(eap, aka->type, response, resp_len);
+	eap_method_respond(eap, response, resp_len);
 =

 	if (!aka->protected) {
 		eap_aka_finish(eap);
@@ -536,7 +536,7 @@ static void handle_notification(struct eap_state *eap, =
const uint8_t *pkt,
 			return;
 		}
 =

-		eap_send_response(eap, aka->type, response, pos - response);
+		eap_method_respond(eap, response, pos - response);
 =

 		aka->state =3D EAP_AKA_STATE_SUCCESS;
 =

@@ -583,7 +583,7 @@ static void handle_identity(struct eap_state *eap, cons=
t uint8_t *pkt,
 			EAP_SIM_PAD_LENGTH, (uint8_t *)aka->identity,
 			strlen(aka->identity));
 =

-	eap_send_response(eap, aka->type, response, pos - response);
+	eap_method_respond(eap, response, pos - response);
 }
 =

 static void eap_aka_handle_request(struct eap_state *eap,
diff --git a/src/eap-gtc.c b/src/eap-gtc.c
index f895ec61..d14fa686 100644
--- a/src/eap-gtc.c
+++ b/src/eap-gtc.c
@@ -64,7 +64,7 @@ static void eap_gtc_handle_request(struct eap_state *eap,
 =

 	memcpy(response + 5, gtc->password, secret_len);
 =

-	eap_send_response(eap, EAP_TYPE_GTC, response, 5 + secret_len);
+	eap_method_respond(eap, response, 5 + secret_len);
 =

 	eap_method_success(eap);
 =

diff --git a/src/eap-md5.c b/src/eap-md5.c
index 1dab7df7..df9f5ab2 100644
--- a/src/eap-md5.c
+++ b/src/eap-md5.c
@@ -79,8 +79,7 @@ static void eap_md5_handle_request(struct eap_state *eap,
 	l_checksum_get_digest(hash, response + 6, 16);
 	l_checksum_free(hash);
 =

-	eap_send_response(eap, EAP_TYPE_MD5_CHALLENGE,
-				response, sizeof(response));
+	eap_method_respond(eap, response, sizeof(response));
 =

 	/* We have no choice but to call it a success */
 	eap_method_success(eap);
diff --git a/src/eap-mschapv2.c b/src/eap-mschapv2.c
index 3ede3498..49b5335c 100644
--- a/src/eap-mschapv2.c
+++ b/src/eap-mschapv2.c
@@ -253,7 +253,7 @@ static bool eap_mschapv2_send_response(struct eap_state=
 *eap)
 							MSCHAPV2_CHAL_LEN);
 	memcpy(response->name, state->user, state->user_len);
 =

-	eap_send_response(eap, EAP_TYPE_MSCHAPV2, output, sizeof(output));
+	eap_method_respond(eap, output, sizeof(output));
 =

 	return true;
 }
@@ -346,7 +346,7 @@ static void eap_mschapv2_handle_success(struct eap_stat=
e *eap,
 	eap_method_success(eap);
 =

 	buffer[5] =3D MSCHAPV2_OP_SUCCESS;
-	eap_send_response(eap, EAP_TYPE_MSCHAPV2, buffer, sizeof(buffer));
+	eap_method_respond(eap, buffer, sizeof(buffer));
 =

 	/* The eapol set_key_material only needs msk, and that's all we got */
 	eap_set_key_material(eap, session_key, 32, NULL, 0, NULL, 0, NULL, 0);
diff --git a/src/eap-private.h b/src/eap-private.h
index d2e44397..65ee871d 100644
--- a/src/eap-private.h
+++ b/src/eap-private.h
@@ -114,10 +114,6 @@ void *eap_get_data(struct eap_state *eap);
 enum eap_type eap_get_method_type(struct eap_state *eap);
 const char *eap_get_method_name(struct eap_state *eap);
 =

-void eap_send_response(struct eap_state *eap,
-			enum eap_type request_type,
-			uint8_t *buf, size_t len);
-
 void eap_set_key_material(struct eap_state *eap,
 				const uint8_t *msk_data, size_t msk_len,
 				const uint8_t *emsk_data, size_t emsk_len,
@@ -126,6 +122,7 @@ void eap_set_key_material(struct eap_state *eap,
 =

 void eap_start_complete_timeout(struct eap_state *eap);
 =

+void eap_method_respond(struct eap_state *eap, uint8_t *buf, size_t len);
 bool eap_method_is_success(struct eap_state *eap);
 void eap_method_success(struct eap_state *eap);
 void eap_method_error(struct eap_state *eap);
diff --git a/src/eap-pwd.c b/src/eap-pwd.c
index a77f21b9..070d483a 100644
--- a/src/eap-pwd.c
+++ b/src/eap-pwd.c
@@ -194,7 +194,7 @@ static void eap_pwd_send_response(struct eap_state *eap,
 =

 	/* packet will fit within mtu */
 	if (len <=3D mtu) {
-		eap_send_response(eap, EAP_TYPE_PWD, pkt, len);
+		eap_method_respond(eap, pkt, len);
 		return;
 	}
 =

@@ -218,7 +218,7 @@ static void eap_pwd_send_response(struct eap_state *eap,
 =

 	l_info("sending initial fragment, %zu bytes", mtu);
 =

-	eap_send_response(eap, EAP_TYPE_PWD, frag, mtu);
+	eap_method_respond(eap, frag, mtu);
 =

 	/* alloc/copy remainder of packet to frag buf */
 	pwd->tx_frag_buf =3D l_malloc(pwd->tx_frag_remaining);
@@ -593,7 +593,7 @@ static void eap_pwd_send_ack(struct eap_state *eap)
 =

 	buf[5] =3D pwd->state + 1;
 =

-	eap_send_response(eap, EAP_TYPE_PWD, buf, 6);
+	eap_method_respond(eap, buf, 6);
 }
 =

 #define FRAG_BYTES(mtu, remaining) \
@@ -631,8 +631,7 @@ static void eap_pwd_handle_request(struct eap_state *ea=
p,
 		l_info("sending fragment, %d bytes",
 				frag_bytes + EAP_PWD_HDR_LEN);
 =

-		eap_send_response(eap, EAP_TYPE_PWD, frag,
-				frag_bytes + EAP_PWD_HDR_LEN);
+		eap_method_respond(eap, frag, frag_bytes + EAP_PWD_HDR_LEN);
 =

 		if (!pwd->tx_frag_remaining) {
 			/* done sending fragments, free */
diff --git a/src/eap-sim.c b/src/eap-sim.c
index b29211f6..93063b7a 100644
--- a/src/eap-sim.c
+++ b/src/eap-sim.c
@@ -290,7 +290,7 @@ static void handle_start(struct eap_state *eap, const u=
int8_t *pkt,
 				EAP_SIM_PAD_LENGTH, (uint8_t *)sim->identity,
 				strlen(sim->identity));
 =

-	eap_send_response(eap, EAP_TYPE_SIM, response, resp_len);
+	eap_method_respond(eap, response, resp_len);
 =

 	return;
 =

@@ -391,7 +391,7 @@ static void gsm_callback(const uint8_t *sres, const uin=
t8_t *kc,
 	l_free(sim->chal_pkt);
 	sim->chal_pkt =3D NULL;
 =

-	eap_send_response(eap, EAP_TYPE_SIM, response, resp_len);
+	eap_method_respond(eap, response, resp_len);
 =

 	if (!sim->protected) {
 		/*
@@ -565,7 +565,7 @@ static void handle_notification(struct eap_state *eap, =
const uint8_t *pkt,
 			return;
 		}
 =

-		eap_send_response(eap, EAP_TYPE_SIM, response, pos - response);
+		eap_method_respond(eap, response, pos - response);
 =

 		sim->state =3D EAP_SIM_STATE_SUCCESS;
 		return;
diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 28febaf0..c3eb5ab3 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -332,7 +332,7 @@ static void eap_tls_send_fragment(struct eap_state *eap)
 =

 	memcpy(buf + header_len,
 		eap_tls->tx_pdu_buf->data + eap_tls->tx_frag_offset, len);
-	eap_send_response(eap, eap_get_method_type(eap), buf, header_len + len);
+	eap_method_respond(eap, buf, header_len + len);
 =

 	eap_tls->tx_frag_last_len =3D len;
 }
@@ -389,7 +389,7 @@ static void eap_tls_send_response(struct eap_state *eap,
 =

 		memcpy(buf + EAP_TLS_HEADER_LEN + extra, pdu, pdu_len);
 =

-		eap_send_response(eap, eap_get_method_type(eap), buf, msg_len);
+		eap_method_respond(eap, buf, msg_len);
 		l_free(buf);
 		return;
 	}
@@ -409,8 +409,7 @@ void eap_tls_common_send_empty_response(struct eap_stat=
e *eap)
 =

 	buf[EAP_TLS_HEADER_OCTET_FLAGS + position] =3D eap_tls->version_negotiate=
d;
 =

-	eap_send_response(eap, eap_get_method_type(eap), buf,
-				EAP_TLS_HEADER_LEN + position);
+	eap_method_respond(eap, buf, EAP_TLS_HEADER_LEN + position);
 }
 =

 static int eap_tls_init_request_assembly(struct eap_state *eap,
diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 3e0433e3..0fec29c6 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -339,7 +339,7 @@ static void eap_wsc_send_fragment(struct eap_state *eap)
 	}
 =

 	memcpy(buf + header_len, wsc->sent_pdu + wsc->tx_frag_offset, len);
-	eap_send_response(eap, EAP_TYPE_EXPANDED, buf, header_len + len);
+	eap_method_respond(eap, buf, header_len + len);
 =

 	wsc->tx_last_frag_len =3D len;
 }
@@ -359,7 +359,7 @@ static void eap_wsc_send_response(struct eap_state *eap,
 		buf[13] =3D 0;
 		memcpy(buf + EAP_WSC_HEADER_LEN, pdu, pdu_len);
 =

-		eap_send_response(eap, EAP_TYPE_EXPANDED, buf, msg_len);
+		eap_method_respond(eap, buf, msg_len);
 		l_free(buf);
 		return;
 	}
@@ -419,8 +419,7 @@ static void eap_wsc_send_nack(struct eap_state *eap,
 	buf[13] =3D 0;
 	memcpy(buf + EAP_WSC_HEADER_LEN, pdu, pdu_len);
 =

-	eap_send_response(eap, EAP_TYPE_EXPANDED, buf,
-						pdu_len + EAP_WSC_HEADER_LEN);
+	eap_method_respond(eap, buf, pdu_len + EAP_WSC_HEADER_LEN);
 	l_free(pdu);
 }
 =

@@ -446,8 +445,7 @@ static void eap_wsc_send_done(struct eap_state *eap)
 	buf[13] =3D 0;
 	memcpy(buf + EAP_WSC_HEADER_LEN, pdu, pdu_len);
 =

-	eap_send_response(eap, EAP_TYPE_EXPANDED, buf,
-						pdu_len + EAP_WSC_HEADER_LEN);
+	eap_method_respond(eap, buf, pdu_len + EAP_WSC_HEADER_LEN);
 	l_free(pdu);
 }
 =

@@ -458,7 +456,7 @@ static void eap_wsc_send_frag_ack(struct eap_state *eap)
 	buf[12] =3D WSC_OP_FRAG_ACK;
 	buf[13] =3D 0;
 =

-	eap_send_response(eap, EAP_TYPE_EXPANDED, buf, EAP_WSC_HEADER_LEN);
+	eap_method_respond(eap, buf, EAP_WSC_HEADER_LEN);
 }
 =

 static void eap_wsc_handle_m8(struct eap_state *eap,
@@ -1123,7 +1121,7 @@ static void eap_wsc_handle_retransmit(struct eap_stat=
e *eap,
 		buf[13] =3D 0;
 		memcpy(buf + EAP_WSC_HEADER_LEN, wsc->sent_pdu, wsc->sent_len);
 =

-		eap_send_response(eap, EAP_TYPE_EXPANDED, buf, msg_len);
+		eap_method_respond(eap, buf, msg_len);
 	}
 }
 =

diff --git a/src/eap.c b/src/eap.c
index 816b5f9a..57f8d688 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -149,29 +149,19 @@ const char *eap_get_identity(struct eap_state *eap)
 	return eap->identity;
 }
 =

-/**
- * eap_send_response:
- * @eap: EAP state
- * @type: Type of response being sent
- * @buf: Buffer to send
- * @len: Size of the buffer
- *
- * Sends out a response to a received request.  This method first fills the
- * EAP header into the buffer based on the EAP type response being sent.
- *
- * If the response type is EAP_TYPE_EXPANDED, then the Vendor-Id and
- * Vendor-Type fields are filled in based on contents of the eap_method
- * associated with @eap.
- *
- * The buffer passed in MUST be at least 12 bytes long if @type is
- * EAP_TYPE_EXPANDED and at least 5 bytes for other cases.
- **/
-void eap_send_response(struct eap_state *eap, enum eap_type type,
-						uint8_t *buf, size_t len)
+static void eap_send_packet(struct eap_state *eap, enum eap_code code,
+				uint8_t id, uint8_t *buf, size_t len)
 {
-	buf[0] =3D EAP_CODE_RESPONSE;
-	buf[1] =3D eap->last_id;
+	buf[0] =3D code;
+	buf[1] =3D id;
 	l_put_be16(len, &buf[2]);
+
+	eap->tx_packet(buf, len, eap->user_data);
+}
+
+static void eap_send_response(struct eap_state *eap, enum eap_type type,
+				uint8_t *buf, size_t len)
+{
 	buf[4] =3D type;
 =

 	if (type =3D=3D EAP_TYPE_EXPANDED) {
@@ -179,7 +169,28 @@ void eap_send_response(struct eap_state *eap, enum eap=
_type type,
 		l_put_be32(eap->method->vendor_type, buf + 8);
 	}
 =

-	eap->tx_packet(buf, len, eap->user_data);
+	eap_send_packet(eap, EAP_CODE_RESPONSE, eap->last_id, buf, len);
+}
+
+/**
+ * eap_send_packet:
+ * @eap: EAP state
+ * @buf: Buffer to send
+ * @len: Size of the buffer
+ *
+ * Sends out a response to a received request.  This method first fills
+ * the EAP header in the buffer based on the method's EAP type being
+ * sent.
+ *
+ * If the method uses an expanded type , then the Vendor-Id and
+ * Vendor-Type fields are filled in automatically.
+ *
+ * The buffer passed in MUST be at least 12 bytes long if method uses
+ * an expanded type and at least 5 bytes for other cases.
+ **/
+void eap_method_respond(struct eap_state *eap, uint8_t *buf, size_t len)
+{
+	eap_send_response(eap, eap->method->request_type, buf, len);
 }
 =

 static void eap_complete_timeout(struct l_timeout *timeout, void *user_dat=
a)
diff --git a/src/simutil.c b/src/simutil.c
index eda31a86..8947ad66 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -353,7 +353,7 @@ void eap_sim_client_error(struct eap_state *eap, enum e=
ap_type type,
 	buf[9] =3D 1;
 	l_put_be16(code, buf + 10);
 =

-	eap_send_response(eap, type, buf, 12);
+	eap_method_respond(eap, buf, 12);
 }
 =

 size_t eap_sim_add_attribute(uint8_t *buf, enum eap_sim_at attr,
-- =

2.25.1

--===============2337683825618723523==--

