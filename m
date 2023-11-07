Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072ED328BA
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8z1wEvU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7af52ee31so69885557b3.2
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699376798; x=1699981598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yti3rksEYxxgpIixPhuNQ+tSF0EdwsCqJ62LlD6CihQ=;
        b=Q8z1wEvUspE3vth57cHn72ZGH8931O9S8keg+fK22ioY6rhQJkHMqNv0/E5JVYzzIu
         TdkXNtTyewXbh89tGTYYyK2nlC2gaNfNioUEJuDlWhb3cA+UxzPxKx93kZKcZrU/+/mG
         yQ+AtUyQH/w0JJ3zOXlBJHepcWkvh/gpgBr/4i4w9enfpbUJOYJiyxq1eGgIbdb4qcBM
         NO/S+W2K5UFwdjUeAq3JYE12JQ0/CD+vYz9htKxSxa6P4/fIp3LnRQIQAvEvTF3I5Ucm
         96AXrof/lK5tT2LyaRuGUg1dDx1ZdwukrvkTaDmX1WCdfqaj89KhOGKSJNDkMjiSCR5x
         euiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699376798; x=1699981598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yti3rksEYxxgpIixPhuNQ+tSF0EdwsCqJ62LlD6CihQ=;
        b=I5SLdezL/8GiBbYjjO6waIIMSTv4CNdAcM32FeukIhOt37lvJ3BsDgIRyq62S9TClA
         WH59Z0evJTHTjtaGCu2f4k3DfrEfYphM+eu7Z/XPXx7axa+QlbvrdVtiJE7aWB/g1cfv
         nXTRWXQuy2+VFUAbF5ORal83qjujRHJu0YNTEcD8rljkG37/4WviPNodrLInN8BS3dh3
         mq6PPcKjSzf26WYvgw848oktLtZhKagoB2E301tkjLG9giP3Sk40bV0qkMTA4PMImGjY
         AijjSlU4OAsgpKzufr+sYqSStgLRYNhfVDHhlx0GKdt1h2BrEIeCILlLryW/JreqkmHC
         nAmQ==
X-Gm-Message-State: AOJu0YxpQFkLm+tMwCWzKlZJXGtOisY3TjJ+uV5l97rN2hOhVB4nh+hJ
	BA53GuxfpA0oWjl7/HIRuBPtpyrHyHQ=
X-Google-Smtp-Source: AGHT+IEzJhHy+OEh/fKrN0l/b/tCB6LIcSqdbO48MVGnUxPZX3HLR75KxuSsDyCIhj4ZZ7GNN2YxDA==
X-Received: by 2002:a81:570c:0:b0:5a7:b942:c3fe with SMTP id l12-20020a81570c000000b005a7b942c3femr13313830ywb.16.1699376797633;
        Tue, 07 Nov 2023 09:06:37 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z127-20020a814c85000000b005a7db2a0dddsm5790475ywa.3.2023.11.07.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:06:37 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/4] dpp: initial version of PKEX configurator support
Date: Tue,  7 Nov 2023 09:06:28 -0800
Message-Id: <20231107170629.1831655-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107170629.1831655-1-prestwoj@gmail.com>
References: <20231107170629.1831655-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PKEX configurator role is currently limited to being a responder.
When started the configurator will listen on its current operating
channel for a PKEX exchange request. Once received it and the
encrypted key is properly decrypted it treats this peer as the
enrollee and won't allow configurations from other peers unless
PKEX is restarted. The configurator will encrypt and send its
encrypted ephemeral key in the PKEX exchange response. The enrollee
then sends its encrypted bootstrapping key (as commit-reveal request)
then the same for the configurator (as commit-reveal response).

After this, PKEX authentication begins. The enrollee is expected to
send the authenticate request, since its the initiator.
---
 src/dpp.c | 504 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 503 insertions(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index 4b1c1233..86361ba0 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1887,7 +1887,8 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 	if (util_is_broadcast_address(from))
 		return;
 
-	if (dpp->state != DPP_STATE_PRESENCE)
+	if (dpp->state != DPP_STATE_PRESENCE &&
+				dpp->state != DPP_STATE_AUTHENTICATING)
 		return;
 
 	l_debug("authenticate request");
@@ -2746,6 +2747,436 @@ failed:
 	dpp_reset(dpp);
 }
 
