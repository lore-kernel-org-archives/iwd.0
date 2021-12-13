Content-Type: multipart/mixed; boundary="===============8755445885008342047=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/9] dpp: add DPP authentication protocol
Date: Mon, 13 Dec 2021 12:33:29 -0800
Message-ID: <20211213203332.2191003-6-prestwoj@gmail.com>
In-Reply-To: 20211213203332.2191003-1-prestwoj@gmail.com

--===============8755445885008342047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implements the DPP protocol used to authenticate to a
DPP configurator.

Note this is not a full implementation of the protocol and
there are a few missing features which will be added as
needed:

 - Mutual authentication (needed for BLE bootstrapping)
 - Configurator support
 - Initiator role
---
 src/dpp.c | 561 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 561 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index e6477f5c..e0e381b8 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -42,6 +42,9 @@
 #include "src/frame-xchg.h"
 #include "src/iwd.h"
 #include "src/util.h"
+#include "src/crypto.h"
+#include "src/mpdu.h"
+#include "ell/useful.h"
 =

 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -50,6 +53,7 @@ static uint8_t broadcast[] =3D {0xff, 0xff, 0xff, 0xff, 0=
xff, 0xff};
 enum dpp_state {
 	DPP_STATE_NOTHING,
 	DPP_STATE_PRESENCE,
+	DPP_STATE_AUTHENTICATING,
 };
 =

 struct dpp_sm {
@@ -78,6 +82,18 @@ struct dpp_sm {
 	struct scan_freq_set *presence_list;
 =

 	uint32_t offchannel_id;
+
+	uint8_t auth_addr[6];
+	uint8_t r_nonce[32];
+	uint8_t i_nonce[32];
+
+	uint64_t ke[L_ECC_MAX_DIGITS];
+	uint64_t k2[L_ECC_MAX_DIGITS];
+
+	struct l_ecc_scalar *proto_private;
+	struct l_ecc_point *proto_public;
+
+	struct l_ecc_point *i_proto_public;
 };
 =

 static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
@@ -103,6 +119,34 @@ static void dpp_send_frame(uint64_t wdev_id, struct io=
vec *iov, size_t iov_len,
 		l_error("Could not send CMD_FRAME");
 }
 =

+static uint8_t *dpp_unwrap_attr(enum dpp_frame_type type, const void *star=
t,
+				const void *key, size_t key_len,
+				const uint8_t *wrapped, size_t wrapped_len,
+				size_t *unwrapped_len)
+{
+	uint8_t ad0[] =3D { 0x50, 0x6f, 0x9a, 0x1a, 0x01, type };
+	struct iovec ad[2];
+	uint8_t *unwrapped;
+
+	ad[0].iov_base =3D ad0;
+	ad[0].iov_len =3D sizeof(ad0);
+
+	ad[1].iov_base =3D (void *)start;
+	ad[1].iov_len =3D ((wrapped - 4) - ((const uint8_t *)start));
+
+	unwrapped =3D l_malloc(wrapped_len - 16);
+
+	if (!aes_siv_decrypt(key, key_len, wrapped, wrapped_len, ad, 2,
+				unwrapped)) {
+		l_free(unwrapped);
+		return NULL;
+	}
+
+	*unwrapped_len =3D wrapped_len - 16;
+
+	return unwrapped;
+}
+
 static size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
 				void *attr, size_t attr_len)
 {
@@ -113,6 +157,93 @@ static size_t dpp_append_attr(uint8_t *to, enum dpp_at=
tribute_type type,
 	return attr_len + 4;
 }
 =

+/*
+ * Encrypt DPP attributes encapsulated in DPP wrapped data.
+ *
+ * hdr - pointer to start of OUI, or NULL
+ * wrap_start - pointer to the start of wrapped data attribute
+ * to - buffer to encrypt data.
+ * to_len - size of 'to'
+ * key - key used to encrypt
+ * key_len - size of 'key'
+ * num_attrs - number of attributes listed (type, length, data triplets)
+ * ... - List of attributes, Type, Length, and data
+ */
+static size_t dpp_append_wrapped_data(uint8_t *hdr, uint8_t *wrap_start,
+					uint8_t *to, size_t to_len,
+					const void *key, size_t key_len,
+					size_t num_attrs, ...)
+{
+	size_t i;
+	size_t attrs_len =3D 0;
+	_auto_(l_free) uint8_t *plaintext =3D NULL;
+	uint8_t *ptr;
+	struct iovec ad[2];
+	size_t ad_size =3D 0;
+	va_list va;
+
+	if (hdr) {
+		ad[0].iov_base =3D hdr;
+		ad[0].iov_len =3D 6;
+		ad_size++;
+	}
+
+	va_start(va, num_attrs);
+
+	/* Count up total attributes length */
+	for (i =3D 0; i < num_attrs; i++) {
+		va_arg(va, enum dpp_attribute_type);
+		attrs_len +=3D va_arg(va, size_t) + 4;
+		va_arg(va, void*);
+	}
+
+	if (to_len < attrs_len + 4 + 16)
+		return false;
+
+	plaintext =3D l_malloc(attrs_len);
+
+	ptr =3D plaintext;
+
+	va_end(va);
+
+	va_start(va, num_attrs);
+
+	/* Build up plaintext attributes */
+	for (i =3D 0; i < num_attrs; i++) {
+		enum dpp_attribute_type type =3D va_arg(va,
+						enum dpp_attribute_type);
+		size_t l =3D va_arg(va, size_t);
+		void *p =3D va_arg(va, void *);
+
+		l_put_le16(type, ptr);
+		ptr +=3D 2;
+		l_put_le16(l, ptr);
+		ptr +=3D 2;
+		memcpy(ptr, p, l);
+		ptr +=3D l;
+	}
+
+	va_end(va);
+
+	ptr =3D to;
+
+	l_put_le16(DPP_ATTR_WRAPPED_DATA, ptr);
+	ptr +=3D 2;
+	l_put_le16(attrs_len + 16, ptr);
+	ptr +=3D 2;
+
+	if (wrap_start) {
+		ad[1].iov_base =3D wrap_start;
+		ad[1].iov_len =3D ptr - wrap_start - 4;
+		ad_size++;
+	}
+
+	aes_siv_encrypt(key, key_len, plaintext, attrs_len,
+				ad, ad_size, ptr);
+
+	return attrs_len + 4 + 16;
+}
+
 static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
 				enum dpp_frame_type type,
 				uint8_t buf[static 32])
