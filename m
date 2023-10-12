Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E103B7BD
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftMF4Rtn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c5cd27b1acso12057025ad.2
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140927; x=1697745727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7QrCl1QfDzyYnsNm+akjruGqZpzWdRuGCF6J9CRREo=;
        b=ftMF4RtnFdjlpfYRflMK1wSY/hyrbu1Ngb2PAbBJNnrjHSgi1XoyfLeVmPLJNtw9Kc
         oAYlMnFymdpEECu35EGpLmHKOCzhXQj/IWikcuVl+W5QWP3+mZuLn4MBD48gfd4yPSRD
         1Ef4sIQG32P4bpxZbNWs4d18texQio/idhPSf+gGFqjmgJnfCdHlvbQsxA7wnq0weV5v
         iu6rq+GfLMf2PLRWZ+u7rU/6XNZARSxMB1lu+BF5j7SXf/ObzBarsNmCXq72VUd43Qfx
         NGXOLJSX7aQ6/9esSH3JQ2amCBxFAbcMxJDMB5Ee5RO+A0ms5cl30qqzngqbPQYxyg2k
         5LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140927; x=1697745727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7QrCl1QfDzyYnsNm+akjruGqZpzWdRuGCF6J9CRREo=;
        b=nM0R1R42BwuNjWMnfRp12K7vLnt/taliE0ekam6pylKcDnNTS8kh8FzIoWS9i3Xqfb
         1jc5k2NmNudWSR/wO0TyhwjN7W96Kmc0A1q2ygFTu7uFei0Ot5Z8p0vEFWHfavLHcZ8p
         Nl4cZY3lZKcFsrNQZvbyzRSbubrmkZ11AMxDPlcCOF+JxeDqVdjnnpcSkJKmRg20mljD
         zN3DzIHdDt+/ycHeg/svcQfkJ44bqUStQ5qUeZiblbVMHXHJJMprQ8taayJ9VTiYbcqK
         DCtkCeVjiLs+osnlNRkSVr+POz8cd0ivQFnfVO88M9sz1YtY0FQfOT2mcBej1OKEvPrH
         ZoIg==
X-Gm-Message-State: AOJu0YzFZw/+wTRBNYtw6KhVyYAmB4B85FvsTfwDxXnQETKAqWQDaDHY
	xGZ/inn7HAGvUh2orm1XO7QiaGYKVdY=
X-Google-Smtp-Source: AGHT+IGkOKX0LSzX4Tepa1HctpO2RwIZ8oJZmCS72FeQvBZaQE8ovLoQ3/ocvPFcqVNY2jSIlZowDg==
X-Received: by 2002:a17:902:d2c3:b0:1c4:4efc:90a6 with SMTP id n3-20020a170902d2c300b001c44efc90a6mr33687843plc.38.1697140926788;
        Thu, 12 Oct 2023 13:02:06 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/21] dpp-util: add crypto for PKEX
Date: Thu, 12 Oct 2023 13:01:41 -0700
Message-Id: <20231012200150.338401-13-prestwoj@gmail.com>
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

---
 src/dpp-util.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  32 ++++++++
 2 files changed, 240 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 0406a4dc..b0556917 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -39,6 +39,32 @@
 #include "ell/asn1-private.h"
 #include "src/ie.h"
 
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
@@ -1134,3 +1160,185 @@ void dpp_free_uri_info(struct dpp_uri_info *info)
 
 	l_free(info);
 }
+
+struct l_ecc_point *dpp_derive_l_initiator(
+				const struct l_ecc_point *boot_public,
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
+struct l_ecc_point *dpp_derive_l_responder(
+				const struct l_ecc_scalar *boot_private,
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
+struct l_ecc_point *dpp_derive_q(const struct l_ecc_curve *curve,
+					bool responder,
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
+	const uint8_t *p_data = responder ? dpp_pkex_responder_p256 :
+					dpp_pkex_initiator_p256;
+	struct l_checksum *sha = l_checksum_new(type);
+
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
+bool dpp_derive_v(const struct l_ecc_point *l, const uint8_t *mac,
+			const struct l_ecc_point *b,
+			const struct l_ecc_point *x,
+			const struct l_ecc_point *y,
+			uint8_t *v_out, size_t *v_len)
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
index 96711c35..6b00796e 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -183,3 +183,35 @@ struct l_ecc_point *dpp_point_from_asn1(const uint8_t *asn1, size_t len);
 
 struct dpp_uri_info *dpp_parse_uri(const char *uri);
 void dpp_free_uri_info(struct dpp_uri_info *info);
+
+struct l_ecc_point *dpp_derive_q(const struct l_ecc_curve *curve,
+					bool responder,
+					const char *key,
+					const char *identifier,
+					const uint8_t *mac);
+struct l_ecc_point *dpp_derive_l_initiator(
+				const struct l_ecc_point *boot_public,
+				const struct l_ecc_point *proto_public,
+				const struct l_ecc_scalar *boot_private);
+struct l_ecc_point *dpp_derive_l_responder(
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
+			uint8_t *v_out, size_t *v_len);
-- 
2.25.1

