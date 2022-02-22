Content-Type: multipart/mixed; boundary="===============5698677403707817196=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v6 4/9] dpp: add support for initiating as a configurator
Date: Tue, 22 Feb 2022 14:02:27 -0800
Message-ID: <20220222220232.2475972-4-prestwoj@gmail.com>
In-Reply-To: 20220222220232.2475972-1-prestwoj@gmail.com

--===============5698677403707817196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The difference between the existing code is that IWD will send the
authentication request, making it the initiator.

This handles the use case where IWD is provided a peers URI containing
its bootstrapping key rather than IWD always providing its own URI.
A new DBus API was added, ConfigureEnrollee().

Using ConfigureEnrollee() IWD will act as a configurator but begin by
traversing a channel list (URI provided or default) and waiting for
presence announcements (with one caveat). When an announcement is
received IWD will send an authentication request to the peer, receive
its reply, and send an authentication confirm.

As with being a responder, IWD only supports configuration to the
currently connected BSS and will request the enrollee switch to this
BSS's frequency to preserve network performance.

The caveat here is that only one driver (ath9k) supports multicast frame
registration which prevents presence frame from being received. In this
case it will be required the the peer URI contains a MAC and channel
information. This is because IWD will jump right into sending auth
requests rather than waiting for a presence announcement.
---
 src/dpp.c | 496 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 486 insertions(+), 10 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 17c7425a..62790c0c 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -84,15 +84,23 @@ struct dpp_sm {
 =

 	uint8_t *own_asn1;
 	size_t own_asn1_len;
+	uint8_t *peer_asn1;
+	size_t peer_asn1_len;
 	uint8_t own_boot_hash[32];
+	uint8_t peer_boot_hash[32];
 	const struct l_ecc_curve *curve;
 	size_t key_len;
 	size_t nonce_len;
 	struct l_ecc_scalar *boot_private;
 	struct l_ecc_point *boot_public;
+	struct l_ecc_point *peer_boot_public;
 =

 	enum dpp_state state;
 =

+	/*
+	 * List of frequencies to jump between. The presence of this list is
+	 * also used to signify that a configurator is an initiator vs responder
+	 */
 	uint32_t *freqs;
 	size_t freqs_len;
 	size_t freqs_idx;
@@ -108,7 +116,9 @@ struct dpp_sm {
 	uint8_t i_nonce[32];
 	uint8_t e_nonce[32];
 =

+	struct l_ecc_scalar *m;
 	uint64_t ke[L_ECC_MAX_DIGITS];
+	uint64_t k1[L_ECC_MAX_DIGITS];
 	uint64_t k2[L_ECC_MAX_DIGITS];
 	uint64_t auth_tag[L_ECC_MAX_DIGITS];
 =

@@ -148,6 +158,16 @@ static void dpp_free_auth_data(struct dpp_sm *dpp)
 		l_ecc_point_free(dpp->peer_proto_public);
 		dpp->peer_proto_public =3D NULL;
 	}
+
+	if (dpp->peer_boot_public) {
+		l_ecc_point_free(dpp->peer_boot_public);
+		dpp->peer_boot_public =3D NULL;
+	}
+
+	if (dpp->m) {
+		l_ecc_scalar_free(dpp->m);
+		dpp->m =3D NULL;
+	}
 }
 =

 static void dpp_reset(struct dpp_sm *dpp)
@@ -182,6 +202,11 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->connect_scan_id =3D 0;
 	}
 =

+	if (dpp->peer_asn1) {
+		l_free(dpp->peer_asn1);
+		dpp->peer_asn1 =3D NULL;
+	}
+
 	dpp->state =3D DPP_STATE_NOTHING;
 	dpp->new_freq =3D 0;
 	dpp->frame_retry =3D 0;
@@ -191,6 +216,7 @@ static void dpp_reset(struct dpp_sm *dpp)
 	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->e_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->ke, dpp->key_len);
+	explicit_bzero(dpp->k1, dpp->key_len);
 	explicit_bzero(dpp->k2, dpp->key_len);
 	explicit_bzero(dpp->auth_tag, dpp->key_len);
 =

@@ -1266,21 +1292,69 @@ static void dpp_presence_announce(struct dpp_sm *dp=
p)
 	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 =

