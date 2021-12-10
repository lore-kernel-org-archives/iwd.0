Content-Type: multipart/mixed; boundary="===============3153252013691499350=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] dpp-util: check return of l_ecc_scalar_get_data
Date: Fri, 10 Dec 2021 08:48:39 -0800
Message-ID: <20211210164839.1938702-1-prestwoj@gmail.com>

--===============3153252013691499350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Static analysis was not happy since this return can be negative and
it was being fed into an unsigned argument. In reality this cannot
happen since the key buffer is always set to the maximum size supported
by any curves.
---
 src/dpp-util.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 31d8e2c4..ac365ccc 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -420,16 +420,20 @@ struct l_ecc_scalar *dpp_derive_k1(const struct l_ecc=
_point *i_proto_public,
 		return NULL;
 =

 	key_len =3D l_ecc_scalar_get_data(m, mx_bytes, sizeof(mx_bytes));
+	if (key_len < 0)
+		goto free_m;
 =

 	sha =3D dpp_sha_from_key_len(key_len);
 =

 	if (!dpp_hkdf(sha, NULL, key_len, "first intermediate key", mx_bytes,
-			key_len, k1, key_len)) {
-		l_ecc_scalar_free(m);
-		return NULL;
-	}
+			key_len, k1, key_len))
+		goto free_m;
 =

 	return m;
+
+free_m:
+	l_ecc_scalar_free(m);
+	return NULL;
 }
 =

 /*
@@ -449,16 +453,20 @@ struct l_ecc_scalar *dpp_derive_k2(const struct l_ecc=
_point *i_proto_public,
 		return NULL;
 =

 	key_len =3D l_ecc_scalar_get_data(n, nx_bytes, sizeof(nx_bytes));
+	if (key_len < 0)
+		goto free_n;
 =

 	sha =3D dpp_sha_from_key_len(key_len);
 =

 	if (!dpp_hkdf(sha, NULL, key_len, "second intermediate key", nx_bytes,
-			key_len, k2, key_len)) {
-		l_ecc_scalar_free(n);
-		return NULL;
-	}
+			key_len, k2, key_len))
+		goto free_n;
 =

 	return n;
+
+free_n:
+	l_ecc_scalar_free(n);
+	return NULL;
 }
 =

 bool dpp_derive_ke(const uint8_t *i_nonce, const uint8_t *r_nonce,
-- =

2.31.1

--===============3153252013691499350==--

