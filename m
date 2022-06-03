Content-Type: multipart/mixed; boundary="===============7856940892974953081=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] dpp,dpp-util: use 'ULL' for constant arguments to va_arg
Date: Fri, 03 Jun 2022 09:38:57 -0700
Message-ID: <20220603163857.179014-1-prestwoj@gmail.com>

--===============7856940892974953081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There were a few places in dpp/dpp-util which passed a single byte but
was being read in with va_arg(va, size_t). On some architectures this was
causing failures presumably from the compiler using an integer type
smaller than size_t. As we do elsewhere, use 1ULL to force the compiler
to pass a properly sized iteger to va_arg.
---
 src/dpp-util.c | 6 ++++--
 src/dpp.c      | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 8e7631d0..8cb37340 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -571,7 +571,8 @@ bool dpp_derive_r_auth(const void *i_nonce, const void =
*r_nonce,
 	 * R-auth =3D H(I-nonce | R-nonce | PI.x | PR.x | [ BI.x | ] BR.x | 0)
 	 */
 	return dpp_hash(type, r_auth, 6, i_nonce, nonce_len, r_nonce, nonce_len,
-			pix, keys_len, prx, keys_len, brx, keys_len, &zero, 1);
+			pix, keys_len, prx, keys_len, brx, keys_len,
+			&zero, 1ULL);
 }
 =

 bool dpp_derive_i_auth(const void *r_nonce, const void *i_nonce,
@@ -596,7 +597,8 @@ bool dpp_derive_i_auth(const void *r_nonce, const void =
*i_nonce,
 	 * I-auth =3D H(R-nonce | I-nonce | PR.x | PI.x | BR.x | [ BI.x | ] 1)
 	 */
 	return dpp_hash(type, i_auth, 6, r_nonce, nonce_len, i_nonce, nonce_len,
-			prx, keys_len, pix, keys_len, brx, keys_len, &one, 1);
+			prx, keys_len, pix, keys_len, brx, keys_len,
+			&one, 1ULL);
 }
 =

 /*
diff --git a/src/dpp.c b/src/dpp.c
index b70b9871..d6b312d7 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -511,7 +511,7 @@ static void send_config_result(struct dpp_sm *dpp, cons=
t uint8_t *to)
 =

 	ptr +=3D dpp_append_wrapped_data(hdr + 26, 6, attrs, 0, ptr,
 			sizeof(attrs), dpp->ke, dpp->key_len, 2,
-			DPP_ATTR_STATUS, 1, &zero,
+			DPP_ATTR_STATUS, 1ULL, &zero,
 			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce);
 =

 	iov[1].iov_base =3D attrs;
@@ -1146,7 +1146,7 @@ static void send_authenticate_response(struct dpp_sm =
*dpp)
 			ptr, sizeof(attrs), dpp->k2, dpp->key_len, 4,
 			DPP_ATTR_RESPONDER_NONCE, dpp->nonce_len, dpp->r_nonce,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
-			DPP_ATTR_RESPONDER_CAPABILITIES, 1, &dpp->role,
+			DPP_ATTR_RESPONDER_CAPABILITIES, 1ULL, &dpp->role,
 			DPP_ATTR_WRAPPED_DATA, wrapped2_len, wrapped2);
 =

 	iov[1].iov_base =3D attrs;
@@ -1313,7 +1313,7 @@ static void dpp_auth_request_failed(struct dpp_sm *dp=
p,
 	ptr +=3D dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs,
 			ptr, sizeof(attrs) - (ptr - attrs), k1, dpp->key_len, 2,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
-			DPP_ATTR_RESPONDER_CAPABILITIES, 1, &dpp->role);
+			DPP_ATTR_RESPONDER_CAPABILITIES, 1ULL, &dpp->role);
 =

 	iov[1].iov_base =3D attrs;
 	iov[1].iov_len =3D ptr - attrs;
@@ -1404,7 +1404,7 @@ static bool dpp_send_authenticate_request(struct dpp_=
sm *dpp)
 	ptr +=3D dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs,
 			ptr, sizeof(attrs), dpp->k1, dpp->key_len, 2,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
-			DPP_ATTR_INITIATOR_CAPABILITIES, 1, &dpp->role);
+			DPP_ATTR_INITIATOR_CAPABILITIES, 1ULL, &dpp->role);
 =

 	iov[1].iov_base =3D attrs;
 	iov[1].iov_len =3D ptr - attrs;
-- =

2.34.1

--===============7856940892974953081==--

