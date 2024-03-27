Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943F12F393
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552819; cv=none; b=PO2jz0fg15Xcqy1CCqbd8zORWLaFZndQSmzZiAs/WLKY4Tbh31XsvS+Kv26QLh38lOX1N8ZayRMo9mSXzP6SY1FTVyoyEEYIiE/2DMJJi9E9Sp/bq23w6f/8mc0D/0FdS+WPOH5Fk3fY4AT7k4zR3FycJXCF2YA3cnHZM/RpNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552819; c=relaxed/simple;
	bh=5cFsGsqBM38Int8bQPikeWCclmUwKM1nCJsxlKuHw1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtnMY/kKGfX2GNaO33U+XkV9CFMHpHIosRvjNbrTy7gIEVnIf2Iwta/bR1BMS6WrSKSYXiSNcN29rN5GsvBJCWeSbin08LDF1UmF/jasOZNqurIuZtBN2GyYyq90kI+CmV/JgKEu/GAsVPJK4thSb+a6Z7dUWOlQ1PDYssSq0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DikZuMY4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DikZuMY4"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789db18e24eso439002285a.1
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552813; x=1712157613; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clUZyXE3vVtQZt5f/CiHXTNrFxzqu+qzMUhSAOQCX3Y=;
        b=DikZuMY43swE5AAUtYZGIRl0n75zG6aGNmIn9/1hdE7nEYXAcKArristUfrW2Z3wsU
         RVCTMgZrZ74omds0WPUJ80iCNXAaH1qF6fk4bgN/edZ3JCwKLwcuAn5QnCOXW8SgsMVq
         Zt3ErgxKdyOlDcydBxt4pYc/PbzWOJmnBHo7JIKjFr7HGkYm6Rd6bW8xs/2mXOueBliU
         l+JqCxnutarnaT39qEHS0XhSq1gelyazG2LStxIG9ZVJJTSHT0TBKSRuWsfgj2TN+Jsl
         iO/K1cStX9D11KOAVpndESix92F09rzCghsAtoks8wNpEQqKP59W8/tSJ00Henl2tvhv
         0K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552813; x=1712157613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clUZyXE3vVtQZt5f/CiHXTNrFxzqu+qzMUhSAOQCX3Y=;
        b=bqvoiQNkPuuRgSG1XKpQMEOCuP6dI/Or6w8sVi19raztAYcRRhB+rz12UWONQ3E/20
         30iQNMKhRkMwIN2gDZu4ubJKzqd4fpYCTio+1kO5S5qRnJqPh3oyDvTloHZpF1oeCUYc
         kT8kjTz31LD9dECvCfgSZj0XslFhLR5qBhFxRp4H2TJmy9uK5tOuB6XHpD4OivoKVvZu
         w3IgHZVN3aAToOMMqGWiXesjxyWRxVKPTkCxCLiUZLf/ocZJ6M7ZocS0jbCTAf1UYgnv
         12qXHs3n9p/KZ/LapWFzvsUcoWAvRnLrIzgkFC9w5T0+Qec2Boi9+DasTt4tgWIympOQ
         yqzA==
X-Gm-Message-State: AOJu0Yz47yZe10ANVqNuAXOj1/kDne+QInV9XWFaMxjW6f9aX/CTyRRv
	Q3TiNbBTy98m5m43OcdL/PFVW+CsGVYpnCjkuJxuMzK/Dv63+zxexEcAQ40E
X-Google-Smtp-Source: AGHT+IEHXvOyRSPE9YBfTsiem31IX2aELLjF6dz2jbA7IVFiHdjvUzI586+xdng65HRJisLWNRW34w==
X-Received: by 2002:a05:6214:2585:b0:696:4207:a6c9 with SMTP id fq5-20020a056214258500b006964207a6c9mr5049664qvb.35.1711552811925;
        Wed, 27 Mar 2024 08:20:11 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 7-20020a056214202700b006968ce99b7esm3520782qvf.34.2024.03.27.08.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:20:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/9] dpp: remove most crypto/frame processing
Date: Wed, 27 Mar 2024 08:19:56 -0700
Message-Id: <20240327151957.1446149-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327151957.1446149-1-prestwoj@gmail.com>
References: <20240327151957.1446149-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To prep for using dpp-common all (or most) of the crypto and frame
processing has been removed from dpp.c. This commit only serves as
a temporary transition to using dpp-common in order to make the
patches more readable. DPP is entirely broken with only this patch.
---
 src/dpp.c | 3232 ++++-------------------------------------------------
 1 file changed, 235 insertions(+), 2997 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 47ebd495..31d0ef28 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -57,8 +57,6 @@
 
 #define DPP_FRAME_MAX_RETRIES 5
 #define DPP_FRAME_RETRY_TIMEOUT 1
-#define DPP_AUTH_PROTO_TIMEOUT 10
-#define DPP_PKEX_PROTO_TIMEOUT 120
 
 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -96,7 +94,7 @@ struct pkex_agent {
 	uint32_t pending_id;
 };
 
