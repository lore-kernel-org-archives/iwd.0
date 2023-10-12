Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A83C6B0
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JINzPnbd"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c9de3f66e5so9935825ad.3
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140931; x=1697745731; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLiLyDe69Ilf4v7vlhUvsxckLsd0nEMIiqeFAS7xK08=;
        b=JINzPnbdxFbcMZV0ehpjTZ425QT0VmEnDRGaSiydFZlupp+eh+yPwxTtyl0Rvalp55
         Z2teUH2XR3YMjlmkH9Bs4gVT8Q+BwDNy+6Y5EoRsoa+q3A45YSx+VgXPQeG8LXqRBg8V
         mAQXytQQsJkuP1Vh+KiJy0hUWudnFrXSaAPbgD8UtXo13WikoT4/JrIhDopQBnZI855G
         mCi4g/PgGpliggMi1Cz6br75caND7V2xlc+M74sX80ywYI8A5niTBjfQ/WhKjk9tVBgk
         f3NrbHz3K9QJvevXjKkLmAD3hf/R7fcz/NTKrF/zIuUcqhsfTKAJsB9yqyUP3wJGbMHB
         J8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140931; x=1697745731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLiLyDe69Ilf4v7vlhUvsxckLsd0nEMIiqeFAS7xK08=;
        b=vKWceDFIvqjzcQfC/gtRqefDyRk4dkYZN6Nff3za7LwF9SR8YAFlhkUrGBvR00uVkr
         8kVniyx2rHAtjxjl6zolSVMgtpdWCjmMX72TZyD9NOAdEMdZ7b/v+4bCaFfjXcBOZ66B
         ogpUkIMtWXbR0RcVoN1UhbNSV+gvNx308sCZOe+X9FKC8dYQx3a62MbZ5kEBfN4yJFli
         EwMC2VawVIoEylXToxdh5n8qOQIyXp+MQlhVH/4kBxrTjWRJbUfSZYX8jHZsecMuTFx5
         TMUhdZGczGlYekZ8WNqaXtMniafuq8omFhyDKwe9b4bFYK6rBKMi5bn5YlxudMXPLi1E
         GYIQ==
X-Gm-Message-State: AOJu0YzESS7kEkHHrjY2glpaLbvPG9XNDYYW1lTYAHENgmIZcjfLKZjH
	VGEHB3qSVbQeQHVNRliLD12ny/S9ecY=
X-Google-Smtp-Source: AGHT+IE1hxnp8aB1lYY3Xqfa+6WgMJJyux/tRTh0e8u9ZDZGamzgoGFHJdIMpSZTCuKZ+xLzAopa/w==
X-Received: by 2002:a17:902:dac9:b0:1c7:5f18:d125 with SMTP id q9-20020a170902dac900b001c75f18d125mr28245039plx.27.1697140930891;
        Thu, 12 Oct 2023 13:02:10 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 17/21] dpp: initial version of PKEX enrollee support
Date: Thu, 12 Oct 2023 13:01:46 -0700
Message-Id: <20231012200150.338401-18-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the initial support for PKEX enrollees acting as the
initiator. A PKEX initiator starts the protocol by broadcasting
the PKEX exchange request. This request contains a key encrypted
with the pre-shared PKEX code. If accepted the peer sends back
the exchange response with its own encrypted key. The enrollee
decrypts this and performs some crypto/hashing in order to establish
an ephemeral key used to encrypt its own boostrapping key. The
boostrapping key is encrypted and sent to the peer in the PKEX
commit-reveal request. The peer then does the same thing, encrypting
its own bootstrapping key and sending to the initiator as the
PKEX commit-reveal response.

After this, both peers have exchanged their boostrapping keys
securely and can begin DPP authentication, then configuration.

