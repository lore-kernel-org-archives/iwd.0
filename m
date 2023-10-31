Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073820332
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeL00ADj"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7789cc5c8ccso11751585a.0
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778089; x=1699382889; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUZym1BOEGPM5UV9nE1+c01dkvpGGmKhausHLDpKdGc=;
        b=JeL00ADjKZs0Xj3yht6alW34q8Az+f3jLRX+BHhcTnsmuRAJof00j2uVZFQYSLds7x
         XOeC9t7b/mJAu/1l5xA7DXFwoxu+PRTUAub1sH6hl900umNzNKO0d23AMkol1dCiKnwN
         UgwBasfxFEaXzXByBR37c6/Lo9OunOyb2r4DVB9dpM1RJLr4gU4sSK4wq9k8doW57hP/
         ZW/2WuJOvpmJ/xkDhMn7ky3MhSO+mTG2Hb3tuJ49Fg4C6DP/aVIe+IdjttIkx+3qm62D
         kSuGlaaO24QCzJuwQVAsgBVlRMKOHo404k0U2t5oWYHDZ1Vz6DuwQKtEf13mtRqIkTB6
         ISJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778089; x=1699382889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUZym1BOEGPM5UV9nE1+c01dkvpGGmKhausHLDpKdGc=;
        b=DGTzitSFkXZ0x9VskKJoLpcvPnbve8lW0scL6XSvyoVetW0Xr1dSOzK7rpB/lvhKY1
         O+1r6DhttmVMlZqKyf2l61YarLUL33zoWF3JoJTyTDdGHkgOTl5xNGFioe28akS63y0b
         wVam+8gjphULoUZoSNlZ86PQjec/E3sPjqWSWcq8Y4OiFhTAe/HIzjpmb1QVp+NSvRwh
         B7EXK/CkQz8+xTpGJdNSB+MMA0SS+Wiml2hb9R2rzlgI6DoBGFz/gsq0y/+aDrUFs3n3
         Ob5tcAMZLXmZnUYgxQCvdNwz0SCrhDTHtgj+4htzVmETK02lOgIm7/DcZavRmeYWylEa
         AZIA==
X-Gm-Message-State: AOJu0Yy2nlSVxWdL90EeG20CbB/DiK2Y24/oEuKaNErMqmAYNaZwUYYi
	imQ5LXmjqUZpijf/uZko1jSl19TKcXw=
X-Google-Smtp-Source: AGHT+IEYm1wGQ3A8+7j29UD6XUuB/biqjWBvxl7aMmGE48dorucLSXQUs8a0OhPmm5ziW2mjLyoPkA==
X-Received: by 2002:a05:620a:3905:b0:76c:ea67:38e4 with SMTP id qr5-20020a05620a390500b0076cea6738e4mr5836950qkn.12.1698778089384;
        Tue, 31 Oct 2023 11:48:09 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:48:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 9/9] dpp: initial version of PKEX configurator support
Date: Tue, 31 Oct 2023 11:47:50 -0700
Message-Id: <20231031184750.722404-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184750.722404-1-prestwoj@gmail.com>
References: <20231031184750.722404-1-prestwoj@gmail.com>
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
 src/dpp.c | 640 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 635 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 8b47be5c..e48d695b 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -164,6 +164,7 @@ struct dpp_sm {
 	char *pkex_id;
 	char *pkex_key;
 	uint8_t pkex_version;
+	struct l_ecc_point *peer_encr_key;
 	struct l_ecc_point *pkex_m;
 	/* Ephemeral key Y' or X' for enrollee or configurator */
 	struct l_ecc_point *y_or_x;
@@ -314,6 +315,26 @@ static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
 	return ret;
 }
 
