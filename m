Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9807156CE
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/HAhwIt"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-779fb118fe4so96012685a.2
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352035; x=1698956835; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdxpq72IgTIrQSGPnwcZL28kW20N6UFvKjYBlPkvscE=;
        b=i/HAhwItUqEjaAXpIkUYT/0XvkYkOLPN7b59yhgacLS/cQul/iWC0k55C8nBbJF2fB
         fr+dc0F3D4zIaGVY9Z3lyngocyyIC6jbRq/yGfC/EKQjjfrBxLJFP5tkXaSwyxfyCC1P
         1JcXrpmgYTPmGzewENs01O8tyB5EvEHorrMqeAtlJy8DkIYciG4U7DjDNd4UF4UdtKW/
         t+1E36DEUUqJG0Nb2c+AYULV5IQtiqg8rsUrMCyhJR+M2vHxK2y/MHQojskmqI5cQ0rW
         ingVR2kp676qupN6EPsoxNFmWVYJFjulm5RTyQQN6mxK4YhH5YcACZA6wwHNUmHHrHqy
         rL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352035; x=1698956835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdxpq72IgTIrQSGPnwcZL28kW20N6UFvKjYBlPkvscE=;
        b=Rdp7msSSRbCS+oD9MHiJO5uf7C2vpHETC4Q/JsNUgWCNl/aovR0NPXCjfy46G/OxeE
         iQxwjOKfkrYLwYwM717UfYiUnakL/vya8nGK2QO1RLACFZoEN7DCi1zfNojSaoXySgnx
         UMgddfisHneMAo9FSNpI+3H5Aivsp5wzmeiedK+iSXo9z5oRL8QCAL7VeqxNFZO0QdO3
         uObbEKUBNIgfXkZgmJR6AtDTc+qJeXewvzE8v7ygxKYTqMic7PIfKBtU3/WsWUamdKaT
         s7Ur6+2efwvx2LlRP++WX9xK1jq1lpVtDE/TmbiTBtdsKQobUGzvdZNv2KPEJUuk9DGj
         3SDg==
X-Gm-Message-State: AOJu0Yzr8c17M4sbNUkD4UP8Y66ihl2+GH2xpr6R071q9bw7pH31iIQo
	MjEX/cOJZ9iLaO2j9MaWbxZKCgYOQX4=
X-Google-Smtp-Source: AGHT+IGEHgzfPyCULtOYzS9r+ANEAgwECvH2b4U3a5av0U2Ms7OvWkVls1urh4j6HJtyZpISqdGQEA==
X-Received: by 2002:a05:620a:d8a:b0:777:fec:5736 with SMTP id q10-20020a05620a0d8a00b007770fec5736mr438887qkl.49.1698352034791;
        Thu, 26 Oct 2023 13:27:14 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/15] dpp-util: add crypto for PKEX
Date: Thu, 26 Oct 2023 13:26:48 -0700
Message-Id: <20231026202657.183591-7-prestwoj@gmail.com>
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

---
 src/dpp-util.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  35 +++++++
 2 files changed, 310 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 0406a4dc..cadc6437 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -39,6 +39,33 @@
 #include "ell/asn1-private.h"
 #include "src/ie.h"
 