For now the enrollee will only iterate the default channel list
from the Easy Connect spec. Future upates will need to include some
way of discovering non-default channel configurators, but the
protocol needs to be ironed out first.
---
 src/dpp.c | 745 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 742 insertions(+), 3 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index fb025ac3..de9c64ce 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -69,6 +69,8 @@ static uint8_t dpp_prefix[] = { 0x04, 0x09, 0x50, 0x6f, 0x9a, 0x1a, 0x01 };
 enum dpp_state {
 	DPP_STATE_NOTHING,
 	DPP_STATE_PRESENCE,
+	DPP_STATE_PKEX_EXCHANGE,
+	DPP_STATE_PKEX_COMMIT_REVEAL,
 	DPP_STATE_AUTHENTICATING,
 	DPP_STATE_CONFIGURING,
 };
@@ -146,19 +148,66 @@ struct dpp_sm {
 
 	struct l_dbus_message *pending;
 
+	/* PKEX-specific values */
+	char *pkex_id;
+	char *pkex_key;
+	uint8_t pkex_version;
+	struct l_ecc_point *pkex_m;
+	/* Ephemeral key Y' or X' for enrollee or configurator */
+	struct l_ecc_point *y_or_x;
+	/* Ephemeral key pair y/Y or x/X */
+	struct l_ecc_point *pkex_public;
+	struct l_ecc_scalar *pkex_private;
+	uint8_t z[L_ECC_SCALAR_MAX_BYTES];
+	size_t z_len;
+	uint8_t u[L_ECC_SCALAR_MAX_BYTES];
+	size_t u_len;
+
 	bool mcast_support : 1;
 	bool roc_started : 1;
 	bool channel_switch : 1;
 	bool mutual_auth : 1;
 };
 
+static bool dpp_pkex_get_started(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	bool started = false;
+
+	switch (dpp->state) {
+	case DPP_STATE_PKEX_EXCHANGE:
+	case DPP_STATE_PKEX_COMMIT_REVEAL:
+		started = true;
+		break;
+	default:
+		break;
+	}
+
+	l_dbus_message_builder_append_basic(builder, 'b', &started);
+
+	return true;
+}
+
 static bool dpp_get_started(struct l_dbus *dbus,
 				struct l_dbus_message *message,
 				struct l_dbus_message_builder *builder,
 				void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
-	bool started = (dpp->state != DPP_STATE_NOTHING);
+	bool started = false;
+
+	switch (dpp->state) {
+	case DPP_STATE_PRESENCE:
+	case DPP_STATE_AUTHENTICATING:
+	case DPP_STATE_CONFIGURING:
+		started = true;
+		break;
+	default:
+		break;
+	}
 
 	l_dbus_message_builder_append_basic(builder, 'b', &started);
 
@@ -198,7 +247,9 @@ static bool dpp_get_uri(struct l_dbus *dbus,
 {
 	struct dpp_sm *dpp = user_data;
 
-	if (dpp->state == DPP_STATE_NOTHING)
+	if (dpp->state == DPP_STATE_NOTHING ||
+			dpp->state == DPP_STATE_PKEX_EXCHANGE ||
+			dpp->state == DPP_STATE_PKEX_COMMIT_REVEAL)
 		return false;
 
 	l_dbus_message_builder_append_basic(builder, 's', dpp->uri);
@@ -217,6 +268,16 @@ static void dpp_property_changed_notify(struct dpp_sm *dpp)
 				"URI");
 }
 
+static void dpp_pkex_property_changed_notify(struct dpp_sm *dpp)
+{
+	const char *path = netdev_get_path(dpp->netdev);
+
+	l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_PKEX_INTERFACE,
+				"Started");
+	l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_PKEX_INTERFACE,
+				"Role");
+}
+
 static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
 				size_t *out_len)
 {
@@ -267,6 +328,27 @@ static void dpp_free_auth_data(struct dpp_sm *dpp)
 		l_ecc_scalar_free(dpp->m);
 		dpp->m = NULL;
 	}
+
+	if (dpp->pkex_m) {
+		l_ecc_point_free(dpp->pkex_m);
+		dpp->pkex_m = NULL;
+	}
+
+	if (dpp->y_or_x) {
+		l_ecc_point_free(dpp->y_or_x);
+		dpp->y_or_x = NULL;
+	}
+
+	if (dpp->pkex_public) {
+		l_ecc_point_free(dpp->pkex_public);
+		dpp->pkex_public = NULL;
+	}
+
+	if (dpp->pkex_private) {
+		l_ecc_scalar_free(dpp->pkex_private);
+		dpp->pkex_private = NULL;
+	}
+
 }
 
 static void dpp_reset(struct dpp_sm *dpp)
