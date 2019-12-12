Content-Type: multipart/mixed; boundary="===============7502524282315242156=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 2/2] peap: Add support for Crypto-Binding in PEAPv0
Date: Thu, 12 Dec 2019 12:10:16 -0800
Message-ID: <20191212201016.18072-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191212201016.18072-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7502524282315242156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Crypto Binding TLV is used to ensure that the EAP peer and the
EAP server participated in both the inner and the outer EAP
authentications of a PEAP authentication by cryptographically associating
the phase 1 and phase 2 authentications.

The usage of Crypto-Binding in PEAPv0 is optional and is triggered by
the reception of the Crypto-Binding TLV from the server.
---
 src/eap-peap.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 169 insertions(+), 1 deletion(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 8059e60b..dd2438b8 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <ell/ell.h>
 =

+#include "src/crypto.h"
 #include "src/missing.h"
 #include "src/eap.h"
 #include "src/eap-private.h"
@@ -117,9 +118,170 @@ enum eap_extensions_tlv_type {
 	/* Reserved =3D 0x0000, */
 	/* Reserved =3D 0x0001, */
 	/* Reserved =3D 0x0002, */
-	EAP_EXTENSIONS_TLV_TYPE_RESULT =3D 0x8003,
+	EAP_EXTENSIONS_TLV_TYPE_RESULT        =3D 0x8003,
+	EAP_EXTENSIONS_TLV_TYPE_CRYPTOBINDING =3D 0x000C,
 };
 =

+enum TLV_CRYPTOBINDING_TYPE {
+	TLV_CRYPTOBINDING_TYPE_REQUEST =3D  0,
+	TLV_CRYPTOBINDING_TYPE_RESPONSE =3D 1,
+};
+
+static bool cryptobinding_tlv_generate_csk(struct eap_state *eap, uint8_t =
*imck)
+{
+	struct peap_state *peap_state =3D eap_tls_common_get_variant_data(eap);
+	static const char *label =3D "Session Key Generating Function";
+
+	if (!prf_plus_sha1(imck, 40, label, strlen(label), "\00", 1,
+				peap_state->key, sizeof(peap_state->key)))
+		return false;
+
+	return true;
+}
+
+static bool cryptobinding_tlv_generate_imck(struct eap_state *eap,
+							uint8_t *imck_out)
+{
+	struct peap_state *peap_state =3D eap_tls_common_get_variant_data(eap);
+	static const char *label =3D "Inner Methods Compound Keys";
+	uint8_t isk[32];
+
+	memset(isk, 0, sizeof(isk));
+
+	if (!prf_plus_sha1(peap_state->key, 40, label, strlen(label),
+					isk, sizeof(isk), imck_out, 60))
+		return false;
+
+	return true;
+}
+
+static int eap_extensions_handle_cryptobinding_tlv(struct eap_state *eap,
+							const uint8_t *data,
+							uint16_t tlv_value_len,
+							uint8_t *response)
+{
+	static const uint8_t cryptobinding_val_len =3D 56;
+	static const uint8_t cryptobinding_compound_mac_len =3D 20;
+	static const uint8_t cryptobinding_nonce_len =3D 32;
+	const uint8_t *nonce;
+	const uint8_t *server_compound_mac;
+	uint8_t client_compound_mac[cryptobinding_compound_mac_len];
+	const uint8_t *cryptobinding_tlv_value;
+	uint8_t buf[61];
+	uint8_t imck[60];
+
+	if (tlv_value_len !=3D cryptobinding_val_len)
+		return -ENOENT;
+
+	cryptobinding_tlv_value =3D data;
+
+	/* Reserved byte: must be ignored on receipt. */
+	data +=3D 1;
+
+	/* Version byte: must be set to 0. */
+	if (*data)
+		return -ENOENT;
+
+	data +=3D 1;
+
+	/* RecvVersion byte: must be set to 0. */
+	if (*data)
+		return -ENOENT;
+
+	data +=3D 1;
+
+	/* SubType byte: cryptobinding TLV request. */
+	if (*data !=3D TLV_CRYPTOBINDING_TYPE_REQUEST)
+		return -ENOENT;
+
+	data +=3D 1;
+
+	nonce =3D data;
+	data +=3D cryptobinding_nonce_len;
+
+	server_compound_mac =3D data;
+
+	l_put_be16(EAP_EXTENSIONS_TLV_TYPE_CRYPTOBINDING, &buf[0]);
+	l_put_be16(tlv_value_len, &buf[2]);
+	memcpy(&buf[4], cryptobinding_tlv_value,
+					4 + cryptobinding_nonce_len);
+	memset(&buf[EAP_EXTENSIONS_TLV_HEADER_LEN + 4 +
+						cryptobinding_nonce_len],
+					0, cryptobinding_compound_mac_len);
+	buf[60] =3D EAP_TYPE_PEAP;
+
+	if (!cryptobinding_tlv_generate_imck(eap, imck)) {
+		l_error("PEAP: Failed to generate IMCK to validate "
+						"server compound MAC.");
+
+		return -ENOENT;
+	}
+
+	if (!hmac_sha1(imck + 40, 20, buf, sizeof(buf), client_compound_mac,
+					cryptobinding_compound_mac_len)) {
+		l_error("PEAP: Failed to generate compound MAC to validate "
+						"server compound MAC.");
+
+		return -ENOENT;
+	}
+
+	if (memcmp(server_compound_mac, client_compound_mac,
+					cryptobinding_compound_mac_len)) {
+		l_error("PEAP: Generated compound MAC and server compound MAC "
+							"don't match.");
+
+		return -ENOENT;
+	}
+
+	/* Build response Crypto-Binding TLV */
+	data =3D response;
+
+	l_put_be16(EAP_EXTENSIONS_TLV_TYPE_CRYPTOBINDING, response);
+	response +=3D 2;
+
+	l_put_be16(cryptobinding_val_len, response);
+	response +=3D 2;
+
+	/* Reserved - must be set to 0. */
+	l_put_u8(0, response);
+	response +=3D 1;
+
+	/* Version */
+	l_put_u8(EAP_TLS_VERSION_0, response);
+	response +=3D 1;
+
+	/* Received Version */
+	l_put_u8(EAP_TLS_VERSION_0, response);
+	response +=3D 1;
+
+	/* Sub-Type */
+	l_put_u8(TLV_CRYPTOBINDING_TYPE_RESPONSE, response);
+	response +=3D 1;
+
+	memcpy(response, nonce, cryptobinding_nonce_len);
+	response +=3D cryptobinding_nonce_len;
+
+	memcpy(buf, data, EAP_EXTENSIONS_TLV_HEADER_LEN + 4 +
+						cryptobinding_nonce_len);
+
+	if (!hmac_sha1(imck + 40, 20, buf, sizeof(buf), client_compound_mac,
+					cryptobinding_compound_mac_len)) {
+		l_error("PEAP: Failed to generate client compound MAC.");
+
+		return -ENOENT;
+	}
+
+	memcpy(response, client_compound_mac, cryptobinding_compound_mac_len);
+
+	if (!cryptobinding_tlv_generate_csk(eap, imck)) {
+		l_error("PEAP: Failed to generate Compound Session Key.");
+
+		return -ENOENT;
+	}
+
+	return EAP_EXTENSIONS_TLV_HEADER_LEN + cryptobinding_val_len;
+}
+
 enum eap_extensions_result {
 	EAP_EXTENSIONS_RESULT_SUCCCESS =3D 1,
 	EAP_EXTENSIONS_RESULT_FAILURE  =3D 2,
@@ -199,6 +361,12 @@ static int eap_extensions_process_tlvs(struct eap_stat=
e *eap,
 						result);
 =

 			break;
+		case EAP_EXTENSIONS_TLV_TYPE_CRYPTOBINDING:
+			response_tlv_len =3D
+				eap_extensions_handle_cryptobinding_tlv(eap,
+						data, tlv_value_len, response);
+
+			break;
 		default:
 			if (tlv_type & EAP_EXTENSIONS_TLV_M_BIT_MASK)
 				return -ENOENT;
-- =

2.13.6

--===============7502524282315242156==--

