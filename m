Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACB31A87
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBqw68V+"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6754b4091b6so44096536d6.3
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464125; x=1700068925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fS2tDIIChIsgrCOlKIwKzy5GgPPGt8mFpfl8FeTA0s=;
        b=LBqw68V+/6EltCVMVWsvAqS+46DE7EMLkR7VqXQZCzxJgLi1aCSKYC4sTUtJBrzVfg
         G1iPdvQdMfOzahUNTCwo3uCHZbH/gOxhV2ZQuE+uuqXzn4KIc+ethRrWo+PHXsI+dPG3
         BxNH2dXdCPLKhx+LiXxG4reEe9aC62hBVz5JWrezZi5BH85qb0rkM+xYo8bVGnz1uGWA
         FzeKQjyocvY9pTrdjGcaT6dggzvGw8nxCjLLRqdTZrVakx/yQX3/iUR2/l1/J0rB6PYI
         utSIe+Hp9DxK3rSj72WI8sRivd8N33SZtJOn/1eGLcksLFVwxSLCQq7WT57UDePnb311
         NUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464125; x=1700068925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fS2tDIIChIsgrCOlKIwKzy5GgPPGt8mFpfl8FeTA0s=;
        b=DKfi0ZAP5f9juzCe/NxMtmqumu0PRRwZsAnvMnfv0h1boq89Tv1LC8wQ01XFSQYigO
         pUECOrTD4doZaGqnX4YyCbZTOPmTxBK3s2rIz3edM0rghY+4k4Ofr3W29yzXhYn366xb
         JIfmbUyJKxS/3Ybi+BWhSfkSG1++lYi+FabS5njdf2LnAzHD/K+0/1Ot/F26aqljzlEG
         VpZb5j5vHkhZTWsgygmO8eTJhnFBIHqDD631Wpyc+3WEF8FAWNyMmmDYVGfgn8ZzBh0I
         BP0onzFe51m8DyNGA37LIXjdQFsf1zI60SPHzxR8nE3sMhLhA7VmQZMyiTrMekP/MBD8
         XDHw==
X-Gm-Message-State: AOJu0Yy5r4x7qGBSBjgNmhevIFyTTDqLi+sEdnH1A5M3p0LZ7RHo7nUe
	3T4+R2kPdKAbRi8Mxs84sQeppLi5JiU=
X-Google-Smtp-Source: AGHT+IER7Fk1pg558u2Sg59IuM0gzsFuiU6SBQKMfLXZYsLseIzUzlZbjy+JKW4OtR2JYYh9IcQ1sg==
X-Received: by 2002:a05:6214:d4a:b0:66d:1d3f:17d7 with SMTP id 10-20020a0562140d4a00b0066d1d3f17d7mr2857973qvr.8.1699464124600;
        Wed, 08 Nov 2023 09:22:04 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:22:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 05/10] dpp: initial version of PKEX enrollee support
Date: Wed,  8 Nov 2023 09:21:50 -0800
Message-Id: <20231108172155.2129509-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108172155.2129509-1-prestwoj@gmail.com>
References: <20231108172155.2129509-1-prestwoj@gmail.com>
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
 src/dpp.c | 811 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 800 insertions(+), 11 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 7a7301e2..ee2cd903 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -57,6 +57,7 @@
 #define DPP_FRAME_MAX_RETRIES 5
 #define DPP_FRAME_RETRY_TIMEOUT 1
 #define DPP_AUTH_PROTO_TIMEOUT 10
+#define DPP_PKEX_PROTO_TIMEOUT 120
 
 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -70,6 +71,8 @@ static uint8_t dpp_prefix[] = { 0x04, 0x09, 0x50, 0x6f, 0x9a, 0x1a, 0x01 };
 enum dpp_state {
 	DPP_STATE_NOTHING,
 	DPP_STATE_PRESENCE,
+	DPP_STATE_PKEX_EXCHANGE,
+	DPP_STATE_PKEX_COMMIT_REVEAL,
 	DPP_STATE_AUTHENTICATING,
 	DPP_STATE_CONFIGURING,
 };
