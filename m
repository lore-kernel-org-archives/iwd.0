Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113DF168BC
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qek7RpfL"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5b383b4184fso71227347b3.1
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699376797; x=1699981597; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6DXwbDCtzTCur17BgER2oVWbToEYrKuG8tAtstzK1I=;
        b=Qek7RpfLh+NxwroZAt85XP4bpymn/sHzehd6WmJKbaIMeD2qvSui5OHuJQLuWmGujR
         bEMy/9EUFRmgMqqWts8oR4kwpIQVEqdzYU+Jq4rRj7NUOCEKAFR1mfR0GWi5fJ2MFp5T
         sX5zbrLotzx94zLjxghorZ4wE9XvZO45xNs1Bfk5QvbAplASvyYpeXHZqVcf3ZAwqNTN
         zzqNuCKkE+kGfo2ir2EpflPfxG4nTgCSKKwkaTgL3yBsT4POyS/5dBooHDj/e5PTCqvH
         JCNEkcut5APdMazqeBltmrThSL3knFcDv02B6pKU9qJssY9GABFozp7RJ/64rx2kytj+
         LE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699376797; x=1699981597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6DXwbDCtzTCur17BgER2oVWbToEYrKuG8tAtstzK1I=;
        b=m5nJqziYSrPKUV1U+kbDrZuN/RSYc/2lezoah1+gPphLyAJRCg2PHTtgE2jl+JPAev
         Ej8NdH2EDlAe7NSAsE5Keo4gUJKGM24twqhnKidBE1m6Gg9GpxkpiZz+s3ffJs+QV30l
         j/QbG+IDiLLe7p8rYsebQqfDmtlprHHeclaIt0Kx3DLABkzF/kaNWcR0rKQh7wtqaZe3
         lKo0K7JIHuFZxYMBxKh88BXEF1HOFfl8AF0QEH6Ghv7//z8+GMzPw07VkYgWqUhco7HS
         lBtY14y8kot7nxRuSwABCidmm3NVFBgc7HrJaf5NMLUpEzfsqLKzA1KRz+8RGzZie8rr
         G2nQ==
X-Gm-Message-State: AOJu0Yw59n7MQEDoZySk/EUyViMmBWlciVVwJ5jgQ2jWtl/L/jgeD3hT
	ywcYNYcfsJ9jL1tnxQkuBq6rCyTyUJg=
X-Google-Smtp-Source: AGHT+IFqKpCPF0/yRFU5zD49Lh8e3eI6yqFF8WGQzBVEKjN2j2G4JFoQaBeBKlgbik9BWK9nmTrfqw==
X-Received: by 2002:a0d:f643:0:b0:594:f864:8507 with SMTP id g64-20020a0df643000000b00594f8648507mr13118038ywf.51.1699376796367;
        Tue, 07 Nov 2023 09:06:36 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z127-20020a814c85000000b005a7db2a0dddsm5790475ywa.3.2023.11.07.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:06:36 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/4] dpp: initial version of PKEX enrollee support