+/* WFA Easy Connect v3.0 C.1 Role-specific Elements for NIST p256 */
+static const uint8_t dpp_pkex_initiator_p256[64] = {
+	/* X */
+	0x56, 0x26, 0x12, 0xcf, 0x36, 0x48, 0xfe, 0x0b,
+	0x07, 0x04, 0xbb, 0x12, 0x22, 0x50, 0xb2, 0x54,
+	0xb1, 0x94, 0x64, 0x7e, 0x54, 0xce, 0x08, 0x07,
+	0x2e, 0xec, 0xca, 0x74, 0x5b, 0x61, 0x2d, 0x25,
+	/* Y */
+	0x3e, 0x44, 0xc7, 0xc9, 0x8c, 0x1c, 0xa1, 0x0b,
+	0x20, 0x09, 0x93, 0xb2, 0xfd, 0xe5, 0x69, 0xdc,
+	0x75, 0xbc, 0xad, 0x33, 0xc1, 0xe7, 0xc6, 0x45,
+	0x4d, 0x10, 0x1e, 0x6a, 0x3d, 0x84, 0x3c, 0xa4
+};
+
+static const uint8_t dpp_pkex_responder_p256[64] = {
+	/* X */
+	0x1e, 0xa4, 0x8a, 0xb1, 0xa4, 0xe8, 0x42, 0x39,
+	0xad, 0x73, 0x07, 0xf2, 0x34, 0xdf, 0x57, 0x4f,
+	0xc0, 0x9d, 0x54, 0xbe, 0x36, 0x1b, 0x31, 0x0f,
+	0x59, 0x91, 0x52, 0x33, 0xac, 0x19, 0x9d, 0x76,
+	/* Y */
+	0xd9, 0xfb, 0xf6, 0xb9, 0xf5, 0xfa, 0xdf, 0x19,
+	0x58, 0xd8, 0x3e, 0xc9, 0x89, 0x7a, 0x35, 0xc1,
+	0xbd, 0xe9, 0x0b, 0x77, 0x7a, 0xcb, 0x91, 0x2a,
+	0xe8, 0x21, 0x3f, 0x47, 0x52, 0x02, 0x4d, 0x67
+};
+
 static void append_freqs(struct l_string *uri,
 					const uint32_t *freqs, size_t len)
 {
@@ -1134,3 +1161,251 @@ void dpp_free_uri_info(struct dpp_uri_info *info)
 
 	l_free(info);
 }
