Content-Type: multipart/mixed; boundary="===============7869666660773798762=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 01/12] dpp-util: use ell/asn1-private.h for ASN1 generation
Date: Tue, 18 Jan 2022 13:25:01 -0800
Message-ID: <20220118212512.2017977-1-prestwoj@gmail.com>

--===============7869666660773798762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ASN1 parsing will soon be required which will need some utilities in
asn1-private.h. To avoid duplication include this private header and
replace the OID's with the defined structures as well as remove the
duplicated macros.
---
 src/dpp-util.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 029fbf6f..4823b2f0 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -36,6 +36,7 @@
 #include "src/crypto.h"
 #include "src/json.h"
 #include "ell/useful.h"
+#include "ell/asn1-private.h"
 #include "src/ie.h"
 =

 static void append_freqs(struct l_string *uri,
@@ -694,32 +695,34 @@ bool dpp_derive_ke(const uint8_t *i_nonce, const uint=
8_t *r_nonce,
 	return hkdf_expand(sha, bk, key_len, "DPP Key", ke, key_len);
 }
 =

-#define ASN1_ID(class, pc, tag)	(((class) << 6) | ((pc) << 5) | (tag))
-
-#define ASN1_ID_SEQUENCE	ASN1_ID(0, 1, 0x10)
-#define ASN1_ID_BIT_STRING	ASN1_ID(0, 0, 0x03)
-#define ASN1_ID_OID		ASN1_ID(0, 0, 0x06)
-
 /*
  * Values derived from OID definitions in https://www.secg.org/sec2-v2.pdf
  * Appendix A.2.1
  *
  * 1.2.840.10045.2.1 (ecPublicKey)
  */
-static uint8_t ec_oid[] =3D { 0x2a, 0x86, 0x48, 0xce, 0x3d, 0x02, 0x01 };
+static struct asn1_oid ec_oid =3D {
+	.asn1_len =3D 7,
+	.asn1 =3D { 0x2a, 0x86, 0x48, 0xce, 0x3d, 0x02, 0x01 }
+};
 =

 /* 1.2.840.10045.3.1.7 (prime256v1) */
-static uint8_t ec_p256_oid[] =3D { 0x2a, 0x86, 0x48, 0xce,
-				0x3d, 0x03, 0x01, 0x07 };
+static struct asn1_oid ec_p256_oid =3D {
+	.asn1_len =3D 8,
+	.asn1 =3D { 0x2a, 0x86, 0x48, 0xce, 0x3d, 0x03, 0x01, 0x07 }
+};
+
 /* 1.3.132.0.34 (secp384r1) */
-static uint8_t ec_p384_oid[] =3D { 0x2B, 0x81, 0x04, 0x00, 0x22 };
+static struct asn1_oid ec_p384_oid =3D {
+	.asn1_len =3D 5,
+	.asn1 =3D { 0x2B, 0x81, 0x04, 0x00, 0x22 }
+};
 =

 uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p, size_t *len_out)
 {
 	uint8_t *asn1;
 	uint8_t *ptr;
-	uint8_t *type_oid;
-	size_t type_oid_len;
+	struct asn1_oid *key_type;
 	const struct l_ecc_curve *curve =3D l_ecc_point_get_curve(p);
 	ssize_t key_size =3D l_ecc_curve_get_scalar_bytes(curve);
 	uint64_t x[L_ECC_MAX_DIGITS];
@@ -729,12 +732,10 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *=
p, size_t *len_out)
 =

 	switch (key_size) {
 	case 32:
-		type_oid =3D ec_p256_oid;
-		type_oid_len =3D sizeof(ec_p256_oid);
+		key_type =3D &ec_p256_oid;
 		break;
 	case 48:
-		type_oid =3D ec_p384_oid;
-		type_oid_len =3D sizeof(ec_p384_oid);
+		key_type =3D &ec_p384_oid;
 		break;
 	default:
 		return NULL;
@@ -744,7 +745,7 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p,=
 size_t *len_out)
 	if (ret < 0 || ret !=3D key_size)
 		return NULL;
 =

-	len =3D 2 + sizeof(ec_oid) + 2 + type_oid_len + 2 + key_size + 4;
+	len =3D 2 + ec_oid.asn1_len + 2 + key_type->asn1_len + 2 + key_size + 4;
 =

 	/*
 	 * Set the type to whatever avoids doing p - y when reading in the
@@ -769,19 +770,19 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *=
p, size_t *len_out)
 =

 	*ptr++ =3D ASN1_ID_SEQUENCE;
 =

-	len =3D sizeof(ec_oid) + type_oid_len + 4;
+	len =3D ec_oid.asn1_len + key_type->asn1_len + 4;
 =

 	*ptr++ =3D len;
 =

 	*ptr++ =3D ASN1_ID_OID;
-	*ptr++ =3D sizeof(ec_oid);
-	memcpy(ptr, ec_oid, sizeof(ec_oid));
-	ptr +=3D sizeof(ec_oid);
+	*ptr++ =3D ec_oid.asn1_len;
+	memcpy(ptr, ec_oid.asn1, ec_oid.asn1_len);
+	ptr +=3D ec_oid.asn1_len;
 =

 	*ptr++ =3D ASN1_ID_OID;
-	*ptr++ =3D type_oid_len;
-	memcpy(ptr, type_oid, type_oid_len);
-	ptr +=3D type_oid_len;
+	*ptr++ =3D key_type->asn1_len;
+	memcpy(ptr, key_type->asn1, key_type->asn1_len);
+	ptr +=3D key_type->asn1_len;
 =

 	*ptr++ =3D ASN1_ID_BIT_STRING;
 	*ptr++ =3D key_size + 2;
-- =

2.31.1

--===============7869666660773798762==--

