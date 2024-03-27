Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B921EF0D
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552807; cv=none; b=pOIBGgZpbFo1jo09XagRzOeqXlDd7FqyBJxsq7Lwpt3j8dF95Ahm1XBTaQo/R7+RjPB/wjJSm/U1td7hxYYnx7r0yWf9y1Ewe2xIyiA8j2DNue+FxXUqfrqleYI3qANVhRIwUAS5dgoqU3IgFrroDxuubpKckOgd3/voCXnTQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552807; c=relaxed/simple;
	bh=sFTQKNf5ZO84V2j7VJzumOiE8EsS7sMgoo117zfDSZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyGKhh3IV1ztEsAZRuTqG7GUI0nd4Bv30ahvp7HBv6dqbR9XAEN7hmAIArMjt3VdJaCHjnFZ59NA05I5Yw8qv9TB++CPupn3OamHFMK2edqOO8MB/CQ+14vTAw+M2oP/ZUtBC0K2ZoG+yvTUkVaKfv0v384y9KjCRSd+MJgla9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9nQGMSz; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9nQGMSz"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-695df25699fso56883776d6.2
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552804; x=1712157604; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2pOd3LND5n34HOza4BfVKn2HqMkXWPIWVe5Ll/LzXg=;
        b=O9nQGMSzUDrCpU941xoa9aLeXNYXlcoQlRBK7jPGdRIpSmAJFrI3H+e06pkGQbFSyp
         BWOYIQQ0KwDzf/pYwRVELoT4hrwkP4wEn6LzEojlVEgtiRaC1n90dR8CCsKPTe2PVD37
         VXcdC7QyN0sGJDrFSBr1SmznxVi9RA65+N4iVRLgeT2EltEAcYFzq7Kvk646hHvGyU9W
         Oj+ECdOWb+YgHODpVLIJ8c3Dulv3XAZJFGJBGZ98PUhgeUsyVnWQmUgoFJGEXwUvPLwQ
         wdnpNlkpZhZrZvMr7cFEx8pWUNxdXtxqhX2K09Lwew0g7aSRiEczA7/TsFZiqmkI1EEG
         8jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552804; x=1712157604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2pOd3LND5n34HOza4BfVKn2HqMkXWPIWVe5Ll/LzXg=;
        b=kKRpO5tU8SokOSsYt0pitMu/IOfFap1sGW0yye/1iQATB9oD/R849aoZ0cF3Ruap7t
         is5SioMicp0Mla4mZKYe4pZs9YtJxNeZCvYUjJo5HrikDdChTYifGOS8Wenw5U8LjC1x
         3ftd7FTfZMXF9FwxbTRuOwEdP8429KwIvmte5ZMxGJ839GLq9h0L/swoEowR5OITUzPW
         3dsZqiUOrQFJxmnCwcX3A68IsxMT8IxbHZ+cWXCUIlti32vF01AIpjxGJEdNmpuOPt3k
         VfNNIac/mluJbK4e9OxVwRTv3VnloAk25CNa/Xo5hGOrg9TXlE2THu1vgm3nwSY+MkYJ
         wIbw==
X-Gm-Message-State: AOJu0Yw6i7mI6dOPh4Y4nuJm6kh5QdH9qvoz/wwl/yW/0ijIMkpBejUO
	e18gzZfcIlwPGowhsP4Qzi0xR6PtW+JMAx1OIzaXI+4vdus05KCptW1qLNMP
X-Google-Smtp-Source: AGHT+IGLsHRM1dBcFmblVWE7TW3WX6chzrjvwWMcfVu3e/xMP2nhto7jeGxBb4OxoSnIoRM7O+HbvQ==
X-Received: by 2002:a05:6214:1c49:b0:690:a66b:268e with SMTP id if9-20020a0562141c4900b00690a66b268emr1878466qvb.57.1711552803711;
        Wed, 27 Mar 2024 08:20:03 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 7-20020a056214202700b006968ce99b7esm3520782qvf.34.2024.03.27.08.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:20:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/9] dpp-util: move AAD logic within dpp_append_wrapped_attributes
