Content-Type: multipart/mixed; boundary="===============7917460414718733706=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 01/11] dpp-util: add dpp_point_to_asn1
Date: Wed, 15 Dec 2021 09:58:04 -0800
Message-ID: <20211215175814.2467124-1-prestwoj@gmail.com>

--===============7917460414718733706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Converts an l_ecc_point to the DPP ASN.1 structure.
---
 src/dpp-util.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  2 ++
 2 files changed, 91 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 0b355311..e5f76bfd 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -361,3 +361,92 @@ bool dpp_derive_ke(const uint8_t *i_nonce, const uint8=
_t *r_nonce,
 	/* ke =3D HKDF-Expand(bk, "DPP Key", length) */
 	return hkdf_expand(sha, bk, key_len, "DPP Key", ke, key_len);
 }
+
+#define ASN1_ID(class, pc, tag)	(((class) << 6) | ((pc) << 5) | (tag))
+
+#define ASN1_ID_SEQUENCE	ASN1_ID(0, 1, 0x10)
+#define ASN1_ID_BIT_STRING	ASN1_ID(0, 0, 0x03)
+#define ASN1_ID_OID		ASN1_ID(0, 0, 0x06)
+
+static uint8_t ec_oid[] =3D { 0x2a, 0x86, 0x48, 0xce, 0x3d, 0x02, 0x01 };
+static uint8_t ec_p256_oid[] =3D { 0x2a, 0x86, 0x48, 0xce,
+				0x3d, 0x03, 0x01, 0x07 };
+static uint8_t ec_p384_oid[] =3D { 0x2B, 0x81, 0x04, 0x00, 0x22 };
+static uint8_t ec_p512_oid[] =3D { 0x2B, 0x81, 0x04, 0x00, 0x23 };
+
+uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p, size_t *len_out)
+{
+	uint8_t *asn1;
+	uint8_t *ptr;
+	uint8_t *type_oid;
+	size_t type_oid_len;
+	const struct l_ecc_curve *curve =3D l_ecc_point_get_curve(p);
+	ssize_t key_size =3D l_ecc_curve_get_scalar_bytes(curve);
+	uint64_t x[L_ECC_MAX_DIGITS];
+	ssize_t ret;
+	size_t len;
+
+	switch (key_size) {
+	case 32:
+		type_oid =3D ec_p256_oid;
+		type_oid_len =3D sizeof(ec_p256_oid);
+		break;
+	case 48:
+		type_oid =3D ec_p384_oid;
+		type_oid_len =3D sizeof(ec_p384_oid);
+		break;
+	case 64:
+		type_oid =3D ec_p512_oid;
+		type_oid_len =3D sizeof(ec_p512_oid);
+		break;
+	default:
+		return NULL;
+	}
+
+	ret =3D l_ecc_point_get_x(p, x, sizeof(x));
+	if (ret < 0 || ret !=3D key_size)
+		return NULL;
+
+	len =3D 2 + sizeof(ec_oid) + 2 + type_oid_len + 2 + key_size + 4;
+
+	if (L_WARN_ON(len > 128))
+		return NULL;
+
+	asn1 =3D l_malloc(len + 2);
+	ptr =3D asn1;
+
+	*ptr++ =3D ASN1_ID_SEQUENCE;
+	/* Length of both OIDs and key, plus tag/len bytes */
+	*ptr++ =3D len;
+
+	*ptr++ =3D ASN1_ID_SEQUENCE;
+
+	len =3D sizeof(ec_oid) + type_oid_len + 4;
+
+	if (L_WARN_ON(len > 128))
+		return NULL;
+
+	*ptr++ =3D len;
+
+	*ptr++ =3D ASN1_ID_OID;
+	*ptr++ =3D sizeof(ec_oid);
+	memcpy(ptr, ec_oid, sizeof(ec_oid));
+	ptr +=3D sizeof(ec_oid);
+
+	*ptr++ =3D ASN1_ID_OID;
+	*ptr++ =3D type_oid_len;
+	memcpy(ptr, type_oid, type_oid_len);
+	ptr +=3D type_oid_len;
+
+	*ptr++ =3D ASN1_ID_BIT_STRING;
+	*ptr++ =3D key_size + 2;
+	*ptr++ =3D 0x00;
+	*ptr++ =3D 0x03;
+	memcpy(ptr, x, key_size);
+	ptr +=3D key_size;
+
+	if (len_out)
+		*len_out =3D ptr - asn1;
+
+	return asn1;
+}
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 6d0dcccb..0c22e9b7 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -97,3 +97,5 @@ struct l_ecc_scalar *dpp_derive_k2(const struct l_ecc_poi=
nt *i_proto_public,
 bool dpp_derive_ke(const uint8_t *i_nonce, const uint8_t *r_nonce,
 				struct l_ecc_scalar *m, struct l_ecc_scalar *n,
 				void *ke);
+
+uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p, size_t *len_out);
-- =

2.31.1

--===============7917460414718733706==--