@@ -328,10 +410,24 @@ static void dpp_reset(struct dpp_sm *dpp)
 	explicit_bzero(dpp->k1, dpp->key_len);
 	explicit_bzero(dpp->k2, dpp->key_len);
 	explicit_bzero(dpp->auth_tag, dpp->key_len);
+	explicit_bzero(dpp->z, dpp->key_len);
+	explicit_bzero(dpp->u, dpp->u_len);
+
+	if (dpp->pkex_key) {
+		explicit_bzero(dpp->pkex_key, strlen(dpp->pkex_key));
+		l_free(dpp->pkex_key);
+		dpp->pkex_key = NULL;
+	}
+
+	if (dpp->pkex_id) {
+		l_free(dpp->pkex_id);
+		dpp->pkex_id = NULL;
+	}
 
 	dpp_free_auth_data(dpp);
 
 	dpp_property_changed_notify(dpp);
+	dpp_pkex_property_changed_notify(dpp);
 }
 
 static void dpp_free(struct dpp_sm *dpp)
@@ -1494,6 +1590,71 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 	return true;
 }
 
+static void dpp_send_pkex_exchange_request(struct dpp_sm *dpp)
+{
+	uint8_t hdr[32];
+	uint8_t attrs[256];
+	uint8_t *ptr = attrs;
+	uint64_t m_data[L_ECC_MAX_DIGITS * 2];
+	uint16_t group;
+	struct iovec iov[2];
+	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
+
+	l_put_le16(l_ecc_curve_get_ike_group(dpp->curve), &group);
+
+	iov[0].iov_len = dpp_build_header(own_mac, broadcast,
+				DPP_FRAME_PKEX_VERSION1_XCHG_REQUST, hdr);
+	iov[0].iov_base = hdr;
+
+	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION,
+				&dpp->pkex_version, 1);
+	ptr += dpp_append_attr(ptr, DPP_ATTR_FINITE_CYCLIC_GROUP,
+				&group, 2);
+
+	if (dpp->pkex_id)
+		ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
+					dpp->pkex_id, strlen(dpp->pkex_id));
+
+	l_ecc_point_get_data(dpp->pkex_m, m_data, sizeof(m_data));
+
+	ptr += dpp_append_attr(ptr, DPP_ATTR_ENCRYPTED_KEY,
+				m_data, dpp->key_len * 2);
+
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = ptr - attrs;
+
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+}
+
+static void dpp_send_commit_reveal_request(struct dpp_sm *dpp)
+{
+	struct iovec iov[2];
+	uint8_t hdr[41];
+	uint8_t attrs[512];
+	uint8_t *ptr = attrs;
+	uint8_t zero = 0;
+	uint8_t a_pub[L_ECC_POINT_MAX_BYTES];
+	ssize_t a_len;
+
+	a_len = l_ecc_point_get_data(dpp->boot_public, a_pub, sizeof(a_pub));
+
+	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
+					dpp->peer_addr,
+					DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST,
+					hdr);
+	iov[0].iov_base = hdr;
+
+	ptr += dpp_append_wrapped_data(hdr + 26, 6, &zero, 1, ptr,
+			sizeof(attrs), dpp->z, dpp->z_len, 2,
+			DPP_ATTR_BOOTSTRAPPING_KEY, a_len, a_pub,
+			DPP_ATTR_INITIATOR_AUTH_TAG, dpp->u_len, dpp->u);
+
+	iov[1].iov_base = attrs;
+	iov[1].iov_len = ptr - attrs;
+
+	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+}
+
 static void dpp_roc_started(void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
@@ -1557,6 +1718,16 @@ static void dpp_roc_started(void *user_data)
 			send_authenticate_response(dpp);
 		}
 