Date: Wed, 27 Mar 2024 08:19:50 -0700
Message-Id: <20240327151957.1446149-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327151957.1446149-1-prestwoj@gmail.com>
References: <20240327151957.1446149-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leaving it up to the caller to calcluate the AAD resulted in lots of
magic values, and any comments associated are spread out within
dpp.c. The AAD values can be calculated entirely by the frame
contents so move that within dpp_append_wrapped_data.

The caller now only needs to pass the frame (after the mpdu header),
the length, and the offset to where the wrapped data should start.
The new AAD calculation includes all relavent comments so magic
offsets are documented.

The reason the entire mmpdu_body is not passed to
dpp_append_wrapped_attributes (and one byte further) is to future
proof for DPP encapsulation using TCP. For this, the category byte
is omitted and only the action byte and further is encapsulated.
Having dpp_append_wrapped_attributes start at the action byte
allows it to work regardless of 8021x or TCP encapsulation.
---
 src/dpp-util.c | 167 +++++++++++++++++++++++++++++++++++++++++++++----
 src/dpp-util.h |   5 +-
 src/dpp.c      |  99 +++++++++++++++++------------
 3 files changed, 218 insertions(+), 53 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index cfdedbdd..ada7ed96 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -39,6 +39,11 @@
 #include "ell/asn1-private.h"
 #include "src/ie.h"
 