+static void dpp_send_authenticate_request(struct dpp_sm *dpp)
+{
+	uint8_t hdr[32];
+	uint8_t attrs[256];
+	uint8_t *ptr =3D attrs;
+	uint64_t i_proto_key[L_ECC_MAX_DIGITS * 2];
+	uint8_t version =3D 2;
+	struct iovec iov[2];
+	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
+	struct scan_bss *bss =3D station_get_connected_bss(station);
+
+	l_ecc_point_get_data(dpp->own_proto_public, i_proto_key,
+				sizeof(i_proto_key));
+
+	iov[0].iov_len =3D dpp_build_header(netdev_get_address(dpp->netdev),
+				dpp->auth_addr,
+				DPP_FRAME_AUTHENTICATION_REQUEST, hdr);
+	iov[0].iov_base =3D hdr;
+
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
+				dpp->peer_boot_hash, 32);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
+				dpp->own_boot_hash, 32);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_INITIATOR_PROTOCOL_KEY,
+				i_proto_key, dpp->key_len * 2);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
+
+	if (dpp->current_freq !=3D bss->frequency) {
+		uint8_t pair[2] =3D { 81,
+				band_freq_to_channel(bss->frequency, NULL) };
+
+		ptr +=3D dpp_append_attr(ptr, DPP_ATTR_CHANNEL, pair, 2);
+	}
+
+	ptr +=3D dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs,
+			ptr, sizeof(attrs), dpp->k1, dpp->key_len, 2,
+			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
+			DPP_ATTR_INITIATOR_CAPABILITIES, 1, &dpp->role);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+}
+
 static void dpp_roc_started(void *user_data)
 {
 	struct dpp_sm *dpp =3D user_data;
 =

 	/*
 	 * - If a configurator, nothing to do but wait for a request
+	 *   (unless multicast frame registration is unsupported in which case
+	 *   send an authenticate request now)
 	 * - If in the presence state continue sending announcements.
 	 * - If authenticating, and this is a result of a channel switch send
 	 *   the authenticate response now.
 	 */
-	if (dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
-		return;
 =

 	switch (dpp->state) {
 	case DPP_STATE_PRESENCE:
+		if (dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
+			return;
+
 		if (dpp->pending) {
 			struct l_dbus_message *reply =3D
 				l_dbus_message_new_method_return(dpp->pending);
@@ -1293,6 +1367,19 @@ static void dpp_roc_started(void *user_data)
 		dpp_presence_announce(dpp);
 		break;
 	case DPP_STATE_AUTHENTICATING:
+		/*
+		 * No multicast frame registration support, jump right into
+		 * sending auth frames. This diverges from the 2.0 spec, but in
+		 * reality the the main path nearly all drivers will hit.
+		 */
+		if (dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR) {
+			if (dpp->mcast_support)
+				return;
+
+			dpp_send_authenticate_request(dpp);
+			return;
+		}
+
 		if (dpp->new_freq) {
 			dpp->current_freq =3D dpp->new_freq;
 			dpp->new_freq =3D 0;
@@ -1550,9 +1637,6 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 =

 	/* Derive keys k2, ke, and R-Auth for authentication response */
 =

-	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
-					&dpp->own_proto_public);
-
 	n =3D dpp_derive_k2(dpp->peer_proto_public, dpp->proto_private, dpp->k2);
 	if (!n)
 		goto auth_request_failed;
@@ -1583,6 +1667,294 @@ auth_request_failed:
 	dpp_free_auth_data(dpp);
 }
 =

+static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
+{
+	uint8_t hdr[32];
+	struct iovec iov[2];
+	uint8_t attrs[256];
+	uint8_t *ptr =3D attrs;
+	uint8_t zero =3D 0;
+
+	iov[0].iov_len =3D dpp_build_header(netdev_get_address(dpp->netdev),
+					dpp->auth_addr,
+					DPP_FRAME_AUTHENTICATION_CONFIRM, hdr);
+	iov[0].iov_base =3D hdr;
+
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_STATUS, &zero, 1);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
+					dpp->peer_boot_hash, 32);
+
+	ptr +=3D dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs, ptr,
+			sizeof(attrs), dpp->ke, dpp->key_len, 1,
+			DPP_ATTR_INITIATOR_AUTH_TAG, dpp->key_len,
+			dpp->auth_tag);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+}
+
+static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
+					const uint8_t *body, size_t body_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	int status =3D -1;
+	const void *r_boot_hash =3D NULL;
+	const void *r_proto =3D NULL;
+	size_t r_proto_len =3D 0;
+	const void *wrapped =3D NULL;
+	size_t wrapped_len;
+	_auto_(l_free) uint8_t *unwrapped1 =3D NULL;
+	_auto_(l_free) uint8_t *unwrapped2 =3D NULL;
+	const void *r_nonce =3D NULL;
+	const void *i_nonce =3D NULL;
+	const void *r_auth =3D NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *r_proto_key =3D NULL;
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n =3D NULL;
+	const void *ad0 =3D body + 2;
+	const void *ad1 =3D body + 8;
+	uint64_t r_auth_derived[L_ECC_MAX_DIGITS];
+
+	l_debug("Authenticate response");
+
+	if (dpp->state !=3D DPP_STATE_AUTHENTICATING)
+		return;
+
+	if (dpp->role !=3D DPP_CAPABILITY_CONFIGURATOR)
+		return;
+
+	if (!dpp->freqs)
+		return;
+
+	if (memcmp(from, dpp->auth_addr, 6))
+		return;
+
+	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_STATUS:
+			if (len !=3D 1)
+				return;
+
+			status =3D l_get_u8(data);
+			break;
+		case DPP_ATTR_RESPONDER_BOOT_KEY_HASH:
+			r_boot_hash =3D data;
+			break;
+		case DPP_ATTR_RESPONDER_PROTOCOL_KEY:
+			r_proto =3D data;
+			r_proto_len =3D len;
+			break;
+		case DPP_ATTR_PROTOCOL_VERSION:
+			if (len !=3D 1 || l_get_u8(data) !=3D 2)
+				return;
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
+	if (status !=3D DPP_STATUS_OK || !r_boot_hash || !r_proto ) {
+		l_debug("Auth response bad status or missing attributes");
+		return;
+	}
+
+	r_proto_key =3D l_ecc_point_from_data(dpp->curve, L_ECC_POINT_TYPE_FULL,
+						r_proto, r_proto_len);
+	if (!r_proto_key) {
+		l_debug("Peers protocol key was invalid");
+		return;
+	}
+
+	n =3D dpp_derive_k2(r_proto_key, dpp->proto_private, dpp->k2);
+
+	unwrapped1 =3D dpp_unwrap_attr(ad0, 6, ad1, wrapped - 4 - ad1, dpp->k2,
+					dpp->key_len, wrapped, wrapped_len,
+					&wrapped_len);
+	if (!unwrapped1) {
+		l_debug("Failed to unwrap primary data");
+		return;
+	}
+
+	wrapped =3D NULL;
+
+	dpp_attr_iter_init(&iter, unwrapped1, wrapped_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_RESPONDER_NONCE:
+			if (len !=3D dpp->nonce_len)
+				return;
+
+			r_nonce =3D data;
+			break;
+		case DPP_ATTR_INITIATOR_NONCE:
+			if (len !=3D dpp->nonce_len)
+				return;
+
+			i_nonce =3D data;
+			break;
+		case DPP_ATTR_RESPONDER_CAPABILITIES:
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
+	if (!r_nonce || !i_nonce || !wrapped) {
+		l_debug("Wrapped data missing attributes");
+		return;
+	}
+
+	if (!dpp_derive_ke(i_nonce, r_nonce, dpp->m, n, dpp->ke)) {
+		l_debug("Failed to derive ke");
+		return;
+	}
+
+	unwrapped2 =3D dpp_unwrap_attr(NULL, 0, NULL, 0, dpp->ke, dpp->key_len,
+					wrapped, wrapped_len, &wrapped_len);
+	if (!unwrapped2) {
+		l_debug("Failed to unwrap secondary data");
+		return;
+	}
+
+	dpp_attr_iter_init(&iter, unwrapped2, wrapped_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_RESPONDER_AUTH_TAG:
+			if (len !=3D dpp->key_len)
+				return;
+
+			r_auth =3D data;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!r_auth) {
+		l_debug("R-Auth was not in secondary wrapped data");
+		return;
+	}
+
+	if (!dpp_derive_r_auth(i_nonce, r_nonce, dpp->nonce_len,
+				dpp->own_proto_public, r_proto_key,
+				dpp->peer_boot_public, r_auth_derived)) {
+		l_debug("Failed to derive r_auth");
+		return;
+	}
+
+	if (memcmp(r_auth, r_auth_derived, dpp->key_len)) {
+		l_debug("R-Auth did not verify");
+		return;
+	}
+
+	if (!dpp_derive_i_auth(r_nonce, i_nonce, dpp->nonce_len,
+				r_proto_key, dpp->own_proto_public,
+				dpp->peer_boot_public, dpp->auth_tag)) {
+		l_debug("Could not derive I-Auth");
+		return;
+	}
+
+	dpp->current_freq =3D dpp->new_freq;
+
+	dpp_send_authenticate_confirm(dpp);
+}
+
+static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
+						const uint8_t *from,
+						const uint8_t *body,
+						size_t body_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	const void *r_boot =3D NULL;
+	size_t r_boot_len =3D 0;
+	uint8_t hash[32];
+
+	l_debug("Presence announcement "MAC, MAC_STR(from));
+
+	/* Must be a configurator, in an initiator role, in PRESENCE state */
+	if (dpp->state !=3D DPP_STATE_PRESENCE)
+		return;
+
+	if (dpp->role !=3D DPP_CAPABILITY_CONFIGURATOR)
+		return;
+
+	if (!dpp->freqs)
+		return;
+
+	/*
+	 * The URI may not have contained a MAC address, if this announcement
+	 * verifies set auth_addr then.
+	 */
+	if (!l_memeqzero(dpp->auth_addr, 6) &&
+				memcmp(from, dpp->auth_addr, 6)) {
+		l_debug("Unexpected source "MAC" expected "MAC, MAC_STR(from),
+						MAC_STR(dpp->auth_addr));
+		return;
+	}
+
+	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_RESPONDER_BOOT_KEY_HASH:
+			r_boot =3D data;
+			r_boot_len =3D len;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!r_boot || r_boot_len !=3D 32) {
+		l_debug("No responder boot hash");
+		return;
+	}
+
+	/* Hash what we have for the peer and check its our enrollee */
+	dpp_hash(L_CHECKSUM_SHA256, hash, 2, "chirp", strlen("chirp"),
+			dpp->peer_asn1, dpp->peer_asn1_len);
+
+	if (memcmp(hash, r_boot, sizeof(hash))) {
+		l_debug("Peers boot hash did not match");
+		return;
+	}
+
+	/*
+	 * This is the peer we expected, save away the address and derive the
+	 * initial keys.
+	 */
+	memcpy(dpp->auth_addr, from, 6);
+
+	dpp->state =3D DPP_STATE_AUTHENTICATING;
+
+	dpp_send_authenticate_request(dpp);
+
+	/*
+	 * Should we wait for an ACK then go offchannel?
+	 */
+	if (dpp->current_freq !=3D dpp->new_freq)
+		dpp_start_offchannel(dpp, dpp->new_freq);
+}
+
 static void dpp_handle_frame(struct dpp_sm *dpp,
 				const struct mmpdu_header *frame,
 				const void *body, size_t body_len)
