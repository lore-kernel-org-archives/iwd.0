Content-Type: multipart/mixed; boundary="===============4066652559614343722=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] dpp-util: fix dpp_point_to_asn1 compressed type
Date: Tue, 18 Jan 2022 08:58:46 -0800
Message-ID: <20220118165846.1968568-1-prestwoj@gmail.com>

--===============4066652559614343722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The point type was being hard coded to 0x3 (BIT1) which may have resulted
in the peer subtracting Y from P when reading in the point (depending on
if Y was odd or not).

Instead set the compressed type to whatever avoids the subtraction which
both saves IWD from needing to do it, as well as the peer.
---
 src/dpp-util.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 048009c4..a643beb1 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -728,6 +728,7 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p,=
 size_t *len_out)
 	uint64_t x[L_ECC_MAX_DIGITS];
 	ssize_t ret;
 	size_t len;
+	uint8_t point_type;
 =

 	switch (key_size) {
 	case 32:
@@ -744,6 +745,17 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p=
, size_t *len_out)
 	if (ret < 0 || ret !=3D key_size)
 		return NULL;
 =

+	/*
+	 * Set the type to whatever avoids doing p - y when reading in the
+	 * key. Working backwards from l_ecc_point_from_data if Y is odd and
+	 * the type is BIT0 there is no subtraction. Similarly if Y is even
+	 * and the type is BIT1.
+	 */
+	if (l_ecc_point_y_isodd(p))
+		point_type =3D L_ECC_POINT_TYPE_COMPRESSED_BIT0;
+	else
+		point_type =3D L_ECC_POINT_TYPE_COMPRESSED_BIT1;
+
 	len =3D 2 + ec_oid.asn1_len + 2 + key_type->asn1_len + 2 + key_size + 4;
 =

 	if (L_WARN_ON(len > 128))
@@ -775,7 +787,7 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p,=
 size_t *len_out)
 	*ptr++ =3D ASN1_ID_BIT_STRING;
 	*ptr++ =3D key_size + 2;
 	*ptr++ =3D 0x00;
-	*ptr++ =3D 0x03;
+	*ptr++ =3D point_type;
 	memcpy(ptr, x, key_size);
 	ptr +=3D key_size;
 =

-- =

2.31.1

--===============4066652559614343722==--

