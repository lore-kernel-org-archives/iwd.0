Content-Type: multipart/mixed; boundary="===============0676587612100776968=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2] dpp-util: fix dpp_point_to_asn1 compressed type
Date: Tue, 18 Jan 2022 11:59:50 -0800
Message-ID: <20220118195950.1996926-1-prestwoj@gmail.com>

--===============0676587612100776968==
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
index 8ea3d498..029fbf6f 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -725,6 +725,7 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p,=
 size_t *len_out)
 	uint64_t x[L_ECC_MAX_DIGITS];
 	ssize_t ret;
 	size_t len;
+	uint8_t point_type;
 =

 	switch (key_size) {
 	case 32:
@@ -745,6 +746,17 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p=
, size_t *len_out)
 =

 	len =3D 2 + sizeof(ec_oid) + 2 + type_oid_len + 2 + key_size + 4;
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
 	if (L_WARN_ON(len > 128))
 		return NULL;
 =

@@ -774,7 +786,7 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p,=
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

--===============0676587612100776968==--

