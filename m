Content-Type: multipart/mixed; boundary="===============6679741296217284041=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 01/10] dpp-util: fix dpp_point_from_asn1
Date: Mon, 14 Feb 2022 13:48:00 -0800
Message-ID: <20220214214809.1017870-1-prestwoj@gmail.com>

--===============6679741296217284041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This got merged without a few additional fixes, in particular an
over 80 character line and incorrect length check.
---
 src/dpp-util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 4a5bd046..5199d0ae 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -828,7 +828,8 @@ struct l_ecc_point *dpp_point_from_asn1(const uint8_t *=
asn1, size_t len)
 		return NULL;
 =

 	/* SEQUENCE */
-	inner_seq =3D asn1_der_find_elem(outer_seq, outer_len, 0, &tag, &inner_le=
n);
+	inner_seq =3D asn1_der_find_elem(outer_seq, outer_len, 0, &tag,
+					&inner_len);
 	if (!inner_seq || tag !=3D ASN1_ID_SEQUENCE)
 		return NULL;
 =

@@ -859,7 +860,7 @@ struct l_ecc_point *dpp_point_from_asn1(const uint8_t *=
asn1, size_t len)
 =

 	/* BITSTRING */
 	key_data =3D asn1_der_find_elem(outer_seq, outer_len, 1, &tag, &elen);
-	if (!key_data || tag !=3D ASN1_ID_BIT_STRING || elen > 2)
+	if (!key_data || tag !=3D ASN1_ID_BIT_STRING || elen < 2)
 		return NULL;
 =

 	return l_ecc_point_from_data(curve, key_data[1],
-- =

2.34.1

--===============6679741296217284041==--

