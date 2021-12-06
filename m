Content-Type: multipart/mixed; boundary="===============6516691806406659981=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] dpp-util: add DPP attribute iteration APIs
Date: Mon, 06 Dec 2021 13:03:55 -0800
Message-ID: <20211206210356.1204046-3-prestwoj@gmail.com>
In-Reply-To: 20211206210356.1204046-1-prestwoj@gmail.com

--===============6516691806406659981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp-util.c | 34 ++++++++++++++++++++++++++++++++++
 src/dpp-util.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index ca641311..b7122de6 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -94,6 +94,40 @@ char *dpp_generate_uri(const uint8_t *asn1, size_t asn1_=
len, uint8_t version,
 	return l_string_unwrap(uri);
 }
 =

+void dpp_attr_iter_init(struct dpp_attr_iter *iter, const uint8_t *pdu,
+			size_t len)
+{
+	iter->pos =3D pdu;
+	iter->end =3D pdu + len;
+}
+
+bool dpp_attr_iter_next(struct dpp_attr_iter *iter,
+			enum dpp_attribute_type *type_out, size_t *len_out,
+			const uint8_t **data_out)
+{
+	enum dpp_attribute_type type;
+	size_t len;
+
+	if (iter->pos + 4 > iter->end)
+		return false;
+
+	type =3D l_get_le16(iter->pos);
+	len =3D l_get_le16(iter->pos + 2);
+
+	iter->pos +=3D 4;
+
+	if (iter->pos + len > iter->end)
+		return false;
+
+	*type_out =3D type;
+	*len_out =3D len;
+	*data_out =3D iter->pos;
+
+	iter->pos +=3D len;
+
+	return true;
+}
+
 /*
  * EasyConnect 2.0 Table 3. Key and Nonce Length Dependency on Prime Length
  */
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 971c0ce4..6d0dcccb 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -22,6 +22,55 @@
 struct l_ecc_point;
 struct l_ecc_scalar;
 =

+enum dpp_attribute_type {
+	/* 0000 - 0FFF reserved */
+	DPP_ATTR_STATUS				=3D 0x1000,
+	DPP_ATTR_INITIATOR_BOOT_KEY_HASH	=3D 0x1001,
+	DPP_ATTR_RESPONDER_BOOT_KEY_HASH	=3D 0x1002,
+	DPP_ATTR_INITIATOR_PROTOCOL_KEY		=3D 0x1003,
+	DPP_ATTR_WRAPPED_DATA			=3D 0x1004,
+	DPP_ATTR_INITIATOR_NONCE		=3D 0x1005,
+	DPP_ATTR_INITIATOR_CAPABILITIES		=3D 0x1006,
+	DPP_ATTR_RESPONDER_NONCE		=3D 0x1007,
+	DPP_ATTR_RESPONDER_CAPABILITIES		=3D 0x1008,
+	DPP_ATTR_RESPONDER_PROTOCOL_KEY		=3D 0x1009,
+	DPP_ATTR_INITIATOR_AUTH_TAG		=3D 0x100a,
+	DPP_ATTR_RESPONDER_AUTH_TAG		=3D 0x100b,
+	DPP_ATTR_CONFIGURATION_OBJECT		=3D 0x100c,
+	DPP_ATTR_CONNECTOR			=3D 0x100d,
+	DPP_ATTR_CONFIGURATION_REQUEST		=3D 0x100e,
+	DPP_ATTR_BOOTSTRAPPING_KEY		=3D 0x100f,
+	/* 1010 - 1011 reserved */
+	DPP_ATTR_FINITE_CYCLIC_GROUP		=3D 0x1012,
+	DPP_ATTR_ENCRYPTED_KEY			=3D 0x1013,
+	DPP_ATTR_ENROLLEE_NONCE			=3D 0x1014,
+	DPP_ATTR_CODE_IDENTIFIER		=3D 0x1015,
+	DPP_ATTR_TRANSACTION_ID			=3D 0x1016,
+	DPP_ATTR_BOOTSTRAPPING_INFO		=3D 0x1017,
+	DPP_ATTR_CHANNEL			=3D 0x1018,
+	DPP_ATTR_PROTOCOL_VERSION		=3D 0x1019,
+	DPP_ATTR_ENVELOPED_DATA			=3D 0x101a,
+	DPP_ATTR_SEND_CONN_STATUS		=3D 0x101b,
+	DPP_ATTR_CONN_STATUS			=3D 0x101c,
+	DPP_ATTR_RECONFIGURATION_FLAGS		=3D 0x101d,
+	DPP_ATTR_C_SIGN_KEY_HASH		=3D 0x101e,
+	DPP_ATTR_CSR_ATTRIBUTES_REQUEST		=3D 0x101f,
+	DPP_ATTR_ANONCE				=3D 0x1020,
+	DPP_ATTR_EID				=3D 0x1021,
+	DPP_ATTR_CONFIGURATOR_NONCE		=3D 0x1022,
+};
+
+struct dpp_attr_iter {
+	const uint8_t *pos;
+	const uint8_t *end;
+};
+
+void dpp_attr_iter_init(struct dpp_attr_iter *iter, const uint8_t *pdu,
+			size_t len);
+bool dpp_attr_iter_next(struct dpp_attr_iter *iter,
+			enum dpp_attribute_type *type, size_t *len,
+			const uint8_t **data);
+
 char *dpp_generate_uri(const uint8_t *asn1, size_t asn1_len, uint8_t versi=
on,
 			const uint8_t *mac, const uint32_t *freqs,
 			size_t freqs_len, const char *info, const char *host);
-- =

2.31.1

--===============6516691806406659981==--

