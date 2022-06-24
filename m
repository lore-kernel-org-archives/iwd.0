Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC34A02
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:10:00 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id 184so3660512pga.12
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCkwC2D0RD4oXZXaVih5oSm/+99d3lakST5G0fiiLKM=;
        b=EmT9NJSOAp3rzRQVOaqUsa0ay+4nmuozTAirCbdl0XjYMtSRo+0gCXuAdAIA7yPi6h
         VONpaaXk0DEZjKifZSYrKrtbwlgEGNBySCg0Ae+tq5CkM8FF213QtUtpNtCjSxnkwOlB
         hHWq0KL9qGVxmoz4ba2q7JMijmCwjjfIBSCZ7U+px2hsqUM0/Ezi40EdvSArWYtlrdTG
         lHxTuvx0AXb+Psp5OnELugkuq3HXxGxrJgj8gDyQ6XKJfMBXgQ72JPNxiKkfU+tgSV8j
         ZxfKm3sukxGIyBDVjNho53CQDw7ycCc1pyPorYQ20Q1dPj/a7QZPfKUuoogt6lqb0Xk5
         wBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCkwC2D0RD4oXZXaVih5oSm/+99d3lakST5G0fiiLKM=;
        b=B0QjbAAxTLYClbqZ6oAHXXz6eLCBfxSD9xK58YK41KRzX4Z9e9kFztwaJqPwdvqJkE
         dDzUjMEVPeX0tz7rlFQ3VKORorrmUMdoTYn1ZclpSmcQkO6Y5X/qpxCXxFGTs7RzTs78
         9o8jCYFsvWa4nbubydOnuBSctED+qqspd1sBPz5rgr8uv5E2id0gVkEIXMSIuQhv516o
         9VTJEFiI/OHnZNTTCul7/mnk+iTCkNw0X/7rNfzUSp2uv6uH13tnQ2VRvQCPP7P4EKlv
         UW2Q2gslNx1TC4e+iw9rXRj0ElAG+ARXEg78gJxTIMBBDwleNJF/mpz5LQ3mPRjwoSXR
         BaWQ==
X-Gm-Message-State: AJIora+GYT+ffF57dqzp1mvOIGOuY5tRtQDq3yzDKGTew/5ycCdkF1Rm
	6PQK0LmMbq99+KEiWFu01j1Twj0rzzM=
X-Google-Smtp-Source: AGRyM1vPOIEuxkvYpxbp+UAwbSwu2Y5K3j/JizgXz7i1d/DW1D/4o9P6Jrs/XPgQKSEDqyqCAKU1vw==
X-Received: by 2002:a63:d50f:0:b0:408:994a:96d5 with SMTP id c15-20020a63d50f000000b00408994a96d5mr1074841pgg.299.1656112200018;
        Fri, 24 Jun 2022 16:10:00 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm4449767pjo.12.2022.06.24.16.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:09:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] unit: update test-eapol to use the new ptk verify APIs
Date: Fri, 24 Jun 2022 16:07:41 -0700
Message-Id: <20220624230741.1957863-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624230741.1957863-1-prestwoj@gmail.com>
References: <20220624230741.1957863-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-eapol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index d3cfac11..227e485f 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -1768,13 +1768,13 @@ static void eapol_4way_test(const void *data)
 	step1 = eapol_key_validate(eapol_key_data_3,
 					sizeof(eapol_key_data_3), 16);
 	assert(step1);
-	assert(eapol_verify_ptk_1_of_4(step1, 16));
+	assert(eapol_verify_ptk_1_of_4(step1, 16, false));
 	memcpy(anonce, step1->key_nonce, sizeof(step1->key_nonce));
 
 	step2 = eapol_key_validate(eapol_key_data_4,
 					sizeof(eapol_key_data_4), 16);
 	assert(step2);
-	assert(eapol_verify_ptk_2_of_4(step2));
+	assert(eapol_verify_ptk_2_of_4(step2, false));
 	memcpy(snonce, step2->key_nonce, sizeof(step2->key_nonce));
 
 	assert(!crypto_psk_from_passphrase(passphrase, (uint8_t *) ssid,
@@ -1853,13 +1853,13 @@ static void eapol_wpa2_handshake_test(const void *data)
 	ptk_step1 = eapol_key_validate(eapol_key_data_7,
 					sizeof(eapol_key_data_7), 16);
 	assert(ptk_step1);
-	assert(eapol_verify_ptk_1_of_4(ptk_step1, 16));
+	assert(eapol_verify_ptk_1_of_4(ptk_step1, 16, false));
 	memcpy(anonce, ptk_step1->key_nonce, sizeof(ptk_step1->key_nonce));
 
 	ptk_step2 = eapol_key_validate(eapol_key_data_8,
 					sizeof(eapol_key_data_8), 16);
 	assert(ptk_step2);
-	assert(eapol_verify_ptk_2_of_4(ptk_step2));
+	assert(eapol_verify_ptk_2_of_4(ptk_step2, false));
 	memcpy(snonce, ptk_step2->key_nonce, sizeof(ptk_step2->key_nonce));
 
 	assert(!crypto_psk_from_passphrase(passphrase, (uint8_t *) ssid,
@@ -1983,13 +1983,13 @@ static void eapol_wpa_handshake_test(const void *data)
 	ptk_step1 = eapol_key_validate(eapol_key_data_13,
 					sizeof(eapol_key_data_13), 16);
 	assert(ptk_step1);
-	assert(eapol_verify_ptk_1_of_4(ptk_step1, 16));
+	assert(eapol_verify_ptk_1_of_4(ptk_step1, 16, false));
 	memcpy(anonce, ptk_step1->key_nonce, sizeof(ptk_step1->key_nonce));
 
 	ptk_step2 = eapol_key_validate(eapol_key_data_14,
 					sizeof(eapol_key_data_14), 16);
 	assert(ptk_step2);
-	assert(eapol_verify_ptk_2_of_4(ptk_step2));
+	assert(eapol_verify_ptk_2_of_4(ptk_step2, false));
 	memcpy(snonce, ptk_step2->key_nonce, sizeof(ptk_step2->key_nonce));
 
 	assert(!crypto_psk_from_passphrase(passphrase, (uint8_t *) ssid,
-- 
2.34.1