+
+/*
+ * 6.3.4 DPP Authentication Confirm
+ *
+ * L = bI * (BR + PR)
+ */
+struct l_ecc_point *dpp_derive_li(const struct l_ecc_point *boot_public,
+				const struct l_ecc_point *proto_public,
+				const struct l_ecc_scalar *boot_private)
+{
+	const struct l_ecc_curve *curve = l_ecc_point_get_curve(boot_public);
+	struct l_ecc_point *ret = l_ecc_point_new(curve);
+
+	l_ecc_point_add(ret, boot_public, proto_public);
+	l_ecc_point_multiply(ret, boot_private, ret);
+
+	return ret;
+}
+
+/*
+ * 6.3.3 DPP Authentication Response
+ *
+ * L = ((bR + pR) modulo q) * BI
+ */
+struct l_ecc_point *dpp_derive_lr(const struct l_ecc_scalar *boot_private,
+				const struct l_ecc_scalar *proto_private,
+				const struct l_ecc_point *peer_public)
+{
+	const struct l_ecc_curve *curve = l_ecc_point_get_curve(peer_public);
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *order =
+					l_ecc_curve_get_order(curve);
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *sum =
+					l_ecc_scalar_new(curve, NULL, 0);
+	_auto_(l_ecc_point_free) struct l_ecc_point *ret =
+					l_ecc_point_new(curve);
+
+	if (!l_ecc_scalar_add(sum, boot_private, proto_private, order))
+		return NULL;
+
+	if (!l_ecc_point_multiply(ret, sum, peer_public))
+		return NULL;
+
+	return l_steal_ptr(ret);
+}
+
+
+static struct l_ecc_point *dpp_derive_q(const struct l_ecc_curve *curve,
+					const uint8_t *p_data,
+					const char *key,
+					const char *identifier,
+					const uint8_t *mac)
+{
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *scalar = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *ret = NULL;
+	uint8_t hash[L_ECC_SCALAR_MAX_BYTES];
+	unsigned int bytes = l_ecc_curve_get_scalar_bytes(curve);
+	enum l_checksum_type type = dpp_sha_from_key_len(bytes);
+	_auto_(l_ecc_point_free) struct l_ecc_point *p = NULL;
+	struct l_checksum *sha = l_checksum_new(type);
+
+	/*
+	 * "If the Initiator indicates PKEX with a Protocol Version of 1,
+	 * MAC-Initiator shall be the MAC address of the Initiator and the
+	 * Protocol Version shall not be present. Otherwise, MAC-Initiator is
+	 * not present"
+	 *
+	 * (This goes for MAC-Responder as well)
+	 */
+	if (mac)
+		l_checksum_update(sha, mac, 6);
+
+	if (identifier)
+		l_checksum_update(sha, identifier, strlen(identifier));
+
+	l_checksum_update(sha, key, strlen(key));
+	l_checksum_get_digest(sha, hash, bytes);
+	l_checksum_free(sha);
+
+	/* Unlikely but can happen */
+	scalar = l_ecc_scalar_new(curve, hash, bytes);
+	if (!scalar)
+		return NULL;
+
+	p = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_FULL,
+					p_data, bytes * 2);
+	if (!p)
+		return NULL;
+
+	ret = l_ecc_point_new(curve);
+
+	if (!l_ecc_point_multiply(ret, scalar, p))
+		return NULL;
+
+	return l_steal_ptr(ret);
+}
+
+/*
+ * 5.6.2 PKEX Exchange Phase
+ *
+ * Qi = H([MAC-Initiator |] [identifier | ] code) * Pi
+ */
+struct l_ecc_point *dpp_derive_qi(const struct l_ecc_curve *curve,
+					const char *key,
+					const char *identifier,
+					const uint8_t *mac_initiator)
+{
+	return dpp_derive_q(curve, dpp_pkex_initiator_p256, key, identifier,
+				mac_initiator);
+}
+
+/*
+ * 5.6.2 PKEX Exchange Phase
+ *
+ * Qr = H([MAC-Responder |] [identifier | ] code) * Pr
+ */
+struct l_ecc_point *dpp_derive_qr(const struct l_ecc_curve *curve,
+					const char *key,
+					const char *identifier,
+					const uint8_t *mac_responder)
+{
+	return dpp_derive_q(curve, dpp_pkex_responder_p256, key, identifier,
+				mac_responder);
+}
+
+/*
+ * 5.6.2 PKEX Exchange Phase
+ *
+ * z = HKDF(<>, info | M.x | N.x | code, K.x)
+ */
+bool dpp_derive_z(const uint8_t *mac_i, const uint8_t *mac_r,
+				const struct l_ecc_point *n,
+				const struct l_ecc_point *m,
+				const struct l_ecc_point *k,
+				const char *key,
+				const char *identifier,
+				void *z_out, size_t *z_len)
+{
+	const struct l_ecc_curve *curve = l_ecc_point_get_curve(n);
+	size_t bytes = l_ecc_curve_get_scalar_bytes(curve);
+	enum l_checksum_type sha = dpp_sha_from_key_len(bytes);
+	uint8_t k_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t m_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t n_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t prk[L_ECC_SCALAR_MAX_BYTES];
+
+	l_ecc_point_get_x(k, k_x, sizeof(k_x));
+	l_ecc_point_get_x(m, m_x, sizeof(m_x));
+	l_ecc_point_get_x(n, n_x, sizeof(n_x));
+
+	hkdf_extract(sha, NULL, 0, 1, prk, k_x, bytes);
+
+	/* HKDF-Extract (since it doesn't take non-string arguments)*/
+	prf_plus(sha, prk, bytes, z_out, bytes, 5, mac_i, 6, mac_r, 6, m_x,
+			bytes, n_x, bytes, key, strlen(key));
+
+	*z_len = bytes;
+
+	return true;
+}
+
+/*
+ * 5.6.3 PKEX Commit-Reveal Phase
+ *
+ * Initiator derivation:
+ * u = HMAC(J.x, [MAC-Initiator |] A.x | Y'.x | X.x )
+ *
+ * Responder derivation:
+ * u' = HMAC(J'.x, [MAC-Initiator |] A'.x | Y.x | X'.x)
+ */
+bool dpp_derive_u(const struct l_ecc_point *j,
+			const uint8_t *mac_i,
+			const struct l_ecc_point *a,
+			const struct l_ecc_point *y,
+			const struct l_ecc_point *x,
+			void *u_out, size_t *u_len)
+{
+	const struct l_ecc_curve *curve = l_ecc_point_get_curve(y);
+	uint8_t j_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t a_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t y_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t x_x[L_ECC_SCALAR_MAX_BYTES];
+	size_t bytes = l_ecc_curve_get_scalar_bytes(curve);
+	enum l_checksum_type sha = dpp_sha_from_key_len(bytes);
+	struct l_checksum *hmac;
+
+	l_ecc_point_get_x(j, j_x, bytes);
+	l_ecc_point_get_x(a, a_x, bytes);
+	l_ecc_point_get_x(y, y_x, bytes);
+	l_ecc_point_get_x(x, x_x, bytes);
+
+	/* u = HMAC(J.x, MAC-Initiator | A.x | Y'.x | X.x)*/
+	hmac = l_checksum_new_hmac(sha, j_x, bytes);
+	l_checksum_update(hmac, mac_i, 6);
+	l_checksum_update(hmac, a_x, bytes);
+	l_checksum_update(hmac, y_x, bytes);
+	l_checksum_update(hmac, x_x, bytes);
+	l_checksum_get_digest(hmac, u_out, bytes);
+	l_checksum_free(hmac);
+
+	*u_len = bytes;
+
+	return true;
+}
+
+/*
+ * 5.6.3 PKEX Commit-Reveal Phase
+ *
+ * Initiator derivation:
+ * v = HMAC(L.x, [MAC-Responder |] B.x | X'.x |Y.x )
+ *
+ * Responder derivation:
+ * v' = HMAC(L.x, [MAC-Responder |] B'.x | X.x | Y'.x )
+ */
+bool dpp_derive_v(const struct l_ecc_point *l, const uint8_t *mac,
+			const struct l_ecc_point *b,
+			const struct l_ecc_point *x,
+			const struct l_ecc_point *y,
+			void *v_out, size_t *v_len)
+{
+	const struct l_ecc_curve *curve = l_ecc_point_get_curve(l);
+	uint8_t l_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t b_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t x_x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t y_x[L_ECC_SCALAR_MAX_BYTES];
+	size_t bytes = l_ecc_curve_get_scalar_bytes(curve);
+	enum l_checksum_type sha = dpp_sha_from_key_len(bytes);
+	struct l_checksum *hmac;
+
+	l_ecc_point_get_x(l, l_x, sizeof(l_x));
+	l_ecc_point_get_x(b, b_x, sizeof(b_x));
+	l_ecc_point_get_x(x, x_x, sizeof(x_x));
+	l_ecc_point_get_x(y, y_x, sizeof(y_x));
+
+	hmac = l_checksum_new_hmac(sha, l_x, bytes);
+
+	if (mac)
+		l_checksum_update(hmac, mac, 6);
+
+	l_checksum_update(hmac, b_x, bytes);
+	l_checksum_update(hmac, x_x, bytes);
+	l_checksum_update(hmac, y_x, bytes);
+	l_checksum_get_digest(hmac, v_out, bytes);
+	l_checksum_free(hmac);
+
+	*v_len = bytes;
+
+	return true;
+}
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 96711c35..5f9a2ff4 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -183,3 +183,38 @@ struct l_ecc_point *dpp_point_from_asn1(const uint8_t *asn1, size_t len);
 
 struct dpp_uri_info *dpp_parse_uri(const char *uri);
 void dpp_free_uri_info(struct dpp_uri_info *info);
