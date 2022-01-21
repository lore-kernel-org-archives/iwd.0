Content-Type: multipart/mixed; boundary="===============0575102553201970530=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] sae: pass exact length to l_ecc_point_from_data
Date: Fri, 21 Jan 2022 10:32:37 -0800
Message-ID: <20220121183237.2549872-1-prestwoj@gmail.com>

--===============0575102553201970530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

l_ecc_point_from_data now strictly enforces the buffer length.
---
 src/sae.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/sae.c b/src/sae.c
index b0f80bb6..dc07db4b 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -413,6 +413,7 @@ static struct l_ecc_point *sae_compute_pwe(const struct=
 l_ecc_curve *curve,
 	struct l_ecc_scalar *qnr;
 	uint8_t qnr_bin[L_ECC_SCALAR_MAX_BYTES] =3D {0};
 	struct l_ecc_point *pwe;
+	unsigned int bytes =3D l_ecc_curve_get_scalar_bytes(curve);
 =

 	/* create qr/qnr prior to beginning hunting-and-pecking loop */
 	qr =3D sae_new_residue(curve, true);
@@ -493,7 +494,7 @@ static struct l_ecc_point *sae_compute_pwe(const struct=
 l_ecc_curve *curve,
 		return NULL;
 	}
 =

-	pwe =3D l_ecc_point_from_data(curve, !is_odd + 2, x, sizeof(x));
+	pwe =3D l_ecc_point_from_data(curve, !is_odd + 2, x, bytes);
 	if (!pwe)
 		l_error("computing y failed, was x quadratic residue?");
 =

-- =

2.31.1

--===============0575102553201970530==--

