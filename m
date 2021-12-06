Content-Type: multipart/mixed; boundary="===============0715057525339987776=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] unit: fix memory leaks in test-dpp
Date: Mon, 06 Dec 2021 15:51:26 -0800
Message-ID: <20211206235126.1384140-1-prestwoj@gmail.com>

--===============0715057525339987776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-dpp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index d687bba0..1d4846c7 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -31,6 +31,7 @@
 =

 #include "src/dpp-util.h"
 #include "src/util.h"
+#include "ell/useful.h"
 =

 /*
  * B.2 Test Vectors for DPP Authentication Using P-256 for
@@ -68,12 +69,13 @@ static void test_key_derivation(const void *data)
 {
 	uint64_t tmp[L_ECC_MAX_DIGITS];
 	const struct l_ecc_curve *curve =3D l_ecc_curve_from_ike_group(19);
-	struct l_ecc_point *i_proto_public;
-	struct l_ecc_point *r_boot_public;
-	struct l_ecc_scalar *r_boot_private;
-	struct l_ecc_scalar *r_proto_private;
-	struct l_ecc_point *r_proto_public;
-	struct l_ecc_scalar *m, *n;
+	_auto_(l_ecc_point_free) struct l_ecc_point *i_proto_public =3D NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *r_boot_public =3D NULL;
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *r_boot_private =3D NULL;
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *r_proto_private =3D NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *r_proto_public =3D NULL;
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *m =3D NULL;
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n =3D NULL;
 	uint64_t k1[L_ECC_MAX_DIGITS];
 	uint64_t k2[L_ECC_MAX_DIGITS];
 	uint64_t ke[L_ECC_MAX_DIGITS];
-- =

2.31.1

--===============0715057525339987776==--

