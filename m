Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5283C6B1
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw4mhUl/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27cfb8442f9so988958a91.2
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140923; x=1697745723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Aivrm8jlM4NES23EpFI5RFGEvkNS+oV3/aS5oro3ec=;
        b=Cw4mhUl/lnor2wa7nkQ6uumZ1Qpme0bNWplhV2f/fjFWQilUXW7LylnRcvC2I1orDg
         iMsxkZw7AH3lbFaT6v0C7w5Ro/piDN/iw/ix//wU3uMXJOBGEKNML0MAax3PWxDEULdr
         ZRWdTPtn9cLXDSIM0fAW6el/nv9Fc2CSUnA/hq087cnfPiV+fD0fS8XdyYKvbbePFlzT
         fe/VTQpRwm3bn9hH51W/CfjDIdnWq9umiwD8deQyOa4d5/BSUGn692F5YOaKMVoSlRe+
         icjzgGiDTiN67pZ9DI5O6A5I/yIfhi9hv0QgS5qdyi/KikkqSK/Jqxqr27WjVVqCrkCb
         5euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140923; x=1697745723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Aivrm8jlM4NES23EpFI5RFGEvkNS+oV3/aS5oro3ec=;
        b=dDGKd3IQYMC4FZGTeJENIGXxnWLXJ2IprlGfVpMQf6SCcK+A9KZsh9u7EYZkNFPukL
         7a7p9FcWBt/euyeBrJJxSfXAbwGIXxxlnBIxdw9cgrGRBSqcjf9P+G5aNlF2x/y57Uga
         k4isG9+SJFuKjc/jler4t6Y+MlWFyDq+Hx2C8Aq/0KqZMqUhZTUQeGSMjB5d2sJ8ZlqH
         03rsrw7UcSioVtkq6druA7SZ6W5lhdFjiGBUxXlWzGya8n13MWgBQ1C/nY7+uddaL0Pl
         kVW3iMGnhB5DoGSZGV+asWq8EhC+3znVryrDd62Q1S0RQbHm/ncV4wAcBaK9UvtU+WX3
         ZfNQ==
X-Gm-Message-State: AOJu0YyBABX0vWMVi47nANZ0m+y7pRDSWpfDD7G0CNUuHPW2M9ee52lz
	NvIwG4jYFfSicPEwTlfsvBueHUtYoTc=
X-Google-Smtp-Source: AGHT+IHGKqvwF0+UqnhlfxKW/H6IyvmDDFE0juxgS/ZXU4NyAaTD+EO90i32zVBtidf+W5mCRVBOtQ==
X-Received: by 2002:a17:90a:db0f:b0:27d:b9d:bd6f with SMTP id g15-20020a17090adb0f00b0027d0b9dbd6fmr5084915pjv.45.1697140922914;
        Thu, 12 Oct 2023 13:02:02 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/21] dpp-util: allow for mutual authentication in i/r_auth
Date: Thu, 12 Oct 2023 13:01:36 -0700
Message-Id: <20231012200150.338401-8-prestwoj@gmail.com>
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