+#define DPP_ACTION_VENDOR_SPECIFIC	0x09
+#define DPP_ACTION_GAS_REQUEST		0x0a
+#define DPP_ACTION_GAS_RESPONSE		0x0b
+#define DPP_HDR_LEN			6
+
 /* WFA Easy Connect v3.0 C.1 Role-specific Elements for NIST p256 */
 static const uint8_t dpp_pkex_initiator_p256[64] = {
 	/* X */
@@ -463,22 +468,91 @@ uint8_t *dpp_unwrap_attr(const void *ad0, size_t ad0_len, const void *ad1,
 	return unwrapped;
 }
 
+static bool dpp_aad(const uint8_t *frame, size_t frame_len, uint8_t *to,
+			const uint8_t **ad0, size_t *ad0_len,
+			const uint8_t **ad1, size_t *ad1_len)
+{
+	/* For PKEX frames */
+	static uint8_t zero = 0;
+	static uint8_t one = 1;
+	enum dpp_frame_type type;
+	/* OUI field (inclusive) */
+	const uint8_t *start = frame + 1;
+
+	if (frame_len < 6)
+		return false;
+
+	type = l_get_u8(frame + 6);
+
+	switch (type) {
+
+	case DPP_FRAME_AUTHENTICATION_REQUEST:
+	case DPP_FRAME_AUTHENTICATION_RESPONSE:
+	case DPP_FRAME_AUTHENTICATION_CONFIRM:
+	case DPP_FRAME_CONFIGURATION_RESULT:
+		/*
+		 * Section 6.3.1.4 Protocol Conventions
+		 * All other invocations of AES-SIV in the DPP Authentication
+		 * protocol shall pass a vector of AAD having two components of
+		 * AAD in the following order:
+		 *     (1) the DPP header, as defined in Table 34, from the OUI
+		 *         field (inclusive) to the DPP Frame Type field
+		 *         (inclusive); and
+		 *     (2) all octets in a DPP Public Action frame after the DPP
+		 *         Frame Type field up to and including the last octet
+		 *         of the last attribute before the Wrapped Data
+		 *         attribute
+		 *
+		 * Note: The configuration result frame uses identical wordage
+		 *       but is in Section 6.4.1
+		 */
+		*ad0 = start;
+		*ad0_len = DPP_HDR_LEN;
+		*ad1 = start + DPP_HDR_LEN;
+		*ad1_len = to - start - DPP_HDR_LEN;
+		return true;
+	case DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST:
+		/*
+		 * The AAD for this operation shall consist of two components:
+		 *     (1) the DPP header, as defined in Table 34, from the OUI
+		 *         field (inclusive) to the DPP Frame Type field
+		 *         (inclusive); and
+		 *     (2) a single octet of the value zero
+		 */
+		*ad0 = start;
+		*ad0_len = DPP_HDR_LEN;
+		*ad1 = &zero;
+		*ad1_len = 1;
+		return true;
+	case DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE:
+		/*
+		 * The AAD for this operation shall consist of two components:
+		 *     (1) the DPP header, as defined in Table 34, from the OUI
+		 *         field (inclusive) to the DPP Frame Type field
+		 *         (inclusive); and
+		 *     (2) a single octet of the value one
+		 */
+		*ad0 = start;
+		*ad0_len = DPP_HDR_LEN;
+		*ad1 = &one;
+		*ad1_len = 1;
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
- * Encrypt DPP attributes encapsulated in DPP wrapped data.
- *
- * ad0/ad0_len - frame specific AD0 component
- * ad1/ad0_len - frame specific AD1 component
- * to - buffer to encrypt data.
- * to_len - size of 'to'
+ * frame - start of action frame (excluding mpdu header and category)
+ * frame_len - total frame buffer size
+ * to - current position of DPP attributes (where wrapped data will start)
  * key - key used to encrypt
  * key_len - size of 'key'
  * num_attrs - number of attributes listed (type, length, data triplets)
  * ... - List of attributes, Type, Length, and data
  */
-size_t dpp_append_wrapped_data(const void *ad0, size_t ad0_len,
-				const void *ad1, size_t ad1_len,
-				uint8_t *to, size_t to_len,
-				const void *key, size_t key_len,
+size_t dpp_append_wrapped_data(const uint8_t *frame, size_t frame_len,
+				uint8_t *to, const void *key, size_t key_len,
 				size_t num_attrs, ...)
 {
 	size_t i;
@@ -488,6 +562,77 @@ size_t dpp_append_wrapped_data(const void *ad0, size_t ad0_len,
 	struct iovec ad[2];
 	size_t ad_size = 0;
 	va_list va;
+	uint8_t action;
+	const uint8_t *ad0 = NULL;
+	const uint8_t *ad1 = NULL;
+	size_t ad0_len, ad1_len;
+
+	/*
+	 * First determine the frame type. This could be passed in but due to
+	 * The config protocol using GAS request/response frames not all frames
+	 * map to a dpp_frame_type enum. Due to this, minimal parsing is done
+	 * on the frame to determine the type, and in turn the AAD
+	 * offsets/lengths.
+	 */
+	if (frame_len < 1)
+		return 0;
+
+	action = *frame;
+
+	switch (action) {
+	case DPP_ACTION_VENDOR_SPECIFIC:
+		if (!dpp_aad(frame, frame_len, to, &ad0, &ad0_len,
+				&ad1, &ad1_len))
+			return 0;
+
+		break;
+	/*
+	 * Section 6.4.1 Overview
+	 *
+	 * "AAD for use with AES-SIV for protected messages in the DPP
+	 * Configuration protocol shall consist of all octets in the
+	 * Query Request and Query Response fields up to the first octet
+	 * of the Wrapped Data attribute, which is the last attribute in a DPP
+	 * Configuration frame. When the number of octets of AAD is zero, the
+	 * number of components of AAD passed to AES-SIV is zero
+	 */
+	case DPP_ACTION_GAS_REQUEST:
+		/*
+		 * 8.3.2 DPP Configuration Request frame
+		 * The attributes begin 14 bytes after the action (inclusive)
+		 */
+		if (frame_len < 14)
+			return 0;
+
+		/* Start of query request */
+		ad0 = frame + 14;
+		/* "up to the first octet of the Wrapped Data attribute" */
+		ad0_len = to - frame - 14;
+
+		if (!ad0_len)
+			ad0 = NULL;
+
+		break;
+	case DPP_ACTION_GAS_RESPONSE:
+		/*
+		 * 8.3.3 DPP Configuration Response frame
+		 * The attributes begin 18 bytes after the action (inclusive)
+		 */
+		if (frame_len < 18)
+			return 0;
+
+		/* Start of query response */
+		ad0 = frame + 18;
+		/* "up to the first octet of the Wrapped Data attribute" */
+		ad0_len = to - frame - 18;
+
+		if (!ad0_len)
+			ad0 = NULL;
+
+		break;
+	default:
+		return 0;
+	}
 
 	va_start(va, num_attrs);
 
@@ -500,7 +645,7 @@ size_t dpp_append_wrapped_data(const void *ad0, size_t ad0_len,
 
 	va_end(va);
 
-	if (to_len < attrs_len + 4 + 16)
+	if (frame_len - (to - frame) < attrs_len + 4 + 16)
 		return false;
 
 	plaintext = l_malloc(attrs_len);
diff --git a/src/dpp-util.h b/src/dpp-util.h
index dc8a894b..387750aa 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -148,9 +148,8 @@ uint8_t *dpp_unwrap_attr(const void *ad0, size_t ad0_len, const void *ad1,
 				size_t *unwrapped_len);
 size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
 				void *attr, size_t attr_len);
-size_t dpp_append_wrapped_data(const void *ad0, size_t ad0_len, const void *ad1,
-				size_t ad1_len, uint8_t *to, size_t to_len,
-				const void *key, size_t key_len,
+size_t dpp_append_wrapped_data(const uint8_t *frame, size_t frame_len,
+				uint8_t *to, const void *key, size_t key_len,
 				size_t num_attrs, ...);
 
 char *dpp_generate_uri(const uint8_t *asn1, size_t asn1_len, uint8_t version,
diff --git a/src/dpp.c b/src/dpp.c
index 5aac22a7..d710aa98 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -758,6 +758,9 @@ static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
 	size_t json_len = strlen(json);
 	uint8_t *ptr = frame;
 	uint8_t *lptr;
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+
+	memset(frame, 0, sizeof(frame));
 
 	l_getrandom(&dpp->diag_token, 1);
 
@@ -779,7 +782,8 @@ static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
 	 * In this case there is no query request/response fields, nor any
 	 * attributes besides wrapped data meaning zero AD components.
 	 */
-	ptr += dpp_append_wrapped_data(NULL, 0, NULL, 0, ptr, sizeof(frame),
+	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
 			dpp->ke, dpp->key_len, 2,
 			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce,
 			DPP_ATTR_CONFIGURATION_REQUEST, json_len, json);
@@ -800,11 +804,15 @@ static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
 	uint8_t frame[256];
 	uint8_t *ptr = frame;
 	uint8_t zero = 0;
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+
+	memset(frame, 0, sizeof(frame));
 
 	ptr += dpp_build_header(netdev_get_address(dpp->netdev), to,
 					DPP_FRAME_CONFIGURATION_RESULT, ptr);
-	ptr += dpp_append_wrapped_data(frame + 26, 6, ptr, 0, ptr,
-			sizeof(frame), dpp->ke, dpp->key_len, 2,
+	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
+			dpp->ke, dpp->key_len, 2,
 			DPP_ATTR_STATUS, (size_t) 1, &zero,
 			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce);
 
@@ -1163,6 +1171,7 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 	size_t json_len;
 	uint8_t *ptr = frame;
 	uint8_t *lptr;
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
 
 	memset(frame, 0, sizeof(frame));
 
@@ -1205,19 +1214,19 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 		json = dpp_configuration_to_json(dpp->config);
 		json_len = strlen(json);
 
-		ptr += dpp_append_wrapped_data(lptr + 2, ptr - lptr - 2,
-						NULL, 0, ptr, sizeof(frame),
-						dpp->ke, dpp->key_len, 2,
-						DPP_ATTR_ENROLLEE_NONCE,
-						dpp->nonce_len, dpp->e_nonce,
-						DPP_ATTR_CONFIGURATION_OBJECT,
-						json_len, json);
+		ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+				sizeof(frame) - mmpdu_header_len(hdr) - 1,
+				ptr, dpp->ke, dpp->key_len, 2,
+				DPP_ATTR_ENROLLEE_NONCE,
+				dpp->nonce_len, dpp->e_nonce,
+				DPP_ATTR_CONFIGURATION_OBJECT,
+				json_len, json);
 	} else
-		ptr += dpp_append_wrapped_data(lptr + 2, ptr - lptr - 2,
-						NULL, 0, ptr, sizeof(frame),
-						dpp->ke, dpp->key_len, 2,
-						DPP_ATTR_ENROLLEE_NONCE,
-						dpp->nonce_len, dpp->e_nonce);
+		ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+				sizeof(frame) - mmpdu_header_len(hdr) - 1,
+				ptr, dpp->ke, dpp->key_len, 2,
+				DPP_ATTR_ENROLLEE_NONCE,
+				dpp->nonce_len, dpp->e_nonce);
 
 	l_put_le16(ptr - lptr - 2, lptr);
 
@@ -1494,7 +1503,6 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 {
 	uint8_t frame[512];
 	uint8_t *ptr = frame;
-	uint8_t *attrs;
 	uint8_t status = DPP_STATUS_OK;
 	uint64_t r_proto_key[L_ECC_MAX_DIGITS * 2];
 	uint8_t version = 2;
@@ -1502,6 +1510,9 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 	uint8_t wrapped2_plaintext[dpp->key_len + 4];
 	uint8_t wrapped2[dpp->key_len + 16 + 8];
 	size_t wrapped2_len;
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+
+	memset(frame, 0, sizeof(frame));
 
 	l_ecc_point_get_data(dpp->own_proto_public, r_proto_key,
 				sizeof(r_proto_key));
@@ -1509,7 +1520,6 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 				dpp->peer_addr,
 				DPP_FRAME_AUTHENTICATION_RESPONSE, ptr);
-	attrs = ptr;
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 				dpp->own_boot_hash, 32);
@@ -1538,8 +1548,9 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 
 	wrapped2_len += 16;
 
-	ptr += dpp_append_wrapped_data(frame + 26, 6, attrs, ptr - attrs,
-			ptr, sizeof(frame), dpp->k2, dpp->key_len, 4,
+	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
+			dpp->k2, dpp->key_len, 4,
 			DPP_ATTR_RESPONDER_NONCE, dpp->nonce_len, dpp->r_nonce,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
 			DPP_ATTR_RESPONDER_CAPABILITIES, (size_t) 1, &dpp->role,
@@ -1694,23 +1705,25 @@ static void dpp_auth_request_failed(struct dpp_sm *dpp,
 {
 	uint8_t frame[128];
 	uint8_t *ptr = frame;
-	uint8_t *attrs;
 	uint8_t version = 2;
 	uint8_t s = status;
 	struct iovec iov;
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+
+	memset(frame, 0, sizeof(frame));
 
 	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 				dpp->peer_addr,
 				DPP_FRAME_AUTHENTICATION_RESPONSE, ptr);
-	attrs = ptr;
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &s, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 				dpp->own_boot_hash, 32);
 
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
 
-	ptr += dpp_append_wrapped_data(frame + 26, 6, attrs, ptr - attrs,
-			ptr, sizeof(frame) - (ptr - attrs), k1, dpp->key_len, 2,
+	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
+			k1, dpp->key_len, 2,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
 			DPP_ATTR_RESPONDER_CAPABILITIES,
 			(size_t) 1, &dpp->role);
@@ -1765,12 +1778,14 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 {
 	uint8_t frame[256];
 	uint8_t *ptr = frame;
-	uint8_t *attrs;
 	uint64_t i_proto_key[L_ECC_MAX_DIGITS * 2];
 	uint8_t version = 2;
 	struct iovec iov;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	struct scan_bss *bss = station_get_connected_bss(station);
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+
+	memset(frame, 0, sizeof(frame));
 
 	/* Got disconnected by the time the peer was discovered */
 	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR && !bss) {
@@ -1784,8 +1799,6 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 				dpp->peer_addr,
 				DPP_FRAME_AUTHENTICATION_REQUEST, ptr);
-	attrs = ptr;
-
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 				dpp->peer_boot_hash, 32);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
@@ -1802,8 +1815,9 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 		ptr += dpp_append_attr(ptr, DPP_ATTR_CHANNEL, pair, 2);
 	}
 
-	ptr += dpp_append_wrapped_data(frame + 26, 6, attrs, ptr - attrs,
-			ptr, sizeof(frame), dpp->k1, dpp->key_len, 2,
+	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
+			dpp->k1, dpp->key_len, 2,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
 			DPP_ATTR_INITIATOR_CAPABILITIES,
 			(size_t) 1, &dpp->role);
@@ -1857,9 +1871,11 @@ static void dpp_send_commit_reveal_request(struct dpp_sm *dpp)
 	struct iovec iov;
 	uint8_t frame[512];
 	uint8_t *ptr = frame;
-	uint8_t zero = 0;
 	uint8_t a_pub[L_ECC_POINT_MAX_BYTES];
 	ssize_t a_len;
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+
+	memset(frame, 0, sizeof(frame));
 
 	a_len = l_ecc_point_get_data(dpp->boot_public, a_pub, sizeof(a_pub));
 
@@ -1867,8 +1883,9 @@ static void dpp_send_commit_reveal_request(struct dpp_sm *dpp)
 					dpp->peer_addr,
 					DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST,
 					ptr);
-	ptr += dpp_append_wrapped_data(frame + 26, 6, &zero, 1, ptr,
-			sizeof(frame), dpp->z, dpp->z_len, 2,
+	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
+			dpp->z, dpp->z_len, 2,
 			DPP_ATTR_BOOTSTRAPPING_KEY, a_len, a_pub,
 			DPP_ATTR_INITIATOR_AUTH_TAG, dpp->u_len, dpp->u);
 
@@ -2264,13 +2281,14 @@ static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
 	struct iovec iov;
 	uint8_t frame[256];
 	uint8_t *ptr = frame;
-	uint8_t *attrs;
 	uint8_t zero = 0;
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+
+	memset(frame, 0, sizeof(frame));
 
 	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 					dpp->peer_addr,
 					DPP_FRAME_AUTHENTICATION_CONFIRM, ptr);
-	attrs = ptr;
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &zero, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 					dpp->peer_boot_hash, 32);
@@ -2278,8 +2296,9 @@ static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
 		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
 					dpp->own_boot_hash, 32);
 
