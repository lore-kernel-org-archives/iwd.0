Content-Type: multipart/mixed; boundary="===============4551595133544721616=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 6/6] peap: Add support for Crypto-Binding in PEAPv0
Date: Thu, 05 Dec 2019 13:13:54 -0800
Message-ID: <20191205211354.19075-6-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191205211354.19075-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4551595133544721616==
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
 src/eap-peap.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 177 insertions(+), 2 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 8cd73c82..b2897186 100644
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
@@ -113,13 +114,178 @@ static void eap_peap_phase2_complete(enum eap_result=
 result, void *user_data)
 #define EAP_EXTENSIONS_TLV_HEADER_LEN 4
 #define EAP_EXTENSIONS_TLV_M_BIT_MASK 0x8000
 =

+#define TLV_CRYPTOBINDING_VAL_LEN 56
+#define TLV_CRYPTOBINDING_NONCE_LEN 32
+#define TLV_CRYPTOBINDING_COMPOUND_MAC_LEN 20
+
 enum eap_extensions_tlv_type {
 	/* Reserved =3D 0x0000, */
 	/* Reserved =3D 0x0001, */
 	/* Reserved =3D 0x0002, */
-	EAP_EXTENSIONS_TLV_TYPE_RESULT =3D 0x8003,
+	EAP_EXTENSIONS_TLV_TYPE_RESULT        =3D 0x8003,
+	EAP_EXTENSIONS_TLV_TYPE_CRYPTOBINDING =3D 0x000C,
+};
+
+enum TLV_CRYPTOBINDING_TYPE {
+	TLV_CRYPTOBINDING_TYPE_REQUEST =3D  0,
+	TLV_CRYPTOBINDING_TYPE_RESPONSE =3D 1,
 };
 =

+static bool cryptobinding_tlv_generate_csk(struct eap_state *eap, uint8_t =
*imck)
+{
+	struct peap_state *peap_state =3D eap_tls_common_get_variant_data(eap);
+	char *label;
+
+	label =3D "Session Key Generating Function";
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
+	static uint8_t isk[32];
+	char *label;
+
+	label =3D "Inner Methods Compound Keys";
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
+	const uint8_t *nonce;
+	const uint8_t *server_compound_mac;
+	uint8_t compound_mac[TLV_CRYPTOBINDING_COMPOUND_MAC_LEN];
+	const uint8_t *cryptobinding_tlv_value;
+	uint8_t buf[61];
+	uint8_t imck[60];
+
+	if (tlv_value_len !=3D TLV_CRYPTOBINDING_VAL_LEN)
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
+	data +=3D TLV_CRYPTOBINDING_NONCE_LEN;
+
+	server_compound_mac =3D data;
+
+	l_put_be16(EAP_EXTENSIONS_TLV_TYPE_CRYPTOBINDING, &buf[0]);
+	l_put_be16(tlv_value_len, &buf[2]);
+	memcpy(&buf[4], cryptobinding_tlv_value,
+					4 + TLV_CRYPTOBINDING_NONCE_LEN);
+	memset(&buf[EAP_EXTENSIONS_TLV_HEADER_LEN + 4 +
+						TLV_CRYPTOBINDING_NONCE_LEN],
+					0, TLV_CRYPTOBINDING_COMPOUND_MAC_LEN);
+	buf[60] =3D EAP_TYPE_PEAP;
+
+	if (!cryptobinding_tlv_generate_imck(eap, imck)) {
+		l_error("PEAP: Failed to generate IMCK to validate "
+						"server compound MAC.");
+
+		return -ENOENT;
+	}
+
+	if (!hmac_sha1(imck + 40, 20, buf, sizeof(buf), compound_mac,
+					TLV_CRYPTOBINDING_COMPOUND_MAC_LEN)) {
+		l_error("PEAP: Failed to generate compound MAC to validate "
+						"server compound MAC.");
+
+		return -ENOENT;
+	}
+
+	if (memcmp(server_compound_mac, compound_mac,
+					TLV_CRYPTOBINDING_COMPOUND_MAC_LEN)) {
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
+	l_put_be16(TLV_CRYPTOBINDING_VAL_LEN, response);
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
+	memcpy(response, nonce, TLV_CRYPTOBINDING_NONCE_LEN);
+	response +=3D TLV_CRYPTOBINDING_NONCE_LEN;
+
+	memcpy(buf, data, EAP_EXTENSIONS_TLV_HEADER_LEN + 4 +
+						TLV_CRYPTOBINDING_NONCE_LEN);
+
+	if (!hmac_sha1(imck + 40, 20, buf, sizeof(buf), compound_mac,
+					TLV_CRYPTOBINDING_COMPOUND_MAC_LEN)) {
+		l_error("PEAP: Failed to generate client compound MAC.");
+
+		return -ENOENT;
+	}
+
+	memcpy(response, compound_mac, 20);
+
+	if (!cryptobinding_tlv_generate_csk(eap, imck)) {
+		l_error("PEAP: Failed to generate Compound Session Key.");
+
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 #define TLV_RESULT_VAL_LEN 2
 =

 enum eap_extensions_result {
@@ -199,6 +365,13 @@ static int eap_extensions_process_tlvs(struct eap_stat=
e *eap,
 			response +=3D EAP_EXTENSIONS_TLV_HEADER_LEN +
 							TLV_RESULT_VAL_LEN;
 			break;
+		case EAP_EXTENSIONS_TLV_TYPE_CRYPTOBINDING:
+			r =3D eap_extensions_handle_cryptobinding_tlv(eap,
+						data, tlv_value_len, response);
+
+			response +=3D EAP_EXTENSIONS_TLV_HEADER_LEN +
+						TLV_CRYPTOBINDING_VAL_LEN;
+			break;
 		default:
 			if (tlv_type & EAP_EXTENSIONS_TLV_M_BIT_MASK)
 				return -ENOENT;
@@ -224,7 +397,9 @@ static void eap_extensions_handle_request(struct eap_st=
ate *eap,
 	struct peap_state *peap_state;
 	uint8_t response[EAP_EXTENSIONS_HEADER_LEN +
 				EAP_EXTENSIONS_TLV_HEADER_LEN +
-						TLV_RESULT_VAL_LEN];
+						TLV_RESULT_VAL_LEN +
+				EAP_EXTENSIONS_TLV_HEADER_LEN +
+						TLV_CRYPTOBINDING_VAL_LEN];
 	int r =3D eap_extensions_process_tlvs(eap, pkt, len,
 					&response[EAP_EXTENSIONS_HEADER_LEN]);
 =

-- =

2.13.6

--===============4551595133544721616==--

