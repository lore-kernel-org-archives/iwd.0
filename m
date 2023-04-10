Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE008477
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:44 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso4406425pjt.4
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTJW7Z4SgsINy/itTCPc4m4DAYFN2eC4mR95RpKgNPs=;
        b=Vja9yw6LSa32xGJeaC261Ejmk0n5vlQQuFcv+jp1HM0Cl9CSJ63LFBP8IRNllLCvJB
         J5i2JyDNfa3SBR+7otUaJGgQi031Q8uarZT1pmU6KgYIDW61vR263OsHnRZl0910PrtM
         Z/nnrSyfNoOsw0/A8VJIWcova5JdAv89SRCdzIN7WSwXsWV8dMMGAu0sGAZoCU7ZcuzA
         LK+onmrgRokheXwNIFBeFvIBxqEqzOJuC8z+6AQX/J2Qre+xGyYVZ8UFGI+wxEknhCbC
         G+3ne9VO5iwFbEwdu5iPfB3zZy7HqPsF/k+uczm3w2s6R7TTyA5NPOdB9czcv/D4Or5u
         hilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTJW7Z4SgsINy/itTCPc4m4DAYFN2eC4mR95RpKgNPs=;
        b=S3ILQXAO6tY6gLDWOy2qQpSKx3yTOuORJ3lvgMathdh3rm5N9DSFi7oo4P20wm04fA
         Z62xz6N16Mpzll7FBbA5jSrWgr9qwUQBLKVy/XIxOsZPAWvTSXPkiMVoq7TEsn+UBGLq
         7hPRslqKBTYfcOp5rDddskzcx0OS2PMHhqek4uNY209UEH2+h6MdNfBkXucHJ4kRlUIq
         wn1PA1vT3MdniGxe2qwMTn8zjqG+Az176q5qjZpSh5MFofBhf8tE4NX905xNdgXJrP/9
         kmva2r3Y20LRFYb+VPKvIlncp6sEIDp98A+j6flPXQ0Bp6C5lVpO5auj5eTNZU/B5kqz
         MoZQ==
X-Gm-Message-State: AAQBX9fZfhQiXc2CI2M6VpymfqlxlKM8CzwyQbmb+vCvPXt5tUDdfWWE
	pBFLLkePIOXamf+XEjvo9tI7YI4MWjKehw==
X-Google-Smtp-Source: AKy350adcZTy6ZkBv+b2dLuTA7AmkQ+Xmued69wLNL2Ec7BHPCnD8cbJESHThF3ExbAXaXHESA8l2g==
X-Received: by 2002:a17:903:41c1:b0:1a5:1842:f7da with SMTP id u1-20020a17090341c100b001a51842f7damr12433479ple.6.1681164104028;
        Mon, 10 Apr 2023 15:01:44 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/9] handshake: support FT-8021X-SHA384
Date: Mon, 10 Apr 2023 15:01:31 -0700
Message-Id: <20230410220135.373872-6-prestwoj@gmail.com>
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

This adds the AKM to various places in handshake.c when deriving
keys to support this AKM.
---
 src/handshake.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index 82e0c1c2..362ff58a 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -505,6 +505,7 @@ bool handshake_state_derive_ptk(struct handshake_state *s)
 			return false;
 
 	if ((s->akm_suite & (IE_RSN_AKM_SUITE_FT_OVER_8021X |
+				IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384 |
 				IE_RSN_AKM_SUITE_FT_USING_PSK |
 				IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256 |
 				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
@@ -524,7 +525,8 @@ bool handshake_state_derive_ptk(struct handshake_state *s)
 		else
 			return false;
 	} else if (s->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA384 |
-			IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
+			IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
+			IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384))
 		type = L_CHECKSUM_SHA384;
 	else if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
 			IE_RSN_AKM_SUITE_PSK_SHA256 |
@@ -540,6 +542,7 @@ bool handshake_state_derive_ptk(struct handshake_state *s)
 	ptk_size = handshake_state_get_ptk_size(s);
 
 	if (s->akm_suite & (IE_RSN_AKM_SUITE_FT_OVER_8021X |
+				IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384 |
 				IE_RSN_AKM_SUITE_FT_USING_PSK |
 				IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256 |
 				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
@@ -549,7 +552,8 @@ bool handshake_state_derive_ptk(struct handshake_state *s)
 		const uint8_t *xxkey = s->pmk;
 		size_t xxkey_len = 32;
 		bool sha384 = (s->akm_suite &
-					IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384);
+					(IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
+					IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384));
 
 		/*
 		 * In a Fast Transition initial mobility domain association
@@ -562,7 +566,10 @@ bool handshake_state_derive_ptk(struct handshake_state *s)
 		 */
 		if (s->akm_suite == IE_RSN_AKM_SUITE_FT_OVER_8021X)
 			xxkey = s->pmk + 32;
-		else if (s->akm_suite & (IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
+		else if (s->akm_suite == IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384) {
+			xxkey = s->pmk;
+			xxkey_len = s->pmk_len;
+		} else if (s->akm_suite & (IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
 				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384)) {
 			xxkey = s->fils_ft;
 			xxkey_len = s->fils_ft_len;
@@ -626,7 +633,8 @@ const uint8_t *handshake_state_get_kck(struct handshake_state *s)
 
 size_t handshake_state_get_kck_len(struct handshake_state *s)
 {
-	if (s->akm_suite & IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384)
+	if (s->akm_suite & (IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
+			IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384))
 		return 24;
 
 	return 16;
@@ -767,7 +775,16 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 	 * (Note SAE/FILS were left out as they generate their own PMKID)
 	 */
 
-	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
+	if (s->akm_suite & IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384) {
+		sha = L_CHECKSUM_SHA384;
+		/*
+		 * According to 12.7.1.6.3 the key length should be:
+		 * "the first 384 bits of the MSK". Unfortunately hostapd uses
+		 * the PMK length directly which can vary depending on the EAP
+		 * method...
+		 */
+		key_len = s->pmk_len;
+	} else if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
 			IE_RSN_AKM_SUITE_PSK_SHA256 |
 			IE_RSN_AKM_SUITE_FT_OVER_8021X |
 			IE_RSN_AKM_SUITE_FT_USING_PSK))
-- 
2.25.1