@@ -1603,6 +1975,9 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
 	case DPP_FRAME_AUTHENTICATION_REQUEST:
 		authenticate_request(dpp, frame->address_2, body, body_len);
 		break;
+	case DPP_FRAME_AUTHENTICATION_RESPONSE:
+		authenticate_response(dpp, frame->address_2, body, body_len);
+		break;
 	case DPP_FRAME_AUTHENTICATION_CONFIRM:
 		authenticate_confirm(dpp, frame->address_2, body, body_len);
 		break;
@@ -1610,6 +1985,10 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
 		dpp_handle_config_result_frame(dpp, frame->address_2,
 						body, body_len);
 		break;
+	case DPP_FRAME_PRESENCE_ANNOUNCEMENT:
+		dpp_handle_presence_announcement(dpp, frame->address_2,
+							body, body_len);
+		break;
 	default:
 		l_debug("Unhandled DPP frame %u", *ptr);
 		break;
@@ -1911,6 +2290,9 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 	dpp->state =3D DPP_STATE_PRESENCE;
 	dpp->role =3D DPP_CAPABILITY_ENROLLEE;
 =

+	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
+					&dpp->own_proto_public);
+
 	l_debug("DPP Start Enrollee: %s", dpp->uri);
 =

 	dpp->pending =3D l_dbus_message_ref(message);