+static void dpp_free_pending_pkex_data(struct dpp_sm *dpp)
+{
+	if (dpp->agent && dpp->agent->pending_id) {
+		l_dbus_cancel(dbus_get_bus(), dpp->agent->pending_id);
+		dpp->agent->pending_id = 0;
+	}
+
+	if (dpp->pkex_id) {
+		l_free(dpp->pkex_id);
+		dpp->pkex_id = NULL;
+	}
+
+	if (dpp->peer_encr_key) {
+		l_ecc_point_free(dpp->peer_encr_key);
+		dpp->peer_encr_key = NULL;
+	}
+
+	memset(dpp->peer_addr, 0, sizeof(dpp->peer_addr));
+}
+
 static void dpp_free_auth_data(struct dpp_sm *dpp)
 {
 	if (dpp->own_proto_public) {
@@ -431,10 +452,7 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->pkex_key = NULL;
 	}
 
-	if (dpp->pkex_id) {
-		l_free(dpp->pkex_id);
-		dpp->pkex_id = NULL;
-	}
+	dpp_free_pending_pkex_data(dpp);
 
 	dpp_free_auth_data(dpp);
 
@@ -1818,6 +1836,18 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 
 	switch (dpp->state) {
 	case DPP_STATE_PKEX_EXCHANGE:
+		if (dpp->role != DPP_CAPABILITY_CONFIGURATOR || !dpp->agent)
+			break;
+
+		/*
+		 * We have a pending agent request but it did not arrive in
+		 * time, we cant assume the enrollee will be waiting around
+		 * for our response so cancel the request and continue waiting
+		 * for another request
+		 */
+		if (dpp->agent->pending_id)
+			dpp_free_pending_pkex_data(dpp);
+		/* Fall through */
 	case DPP_STATE_PRESENCE:
 		break;
 	case DPP_STATE_NOTHING:
@@ -1905,7 +1935,8 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 	if (util_is_broadcast_address(from))
 		return;
 
-	if (dpp->state != DPP_STATE_PRESENCE)
+	if (dpp->state != DPP_STATE_PRESENCE &&
+				dpp->state != DPP_STATE_AUTHENTICATING)
 		return;
 
 	l_debug("authenticate request");
@@ -2764,6 +2795,516 @@ failed:
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
+static void dpp_pkex_agent_reply(struct l_dbus_message *message,
+					void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *error, *text;
+	const char *code;
+
+	dpp->agent->pending_id = 0;
+
+	l_debug("SharedCodeAgent %s path %s replied", dpp->agent->owner,
+			dpp->agent->path);
+
+	if (l_dbus_message_get_error(message, &error, &text)) {
+		l_error("RequestSharedCode(%s) returned %s(\"%s\")",
+				dpp->pkex_id, error, text);
+		goto reset;
+	}
+
+	if (!l_dbus_message_get_arguments(message, "s", &code)) {
+		l_debug("Invalid arguments, check SharedCodeAgent!");
+		goto reset;
+	}
+
+	dpp->pkex_key = l_strdup(code);
+	dpp_process_pkex_exchange_request(dpp, dpp->peer_encr_key);
+
+	return;
+
+reset:
+	dpp_free_pending_pkex_data(dpp);
+}
+
+static bool dpp_pkex_agent_request(struct dpp_sm *dpp)
+{
+	struct l_dbus_message *msg;
+
+	if (!dpp->agent)
+		return false;
+
+	if (L_WARN_ON(dpp->agent->pending_id))
+		return false;
+
+	msg = l_dbus_message_new_method_call(dbus_get_bus(),
+						dpp->agent->owner,
+						dpp->agent->path,
+						IWD_SHARED_CODE_AGENT_INTERFACE,
+						"RequestSharedCode");
+	l_dbus_message_set_arguments(msg, "s", dpp->pkex_id);
+
+
+	dpp->agent->pending_id = l_dbus_send_with_reply(dbus_get_bus(),
+							msg,
+							dpp_pkex_agent_reply,
+							dpp, NULL);
+	return dpp->agent->pending_id != 0;
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
+	if (!dpp->pkex_key) {
+		if (!id) {
+			l_debug("Configurator started with agent but enrollee "
+				"sent no identifier, ignoring");
+			return;
+		}
+
+		dpp->pkex_id = l_strndup(id, id_len);
+
+		/* Need to obtain code from agent */
+		if (!dpp_pkex_agent_request(dpp)) {
+			l_debug("Failed to request code from agent!");
+			dpp_free_pending_pkex_data(dpp);
+			return;
+		}
+
+		/* Save the encrypted key/identifier for the agent callback */
+
+		dpp->peer_encr_key = l_steal_ptr(m);
+
+		return;
+	}
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
@@ -2806,6 +3347,14 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
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
@@ -3508,6 +4057,83 @@ invalid_args:
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
+	if (dpp->pkex_key)
+		l_debug("Starting PKEX configurator for single enrollee");
+	else
+		l_debug("Starting PKEX configurator with agent");
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
+static struct l_dbus_message *dpp_dbus_pkex_start_configurator(
+						struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	if (!dpp->agent)
+		return dbus_error_no_agent(message);
+
+	return dpp_start_pkex_configurator(dpp, NULL, NULL, message);
+}
+
 static void dpp_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "StartEnrollee", 0,
@@ -3599,6 +4225,10 @@ static void dpp_setup_pkex_interface(struct l_dbus_interface *interface)
 			dpp_dbus_pkex_unregister_agent, "", "");
 	l_dbus_interface_method(interface, "StartEnrollee", 0,
 			dpp_dbus_pkex_start_enrollee, "", "a{sv}", "args");
+	l_dbus_interface_method(interface, "ConfigureEnrollee", 0,
+			dpp_dbus_pkex_configure_enrollee, "", "a{sv}", "args");
+	l_dbus_interface_method(interface, "StartConfigurator", 0,
+			dpp_dbus_pkex_start_configurator, "", "");
 	l_dbus_interface_method(interface, "Stop", 0, dpp_dbus_stop, "", "");
 
 	l_dbus_interface_property(interface, "Started", 0, "b",
-- 
2.25.1

