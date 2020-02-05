Content-Type: multipart/mixed; boundary="===============7589710446439762275=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] peap: Ensure TLV uniqueness
Date: Wed, 05 Feb 2020 15:19:05 -0800
Message-ID: <20200205231905.30996-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7589710446439762275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Processing the duplicated TLVs while connecting to a malicious AP may lead
to overflow of the response buffer. This patch ensures that the
duplicated TLVs are not parsed.
---
 src/eap-peap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 8c3ba2f3..c17e5b92 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -353,6 +353,8 @@ static int eap_extensions_process_tlvs(struct eap_state=
 *eap,
 	int response_len =3D 0;
 	uint16_t tlv_type;
 	uint16_t tlv_value_len;
+	bool seen_result_tlv =3D false;
+	bool seen_cryptobinding_tlv =3D false;
 =

 	while (data_len >=3D EAP_EXTENSIONS_TLV_HEADER_LEN) {
 		int response_tlv_len =3D 0;
@@ -370,12 +372,22 @@ static int eap_extensions_process_tlvs(struct eap_sta=
te *eap,
 =

 		switch (tlv_type) {
 		case EAP_EXTENSIONS_TLV_TYPE_RESULT:
+			if (seen_result_tlv)
+				return -EBADMSG;
+
+			seen_result_tlv =3D true;
+
 			response_tlv_len =3D eap_extensions_handle_result_tlv(eap,
 						data, tlv_value_len, response,
 						result);
 =

 			break;
 		case EAP_EXTENSIONS_TLV_TYPE_CRYPTOBINDING:
+			if (seen_cryptobinding_tlv)
+				return -EBADMSG;
+
+			seen_cryptobinding_tlv =3D true;
+
 			response_tlv_len =3D
 				eap_extensions_handle_cryptobinding_tlv(eap,
 						data, tlv_value_len, response);
-- =

2.13.6

--===============7589710446439762275==--

