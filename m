Content-Type: multipart/mixed; boundary="===============1969629007952314792=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/5] dpp: move r_auth into dpp_sm
Date: Fri, 07 Jan 2022 14:31:10 -0800
Message-ID: <20220107223112.715855-3-prestwoj@gmail.com>
In-Reply-To: 20220107223112.715855-1-prestwoj@gmail.com

--===============1969629007952314792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to support channel switching during authentication r_auth
needs to be held onto in dpp_sm for after the ROC call starts.
---
 src/dpp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 5d52e007..25359075 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -102,6 +102,7 @@ struct dpp_sm {
 =

 	uint64_t ke[L_ECC_MAX_DIGITS];
 	uint64_t k2[L_ECC_MAX_DIGITS];
+	uint64_t r_auth[L_ECC_MAX_DIGITS];
 =

 	struct l_ecc_scalar *proto_private;
 	struct l_ecc_point *proto_public;
@@ -967,7 +968,7 @@ static void dpp_handle_config_result_frame(struct dpp_s=
m *dpp,
  * ad1 =3D attrs
  * ad1_len =3D ptr - attrs
  */
-static void send_authenticate_response(struct dpp_sm *dpp, void *r_auth)
+static void send_authenticate_response(struct dpp_sm *dpp)
 {
 	uint8_t hdr[32];
 	uint8_t attrs[256];
@@ -998,7 +999,7 @@ static void send_authenticate_response(struct dpp_sm *d=
pp, void *r_auth)
 	/* Wrap up secondary data (R-Auth) */
 	wrapped2_len =3D dpp_append_attr(wrapped2_plaintext,
 					DPP_ATTR_RESPONDER_AUTH_TAG,
-					r_auth, dpp->key_len);
+					dpp->r_auth, dpp->key_len);
 	/*
 	 * "Invocations of AES-SIV in the DPP Authentication protocol that
 	 * produce ciphertext that is part of an additional AES-SIV invocation
@@ -1222,7 +1223,6 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *m =3D NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n =3D NULL;
 	uint64_t k1[L_ECC_MAX_DIGITS];
-	uint64_t r_auth[L_ECC_MAX_DIGITS];
 	const void *ad0 =3D body + 2;
 	const void *ad1 =3D body + 8;
 =

@@ -1363,7 +1363,7 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 =

 	if (!dpp_derive_r_auth(dpp->i_nonce, dpp->r_nonce, dpp->nonce_len,
 				dpp->i_proto_public, dpp->proto_public,
-				dpp->boot_public, r_auth))
+				dpp->boot_public, dpp->r_auth))
 		goto auth_request_failed;
 =

 	memcpy(dpp->auth_addr, from, 6);
@@ -1371,7 +1371,7 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 	dpp->state =3D DPP_STATE_AUTHENTICATING;
 	dpp_reset_protocol_timer(dpp);
 =

-	send_authenticate_response(dpp, r_auth);
+	send_authenticate_response(dpp);
 =

 	return;
 =

-- =

2.31.1

--===============1969629007952314792==--

