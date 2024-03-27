Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E528DDC
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552807; cv=none; b=KcI1crAfAK3u2E41Gfpz2zI1+iRODctpw9GoHy8vX2E+0po/KcJu3c/2Mq4n7HFtC5NODI/qOa0rYcfMs5Gs7e2jTW0wT9MMcDKhEUiV8rqT+I5OG3i8y+zxEKN3RTWQykrzbWtwbne+OfMj/PoRz0DfDQGP9ul8nY02cWLSdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552807; c=relaxed/simple;
	bh=jJ5esnnRNgXe3z3MIu5zboM+GnUmYAxAdp1sy3EHfXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eH/JA+KZVFb7z8T1ElUIWeL1WiS+iQbw77G//b3Fp2gTpm13IPI6KPDg2kdjjyMEr9JiH1X+LcgX8I5VJqteGZUqCNpol2X8bOKz9gF9jj1JFs+XphApJNe7wd6+XsFQt+HYDHKg6SRTZ5wlqEburlQNVakaepOoZd7eJD4jcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuoAKYIf; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuoAKYIf"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6a5bd015dso3174687a34.2
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552802; x=1712157602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4JYrgMBb05/WBhrrCym7IMqYhMQgQYQ/GI1tbANiwLc=;
        b=OuoAKYIfaEM25uIGO2y9nNxLxmgFm0hs9EFKp4ZORypMAzielLRUZewj0Uc8tC3uXC
         HVVNL/hS89Di+f8chnSrMVy4n9i5j+H3jVN+tNZGbc6KlvNX/HOSkN6cMBwZ5ae4L0+Y
         vb094r0oRMKqbu30izktGKLQw+10s1HzXX2HnULK225J0uXKZKYRADtvQexrlMdixA0J
         YFd3tT2G4Wy+1+Z9bhWLztp8cX8LBY7bQULV032vAkLJOEiZwSTcHmYU9Zi9ICFR7o+j
         43YuIaUtWPCA/d/nheKb+fYfmlzi5qJ7Qtapa0fMAK48O6KjuVCSdqGjLtTEZJtUxxHO
         u9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552802; x=1712157602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JYrgMBb05/WBhrrCym7IMqYhMQgQYQ/GI1tbANiwLc=;
        b=TsfieqKoW+GUeeDkHw6vF8UhJKVLC8wtnph+5CwwCsLeh/7Qg7Ou5DkiLcZWaxi6yA
         ORKV6qjzv1F3aoia6B99smmwx5S2inhM+H9QcedmUE+6dL6HsoZk4mfiYeAU4J3Bx18b
         7bMrAGb0qJxsMktbnrW06+KbqE3cugCZYKdU25yqSH9OTYyIuQZDuYy2aDV9kxoNpUO/
         JqTvN+v8fB9NM2W3f8BLpMgkyyUQhCA/lExEaQ7ZGjFIl+RGEyw9NZEh9N3mvR1fS+IB
         3ReInhY4LM4d30rSDl6hCnUxzuSIHogKe8G/EVbwZQfCxcV/DZyT9dBNsS2+kVp23INV
         yIug==
X-Gm-Message-State: AOJu0YzUxyQWrIbMsYPJxTTJaL3Th1lYeDAY4afdgDsaFeikHxKILmtS
	lsNHS5hCykbm8/1pWek84psODVyabP+MSBjfE7uqP1PRvGyMwsXLVX4SsDzQ
X-Google-Smtp-Source: AGHT+IF8beWLdeA7yyKpqG8zCMLCVWR0eAJbF5Vk8aFs2WBmlISK20IV+g2y+tQ0sbzRh2muzPUncg==
X-Received: by 2002:a05:6808:13cc:b0:3c3:cde0:735e with SMTP id d12-20020a05680813cc00b003c3cde0735emr259864oiw.14.1711552802456;
        Wed, 27 Mar 2024 08:20:02 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 7-20020a056214202700b006968ce99b7esm3520782qvf.34.2024.03.27.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:20:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] dpp: prep for moving AAD within dpp_append_wrapped_data
