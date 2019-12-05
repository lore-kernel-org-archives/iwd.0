Content-Type: multipart/mixed; boundary="===============8187435618938848066=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/6] peap: Rename AVPs to TLVs
Date: Thu, 05 Dec 2019 13:13:51 -0800
Message-ID: <20191205211354.19075-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191205211354.19075-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8187435618938848066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Most of the literature seems to refer to AVPs as TLVs. Rename the
variables to follow the common nomenclature.
---
 src/eap-peap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index eb0b0c5f..ed18c667 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -110,13 +110,13 @@ static void eap_peap_phase2_complete(enum eap_result =
result, void *user_data)
  * PEAPv0: draft-kamath-pppext-peapv0-00, Section 2
  */
 #define EAP_EXTENSIONS_HEADER_LEN 5
-#define EAP_EXTENSIONS_AVP_HEADER_LEN 4
+#define EAP_EXTENSIONS_TLV_HEADER_LEN 4
 =

-enum eap_extensions_avp_type {
+enum eap_extensions_tlv_type {
 	/* Reserved =3D 0x0000, */
 	/* Reserved =3D 0x0001, */
 	/* Reserved =3D 0x0002, */
-	EAP_EXTENSIONS_AVP_TYPE_RESULT =3D 0x8003,
+	EAP_EXTENSIONS_TLV_TYPE_RESULT =3D 0x8003,
 };
 =

 enum eap_extensions_result {
@@ -124,7 +124,7 @@ enum eap_extensions_result {
 	EAP_EXTENSIONS_RESULT_FAILURE  =3D 2,
 };
 =

-static int eap_extensions_handle_result_avp(struct eap_state *eap,
+static int eap_extensions_handle_result_tlv(struct eap_state *eap,
 						const uint8_t *data,
 						size_t data_len,
 						uint8_t *response)
@@ -134,12 +134,12 @@ static int eap_extensions_handle_result_avp(struct ea=
p_state *eap,
 	uint16_t len;
 	uint16_t result;
 =

-	if (data_len < EAP_EXTENSIONS_AVP_HEADER_LEN + 2)
+	if (data_len < EAP_EXTENSIONS_TLV_HEADER_LEN + 2)
 		return -ENOENT;
 =

 	type =3D l_get_be16(data);
 =

-	if (type !=3D EAP_EXTENSIONS_AVP_TYPE_RESULT)
+	if (type !=3D EAP_EXTENSIONS_TLV_TYPE_RESULT)
 		return -ENOENT;
 =

 	data +=3D 2;
@@ -169,11 +169,11 @@ static int eap_extensions_handle_result_avp(struct ea=
p_state *eap,
 		return -ENOENT;
 	}
 =

-	l_put_be16(EAP_EXTENSIONS_AVP_TYPE_RESULT,
+	l_put_be16(EAP_EXTENSIONS_TLV_TYPE_RESULT,
 					&response[EAP_EXTENSIONS_HEADER_LEN]);
 	l_put_be16(2, &response[EAP_EXTENSIONS_HEADER_LEN + 2]);
 	l_put_be16(result, &response[EAP_EXTENSIONS_HEADER_LEN +
-						EAP_EXTENSIONS_AVP_HEADER_LEN]);
+						EAP_EXTENSIONS_TLV_HEADER_LEN]);
 =

 	return result;
 }
@@ -185,8 +185,8 @@ static void eap_extensions_handle_request(struct eap_st=
ate *eap,
 {
 	struct peap_state *peap_state;
 	uint8_t response[EAP_EXTENSIONS_HEADER_LEN +
-					EAP_EXTENSIONS_AVP_HEADER_LEN + 2];
-	int r =3D eap_extensions_handle_result_avp(eap, pkt, len, response);
+					EAP_EXTENSIONS_TLV_HEADER_LEN + 2];
+	int r =3D eap_extensions_handle_result_tlv(eap, pkt, len, response);
 =

 	if (r < 0)
 		return;
-- =

2.13.6

--===============8187435618938848066==--

