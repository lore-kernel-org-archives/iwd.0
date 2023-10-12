Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15923C6B0
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Ll4F1d"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c888b3a25aso11422735ad.0
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140928; x=1697745728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJeJDFRoAxVOQIu0OQPOFgq6AIgCxMsqYFDJ3fsfN8w=;
        b=L5Ll4F1dPWnNHhvJjJRXs6hPYFwCJEuhjq1Pa/JD1T08Z104k5VBlbzIjEM2l9nB20
         mt0xXHFsg9Q6IryXewajMjEVIvM1Xcr89fj8ss9fCVp+QfbGP+1nDtIHfYJiptEv7Zcu
         5IiBGKRWpS6T23IuwjFgSpTJzhzG/mR1Rt1owImfj6JG4adnzPG+ZqEYbhZDRNp0hZNC
         yPhoDQem+MXn/U4Nv4mr+hvSRJjj3natG4nE7i9VhGDPP2BLeIryfCRef/XWCsYDDZkX
         hb60UkDtJH5ifAsrDR49Z+EZKE1tbmkUb+tuzUZYuQJ1vu3CISnQqEPSQL4QUE4SQ+jO
         LHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140928; x=1697745728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJeJDFRoAxVOQIu0OQPOFgq6AIgCxMsqYFDJ3fsfN8w=;
        b=rCXKBEsAyar79xiQHvj45+gpS7+VMo6guVm+c4k8pWh2fo+gf9jC+bnpLdJR5RYzLn
         tPLbtEdsI9VYgukR0n32R8RnkzMKpQNZPN4vEphcszRG8hWltE/c/hH2nTYRW0WNsLUZ
         I518+T9ZC8TVhwsXbZSn4ZQG7ZC2NGIQ5NWdY0Xb09iFFe5taN9hil+pt789KMLbizf1
         NniVdPwFghb36TExFHoaI4TkBntgwUVjTggIhdqN/xwxI78I7DT7UEf7Q3/a3Oxhdiws
         jEk/U72yQLBiinpAFz86rDwn7/dQWBqp+P83JkbTipexzbysIQYYjEchlYSBQuy9L74E
         yd/w==
X-Gm-Message-State: AOJu0Yx+AT1kvSxU8pG2rtXqO7B5+tEL7sIEAO7/09iz3uSFfnFgkeZ7
	fSqgzwkq9O1wDcQLgfmdpHBlNbF9+BE=
X-Google-Smtp-Source: AGHT+IHsplO7wcd2TRak+/tKsfnRHOKkIjv1phWP8G6tsAKQNgaB+o9CDlQlSpjdih1ZwgwPVEE1yg==
X-Received: by 2002:a17:902:f689:b0:1c7:65e3:e605 with SMTP id l9-20020a170902f68900b001c765e3e605mr25853761plg.36.1697140928286;
        Thu, 12 Oct 2023 13:02:08 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/21] dpp: support mutual authentication
Date: Thu, 12 Oct 2023 13:01:43 -0700
Message-Id: <20231012200150.338401-15-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be needed for PKEX support. It requires an additional
value, L, be derived and used in some of the hashing functions.
---
 src/dpp.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index fc3d5c4f..adfebff3 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -149,6 +149,7 @@ struct dpp_sm {
 	bool mcast_support : 1;
 	bool roc_started : 1;
 	bool channel_switch : 1;
+	bool mutual_auth : 1;
 };
 
 static bool dpp_get_started(struct l_dbus *dbus,
@@ -1168,7 +1169,7 @@ static void dpp_handle_config_result_frame(struct dpp_sm *dpp,
 static void send_authenticate_response(struct dpp_sm *dpp)
 {
 	uint8_t hdr[32];
-	uint8_t attrs[256];
+	uint8_t attrs[512];
 	uint8_t *ptr = attrs;
 	uint8_t status = DPP_STATUS_OK;
 	uint64_t r_proto_key[L_ECC_MAX_DIGITS * 2];
@@ -1189,6 +1190,9 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 				dpp->own_boot_hash, 32);
+	if (dpp->mutual_auth)
+		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
+				dpp->peer_boot_hash, 32);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_PROTOCOL_KEY,
 				r_proto_key, dpp->key_len * 2);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
@@ -1242,6 +1246,7 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
 	const void *unwrap_key;
 	const void *ad0 = body + 2;
 	const void *ad1 = body + 8;
+	struct l_ecc_point *bi = NULL;
 
 	if (dpp->state != DPP_STATE_AUTHENTICATING)
 		return;
