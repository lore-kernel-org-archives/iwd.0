Content-Type: multipart/mixed; boundary="===============0109322136174764020=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 1/2] peap: Extend EAP Extensions to handle multiple TLVs
Date: Thu, 12 Dec 2019 12:10:15 -0800
Message-ID: <20191212201016.18072-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0109322136174764020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The handler for EAP Extensions has been modified to support multiple
TLV types instead of the single Result TLV. This will allow to handle
the other TLVs such as Crypto-Binding TLV.
---
 src/eap-peap.c | 125 ++++++++++++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 88 insertions(+), 37 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index ed18c667..8059e60b 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -111,6 +111,7 @@ static void eap_peap_phase2_complete(enum eap_result re=
sult, void *user_data)
  */
 #define EAP_EXTENSIONS_HEADER_LEN 5
 #define EAP_EXTENSIONS_TLV_HEADER_LEN 4
+#define EAP_EXTENSIONS_TLV_M_BIT_MASK 0x8000
 =

 enum eap_extensions_tlv_type {
 	/* Reserved =3D 0x0000, */
@@ -127,39 +128,24 @@ enum eap_extensions_result {
 static int eap_extensions_handle_result_tlv(struct eap_state *eap,
 						const uint8_t *data,
 						size_t data_len,
-						uint8_t *response)
+						uint8_t *response,
+						uint8_t *result)
 {
+	static const uint8_t result_tlv_len =3D 2;
 	struct peap_state *peap_state;
-	uint16_t type;
-	uint16_t len;
-	uint16_t result;
 =

-	if (data_len < EAP_EXTENSIONS_TLV_HEADER_LEN + 2)
-		return -ENOENT;
-
-	type =3D l_get_be16(data);
-
-	if (type !=3D EAP_EXTENSIONS_TLV_TYPE_RESULT)
-		return -ENOENT;
-
-	data +=3D 2;
-
-	len =3D l_get_be16(data);
-
-	if (len !=3D 2)
-		return -ENOENT;
-
-	data +=3D 2;
+	if (data_len !=3D result_tlv_len)
+		return -EBADMSG;
 =

-	result =3D l_get_be16(data);
+	*result =3D l_get_be16(data);
 =

-	l_debug("result: %d", result);
+	l_debug("result: %d", *result);
 =

-	switch (result) {
+	switch (*result) {
 	case EAP_EXTENSIONS_RESULT_SUCCCESS:
 		peap_state =3D eap_tls_common_get_variant_data(eap);
 =

-		result =3D eap_method_is_success(peap_state->phase2) ?
+		*result =3D eap_method_is_success(peap_state->phase2) ?
 					EAP_EXTENSIONS_RESULT_SUCCCESS :
 					EAP_EXTENSIONS_RESULT_FAILURE;
 		/* fall through */
@@ -169,13 +155,68 @@ static int eap_extensions_handle_result_tlv(struct ea=
p_state *eap,
 		return -ENOENT;
 	}
 =

-	l_put_be16(EAP_EXTENSIONS_TLV_TYPE_RESULT,
-					&response[EAP_EXTENSIONS_HEADER_LEN]);
-	l_put_be16(2, &response[EAP_EXTENSIONS_HEADER_LEN + 2]);
-	l_put_be16(result, &response[EAP_EXTENSIONS_HEADER_LEN +
-						EAP_EXTENSIONS_TLV_HEADER_LEN]);
+	/* Build response Result TLV */
+
+	l_put_be16(EAP_EXTENSIONS_TLV_TYPE_RESULT, response);
+	response +=3D 2;
+
+	l_put_be16(result_tlv_len, response);
+	response +=3D 2;
+
+	l_put_be16(*result, response);
+
+	return EAP_EXTENSIONS_TLV_HEADER_LEN + result_tlv_len;
+}
+
+static int eap_extensions_process_tlvs(struct eap_state *eap,
+						const uint8_t *data,
+						size_t data_len,
+						uint8_t *response,
+						uint8_t *result)
+{
+	int response_len =3D 0;
+	uint16_t tlv_type;
+	uint16_t tlv_value_len;
+
+	while (data_len >=3D EAP_EXTENSIONS_TLV_HEADER_LEN) {
+		int response_tlv_len =3D 0;
+
+		tlv_type =3D l_get_be16(data);
+		data +=3D 2;
+
+		tlv_value_len =3D l_get_be16(data);
+		data +=3D 2;
+
+		data_len -=3D EAP_EXTENSIONS_TLV_HEADER_LEN;
+
+		if (data_len < tlv_value_len)
+			return -EBADMSG;
+
+		switch (tlv_type) {
+		case EAP_EXTENSIONS_TLV_TYPE_RESULT:
+			response_tlv_len =3D eap_extensions_handle_result_tlv(eap,
+						data, tlv_value_len, response,
+						result);
+
+			break;
+		default:
+			if (tlv_type & EAP_EXTENSIONS_TLV_M_BIT_MASK)
+				return -ENOENT;
+
+			break;
+		}
+
+		if (response_tlv_len < 0)
+			return response_tlv_len;
+
+		response +=3D response_tlv_len;
+		response_len +=3D response_tlv_len;
+
+		data +=3D tlv_value_len;
+		data_len -=3D tlv_value_len;
+	}
 =

-	return result;
+	return response_len;
 }
 =

 static void eap_extensions_handle_request(struct eap_state *eap,
@@ -184,24 +225,34 @@ static void eap_extensions_handle_request(struct eap_=
state *eap,
 							size_t len)
 {
 	struct peap_state *peap_state;
-	uint8_t response[EAP_EXTENSIONS_HEADER_LEN +
-					EAP_EXTENSIONS_TLV_HEADER_LEN + 2];
-	int r =3D eap_extensions_handle_result_tlv(eap, pkt, len, response);
+	uint8_t result =3D EAP_EXTENSIONS_RESULT_FAILURE;
+	/*
+	 * The buffer size is chosen to satisfy the needs of the two supported
+	 * TLVs.
+	 */
+	uint8_t response[256];
+	int response_len;
 =

-	if (r < 0)
+	response_len =3D eap_extensions_process_tlvs(eap, pkt, len,
+					&response[EAP_EXTENSIONS_HEADER_LEN],
+					&result);
+
+	if (response_len < 0)
 		return;
 =

+	response_len +=3D EAP_EXTENSIONS_HEADER_LEN;
+
 	response[0] =3D EAP_CODE_RESPONSE;
 	response[1] =3D id;
-	l_put_be16(sizeof(response), &response[2]);
+	l_put_be16(response_len, &response[2]);
 	response[4] =3D EAP_TYPE_EXTENSIONS;
 =

-	eap_peap_phase2_send_response(response, sizeof(response), eap);
+	eap_peap_phase2_send_response(response, response_len, eap);
 =

 	eap_discard_success_and_failure(eap, false);
 	eap_tls_common_set_completed(eap);
 =

-	if (r !=3D EAP_EXTENSIONS_RESULT_SUCCCESS) {
+	if (result !=3D EAP_EXTENSIONS_RESULT_SUCCCESS) {
 		eap_tls_common_set_phase2_failed(eap);
 =

 		eap_tls_common_tunnel_close(eap);
-- =

2.13.6

--===============0109322136174764020==--

