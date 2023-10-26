Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34003CCFD
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghO8hap4"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-777719639adso98222685a.3
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352036; x=1698956836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFDJehJE104fBbEMsLTJPktVkCUJULKms/9kwKT+psg=;
        b=ghO8hap45ygGNewBPmoMVcklUwTcCUq32EeiRkzx0ESwQjenpUpkaucaWYY8nbMzRZ
         lXOEkLjb/11h0xOOuJUg4bj5yJbecQ9O6PwR81uvXkOiPIUx115vhlOlquW0N9gublNn
         9J3BVb5V3IhsSQQihEaKKeYi+difN1LFq2LM8EryhsuJa79Mx7aL9UfFGkWYy0WZVTek
         /YeMDVto5U7pJY3aRHq5eqoULxWBqK5Z62p3MORuFf9daHwyRxU3M06gg8FzAgoSxvEw
         Mcp89hzvB0+E7wO1IB2bkFv/5lLnUkbXs0YAj1tyu0jfPhEUwM2o2OIyxoeK51aNP0SU
         PzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352036; x=1698956836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFDJehJE104fBbEMsLTJPktVkCUJULKms/9kwKT+psg=;
        b=qSZ0GxXEPIiQZ6XYXX2q1wmKk9JZSQ2kkqDap5/nr3OkYFpjeX4ND0M4G9ppodJHH/
         jYo1lz5Qi7ahad7YxlsSRytXqvSNLo7M7JeJGUNHFg37C88ECiwK7CxPJQkkxBFSwmQO
         xCrskJSuHxtn7ypukWjX9ZfmNdy3zyuX2mQ+dgliDPqppXlfwjamr9fcANAy7Pmvshb1
         3qCquepyJ7PWCFl/rKJuFoZEt2U2tUfqVDdtSV1KrXo6u7eHOfMPFONHhz6FHx87Fzyb
         0l/j8G5s7yFDnLqx93Yh2LTVCUmVZPcIOv+UP7SZwHKnO6P7pGTtOpsqJwJfkQhNqQob
         /7KQ==
X-Gm-Message-State: AOJu0YyykdnECPwFcUZlTuNitWln87Qp03aOF21DdFGmtUxLR2i/U8st
	9MLB0UWljtZKnpsLXFjpq/+GNngEjOM=
X-Google-Smtp-Source: AGHT+IHiFDFr089o6dSrAH9yQPiHIxSlO5DwneGUjKpyA98NNSF+WpWQT/GdlbTvnV+jrDU18Aa1MQ==
X-Received: by 2002:a05:620a:280a:b0:777:b325:d02d with SMTP id f10-20020a05620a280a00b00777b325d02dmr513221qkp.33.1698352036407;
        Thu, 26 Oct 2023 13:27:16 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/15] dpp: support mutual authentication
Date: Thu, 26 Oct 2023 13:26:49 -0700
Message-Id: <20231026202657.183591-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
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
 src/dpp.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 6fd37272..77af5669 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -151,6 +151,7 @@ struct dpp_sm {
 	bool roc_started : 1;
 	bool channel_switch : 1;
 	bool station_autoconnecting : 1;
+	bool mutual_auth : 1;
 };
 
 static bool dpp_get_started(struct l_dbus *dbus,
@@ -1153,7 +1154,7 @@ static void dpp_handle_config_result_frame(struct dpp_sm *dpp,
 static void send_authenticate_response(struct dpp_sm *dpp)
 {
 	uint8_t hdr[32];
-	uint8_t attrs[256];
+	uint8_t attrs[512];
 	uint8_t *ptr = attrs;
 	uint8_t status = DPP_STATUS_OK;
 	uint64_t r_proto_key[L_ECC_MAX_DIGITS * 2];
@@ -1174,6 +1175,9 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 				dpp->own_boot_hash, 32);
+	if (dpp->mutual_auth)
+		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
+				dpp->peer_boot_hash, 32);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_PROTOCOL_KEY,
 				r_proto_key, dpp->key_len * 2);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
@@ -1227,6 +1231,7 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
 	const void *unwrap_key;
 	const void *ad0 = body + 2;
 	const void *ad1 = body + 8;
+	struct l_ecc_point *bi = NULL;
 
 	if (dpp->state != DPP_STATE_AUTHENTICATING)
 		return;
@@ -1319,9 +1324,12 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
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
@@ -1638,6 +1646,8 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 	_auto_(l_free) uint8_t *unwrapped = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *m = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
+	struct l_ecc_point *bi = NULL;
 	uint64_t k1[L_ECC_MAX_DIGITS];
 	const void *ad0 = body + 2;
 	const void *ad1 = body + 8;
@@ -1785,6 +1795,12 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 
 	memcpy(dpp->i_nonce, i_nonce, i_nonce_len);
 
+	if (dpp->mutual_auth) {
+		l = dpp_derive_lr(dpp->boot_private, dpp->proto_private,
+					dpp->peer_boot_public);
+		bi = dpp->peer_boot_public;
+	}
+
 	/* Derive keys k2, ke, and R-Auth for authentication response */
 
 	n = dpp_derive_k2(dpp->peer_proto_public, dpp->proto_private, dpp->k2);
@@ -1793,12 +1809,12 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 
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
@@ -1833,6 +1849,9 @@ static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
 	ptr += dpp_append_attr(ptr, DPP_ATTR_STATUS, &zero, 1);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH,
 					dpp->peer_boot_hash, 32);
+	if (dpp->mutual_auth)
+		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
+					dpp->own_boot_hash, 32);
 
 	ptr += dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs, ptr,
 			sizeof(attrs), dpp->ke, dpp->key_len, 1,
@@ -1865,6 +1884,8 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	const void *r_auth = NULL;
 	_auto_(l_ecc_point_free) struct l_ecc_point *r_proto_key = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
+	struct l_ecc_point *bi = NULL;
 	const void *ad0 = body + 2;
 	const void *ad1 = body + 8;
 	uint64_t r_auth_derived[L_ECC_MAX_DIGITS];
@@ -1969,7 +1990,13 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 		return;
 	}
 
-	if (!dpp_derive_ke(i_nonce, r_nonce, dpp->m, n, NULL, dpp->ke)) {
+	if (dpp->mutual_auth) {
+		l = dpp_derive_li(dpp->peer_boot_public, r_proto_key,
+					dpp->boot_private);
+		bi = dpp->boot_public;
+	}
+
+	if (!dpp_derive_ke(i_nonce, r_nonce, dpp->m, n, l, dpp->ke)) {
 		l_debug("Failed to derive ke");
 		return;
 	}
@@ -2002,7 +2029,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	}
 
 	if (!dpp_derive_r_auth(i_nonce, r_nonce, dpp->nonce_len,
-				dpp->own_proto_public, r_proto_key, NULL,
+				dpp->own_proto_public, r_proto_key, bi,
 				dpp->peer_boot_public, r_auth_derived)) {
 		l_debug("Failed to derive r_auth");
 		return;
@@ -2015,7 +2042,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 
 	if (!dpp_derive_i_auth(r_nonce, i_nonce, dpp->nonce_len,
 				r_proto_key, dpp->own_proto_public,
-				dpp->peer_boot_public, NULL, dpp->auth_tag)) {
+				dpp->peer_boot_public, bi, dpp->auth_tag)) {
 		l_debug("Could not derive I-Auth");
 		return;
 	}
-- 
2.25.1