+		break;
+	case DPP_STATE_PKEX_EXCHANGE:
+		if (dpp->role == DPP_CAPABILITY_ENROLLEE)
+			dpp_send_pkex_exchange_request(dpp);
+
+		break;
+	case DPP_STATE_PKEX_COMMIT_REVEAL:
+		if (dpp->role == DPP_CAPABILITY_ENROLLEE)
+			dpp_send_commit_reveal_request(dpp);
+
 		break;
 	default:
 		break;
@@ -1586,12 +1757,14 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 
 	switch (dpp->state) {
 	case DPP_STATE_PRESENCE:
+	case DPP_STATE_PKEX_EXCHANGE:
 		break;
 	case DPP_STATE_NOTHING:
 		/* Protocol already terminated */
 		return;
 	case DPP_STATE_AUTHENTICATING:
 	case DPP_STATE_CONFIGURING:
+	case DPP_STATE_PKEX_COMMIT_REVEAL:
 		goto next_roc;
 	}
 
@@ -2155,6 +2328,382 @@ static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
 		dpp->channel_switch = true;
 }
 
+static void dpp_pkex_bad_group(struct dpp_sm *dpp, uint16_t group)
+{
+	uint16_t own_group = l_ecc_curve_get_ike_group(dpp->curve);
+
+	/*
+	 * TODO: The spec allows group negotiation, but it is not yet
+	 *       implemented.
+	 */
+	if (!group)
+		return;
+	/*
+	 * Section 5.6.2
+	 * "If the Responder's offered group offers less security
+	 * than the Initiator's offered group, then the Initiator should
+	 * ignore this message"
+	 */
+	if (group < own_group) {
+		l_debug("Offered group %u is less secure, ignoring",
+				group);
+		return;
+	}
+	/*
+	 * Section 5.6.2
+	 * "If the Responder's offered group offers equivalent or better
+	 * security than the Initiator's offered group, then the
+	 * Initiator may choose to abort its original request and try
+	 * another exchange using the group offered by the Responder"
+	 */
+	if (group >= own_group) {
+		l_debug("Offered group %u is the same or more secure, "
+			" but group negotiation is not supported", group);
+		return;
+	}
+}
+
+static void dpp_pkex_bad_code(struct dpp_sm *dpp)
+{
+	_auto_(l_ecc_point_free) struct l_ecc_point *qr = NULL;
+
+	qr = dpp_derive_q(dpp->curve, true, dpp->pkex_key, dpp->pkex_id,
+				netdev_get_address(dpp->netdev));
+	if (!qr) {
+		l_debug("Qr computed to zero, new code should be provisioned");
+		return;
+	}
+
+	l_debug("Qr computed successfully but responder indicated otherwise");
+}
+
+static void dpp_handle_pkex_exchange_response(struct dpp_sm *dpp,
+					const uint8_t *from,
+					const uint8_t *body, size_t body_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	uint8_t status = __DPP_STATUS_MAX;
+	uint8_t version = 0;
+	const char *identifier = NULL;
+	size_t identifier_len = 0;
+	const void *key = NULL;
+	size_t key_len = 0;
+	uint16_t group = 0;
+	_auto_(l_ecc_point_free) struct l_ecc_point *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *j = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *qr = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *k = NULL;
+	const uint8_t *own_addr = netdev_get_address(dpp->netdev);
+
+	l_debug("PKEX response "MAC, MAC_STR(from));
+
+	if (dpp->state != DPP_STATE_PKEX_EXCHANGE)
+		return;
+
+	if (dpp->role != DPP_CAPABILITY_ENROLLEE)
+		return;
+
+	memcpy(dpp->peer_addr, from, 6);
+
+	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_STATUS:
+			if (len != 1)
+				return;
+
+			status = l_get_u8(data);
+			break;
+		case DPP_ATTR_PROTOCOL_VERSION:
+			if (len != 1)
+				return;
+
+			version = l_get_u8(data);
+			break;
+		case DPP_ATTR_CODE_IDENTIFIER:
+			identifier = (char *) data;
+			identifier_len = len;
+			break;
+		case DPP_ATTR_ENCRYPTED_KEY:
+			if (len != dpp->key_len * 2)
+				return;
+
+			key = data;
+			key_len = len;
+			break;
+		case DPP_ATTR_FINITE_CYCLIC_GROUP:
+			if (len != 2)
+				return;
+
+			group = l_get_le16(data);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (status == __DPP_STATUS_MAX) {
+		l_debug("No status attribute, ignoring");
+		return;
+	}
+
+	if (!key) {
+		l_debug("No encrypted key, ignoring");
+		return;
+	}
+
+	if (status != DPP_STATUS_OK)
+		goto handle_status;
+
+	if (dpp->pkex_id) {
+		if (!identifier || identifier_len != strlen(dpp->pkex_id) ||
+					strncmp(dpp->pkex_id, identifier,
+						identifier_len)) {
+			l_debug("mismatch identifier, ignoring");
+			return;
+		}
+	}
+
+	if (version && version != dpp->pkex_version) {
+		l_debug("PKEX version does not match, igoring");
+		return;
+	}
+
+	n = l_ecc_point_from_data(dpp->curve, L_ECC_POINT_TYPE_FULL,
+					key, key_len);
+	if (!n) {
+		l_debug("failed to parse peers encrypted key");
+		goto failed;
+	}
+
+	qr = dpp_derive_q(dpp->curve, true, dpp->pkex_key, dpp->pkex_id,
+				dpp->peer_addr);
+	if (!qr)
+		goto failed;
+
+	dpp->y_or_x = l_ecc_point_new(dpp->curve);
+
+	/* Y' = N - Qr */
+	l_ecc_point_inverse(qr);
+	l_ecc_point_add(dpp->y_or_x, n, qr);
+
+	/*
+	 * "The resulting ephemeral key, denoted Y’, is then checked whether it
+	 * is the point-at-infinity. If it is not valid, the protocol ends
+	 * unsuccessfully"
+	 */
+	if (l_ecc_point_is_infinity(dpp->y_or_x)) {
+		l_debug("Y' computed to infinity, failing");
+		dpp_reset(dpp);
+		return;
+	}
+
+	k = l_ecc_point_new(dpp->curve);
+
+	/* K = Y' * x */
+	l_ecc_point_multiply(k, dpp->pkex_private, dpp->y_or_x);
+
+	dpp_derive_z(own_addr, dpp->peer_addr, n, dpp->pkex_m, k,
+				dpp->pkex_key, dpp->pkex_id,
+				dpp->z, &dpp->z_len);
+
+	j = l_ecc_point_new(dpp->curve);
+
+	l_ecc_point_multiply(j, dpp->boot_private, dpp->y_or_x);
+
+	if (!dpp_derive_u(j, own_addr, dpp->boot_public, dpp->y_or_x,
+				dpp->pkex_public, dpp->u, &dpp->u_len)) {
+		l_debug("failed to compute u");
+		goto failed;
+	}
+
+	/*
+	 * Now that a response was successfully received, start another
+	 * offchannel with more time for the remainder of the protocol. After
+	 * PKEX, authentication will begin which handles the protocol timeout.
+	 * If the remainder of PKEX (commit-reveal exchange) cannot complete in
+	 * this time it will fail.
+	 */
+	dpp->dwell = (dpp->max_roc < 2000) ? dpp->max_roc : 2000;
+	dpp->state = DPP_STATE_PKEX_COMMIT_REVEAL;
+
+	dpp_pkex_property_changed_notify(dpp);
+
+	dpp_start_offchannel(dpp, dpp->current_freq);
+
+	return;
+
+handle_status:
+	switch (status) {
+	case DPP_STATUS_BAD_GROUP:
+		dpp_pkex_bad_group(dpp, group);
+		break;
+	case DPP_STATUS_BAD_CODE:
+		dpp_pkex_bad_code(dpp);
+		break;
+	default:
+		l_debug("Unhandled status %u", status);
+		break;
+	}
+
+failed:
+	dpp_reset(dpp);
+}
+
+static bool dpp_pkex_start_authentication(struct dpp_sm *dpp)
+{
+	dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
+					netdev_get_address(dpp->netdev),
+					&dpp->current_freq, 1, NULL, NULL);
+
+	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
+					&dpp->own_proto_public);
+
+	l_getrandom(dpp->i_nonce, dpp->nonce_len);
+
+	dpp->peer_asn1 = dpp_point_to_asn1(dpp->peer_boot_public,
+						&dpp->peer_asn1_len);
+
+	dpp->m = dpp_derive_k1(dpp->peer_boot_public, dpp->proto_private,
+				dpp->k1);
+
+	dpp_hash(L_CHECKSUM_SHA256, dpp->peer_boot_hash, 1, dpp->peer_asn1,
+			dpp->peer_asn1_len);
+
+	dpp->state = DPP_STATE_AUTHENTICATING;
+	dpp->mutual_auth = true;
+
+	dpp_pkex_property_changed_notify(dpp);
+
+	if (dpp->role == DPP_CAPABILITY_ENROLLEE) {
+		dpp->new_freq = dpp->current_freq;
+
+		return dpp_send_authenticate_request(dpp);
+	}
+
+	return true;
+}
+
+
+static void dpp_handle_pkex_commit_reveal_response(struct dpp_sm *dpp,
+					const uint8_t *from,
+					const uint8_t *body, size_t body_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	const uint8_t *wrapped = NULL;
+	size_t wrapped_len = 0;
+	uint8_t one = 1;
+	_auto_(l_free) uint8_t *unwrapped = NULL;
+	size_t unwrapped_len = 0;
+	const uint8_t *boot_key = NULL;
+	size_t boot_key_len = 0;
+	const uint8_t *r_auth = NULL;
+	uint8_t v[L_ECC_SCALAR_MAX_BYTES];
+	size_t v_len;
+	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
+
+	l_debug("PKEX commit reveal "MAC, MAC_STR(from));
+
+	if (dpp->state != DPP_STATE_PKEX_COMMIT_REVEAL)
+		return;
+
+	if (dpp->role != DPP_CAPABILITY_ENROLLEE)
+		return;
+
+	/*
+	 * The URI may not have contained a MAC address, if this announcement
+	 * verifies set peer_addr then.
+	 */
+	if (memcmp(from, dpp->peer_addr, 6)) {
+		l_debug("Unexpected source "MAC" expected "MAC, MAC_STR(from),
+						MAC_STR(dpp->peer_addr));
+		return;
+	}
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
+	unwrapped = dpp_unwrap_attr(body + 2, 6, &one, 1, dpp->z, dpp->z_len,
+					wrapped, wrapped_len, &unwrapped_len);
+	if (!unwrapped) {
+		l_debug("Failed to unwrap Reveal-Commit message");
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
+			boot_key = data;
+			boot_key_len = len;
+			break;
+		case DPP_ATTR_RESPONDER_AUTH_TAG:
+			if (len != 32)
+				return;
+
+			r_auth = data;
+			break;
+		default:
+			break;
+		}
+	}
+
+	dpp->peer_boot_public = l_ecc_point_from_data(dpp->curve,
+							L_ECC_POINT_TYPE_FULL,
+							boot_key, boot_key_len);
+	if (!dpp->peer_boot_public) {
+		l_debug("Peer public bootstrapping key was invalid");
+		goto failed;
+	}
+
+	l = l_ecc_point_new(dpp->curve);
+
+	l_ecc_point_multiply(l, dpp->pkex_private, dpp->peer_boot_public);
+
+	if (!dpp_derive_v(l, dpp->peer_addr, dpp->peer_boot_public,
+				dpp->pkex_public, dpp->y_or_x, v, &v_len)) {
+		l_debug("Failed to derive v");
+		goto failed;
+	}
+
+	if (memcmp(v, r_auth, v_len)) {
+		l_debug("Bootstrapping data did not verify");
+		goto failed;
+	}
+
+	if (dpp_pkex_start_authentication(dpp))
+		return;
+
+failed:
+	dpp_reset(dpp);
+}
+
 static void dpp_handle_frame(struct dpp_sm *dpp,
 				const struct mmpdu_header *frame,
 				const void *body, size_t body_len)