Date: Tue,  7 Nov 2023 09:06:27 -0800
Message-Id: <20231107170629.1831655-3-prestwoj@gmail.com>
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
 src/dpp.c | 792 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 788 insertions(+), 4 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index b0a79361..4b1c1233 100644
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
@@ -147,19 +150,66 @@ struct dpp_sm {
 
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
 
@@ -199,7 +249,9 @@ static bool dpp_get_uri(struct l_dbus *dbus,
 {
 	struct dpp_sm *dpp = user_data;
 
-	if (dpp->state == DPP_STATE_NOTHING)
+	if (dpp->state == DPP_STATE_NOTHING ||
+			dpp->state == DPP_STATE_PKEX_EXCHANGE ||
+			dpp->state == DPP_STATE_PKEX_COMMIT_REVEAL)
 		return false;
 
 	l_dbus_message_builder_append_basic(builder, 's', dpp->uri);
@@ -218,6 +270,16 @@ static void dpp_property_changed_notify(struct dpp_sm *dpp)
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
@@ -242,6 +304,21 @@ static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
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
@@ -268,6 +345,27 @@ static void dpp_free_auth_data(struct dpp_sm *dpp)
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
@@ -321,6 +419,7 @@ static void dpp_reset(struct dpp_sm *dpp)
 	dpp->new_freq = 0;
 	dpp->frame_retry = 0;
 	dpp->frame_cookie = 0;
+	dpp->pkex_version = 0;
 
 	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
@@ -329,10 +428,15 @@ static void dpp_reset(struct dpp_sm *dpp)
 	explicit_bzero(dpp->k1, dpp->key_len);
 	explicit_bzero(dpp->k2, dpp->key_len);
 	explicit_bzero(dpp->auth_tag, dpp->key_len);
+	explicit_bzero(dpp->z, dpp->key_len);
+	explicit_bzero(dpp->u, dpp->u_len);
+
+	dpp_free_pending_pkex_data(dpp);
 
 	dpp_free_auth_data(dpp);
 
 	dpp_property_changed_notify(dpp);
+	dpp_pkex_property_changed_notify(dpp);
 }
 
 static void dpp_free(struct dpp_sm *dpp)
@@ -357,6 +461,23 @@ static void dpp_free(struct dpp_sm *dpp)
 	l_free(dpp);
 }
 
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
 static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
@@ -1512,6 +1633,71 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
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
@@ -1575,6 +1761,16 @@ static void dpp_roc_started(void *user_data)
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
@@ -1603,6 +1799,7 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 		goto protocol_failed;
 
 	switch (dpp->state) {
+	case DPP_STATE_PKEX_EXCHANGE:
 	case DPP_STATE_PRESENCE:
 		break;
 	case DPP_STATE_NOTHING:
@@ -1610,6 +1807,7 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 		return;
 	case DPP_STATE_AUTHENTICATING:
 	case DPP_STATE_CONFIGURING:
+	case DPP_STATE_PKEX_COMMIT_REVEAL:
 		goto next_roc;
 	}
 
@@ -2172,6 +2370,382 @@ static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
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
+			status = data;
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
+	dpp_pkex_property_changed_notify(dpp);
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
@@ -2206,6 +2780,14 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
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
@@ -2262,10 +2844,16 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
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
 
@@ -2435,6 +3023,8 @@ static void dpp_create(struct netdev *netdev)
 
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
+	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
+					IWD_DPP_PKEX_INTERFACE, dpp);
 
 	dpp_frame_watch(dpp, 0x00d0, dpp_prefix, sizeof(dpp_prefix));
 
@@ -2730,9 +3320,176 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 {
 	struct dpp_sm *dpp = user_data;
 
+	/* Don't stop PKEX from the DPP interface */
+	if (!dpp->pkex_version)
+		dpp_reset(dpp);
+
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
+ *           operation only in the 5.150 – 5.250 GHz band and Channel
+ *           149 (5.745 GHz) otherwise
+ */
+static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
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
+	dpp_pkex_property_changed_notify(dpp);
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
+	if (id && !dpp_check_pkex_identifier(id))
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
+	if (dpp->state != DPP_STATE_NOTHING)
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
@@ -2753,6 +3510,31 @@ static void dpp_setup_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_property(interface, "URI", 0, "s", dpp_get_uri, NULL);
 }
 
+static struct l_dbus_message *dpp_dbus_pkex_stop(struct l_dbus *dbus,
+				struct l_dbus_message *message, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	/* If PKEX/DPP was not started via this interface don't stop it */
+	if (dpp->pkex_version)
+		dpp_reset(dpp);
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
+	l_dbus_interface_property(interface, "Role", 0, "s", dpp_get_role,
+			NULL);
+}
+
 static void dpp_destroy_interface(void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
@@ -2775,6 +3557,8 @@ static int dpp_init(void)
 	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_INTERFACE,
 					dpp_setup_interface,
 					dpp_destroy_interface, false);
+	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_PKEX_INTERFACE,
+					dpp_setup_pkex_interface, NULL, false);
 
 	mlme_watch = l_genl_family_register(nl80211, "mlme", dpp_mlme_notify,
 						NULL, NULL);
-- 
2.25.1