@@ -89,6 +92,7 @@ struct dpp_sm {
 	struct netdev *netdev;
 	char *uri;
 	uint8_t role;
+	int refcount;
 
 	uint64_t wdev_id;
 
@@ -154,12 +158,73 @@ struct dpp_sm {
 
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
 
+static const char *dpp_role_to_string(enum dpp_capability role)
+{
+	switch (role) {
+	case DPP_CAPABILITY_ENROLLEE:
+		return "enrollee";
+	case DPP_CAPABILITY_CONFIGURATOR:
+		return "configurator";
+	default:
+		return NULL;
+	}
+}
+
+static bool dpp_pkex_get_started(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	bool started = (dpp->state != DPP_STATE_NOTHING &&
+			dpp->interface == DPP_INTERFACE_PKEX);
+
+	l_dbus_message_builder_append_basic(builder, 'b', &started);
+
+	return true;
+}
+
+static bool dpp_pkex_get_role(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *role;
+
+	if (dpp->state == DPP_STATE_NOTHING ||
+				dpp->interface != DPP_INTERFACE_PKEX)
+		return false;
+
+	role = dpp_role_to_string(dpp->role);
+	if (L_WARN_ON(!role))
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', role);
+	return true;
+}
+
 static bool dpp_get_started(struct l_dbus *dbus,
 				struct l_dbus_message *message,
 				struct l_dbus_message_builder *builder,
@@ -186,16 +251,9 @@ static bool dpp_get_role(struct l_dbus *dbus,
 				dpp->interface != DPP_INTERFACE_DPP)
 		return false;
 
-	switch (dpp->role) {
-	case DPP_CAPABILITY_ENROLLEE:
-		role = "enrollee";
-		break;
-	case DPP_CAPABILITY_CONFIGURATOR:
-		role = "configurator";
-		break;
-	default:
+	role = dpp_role_to_string(dpp->role);
+	if (L_WARN_ON(!role))
 		return false;
-	}
 
 	l_dbus_message_builder_append_basic(builder, 's', role);
 	return true;
@@ -229,6 +287,12 @@ static void dpp_property_changed_notify(struct dpp_sm *dpp)
 		l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
 					"URI");
 		break;
+	case DPP_INTERFACE_PKEX:
+		l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_PKEX_INTERFACE,
+					"Started");
+		l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_PKEX_INTERFACE,
+					"Role");
+		break;
 	default:
 		break;
 	}
@@ -258,6 +322,21 @@ static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
 	return ret;
 }
 