+static void dpp_send_bad_group(struct dpp_sm *dpp, const uint8_t *addr)
+{
+	uint8_t hdr[32];
+	uint8_t attrs[256];
+	uint8_t *ptr = attrs;
+	uint16_t group;
+	uint8_t status = DPP_STATUS_BAD_GROUP;
+	struct iovec iov[2];
+	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
+
+	l_put_le16(l_ecc_curve_get_ike_group(dpp->curve), &group);
+
+	iov[0].iov_len = dpp_build_header(own_mac, addr,
+				DPP_FRAME_PKEX_XCHG_RESPONSE, hdr);
+	iov[0].iov_base = hdr;
+
+	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
+	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION,
+				&dpp->pkex_version, 1);
+	ptr += dpp_append_attr(ptr, DPP_ATTR_FINITE_CYCLIC_GROUP, &group, 2);
+
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = ptr - attrs;
+
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+}
+
+static void dpp_send_bad_code(struct dpp_sm *dpp, const uint8_t *addr)
+{
+	uint8_t hdr[32];
+	uint8_t attrs[256];
+	uint8_t *ptr = attrs;
+	uint8_t status = DPP_STATUS_BAD_CODE;
+	struct iovec iov[2];
+	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
+
+	iov[0].iov_len = dpp_build_header(own_mac, addr,
+				DPP_FRAME_PKEX_XCHG_RESPONSE, hdr);
+	iov[0].iov_base = hdr;
+
+	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
+	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION,
+				&dpp->pkex_version, 1);
+	if (dpp->pkex_id)
+		ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
+					dpp->pkex_id, strlen(dpp->pkex_id));
+
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = ptr - attrs;
+
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+}
+
+static void dpp_send_pkex_exchange_response(struct dpp_sm *dpp,
+						struct l_ecc_point *n)
+{
+	uint8_t hdr[32];
+	uint8_t attrs[256];
+	uint8_t *ptr = attrs;
+	uint64_t n_data[L_ECC_MAX_DIGITS * 2];
+	uint16_t group;
+	uint8_t status = DPP_STATUS_OK;
+	struct iovec iov[2];
+	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
+
+	l_put_le16(l_ecc_curve_get_ike_group(dpp->curve), &group);
+
+	iov[0].iov_len = dpp_build_header(own_mac, dpp->peer_addr,
+				DPP_FRAME_PKEX_XCHG_RESPONSE, hdr);
+	iov[0].iov_base = hdr;
+
+	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
+
+	if (dpp->pkex_id)
+		ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
+					dpp->pkex_id, strlen(dpp->pkex_id));
+
+	l_ecc_point_get_data(n, n_data, sizeof(n_data));
+
+	ptr += dpp_append_attr(ptr, DPP_ATTR_ENCRYPTED_KEY,
+				n_data, dpp->key_len * 2);
+
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = ptr - attrs;
+
+	dpp->state = DPP_STATE_PKEX_COMMIT_REVEAL;
+
+	dpp_pkex_property_changed_notify(dpp);
+
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+}
+
+static void dpp_process_pkex_exchange_request(struct dpp_sm *dpp,
+						struct l_ecc_point *m)
+{
+	_auto_(l_ecc_point_free) struct l_ecc_point *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *qr = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *k = NULL;
+	const uint8_t *own_addr = netdev_get_address(dpp->netdev);
+
+	/* Qi = H(MAC-Initiator | [identifier | ] code) * Pi */
+	qi = dpp_derive_qi(dpp->curve, dpp->pkex_key, dpp->pkex_id,
+				dpp->peer_addr);
+	if (!qi) {
+		l_debug("could not derive Qi");
+		return;
+	}
+
+	/* X' = M - Qi */
+	dpp->y_or_x = l_ecc_point_new(dpp->curve);
+
+	l_ecc_point_inverse(qi);
+	l_ecc_point_add(dpp->y_or_x, m, qi);
+
+	/*
+	 * "The resulting ephemeral key, denoted X’, is checked whether it is
+	 * the point-at-infinity. If it is not valid, the protocol silently
+	 * fails"
+	 */
+	if (l_ecc_point_is_infinity(dpp->y_or_x)) {
+		l_debug("X' is at infinity, ignore message");
+		dpp_reset(dpp);
+		return;
+	}
+
+	qr = dpp_derive_qr(dpp->curve, dpp->pkex_key, dpp->pkex_id, own_addr);
+	if (!qr || l_ecc_point_is_infinity(qr)) {
+		l_debug("Qr did not derive");
+		l_ecc_point_free(dpp->y_or_x);
+		dpp->y_or_x = NULL;
+		goto bad_code;
+	}
+
+	/*
+	 * "The Responder then generates a random ephemeral keypair, y/Y,
+	 * encrypts Y with Qr to obtain the result, denoted N."
+	 */
+	l_ecdh_generate_key_pair(dpp->curve, &dpp->pkex_private,
+					&dpp->pkex_public);
+
+	/* N = Y + Qr */
+	n = l_ecc_point_new(dpp->curve);
+
+	l_ecc_point_add(n, dpp->pkex_public, qr);
+
+	/* K = y * X' */
+
+	k = l_ecc_point_new(dpp->curve);
+
+	l_ecc_point_multiply(k, dpp->pkex_private, dpp->y_or_x);
+
+	/* z = HKDF(<>, info | M.x | N.x | code, K.x) */
+	dpp_derive_z(dpp->peer_addr, own_addr, n, m, k, dpp->pkex_key,
+				dpp->pkex_id, dpp->z, &dpp->z_len);
+
+	dpp_send_pkex_exchange_response(dpp, n);
+
+	return;
+
+bad_code:
+	dpp_send_bad_code(dpp, dpp->peer_addr);
+	return;
+}
+
+static void dpp_handle_pkex_exchange_request(struct dpp_sm *dpp,
+					const uint8_t *from,
+					const uint8_t *body, size_t body_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	uint8_t version = 0;
+	uint16_t group = 0;
+	const char *id = NULL;
+	size_t id_len = 0;
+	const void *key = NULL;
+	size_t key_len = 0;
+	_auto_(l_ecc_point_free) struct l_ecc_point *m = NULL;
+
+	l_debug("PKEX exchange request "MAC, MAC_STR(from));
+
+	if (dpp->state != DPP_STATE_PKEX_EXCHANGE)
+		return;
+
+	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
+		return;
+
+	if (!l_memeqzero(dpp->peer_addr, 6)) {
+		l_debug("Already configuring enrollee, ignoring");
+		return;
+	}
+
+	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_PROTOCOL_VERSION:
+			if (len != 1)
+				return;
+
+			version = l_get_u8(data);
+			break;
+		case DPP_ATTR_FINITE_CYCLIC_GROUP:
+			if (len != 2)
+				return;
+
+			group = l_get_le16(data);
+			break;
+		case DPP_ATTR_CODE_IDENTIFIER:
+			id = (char *) data;
+			id_len = len;
+			break;
+		case DPP_ATTR_ENCRYPTED_KEY:
+			key = data;
+			key_len = len;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!key || !group) {
+		l_debug("initiator did not provide group or key, ignoring");
+		return;
+	}
+
+	if (group != l_ecc_curve_get_ike_group(dpp->curve)) {
+		l_debug("initiator is not using the same group");
+		goto bad_group;
+	}
+
+	/*
+	 * If the group isn't the same the key length won't match, so check
+	 * this here after we've determined the groups are equal
+	 */
+	if (key_len != dpp->key_len * 2) {
+		l_debug("Unexpected encrypted key length");
+		return;
+	}
+
+	if (version && version != dpp->pkex_version) {
+		l_debug("initiator is not using the same version, ignoring");
+		return;
+	}
+
+	if (dpp->pkex_id) {
+		if (!id || !dpp_check_pkex_identifier(id) ||
+					id_len != strlen(dpp->pkex_id) ||
+					strncmp(dpp->pkex_id, id, id_len)) {
+			l_debug("mismatch identifier, ignoring");
+			return;
+		}
+	}
+
+	m = l_ecc_point_from_data(dpp->curve, L_ECC_POINT_TYPE_FULL,
+					key, key_len);
+	if (!m) {
+		l_debug("could not parse key from initiator, ignoring");
+		return;
+	}
+
+	memcpy(dpp->peer_addr, from, 6);
+
+	dpp_process_pkex_exchange_request(dpp, m);
+
+	return;
+
+bad_group:
+	dpp_send_bad_group(dpp, from);
+}
+
+static void dpp_send_commit_reveal_response(struct dpp_sm *dpp,
+						const uint8_t *v, size_t v_len)
+{
+	uint8_t hdr[32];
+	uint8_t attrs[256];
+	uint8_t *ptr = attrs;
+	uint8_t one = 1;
+	struct iovec iov[2];
+	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
+	uint8_t b_pub[L_ECC_POINT_MAX_BYTES];
+	size_t b_len;
+
+	b_len = l_ecc_point_get_data(dpp->boot_public, b_pub, sizeof(b_pub));
+
+
+	iov[0].iov_len = dpp_build_header(own_mac, dpp->peer_addr,
+				DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE, hdr);
+	iov[0].iov_base = hdr;
+
+	ptr += dpp_append_wrapped_data(hdr + 26, 6, &one, 1, ptr,
+			sizeof(attrs), dpp->z, dpp->z_len, 2,
+			DPP_ATTR_BOOTSTRAPPING_KEY, b_len, b_pub,
+			DPP_ATTR_RESPONDER_AUTH_TAG, v_len, v);
+
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = ptr - attrs;
+
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+}
+
+static void dpp_handle_pkex_commit_reveal_request(struct dpp_sm *dpp,
+					const uint8_t *from,
+					const uint8_t *body, size_t body_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	const void *wrapped = NULL;
+	size_t wrapped_len = 0;
+	_auto_(l_free) uint8_t *unwrapped = NULL;
+	size_t unwrapped_len;
+	uint8_t zero = 0;
+	const void *key = 0;
+	size_t key_len = 0;
+	const void *i_auth = NULL;
+	size_t i_auth_len = 0;
+	_auto_(l_ecc_point_free) struct l_ecc_point *j = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
+	uint8_t u[L_ECC_SCALAR_MAX_BYTES];
+	size_t u_len = 0;
+	uint8_t v[L_ECC_SCALAR_MAX_BYTES];
+	size_t v_len = 0;
+	const uint8_t *own_addr = netdev_get_address(dpp->netdev);
+
+	l_debug("PKEX commit-reveal request "MAC, MAC_STR(from));
+
+	if (dpp->state != DPP_STATE_PKEX_COMMIT_REVEAL)
+		return;
+
+	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
+		return;
+
+	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_WRAPPED_DATA:
+			wrapped = data;
+			wrapped_len = len;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!wrapped) {
+		l_debug("No wrapped data");
+		return;
+	}
+
+	unwrapped = dpp_unwrap_attr(body + 2, 6, &zero, 1, dpp->z, dpp->z_len,
+					wrapped, wrapped_len, &unwrapped_len);
+	if (!unwrapped) {
+		l_debug("Failed to unwrap attributes");
+		return;
+	}
+
+	dpp_attr_iter_init(&iter, unwrapped, unwrapped_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_BOOTSTRAPPING_KEY:
+			if (len != dpp->key_len * 2)
+				return;
+
+			key = data;
+			key_len = len;
+			break;
+		case DPP_ATTR_INITIATOR_AUTH_TAG:
+			if (len != 32)
+				return;
+
+			i_auth = data;
+			i_auth_len = len;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!key || !i_auth) {
+		l_debug("missing attributes");
+		return;
+	}
+
+	dpp->peer_boot_public = l_ecc_point_from_data(dpp->curve,
+					L_ECC_POINT_TYPE_FULL, key, key_len);
+	if (!dpp->peer_boot_public) {
+		l_debug("peers boostrapping key did not validate");
+		goto failed;
+	}
+
+	/* J' = y * A' */
+	j = l_ecc_point_new(dpp->curve);
+
+	l_ecc_point_multiply(j, dpp->pkex_private, dpp->peer_boot_public);
+
+	dpp_derive_u(j, dpp->peer_addr, dpp->peer_boot_public, dpp->pkex_public,
+			dpp->y_or_x, u, &u_len);
+
+	if (memcmp(u, i_auth, i_auth_len)) {
+		l_debug("Initiator auth tag did not verify");
+		goto failed;
+	}
+
+	/* L' = x * B' */
+	l = l_ecc_point_new(dpp->curve);
+
+	l_ecc_point_multiply(l, dpp->boot_private, dpp->y_or_x);
+
+	if (!dpp_derive_v(l, own_addr, dpp->boot_public, dpp->y_or_x,
+				dpp->pkex_public, v, &v_len)) {
+		l_debug("Failed to derive v");
+		goto failed;
+	}
+
+	dpp_send_commit_reveal_response(dpp, v, v_len);
+
+	dpp_pkex_start_authentication(dpp);
+
+	return;
+
+failed:
+	dpp_reset(dpp);
+}
+
 static void dpp_handle_frame(struct dpp_sm *dpp,
 				const struct mmpdu_header *frame,
 				const void *body, size_t body_len)