@@ -137,6 +268,429 @@ static size_t dpp_build_header(const uint8_t *src, co=
nst uint8_t *dest,
 	return ptr - buf;
 }
 =

+static void dpp_free_auth_data(struct dpp_sm *dpp)
+{
+	if (dpp->proto_public)
+		l_ecc_point_free(dpp->proto_public);
+
+	if (dpp->proto_private)
+		l_ecc_scalar_free(dpp->proto_private);
+
+	if (dpp->i_proto_public)
+		l_ecc_point_free(dpp->i_proto_public);
+}
+
+static void send_authenticate_response(struct dpp_sm *dpp, void *r_auth)
+{
+	uint8_t hdr[32];
+	uint8_t attrs[512];
+	uint8_t *ptr =3D attrs;
+	uint8_t status =3D DPP_STATUS_OK;
+	uint64_t r_proto_key[L_ECC_MAX_DIGITS * 2];
+	uint8_t version =3D 2;
+	uint8_t r_capabilities =3D 0x01;
+	struct iovec iov[3];
+	uint8_t wrapped2_plaintext[dpp->key_len + 4];
+	uint8_t wrapped2[dpp->key_len + 16 + 8];
+	size_t wrapped2_len;
+
+	l_ecc_point_get_data(dpp->proto_public, r_proto_key,
+				sizeof(r_proto_key));
+
+	iov[0].iov_len =3D dpp_build_header(netdev_get_address(dpp->netdev),
+				dpp->auth_addr,
+				DPP_FRAME_AUTHENTICATION_RESPONSE, hdr);
+	iov[0].iov_base =3D hdr;
+
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
+				dpp->pub_boot_hash, 32);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_PROTOCOL_KEY,
+				r_proto_key, dpp->key_len * 2);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
+
+	/* Wrap up secondary data (R-Auth) */
+	wrapped2_len =3D dpp_append_attr(wrapped2_plaintext,
+					DPP_ATTR_RESPONDER_AUTH_TAG,
+					r_auth, dpp->key_len);
+	aes_siv_encrypt(dpp->ke, dpp->key_len, wrapped2_plaintext,
+					dpp->key_len + 4, NULL, 0, wrapped2);
+
+	wrapped2_len +=3D 16;
+
+	/* Wrap up primary data */
+	ptr +=3D dpp_append_wrapped_data(hdr + 26, attrs,
+			ptr, 512, dpp->k2, dpp->key_len, 4,
+			DPP_ATTR_RESPONDER_NONCE, dpp->nonce_len, dpp->r_nonce,
+			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
+			DPP_ATTR_RESPONDER_CAPABILITIES, 1, &r_capabilities,
+			DPP_ATTR_WRAPPED_DATA, wrapped2_len, wrapped2);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+	iov[2].iov_base =3D NULL;
+
+	dpp_send_frame(netdev_get_wdev_id(dpp->netdev), iov, 2,
+				dpp->current_freq);
+}
+
+static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
+					const uint8_t *attrs, size_t attrs_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	enum dpp_status status =3D __DPP_STATUS_INVALID;
+	const uint8_t *r_boot_hash =3D NULL, *wrapped =3D NULL;
+	const uint8_t *i_auth =3D NULL;
+	size_t i_auth_len;
+	_auto_(l_free) uint8_t *unwrapped =3D NULL;
+	size_t wrapped_len =3D 0;
+	uint64_t i_auth_check[L_ECC_MAX_DIGITS];
+	const void *unwrap_key;
+
+	if (memcmp(from, dpp->auth_addr, 6))
+		return;
+
+	l_debug("authenticate confirm");
+
+	dpp_attr_iter_init(&iter, attrs, attrs_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_STATUS:
+			status =3D l_get_u8(data);
+			break;
+		case DPP_ATTR_RESPONDER_BOOT_KEY_HASH:
+			r_boot_hash =3D data;
+			/*
+			 * Spec requires this, but does not mention if anything
+			 * is to be done with it.
+			 */
+			break;
+		case DPP_ATTR_INITIATOR_BOOT_KEY_HASH:
+			/* No mutual authentication */
+			break;
+		case DPP_ATTR_WRAPPED_DATA:
+			wrapped =3D data;
+			wrapped_len =3D len;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!r_boot_hash || !wrapped) {
+		l_debug("Attributes missing from authenticate confirm");
+		return;
+	}
+
+	/*
+	 * "The Responder obtains the DPP Authentication Confirm frame and
+	 * checks the value of the DPP Status field. If the value of the DPP
+	 * Status field is STATUS_NOT_COMPATIBLE or STATUS_AUTH_FAILURE, the
+	 * Responder unwraps the wrapped data portion of the frame using k2"
+	 */
+	if (status =3D=3D DPP_STATUS_OK)
+		unwrap_key =3D dpp->ke;
+	else if (status =3D=3D DPP_STATUS_NOT_COMPATIBLE ||
+				status =3D=3D DPP_STATUS_AUTH_FAILURE)
+		unwrap_key =3D dpp->k2;
+	else
+		goto auth_confirm_failed;
+
+	unwrapped =3D dpp_unwrap_attr(DPP_FRAME_AUTHENTICATION_CONFIRM, attrs,
+			unwrap_key, dpp->key_len, wrapped, wrapped_len,
+			&wrapped_len);
+	if (!unwrapped)
+		goto auth_confirm_failed;
+
+	if (status !=3D DPP_STATUS_OK) {
+		/*
+		 * "If unwrapping is successful, the Responder should generate
+		 * an alert indicating the reason for the protocol failure."
+		 */
+		l_debug("Authentication failed due to status %s",
+				status =3D=3D DPP_STATUS_NOT_COMPATIBLE ?
+				"NOT_COMPATIBLE" : "AUTH_FAILURE");
+		goto auth_confirm_failed;
+	}
+
+	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_INITIATOR_AUTH_TAG:
+			i_auth =3D data;
+			i_auth_len =3D len;
+			break;
+		case DPP_ATTR_RESPONDER_NONCE:
+			/* Only if error */
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!i_auth || i_auth_len !=3D dpp->key_len) {
+		l_debug("I-Auth missing from wrapped data");
+		goto auth_confirm_failed;
+	}
+
+	dpp_derive_i_auth(dpp->r_nonce, dpp->i_nonce, dpp->nonce_len,
+				dpp->proto_public, dpp->i_proto_public,
+				dpp->boot_public, i_auth_check);
+
+	if (memcmp(i_auth, i_auth_check, i_auth_len)) {
+		l_error("I-Auth did not verify");
+		goto auth_confirm_failed;
+	}
+
+	l_debug("Authentication successful");
+
+	return;
+
+auth_confirm_failed:
+	dpp->state =3D DPP_STATE_PRESENCE;
+	dpp_free_auth_data(dpp);
+}
+
+static void dpp_auth_request_failed(struct dpp_sm *dpp,
+					enum dpp_status status,
+					void *k1)
+{
+	uint8_t hdr[32];
+	uint8_t attrs[128];
+	uint8_t *ptr =3D attrs;
+	uint8_t version =3D 2;
+	uint8_t r_capabilities =3D 0x01;
+	struct iovec iov[3];
+
+	iov[0].iov_len =3D dpp_build_header(netdev_get_address(dpp->netdev),
+				dpp->auth_addr,
+				DPP_FRAME_AUTHENTICATION_RESPONSE, hdr);
+	iov[0].iov_base =3D hdr;
+
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
+				dpp->pub_boot_hash, 32);
+
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
+
+	ptr +=3D dpp_append_wrapped_data(hdr + 26, attrs,
+			ptr, sizeof(attrs) - (ptr - attrs), k1, dpp->key_len, 2,
+			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
+			DPP_ATTR_RESPONDER_CAPABILITIES, 1, &r_capabilities);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+	iov[2].iov_base =3D NULL;
+
+	dpp_send_frame(netdev_get_wdev_id(dpp->netdev), iov, 2,
+				dpp->current_freq);
+}
+
+static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
+					const uint8_t *attrs, size_t attrs_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	const uint8_t *r_boot =3D NULL;
+	const uint8_t *i_boot =3D NULL;
+	const uint8_t *i_proto =3D NULL;
+	const uint8_t *wrapped =3D NULL;
+	const uint8_t *i_nonce =3D NULL;
+	size_t r_boot_len =3D 0, i_proto_len =3D 0, wrapped_len =3D 0;
+	size_t i_nonce_len =3D 0;
+	_auto_(l_free) uint8_t *unwrapped =3D NULL;
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *m =3D NULL;
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n =3D NULL;
+	uint64_t k1[L_ECC_MAX_DIGITS];
+	uint64_t r_auth[L_ECC_MAX_DIGITS];
+
+	if (dpp->state !=3D DPP_STATE_PRESENCE && dpp->state !=3D DPP_STATE_NOTHI=
NG)
+		return;
+
+	l_debug("authenticate request");
+
+	dpp_attr_iter_init(&iter, attrs, attrs_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_INITIATOR_BOOT_KEY_HASH:
+			i_boot =3D data;
+			/*
+			 * This attribute is required by the spec, but only
+			 * used for mutual authentication.
+			 */
+			break;
+		case DPP_ATTR_RESPONDER_BOOT_KEY_HASH:
+			r_boot =3D data;
+			r_boot_len =3D len;
+			break;
+		case DPP_ATTR_INITIATOR_PROTOCOL_KEY:
+			i_proto =3D data;
+			i_proto_len =3D len;
+			break;
+		case DPP_ATTR_WRAPPED_DATA:
+			/* I-Nonce/I-Capabilities part of wrapped data */
+			wrapped =3D data;
+			wrapped_len =3D len;
+			break;
+
+		/* Optional attributes */
+		case DPP_ATTR_PROTOCOL_VERSION:
+			if (l_get_u8(data) !=3D 2) {
+				l_debug("Protocol version did not match");
+				return;
+			}
+
+			break;
+		/*
+		 * TODO: Go on this channel for remainder of auth protocol.
+		 *
+		 * "the Responder determines whether it can use the requested
+		 * channel for the following exchanges. If so, it sends the DPP
+		 * Authentication Response frame on that channel. If not, it
+		 * discards the DPP Authentication Request frame without
+		 * replying to it."
+		 *
+		 * For the time being this feature is not being implemented and
+		 * the frame will be dropped.
+		 */
+		case DPP_ATTR_CHANNEL:
+			return;
+		default:
+			break;
+		}
+	}
+
+	if (!r_boot || !i_boot || !i_proto || !wrapped)
+		goto auth_request_failed;
+
+	if (r_boot_len !=3D 32 || memcmp(dpp->pub_boot_hash,
+					r_boot, r_boot_len)) {
+		l_debug("Responder boot key hash failed to verify");
+		goto auth_request_failed;
+	}
+
+	dpp->i_proto_public =3D l_ecc_point_from_data(dpp->curve,
+						L_ECC_POINT_TYPE_FULL,
+						i_proto, i_proto_len);
+	if (!dpp->i_proto_public) {
+		l_debug("Initiators protocol key invalid");
+		goto auth_request_failed;
+	}
+
+	m =3D dpp_derive_k1(dpp->i_proto_public, dpp->boot_private, k1);
+	if (!m)
+		goto auth_request_failed;
+
+	unwrapped =3D dpp_unwrap_attr(DPP_FRAME_AUTHENTICATION_REQUEST, attrs, k1,
+			dpp->key_len, wrapped, wrapped_len, &wrapped_len);
+	if (!unwrapped)
+		goto auth_request_failed;
+
+	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_INITIATOR_NONCE:
+			i_nonce =3D data;
+			i_nonce_len =3D len;
+			break;
+		case DPP_ATTR_INITIATOR_CAPABILITIES:
+			/*
+			 * "If the Responder is not capable of supporting the
+			 * role indicated by the Initiator, it shall respond
+			 * with a DPP Authentication Response frame indicating
+			 * failure by adding the DPP Status field set to
+			 * STATUS_NOT_COMPATIBLE"
+			 */
+			if (!(l_get_u8(data) & 0x2)) {
+				l_debug("Initiator is not configurator");
+
+				dpp_auth_request_failed(dpp,
+						DPP_STATUS_NOT_COMPATIBLE, k1);
+				goto auth_request_failed;
+			}
+
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (i_nonce_len !=3D dpp->nonce_len) {
+		l_debug("I-Nonce has unexpected length %lu", i_nonce_len);
+		goto auth_request_failed;
+	}
+
+	memcpy(dpp->i_nonce, i_nonce, i_nonce_len);
+
+	/* Derive keys k2, ke, and R-Auth for authentication response */
+
+	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
+					&dpp->proto_public);
+
+	n =3D dpp_derive_k2(dpp->i_proto_public, dpp->proto_private, dpp->k2);
+	if (!n)
+		goto auth_request_failed;
+
+	l_getrandom(dpp->r_nonce, dpp->nonce_len);
+
+	if (!dpp_derive_ke(dpp->i_nonce, dpp->r_nonce, m, n, dpp->ke))
+		goto auth_request_failed;
+
+	if (!dpp_derive_r_auth(dpp->i_nonce, dpp->r_nonce, dpp->nonce_len,
+				dpp->i_proto_public, dpp->proto_public,
+				dpp->boot_public, r_auth))
+		goto auth_request_failed;
+
+	memcpy(dpp->auth_addr, from, 6);
+
+	dpp->state =3D DPP_STATE_AUTHENTICATING;
+
+	send_authenticate_response(dpp, r_auth);
+
+	return;
+
+auth_request_failed:
+	dpp->state =3D DPP_STATE_PRESENCE;
+	dpp_free_auth_data(dpp);
+}
+
+static void dpp_handle_auth_frame(const struct mmpdu_header *frame,
+				const void *body, size_t body_len,
+				int rssi, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+	const uint8_t *ptr;
+
+	if (body_len < 8)
+		return;
+
+	ptr =3D body + 7;
+	body_len -=3D 7;
+
+	switch (*ptr) {
+	case DPP_FRAME_AUTHENTICATION_REQUEST:
+		authenticate_request(dpp, frame->address_2, ptr + 1,
+					body_len - 1);
+		break;
+	case DPP_FRAME_AUTHENTICATION_CONFIRM:
+		authenticate_confirm(dpp, frame->address_2, ptr + 1,
+					body_len - 1);
+		break;
+	default:
+		l_debug("Unhandled DPP frame %u", *ptr);
+		break;
+	}
+}
+
 static void dpp_presence_announce(struct dpp_sm *dpp)
 {
 	struct netdev *netdev =3D dpp->netdev;
@@ -177,6 +731,7 @@ static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
 	struct dpp_sm *dpp =3D l_new(struct dpp_sm, 1);
+	uint8_t dpp_prefix[] =3D { 0x04, 0x09, 0x50, 0x6f, 0x9a, 0x1a, 0x01 };
 =

 	dpp->netdev =3D netdev;
 	dpp->state =3D DPP_STATE_NOTHING;
@@ -184,6 +739,10 @@ static void dpp_create(struct netdev *netdev)
 =

 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
+
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0, dpp_prefix,
+				sizeof(dpp_prefix), dpp_handle_auth_frame,
+				dpp, NULL);
 }
 =

 static void dpp_reset(struct dpp_sm *dpp)
@@ -223,6 +782,8 @@ static void dpp_free(struct dpp_sm *dpp)
 		dpp->offchannel_id =3D 0;
 	}
 =

+	dpp_free_auth_data(dpp);
+
 	l_free(dpp);
 }
 =

-- =

2.31.1

--===============8755445885008342047==--