Date: Wed, 27 Mar 2024 08:19:49 -0700
Message-Id: <20240327151957.1446149-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AAD pointers for DPP are specific to the frame type. This is
currently sorted out by the caller within the respective frame
building functions but its quite unreadable. There are some comments
but lots of magic numbers. This should be moved within the
dpp_append_wrapped_data utility but the first step is to make the
frame buffer continuous. This will allow the entire frame to be
passed and dpp_append_wrapped_data can calculate the AAD offsets
itself.
---
 src/dpp.c | 239 +++++++++++++++++++++++++-----------------------------
 1 file changed, 112 insertions(+), 127 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 567fe8d2..5aac22a7 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -648,7 +648,7 @@ static void dpp_frame_retry(struct dpp_sm *dpp)
 
 static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
 				enum dpp_frame_type type,
-				uint8_t buf[static 32])
+				uint8_t *buf)
 {
 	uint8_t *ptr = buf + 24;
 
@@ -672,7 +672,7 @@ static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
 
 static size_t dpp_build_config_header(const uint8_t *src, const uint8_t *dest,
 					uint8_t diag_token,
-					uint8_t buf[static 37])
+					uint8_t *buf)
 {
 	uint8_t *ptr = buf + 24;
 
@@ -753,22 +753,21 @@ static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
 {
 	const char *json = "{\"name\":\"IWD\",\"wi-fi_tech\":\"infra\","
 				"\"netRole\":\"sta\"}";
-	struct iovec iov[3];
-	uint8_t hdr[37];
-	uint8_t attrs[512];
+	struct iovec iov;
+	uint8_t frame[512];
 	size_t json_len = strlen(json);
-	uint8_t *ptr = attrs;
+	uint8_t *ptr = frame;
+	uint8_t *lptr;
 
 	l_getrandom(&dpp->diag_token, 1);
 
-	iov[0].iov_len = dpp_build_config_header(
-					netdev_get_address(dpp->netdev),
-					addr, dpp->diag_token, hdr);
-	iov[0].iov_base = hdr;
+	ptr += dpp_build_config_header(netdev_get_address(dpp->netdev),
+					addr, dpp->diag_token, ptr);
 
 	l_getrandom(dpp->e_nonce, dpp->nonce_len);
 
 	/* length */
+	lptr = ptr;
 	ptr += 2;
 
 	/*
@@ -780,42 +779,39 @@ static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
 	 * In this case there is no query request/response fields, nor any
 	 * attributes besides wrapped data meaning zero AD components.
 	 */
-	ptr += dpp_append_wrapped_data(NULL, 0, NULL, 0, ptr, sizeof(attrs),
+	ptr += dpp_append_wrapped_data(NULL, 0, NULL, 0, ptr, sizeof(frame),
 			dpp->ke, dpp->key_len, 2,
 			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce,
 			DPP_ATTR_CONFIGURATION_REQUEST, json_len, json);
 
-	l_put_le16(ptr - attrs - 2, attrs);
+	l_put_le16(ptr - lptr - 2, lptr);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
 	dpp->state = DPP_STATE_CONFIGURING;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 
 static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
 {
-	uint8_t hdr[32];
-	struct iovec iov[2];
-	uint8_t attrs[256];
-	uint8_t *ptr = attrs;
+	struct iovec iov;
+	uint8_t frame[256];
+	uint8_t *ptr = frame;
 	uint8_t zero = 0;
 
-	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev), to,
-					DPP_FRAME_CONFIGURATION_RESULT, hdr);
-	iov[0].iov_base = hdr;
-
-	ptr += dpp_append_wrapped_data(hdr + 26, 6, attrs, 0, ptr,
-			sizeof(attrs), dpp->ke, dpp->key_len, 2,
+	ptr += dpp_build_header(netdev_get_address(dpp->netdev), to,
+					DPP_FRAME_CONFIGURATION_RESULT, ptr);
+	ptr += dpp_append_wrapped_data(frame + 26, 6, ptr, 0, ptr,
+			sizeof(frame), dpp->ke, dpp->key_len, 2,
 			DPP_ATTR_STATUS, (size_t) 1, &zero,
 			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 
 static void dpp_write_config(struct dpp_configuration *config,
@@ -1162,18 +1158,20 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 {
 	_auto_(l_free) char *json = NULL;
-	struct iovec iov[3];
-	uint8_t hdr[41];
-	uint8_t attrs[512];
+	struct iovec iov;
+	uint8_t frame[512];
 	size_t json_len;
-	uint8_t *ptr = hdr + 24;
+	uint8_t *ptr = frame;
+	uint8_t *lptr;
+
+	memset(frame, 0, sizeof(frame));
 
-	memset(hdr, 0, sizeof(hdr));
+	l_put_le16(0x00d0, ptr);
+	memcpy(ptr + 4, dpp->peer_addr, 6);
+	memcpy(ptr + 10, netdev_get_address(dpp->netdev), 6);
+	memcpy(ptr + 16, broadcast, 6);
 
-	l_put_le16(0x00d0, hdr);
-	memcpy(hdr + 4, dpp->peer_addr, 6);
-	memcpy(hdr + 10, netdev_get_address(dpp->netdev), 6);
-	memcpy(hdr + 16, broadcast, 6);
+	ptr += 24;
 
 	*ptr++ = 0x04;
 	*ptr++ = 0x0b;
@@ -1192,11 +1190,7 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 	*ptr++ = 0x1a;
 	*ptr++ = 1;
 
-	iov[0].iov_base = hdr;
-	iov[0].iov_len = ptr - hdr;
-
-	ptr = attrs;
-
+	lptr = ptr;
 	ptr += 2; /* length */
 
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
@@ -1211,26 +1205,26 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 		json = dpp_configuration_to_json(dpp->config);
 		json_len = strlen(json);
 
-		ptr += dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
-						NULL, 0, ptr, sizeof(attrs),
+		ptr += dpp_append_wrapped_data(lptr + 2, ptr - lptr - 2,
+						NULL, 0, ptr, sizeof(frame),
 						dpp->ke, dpp->key_len, 2,
 						DPP_ATTR_ENROLLEE_NONCE,
 						dpp->nonce_len, dpp->e_nonce,
 						DPP_ATTR_CONFIGURATION_OBJECT,
 						json_len, json);
 	} else
-		ptr += dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
-						NULL, 0, ptr, sizeof(attrs),
+		ptr += dpp_append_wrapped_data(lptr + 2, ptr - lptr - 2,
+						NULL, 0, ptr, sizeof(frame),
 						dpp->ke, dpp->key_len, 2,
 						DPP_ATTR_ENROLLEE_NONCE,
 						dpp->nonce_len, dpp->e_nonce);
 
-	l_put_le16(ptr - attrs - 2, attrs);
+	l_put_le16(ptr - lptr - 2, lptr);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 
 static bool dpp_check_config_header(const uint8_t *ptr)
@@ -1498,13 +1492,13 @@ static void dpp_handle_config_result_frame(struct dpp_sm *dpp,
  */
 static void send_authenticate_response(struct dpp_sm *dpp)
 {
-	uint8_t hdr[32];
-	uint8_t attrs[512];
-	uint8_t *ptr = attrs;
+	uint8_t frame[512];
+	uint8_t *ptr = frame;
+	uint8_t *attrs;
 	uint8_t status = DPP_STATUS_OK;
 	uint64_t r_proto_key[L_ECC_MAX_DIGITS * 2];
 	uint8_t version = 2;
-	struct iovec iov[3];
+	struct iovec iov;
 	uint8_t wrapped2_plaintext[dpp->key_len + 4];
 	uint8_t wrapped2[dpp->key_len + 16 + 8];
 	size_t wrapped2_len;
@@ -1512,11 +1506,10 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 	l_ecc_point_get_data(dpp->own_proto_public, r_proto_key,
 				sizeof(r_proto_key));
 
-	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
+	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 				dpp->peer_addr,
-				DPP_FRAME_AUTHENTICATION_RESPONSE, hdr);
-	iov[0].iov_base = hdr;
-
+				DPP_FRAME_AUTHENTICATION_RESPONSE, ptr);
+	attrs = ptr;
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 				dpp->own_boot_hash, 32);
@@ -1545,17 +1538,17 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 
 	wrapped2_len += 16;
 
-	ptr += dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs,
-			ptr, sizeof(attrs), dpp->k2, dpp->key_len, 4,
+	ptr += dpp_append_wrapped_data(frame + 26, 6, attrs, ptr - attrs,
+			ptr, sizeof(frame), dpp->k2, dpp->key_len, 4,
 			DPP_ATTR_RESPONDER_NONCE, dpp->nonce_len, dpp->r_nonce,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
 			DPP_ATTR_RESPONDER_CAPABILITIES, (size_t) 1, &dpp->role,
 			DPP_ATTR_WRAPPED_DATA, wrapped2_len, wrapped2);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 
 static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
@@ -1699,34 +1692,33 @@ static void dpp_auth_request_failed(struct dpp_sm *dpp,
 					enum dpp_status status,
 					void *k1)
 {
-	uint8_t hdr[32];
-	uint8_t attrs[128];
-	uint8_t *ptr = attrs;
+	uint8_t frame[128];
+	uint8_t *ptr = frame;
+	uint8_t *attrs;
 	uint8_t version = 2;
 	uint8_t s = status;
-	struct iovec iov[2];
+	struct iovec iov;
 
-	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
+	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 				dpp->peer_addr,
-				DPP_FRAME_AUTHENTICATION_RESPONSE, hdr);
-	iov[0].iov_base = hdr;
-
+				DPP_FRAME_AUTHENTICATION_RESPONSE, ptr);
+	attrs = ptr;
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &s, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 				dpp->own_boot_hash, 32);
 
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
 
-	ptr += dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs,
-			ptr, sizeof(attrs) - (ptr - attrs), k1, dpp->key_len, 2,
+	ptr += dpp_append_wrapped_data(frame + 26, 6, attrs, ptr - attrs,
+			ptr, sizeof(frame) - (ptr - attrs), k1, dpp->key_len, 2,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
 			DPP_ATTR_RESPONDER_CAPABILITIES,
 			(size_t) 1, &dpp->role);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 
 static bool dpp_check_roles(struct dpp_sm *dpp, uint8_t peer_capa)
@@ -1771,12 +1763,12 @@ static void dpp_presence_announce(struct dpp_sm *dpp)
 
 static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 {
-	uint8_t hdr[32];
-	uint8_t attrs[256];
-	uint8_t *ptr = attrs;
+	uint8_t frame[256];
+	uint8_t *ptr = frame;
+	uint8_t *attrs;
 	uint64_t i_proto_key[L_ECC_MAX_DIGITS * 2];
 	uint8_t version = 2;
-	struct iovec iov[2];
+	struct iovec iov;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	struct scan_bss *bss = station_get_connected_bss(station);
 
@@ -1789,10 +1781,10 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 	l_ecc_point_get_data(dpp->own_proto_public, i_proto_key,
 				sizeof(i_proto_key));
 
-	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
+	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 				dpp->peer_addr,
-				DPP_FRAME_AUTHENTICATION_REQUEST, hdr);
-	iov[0].iov_base = hdr;
+				DPP_FRAME_AUTHENTICATION_REQUEST, ptr);
+	attrs = ptr;
 
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 				dpp->peer_boot_hash, 32);
@@ -1810,16 +1802,16 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 		ptr += dpp_append_attr(ptr, DPP_ATTR_CHANNEL, pair, 2);
 	}
 
