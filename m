Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256A2AB47
	for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 17:25:42 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6300510605bso28962116d6.0
        for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281941; x=1689873941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq+Oi7Zirz4f2I5iCURAGUNbEUw+cKmOpqjfxk0bz0s=;
        b=PWAqv2iad/Eu0byeyyMX+rQ2hliDCChRCGy5gP5b0VmwO1vnqlHd4SoNnSCsA96eXc
         UO7zpEWoIIBlueQBp77fCGUp9WbSsNsB9rj/7VBLDF4ZsDDQsGlT/Oin8VoZR9+yBEJb
         TMXZXnmMJAEpGIauRELCJJTplehywTOdzaWTf/rRbfWQd5NR33U/YeNaHQ4bcXgvgdgE
         TC5PNO4JYZz2Fhzioca8pOo/VgZSoCMt1oKRsnbCfUIbyZN4in6k5Shh5GF8Yb6hOmk1
         O67Co9I8zIEUKcdiQu7jMcOnbM5DpDzzDLMUnvMq3puGuiAPtqABqmA46ep0ITtAb5Oq
         cB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281941; x=1689873941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq+Oi7Zirz4f2I5iCURAGUNbEUw+cKmOpqjfxk0bz0s=;
        b=Q8XapnS+MJ/s+9y+BO6TLc0VpgYsvCLbibVHzAHIuEAoqlq3x/M1Hd54UMpVd1AnyP
         nb32NxkealXfj/400wThH82L8j7vauLfL1mQPsjnq3qN8j5G/ceqKgZGDvnKDy4yUvDj
         4YTeTGOwSKpo+RPGckunvC9oHoKCLeBrD+uSGjFGX3ccn39JvOkG7LZfHEdJupW9TJ0z
         YYd33HQOxNuTlqMYPJdWLnR/hMPFyGS8Vhh1zKSplNSkWQuvYeBzhiv7TiEWQzR1sKDa
         EhiQcYxAKAUd+2f4CPWIi+9uvIW94h05pntq7JEs4VfqBOf/DqbNrw8mW3FGtMT25VH2
         y8ow==
X-Gm-Message-State: AC+VfDzeMEq/TCyL6i3KGWpYv0CrqDFK6yXC8VTAgHDJbPBmttOPUa81
	S6f+JKmGwVqmUQBO6jq2Z864UGQSaagdgA==
X-Google-Smtp-Source: ACHHUZ6hZpvz6eg4pJGD0cRivb46wpW138j34TVAY01jjZQNGdXiLNGX7pHtaNC9oMVR1H6XAabhsQ==
X-Received: by 2002:a05:6214:f01:b0:625:87e4:1689 with SMTP id gw1-20020a0562140f0100b0062587e41689mr17346759qvb.20.1687281941129;
        Tue, 20 Jun 2023 10:25:41 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g8-20020a0cf088000000b006261e6a88c7sm1475913qvk.36.2023.06.20.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:25:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3 v2] crypto: modify crypto_derive_pmkid to take the length/checksum type
Date: Tue, 20 Jun 2023 10:25:31 -0700
Message-Id: <20230620172533.727504-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620172533.727504-1-prestwoj@gmail.com>
References: <20230620172533.727504-1-prestwoj@gmail.com>
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
 src/crypto.c    | 10 ++++------
 src/crypto.h    |  5 +++--
 src/eapol.c     |  4 ++--
 src/handshake.c |  9 ++++-----
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index 840d9ee4..099b8695 100644
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
 
@@ -1126,10 +1127,7 @@ bool crypto_derive_pmkid(const uint8_t *pmk,
 	memcpy(data + 8, addr2, 6);
 	memcpy(data + 14, addr1, 6);
 
-	if (use_sha256)
-		return hmac_sha256(pmk, 32, data, 20, out_pmkid, 16);
-	else
-		return hmac_sha1(pmk, 32, data, 20, out_pmkid, 16);
+	return hmac_common(checksum, pmk, key_len, data, 20, out_pmkid, 16);
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
index 37f5eaaa..f290f40a 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1112,8 +1112,8 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 	memcpy(ek->key_nonce, sm->handshake->anonce, sizeof(ek->key_nonce));
 
 	/* Write the PMKID KDE into Key Data field unencrypted */
-	crypto_derive_pmkid(sm->handshake->pmk, sm->handshake->spa, aa,
-			pmkid, false);
+	crypto_derive_pmkid(sm->handshake->pmk, 32, sm->handshake->spa, aa,
+			pmkid, L_CHECKSUM_SHA1);
 
 	eapol_key_data_append(ek, sm->mic_len, HANDSHAKE_KDE_PMKID, pmkid, 16);
 
diff --git a/src/handshake.c b/src/handshake.c
index cd9b3082..ac5bda51 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -736,7 +736,7 @@ void handshake_state_set_pmkid(struct handshake_state *s, const uint8_t *pmkid)
 
 bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 {
-	bool use_sha256;
+	enum l_checksum_type sha;
 
 	/* SAE exports pmkid */
 	if (s->have_pmkid) {
@@ -757,12 +757,11 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 
 	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
 			IE_RSN_AKM_SUITE_PSK_SHA256))
-		use_sha256 = true;
+		sha = L_CHECKSUM_SHA256;
 	else
-		use_sha256 = false;
+		sha = L_CHECKSUM_SHA1;
 
-	return crypto_derive_pmkid(s->pmk, s->spa, s->aa, out_pmkid,
-					use_sha256);
+	return crypto_derive_pmkid(s->pmk, 32, s->spa, s->aa, out_pmkid, sha);
 }
 
 void handshake_state_set_gtk(struct handshake_state *s, const uint8_t *key,
-- 
2.25.1