+static void dpp_free_pending_pkex_data(struct dpp_sm *dpp)
+{
+	if (dpp->pkex_id) {
+		l_free(dpp->pkex_id);
+		dpp->pkex_id = NULL;
+	}
+
+	if (dpp->pkex_key) {
+		l_free(dpp->pkex_key);
+		dpp->pkex_key = NULL;
+	}
+
+	memset(dpp->peer_addr, 0, sizeof(dpp->peer_addr));
+}
+
 static void dpp_free_auth_data(struct dpp_sm *dpp)
 {
 	if (dpp->own_proto_public) {
@@ -284,6 +363,27 @@ static void dpp_free_auth_data(struct dpp_sm *dpp)
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
@@ -337,6 +437,7 @@ static void dpp_reset(struct dpp_sm *dpp)
 	dpp->new_freq = 0;
 	dpp->frame_retry = 0;
 	dpp->frame_cookie = 0;
+	dpp->pkex_version = 0;
 
 	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
@@ -345,6 +446,10 @@ static void dpp_reset(struct dpp_sm *dpp)
 	explicit_bzero(dpp->k1, dpp->key_len);
 	explicit_bzero(dpp->k2, dpp->key_len);
 	explicit_bzero(dpp->auth_tag, dpp->key_len);
+	explicit_bzero(dpp->z, dpp->key_len);
+	explicit_bzero(dpp->u, dpp->u_len);
+
+	dpp_free_pending_pkex_data(dpp);
 
 	dpp_free_auth_data(dpp);
 
@@ -1530,6 +1635,71 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
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
+				DPP_FRAME_PKEX_VERSION1_XCHG_REQUEST, hdr);
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
@@ -1593,6 +1763,16 @@ static void dpp_roc_started(void *user_data)
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
@@ -1621,6 +1801,7 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 		goto protocol_failed;
 
 	switch (dpp->state) {
+	case DPP_STATE_PKEX_EXCHANGE:
 	case DPP_STATE_PRESENCE:
 		break;
 	case DPP_STATE_NOTHING:
@@ -1628,6 +1809,7 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 		return;
 	case DPP_STATE_AUTHENTICATING:
 	case DPP_STATE_CONFIGURING:
+	case DPP_STATE_PKEX_COMMIT_REVEAL:
 		goto next_roc;
 	}
 
@@ -2190,6 +2372,382 @@ static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
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
+	qr = dpp_derive_qr(dpp->curve, dpp->pkex_key, dpp->pkex_id,
+				netdev_get_address(dpp->netdev));
+	if (!qr || l_ecc_point_is_infinity(qr)) {
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
+	const uint8_t *status = NULL;
+	uint8_t version = 0;
+	const void *identifier = NULL;
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
+			status = data;
+			break;
+		case DPP_ATTR_PROTOCOL_VERSION:
+			if (len != 1)
+				return;
+
+			version = l_get_u8(data);
+			break;
+		case DPP_ATTR_CODE_IDENTIFIER:
+			identifier = data;
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
+	if (!status) {
+		l_debug("No status attribute, ignoring");
+		return;
+	}
+
+	if (!key) {
+		l_debug("No encrypted key, ignoring");
+		return;
+	}
+
+	if (*status != DPP_STATUS_OK)
+		goto handle_status;
+
+	if (dpp->pkex_id) {
+		if (!identifier || identifier_len != strlen(dpp->pkex_id) ||
+					memcmp(dpp->pkex_id, identifier,
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
+	qr = dpp_derive_qr(dpp->curve, dpp->pkex_key, dpp->pkex_id,
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
+		goto failed;
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
+	/* J = a * Y' */
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
+	dpp_property_changed_notify(dpp);
+
+	dpp_start_offchannel(dpp, dpp->current_freq);
+
+	return;
+
+handle_status:
+	switch (*status) {
+	case DPP_STATUS_BAD_GROUP:
+		dpp_pkex_bad_group(dpp, group);
+		break;
+	case DPP_STATUS_BAD_CODE:
+		dpp_pkex_bad_code(dpp);
+		break;
+	default:
+		l_debug("Unhandled status %u", *status);
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
+	dpp_property_changed_notify(dpp);
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
+	/* L = b * X' */
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
@@ -2224,6 +2782,14 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
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
@@ -2280,10 +2846,16 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 	if (!dpp)
 		return;
 
-	if (dpp->state <= DPP_STATE_PRESENCE)
+	/*
+	 * Don't retransmit for presence or PKEX exchange if an enrollee, both
+	 * are broadcast frames which don't expect an ack.
+	 */
+	if (dpp->state == DPP_STATE_NOTHING ||
+			dpp->state == DPP_STATE_PRESENCE ||
+			(dpp->state == DPP_STATE_PKEX_EXCHANGE &&
+			dpp->role == DPP_CAPABILITY_ENROLLEE))
 		return;
 
-
 	if (dpp->frame_cookie != cookie)
 		return;
 
@@ -2454,6 +3026,16 @@ static void dpp_create(struct netdev *netdev)
 
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
+	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
+					IWD_DPP_PKEX_INTERFACE, dpp);
+	/*
+	 * Since both interfaces share the dpp_sm set this to 2. Currently both
+	 * interfaces are added/removed in unison so we _could_ simply omit the
+	 * destroy callback on one of them. But for consistency and future
+	 * proofing use a reference count and the final interface being removed
+	 * will destroy the dpp_sm.
+	 */
+	dpp->refcount = 2;
 
 	dpp_frame_watch(dpp, 0x00d0, dpp_prefix, sizeof(dpp_prefix));
 
@@ -2484,6 +3066,9 @@ static void dpp_netdev_watch(struct netdev *netdev,
 		l_dbus_object_remove_interface(dbus_get_bus(),
 						netdev_get_path(netdev),
 						IWD_DPP_INTERFACE);
+		l_dbus_object_remove_interface(dbus_get_bus(),
+						netdev_get_path(netdev),
+						IWD_DPP_PKEX_INTERFACE);
 		break;
 	default:
 		break;
@@ -2756,9 +3341,182 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 	if (dpp->interface != DPP_INTERFACE_DPP)
 		return dbus_error_not_found(message);
 
+	return l_dbus_message_new_method_return(message);
+}
+
+/*
+ * Section 5.6.1
+ * In lieu of specific channel information obtained in a manner outside
+ * the scope of this specification, PKEX responders shall select one of
+ * the following channels:
+ *  - 2.4 GHz: Channel 6 (2.437 GHz)
+ *  - 5 GHz: Channel 44 (5.220 GHz) if local regulations permit
+ *           operation only in the 5.150 - 5.250 GHz band and Channel
+ *           149 (5.745 GHz) otherwise
+ */
+static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
+{
+	struct wiphy *wiphy = wiphy_find_by_wdev(dpp->wdev_id);
+	uint32_t default_channels[3] = { 2437, 5220, 5745 };
+	uint32_t *freqs_out;
+	size_t len = 0;
+
+	if ((wiphy_get_supported_bands(wiphy) & BAND_FREQ_2_4_GHZ) &&
+			scan_get_band_rank_modifier(BAND_FREQ_2_4_GHZ) != 0)
+		default_channels[len++] = 2437;
+
+	if ((wiphy_get_supported_bands(wiphy) & BAND_FREQ_5_GHZ) &&
+			scan_get_band_rank_modifier(BAND_FREQ_5_GHZ) != 0) {
+		default_channels[len++] = 5220;
+		default_channels[len++] = 5745;
+	}
+
+	if (!len) {
+		l_warn("No bands are allowed, check BandModifier* settings!");
+		return NULL;
+	}
+
+	freqs_out = l_memdup(default_channels, sizeof(uint32_t) * len);
+	*out_len = len;
+
+	return freqs_out;
+}
+
+static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
+				const char *identifier)
+{
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
+
+	if (station && station_get_connected_network(station)) {
+		l_debug("Already connected, disconnect before enrolling");
+		return false;
+	}
+
+	if (identifier)
+		dpp->pkex_id = l_strdup(identifier);
+
+	dpp->pkex_key = l_strdup(key);
+	memcpy(dpp->peer_addr, broadcast, 6);
+	dpp->role = DPP_CAPABILITY_ENROLLEE;
+	dpp->state = DPP_STATE_PKEX_EXCHANGE;
+	dpp->interface = DPP_INTERFACE_PKEX;
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
+	qi = dpp_derive_qi(dpp->curve, dpp->pkex_key, dpp->pkex_id,
+				netdev_get_address(dpp->netdev));
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
+	dpp_property_changed_notify(dpp);
+
+	dpp->freqs = dpp_default_freqs(dpp, &dpp->freqs_len);
+	if (!dpp->freqs)
+		goto failed;
+
+	dpp->current_freq = dpp->freqs[dpp->freqs_idx];
+
+	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
+
+	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
+
+	dpp_start_offchannel(dpp, dpp->current_freq);
+
+	return true;
+
+failed:
 	dpp_reset(dpp);
+	return false;
+}
+
+static bool dpp_parse_pkex_args(struct l_dbus_message *message,
+					const char **key_out,
+					const char **id_out)
+{
+	struct l_dbus_message_iter iter;
+	struct l_dbus_message_iter variant;
+	const char *dict_key;
+	const char *key = NULL;
+	const char *id = NULL;
+
+	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter))
+		return false;
+
+	while (l_dbus_message_iter_next_entry(&iter, &dict_key, &variant)) {
+		if (!strcmp(dict_key, "Code")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+								&key))
+				return false;
+		} else if (!strcmp(dict_key, "Identifier")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+								&id))
+				return false;
+		}
+	}
+
+	if (!key)
+		return false;
+
+	if (id && strlen(id) > 80)
+		return false;
+
+	*key_out = key;
+	*id_out = id;
+
+	return true;
+}
+
+static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *key;
+	const char *id;
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+
+	l_debug("");
+
+	if (dpp->state != DPP_STATE_NOTHING ||
+				dpp->interface != DPP_INTERFACE_UNBOUND)
+		return dbus_error_busy(message);
+
+	if (station_get_connected_network(station))
+		return dbus_error_busy(message);
+
+	if (!dpp_parse_pkex_args(message, &key, &id))
+		goto invalid_args;
+
+	if (!dpp_start_pkex_enrollee(dpp, key, id))
+		goto invalid_args;
 
 	return l_dbus_message_new_method_return(message);
