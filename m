Content-Type: multipart/mixed; boundary="===============6357303669988585043=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 05/12] dpp: use own/peer naming rather than i/r
Date: Tue, 18 Jan 2022 13:25:05 -0800
Message-ID: <20220118212512.2017977-5-prestwoj@gmail.com>
In-Reply-To: 20220118212512.2017977-1-prestwoj@gmail.com

--===============6357303669988585043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Several members are named based on initiator/responder (i/r)
terminology. Eventually both initiator and responder will be
supported so rename these members to use own/peer naming
instead.
---
 src/dpp.c | 70 +++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 78e8ffc5..a7216143 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -81,9 +81,9 @@ struct dpp_sm {
 =

 	uint64_t wdev_id;
 =

-	uint8_t *pub_asn1;
-	size_t pub_asn1_len;
-	uint8_t pub_boot_hash[32];
+	uint8_t *own_asn1;
+	size_t own_asn1_len;
+	uint8_t own_boot_hash[32];
 	const struct l_ecc_curve *curve;
 	size_t key_len;
 	size_t nonce_len;
@@ -109,12 +109,12 @@ struct dpp_sm {
 =

 	uint64_t ke[L_ECC_MAX_DIGITS];
 	uint64_t k2[L_ECC_MAX_DIGITS];
-	uint64_t r_auth[L_ECC_MAX_DIGITS];
+	uint64_t auth_tag[L_ECC_MAX_DIGITS];
 =

 	struct l_ecc_scalar *proto_private;
-	struct l_ecc_point *proto_public;
+	struct l_ecc_point *own_proto_public;
 =

-	struct l_ecc_point *i_proto_public;
+	struct l_ecc_point *peer_proto_public;
 =

 	uint8_t diag_token;
 =

@@ -131,9 +131,9 @@ struct dpp_sm {
 =

 static void dpp_free_auth_data(struct dpp_sm *dpp)
 {
-	if (dpp->proto_public) {
-		l_ecc_point_free(dpp->proto_public);
-		dpp->proto_public =3D NULL;
+	if (dpp->own_proto_public) {
+		l_ecc_point_free(dpp->own_proto_public);
+		dpp->own_proto_public =3D NULL;
 	}
 =

 	if (dpp->proto_private) {
@@ -141,9 +141,9 @@ static void dpp_free_auth_data(struct dpp_sm *dpp)
 		dpp->proto_private =3D NULL;
 	}
 =

-	if (dpp->i_proto_public) {
-		l_ecc_point_free(dpp->i_proto_public);
-		dpp->i_proto_public =3D NULL;
+	if (dpp->peer_proto_public) {
+		l_ecc_point_free(dpp->peer_proto_public);
+		dpp->peer_proto_public =3D NULL;
 	}
 }
 =

@@ -189,7 +189,7 @@ static void dpp_reset(struct dpp_sm *dpp)
 	explicit_bzero(dpp->e_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->ke, dpp->key_len);
 	explicit_bzero(dpp->k2, dpp->key_len);
-	explicit_bzero(dpp->r_auth, dpp->key_len);
+	explicit_bzero(dpp->auth_tag, dpp->key_len);
 =

 	dpp_free_auth_data(dpp);
 }
@@ -198,9 +198,9 @@ static void dpp_free(struct dpp_sm *dpp)
 {
 	dpp_reset(dpp);
 =

-	if (dpp->pub_asn1) {
-		l_free(dpp->pub_asn1);
-		dpp->pub_asn1 =3D NULL;
+	if (dpp->own_asn1) {
+		l_free(dpp->own_asn1);
+		dpp->own_asn1 =3D NULL;
 	}
 =

 	if (dpp->boot_public) {
@@ -1011,7 +1011,7 @@ static void send_authenticate_response(struct dpp_sm =
*dpp)
 	uint8_t wrapped2[dpp->key_len + 16 + 8];
 	size_t wrapped2_len;
 =

-	l_ecc_point_get_data(dpp->proto_public, r_proto_key,
+	l_ecc_point_get_data(dpp->own_proto_public, r_proto_key,
 				sizeof(r_proto_key));
 =

 	iov[0].iov_len =3D dpp_build_header(netdev_get_address(dpp->netdev),
@@ -1021,7 +1021,7 @@ static void send_authenticate_response(struct dpp_sm =
*dpp)
 =

 	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
 	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
-				dpp->pub_boot_hash, 32);
+				dpp->own_boot_hash, 32);
 	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_PROTOCOL_KEY,
 				r_proto_key, dpp->key_len * 2);
 	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
@@ -1029,7 +1029,7 @@ static void send_authenticate_response(struct dpp_sm =
*dpp)
 	/* Wrap up secondary data (R-Auth) */
 	wrapped2_len =3D dpp_append_attr(wrapped2_plaintext,
 					DPP_ATTR_RESPONDER_AUTH_TAG,
-					dpp->r_auth, dpp->key_len);
+					dpp->auth_tag, dpp->key_len);
 	/*
 	 * "Invocations of AES-SIV in the DPP Authentication protocol that
 	 * produce ciphertext that is part of an additional AES-SIV invocation
@@ -1165,7 +1165,7 @@ static void authenticate_confirm(struct dpp_sm *dpp, =
const uint8_t *from,
 	}
 =

 	dpp_derive_i_auth(dpp->r_nonce, dpp->i_nonce, dpp->nonce_len,
-				dpp->proto_public, dpp->i_proto_public,
+				dpp->own_proto_public, dpp->peer_proto_public,
 				dpp->boot_public, i_auth_check);
 =

 	if (memcmp(i_auth, i_auth_check, i_auth_len)) {
@@ -1205,7 +1205,7 @@ static void dpp_auth_request_failed(struct dpp_sm *dp=
p,
 =

 	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_STATUS, &s, 1);
 	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
-				dpp->pub_boot_hash, 32);
+				dpp->own_boot_hash, 32);
 =

 	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
 =

@@ -1247,7 +1247,7 @@ static void dpp_presence_announce(struct dpp_sm *dpp)
 	iov[0].iov_base =3D hdr;
 =

 	dpp_hash(L_CHECKSUM_SHA256, hash, 2, "chirp", strlen("chirp"),
-			dpp->pub_asn1, dpp->pub_asn1_len);
+			dpp->own_asn1, dpp->own_asn1_len);
 =

 	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH, hash, 32);
 =

@@ -1463,21 +1463,21 @@ static void authenticate_request(struct dpp_sm *dpp=
, const uint8_t *from,
 	if (!r_boot || !i_boot || !i_proto || !wrapped)
 		goto auth_request_failed;
 =

-	if (r_boot_len !=3D 32 || memcmp(dpp->pub_boot_hash,
+	if (r_boot_len !=3D 32 || memcmp(dpp->own_boot_hash,
 					r_boot, r_boot_len)) {
 		l_debug("Responder boot key hash failed to verify");
 		goto auth_request_failed;
 	}
 =

-	dpp->i_proto_public =3D l_ecc_point_from_data(dpp->curve,
+	dpp->peer_proto_public =3D l_ecc_point_from_data(dpp->curve,
 						L_ECC_POINT_TYPE_FULL,
 						i_proto, i_proto_len);
-	if (!dpp->i_proto_public) {
+	if (!dpp->peer_proto_public) {
 		l_debug("Initiators protocol key invalid");
 		goto auth_request_failed;
 	}
 =

-	m =3D dpp_derive_k1(dpp->i_proto_public, dpp->boot_private, k1);
+	m =3D dpp_derive_k1(dpp->peer_proto_public, dpp->boot_private, k1);
 	if (!m)
 		goto auth_request_failed;
 =

@@ -1527,9 +1527,9 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 	/* Derive keys k2, ke, and R-Auth for authentication response */
 =

 	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
-					&dpp->proto_public);
+					&dpp->own_proto_public);
 =

-	n =3D dpp_derive_k2(dpp->i_proto_public, dpp->proto_private, dpp->k2);
+	n =3D dpp_derive_k2(dpp->peer_proto_public, dpp->proto_private, dpp->k2);
 	if (!n)
 		goto auth_request_failed;
 =

@@ -1539,8 +1539,8 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 		goto auth_request_failed;
 =

 	if (!dpp_derive_r_auth(dpp->i_nonce, dpp->r_nonce, dpp->nonce_len,
-				dpp->i_proto_public, dpp->proto_public,
-				dpp->boot_public, dpp->r_auth))
+				dpp->peer_proto_public, dpp->own_proto_public,
+				dpp->boot_public, dpp->auth_tag))
 		goto auth_request_failed;
 =

 	memcpy(dpp->auth_addr, from, 6);
@@ -1664,10 +1664,10 @@ static void dpp_create(struct netdev *netdev)
 	l_ecdh_generate_key_pair(dpp->curve, &dpp->boot_private,
 					&dpp->boot_public);
 =

-	dpp->pub_asn1 =3D dpp_point_to_asn1(dpp->boot_public, &dpp->pub_asn1_len);
+	dpp->own_asn1 =3D dpp_point_to_asn1(dpp->boot_public, &dpp->own_asn1_len);
 =

-	dpp_hash(L_CHECKSUM_SHA256, dpp->pub_boot_hash, 1,
-			dpp->pub_asn1, dpp->pub_asn1_len);
+	dpp_hash(L_CHECKSUM_SHA256, dpp->own_boot_hash, 1,
+			dpp->own_asn1, dpp->own_asn1_len);
 =

 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
@@ -1791,7 +1791,7 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 	} else if (!station)
 		l_debug("No station device, continuing anyways...");
 =

-	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
+	dpp->uri =3D dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
 					netdev_get_address(dpp->netdev), &freq,
 					1, NULL, NULL);
 =

@@ -1848,7 +1848,7 @@ static struct l_dbus_message *dpp_dbus_start_configur=
ator(struct l_dbus *dbus,
 	if (dpp->state !=3D DPP_STATE_NOTHING)
 		return dbus_error_busy(message);
 =

-	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
+	dpp->uri =3D dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
 					netdev_get_address(dpp->netdev),
 					&bss->frequency, 1, NULL, NULL);
 =

-- =

2.31.1

--===============6357303669988585043==--