-	ptr += dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs,
-			ptr, sizeof(attrs), dpp->k1, dpp->key_len, 2,
+	ptr += dpp_append_wrapped_data(frame + 26, 6, attrs, ptr - attrs,
+			ptr, sizeof(frame), dpp->k1, dpp->key_len, 2,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
 			DPP_ATTR_INITIATOR_CAPABILITIES,
 			(size_t) 1, &dpp->role);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 
 	return true;
 }
@@ -1862,31 +1854,28 @@ static void dpp_send_pkex_exchange_request(struct dpp_sm *dpp)
 
 static void dpp_send_commit_reveal_request(struct dpp_sm *dpp)
 {
-	struct iovec iov[2];
-	uint8_t hdr[41];
-	uint8_t attrs[512];
-	uint8_t *ptr = attrs;
+	struct iovec iov;
+	uint8_t frame[512];
+	uint8_t *ptr = frame;
 	uint8_t zero = 0;
 	uint8_t a_pub[L_ECC_POINT_MAX_BYTES];
 	ssize_t a_len;
 
 	a_len = l_ecc_point_get_data(dpp->boot_public, a_pub, sizeof(a_pub));
 
-	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
+	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 					dpp->peer_addr,
 					DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST,
-					hdr);
-	iov[0].iov_base = hdr;
-
-	ptr += dpp_append_wrapped_data(hdr + 26, 6, &zero, 1, ptr,
-			sizeof(attrs), dpp->z, dpp->z_len, 2,
+					ptr);
+	ptr += dpp_append_wrapped_data(frame + 26, 6, &zero, 1, ptr,
+			sizeof(frame), dpp->z, dpp->z_len, 2,
 			DPP_ATTR_BOOTSTRAPPING_KEY, a_len, a_pub,
 			DPP_ATTR_INITIATOR_AUTH_TAG, dpp->u_len, dpp->u);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 
 static void dpp_roc_started(void *user_data)