+
+invalid_args:
+	return dbus_error_invalid_args(message);
 }
 
 static void dpp_setup_interface(struct l_dbus_interface *interface)
@@ -2779,10 +3537,37 @@ static void dpp_setup_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_property(interface, "URI", 0, "s", dpp_get_uri, NULL);
 }
 
+static struct l_dbus_message *dpp_dbus_pkex_stop(struct l_dbus *dbus,
+				struct l_dbus_message *message, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	if (dpp->interface != DPP_INTERFACE_PKEX)
+		return dbus_error_not_found(message);
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static void dpp_setup_pkex_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "StartEnrollee", 0,
+			dpp_dbus_pkex_start_enrollee, "", "a{sv}", "args");
+	l_dbus_interface_method(interface, "Stop", 0,
+			dpp_dbus_pkex_stop, "", "");
+
+	l_dbus_interface_property(interface, "Started", 0, "b",
+			dpp_pkex_get_started, NULL);
+	l_dbus_interface_property(interface, "Role", 0, "s",
+			dpp_pkex_get_role, NULL);
+}
+
 static void dpp_destroy_interface(void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
 
+	if (--dpp->refcount)
+		return;
+
 	l_queue_remove(dpp_list, dpp);
 
 	dpp_free(dpp);
@@ -2801,6 +3586,9 @@ static int dpp_init(void)
 	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_INTERFACE,
 					dpp_setup_interface,
 					dpp_destroy_interface, false);
+	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_PKEX_INTERFACE,
+					dpp_setup_pkex_interface,
+					dpp_destroy_interface, false);
 
 	mlme_watch = l_genl_family_register(nl80211, "mlme", dpp_mlme_notify,
 						NULL, NULL);
@@ -2820,6 +3608,7 @@ static void dpp_exit(void)
 	l_debug("");
 
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_DPP_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_DPP_PKEX_INTERFACE);
 
 	netdev_watch_remove(netdev_watch);
 
-- 
2.25.1