@@ -1927,9 +2309,66 @@ static struct l_dbus_message *dpp_dbus_start_enrolle=
e(struct l_dbus *dbus,
 	return NULL;
 }
 =

-static struct l_dbus_message *dpp_dbus_start_configurator(struct l_dbus *d=
bus,
+/*
+ * Set up the configurator for an initiator role. The configurator
+ * will go offchannel to frequencies advertised by the enrollees URI or,
+ * if no channels are provided, use a default channel list.
+ */
+static bool dpp_configurator_start_presence(struct dpp_sm *dpp, const char=
 *uri)
+{
+	_auto_(l_free) uint32_t *freqs =3D NULL;
+	size_t freqs_len =3D 0;
+	struct dpp_uri_info *info;
+
+	info =3D dpp_parse_uri(uri);
+	if (!info)
+		return false;
+
+	/*
+	 * Very few drivers actually support registration of multicast frames.
+	 * This renders the presence procedure impossible on most drivers.
+	 * But not all is lost. If the URI contains the MAC and channel
+	 * info we an start going through channels sending auth requests which
+	 * is basically DPP 1.0. Otherwise DPP cannot start.
+	 */
+	if (!dpp->mcast_support &&
+				(l_memeqzero(info->mac, 6) || !info->freqs)) {
+		l_error("No multicast registration support, URI must contain "
+			"MAC and channel information");
+		dpp_free_uri_info(info);
+		return false;
+	}
+
+	if (!l_memeqzero(info->mac, 6))
+		memcpy(dpp->auth_addr, info->mac, 6);
+
+	if (info->freqs)
+		freqs =3D scan_freq_set_to_fixed_array(info->freqs, &freqs_len);
+
+	dpp->peer_boot_public =3D l_ecc_point_clone(info->boot_public);
+	dpp->peer_asn1 =3D dpp_point_to_asn1(info->boot_public,
+						&dpp->peer_asn1_len);
+
+	dpp_free_uri_info(info);
+
+	if (!dpp->peer_asn1) {
+		l_debug("Peer boot key did not convert to asn1");
+		return false;
+	}
+
+	dpp_hash(L_CHECKSUM_SHA256, dpp->peer_boot_hash, 1, dpp->peer_asn1,
+			dpp->peer_asn1_len);
+
+	dpp_start_presence(dpp, freqs, freqs_len);
+
+	return true;
+}
+
+static struct l_dbus_message *dpp_start_configurator_common(
+						struct l_dbus *dbus,
 						struct l_dbus_message *message,
-						void *user_data)
+						void *user_data,
+						bool responder)
 {
 	struct dpp_sm *dpp =3D user_data;
 	struct l_dbus_message *reply;
@@ -1938,6 +2377,7 @@ static struct l_dbus_message *dpp_dbus_start_configur=
ator(struct l_dbus *dbus,
 	struct network *network;
 	struct l_settings *settings;
 	struct handshake_state *hs =3D netdev_get_handshake(dpp->netdev);
+	const char *uri;
 =

 	/*
 	 * For now limit the configurator to only configuring enrollees to the
@@ -1961,13 +2401,33 @@ static struct l_dbus_message *dpp_dbus_start_config=
urator(struct l_dbus *dbus,
 	if (dpp->state !=3D DPP_STATE_NOTHING)
 		return dbus_error_busy(message);
 =

+	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
+					&dpp->own_proto_public);
+
+	dpp->state =3D DPP_STATE_PRESENCE;
+
+	if (!responder) {
+		if (!l_dbus_message_get_arguments(message, "s", &uri))
+			return dbus_error_invalid_args(message);
+
+		if (!dpp_configurator_start_presence(dpp, uri))
+			return dbus_error_invalid_args(message);
+
+		/* Since we have the peer's URI generate the keys now */
+		l_getrandom(dpp->i_nonce, dpp->nonce_len);
+
+		dpp->m =3D dpp_derive_k1(dpp->peer_boot_public,
+					dpp->proto_private, dpp->k1);
+
+		if (!dpp->mcast_support)
+			dpp->state =3D DPP_STATE_AUTHENTICATING;
+	} else
+		dpp->current_freq =3D bss->frequency;
+
 	dpp->uri =3D dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
 					netdev_get_address(dpp->netdev),
 					&bss->frequency, 1, NULL, NULL);