@@ -2788,6 +3219,14 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
 		dpp_handle_pkex_commit_reveal_response(dpp, frame->address_2,
 							body, body_len);
 		break;
+	case DPP_FRAME_PKEX_VERSION1_XCHG_REQUST:
+		dpp_handle_pkex_exchange_request(dpp, frame->address_2, body,
+							body_len);
+		break;
+	case DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST:
+		dpp_handle_pkex_commit_reveal_request(dpp, frame->address_2,
+							body, body_len);
+		break;
 	default:
 		l_debug("Unhandled DPP frame %u", *ptr);
 		break;
@@ -3492,6 +3931,67 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 
+static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
+					const char *key, const char *identifier,
+					struct l_dbus_message *message)
+{
+	struct handshake_state *hs = netdev_get_handshake(dpp->netdev);
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	struct network *network = station_get_connected_network(station);
+	struct scan_bss *bss = station_get_connected_bss(station);
+	const struct l_settings *settings;
+
+	if (dpp->state != DPP_STATE_NOTHING)
+		return dbus_error_busy(message);
+
+	if (!network || !bss)
+		return dbus_error_not_connected(message);
+
+	settings = network_get_settings(network);
+	if (!settings) {
+		l_debug("No settings for network, is this a known network?");
+		return dbus_error_not_configured(message);
+	}
+
+	if (identifier)
+		dpp->pkex_id = l_strdup(identifier);
+
+	if (key)
+		dpp->pkex_key = l_strdup(key);
+
+	dpp->role = DPP_CAPABILITY_CONFIGURATOR;
+	dpp->state = DPP_STATE_PKEX_EXCHANGE;
+	dpp->current_freq = bss->frequency;
+	dpp->pkex_version = 1;
+	dpp->config = dpp_configuration_new(network_get_settings(network),
+						network_get_ssid(network),
+						hs->akm_suite);
+
+	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
+	dpp_pkex_property_changed_notify(dpp);
+
+	l_debug("Starting PKEX configurator for single enrollee");
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static struct l_dbus_message *dpp_dbus_pkex_configure_enrollee(
+						struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *key;
+	const char *id;
+
+	l_debug("");
+
+	if (!dpp_parse_pkex_args(message, &key, &id))
+		return dbus_error_invalid_args(message);
+
+	return dpp_start_pkex_configurator(dpp, key, id, message);
+}
+
 static void dpp_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "StartEnrollee", 0,
@@ -3528,6 +4028,8 @@ static void dpp_setup_pkex_interface(struct l_dbus_interface *interface)
 			dpp_dbus_pkex_start_enrollee, "", "a{sv}", "args");
 	l_dbus_interface_method(interface, "Stop", 0,
 			dpp_dbus_pkex_stop, "", "");
+	l_dbus_interface_method(interface, "ConfigureEnrollee", 0,
+			dpp_dbus_pkex_configure_enrollee, "", "a{sv}", "args");
 
 	l_dbus_interface_property(interface, "Started", 0, "b",
 			dpp_pkex_get_started, NULL);
-- 
2.25.1