@@ -2189,6 +2738,14 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
 		dpp_handle_presence_announcement(dpp, frame->address_2,
 							body, body_len);
 		break;
+	case DPP_FRAME_PKEX_XCHG_RESPONSE:
+		dpp_handle_pkex_exchange_response(dpp, frame->address_2, body,
+							body_len);
+		break;
+	case DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE:
+		dpp_handle_pkex_commit_reveal_response(dpp, frame->address_2,
+							body, body_len);
+		break;
 	default:
 		l_debug("Unhandled DPP frame %u", *ptr);
 		break;
@@ -2245,7 +2802,14 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 	if (!dpp)
 		return;
 
-	if (dpp->state == DPP_STATE_PRESENCE || dpp->state == DPP_STATE_NOTHING)
+	/*
+	 * Don't retransmit for presence or PKEX exchange if an enrollee, both
+	 * are broadcast frames which don't expect an ack.
+	 */
+	if (dpp->state == DPP_STATE_NOTHING ||
+			dpp->state == DPP_STATE_PRESENCE ||
+			(dpp->state == DPP_STATE_PKEX_EXCHANGE &&
+			dpp->role == DPP_CAPABILITY_ENROLLEE))
 		return;
 
 
@@ -2418,6 +2982,8 @@ static void dpp_create(struct netdev *netdev)
 
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
+	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
+					IWD_DPP_PKEX_INTERFACE, dpp);
 
 	dpp_frame_watch(dpp, 0x00d0, dpp_prefix, sizeof(dpp_prefix));
 