-struct dpp_sm {
+struct dpp {
 	struct netdev *netdev;
 	char *uri;
 	uint8_t role;
@@ -106,18 +104,8 @@ struct dpp_sm {
 
 	uint64_t wdev_id;
 
-	uint8_t *own_asn1;
-	size_t own_asn1_len;
-	uint8_t *peer_asn1;
-	size_t peer_asn1_len;
-	uint8_t own_boot_hash[32];
-	uint8_t peer_boot_hash[32];
-	const struct l_ecc_curve *curve;
-	size_t key_len;
-	size_t nonce_len;
 	struct l_ecc_scalar *boot_private;
 	struct l_ecc_point *boot_public;
-	struct l_ecc_point *peer_boot_public;
 
 	enum dpp_state state;
 	enum dpp_interface interface;
@@ -140,22 +128,6 @@ struct dpp_sm {
 	uint32_t offchannel_id;
 
 	uint8_t peer_addr[6];
-	uint8_t r_nonce[32];
-	uint8_t i_nonce[32];
-	uint8_t e_nonce[32];
-
-	struct l_ecc_scalar *m;
-	uint64_t ke[L_ECC_MAX_DIGITS];
-	uint64_t k1[L_ECC_MAX_DIGITS];
-	uint64_t k2[L_ECC_MAX_DIGITS];
-	uint64_t auth_tag[L_ECC_MAX_DIGITS];
-
-	struct l_ecc_scalar *proto_private;
-	struct l_ecc_point *own_proto_public;
-
-	struct l_ecc_point *peer_proto_public;
-
-	uint8_t diag_token;
 
 	/* Timeout of either auth/config protocol */
 	struct l_timeout *timeout;
@@ -175,24 +147,12 @@ struct dpp_sm {
 	/* PKEX-specific values */
 	char *pkex_id;
 	char *pkex_key;
-	uint8_t pkex_version;
-	struct l_ecc_point *peer_encr_key;
-	struct l_ecc_point *pkex_m;
-	/* Ephemeral key Y' or X' for enrollee or configurator */
-	struct l_ecc_point *y_or_x;
-	/* Ephemeral key pair y/Y or x/X */
-	struct l_ecc_point *pkex_public;
-	struct l_ecc_scalar *pkex_private;
-	uint8_t z[L_ECC_SCALAR_MAX_BYTES];
-	size_t z_len;
-	uint8_t u[L_ECC_SCALAR_MAX_BYTES];
-	size_t u_len;
+
 	uint32_t pkex_scan_id;
 
 	bool mcast_support : 1;
 	bool roc_started : 1;
 	bool channel_switch : 1;
-	bool mutual_auth : 1;
 };
 
 static const char *dpp_role_to_string(enum dpp_capability role)
@@ -212,7 +172,7 @@ static bool dpp_pkex_get_started(struct l_dbus *dbus,
 				struct l_dbus_message_builder *builder,
 				void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	bool started = (dpp->state != DPP_STATE_NOTHING &&
 			dpp->interface == DPP_INTERFACE_PKEX);
 
@@ -226,7 +186,7 @@ static bool dpp_pkex_get_role(struct l_dbus *dbus,
 				struct l_dbus_message_builder *builder,
 				void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	const char *role;
 
 	if (dpp->state == DPP_STATE_NOTHING ||
@@ -246,7 +206,7 @@ static bool dpp_get_started(struct l_dbus *dbus,
 				struct l_dbus_message_builder *builder,
 				void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	bool started = (dpp->state != DPP_STATE_NOTHING &&
 			dpp->interface == DPP_INTERFACE_DPP);
 
@@ -260,7 +220,7 @@ static bool dpp_get_role(struct l_dbus *dbus,
 				struct l_dbus_message_builder *builder,
 				void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	const char *role;
 
 	if (dpp->state == DPP_STATE_NOTHING ||
@@ -280,7 +240,7 @@ static bool dpp_get_uri(struct l_dbus *dbus,
 				struct l_dbus_message_builder *builder,
 				void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	if (dpp->state == DPP_STATE_NOTHING ||
 				dpp->interface != DPP_INTERFACE_DPP)
@@ -290,7 +250,7 @@ static bool dpp_get_uri(struct l_dbus *dbus,
 	return true;
 }
 
-static void dpp_property_changed_notify(struct dpp_sm *dpp)
+static void dpp_property_changed_notify(struct dpp *dpp)
 {
 	const char *path = netdev_get_path(dpp->netdev);
 
@@ -340,26 +300,6 @@ static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
 	return ret;
 }
 
-static void dpp_free_pending_pkex_data(struct dpp_sm *dpp)
-{
-	if (dpp->pkex_id) {
-		l_free(dpp->pkex_id);
-		dpp->pkex_id = NULL;
-	}
-
-	if (dpp->pkex_key) {
-		l_free(dpp->pkex_key);
-		dpp->pkex_key = NULL;
-	}
-
-	memset(dpp->peer_addr, 0, sizeof(dpp->peer_addr));
-
-	if (dpp->peer_encr_key) {
-		l_ecc_point_free(dpp->peer_encr_key);
-		dpp->peer_encr_key = NULL;
-	}
-}
-
 static void pkex_agent_free(void *data)
 {
 	struct pkex_agent *agent = data;
@@ -370,7 +310,7 @@ static void pkex_agent_free(void *data)
 	l_free(agent);
 }
 
-static void dpp_agent_cancel(struct dpp_sm *dpp)
+static void dpp_agent_cancel(struct dpp *dpp)
 {
 	struct l_dbus_message *msg;
 
@@ -386,7 +326,7 @@ static void dpp_agent_cancel(struct dpp_sm *dpp)
 	l_dbus_send(dbus_get_bus(), msg);
 }
 
-static void dpp_agent_release(struct dpp_sm *dpp)
+static void dpp_agent_release(struct dpp *dpp)
 {
 	struct l_dbus_message *msg;
 
@@ -400,7 +340,7 @@ static void dpp_agent_release(struct dpp_sm *dpp)
 	l_dbus_send(dbus_get_bus(), msg);
 }
 
-static void dpp_destroy_agent(struct dpp_sm *dpp)
+static void dpp_destroy_agent(struct dpp *dpp)
 {
 	if (!dpp->agent)
 		return;
@@ -418,56 +358,7 @@ static void dpp_destroy_agent(struct dpp_sm *dpp)
 	dpp->agent = NULL;
 }
 
-static void dpp_free_auth_data(struct dpp_sm *dpp)
-{
-	if (dpp->own_proto_public) {
-		l_ecc_point_free(dpp->own_proto_public);
-		dpp->own_proto_public = NULL;
-	}
-
-	if (dpp->proto_private) {
-		l_ecc_scalar_free(dpp->proto_private);
-		dpp->proto_private = NULL;
-	}
-
-	if (dpp->peer_proto_public) {
-		l_ecc_point_free(dpp->peer_proto_public);
-		dpp->peer_proto_public = NULL;
-	}
-
-	if (dpp->peer_boot_public) {
-		l_ecc_point_free(dpp->peer_boot_public);
-		dpp->peer_boot_public = NULL;
-	}
-
-	if (dpp->m) {
-		l_ecc_scalar_free(dpp->m);
-		dpp->m = NULL;
-	}
-
-	if (dpp->pkex_m) {
-		l_ecc_point_free(dpp->pkex_m);
-		dpp->pkex_m = NULL;
-	}
-
-	if (dpp->y_or_x) {
-		l_ecc_point_free(dpp->y_or_x);
-		dpp->y_or_x = NULL;
-	}
-
-	if (dpp->pkex_public) {
-		l_ecc_point_free(dpp->pkex_public);
-		dpp->pkex_public = NULL;
-	}
-
-	if (dpp->pkex_private) {
-		l_ecc_scalar_free(dpp->pkex_private);
-		dpp->pkex_private = NULL;
-	}
-
-}
-
-static void dpp_reset(struct dpp_sm *dpp)
+static void dpp_reset(struct dpp *dpp)
 {
 	if (dpp->uri) {
 		l_free(dpp->uri);
@@ -499,11 +390,6 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->connect_scan_id = 0;
 	}
 
-	if (dpp->peer_asn1) {
-		l_free(dpp->peer_asn1);
-		dpp->peer_asn1 = NULL;
-	}
-
 	if (dpp->frame_pending) {
 		l_free(dpp->frame_pending);
 		dpp->frame_pending = NULL;
@@ -524,44 +410,23 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->connect_idle = NULL;
 	}
 
-	dpp->state = DPP_STATE_NOTHING;
 	dpp->new_freq = 0;
 	dpp->frame_retry = 0;
 	dpp->frame_cookie = 0;
-	dpp->pkex_version = 0;
-
-	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
-	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
-	explicit_bzero(dpp->e_nonce, dpp->nonce_len);
-	explicit_bzero(dpp->ke, dpp->key_len);
-	explicit_bzero(dpp->k1, dpp->key_len);
-	explicit_bzero(dpp->k2, dpp->key_len);
-	explicit_bzero(dpp->auth_tag, dpp->key_len);
-	explicit_bzero(dpp->z, dpp->key_len);
-	explicit_bzero(dpp->u, dpp->u_len);
 
 	dpp_destroy_agent(dpp);
 
-	dpp_free_pending_pkex_data(dpp);
-
-	dpp_free_auth_data(dpp);
-
 	dpp_property_changed_notify(dpp);
 
 	dpp->interface = DPP_INTERFACE_UNBOUND;
 }
 
-static void dpp_free(struct dpp_sm *dpp)
+static void dpp_free(struct dpp *dpp)
 {
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 
 	dpp_reset(dpp);
 
-	if (dpp->own_asn1) {
-		l_free(dpp->own_asn1);
-		dpp->own_asn1 = NULL;
-	}
-
 	if (dpp->boot_public) {
 		l_ecc_point_free(dpp->boot_public);
 		dpp->boot_public = NULL;
@@ -586,7 +451,7 @@ static void dpp_free(struct dpp_sm *dpp)
 
 static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	int err = l_genl_msg_get_error(msg);
 
 	if (err < 0) {
@@ -599,7 +464,7 @@ static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
 		l_error("Error parsing frame cookie");
 }
 
-static void dpp_send_frame(struct dpp_sm *dpp,
+static void dpp_send_frame(struct dpp *dpp,
 				struct iovec *iov, size_t iov_len,
 				uint32_t freq)
 {
@@ -632,7 +497,7 @@ static void dpp_send_frame(struct dpp_sm *dpp,
 	}
 }
 
-static void dpp_frame_retry(struct dpp_sm *dpp)
+static void dpp_frame_retry(struct dpp *dpp)
 {
 	struct iovec iov;
 
@@ -645,183 +510,6 @@ static void dpp_frame_retry(struct dpp_sm *dpp)
 	dpp->frame_pending = NULL;
 }
 
-
-static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
-				enum dpp_frame_type type,
-				uint8_t *buf)
-{
-	uint8_t *ptr = buf + 24;
-
-	memset(buf, 0, 32);
-
-	l_put_le16(0x00d0, buf);
-	memcpy(buf + 4, dest, 6);
-	memcpy(buf + 10, src, 6);
-	memcpy(buf + 16, broadcast, 6);
-
-	*ptr++ = 0x04;			/* Category: Public */
-	*ptr++ = 0x09;			/* Action: Vendor specific usage */
-	memcpy(ptr, wifi_alliance_oui, 3);
-	ptr += 3;
-	*ptr++ = 0x1a;			/* WiFi Alliance DPP OI type */
-	*ptr++ = 1;			/* Cryptosuite */
-	*ptr++ = type;
-
-	return ptr - buf;
-}
-
-static size_t dpp_build_config_header(const uint8_t *src, const uint8_t *dest,
-					uint8_t diag_token,
-					uint8_t *buf)
-{
-	uint8_t *ptr = buf + 24;
-
-	memset(buf, 0, 37);
-
-	l_put_le16(0x00d0, buf);
-	memcpy(buf + 4, dest, 6);
-	memcpy(buf + 10, src, 6);
-	memcpy(buf + 16, broadcast, 6);
-
-	*ptr++ = 0x04; /* Public */
-	*ptr++ = 0x0a; /* Action */
-	*ptr++ = diag_token;
-
-	*ptr++ = IE_TYPE_ADVERTISEMENT_PROTOCOL;
-	*ptr++ = 8; /* len */
-	*ptr++ = 0x00;
-	*ptr++ = IE_TYPE_VENDOR_SPECIFIC;
-	*ptr++ = 5;
-	memcpy(ptr, wifi_alliance_oui, 3);
-	ptr += 3;
-	*ptr++ = 0x1a;
-	*ptr++ = 1;
-
-	return ptr - buf;
-}
-
-static void dpp_protocol_timeout(struct l_timeout *timeout, void *user_data)
-{
-	struct dpp_sm *dpp = user_data;
-
-	l_debug("DPP timed out");
-
-	dpp_reset(dpp);
-}
-
-static void dpp_reset_protocol_timer(struct dpp_sm *dpp, uint32_t time)
-{
-	if (dpp->timeout)
-		l_timeout_modify(dpp->timeout, time);
-	else
-		dpp->timeout = l_timeout_create(time, dpp_protocol_timeout,
-						dpp, NULL);
-}
-
-/*
- * The configuration protocols use of AD components is somewhat confusing
- * since the request/response frames are of a different format than the rest.
- * In addition there are situations where the components length is zero yet it
- * is still passed as such to AES-SIV.
- *
- * For the configuration request/response frames:
- *
- * "AAD for use with AES-SIV for protected messages in the DPP Configuration
- * protocol shall consist of all octets in the Query Request and Query Response
- * fields up to the first octet of the Wrapped Data attribute, which is the last
- * attribute in a DPP Configuration frame. When the number of octets of AAD is
- * zero, the number of components of AAD passed to AES-SIV is zero."
- *
- *  - For configuration requests the optional query request field is not
- *    included, therefore no AAD data is passed. (dpp_configuration_start)
- *
- *  - The configuration response does contain a query response field which is
- *    5 bytes. (dpp_handle_config_response_frame)
- *
- * For the configuration result/status, the same rules are used as the
- * authentication protocol. This is reiterated in section 6.4.1.
- *
- *  - For the configuration result there is some confusion as to exactly how the
- *    second AAD component should be passed (since the spec specifically
- *    mentions using two components). There are no attributes prior to the
- *    wrapped data component meaning the length would be zero.
- *    Hostapd/wpa_supplicant pass a zero length AAD component to AES-SIV which
- *    does effect the resulting encryption/decryption so this is also what IWD
- *    will do to remain compliant with it.
- */
-static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
-{
-	const char *json = "{\"name\":\"IWD\",\"wi-fi_tech\":\"infra\","
-				"\"netRole\":\"sta\"}";
-	struct iovec iov;
-	uint8_t frame[512];
-	size_t json_len = strlen(json);
-	uint8_t *ptr = frame;
-	uint8_t *lptr;
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
-
-	memset(frame, 0, sizeof(frame));
-
-	l_getrandom(&dpp->diag_token, 1);
-
-	ptr += dpp_build_config_header(netdev_get_address(dpp->netdev),
-					addr, dpp->diag_token, ptr);
-
-	l_getrandom(dpp->e_nonce, dpp->nonce_len);
-
-	/* length */
-	lptr = ptr;
-	ptr += 2;
-
-	/*
-	 * "AAD for use with AES-SIV for protected messages in the DPP
-	 * Configuration protocol shall consist of all octets in the Query
-	 * Request and Query Response fields up to the first octet of the
-	 * Wrapped Data attribute"
-	 *
-	 * In this case there is no query request/response fields, nor any
-	 * attributes besides wrapped data meaning zero AD components.
-	 */
-	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
-			dpp->ke, dpp->key_len, 2,
-			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce,
-			DPP_ATTR_CONFIGURATION_REQUEST, json_len, json);
-
-	l_put_le16(ptr - lptr - 2, lptr);
-
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
-
-	dpp->state = DPP_STATE_CONFIGURING;
-
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-}
-
-static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
-{
-	struct iovec iov;
-	uint8_t frame[256];
-	uint8_t *ptr = frame;
-	uint8_t zero = 0;
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
-
-	memset(frame, 0, sizeof(frame));
-
-	ptr += dpp_build_header(netdev_get_address(dpp->netdev), to,
-					DPP_FRAME_CONFIGURATION_RESULT, ptr);
-	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
-			dpp->ke, dpp->key_len, 2,
-			DPP_ATTR_STATUS, (size_t) 1, &zero,
-			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce);
-
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
-
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-}
-
 static void dpp_write_config(struct dpp_configuration *config,
 				struct network *network)
 {
@@ -862,2600 +550,250 @@ static void dpp_scan_triggered(int err, void *user_data)
 
 static void dpp_start_connect(struct l_idle *idle, void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
-	struct scan_bss *bss;
-	struct network *network;
-	int ret;
-
-	network = station_network_find(station, dpp->config->ssid,
-					SECURITY_PSK);
-
-	dpp_reset(dpp);
-
-	if (!network) {
-		l_debug("Network was not found!");
-		return;
-	}
-
-	l_debug("connecting to %s from DPP", network_get_ssid(network));
-
-	bss = network_bss_select(network, true);
-	ret = network_autoconnect(network, bss);
-	if (ret < 0)
-		l_warn("failed to connect after DPP (%d) %s", ret,
-			strerror(-ret));
-}
-
-static bool dpp_scan_results(int err, struct l_queue *bss_list,
-				const struct scan_freq_set *freqs,
-				void *userdata)
-{
-	struct dpp_sm *dpp = userdata;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
-
-	if (err < 0)
-		goto reset;
-
-	if (!bss_list || l_queue_length(bss_list) == 0)
-		goto reset;
-
-	/*
-	 * The station watch _should_ detect this and reset, which cancels the
-	 * scan. But just in case...
-	 */
-	if (L_WARN_ON(station_get_connected_network(station)))
-		goto reset;
-
-	station_set_scan_results(station, bss_list, freqs, false);
-
-	dpp_start_connect(NULL, dpp);
-
-	return true;
-
-reset:
-	return false;
-}
-
-static void dpp_scan_destroy(void *userdata)
-{
-	struct dpp_sm *dpp = userdata;
-
-	dpp->connect_scan_id = 0;
-	dpp_reset(dpp);
-}
-
-static void dpp_known_network_watch(enum known_networks_event event,
-					const struct network_info *info,
-					void *user_data)
-{
-	struct dpp_sm *dpp = user_data;
-
-	/*
-	 * Check the following
-	 *  - DPP is enrolling
-	 *  - DPP finished (dpp->config is set)
-	 *  - This is for the network DPP just configured
-	 *  - DPP isn't already trying to connect (e.g. if the profile was
-	 *    immediately modified after DPP synced it).
-	 *  - DPP didn't start a scan for the network.
-	 */
-	if (dpp->role != DPP_CAPABILITY_ENROLLEE)
-		return;
-	if (!dpp->config)
-		return;
-	if (strcmp(info->ssid, dpp->config->ssid))
-		return;
-	if (dpp->connect_idle)
-		return;
-	if (dpp->connect_scan_id)
-		return;
-
-	switch (event) {
-	case KNOWN_NETWORKS_EVENT_ADDED:
-	case KNOWN_NETWORKS_EVENT_UPDATED:
-		/*
-		 * network.c takes care of updating the settings for the
-		 * network. This callback just tells us to begin the connection.
-		 * We do have use an idle here because there is no strict
-		 * guarantee of ordering between known network events, e.g. DPP
-		 * could have been called into prior to network and the network
-		 * object isn't updated yet.
-		 */
-		dpp->connect_idle = l_idle_create(dpp_start_connect, dpp, NULL);
-		break;
-	case KNOWN_NETWORKS_EVENT_REMOVED:
-		l_warn("profile was removed before DPP could connect");
-		break;
-	}
-}
-
-static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
-				const void *body, size_t body_len,
-				int rssi, void *user_data)
-{
-	struct dpp_sm *dpp = user_data;
-	const uint8_t *ptr = body;
-	uint16_t status;
-	uint16_t fragmented; /* Fragmented/Comeback delay field */
-	uint8_t adv_protocol_element[] = { 0x6C, 0x08, 0x7F };
-	uint8_t adv_protocol_id[] = { 0xDD, 0x05, 0x50, 0x6F,
-					0x9A, 0x1A, 0x01 };
-	uint16_t query_len;
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	const char *json = NULL;
-	size_t json_len = 0;
-	int dstatus = -1;
-	const uint8_t *wrapped = NULL;
-	const uint8_t *e_nonce = NULL;
-	size_t wrapped_len = 0;
-	_auto_(l_free) uint8_t *unwrapped = NULL;
-	struct dpp_configuration *config;
+	struct dpp *dpp = user_data;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
-	struct network *network = NULL;
-	struct scan_bss *bss = NULL;
-
-	if (dpp->state != DPP_STATE_CONFIGURING)
-		return;
-
-	/*
-	 * Can a configuration request come from someone other than who you
-	 * authenticated to?
-	 */
-	if (memcmp(dpp->peer_addr, frame->address_2, 6))
-		return;
-
-	if (body_len < 19)
-		return;
-
-	ptr += 2;
-
-	if (*ptr++ != dpp->diag_token)
-		return;
-
-	status = l_get_le16(ptr);
-	ptr += 2;
-
-	if (status != 0) {
-		l_debug("Bad configuration status %u", status);
-		return;
-	}
-
-	fragmented = l_get_le16(ptr);
-	ptr += 2;
-
-	/*
-	 * TODO: handle 0x0001 (fragmented), as well as comeback delay.
-	 */
-	if (fragmented != 0) {
-		l_debug("Fragmented messages not currently supported");
-		return;
-	}
-
-	if (memcmp(ptr, adv_protocol_element, sizeof(adv_protocol_element))) {
-		l_debug("Invalid Advertisement protocol element");
-		return;
-	}
-
-	ptr += sizeof(adv_protocol_element);
-
-	if (memcmp(ptr, adv_protocol_id, sizeof(adv_protocol_id))) {
-		l_debug("Invalid Advertisement protocol ID");
-		return;
-	}
-
-	ptr += sizeof(adv_protocol_id);
-
-	query_len = l_get_le16(ptr);
-	ptr += 2;
-
-	if (query_len > body_len - 19)
-		return;
-
-	dpp_attr_iter_init(&iter, ptr, query_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_STATUS:
-			dstatus = l_get_u8(data);
-			break;
-		case DPP_ATTR_WRAPPED_DATA:
-			wrapped = data;
-			wrapped_len = len;
-			break;
-		default:
-			/*
-			 * TODO: CSR Attribute
-			 */
-			break;
-		}
-	}
-
-	if (dstatus != DPP_STATUS_OK || !wrapped) {
-		l_debug("Bad status or missing attributes");
-		return;
-	}
-
-	unwrapped = dpp_unwrap_attr(ptr, wrapped - ptr - 4, NULL, 0, dpp->ke,
-					dpp->key_len, wrapped, wrapped_len,
-					&wrapped_len);
-	if (!unwrapped) {
-		l_debug("Failed to unwrap");
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_ENROLLEE_NONCE:
-			if (len != dpp->nonce_len)
-				break;
-
-			if (memcmp(data, dpp->e_nonce, dpp->nonce_len))
-				break;
-
-			e_nonce = data;
-			break;
-		case DPP_ATTR_CONFIGURATION_OBJECT:
-			json = (const char *)data;
-			json_len = len;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!json || !e_nonce) {
-		l_debug("No configuration object in response");
-		return;
-	}
-
-	config = dpp_parse_configuration_object(json, json_len);
-	if (!config) {
-		l_error("Configuration object did not parse");
-		return;
-	}
-
-	/*
-	 * We should have a station device, but if not DPP can write the
-	 * credentials out and be done
-	 */
-	if (station) {
-		network = station_network_find(station, config->ssid,
-						SECURITY_PSK);
-		if (network)
-			bss = network_bss_select(network, true);
-	}
-
-	dpp_write_config(config, network);
-
-	send_config_result(dpp, dpp->peer_addr);
-
-	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
-
-	if (network && bss) {
-		l_debug("delaying connect until settings are synced");
-		dpp->config = config;
-		return;
-	} else if (station) {
-		struct scan_parameters params = {0};
-
-		params.ssid = (void *) config->ssid;
-		params.ssid_len = config->ssid_len;
-
-		l_debug("Scanning for %s", config->ssid);
-
-		dpp->connect_scan_id = scan_active_full(dpp->wdev_id, &params,
-						dpp_scan_triggered,
-						dpp_scan_results, dpp,
-						dpp_scan_destroy);
-		if (dpp->connect_scan_id) {
-			dpp->config = config;
-			return;
-		}
-	}
-
-	dpp_configuration_free(config);
-	dpp_reset(dpp);
-}
-
-static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
-{
-	_auto_(l_free) char *json = NULL;
-	struct iovec iov;
-	uint8_t frame[512];
-	size_t json_len;
-	uint8_t *ptr = frame;
-	uint8_t *lptr;
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
-
-	memset(frame, 0, sizeof(frame));
-
-	l_put_le16(0x00d0, ptr);
-	memcpy(ptr + 4, dpp->peer_addr, 6);
-	memcpy(ptr + 10, netdev_get_address(dpp->netdev), 6);
-	memcpy(ptr + 16, broadcast, 6);
-
-	ptr += 24;
-
-	*ptr++ = 0x04;
-	*ptr++ = 0x0b;
-	*ptr++ = dpp->diag_token;
-	l_put_le16(0, ptr); /* status */
-	ptr += 2;
-	l_put_le16(0, ptr); /* fragmented (no) */
-	ptr += 2;
-	*ptr++ = IE_TYPE_ADVERTISEMENT_PROTOCOL;
-	*ptr++ = 0x08;
-	*ptr++ = 0x7f;
-	*ptr++ = IE_TYPE_VENDOR_SPECIFIC;
-	*ptr++ = 5;
-	memcpy(ptr, wifi_alliance_oui, sizeof(wifi_alliance_oui));
-	ptr += sizeof(wifi_alliance_oui);
-	*ptr++ = 0x1a;
-	*ptr++ = 1;
-
-	lptr = ptr;
-	ptr += 2; /* length */
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
-
-	/*
-	 * There are several failure status codes that can be used (defined in
-	 * 6.4.3.1), each with their own set of attributes that should be
-	 * included. For now IWD's basic DPP implementation will assume
-	 * STATUS_CONFIGURE_FAILURE which only includes the E-Nonce.
-	 */
-	if (status == DPP_STATUS_OK) {
-		json = dpp_configuration_to_json(dpp->config);
-		json_len = strlen(json);
-
-		ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-				sizeof(frame) - mmpdu_header_len(hdr) - 1,
-				ptr, dpp->ke, dpp->key_len, 2,
-				DPP_ATTR_ENROLLEE_NONCE,
-				dpp->nonce_len, dpp->e_nonce,
-				DPP_ATTR_CONFIGURATION_OBJECT,
-				json_len, json);
-	} else
-		ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-				sizeof(frame) - mmpdu_header_len(hdr) - 1,
-				ptr, dpp->ke, dpp->key_len, 2,
-				DPP_ATTR_ENROLLEE_NONCE,
-				dpp->nonce_len, dpp->e_nonce);
-
-	l_put_le16(ptr - lptr - 2, lptr);
-
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
-
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-}
-
-static bool dpp_check_config_header(const uint8_t *ptr)
-{
-	/*
-	 * Table 58. General Format of DPP Configuration Request frame
-	 *
-	 * Unfortunately wpa_supplicant hard codes 0x7f as the Query Response
-	 * Info so we need to handle both cases.
-	 */
-	return ptr[0] == IE_TYPE_ADVERTISEMENT_PROTOCOL &&
-			ptr[1] == 0x08 &&
-			(ptr[2] == 0x7f || ptr[2] == 0x00) &&
-			ptr[3] == IE_TYPE_VENDOR_SPECIFIC &&
-			ptr[4] == 5;
-}
-
-static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
-				const void *body, size_t body_len,
-				int rssi, void *user_data)
-{
-	struct dpp_sm *dpp = user_data;
-	const uint8_t *ptr = body;
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	const char *json = NULL;
-	size_t json_len = 0;
-	struct json_contents *c;
-	const uint8_t *wrapped = NULL;
-	const uint8_t *e_nonce = NULL;
-	size_t wrapped_len = 0;
-	_auto_(l_free) uint8_t *unwrapped = NULL;
-	struct json_iter jsiter;
-	_auto_(l_free) char *tech = NULL;
-	_auto_(l_free) char *role = NULL;
-
-	if (dpp->state != DPP_STATE_AUTHENTICATING) {
-		l_debug("Configuration request in wrong state");
-		return;
-	}
-
-	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
-		return;
-
-	if (memcmp(dpp->peer_addr, frame->address_2, 6)) {
-		l_debug("Configuration request not from authenticated peer");
-		return;
-	}
-
-	if (body_len < 15) {
-		l_debug("Configuration request data not long enough");
-		return;
-	}
-
-	ptr += 2;
-
-	dpp->diag_token = *ptr++;
-
-	if (!dpp_check_config_header(ptr))
-		return;
-
-	ptr += 5;
-
-	if (memcmp(ptr, wifi_alliance_oui, sizeof(wifi_alliance_oui)))
-		return;
-
-	ptr += sizeof(wifi_alliance_oui);
-
-	if (*ptr != 0x1a && *(ptr + 1) != 1)
-		return;
-
-	ptr += 2;
-
-	len = l_get_le16(ptr);
-	ptr += 2;
-
-	if (len > body_len - 15)
-		return;
-
-	dpp_attr_iter_init(&iter, ptr, len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_WRAPPED_DATA:
-			wrapped = data;
-			wrapped_len = len;
-			break;
-		default:
-			/* Wrapped data should be only attribute */
-			return;
-		}
-	}
-
-	if (!wrapped) {
-		l_debug("Wrapped data missing");
-		return;
-	}
-
-	unwrapped = dpp_unwrap_attr(NULL, 0, NULL, 0, dpp->ke,
-					dpp->key_len, wrapped, wrapped_len,
-					&wrapped_len);
-	if (!unwrapped) {
-		l_debug("Failed to unwrap");
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_ENROLLEE_NONCE:
-			if (len != dpp->nonce_len)
-				break;
-
-			e_nonce = data;
-			break;
-		case DPP_ATTR_CONFIGURATION_REQUEST:
-			json = (const char *)data;
-			json_len = len;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!json || !e_nonce) {
-		l_debug("No configuration object in response");
-		return;
-	}
-
-	c = json_contents_new(json, json_len);
-	if (!c) {
-		json_contents_free(c);
-		return;
-	}
-
-	json_iter_init(&jsiter, c);
-
-	/*
-	 * Check mandatory values (Table 7). There isn't much that can be done
-	 * with these, but the spec requires they be included.
-	 */
-	if (!json_iter_parse(&jsiter,
-			JSON_MANDATORY("name", JSON_STRING, NULL),
-			JSON_MANDATORY("wi-fi_tech", JSON_STRING, &tech),
-			JSON_MANDATORY("netRole", JSON_STRING, &role),
-			JSON_UNDEFINED))
-		goto configure_failure;
-
-	if (strcmp(tech, "infra"))
-		goto configure_failure;
-
-	if (strcmp(role, "sta"))
-		goto configure_failure;
-
-	json_contents_free(c);
-
-	memcpy(dpp->e_nonce, e_nonce, dpp->nonce_len);
-
-	dpp->state = DPP_STATE_CONFIGURING;
-
-	dpp_send_config_response(dpp, DPP_STATUS_OK);
-
-	return;
-
-configure_failure:
-	dpp_send_config_response(dpp, DPP_STATUS_CONFIGURE_FAILURE);
-	/*
-	 * The other peer is still authenticated, and can potentially send
-	 * additional requests so keep this session alive.
-	 */
-}
-
-static void dpp_handle_config_result_frame(struct dpp_sm *dpp,
-					const uint8_t *from, const void *body,
-					size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	int status = -1;
-	const void *e_nonce = NULL;
-	const void *wrapped = NULL;
-	size_t wrapped_len;
-	_auto_(l_free) void *unwrapped = NULL;
-
-	if (dpp->state != DPP_STATE_CONFIGURING)
-		return;
-
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_WRAPPED_DATA:
-			wrapped = data;
-			wrapped_len = len;
-			break;
-		default:
-			/* Wrapped data should be only attribute */
-			return;
-		}
-	}
-
-	if (!wrapped)
-		return;
-
-	unwrapped = dpp_unwrap_attr(body + 2, wrapped - body - 6, wrapped, 0,
-					dpp->ke, dpp->key_len, wrapped,
-					wrapped_len, &wrapped_len);
-	if (!unwrapped) {
-		l_debug("Failed to unwrap DPP configuration result");
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_STATUS:
-			status = l_get_u8(data);
-			break;
-		case DPP_ATTR_ENROLLEE_NONCE:
-			e_nonce = data;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (status != DPP_STATUS_OK || !e_nonce)
-		l_debug("Enrollee signaled a failed configuration");
-	else
-		l_debug("Configuration success");
-
-	dpp_reset(dpp);
-}
-
-/*
- * The Authentication protocol has a consistent use of AD components, and this
- * use is defined in 6.3.1.4:
- *
- * "Invocations of AES-SIV in the DPP Authentication protocol that produce
- * ciphertext that is part of an additional AES-SIV invocation do not use AAD;
- * in other words, the number of AAD components is set to zero. All other
- * invocations of AES-SIV in the DPP Authentication protocol shall pass a vector
- * of AAD having two components of AAD in the following order: (1) the DPP
- * header, as defined in Table 30, from the OUI field (inclusive) to the DPP
- * Frame Type field (inclusive); and (2) all octets in a DPP Public Action frame
- * after the DPP Frame Type field up to and including the last octet of the last
- * attribute before the Wrapped Data attribute"
- *
- * In practice you see this as AD0 being some offset in the frame (offset to the
- * OUI). For outgoing packets this is 26 bytes offset since the header is built
- * manually. For incoming packets the offset is 2 bytes. The length is always
- * 6 bytes for AD0.
- *
- * The AD1 data is always the start of the attributes, and length is the number
- * of bytes from these attributes to wrapped data. e.g.
- *
- * ad1 = attrs
- * ad1_len = ptr - attrs
- */
-static void send_authenticate_response(struct dpp_sm *dpp)
-{
-	uint8_t frame[512];
-	uint8_t *ptr = frame;
-	uint8_t status = DPP_STATUS_OK;
-	uint8_t version = 2;
-	struct iovec iov;
-	uint8_t wrapped2_plaintext[dpp->key_len + 4];
-	uint8_t wrapped2[dpp->key_len + 16 + 8];
-	size_t wrapped2_len;
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
-
-	memset(frame, 0, sizeof(frame));
-
-	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
-				dpp->peer_addr,
-				DPP_FRAME_AUTHENTICATION_RESPONSE, ptr);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
-				dpp->own_boot_hash, 32);
-	if (dpp->mutual_auth)
-		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
-				dpp->peer_boot_hash, 32);
-	ptr += dpp_append_point(ptr, DPP_ATTR_RESPONDER_PROTOCOL_KEY,
-				dpp->own_proto_public);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
-
-	/* Wrap up secondary data (R-Auth) */
-	wrapped2_len = dpp_append_attr(wrapped2_plaintext,
-					DPP_ATTR_RESPONDER_AUTH_TAG,
-					dpp->auth_tag, dpp->key_len);
-	/*
-	 * "Invocations of AES-SIV in the DPP Authentication protocol that
-	 * produce ciphertext that is part of an additional AES-SIV invocation
-	 * do not use AAD; in other words, the number of AAD components is set
-	 * to zero.""
-	 */
-	if (!aes_siv_encrypt(dpp->ke, dpp->key_len, wrapped2_plaintext,
-					dpp->key_len + 4, NULL, 0, wrapped2)) {
-		l_error("Failed to encrypt wrapped data");
-		return;
-	}
-
-	wrapped2_len += 16;
-
-	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
-			dpp->k2, dpp->key_len, 4,
-			DPP_ATTR_RESPONDER_NONCE, dpp->nonce_len, dpp->r_nonce,
-			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
-			DPP_ATTR_RESPONDER_CAPABILITIES, (size_t) 1, &dpp->role,
-			DPP_ATTR_WRAPPED_DATA, wrapped2_len, wrapped2);
-
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
-
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-}
-
-static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
-					const uint8_t *body, size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	int status = -1;
-	const uint8_t *r_boot_hash = NULL;
-	const void *wrapped = NULL;
-	const uint8_t *i_auth = NULL;
-	size_t i_auth_len;
-	_auto_(l_free) uint8_t *unwrapped = NULL;
-	size_t wrapped_len = 0;
-	uint64_t i_auth_check[L_ECC_MAX_DIGITS];
-	const void *unwrap_key;
-	const void *ad0 = body + 2;
-	const void *ad1 = body + 8;
-	struct l_ecc_point *bi = NULL;
-
-	if (dpp->state != DPP_STATE_AUTHENTICATING)
-		return;
-
-	if (memcmp(from, dpp->peer_addr, 6))
-		return;
-
-	l_debug("authenticate confirm");
-
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_STATUS:
-			status = l_get_u8(data);
-			break;
-		case DPP_ATTR_RESPONDER_BOOT_KEY_HASH:
-			r_boot_hash = data;
-			/*
-			 * Spec requires this, but does not mention if anything
-			 * is to be done with it.
-			 */
-			break;
-		case DPP_ATTR_INITIATOR_BOOT_KEY_HASH:
-			/* No mutual authentication */
-			break;
-		case DPP_ATTR_WRAPPED_DATA:
-			wrapped = data;
-			wrapped_len = len;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!r_boot_hash || !wrapped) {
-		l_debug("Attributes missing from authenticate confirm");
-		return;
-	}
-
-	/*
-	 * "The Responder obtains the DPP Authentication Confirm frame and
-	 * checks the value of the DPP Status field. If the value of the DPP
-	 * Status field is STATUS_NOT_COMPATIBLE or STATUS_AUTH_FAILURE, the
-	 * Responder unwraps the wrapped data portion of the frame using k2"
-	 */
-	if (status == DPP_STATUS_OK)
-		unwrap_key = dpp->ke;
-	else if (status == DPP_STATUS_NOT_COMPATIBLE ||
-				status == DPP_STATUS_AUTH_FAILURE)
-		unwrap_key = dpp->k2;
-	else
-		goto auth_confirm_failed;
-
-	unwrapped = dpp_unwrap_attr(ad0, 6, ad1, wrapped - 4 - ad1,
-			unwrap_key, dpp->key_len, wrapped, wrapped_len,
-			&wrapped_len);
-	if (!unwrapped)
-		goto auth_confirm_failed;
-
-	if (status != DPP_STATUS_OK) {
-		/*
-		 * "If unwrapping is successful, the Responder should generate
-		 * an alert indicating the reason for the protocol failure."
-		 */
-		l_debug("Authentication failed due to status %s",
-				status == DPP_STATUS_NOT_COMPATIBLE ?
-				"NOT_COMPATIBLE" : "AUTH_FAILURE");
-		goto auth_confirm_failed;
-	}
-
-	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_INITIATOR_AUTH_TAG:
-			i_auth = data;
-			i_auth_len = len;
-			break;
-		case DPP_ATTR_RESPONDER_NONCE:
-			/* Only if error */
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!i_auth || i_auth_len != dpp->key_len) {
-		l_debug("I-Auth missing from wrapped data");
-		goto auth_confirm_failed;
-	}
-
-	if (dpp->mutual_auth)
-		bi = dpp->peer_boot_public;
-
-	dpp_derive_i_auth(dpp->r_nonce, dpp->i_nonce, dpp->nonce_len,
-				dpp->own_proto_public, dpp->peer_proto_public,
-				dpp->boot_public, bi, i_auth_check);
-
-	if (memcmp(i_auth, i_auth_check, i_auth_len)) {
-		l_error("I-Auth did not verify");
-		goto auth_confirm_failed;
-	}
-
-	l_debug("Authentication successful");
-
-	dpp_reset_protocol_timer(dpp, DPP_AUTH_PROTO_TIMEOUT);
-
-	if (dpp->role == DPP_CAPABILITY_ENROLLEE)
-		dpp_configuration_start(dpp, from);
-
-	return;
-
-auth_confirm_failed:
-	dpp->state = DPP_STATE_PRESENCE;
-	dpp_free_auth_data(dpp);
-}
-
-static void dpp_auth_request_failed(struct dpp_sm *dpp,
-					enum dpp_status status,
-					void *k1)
-{
-	uint8_t frame[128];
-	uint8_t *ptr = frame;
-	uint8_t version = 2;
-	uint8_t s = status;
-	struct iovec iov;
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
-
-	memset(frame, 0, sizeof(frame));
-
-	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
-				dpp->peer_addr,
-				DPP_FRAME_AUTHENTICATION_RESPONSE, ptr);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &s, 1);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
-				dpp->own_boot_hash, 32);
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
-
-	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
-			k1, dpp->key_len, 2,
-			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
-			DPP_ATTR_RESPONDER_CAPABILITIES,
-			(size_t) 1, &dpp->role);
-
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
-
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-}
-
-static bool dpp_check_roles(struct dpp_sm *dpp, uint8_t peer_capa)
-{
-	if (dpp->role == DPP_CAPABILITY_ENROLLEE &&
-			!(peer_capa & DPP_CAPABILITY_CONFIGURATOR))
-		return false;
-	else if (dpp->role == DPP_CAPABILITY_CONFIGURATOR &&
-			!(peer_capa & DPP_CAPABILITY_ENROLLEE))
-		return false;
-
-	return true;
-}
-
-static void dpp_presence_announce(struct dpp_sm *dpp)
-{
-	struct netdev *netdev = dpp->netdev;
-	uint8_t hdr[32];
-	uint8_t attrs[32 + 4];
-	uint8_t hash[32];
-	uint8_t *ptr = attrs;
-	const uint8_t *addr = netdev_get_address(netdev);
-	struct iovec iov[2];
-
-	iov[0].iov_len = dpp_build_header(addr, broadcast,
-					DPP_FRAME_PRESENCE_ANNOUNCEMENT, hdr);
-	iov[0].iov_base = hdr;
-
-	dpp_hash(L_CHECKSUM_SHA256, hash, 2, "chirp", strlen("chirp"),
-			dpp->own_asn1, dpp->own_asn1_len);
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH, hash, 32);
-
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
-
-	l_debug("Sending presence announcement on frequency %u and waiting %u",
-		dpp->current_freq, dpp->dwell);
-
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
-}
-
-static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
-{
-	uint8_t frame[256];
-	uint8_t *ptr = frame;
-	uint8_t version = 2;
-	struct iovec iov;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
-	struct scan_bss *bss = station_get_connected_bss(station);
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
-
-	memset(frame, 0, sizeof(frame));
-
-	/* Got disconnected by the time the peer was discovered */
-	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR && !bss) {
-		dpp_reset(dpp);
-		return false;
-	}
-
-	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
-				dpp->peer_addr,
-				DPP_FRAME_AUTHENTICATION_REQUEST, ptr);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
-				dpp->peer_boot_hash, 32);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
-				dpp->own_boot_hash, 32);
-	ptr += dpp_append_point(ptr, DPP_ATTR_INITIATOR_PROTOCOL_KEY,
-				dpp->own_proto_public);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
-
-	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR &&
-					dpp->current_freq != bss->frequency) {
-		uint8_t pair[2] = { 81,
-				band_freq_to_channel(bss->frequency, NULL) };
-
-		ptr += dpp_append_attr(ptr, DPP_ATTR_CHANNEL, pair, 2);
-	}
-
-	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
-			dpp->k1, dpp->key_len, 2,
-			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
-			DPP_ATTR_INITIATOR_CAPABILITIES,
-			(size_t) 1, &dpp->role);
-
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
-
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-
-	return true;
-}
-
-static void dpp_send_pkex_exchange_request(struct dpp_sm *dpp)
-{
-	uint8_t hdr[32];
-	uint8_t attrs[256];
-	uint8_t *ptr = attrs;
-	uint16_t group;
-	struct iovec iov[2];
-	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
-
-	l_put_le16(l_ecc_curve_get_ike_group(dpp->curve), &group);
-
-	iov[0].iov_len = dpp_build_header(own_mac, broadcast,
-				DPP_FRAME_PKEX_VERSION1_XCHG_REQUEST, hdr);
-	iov[0].iov_base = hdr;
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION,
-				&dpp->pkex_version, 1);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_FINITE_CYCLIC_GROUP,
-				&group, 2);
-
-	if (dpp->pkex_id)
-		ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
-					dpp->pkex_id, strlen(dpp->pkex_id));
-
-	ptr += dpp_append_point(ptr, DPP_ATTR_ENCRYPTED_KEY, dpp->pkex_m);
-
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
-
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
-}
-
-static void dpp_send_commit_reveal_request(struct dpp_sm *dpp)
-{
-	struct iovec iov;
-	uint8_t frame[512];
-	uint8_t *ptr = frame;
-	uint8_t a_pub[L_ECC_POINT_MAX_BYTES];
-	ssize_t a_len;
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
-
-	memset(frame, 0, sizeof(frame));
-
-	a_len = l_ecc_point_get_data(dpp->boot_public, a_pub, sizeof(a_pub));
-
-	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
-					dpp->peer_addr,
-					DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST,
-					ptr);
-	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
-			dpp->z, dpp->z_len, 2,
-			DPP_ATTR_BOOTSTRAPPING_KEY, a_len, a_pub,
-			DPP_ATTR_INITIATOR_AUTH_TAG, dpp->u_len, dpp->u);
-
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
-
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-}
-
-static void dpp_roc_started(void *user_data)
-{
-	struct dpp_sm *dpp = user_data;
-
-	/*
-	 * - If a configurator, nothing to do but wait for a request
-	 *   (unless multicast frame registration is unsupported in which case
-	 *   send an authenticate request now)
-	 * - If in the presence state continue sending announcements.
-	 * - If authenticating, and this is a result of a channel switch send
-	 *   the authenticate response now.
-	 */
-
-	dpp->roc_started = true;
-
-	/*
-	 * The retry timer indicates a frame was not acked in which case we
-	 * should not change any state or send any frames until that expires.
-	 */
-	if (dpp->retry_timeout)
-		return;
-
-	if (dpp->frame_pending) {
-		dpp_frame_retry(dpp);
-		return;
-	}
-
-	switch (dpp->state) {
-	case DPP_STATE_PRESENCE:
-		if (dpp->role == DPP_CAPABILITY_CONFIGURATOR)
-			return;
-
-		if (dpp->pending) {
-			struct l_dbus_message *reply =
-				l_dbus_message_new_method_return(dpp->pending);
-
-			l_dbus_message_set_arguments(reply, "s", dpp->uri);
-
-			dbus_pending_reply(&dpp->pending, reply);
-		}
-
-		dpp_presence_announce(dpp);
-		break;
-	case DPP_STATE_AUTHENTICATING:
-		/*
-		 * No multicast frame registration support, jump right into
-		 * sending auth frames. This diverges from the 2.0 spec, but in
-		 * reality the the main path nearly all drivers will hit.
-		 */
-		if (dpp->role == DPP_CAPABILITY_CONFIGURATOR) {
-			if (dpp->mcast_support)
-				return;
-
-			dpp_send_authenticate_request(dpp);
-			return;
-		}
-
-		if (dpp->new_freq) {
-			dpp->current_freq = dpp->new_freq;
-			dpp->new_freq = 0;
-			send_authenticate_response(dpp);
-		}
-
-		break;
-	case DPP_STATE_PKEX_EXCHANGE:
-		if (dpp->role == DPP_CAPABILITY_ENROLLEE)
-			dpp_send_pkex_exchange_request(dpp);
-
-		break;
-	case DPP_STATE_PKEX_COMMIT_REVEAL:
-		if (dpp->role == DPP_CAPABILITY_ENROLLEE)
-			dpp_send_commit_reveal_request(dpp);
-
-		break;
-	default:
-		break;
-	}
-}
-
-static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq);
-
-static void dpp_offchannel_timeout(int error, void *user_data)
-{
-	struct dpp_sm *dpp = user_data;
-
-	dpp->offchannel_id = 0;
-	dpp->roc_started = false;
-
-	/*
-	 * If cancelled this is likely due to netdev going down or from Stop().
-	 * Otherwise there was some other problem which is probably not
-	 * recoverable.
-	 */
-	if (error == -ECANCELED)
-		return;
-	else if (error == -EIO)
-		goto next_roc;
-	else if (error < 0)
-		goto protocol_failed;
-
-	switch (dpp->state) {
-	case DPP_STATE_PKEX_EXCHANGE:
-		if (dpp->role != DPP_CAPABILITY_CONFIGURATOR || !dpp->agent)
-			break;
-
-		/*
-		 * We have a pending agent request but it did not arrive in
-		 * time, we cant assume the enrollee will be waiting around
-		 * for our response so cancel the request and continue waiting
-		 * for another request
-		 */
-		if (dpp->agent->pending_id) {
-			dpp_free_pending_pkex_data(dpp);
-			dpp_agent_cancel(dpp);
-		}
-		/* Fall through */
-	case DPP_STATE_PRESENCE:
-		break;
-	case DPP_STATE_NOTHING:
-		/* Protocol already terminated */
-		return;
-	case DPP_STATE_AUTHENTICATING:
-	case DPP_STATE_CONFIGURING:
-	case DPP_STATE_PKEX_COMMIT_REVEAL:
-		goto next_roc;
-	}
-
-	dpp->freqs_idx++;
-
-	if (dpp->freqs_idx >= dpp->freqs_len) {
-		l_debug("Max retries offchannel");
-		dpp->freqs_idx = 0;
-	}
-
-	dpp->current_freq = dpp->freqs[dpp->freqs_idx];
-
-	l_debug("Offchannel timeout, moving to next frequency %u, duration %u",
-			dpp->current_freq, dpp->dwell);
-
-next_roc:
-	dpp_start_offchannel(dpp, dpp->current_freq);
-
-	return;
-
-protocol_failed:
-	dpp_reset(dpp);
-}
-
-static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq)
-{
-	/*
-	 * This needs to be handled carefully for a few reasons:
-	 *
-	 * First, the next offchannel operation needs to be started prior to
-	 * canceling an existing one. This is so the offchannel work can
-	 * continue uninterrupted without any other work items starting in
-	 * between canceling and starting the next (e.g. if a scan request is
-	 * sitting in the queue).
-	 *
-	 * Second, dpp_offchannel_timeout resets dpp->offchannel_id to zero
-	 * which is why the new ID is saved and only set to dpp->offchannel_id
-	 * once the previous offchannel work is cancelled (i.e. destroy() has
-	 * been called).
-	 */
-	uint32_t id = offchannel_start(netdev_get_wdev_id(dpp->netdev),
-				WIPHY_WORK_PRIORITY_OFFCHANNEL,
-				freq, dpp->dwell, dpp_roc_started,
-				dpp, dpp_offchannel_timeout);
-
-	if (dpp->offchannel_id)
-		offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
-
-	dpp->offchannel_id = id;
-}
-
-static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
-					const uint8_t *body, size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	const uint8_t *r_boot = NULL;
-	const uint8_t *i_boot = NULL;
-	const uint8_t *i_proto = NULL;
-	const void *wrapped = NULL;
-	const uint8_t *i_nonce = NULL;
-	uint8_t i_capa = 0;
-	size_t r_boot_len = 0, i_proto_len = 0, wrapped_len = 0;
-	size_t i_nonce_len = 0;
-	_auto_(l_free) uint8_t *unwrapped = NULL;
-	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *m = NULL;
-	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
-	struct l_ecc_point *bi = NULL;
-	uint64_t k1[L_ECC_MAX_DIGITS];
-	const void *ad0 = body + 2;
-	const void *ad1 = body + 8;
-	uint32_t freq;
-
-	if (util_is_broadcast_address(from))
-		return;
-
-	if (dpp->state != DPP_STATE_PRESENCE &&
-				dpp->state != DPP_STATE_AUTHENTICATING)
-		return;
-
-	l_debug("authenticate request");
-
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_INITIATOR_BOOT_KEY_HASH:
-			i_boot = data;
-			/*
-			 * This attribute is required by the spec, but only
-			 * used for mutual authentication.
-			 */
-			break;
-		case DPP_ATTR_RESPONDER_BOOT_KEY_HASH:
-			r_boot = data;
-			r_boot_len = len;
-			break;
-		case DPP_ATTR_INITIATOR_PROTOCOL_KEY:
-			i_proto = data;
-			i_proto_len = len;
-			break;
-		case DPP_ATTR_WRAPPED_DATA:
-			/* I-Nonce/I-Capabilities part of wrapped data */
-			wrapped = data;
-			wrapped_len = len;
-			break;
-
-		/* Optional attributes */
-		case DPP_ATTR_PROTOCOL_VERSION:
-			if (l_get_u8(data) != 2) {
-				l_debug("Protocol version did not match");
-				return;
-			}
-
-			break;
-
-		case DPP_ATTR_CHANNEL:
-			if (len != 2)
-				return;
-
-			freq = oci_to_frequency(l_get_u8(data),
-						l_get_u8(data + 1));
-
-			if (freq == dpp->current_freq)
-				break;
-
-			/*
-			 * Configurators are already connected to a network, so
-			 * to preserve wireless performance the enrollee will
-			 * be required to be on this channel, not a channel it
-			 * requests.
-			 */
-			if (dpp->role == DPP_CAPABILITY_CONFIGURATOR)
-				return;
-
-			/*
-			 * Otherwise, as an enrollee, we can jump to whatever
-			 * channel the configurator requests
-			 */
-			dpp->new_freq = freq;
-
-			l_debug("Configurator requested a new frequency %u",
-					dpp->new_freq);
-
-			dpp_start_offchannel(dpp, dpp->new_freq);
-
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!r_boot || !i_boot || !i_proto || !wrapped)
-		goto auth_request_failed;
-
-	if (r_boot_len != 32 || memcmp(dpp->own_boot_hash,
-					r_boot, r_boot_len)) {
-		l_debug("Responder boot key hash failed to verify");
-		goto auth_request_failed;
-	}
-
-	dpp->peer_proto_public = l_ecc_point_from_data(dpp->curve,
-						L_ECC_POINT_TYPE_FULL,
-						i_proto, i_proto_len);
-	if (!dpp->peer_proto_public) {
-		l_debug("Initiators protocol key invalid");
-		goto auth_request_failed;
-	}
-
-	m = dpp_derive_k1(dpp->peer_proto_public, dpp->boot_private, k1);
-	if (!m)
-		goto auth_request_failed;
-
-	unwrapped = dpp_unwrap_attr(ad0, 6, ad1, wrapped - 4 - ad1,
-			k1, dpp->key_len, wrapped, wrapped_len, &wrapped_len);
-	if (!unwrapped)
-		goto auth_request_failed;
-
-	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_INITIATOR_NONCE:
-			i_nonce = data;
-			i_nonce_len = len;
-			break;
-		case DPP_ATTR_INITIATOR_CAPABILITIES:
-			/*
-			 * "If the Responder is not capable of supporting the
-			 * role indicated by the Initiator, it shall respond
-			 * with a DPP Authentication Response frame indicating
-			 * failure by adding the DPP Status field set to
-			 * STATUS_NOT_COMPATIBLE"
-			 */
-			i_capa = l_get_u8(data);
-
-			if (!dpp_check_roles(dpp, i_capa)) {
-				l_debug("Peer does not support required role");
-				dpp_auth_request_failed(dpp,
-						DPP_STATUS_NOT_COMPATIBLE, k1);
-				goto auth_request_failed;
-			}
-
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (i_nonce_len != dpp->nonce_len) {
-		l_debug("I-Nonce has unexpected length %zu", i_nonce_len);
-		goto auth_request_failed;
-	}
-
-	memcpy(dpp->i_nonce, i_nonce, i_nonce_len);
-
-	if (dpp->mutual_auth) {
-		l = dpp_derive_lr(dpp->boot_private, dpp->proto_private,
-					dpp->peer_boot_public);
-		bi = dpp->peer_boot_public;
-	}
-
-	/* Derive keys k2, ke, and R-Auth for authentication response */
-
-	n = dpp_derive_k2(dpp->peer_proto_public, dpp->proto_private, dpp->k2);
-	if (!n)
-		goto auth_request_failed;
-
-	l_getrandom(dpp->r_nonce, dpp->nonce_len);
-
-	if (!dpp_derive_ke(dpp->i_nonce, dpp->r_nonce, m, n, l, dpp->ke))
-		goto auth_request_failed;
-
-	if (!dpp_derive_r_auth(dpp->i_nonce, dpp->r_nonce, dpp->nonce_len,
-				dpp->peer_proto_public, dpp->own_proto_public,
-				bi, dpp->boot_public, dpp->auth_tag))
-		goto auth_request_failed;
-
-	memcpy(dpp->peer_addr, from, 6);
-
-	dpp->state = DPP_STATE_AUTHENTICATING;
-	dpp_reset_protocol_timer(dpp, DPP_AUTH_PROTO_TIMEOUT);
-
-	/* Don't send if the frequency is changing */
-	if (!dpp->new_freq)
-		send_authenticate_response(dpp);
-
-	return;
-
-auth_request_failed:
-	dpp->state = DPP_STATE_PRESENCE;
-	dpp_free_auth_data(dpp);
-}
-
-static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
-{
-	struct iovec iov;
-	uint8_t frame[256];
-	uint8_t *ptr = frame;
-	uint8_t zero = 0;
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
-
-	memset(frame, 0, sizeof(frame));
-
-	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
-					dpp->peer_addr,
-					DPP_FRAME_AUTHENTICATION_CONFIRM, ptr);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &zero, 1);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
-					dpp->peer_boot_hash, 32);
-	if (dpp->mutual_auth)
-		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
-					dpp->own_boot_hash, 32);
-
-	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
-			dpp->ke, dpp->key_len, 1,
-			DPP_ATTR_INITIATOR_AUTH_TAG, dpp->key_len,
-			dpp->auth_tag);
-
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
-
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-}
-
-static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
-					const uint8_t *body, size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	int status = -1;
-	const void *r_boot_hash = NULL;
-	const void *r_proto = NULL;
-	size_t r_proto_len = 0;
-	const void *wrapped = NULL;
-	size_t wrapped_len;
-	_auto_(l_free) uint8_t *unwrapped1 = NULL;
-	_auto_(l_free) uint8_t *unwrapped2 = NULL;
-	const void *r_nonce = NULL;
-	const void *i_nonce = NULL;
-	const void *r_auth = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *r_proto_key = NULL;
-	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
-	struct l_ecc_point *bi = NULL;
-	const void *ad0 = body + 2;
-	const void *ad1 = body + 8;
-	uint64_t r_auth_derived[L_ECC_MAX_DIGITS];
-
-	l_debug("Authenticate response");
-
-	if (dpp->state != DPP_STATE_AUTHENTICATING)
-		return;
-
-	if (!dpp->freqs)
-		return;
-
-	if (memcmp(from, dpp->peer_addr, 6))
-		return;
-
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_STATUS:
-			if (len != 1)
-				return;
-
-			status = l_get_u8(data);
-			break;
-		case DPP_ATTR_RESPONDER_BOOT_KEY_HASH:
-			r_boot_hash = data;
-			break;
-		case DPP_ATTR_RESPONDER_PROTOCOL_KEY:
-			r_proto = data;
-			r_proto_len = len;
-			break;
-		case DPP_ATTR_PROTOCOL_VERSION:
-			if (len != 1 || l_get_u8(data) != 2)
-				return;
-			break;
-		case DPP_ATTR_WRAPPED_DATA:
-			wrapped = data;
-			wrapped_len = len;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (status != DPP_STATUS_OK || !r_boot_hash || !r_proto || !wrapped) {
-		l_debug("Auth response bad status or missing attributes");
-		return;
-	}
-
-	r_proto_key = l_ecc_point_from_data(dpp->curve, L_ECC_POINT_TYPE_FULL,
-						r_proto, r_proto_len);
-	if (!r_proto_key) {
-		l_debug("Peers protocol key was invalid");
-		return;
-	}
-
-	n = dpp_derive_k2(r_proto_key, dpp->proto_private, dpp->k2);
-
-	unwrapped1 = dpp_unwrap_attr(ad0, 6, ad1, wrapped - 4 - ad1, dpp->k2,
-					dpp->key_len, wrapped, wrapped_len,
-					&wrapped_len);
-	if (!unwrapped1) {
-		l_debug("Failed to unwrap primary data");
-		return;
-	}
-
-	wrapped = NULL;
-
-	dpp_attr_iter_init(&iter, unwrapped1, wrapped_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_RESPONDER_NONCE:
-			if (len != dpp->nonce_len)
-				return;
-
-			r_nonce = data;
-			break;
-		case DPP_ATTR_INITIATOR_NONCE:
-			if (len != dpp->nonce_len)
-				return;
-
-			i_nonce = data;
-			break;
-		case DPP_ATTR_RESPONDER_CAPABILITIES:
-			break;
-		case DPP_ATTR_WRAPPED_DATA:
-			wrapped = data;
-			wrapped_len = len;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!r_nonce || !i_nonce || !wrapped) {
-		l_debug("Wrapped data missing attributes");
-		return;
-	}
-
-	if (dpp->mutual_auth) {
-		l = dpp_derive_li(dpp->peer_boot_public, r_proto_key,
-					dpp->boot_private);
-		bi = dpp->boot_public;
-	}
-
-	if (!dpp_derive_ke(i_nonce, r_nonce, dpp->m, n, l, dpp->ke)) {
-		l_debug("Failed to derive ke");
-		return;
-	}
-
-	unwrapped2 = dpp_unwrap_attr(NULL, 0, NULL, 0, dpp->ke, dpp->key_len,
-					wrapped, wrapped_len, &wrapped_len);
-	if (!unwrapped2) {
-		l_debug("Failed to unwrap secondary data");
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, unwrapped2, wrapped_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_RESPONDER_AUTH_TAG:
-			if (len != dpp->key_len)
-				return;
-
-			r_auth = data;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!r_auth) {
-		l_debug("R-Auth was not in secondary wrapped data");
-		return;
-	}
-
-	if (!dpp_derive_r_auth(i_nonce, r_nonce, dpp->nonce_len,
-				dpp->own_proto_public, r_proto_key, bi,
-				dpp->peer_boot_public, r_auth_derived)) {
-		l_debug("Failed to derive r_auth");
-		return;
-	}
-
-	if (memcmp(r_auth, r_auth_derived, dpp->key_len)) {
-		l_debug("R-Auth did not verify");
-		return;
-	}
-
-	if (!dpp_derive_i_auth(r_nonce, i_nonce, dpp->nonce_len,
-				r_proto_key, dpp->own_proto_public,
-				dpp->peer_boot_public, bi, dpp->auth_tag)) {
-		l_debug("Could not derive I-Auth");
-		return;
-	}
-
-	dpp->channel_switch = false;
-	dpp->current_freq = dpp->new_freq;
-
-	dpp_send_authenticate_confirm(dpp);
-
-	if (dpp->role == DPP_CAPABILITY_ENROLLEE)
-		dpp_configuration_start(dpp, from);
-
-}
-
-static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
-						const uint8_t *from,
-						const uint8_t *body,
-						size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	const void *r_boot = NULL;
-	size_t r_boot_len = 0;
-	uint8_t hash[32];
-
-	l_debug("Presence announcement "MAC, MAC_STR(from));
-
-	/* Must be a configurator, in an initiator role, in PRESENCE state */
-	if (dpp->state != DPP_STATE_PRESENCE)
-		return;
-
-	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
-		return;
-
-	if (!dpp->freqs)
-		return;
-
-	/*
-	 * The URI may not have contained a MAC address, if this announcement
-	 * verifies set peer_addr then.
-	 */
-	if (!l_memeqzero(dpp->peer_addr, 6) &&
-				memcmp(from, dpp->peer_addr, 6)) {
-		l_debug("Unexpected source "MAC" expected "MAC, MAC_STR(from),
-						MAC_STR(dpp->peer_addr));
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_RESPONDER_BOOT_KEY_HASH:
-			r_boot = data;
-			r_boot_len = len;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!r_boot || r_boot_len != 32) {
-		l_debug("No responder boot hash");
-		return;
-	}
-
-	/* Hash what we have for the peer and check its our enrollee */
-	dpp_hash(L_CHECKSUM_SHA256, hash, 2, "chirp", strlen("chirp"),
-			dpp->peer_asn1, dpp->peer_asn1_len);
-
-	if (memcmp(hash, r_boot, sizeof(hash))) {
-		l_debug("Peers boot hash did not match");
-		return;
-	}
-
-	/*
-	 * This is the peer we expected, save away the address and derive the
-	 * initial keys.
-	 */
-	memcpy(dpp->peer_addr, from, 6);
-
-	dpp->state = DPP_STATE_AUTHENTICATING;
-
-	if (!dpp_send_authenticate_request(dpp))
-		return;
-
-	/*
-	 * Requested the peer to move to another channel for the remainder of
-	 * the protocol. IWD's current logic prohibits a configurator from
-	 * running while not connected, so we can assume here that the new
-	 * frequency is the same of the connected BSS. Wait until an ACK is
-	 * received for the auth request then cancel the offchannel request.
-	 */
-	if (dpp->current_freq != dpp->new_freq)
-		dpp->channel_switch = true;
-}
-
-static void dpp_pkex_bad_group(struct dpp_sm *dpp, uint16_t group)
-{
-	uint16_t own_group = l_ecc_curve_get_ike_group(dpp->curve);
-
-	/*
-	 * TODO: The spec allows group negotiation, but it is not yet
-	 *       implemented.
-	 */
-	if (!group)
-		return;
-	/*
-	 * Section 5.6.2
-	 * "If the Responder's offered group offers less security
-	 * than the Initiator's offered group, then the Initiator should
-	 * ignore this message"
-	 */
-	if (group < own_group) {
-		l_debug("Offered group %u is less secure, ignoring",
-				group);
-		return;
-	}
-	/*
-	 * Section 5.6.2
-	 * "If the Responder's offered group offers equivalent or better
-	 * security than the Initiator's offered group, then the
-	 * Initiator may choose to abort its original request and try
-	 * another exchange using the group offered by the Responder"
-	 */
-	if (group >= own_group) {
-		l_debug("Offered group %u is the same or more secure, "
-			" but group negotiation is not supported", group);
-		return;
-	}
-}
-
-static void dpp_pkex_bad_code(struct dpp_sm *dpp)
-{
-	_auto_(l_ecc_point_free) struct l_ecc_point *qr = NULL;
-
-	qr = dpp_derive_qr(dpp->curve, dpp->pkex_key, dpp->pkex_id,
-				netdev_get_address(dpp->netdev));
-	if (!qr || l_ecc_point_is_infinity(qr)) {
-		l_debug("Qr computed to zero, new code should be provisioned");
-		return;
-	}
-
-	l_debug("Qr computed successfully but responder indicated otherwise");
-}
-
-static void dpp_handle_pkex_exchange_response(struct dpp_sm *dpp,
-					const uint8_t *from,
-					const uint8_t *body, size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	const uint8_t *status = NULL;
-	uint8_t version = 0;
-	const void *identifier = NULL;
-	size_t identifier_len = 0;
-	const void *key = NULL;
-	size_t key_len = 0;
-	uint16_t group = 0;
-	_auto_(l_ecc_point_free) struct l_ecc_point *n = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *j = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *qr = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *k = NULL;
-	const uint8_t *own_addr = netdev_get_address(dpp->netdev);
-
-	l_debug("PKEX response "MAC, MAC_STR(from));
-
-	if (dpp->state != DPP_STATE_PKEX_EXCHANGE)
-		return;
-
-	if (dpp->role != DPP_CAPABILITY_ENROLLEE)
-		return;
-
-	memcpy(dpp->peer_addr, from, 6);
-
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_STATUS:
-			if (len != 1)
-				return;
-
-			status = data;
-			break;
-		case DPP_ATTR_PROTOCOL_VERSION:
-			if (len != 1)
-				return;
-
-			version = l_get_u8(data);
-			break;
-		case DPP_ATTR_CODE_IDENTIFIER:
-			identifier = data;
-			identifier_len = len;
-			break;
-		case DPP_ATTR_ENCRYPTED_KEY:
-			if (len != dpp->key_len * 2)
-				return;
-
-			key = data;
-			key_len = len;
-			break;
-		case DPP_ATTR_FINITE_CYCLIC_GROUP:
-			if (len != 2)
-				return;
-
-			group = l_get_le16(data);
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!status) {
-		l_debug("No status attribute, ignoring");
-		return;
-	}
-
-	if (!key) {
-		l_debug("No encrypted key, ignoring");
-		return;
-	}
-
-	if (*status != DPP_STATUS_OK)
-		goto handle_status;
-
-	if (dpp->pkex_id) {
-		if (!identifier || identifier_len != strlen(dpp->pkex_id) ||
-					memcmp(dpp->pkex_id, identifier,
-						identifier_len)) {
-			l_debug("mismatch identifier, ignoring");
-			return;
-		}
-	}
-
-	if (version && version != dpp->pkex_version) {
-		l_debug("PKEX version does not match, igoring");
-		return;
-	}
-
-	n = l_ecc_point_from_data(dpp->curve, L_ECC_POINT_TYPE_FULL,
-					key, key_len);
-	if (!n) {
-		l_debug("failed to parse peers encrypted key");
-		goto failed;
-	}
-
-	qr = dpp_derive_qr(dpp->curve, dpp->pkex_key, dpp->pkex_id,
-				dpp->peer_addr);
-	if (!qr)
-		goto failed;
-
-	dpp->y_or_x = l_ecc_point_new(dpp->curve);
-
-	/* Y' = N - Qr */
-	l_ecc_point_inverse(qr);
-	l_ecc_point_add(dpp->y_or_x, n, qr);
-
-	/*
-	 * "The resulting ephemeral key, denoted Y’, is then checked whether it
-	 * is the point-at-infinity. If it is not valid, the protocol ends
-	 * unsuccessfully"
-	 */
-	if (l_ecc_point_is_infinity(dpp->y_or_x)) {
-		l_debug("Y' computed to infinity, failing");
-		goto failed;
-	}
-
-	k = l_ecc_point_new(dpp->curve);
-
-	/* K = Y' * x */
-	l_ecc_point_multiply(k, dpp->pkex_private, dpp->y_or_x);
-
-	dpp_derive_z(own_addr, dpp->peer_addr, n, dpp->pkex_m, k,
-				dpp->pkex_key, dpp->pkex_id,
-				dpp->z, &dpp->z_len);
-
-	/* J = a * Y' */
-	j = l_ecc_point_new(dpp->curve);
-
-	l_ecc_point_multiply(j, dpp->boot_private, dpp->y_or_x);
-
-	if (!dpp_derive_u(j, own_addr, dpp->boot_public, dpp->y_or_x,
-				dpp->pkex_public, dpp->u, &dpp->u_len)) {
-		l_debug("failed to compute u");
-		goto failed;
-	}
-
-	/*
-	 * Now that a response was successfully received, start another
-	 * offchannel with more time for the remainder of the protocol. After
-	 * PKEX, authentication will begin which handles the protocol timeout.
-	 * If the remainder of PKEX (commit-reveal exchange) cannot complete in
-	 * this time it will fail.
-	 */
-	dpp->dwell = (dpp->max_roc < 2000) ? dpp->max_roc : 2000;
-	dpp->state = DPP_STATE_PKEX_COMMIT_REVEAL;
-
-	dpp_property_changed_notify(dpp);
-
-	dpp_start_offchannel(dpp, dpp->current_freq);
-
-	return;
-
-handle_status:
-	switch (*status) {
-	case DPP_STATUS_BAD_GROUP:
-		dpp_pkex_bad_group(dpp, group);
-		break;
-	case DPP_STATUS_BAD_CODE:
-		dpp_pkex_bad_code(dpp);
-		break;
-	default:
-		l_debug("Unhandled status %u", *status);
-		break;
-	}
-
-failed:
-	dpp_reset(dpp);
-}
-
-static bool dpp_pkex_start_authentication(struct dpp_sm *dpp)
-{
-	dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
-					netdev_get_address(dpp->netdev),
-					&dpp->current_freq, 1, NULL, NULL);
-
-	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
-					&dpp->own_proto_public);
-
-	l_getrandom(dpp->i_nonce, dpp->nonce_len);
-
-	dpp->peer_asn1 = dpp_point_to_asn1(dpp->peer_boot_public,
-						&dpp->peer_asn1_len);
-
-	dpp->m = dpp_derive_k1(dpp->peer_boot_public, dpp->proto_private,
-				dpp->k1);
-
-	dpp_hash(L_CHECKSUM_SHA256, dpp->peer_boot_hash, 1, dpp->peer_asn1,
-			dpp->peer_asn1_len);
-
-	dpp->state = DPP_STATE_AUTHENTICATING;
-	dpp->mutual_auth = true;
-
-	dpp_property_changed_notify(dpp);
-
-	if (dpp->role == DPP_CAPABILITY_ENROLLEE) {
-		dpp->new_freq = dpp->current_freq;
-
-		return dpp_send_authenticate_request(dpp);
-	}
-
-	return true;
-}
-
-static void dpp_handle_pkex_commit_reveal_response(struct dpp_sm *dpp,
-					const uint8_t *from,
-					const uint8_t *body, size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	const uint8_t *wrapped = NULL;
-	size_t wrapped_len = 0;
-	uint8_t one = 1;
-	_auto_(l_free) uint8_t *unwrapped = NULL;
-	size_t unwrapped_len = 0;
-	const uint8_t *boot_key = NULL;
-	size_t boot_key_len = 0;
-	const uint8_t *r_auth = NULL;
-	uint8_t v[L_ECC_SCALAR_MAX_BYTES];
-	size_t v_len;
-	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
-
-	l_debug("PKEX commit reveal "MAC, MAC_STR(from));
-
-	if (dpp->state != DPP_STATE_PKEX_COMMIT_REVEAL)
-		return;
-
-	if (dpp->role != DPP_CAPABILITY_ENROLLEE)
-		return;
-
-	/*
-	 * The URI may not have contained a MAC address, if this announcement
-	 * verifies set peer_addr then.
-	 */
-	if (memcmp(from, dpp->peer_addr, 6)) {
-		l_debug("Unexpected source "MAC" expected "MAC, MAC_STR(from),
-						MAC_STR(dpp->peer_addr));
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_WRAPPED_DATA:
-			wrapped = data;
-			wrapped_len = len;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!wrapped) {
-		l_debug("No wrapped data");
-		return;
-	}
-
-	unwrapped = dpp_unwrap_attr(body + 2, 6, &one, 1, dpp->z, dpp->z_len,
-					wrapped, wrapped_len, &unwrapped_len);
-	if (!unwrapped) {
-		l_debug("Failed to unwrap Reveal-Commit message");
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, unwrapped, unwrapped_len);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_BOOTSTRAPPING_KEY:
-			if (len != dpp->key_len * 2)
-				return;
-
-			boot_key = data;
-			boot_key_len = len;
-			break;
-		case DPP_ATTR_RESPONDER_AUTH_TAG:
-			if (len != 32)
-				return;
-
-			r_auth = data;
-			break;
-		default:
-			break;
-		}
-	}
-
-	dpp->peer_boot_public = l_ecc_point_from_data(dpp->curve,
-							L_ECC_POINT_TYPE_FULL,
-							boot_key, boot_key_len);
-	if (!dpp->peer_boot_public) {
-		l_debug("Peer public bootstrapping key was invalid");
-		goto failed;
-	}
-
-	/* L = b * X' */
-	l = l_ecc_point_new(dpp->curve);
-
-	l_ecc_point_multiply(l, dpp->pkex_private, dpp->peer_boot_public);
-
-	if (!dpp_derive_v(l, dpp->peer_addr, dpp->peer_boot_public,
-				dpp->pkex_public, dpp->y_or_x, v, &v_len)) {
-		l_debug("Failed to derive v");
-		goto failed;
-	}
-
-	if (memcmp(v, r_auth, v_len)) {
-		l_debug("Bootstrapping data did not verify");
-		goto failed;
-	}
-
-	if (dpp_pkex_start_authentication(dpp))
-		return;
-
-failed:
-	dpp_reset(dpp);
-}
-
-static void dpp_send_bad_group(struct dpp_sm *dpp, const uint8_t *addr)
-{
-	uint8_t hdr[32];
-	uint8_t attrs[256];
-	uint8_t *ptr = attrs;
-	uint16_t group;
-	uint8_t status = DPP_STATUS_BAD_GROUP;
-	struct iovec iov[2];
-	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
-
-	l_put_le16(l_ecc_curve_get_ike_group(dpp->curve), &group);
-
-	iov[0].iov_len = dpp_build_header(own_mac, addr,
-				DPP_FRAME_PKEX_XCHG_RESPONSE, hdr);
-	iov[0].iov_base = hdr;
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION,
-				&dpp->pkex_version, 1);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_FINITE_CYCLIC_GROUP, &group, 2);
-
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
-
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
-}
-
-static void dpp_send_bad_code(struct dpp_sm *dpp, const uint8_t *addr)
-{
-	uint8_t hdr[32];
-	uint8_t attrs[256];
-	uint8_t *ptr = attrs;
-	uint8_t status = DPP_STATUS_BAD_CODE;
-	struct iovec iov[2];
-	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
-
-	iov[0].iov_len = dpp_build_header(own_mac, addr,
-				DPP_FRAME_PKEX_XCHG_RESPONSE, hdr);
-	iov[0].iov_base = hdr;
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION,
-				&dpp->pkex_version, 1);
-	if (dpp->pkex_id)
-		ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
-					dpp->pkex_id, strlen(dpp->pkex_id));
-
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
-
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
-}
-
-static void dpp_send_pkex_exchange_response(struct dpp_sm *dpp,
-						struct l_ecc_point *n)
-{
-	uint8_t hdr[32];
-	uint8_t attrs[256];
-	uint8_t *ptr = attrs;
-	uint16_t group;
-	uint8_t status = DPP_STATUS_OK;
-	struct iovec iov[2];
-	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
-
-	l_put_le16(l_ecc_curve_get_ike_group(dpp->curve), &group);
-
-	iov[0].iov_len = dpp_build_header(own_mac, dpp->peer_addr,
-				DPP_FRAME_PKEX_XCHG_RESPONSE, hdr);
-	iov[0].iov_base = hdr;
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
-
-	if (dpp->pkex_id)
-		ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
-					dpp->pkex_id, strlen(dpp->pkex_id));
-
-	ptr += dpp_append_point(ptr, DPP_ATTR_ENCRYPTED_KEY, n);
-
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
-
-	dpp->state = DPP_STATE_PKEX_COMMIT_REVEAL;
-
-	dpp_property_changed_notify(dpp);
-
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
-}
-
-static void dpp_process_pkex_exchange_request(struct dpp_sm *dpp,
-						struct l_ecc_point *m)
-{
-	_auto_(l_ecc_point_free) struct l_ecc_point *n = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *qr = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *k = NULL;
-	const uint8_t *own_addr = netdev_get_address(dpp->netdev);
-
-	/* Qi = H(MAC-Initiator | [identifier | ] code) * Pi */
-	qi = dpp_derive_qi(dpp->curve, dpp->pkex_key, dpp->pkex_id,
-				dpp->peer_addr);
-	if (!qi) {
-		l_debug("could not derive Qi");
-		return;
-	}
-
-	/* X' = M - Qi */
-	dpp->y_or_x = l_ecc_point_new(dpp->curve);
-
-	l_ecc_point_inverse(qi);
-	l_ecc_point_add(dpp->y_or_x, m, qi);
-
-	/*
-	 * "The resulting ephemeral key, denoted X’, is checked whether it is
-	 * the point-at-infinity. If it is not valid, the protocol silently
-	 * fails"
-	 */
-	if (l_ecc_point_is_infinity(dpp->y_or_x)) {
-		l_debug("X' is at infinity, ignore message");
-		dpp_reset(dpp);
-		return;
-	}
-
-	qr = dpp_derive_qr(dpp->curve, dpp->pkex_key, dpp->pkex_id, own_addr);
-	if (!qr || l_ecc_point_is_infinity(qr)) {
-		l_debug("Qr did not derive");
-		l_ecc_point_free(dpp->y_or_x);
-		dpp->y_or_x = NULL;
-		goto bad_code;
-	}
-
-	/*
-	 * "The Responder then generates a random ephemeral keypair, y/Y,
-	 * encrypts Y with Qr to obtain the result, denoted N."
-	 */
-	l_ecdh_generate_key_pair(dpp->curve, &dpp->pkex_private,
-					&dpp->pkex_public);
-
-	/* N = Y + Qr */
-	n = l_ecc_point_new(dpp->curve);
-
-	l_ecc_point_add(n, dpp->pkex_public, qr);
-
-	/* K = y * X' */
-
-	k = l_ecc_point_new(dpp->curve);
-
-	l_ecc_point_multiply(k, dpp->pkex_private, dpp->y_or_x);
-
-	/* z = HKDF(<>, info | M.x | N.x | code, K.x) */
-	dpp_derive_z(dpp->peer_addr, own_addr, n, m, k, dpp->pkex_key,
-				dpp->pkex_id, dpp->z, &dpp->z_len);
-
-	dpp_send_pkex_exchange_response(dpp, n);
-
-	return;
-
-bad_code:
-	dpp_send_bad_code(dpp, dpp->peer_addr);
-	return;
-}
-
-static void dpp_pkex_agent_reply(struct l_dbus_message *message,
-					void *user_data)
-{
-	struct dpp_sm *dpp = user_data;
-	const char *error, *text;
-	const char *code;
-
-	dpp->agent->pending_id = 0;
-
-	l_debug("SharedCodeAgent %s path %s replied", dpp->agent->owner,
-			dpp->agent->path);
-
-	if (l_dbus_message_get_error(message, &error, &text)) {
-		l_error("RequestSharedCode(%s) returned %s(\"%s\")",
-				dpp->pkex_id, error, text);
-		goto reset;
-	}
-
-	if (!l_dbus_message_get_arguments(message, "s", &code)) {
-		l_debug("Invalid arguments, check SharedCodeAgent!");
-		goto reset;
-	}
-
-	dpp->pkex_key = l_strdup(code);
-	dpp_process_pkex_exchange_request(dpp, dpp->peer_encr_key);
-
-	return;
-
-reset:
-	dpp_free_pending_pkex_data(dpp);
-}
-
-static bool dpp_pkex_agent_request(struct dpp_sm *dpp)
-{
-	struct l_dbus_message *msg;
-
-	if (!dpp->agent)
-		return false;
-
-	if (L_WARN_ON(dpp->agent->pending_id))
-		return false;
-
-	msg = l_dbus_message_new_method_call(dbus_get_bus(),
-						dpp->agent->owner,
-						dpp->agent->path,
-						IWD_SHARED_CODE_AGENT_INTERFACE,
-						"RequestSharedCode");
-	l_dbus_message_set_arguments(msg, "s", dpp->pkex_id);
-
-
-	dpp->agent->pending_id = l_dbus_send_with_reply(dbus_get_bus(),
-							msg,
-							dpp_pkex_agent_reply,
-							dpp, NULL);
-	return dpp->agent->pending_id != 0;
-}
-
-static void dpp_handle_pkex_exchange_request(struct dpp_sm *dpp,
-					const uint8_t *from,
-					const uint8_t *body, size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	uint8_t version = 0;
-	uint16_t group = 0;
-	const void *id = NULL;
-	size_t id_len = 0;
-	const void *key = NULL;
-	size_t key_len = 0;
-	_auto_(l_ecc_point_free) struct l_ecc_point *m = NULL;
-
-	l_debug("PKEX exchange request "MAC, MAC_STR(from));
-
-	if (dpp->state != DPP_STATE_PKEX_EXCHANGE)
-		return;
-
-	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
-		return;
-
-	if (!l_memeqzero(dpp->peer_addr, 6)) {
-		l_debug("Already configuring enrollee, ignoring");
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
-
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_PROTOCOL_VERSION:
-			if (len != 1)
-				return;
-
-			version = l_get_u8(data);
-			break;
-		case DPP_ATTR_FINITE_CYCLIC_GROUP:
-			if (len != 2)
-				return;
-
-			group = l_get_le16(data);
-			break;
-		case DPP_ATTR_CODE_IDENTIFIER:
-			id = data;
-			id_len = len;
-			break;
-		case DPP_ATTR_ENCRYPTED_KEY:
-			key = data;
-			key_len = len;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!key || !group) {
-		l_debug("initiator did not provide group or key, ignoring");
-		return;
-	}
+	struct scan_bss *bss;
+	struct network *network;
+	int ret;
 
-	if (group != l_ecc_curve_get_ike_group(dpp->curve)) {
-		l_debug("initiator is not using the same group");
-		goto bad_group;
-	}
+	network = station_network_find(station, dpp->config->ssid,
+					SECURITY_PSK);
 
-	/*
-	 * If the group isn't the same the key length won't match, so check
-	 * this here after we've determined the groups are equal
-	 */
-	if (key_len != dpp->key_len * 2) {
-		l_debug("Unexpected encrypted key length");
-		return;
-	}
+	dpp_reset(dpp);
 
-	if (version && version != dpp->pkex_version) {
-		l_debug("initiator is not using the same version, ignoring");
+	if (!network) {
+		l_debug("Network was not found!");
 		return;
 	}
 
-	if (dpp->pkex_id) {
-		if (!id || id_len != strlen(dpp->pkex_id) ||
-				memcmp(dpp->pkex_id, id, id_len)) {
-			l_debug("mismatch identifier, ignoring");
-			return;
-		}
-	}
+	l_debug("connecting to %s from DPP", network_get_ssid(network));
 
-	m = l_ecc_point_from_data(dpp->curve, L_ECC_POINT_TYPE_FULL,
-					key, key_len);
-	if (!m) {
-		l_debug("could not parse key from initiator, ignoring");
-		return;
-	}
+	bss = network_bss_select(network, true);
+	ret = network_autoconnect(network, bss);
+	if (ret < 0)
+		l_warn("failed to connect after DPP (%d) %s", ret,
+			strerror(-ret));
+}
 
-	memcpy(dpp->peer_addr, from, 6);
+static bool dpp_scan_results(int err, struct l_queue *bss_list,
+				const struct scan_freq_set *freqs,
+				void *userdata)
+{
+	struct dpp *dpp = userdata;
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 
-	if (!dpp->pkex_key) {
-		/*
-		 * "If an optional code identifier is used, it shall be a UTF-8
-		 *  string not greater than eighty (80) octets"
-		 */
-		if (!id || id_len > 80 || !l_utf8_validate(id, id_len, NULL)) {
-			l_debug("Configurator started with agent but enrollee "
-				"sent invalid or no identifier, ignoring");
-			return;
-		}
+	if (err < 0)
+		goto reset;
 
-		dpp->pkex_id = l_strndup(id, id_len);
+	if (!bss_list || l_queue_length(bss_list) == 0)
+		goto reset;
 
-		/* Need to obtain code from agent */
-		if (!dpp_pkex_agent_request(dpp)) {
-			l_debug("Failed to request code from agent!");
-			dpp_free_pending_pkex_data(dpp);
-			return;
-		}
+	/*
+	 * The station watch _should_ detect this and reset, which cancels the
+	 * scan. But just in case...
+	 */
+	if (L_WARN_ON(station_get_connected_network(station)))
+		goto reset;
 
-		/* Save the encrypted key/identifier for the agent callback */
+	station_set_scan_results(station, bss_list, freqs, false);
 
-		dpp->peer_encr_key = l_steal_ptr(m);
+	dpp_start_connect(NULL, dpp);
 
-		return;
-	}
+	return true;
 
-	dpp_process_pkex_exchange_request(dpp, m);
+reset:
+	return false;
+}
 
-	return;
+static void dpp_scan_destroy(void *userdata)
+{
+	struct dpp *dpp = userdata;
 
-bad_group:
-	dpp_send_bad_group(dpp, from);
+	dpp->connect_scan_id = 0;
+	dpp_reset(dpp);
 }
 
-static void dpp_send_commit_reveal_response(struct dpp_sm *dpp,
-						const uint8_t *v, size_t v_len)
+static void dpp_known_network_watch(enum known_networks_event event,
+					const struct network_info *info,
+					void *user_data)
 {
-	uint8_t frame[256];
-	uint8_t *ptr = frame;
-	struct iovec iov;
-	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
-	uint8_t b_pub[L_ECC_POINT_MAX_BYTES];
-	size_t b_len;
-	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+	struct dpp *dpp = user_data;
 
-	memset(frame, 0, sizeof(frame));
+	/*
+	 * Check the following
+	 *  - DPP is enrolling
+	 *  - DPP finished (dpp->config is set)
+	 *  - This is for the network DPP just configured
+	 *  - DPP isn't already trying to connect (e.g. if the profile was
+	 *    immediately modified after DPP synced it).
+	 *  - DPP didn't start a scan for the network.
+	 */
+	if (dpp->role != DPP_CAPABILITY_ENROLLEE)
+		return;
+	if (!dpp->config)
+		return;
+	if (strcmp(info->ssid, dpp->config->ssid))
+		return;
+	if (dpp->connect_idle)
+		return;
+	if (dpp->connect_scan_id)
+		return;
 
-	b_len = l_ecc_point_get_data(dpp->boot_public, b_pub, sizeof(b_pub));
+	switch (event) {
+	case KNOWN_NETWORKS_EVENT_ADDED:
+	case KNOWN_NETWORKS_EVENT_UPDATED:
+		/*
+		 * network.c takes care of updating the settings for the
+		 * network. This callback just tells us to begin the connection.
+		 * We do have use an idle here because there is no strict
+		 * guarantee of ordering between known network events, e.g. DPP
+		 * could have been called into prior to network and the network
+		 * object isn't updated yet.
+		 */
+		dpp->connect_idle = l_idle_create(dpp_start_connect, dpp, NULL);
+		break;
+	case KNOWN_NETWORKS_EVENT_REMOVED:
+		l_warn("profile was removed before DPP could connect");
+		break;
+	}
+}
 
-	ptr += dpp_build_header(own_mac, dpp->peer_addr,
-				DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE, ptr);
-	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
-			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
-			dpp->z, dpp->z_len, 2,
-			DPP_ATTR_BOOTSTRAPPING_KEY, b_len, b_pub,
-			DPP_ATTR_RESPONDER_AUTH_TAG, v_len, v);
+static void dpp_handle_config_frame(const struct mmpdu_header *frame,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
+{
+	struct dpp *dpp = user_data;
+	struct dpp_configuration *config = NULL;
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	struct network *network = NULL;
+	struct scan_bss *bss = NULL;
 
-	iov.iov_base = frame;
-	iov.iov_len = ptr - frame;
+	dpp_write_config(config, network);
 
-	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
-}
+	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 
-static void dpp_handle_pkex_commit_reveal_request(struct dpp_sm *dpp,
-					const uint8_t *from,
-					const uint8_t *body, size_t body_len)
-{
-	struct dpp_attr_iter iter;
-	enum dpp_attribute_type type;
-	size_t len;
-	const uint8_t *data;
-	const void *wrapped = NULL;
-	size_t wrapped_len = 0;
-	_auto_(l_free) uint8_t *unwrapped = NULL;
-	size_t unwrapped_len;
-	uint8_t zero = 0;
-	const void *key = 0;
-	size_t key_len = 0;
-	const void *i_auth = NULL;
-	size_t i_auth_len = 0;
-	_auto_(l_ecc_point_free) struct l_ecc_point *j = NULL;
-	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
-	uint8_t u[L_ECC_SCALAR_MAX_BYTES];
-	size_t u_len = 0;
-	uint8_t v[L_ECC_SCALAR_MAX_BYTES];
-	size_t v_len = 0;
-	const uint8_t *own_addr = netdev_get_address(dpp->netdev);
-
-	l_debug("PKEX commit-reveal request "MAC, MAC_STR(from));
-
-	if (dpp->state != DPP_STATE_PKEX_COMMIT_REVEAL)
+	if (network && bss) {
+		l_debug("delaying connect until settings are synced");
+		dpp->config = config;
 		return;
+	} else if (station) {
+		struct scan_parameters params = {0};
 
-	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
-		return;
+		params.ssid = (void *) config->ssid;
+		params.ssid_len = config->ssid_len;
 
-	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
+		l_debug("Scanning for %s", config->ssid);
 
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_WRAPPED_DATA:
-			wrapped = data;
-			wrapped_len = len;
-			break;
-		default:
-			break;
+		dpp->connect_scan_id = scan_active_full(dpp->wdev_id, &params,
+						dpp_scan_triggered,
+						dpp_scan_results, dpp,
+						dpp_scan_destroy);
+		if (dpp->connect_scan_id) {
+			dpp->config = config;
+			return;
 		}
 	}
 
-	if (!wrapped) {
-		l_debug("No wrapped data");
-		return;
-	}
-
-	unwrapped = dpp_unwrap_attr(body + 2, 6, &zero, 1, dpp->z, dpp->z_len,
-					wrapped, wrapped_len, &unwrapped_len);
-	if (!unwrapped) {
-		l_debug("Failed to unwrap attributes");
-		return;
-	}
-
-	dpp_attr_iter_init(&iter, unwrapped, unwrapped_len);
+}
 
-	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
-		switch (type) {
-		case DPP_ATTR_BOOTSTRAPPING_KEY:
-			if (len != dpp->key_len * 2)
-				return;
+static void dpp_roc_started(void *user_data)
+{
+	struct dpp *dpp = user_data;
 
-			key = data;
-			key_len = len;
-			break;
-		case DPP_ATTR_INITIATOR_AUTH_TAG:
-			if (len != 32)
-				return;
+	/*
+	 * - If a configurator, nothing to do but wait for a request
+	 *   (unless multicast frame registration is unsupported in which case
+	 *   send an authenticate request now)
+	 * - If in the presence state continue sending announcements.
+	 * - If authenticating, and this is a result of a channel switch send
+	 *   the authenticate response now.
+	 */
 
-			i_auth = data;
-			i_auth_len = len;
-			break;
-		default:
-			break;
-		}
-	}
+	dpp->roc_started = true;
 
-	if (!key || !i_auth) {
-		l_debug("missing attributes");
+	/*
+	 * The retry timer indicates a frame was not acked in which case we
+	 * should not change any state or send any frames until that expires.
+	 */
+	if (dpp->retry_timeout)
 		return;
-	}
 
-	dpp->peer_boot_public = l_ecc_point_from_data(dpp->curve,
-					L_ECC_POINT_TYPE_FULL, key, key_len);
-	if (!dpp->peer_boot_public) {
-		l_debug("peers boostrapping key did not validate");
-		goto failed;
+	if (dpp->frame_pending) {
+		dpp_frame_retry(dpp);
+		return;
 	}
+}
 
-	/* J' = y * A' */
-	j = l_ecc_point_new(dpp->curve);
-
-	l_ecc_point_multiply(j, dpp->pkex_private, dpp->peer_boot_public);
+static void dpp_start_offchannel(struct dpp *dpp, uint32_t freq);
 
-	dpp_derive_u(j, dpp->peer_addr, dpp->peer_boot_public, dpp->pkex_public,
-			dpp->y_or_x, u, &u_len);
+static void dpp_offchannel_timeout(int error, void *user_data)
+{
+	struct dpp *dpp = user_data;
 
-	if (memcmp(u, i_auth, i_auth_len)) {
-		l_debug("Initiator auth tag did not verify");
-		goto failed;
-	}
+	dpp->offchannel_id = 0;
+	dpp->roc_started = false;
 
-	/* L' = x * B' */
-	l = l_ecc_point_new(dpp->curve);
+	/*
+	 * If cancelled this is likely due to netdev going down or from Stop().
+	 * Otherwise there was some other problem which is probably not
+	 * recoverable.
+	 */
+	if (error == -ECANCELED)
+		return;
+	else if (error == -EIO)
+		goto next_roc;
+	else if (error < 0)
+		goto protocol_failed;
 
-	l_ecc_point_multiply(l, dpp->boot_private, dpp->y_or_x);
+	dpp->freqs_idx++;
 
-	if (!dpp_derive_v(l, own_addr, dpp->boot_public, dpp->y_or_x,
-				dpp->pkex_public, v, &v_len)) {
-		l_debug("Failed to derive v");
-		goto failed;
+	if (dpp->freqs_idx >= dpp->freqs_len) {
+		l_debug("Max retries offchannel");
+		dpp->freqs_idx = 0;
 	}
 
-	dpp_send_commit_reveal_response(dpp, v, v_len);
+	dpp->current_freq = dpp->freqs[dpp->freqs_idx];
+
+	l_debug("Offchannel timeout, moving to next frequency %u, duration %u",
+			dpp->current_freq, dpp->dwell);
 
-	dpp_pkex_start_authentication(dpp);
+next_roc:
+	dpp_start_offchannel(dpp, dpp->current_freq);
 
 	return;
 
-failed:
+protocol_failed:
 	dpp_reset(dpp);
 }
 
-static void dpp_handle_frame(struct dpp_sm *dpp,
+static void dpp_start_offchannel(struct dpp *dpp, uint32_t freq)
+{
+	/*
+	 * This needs to be handled carefully for a few reasons:
+	 *
+	 * First, the next offchannel operation needs to be started prior to
+	 * canceling an existing one. This is so the offchannel work can
+	 * continue uninterrupted without any other work items starting in
+	 * between canceling and starting the next (e.g. if a scan request is
+	 * sitting in the queue).
+	 *
+	 * Second, dpp_offchannel_timeout resets dpp->offchannel_id to zero
+	 * which is why the new ID is saved and only set to dpp->offchannel_id
+	 * once the previous offchannel work is cancelled (i.e. destroy() has
+	 * been called).
+	 */
+	uint32_t id = offchannel_start(netdev_get_wdev_id(dpp->netdev),
+				WIPHY_WORK_PRIORITY_OFFCHANNEL,
+				freq, dpp->dwell, dpp_roc_started,
+				dpp, dpp_offchannel_timeout);
+
+	if (dpp->offchannel_id)
+		offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
+
+	dpp->offchannel_id = id;
+}
+
+static void dpp_handle_frame(struct dpp *dpp,
 				const struct mmpdu_header *frame,
 				const void *body, size_t body_len)
 {
@@ -3472,39 +810,6 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
 	ptr = body + 7;
 
 	switch (*ptr) {
-	case DPP_FRAME_AUTHENTICATION_REQUEST:
-		authenticate_request(dpp, frame->address_2, body, body_len);
-		break;
-	case DPP_FRAME_AUTHENTICATION_RESPONSE:
-		authenticate_response(dpp, frame->address_2, body, body_len);
-		break;
-	case DPP_FRAME_AUTHENTICATION_CONFIRM:
-		authenticate_confirm(dpp, frame->address_2, body, body_len);
-		break;
-	case DPP_FRAME_CONFIGURATION_RESULT:
-		dpp_handle_config_result_frame(dpp, frame->address_2,
-						body, body_len);
-		break;
-	case DPP_FRAME_PRESENCE_ANNOUNCEMENT:
-		dpp_handle_presence_announcement(dpp, frame->address_2,
-							body, body_len);
-		break;
-	case DPP_FRAME_PKEX_XCHG_RESPONSE:
-		dpp_handle_pkex_exchange_response(dpp, frame->address_2, body,
-							body_len);
-		break;
-	case DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE:
-		dpp_handle_pkex_commit_reveal_response(dpp, frame->address_2,
-							body, body_len);
-		break;
-	case DPP_FRAME_PKEX_VERSION1_XCHG_REQUEST:
-		dpp_handle_pkex_exchange_request(dpp, frame->address_2, body,
-							body_len);
-		break;
-	case DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST:
-		dpp_handle_pkex_commit_reveal_request(dpp, frame->address_2,
-							body, body_len);
-		break;
 	default:
 		l_debug("Unhandled DPP frame %u", *ptr);
 		break;
@@ -3513,7 +818,7 @@ static void dpp_handle_frame(struct dpp_sm *dpp,
 
 static bool match_wdev(const void *a, const void *b)
 {
-	const struct dpp_sm *dpp = a;
+	const struct dpp *dpp = a;
 	const uint64_t *wdev_id = b;
 
 	return *wdev_id == dpp->wdev_id;
@@ -3521,7 +826,7 @@ static bool match_wdev(const void *a, const void *b)
 
 static void dpp_frame_timeout(struct l_timeout *timeout, void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	l_timeout_remove(timeout);
 	dpp->retry_timeout = NULL;
@@ -3540,7 +845,7 @@ static void dpp_frame_timeout(struct l_timeout *timeout, void *user_data)
 
 static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
-	struct dpp_sm *dpp;
+	struct dpp *dpp;
 	uint64_t wdev_id = 0;
 	uint64_t cookie = 0;
 	bool ack = false;
@@ -3620,7 +925,7 @@ retransmit:
 
 static void dpp_unicast_notify(struct l_genl_msg *msg, void *user_data)
 {
-	struct dpp_sm *dpp;
+	struct dpp *dpp;
 	const uint64_t *wdev_id = NULL;
 	struct l_genl_attr attr;
 	uint16_t type, len, frame_len;
@@ -3692,7 +997,7 @@ static void dpp_frame_watch_cb(struct l_genl_msg *msg, void *user_data)
  * require multicast support. This is only supported by ath9k, so adding
  * general support to frame-xchg isn't desireable.
  */
-static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
+static void dpp_frame_watch(struct dpp *dpp, uint16_t frame_type,
 				const uint8_t *prefix, size_t prefix_len)
 {
 	struct l_genl_msg *msg;
@@ -3728,7 +1033,7 @@ static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
  */
 static void dpp_station_state_watch(enum station_state state, void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	if (dpp->state == DPP_STATE_NOTHING)
 		return;
@@ -3779,7 +1084,7 @@ static void dpp_station_state_watch(enum station_state state, void *user_data)
 static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus = dbus_get_bus();
-	struct dpp_sm *dpp = l_new(struct dpp_sm, 1);
+	struct dpp *dpp = l_new(struct dpp, 1);
 	uint8_t dpp_conf_response_prefix[] = { 0x04, 0x0b };
 	uint8_t dpp_conf_request_prefix[] = { 0x04, 0x0a };
 	uint64_t wdev_id = netdev_get_wdev_id(netdev);
@@ -3789,32 +1094,22 @@ static void dpp_create(struct netdev *netdev)
 	dpp->state = DPP_STATE_NOTHING;
 	dpp->interface = DPP_INTERFACE_UNBOUND;
 	dpp->wdev_id = wdev_id;
-	dpp->curve = l_ecc_curve_from_ike_group(19);
-	dpp->key_len = l_ecc_curve_get_scalar_bytes(dpp->curve);
-	dpp->nonce_len = dpp_nonce_len_from_key_len(dpp->key_len);
+
 	dpp->max_roc = wiphy_get_max_roc_duration(wiphy_find_by_wdev(wdev_id));
 	dpp->mcast_support = wiphy_has_ext_feature(
 				wiphy_find_by_wdev(dpp->wdev_id),
 				NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 
-	l_ecdh_generate_key_pair(dpp->curve, &dpp->boot_private,
-					&dpp->boot_public);
-
-	dpp->own_asn1 = dpp_point_to_asn1(dpp->boot_public, &dpp->own_asn1_len);
-
-	dpp_hash(L_CHECKSUM_SHA256, dpp->own_boot_hash, 1,
-			dpp->own_asn1, dpp->own_asn1_len);
-
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_PKEX_INTERFACE, dpp);
 	/*
-	 * Since both interfaces share the dpp_sm set this to 2. Currently both
+	 * Since both interfaces share the dpp set this to 2. Currently both
 	 * interfaces are added/removed in unison so we _could_ simply omit the
 	 * destroy callback on one of them. But for consistency and future
 	 * proofing use a reference count and the final interface being removed
-	 * will destroy the dpp_sm.
+	 * will destroy the dpp.
 	 */
 	dpp->refcount = 2;
 
@@ -3823,11 +1118,11 @@ static void dpp_create(struct netdev *netdev)
 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
 				dpp_conf_response_prefix,
 				sizeof(dpp_conf_response_prefix),
-				dpp_handle_config_response_frame, dpp, NULL);
+				dpp_handle_config_frame, dpp, NULL);
 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
 				dpp_conf_request_prefix,
 				sizeof(dpp_conf_request_prefix),
-				dpp_handle_config_request_frame, dpp, NULL);
+				dpp_handle_config_frame, dpp, NULL);
 
 	dpp->station_watch = station_add_state_watch(station,
 					dpp_station_state_watch, dpp, NULL);
@@ -3864,7 +1159,7 @@ static void dpp_netdev_watch(struct netdev *netdev,
 /*
  * EasyConnect 2.0 - 6.2.2
  */
-static uint32_t *dpp_add_default_channels(struct dpp_sm *dpp, size_t *len_out)
+static uint32_t *dpp_add_default_channels(struct dpp *dpp, size_t *len_out)
 {
 	struct wiphy *wiphy = wiphy_find_by_wdev(
 					netdev_get_wdev_id(dpp->netdev));
@@ -3901,7 +1196,7 @@ static uint32_t *dpp_add_default_channels(struct dpp_sm *dpp, size_t *len_out)
  * procedure is not being fully implemented. In reality doing this would result
  * in quite terrible DPP performance anyways.
  */
-static void dpp_start_presence(struct dpp_sm *dpp, uint32_t *limit_freqs,
+static void dpp_start_presence(struct dpp *dpp, uint32_t *limit_freqs,
 					size_t limit_len)
 {
 	if (limit_freqs) {
@@ -3921,7 +1216,7 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 
@@ -3939,17 +1234,10 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	} else if (!station)
 		l_debug("No station device, continuing anyways...");
 
-	dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
-					netdev_get_address(dpp->netdev), &freq,
-					1, NULL, NULL);
-
 	dpp->state = DPP_STATE_PRESENCE;
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
 	dpp->interface = DPP_INTERFACE_DPP;
 
-	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
-					&dpp->own_proto_public);
-
 	l_debug("DPP Start Enrollee: %s", dpp->uri);
 
 	dpp->pending = l_dbus_message_ref(message);
@@ -3971,7 +1259,7 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
  * will go offchannel to frequencies advertised by the enrollees URI or,
  * if no channels are provided, use a default channel list.
  */
-static bool dpp_configurator_start_presence(struct dpp_sm *dpp, const char *uri)
+static bool dpp_configurator_start_presence(struct dpp *dpp, const char *uri)
 {
 	_auto_(l_free) uint32_t *freqs = NULL;
 	size_t freqs_len = 0;
@@ -4002,20 +1290,8 @@ static bool dpp_configurator_start_presence(struct dpp_sm *dpp, const char *uri)
 	if (info->freqs)
 		freqs = scan_freq_set_to_fixed_array(info->freqs, &freqs_len);
 
-	dpp->peer_boot_public = l_ecc_point_clone(info->boot_public);
-	dpp->peer_asn1 = dpp_point_to_asn1(info->boot_public,
-						&dpp->peer_asn1_len);
-
 	dpp_free_uri_info(info);
 
-	if (!dpp->peer_asn1) {
-		l_debug("Peer boot key did not convert to asn1");
-		return false;
-	}
-
-	dpp_hash(L_CHECKSUM_SHA256, dpp->peer_boot_hash, 1, dpp->peer_asn1,
-			dpp->peer_asn1_len);
-
 	dpp_start_presence(dpp, freqs, freqs_len);
 
 	return true;
@@ -4027,7 +1303,7 @@ static struct l_dbus_message *dpp_start_configurator_common(
 						void *user_data,
 						bool responder)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	struct l_dbus_message *reply;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	struct scan_bss *bss;
@@ -4059,9 +1335,6 @@ static struct l_dbus_message *dpp_start_configurator_common(
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
-					&dpp->own_proto_public);
-
 	dpp->state = DPP_STATE_PRESENCE;
 
 	if (!responder) {
@@ -4071,12 +1344,6 @@ static struct l_dbus_message *dpp_start_configurator_common(
 		if (!dpp_configurator_start_presence(dpp, uri))
 			return dbus_error_invalid_args(message);
 
-		/* Since we have the peer's URI generate the keys now */
-		l_getrandom(dpp->i_nonce, dpp->nonce_len);
-
-		dpp->m = dpp_derive_k1(dpp->peer_boot_public,
-					dpp->proto_private, dpp->k1);
-
 		if (!dpp->mcast_support)
 			dpp->state = DPP_STATE_AUTHENTICATING;
 
@@ -4084,9 +1351,6 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	} else
 		dpp->current_freq = bss->frequency;
 
-	dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
-					netdev_get_address(dpp->netdev),
-					&bss->frequency, 1, NULL, NULL);
 	dpp->role = DPP_CAPABILITY_CONFIGURATOR;
 	dpp->interface = DPP_INTERFACE_DPP;
 	dpp->config = dpp_configuration_new(settings,
@@ -4122,7 +1386,7 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	l_debug("");
 
@@ -4136,7 +1400,7 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 
 static void dpp_pkex_scan_trigger(int err, void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	if (err < 0)
 		dpp_reset(dpp);
@@ -4152,7 +1416,7 @@ static void dpp_pkex_scan_trigger(int err, void *user_data)
  *           operation only in the 5.150 - 5.250 GHz band and Channel
  *           149 (5.745 GHz) otherwise
  */
-static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
+static uint32_t *dpp_default_freqs(struct dpp *dpp, size_t *out_len)
 {
 	struct wiphy *wiphy = wiphy_find_by_wdev(dpp->wdev_id);
 	uint32_t default_channels[3] = { 2437, 5220, 5745 };
@@ -4184,7 +1448,7 @@ static bool dpp_pkex_scan_notify(int err, struct l_queue *bss_list,
 					const struct scan_freq_set *freqs,
 					void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	const struct l_queue_entry *e;
 	_auto_(scan_freq_set_free) struct scan_freq_set *freq_set = NULL;
 
@@ -4216,8 +1480,6 @@ static bool dpp_pkex_scan_notify(int err, struct l_queue *bss_list,
 start:
 	dpp->current_freq = dpp->freqs[0];
 
-	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
-
 	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
 
 	dpp_start_offchannel(dpp, dpp->current_freq);
@@ -4231,12 +1493,12 @@ failed:
 
 static void dpp_pkex_scan_destroy(void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	dpp->pkex_scan_id = 0;
 }
 
-static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
+static bool dpp_start_pkex_enrollee(struct dpp *dpp, const char *key,
 				const char *identifier)
 {
 	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
@@ -4256,28 +1518,6 @@ static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
 	 * but for now use max_roc or 200ms, whichever is less.
 	 */
 	dpp->dwell = (dpp->max_roc < 200) ? dpp->max_roc : 200;
-	/* "DPP R2 devices are expected to use PKEXv1 by default" */
-	dpp->pkex_version = 1;
-
-	if (!l_ecdh_generate_key_pair(dpp->curve, &dpp->pkex_private,
-					&dpp->pkex_public))
-		goto failed;
-
-	/*
-	 * "If Qi is the point-at-infinity, the code shall be deleted and the
-	 * user should be notified to provision a new code"
-	 */
-	qi = dpp_derive_qi(dpp->curve, dpp->pkex_key, dpp->pkex_id,
-				netdev_get_address(dpp->netdev));
-	if (!qi || l_ecc_point_is_infinity(qi)) {
-		l_debug("Cannot derive Qi, provision a new code");
-		goto failed;
-	}
-
-	dpp->pkex_m = l_ecc_point_new(dpp->curve);
-
-	if (!l_ecc_point_add(dpp->pkex_m, dpp->pkex_public, qi))
-		goto failed;
 
 	dpp_property_changed_notify(dpp);
 
@@ -4349,7 +1589,7 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	const char *key;
 	const char *id;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
@@ -4377,14 +1617,14 @@ invalid_args:
 
 static void pkex_agent_disconnect(struct l_dbus *dbus, void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	l_debug("SharedCodeAgent %s disconnected", dpp->agent->path);
 
 	dpp_reset(dpp);
 }
 
-static void dpp_create_agent(struct dpp_sm *dpp, const char *path,
+static void dpp_create_agent(struct dpp *dpp, const char *path,
 					struct l_dbus_message *message)
 {
 	const char *sender = l_dbus_message_get_sender(message);
@@ -4401,7 +1641,7 @@ static void dpp_create_agent(struct dpp_sm *dpp, const char *path,
 	l_debug("Registered a SharedCodeAgent on path %s", path);
 }
 
-static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
+static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp *dpp,
 					const char *key, const char *identifier,
 					const char *agent_path,
 					struct l_dbus_message *message)
@@ -4444,12 +1684,10 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 	dpp->state = DPP_STATE_PKEX_EXCHANGE;
 	dpp->interface = DPP_INTERFACE_PKEX;
 	dpp->current_freq = bss->frequency;
-	dpp->pkex_version = 1;
 	dpp->config = dpp_configuration_new(network_get_settings(network),
 						network_get_ssid(network),
 						hs->akm_suite);
 
-	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
 	dpp_property_changed_notify(dpp);
 
 	if (dpp->pkex_key)
@@ -4465,7 +1703,7 @@ static struct l_dbus_message *dpp_dbus_pkex_configure_enrollee(
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	const char *key;
 	const char *id;
 
@@ -4482,7 +1720,7 @@ static struct l_dbus_message *dpp_dbus_pkex_start_configurator(
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 	const char *path;
 
 	if (!l_dbus_message_get_arguments(message, "o", &path))
@@ -4512,7 +1750,7 @@ static void dpp_setup_interface(struct l_dbus_interface *interface)
 static struct l_dbus_message *dpp_dbus_pkex_stop(struct l_dbus *dbus,
 				struct l_dbus_message *message, void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	l_debug("");
 
@@ -4543,7 +1781,7 @@ static void dpp_setup_pkex_interface(struct l_dbus_interface *interface)
 
 static void dpp_destroy_interface(void *user_data)
 {
-	struct dpp_sm *dpp = user_data;
+	struct dpp *dpp = user_data;
 
 	if (--dpp->refcount)
 		return;
-- 
2.34.1