@@ -1334,9 +1339,12 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
 		goto auth_confirm_failed;
 	}
 
+	if (dpp->mutual_auth)
+		bi = dpp->peer_boot_public;
+
 	dpp_derive_i_auth(dpp->r_nonce, dpp->i_nonce, dpp->nonce_len,
 				dpp->own_proto_public, dpp->peer_proto_public,
-				dpp->boot_public, NULL, i_auth_check);
+				dpp->boot_public, bi, i_auth_check);
 
 	if (memcmp(i_auth, i_auth_check, i_auth_len)) {
 		l_error("I-Auth did not verify");
@@ -1652,6 +1660,8 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 	_auto_(l_free) uint8_t *unwrapped = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *m = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
+	struct l_ecc_point *bi = NULL;
 	uint64_t k1[L_ECC_MAX_DIGITS];
 	const void *ad0 = body + 2;
 	const void *ad1 = body + 8;
@@ -1799,6 +1809,13 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 
 	memcpy(dpp->i_nonce, i_nonce, i_nonce_len);
 
+	if (dpp->mutual_auth) {
+		l = dpp_derive_l_responder(dpp->boot_private,
+						dpp->proto_private,
+						dpp->peer_boot_public);
+		bi = dpp->peer_boot_public;
+	}
+
 	/* Derive keys k2, ke, and R-Auth for authentication response */
 
 	n = dpp_derive_k2(dpp->peer_proto_public, dpp->proto_private, dpp->k2);
@@ -1807,12 +1824,12 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 
 	l_getrandom(dpp->r_nonce, dpp->nonce_len);
 
-	if (!dpp_derive_ke(dpp->i_nonce, dpp->r_nonce, m, n, NULL, dpp->ke))
+	if (!dpp_derive_ke(dpp->i_nonce, dpp->r_nonce, m, n, l, dpp->ke))
 		goto auth_request_failed;
 
 	if (!dpp_derive_r_auth(dpp->i_nonce, dpp->r_nonce, dpp->nonce_len,
 				dpp->peer_proto_public, dpp->own_proto_public,
-				NULL, dpp->boot_public, dpp->auth_tag))
+				bi, dpp->boot_public, dpp->auth_tag))
 		goto auth_request_failed;
 
 	memcpy(dpp->peer_addr, from, 6);
@@ -1847,6 +1864,9 @@ static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &zero, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 					dpp->peer_boot_hash, 32);
+	if (dpp->mutual_auth)
+		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
+					dpp->own_boot_hash, 32);
 
 	ptr += dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs, ptr,
 			sizeof(attrs), dpp->ke, dpp->key_len, 1,
@@ -1879,6 +1899,8 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	const void *r_auth = NULL;
 	_auto_(l_ecc_point_free) struct l_ecc_point *r_proto_key = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
+	struct l_ecc_point *bi = NULL;
 	const void *ad0 = body + 2;
 	const void *ad1 = body + 8;
 	uint64_t r_auth_derived[L_ECC_MAX_DIGITS];
@@ -1983,7 +2005,13 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 		return;
 	}
 
-	if (!dpp_derive_ke(i_nonce, r_nonce, dpp->m, n, NULL, dpp->ke)) {
+	if (dpp->mutual_auth) {
+		l = dpp_derive_l_initiator(dpp->peer_boot_public, r_proto_key,
+						dpp->boot_private);
+		bi = dpp->boot_public;
+	}
+
+	if (!dpp_derive_ke(i_nonce, r_nonce, dpp->m, n, l, dpp->ke)) {
 		l_debug("Failed to derive ke");
 		return;
 	}
@@ -2016,7 +2044,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	}
 
 	if (!dpp_derive_r_auth(i_nonce, r_nonce, dpp->nonce_len,
-				dpp->own_proto_public, r_proto_key, NULL,
+				dpp->own_proto_public, r_proto_key, bi,
 				dpp->peer_boot_public, r_auth_derived)) {
 		l_debug("Failed to derive r_auth");
 		return;
@@ -2029,7 +2057,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 
 	if (!dpp_derive_i_auth(r_nonce, i_nonce, dpp->nonce_len,
 				r_proto_key, dpp->own_proto_public,
-				dpp->peer_boot_public, NULL, dpp->auth_tag)) {
+				dpp->peer_boot_public, bi, dpp->auth_tag)) {
 		l_debug("Could not derive I-Auth");
 		return;
 	}
-- 
2.25.1