@@ -2722,6 +3288,163 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(message);
 }
 
+/*
+ * Section 5.6.1
+ * In lieu of specific channel information obtained in a manner outside
+ * the scope of this specification, PKEX responders shall select one of
+ * the following channels:
+ *  - 2.4 GHz: Channel 6 (2.437 GHz)
+ *  - 5 GHz: Channel 44 (5.220 GHz) if local regulations permit
+ *           operation only in the 5.150 – 5.250 GHz band and Channel
+ *           149 (5.745 GHz) otherwise
+ */
+static uint32_t *dpp_get_pkex_freqs(struct dpp_sm *dpp, size_t *out_len)
+{
+	struct wiphy *wiphy = wiphy_find_by_wdev(dpp->wdev_id);
+	const uint32_t default_channels[] = { 2437, 5220, 5745 };
+	uint32_t *freqs_out;
+	size_t i;
+	size_t len = 1;
+
+	if (wiphy_get_supported_bands(wiphy) & BAND_FREQ_5_GHZ)
+		len += 2;
+
+	freqs_out = l_new(uint32_t, len);
+
+	for (i = 0; i < 3; i++)
+		freqs_out[i] = default_channels[i];
+
+	*out_len = len;
+	return freqs_out;
+}
+
+static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
+				const char *identifier)
+{
+	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
+
+	dpp->freqs = dpp_get_pkex_freqs(dpp, &dpp->freqs_len);
+	if (!dpp->freqs)
+		return false;
+
+	if (identifier)
+		dpp->pkex_id = l_strdup(identifier);
+
+	dpp->pkex_key = l_strdup(key);
+	memcpy(dpp->peer_addr, broadcast, 6);
+	dpp->role = DPP_CAPABILITY_ENROLLEE;
+	dpp->state = DPP_STATE_PKEX_EXCHANGE;
+	dpp->current_freq = dpp->freqs[dpp->freqs_idx];
+	/*
+	 * In theory a driver could support a lesser duration than 200ms. This
+	 * complicates things since we would need to tack on additional
+	 * offchannel requests to meet the 200ms requirement. This could be done
+	 * but for now use max_roc or 200ms, whichever is less.
+	 */
+	dpp->dwell = (dpp->max_roc < 200) ? dpp->max_roc : 200;
+	/* "DPP R2 devices are expected to use PKEXv1 by default" */
+	dpp->pkex_version = 1;
+
+	if (!l_ecdh_generate_key_pair(dpp->curve, &dpp->pkex_private,
+					&dpp->pkex_public))
+		goto failed;
+
+	/*
+	 * "If Qi is the point-at-infinity, the code shall be deleted and the
+	 * user should be notified to provision a new code"
+	 */
+	qi = dpp_derive_q(dpp->curve, false, dpp->pkex_key,
+				dpp->pkex_id, netdev_get_address(dpp->netdev));
+	if (!qi || l_ecc_point_is_infinity(qi)) {
+		l_debug("Cannot derive Qi, provision a new code");
+		goto failed;
+	}
+
+	dpp->pkex_m = l_ecc_point_new(dpp->curve);
+
+	if (!l_ecc_point_add(dpp->pkex_m, dpp->pkex_public, qi))
+		goto failed;
+
+	dpp_pkex_property_changed_notify(dpp);
+
+	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
+
+	dpp_start_offchannel(dpp, dpp->current_freq);
+
+	return true;
+
+failed:
+	dpp_reset(dpp);
+	return false;
+}
+
+static bool dpp_check_pkex_identifier(const char *id)
+{
+	const char *end;
+
+	if (!id)
+		return true;
+
+	/*
+	 * "If an optional code identifier is used, it shall be a UTF-8 string
+	 *  not greater than eighty (80) octets"
+	 */
+	if (!l_utf8_validate(id, strlen(id), &end) || end - id > 80)
+		return false;
+
+	return true;
+}
+
+static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	struct l_dbus_message_iter iter;
+	struct l_dbus_message_iter variant;
+	const char *dict_key;
+	const char *key;
+	const char *id = NULL;
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+
+	l_debug("");
+
+	if (dpp->state != DPP_STATE_NOTHING)
+		return dbus_error_busy(message);
+
+	if (station_get_connected_network(station))
+		return dbus_error_busy(message);
+
+	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter))
+		goto invalid_args;
+
+	while (l_dbus_message_iter_next_entry(&iter, &dict_key, &variant)) {
+		if (!strcmp(dict_key, "Key")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+								&key))
+				goto invalid_args;
+		} else if (!strcmp(dict_key, "Identifier")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+								&id))
+				goto invalid_args;
+		}
+	}
+
+	if (!key)
+		goto invalid_args;
+
+	if (!dpp_check_pkex_identifier(id))
+		goto invalid_args;
+
+	if (!dpp_start_pkex_enrollee(dpp, key, id))
+		goto invalid_args;
+
+	return l_dbus_message_new_method_return(message);
+
+invalid_args:
+	return dbus_error_invalid_args(message);
+}
+
 static void dpp_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "StartEnrollee", 0,
@@ -2740,6 +3463,18 @@ static void dpp_setup_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_property(interface, "URI", 0, "s", dpp_get_uri, NULL);
 }
 
+static void dpp_setup_pkex_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "StartEnrollee", 0,
+			dpp_dbus_pkex_start_enrollee, "", "a{sv}", "args");
+	l_dbus_interface_method(interface, "Stop", 0, dpp_dbus_stop, "", "");
+
+	l_dbus_interface_property(interface, "Started", 0, "b",
+			dpp_pkex_get_started, NULL);
+	l_dbus_interface_property(interface, "Role", 0, "s", dpp_get_role,
+			NULL);
+}
+
 static void dpp_destroy_interface(void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
@@ -2762,6 +3497,10 @@ static int dpp_init(void)
 	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_INTERFACE,
 					dpp_setup_interface,
 					dpp_destroy_interface, false);
+	/* No destroy since DPP/PKEX interfaces are added/removed together */
+	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_PKEX_INTERFACE,
+					dpp_setup_pkex_interface,
+					NULL, false);
 
 	mlme_watch = l_genl_family_register(nl80211, "mlme", dpp_mlme_notify,
 						NULL, NULL);
-- 
2.25.1