@@ -2272,17 +2261,16 @@ auth_request_failed:
 
 static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
 {
-	uint8_t hdr[32];
-	struct iovec iov[2];
-	uint8_t attrs[256];
-	uint8_t *ptr = attrs;
+	struct iovec iov;
+	uint8_t frame[256];
+	uint8_t *ptr = frame;
+	uint8_t *attrs;
 	uint8_t zero = 0;
 
-	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
+	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 					dpp->peer_addr,
-					DPP_FRAME_AUTHENTICATION_CONFIRM, hdr);
-	iov[0].iov_base = hdr;
-
+					DPP_FRAME_AUTHENTICATION_CONFIRM, ptr);
+	attrs = ptr;
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &zero, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 					dpp->peer_boot_hash, 32);
@@ -2290,15 +2278,15 @@ static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
 		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
 					dpp->own_boot_hash, 32);
 
-	ptr += dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs, ptr,
-			sizeof(attrs), dpp->ke, dpp->key_len, 1,
+	ptr += dpp_append_wrapped_data(frame + 26, 6, attrs, ptr - attrs, ptr,
+			sizeof(frame), dpp->ke, dpp->key_len, 1,
 			DPP_ATTR_INITIATOR_AUTH_TAG, dpp->key_len,
 			dpp->auth_tag);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 
 static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
