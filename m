Content-Type: multipart/mixed; boundary="===============7207235665027538111=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 02/12] dpp-util: add dpp_point_from_asn1()
Date: Tue, 18 Jan 2022 13:25:02 -0800
Message-ID: <20220118212512.2017977-2-prestwoj@gmail.com>
In-Reply-To: 20220118212512.2017977-1-prestwoj@gmail.com

--===============7207235665027538111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Given an ASN1 blob of the right form, parse and create
an l_ecc_point object. The form used is specific to DPP
hence why this isn't general purpose and put into dpp-util.
---
 src/dpp-util.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  1 +
 2 files changed, 70 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 4823b2f0..81a97f97 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -796,3 +796,72 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p=
, size_t *len_out)
 =

 	return asn1;
 }
+
+/*
+ * Only checking for the ASN.1 form:
+ *
+ * SEQUENCE {
+ * 	SEQUENCE {
+ * 		OBJECT IDENTIFIER ecPublicKey
+ * 		OBJECT IDENTIFIER key type (p256/p384)
+ * 	}
+ * 	BITSTRING (key data)
+ * }
+ */
+struct l_ecc_point *dpp_point_from_asn1(const uint8_t *asn1, size_t len)
+{
+
+	const uint8_t *outer_seq;
+	size_t outer_len;
+	const uint8_t *inner_seq;
+	size_t inner_len;
+	const uint8_t *elem;
+	const uint8_t *key_data;
+	size_t elen =3D 0;
+	uint8_t tag;
+	unsigned int curve_num;
+	const struct l_ecc_curve *curve;
+
+	/* SEQUENCE */
+	outer_seq =3D asn1_der_find_elem(asn1, len, 0, &tag, &outer_len);
+	if (!outer_seq || tag !=3D ASN1_ID_SEQUENCE)
+		return NULL;
+
+	/* SEQUENCE */
+	inner_seq =3D asn1_der_find_elem(outer_seq, outer_len, 0, &tag, &inner_le=
n);
+	if (!inner_seq || tag !=3D ASN1_ID_SEQUENCE)
+		return NULL;
+
+	/* OBJECT IDENTIFIER (ecPublicKey) */
+	elem =3D asn1_der_find_elem(inner_seq, inner_len, 0, &tag, &elen);
+	if (!elem || tag !=3D ASN1_ID_OID)
+		return NULL;
+
+	/* Check that this OID is ecPublicKey */
+	if (!asn1_oid_eq(&ec_oid, elen, elem))
+		return NULL;
+
+	elem =3D asn1_der_find_elem(inner_seq, inner_len, 1, &tag, &elen);
+	if (!elem || tag !=3D ASN1_ID_OID)
+		return NULL;
+
+	/* Check if ELL supports this curve */
+	if (asn1_oid_eq(&ec_p256_oid, elen, elem))
+		curve_num =3D 19;
+	else if (asn1_oid_eq(&ec_p384_oid, elen, elem))
+		curve_num =3D 20;
+	else
+		return NULL;
+
+	/* BITSTRING */
+	key_data =3D asn1_der_find_elem(outer_seq, outer_len, 1, &tag, &elen);
+	if (!key_data || tag !=3D ASN1_ID_BIT_STRING || elen < 34)
+		return NULL;
+
+	curve =3D l_ecc_curve_from_ike_group(curve_num);
+	if (!curve)
+		return NULL;
+
+	return l_ecc_point_from_data(curve, key_data[1],
+					key_data + 2, elen - 2);
+}
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 84d33656..82535ff8 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -167,3 +167,4 @@ bool dpp_derive_ke(const uint8_t *i_nonce, const uint8_=
t *r_nonce,
 				void *ke);
 =

 uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p, size_t *len_out);
+struct l_ecc_point *dpp_point_from_asn1(const uint8_t *asn1, size_t len);
-- =

2.31.1

--===============7207235665027538111==--