When using mutual authentication an additional value needs to
be hashed when deriving i/r_auth values. A NULL value indicates
no mutual authentication (zero length iovec is passed to hash).
---
 src/dpp-util.c | 20 ++++++++++++++++----
 src/dpp-util.h |  4 +++-
 src/dpp.c      |  8 ++++----
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index df7d0fc5..d3171d02 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -551,12 +551,14 @@ static bool dpp_hkdf(enum l_checksum_type sha, const void *salt,
 bool dpp_derive_r_auth(const void *i_nonce, const void *r_nonce,
 				size_t nonce_len, struct l_ecc_point *i_proto,
 				struct l_ecc_point *r_proto,
+				struct l_ecc_point *i_boot,
 				struct l_ecc_point *r_boot,
 				void *r_auth)
 {
 	uint64_t pix[L_ECC_MAX_DIGITS];
 	uint64_t prx[L_ECC_MAX_DIGITS];
 	uint64_t brx[L_ECC_MAX_DIGITS];
+	uint64_t bix[L_ECC_MAX_DIGITS];
 	size_t keys_len;
 	uint8_t zero = 0;
 	enum l_checksum_type type;
@@ -565,24 +567,30 @@ bool dpp_derive_r_auth(const void *i_nonce, const void *r_nonce,
 	l_ecc_point_get_x(r_proto, prx, sizeof(prx));
 	l_ecc_point_get_x(r_boot, brx, sizeof(brx));
 
+	if (i_boot)
+		l_ecc_point_get_x(i_boot, bix, sizeof(bix));
+
 	type = dpp_sha_from_key_len(keys_len);
 
 	/*
 	 * R-auth = H(I-nonce | R-nonce | PI.x | PR.x | [ BI.x | ] BR.x | 0)
 	 */
-	return dpp_hash(type, r_auth, 6, i_nonce, nonce_len, r_nonce, nonce_len,
-			pix, keys_len, prx, keys_len, brx, keys_len,
+	return dpp_hash(type, r_auth, 7, i_nonce, nonce_len, r_nonce, nonce_len,
+			pix, keys_len, prx, keys_len,
+			bix, i_boot ? keys_len : 0, brx, keys_len,
 			&zero, (size_t) 1);
 }
 
 bool dpp_derive_i_auth(const void *r_nonce, const void *i_nonce,
 				size_t nonce_len, struct l_ecc_point *r_proto,
 				struct l_ecc_point *i_proto,
-				struct l_ecc_point *r_boot, void *i_auth)
+				struct l_ecc_point *r_boot,
+				struct l_ecc_point *i_boot, void *i_auth)
 {
 	uint64_t prx[L_ECC_MAX_DIGITS];
 	uint64_t pix[L_ECC_MAX_DIGITS];
 	uint64_t brx[L_ECC_MAX_DIGITS];
+	uint64_t bix[L_ECC_MAX_DIGITS];
 	size_t keys_len;
 	uint8_t one = 1;
 	enum l_checksum_type type;
@@ -591,13 +599,17 @@ bool dpp_derive_i_auth(const void *r_nonce, const void *i_nonce,
 	l_ecc_point_get_x(i_proto, pix, sizeof(pix));
 	l_ecc_point_get_x(r_boot, brx, sizeof(brx));
 
+	if (i_boot)
+		l_ecc_point_get_x(i_boot, bix, sizeof(bix));
+
 	type = dpp_sha_from_key_len(keys_len);
 
 	/*
 	 * I-auth = H(R-nonce | I-nonce | PR.x | PI.x | BR.x | [ BI.x | ] 1)
 	 */
-	return dpp_hash(type, i_auth, 6, r_nonce, nonce_len, i_nonce, nonce_len,
+	return dpp_hash(type, i_auth, 7, r_nonce, nonce_len, i_nonce, nonce_len,
 			prx, keys_len, pix, keys_len, brx, keys_len,
+			bix, i_boot ? keys_len : 0,
 			&one, (size_t) 1);
 }
 
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 94fe595a..050d66cc 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -160,12 +160,14 @@ bool dpp_hash(enum l_checksum_type type, uint8_t *out, unsigned int num, ...);
 bool dpp_derive_r_auth(const void *i_nonce, const void *r_nonce,
 				size_t nonce_len, struct l_ecc_point *i_proto,
 				struct l_ecc_point *r_proto,
+				struct l_ecc_point *i_boot,
 				struct l_ecc_point *r_boot,
 				void *r_auth);
 bool dpp_derive_i_auth(const void *r_nonce, const void *i_nonce,
 				size_t nonce_len, struct l_ecc_point *r_proto,
 				struct l_ecc_point *i_proto,
-				struct l_ecc_point *r_boot, void *i_auth);
+				struct l_ecc_point *r_boot,
+				struct l_ecc_point *i_boot, void *i_auth);
 struct l_ecc_scalar *dpp_derive_k1(const struct l_ecc_point *i_proto_public,
 				const struct l_ecc_scalar *boot_private,
 				void *k1);
diff --git a/src/dpp.c b/src/dpp.c
index 52adda9a..bbb27ff1 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1336,7 +1336,7 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
 
 	dpp_derive_i_auth(dpp->r_nonce, dpp->i_nonce, dpp->nonce_len,
 				dpp->own_proto_public, dpp->peer_proto_public,
-				dpp->boot_public, i_auth_check);
+				dpp->boot_public, NULL, i_auth_check);
 
 	if (memcmp(i_auth, i_auth_check, i_auth_len)) {
 		l_error("I-Auth did not verify");
@@ -1812,7 +1812,7 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 
 	if (!dpp_derive_r_auth(dpp->i_nonce, dpp->r_nonce, dpp->nonce_len,
 				dpp->peer_proto_public, dpp->own_proto_public,
-				dpp->boot_public, dpp->auth_tag))
+				NULL, dpp->boot_public, dpp->auth_tag))
 		goto auth_request_failed;
 
 	memcpy(dpp->peer_addr, from, 6);
@@ -2016,7 +2016,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	}
 
 	if (!dpp_derive_r_auth(i_nonce, r_nonce, dpp->nonce_len,
-				dpp->own_proto_public, r_proto_key,
+				dpp->own_proto_public, r_proto_key, NULL,
 				dpp->peer_boot_public, r_auth_derived)) {
 		l_debug("Failed to derive r_auth");
 		return;
@@ -2029,7 +2029,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 
 	if (!dpp_derive_i_auth(r_nonce, i_nonce, dpp->nonce_len,
 				r_proto_key, dpp->own_proto_public,
-				dpp->peer_boot_public, dpp->auth_tag)) {
+				dpp->peer_boot_public, NULL, dpp->auth_tag)) {
 		l_debug("Could not derive I-Auth");
 		return;
 	}
-- 
2.25.1