@@ -3311,11 +3299,10 @@ bad_group:
 static void dpp_send_commit_reveal_response(struct dpp_sm *dpp,
 						const uint8_t *v, size_t v_len)
 {
-	uint8_t hdr[32];
-	uint8_t attrs[256];
-	uint8_t *ptr = attrs;
+	uint8_t frame[256];
+	uint8_t *ptr = frame;
 	uint8_t one = 1;
-	struct iovec iov[2];
+	struct iovec iov;
 	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
 	uint8_t b_pub[L_ECC_POINT_MAX_BYTES];
 	size_t b_len;
@@ -3323,19 +3310,17 @@ static void dpp_send_commit_reveal_response(struct dpp_sm *dpp,
 	b_len = l_ecc_point_get_data(dpp->boot_public, b_pub, sizeof(b_pub));
 
 
-	iov[0].iov_len = dpp_build_header(own_mac, dpp->peer_addr,
-				DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE, hdr);
-	iov[0].iov_base = hdr;
-
-	ptr += dpp_append_wrapped_data(hdr + 26, 6, &one, 1, ptr,
-			sizeof(attrs), dpp->z, dpp->z_len, 2,
+	ptr += dpp_build_header(own_mac, dpp->peer_addr,
+				DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE, ptr);
+	ptr += dpp_append_wrapped_data(frame + 26, 6, &one, 1, ptr,
+			sizeof(frame), dpp->z, dpp->z_len, 2,
 			DPP_ATTR_BOOTSTRAPPING_KEY, b_len, b_pub,
 			DPP_ATTR_RESPONDER_AUTH_TAG, v_len, v);
 
-	iov[1].iov_base = attrs;
-	iov[1].iov_len = ptr - attrs;
+	iov.iov_base = frame;
+	iov.iov_len = ptr - frame;
 
-	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
 }
 
 static void dpp_handle_pkex_commit_reveal_request(struct dpp_sm *dpp,
-- 
2.34.1

