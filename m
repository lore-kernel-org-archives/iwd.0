Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE76D24
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:42 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id ik20so5768036plb.3
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V7K1g0yOi2mxId6ry8jEABdwxw9dX/R81b7bI6hj2w=;
        b=EqnKqHGgLom3GhIUf1oCqrtPi6HXOtZZd1vu/5p2QIW+Hcp+IJfY+SLpl82PtRAAqo
         vN81LLlnGhvnVrE8O6F5xJDLVGpdYkrwPHtRJLKldwYJW/BQWlXfeRlNmKdxXgGR1Isv
         hPXsx+rvQNm4XmIirUgv5pdsAI/QZJh5VEJlRJSbT3C59Xej6HLy7buWyQ5kv2x8xbn9
         bZIFd/DGSCvJ3LeGtTdrwy3yb9bpDAv/sQ7aUDRbvEL+KfvWzoWCO+Jw4CGAjVUu9eXj
         /9YuY3gWFLqk6opVNaBayjepn3mXhzJDB7+YJiOf4IKI3XEGH/uVF4AbozHQRXvUj/vX
         IvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V7K1g0yOi2mxId6ry8jEABdwxw9dX/R81b7bI6hj2w=;
        b=oMfLtI2bmCdx05Ai4rayxTFB4TyDpzm5ibtjpK7nVdfT9qPXiPnHc5CQs8UaJvMzHQ
         n/wSTpBWKksDvbnwVGS3Adks+q4JkJYFF0bxppAS2QEpS0/bdsJvXKrLbQn4HujLWgpZ
         FaIpISwoJMx7h4FGiL8WtE+pJ7BNxiv9o7lBqIQ/ab+hmtdfAU2+C5d+kgUAJna0azFf
         vHxM85fvH2SnHNp0w/QD9ZhPUTIyeE0SaTEBpvOGFPujIHhB9dBwq7I0FTV7WFvovXSr
         f0kTrpa/GPajegvcVUj0RHWJ5Ozj86Y9tUo72G/3U+q2AuprlAhPSayJTbbaGjYODX3X
         WGJQ==
X-Gm-Message-State: AAQBX9dzdXXTshhlLUGLu6+sOLyrvpcdKpxszgMLnLPbpHXXyGw1bmC+
	UhbVDeTPDFYh6isJweoRdhqs3rbKolc7vw==
X-Google-Smtp-Source: AKy350bnOCFW3bRT2XEfIietC88A0ITEfsknwWivS17g6Vn2FPxb/6bAjhsLSgsVMeBueOqCnf0D7A==
X-Received: by 2002:a17:902:e848:b0:19e:6b5f:fda9 with SMTP id t8-20020a170902e84800b0019e6b5ffda9mr14475743plg.16.1681164101827;
        Mon, 10 Apr 2023 15:01:41 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] crypto: modify crypto_derive_pmkid to take the hash/key length
Date: Mon, 10 Apr 2023 15:01:27 -0700
Message-Id: <20230410220135.373872-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410220135.373872-1-prestwoj@gmail.com>
References: <20230410220135.373872-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing API was limited to SHA1 or SHA256 and assumed a key
length of 32 bytes. Since other AKMs plan to be added update
this to take the checksum/length directly for better flexibility.
---
 src/crypto.c    | 18 ++++++++++++------
 src/crypto.h    |  5 +++--
 src/eapol.c     |  4 ++--
 src/handshake.c | 11 ++++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index 840d9ee4..f8aba7d8 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -1116,9 +1116,10 @@ exit:
 }
 
 /* Defined in 802.11-2012, Section 11.6.1.3 Pairwise Key Hierarchy */
-bool crypto_derive_pmkid(const uint8_t *pmk,
+bool crypto_derive_pmkid(const uint8_t *pmk, size_t key_len,
 				const uint8_t *addr1, const uint8_t *addr2,
-				uint8_t *out_pmkid, bool use_sha256)
+				uint8_t *out_pmkid,
+				enum l_checksum_type checksum)
 {
 	uint8_t data[20];
 
@@ -1126,10 +1127,15 @@ bool crypto_derive_pmkid(const uint8_t *pmk,
 	memcpy(data + 8, addr2, 6);
 	memcpy(data + 14, addr1, 6);
 
-	if (use_sha256)
-		return hmac_sha256(pmk, 32, data, 20, out_pmkid, 16);
-	else
-		return hmac_sha1(pmk, 32, data, 20, out_pmkid, 16);
+	switch (checksum) {
+	case L_CHECKSUM_SHA1:
+		return hmac_sha1(pmk, key_len, data, 20, out_pmkid, 16);
+	case L_CHECKSUM_SHA256:
+		return hmac_sha256(pmk, key_len, data, 20, out_pmkid, 16);
+	default:
+		l_error("Checksum type %u is not valid", checksum);
+		return false;
+	}
 }
 
 enum l_checksum_type crypto_sae_hash_from_ecc_prime_len(enum crypto_sae type,
diff --git a/src/crypto.h b/src/crypto.h
index ed430abb..d2a96655 100644
--- a/src/crypto.h
+++ b/src/crypto.h
@@ -154,9 +154,10 @@ bool crypto_derive_ft_ptk(const uint8_t *pmk_r1, const uint8_t *pmk_r1_name,
 				bool sha384, uint8_t *out_ptk, size_t ptk_len,
 				uint8_t *out_ptk_name);
 
-bool crypto_derive_pmkid(const uint8_t *pmk,
+bool crypto_derive_pmkid(const uint8_t *pmk, size_t key_len,
 				const uint8_t *addr1, const uint8_t *addr2,
-				uint8_t *out_pmkid, bool use_sha256);
+				uint8_t *out_pmkid,
+				enum l_checksum_type checksum);
 
 enum crypto_sae {
 	CRYPTO_SAE_LOOPING,
diff --git a/src/eapol.c b/src/eapol.c
index 9471d13e..9e8f7c34 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1103,8 +1103,8 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 	memcpy(ek->key_nonce, sm->handshake->anonce, sizeof(ek->key_nonce));
 
 	/* Write the PMKID KDE into Key Data field unencrypted */
-	crypto_derive_pmkid(sm->handshake->pmk, sm->handshake->spa, aa,
-			pmkid, false);
+	crypto_derive_pmkid(sm->handshake->pmk, 32, sm->handshake->spa, aa,
+			pmkid, L_CHECKSUM_SHA1);
 
 	eapol_key_data_append(ek, sm->mic_len, HANDSHAKE_KDE_PMKID, pmkid, 16);
 
diff --git a/src/handshake.c b/src/handshake.c
index 734e997c..39a650c5 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -736,7 +736,8 @@ void handshake_state_set_pmkid(struct handshake_state *s, const uint8_t *pmkid)
 
 bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 {
-	bool use_sha256;
+	enum l_checksum_type sha;
+	size_t key_len = 32;
 
 	/* SAE exports pmkid */
 	if (s->have_pmkid) {
@@ -757,12 +758,12 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 
 	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
 			IE_RSN_AKM_SUITE_PSK_SHA256))
-		use_sha256 = true;
+		sha = L_CHECKSUM_SHA256;
 	else
-		use_sha256 = false;
+		sha = L_CHECKSUM_SHA1;
 
-	return crypto_derive_pmkid(s->pmk, s->spa, s->aa, out_pmkid,
-					use_sha256);
+	return crypto_derive_pmkid(s->pmk, key_len, s->spa, s->aa, out_pmkid,
+					sha);
 }
 
 void handshake_state_set_gtk(struct handshake_state *s, const uint8_t *key,
-- 
2.25.1