+
+struct l_ecc_point *dpp_derive_qi(const struct l_ecc_curve *curve,
+					const char *key,
+					const char *identifier,
+					const uint8_t *mac_initiator);
+struct l_ecc_point *dpp_derive_qr(const struct l_ecc_curve *curve,
+					const char *key,
+					const char *identifier,
+					const uint8_t *mac_responder);
+struct l_ecc_point *dpp_derive_li(
+				const struct l_ecc_point *boot_public,
+				const struct l_ecc_point *proto_public,
+				const struct l_ecc_scalar *boot_private);
+struct l_ecc_point *dpp_derive_lr(
+				const struct l_ecc_scalar *boot_private,
+				const struct l_ecc_scalar *proto_private,
+				const struct l_ecc_point *peer_public);
+bool dpp_derive_z(const uint8_t *mac_i, const uint8_t *mac_r,
+				const struct l_ecc_point *n,
+				const struct l_ecc_point *m,
+				const struct l_ecc_point *k,
+				const char *key,
+				const char *identifier,
+				void *z_out, size_t *z_len);
+bool dpp_derive_u(const struct l_ecc_point *j,
+			const uint8_t *mac_i,
+			const struct l_ecc_point *a,
+			const struct l_ecc_point *y,
+			const struct l_ecc_point *x,
+			void *u_out, size_t *u_len);
+bool dpp_derive_v(const struct l_ecc_point *l, const uint8_t *mac,
+			const struct l_ecc_point *b,
+			const struct l_ecc_point *x,
+			const struct l_ecc_point *y,
+			void *v_out, size_t *v_len);
-- 
2.25.1