-
-	dpp->state =3D DPP_STATE_PRESENCE;
 	dpp->role =3D DPP_CAPABILITY_CONFIGURATOR;
-	dpp->current_freq =3D bss->frequency;
 	dpp->config =3D dpp_configuration_new(settings,
 						network_get_ssid(network),
 						hs->akm_suite);
@@ -1983,6 +2443,20 @@ static struct l_dbus_message *dpp_dbus_start_configu=
rator(struct l_dbus *dbus,
 	return reply;
 }
 =

+static struct l_dbus_message *dpp_dbus_start_configurator(struct l_dbus *d=
bus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	return dpp_start_configurator_common(dbus, message, user_data, true);
+}
+
+static struct l_dbus_message *dpp_dbus_configure_enrollee(struct l_dbus *d=
bus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	return dpp_start_configurator_common(dbus, message, user_data, false);
+}
+
 static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -2000,6 +2474,8 @@ static void dpp_setup_interface(struct l_dbus_interfa=
ce *interface)
 				dpp_dbus_start_enrollee, "s", "", "uri");
 	l_dbus_interface_method(interface, "StartConfigurator", 0,
 				dpp_dbus_start_configurator, "s", "", "uri");
+	l_dbus_interface_method(interface, "ConfigureEnrollee", 0,
+				dpp_dbus_configure_enrollee, "", "s", "uri");
 	l_dbus_interface_method(interface, "Stop", 0,
 				dpp_dbus_stop, "", "");
 }
-- =

2.34.1

--===============5698677403707817196==--