-	ptr += dpp_append_wrapped_data(frame + 26, 6, attrs, ptr - attrs, ptr,
-			sizeof(frame), dpp->ke, dpp->key_len, 1,
+	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
+			dpp->ke, dpp->key_len, 1,
 			DPP_ATTR_INITIATOR_AUTH_TAG, dpp->key_len,
 			dpp->auth_tag);
 
@@ -3301,19 +3320,21 @@ static void dpp_send_commit_reveal_response(struct dpp_sm *dpp,
 {
 	uint8_t frame[256];
 	uint8_t *ptr = frame;
-	uint8_t one = 1;
 	struct iovec iov;
 	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
 	uint8_t b_pub[L_ECC_POINT_MAX_BYTES];
 	size_t b_len;
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
 
-	b_len = l_ecc_point_get_data(dpp->boot_public, b_pub, sizeof(b_pub));
+	memset(frame, 0, sizeof(frame));
 
+	b_len = l_ecc_point_get_data(dpp->boot_public, b_pub, sizeof(b_pub));
 
 	ptr += dpp_build_header(own_mac, dpp->peer_addr,
 				DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE, ptr);
-	ptr += dpp_append_wrapped_data(frame + 26, 6, &one, 1, ptr,
-			sizeof(frame), dpp->z, dpp->z_len, 2,
+	ptr += dpp_append_wrapped_data(mmpdu_body(hdr) + 1,
+			sizeof(frame) - mmpdu_header_len(hdr) - 1, ptr,
+			dpp->z, dpp->z_len, 2,
 			DPP_ATTR_BOOTSTRAPPING_KEY, b_len, b_pub,
 			DPP_ATTR_RESPONDER_AUTH_TAG, v_len, v);
 
-- 
2.34.1

