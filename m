Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A815CF
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0yrRz+1"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58d521f12ebso1008934eaf.2
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 18:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701053649; x=1701658449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOTUEgUpIUa3xSXsm+qBrM9i2hQEQ7mS1G0rrydGMY4=;
        b=F0yrRz+1f7L4PJQrehhHhiKRssHNimVgO3/wMYvyU12gsALE7tyG/QRkiQYmQNg1iI
         8RSr+YLd8ITU52gx9kQpQFmTNWMD2TzcziQ4Yxy2zwaUVOb15kwSeyH6dZ4GJrT7oy6v
         EZS6gGFbwYOZSw12L3myX8+GtgpEy+IAHWZyBkZh4UFFn6iKp956PDA2XS2mzsLyIJBM
         TCwJn/+PT6okZo3hFtYUZKZNDJR6bRaAWyeQ/GeBE/aa23QkkX+FEOQvD/P4xAtshJ1Y
         CVTX/auKXM6Ifx7r2TCB2hijVXoP+qMBf5T8pZcRNg4n8TOowt3O2/czaCl3fEoFFHlT
         BU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701053649; x=1701658449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOTUEgUpIUa3xSXsm+qBrM9i2hQEQ7mS1G0rrydGMY4=;
        b=XqxVR5z8Q0b4O+eD8+P2DxVAI9qAarFigcQR0/vB0sgdYchQ/ANBbsYN7pG4AD6Gwr
         3iXgkWrl482WrS7BQXSQbKt6C67F7m7NqAA4hCTSEJdbUx4NVCd0Wgg7dUaj6I0a3p4q
         Hm9dDklsDVaiL8E8RXzrqfvhO24cblPkWAGqARjltbnB/IbS3WSf4PIACU7krMVFeMH4
         U7hQw6JV57tahO78tX6E3LH8SYcEHlyjxyb+S0y2F9noO2D3rdJJMIozgyapr6nWB0/v
         vrfCRjxgBl94b2yXR1j3cdspPpZcqCyKEdDcBFs/gtgd8wRYrVOGty3TYCFQg0FjR6/s
         AVJQ==
X-Gm-Message-State: AOJu0Yyk+BEe/TrgV0DFnKFoQSD8bXmkx9DseAoz5eoCj18uBxQZNq1P
	isaTD0DWOFqARYUpMWXSRqoFAvi8axc=
X-Google-Smtp-Source: AGHT+IHNv/fIrTOWAjGLopKRsXz8VDR3vMYM/ldF87q8I2gOwH0jBd4oTZ12UjTa2tMuhrMLERJKQg==
X-Received: by 2002:a05:6871:438b:b0:1f9:9980:93bb with SMTP id lv11-20020a056871438b00b001f9998093bbmr14574146oab.52.1701053648655;
        Sun, 26 Nov 2023 18:54:08 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id ti3-20020a056871890300b001f9e3731545sm1818846oab.11.2023.11.26.18.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 18:54:08 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/6] ie: Move AKM suite converter from netdev
Date: Sun, 26 Nov 2023 20:52:58 -0600
Message-ID: <20231127025320.1310543-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more logical to host this function inside ie.c than netdev.c.
Particularly since ie_rsn_cipher_suite_to_cipher is already present in
ie.c.
---
 src/ie.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/ie.h     |  2 ++
 src/netdev.c | 47 +----------------------------------------------
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 6b08ce180a87..a51724aa74c8 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -481,6 +481,52 @@ const char *ie_rsn_cipher_suite_to_string(enum ie_rsn_cipher_suite suite)
 	return NULL;
 }
 
+uint32_t ie_rsn_akm_suite_to_akm(enum ie_rsn_akm_suite akm)
+{
+	switch (akm) {
+	case IE_RSN_AKM_SUITE_8021X:
+		return CRYPTO_AKM_8021X;
+	case IE_RSN_AKM_SUITE_PSK:
+		return CRYPTO_AKM_PSK;
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
+		return CRYPTO_AKM_FT_OVER_8021X;
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+		return CRYPTO_AKM_FT_USING_PSK;
+	case IE_RSN_AKM_SUITE_8021X_SHA256:
+		return CRYPTO_AKM_8021X_SHA256;
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		return CRYPTO_AKM_PSK_SHA256;
+	case IE_RSN_AKM_SUITE_TDLS:
+		return CRYPTO_AKM_TDLS;
+	case IE_RSN_AKM_SUITE_SAE_SHA256:
+		return CRYPTO_AKM_SAE_SHA256;
+	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+		return CRYPTO_AKM_FT_OVER_SAE_SHA256;
+	case IE_RSN_AKM_SUITE_AP_PEER_KEY_SHA256:
+		return CRYPTO_AKM_AP_PEER_KEY_SHA256;
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
+		return CRYPTO_AKM_8021X_SUITE_B_SHA256;
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
+		return CRYPTO_AKM_8021X_SUITE_B_SHA384;
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+		return CRYPTO_AKM_FT_OVER_8021X_SHA384;
+	case IE_RSN_AKM_SUITE_FILS_SHA256:
+		return CRYPTO_AKM_FILS_SHA256;
+	case IE_RSN_AKM_SUITE_FILS_SHA384:
+		return CRYPTO_AKM_FILS_SHA384;
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+		return CRYPTO_AKM_FT_OVER_FILS_SHA256;
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+		return CRYPTO_AKM_FT_OVER_FILS_SHA384;
+	case IE_RSN_AKM_SUITE_OWE:
+		return CRYPTO_AKM_OWE;
+	case IE_RSN_AKM_SUITE_OSEN:
+		return CRYPTO_AKM_OSEN;
+	}
+
+	return 0;
+}
+
 /* 802.11, Section 8.4.2.27.2 */
 static bool ie_parse_cipher_suite(const uint8_t *data,
 					enum ie_rsn_cipher_suite *out)
diff --git a/src/ie.h b/src/ie.h
index c9a6c78324d6..9ada64bf3bd7 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -621,6 +621,8 @@ unsigned char *ie_tlv_builder_finalize(struct ie_tlv_builder *builder,
 uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite);
 const char *ie_rsn_cipher_suite_to_string(enum ie_rsn_cipher_suite suite);
 
+uint32_t ie_rsn_akm_suite_to_akm(enum ie_rsn_akm_suite akm);
+
 int ie_parse_rsne(struct ie_tlv_iter *iter, struct ie_rsn_info *info);
 int ie_parse_rsne_from_data(const uint8_t *data, size_t len,
 				struct ie_rsn_info *info);
diff --git a/src/netdev.c b/src/netdev.c
index f23ca59ea1cb..7b951a6a4797 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2445,51 +2445,6 @@ static void netdev_driver_connected(struct netdev *netdev)
 		eapol_register(netdev->sm);
 }
 
-static unsigned int ie_rsn_akm_suite_to_nl80211(enum ie_rsn_akm_suite akm)
-{
-	switch (akm) {
-	case IE_RSN_AKM_SUITE_8021X:
-		return CRYPTO_AKM_8021X;
-	case IE_RSN_AKM_SUITE_PSK:
-		return CRYPTO_AKM_PSK;
-	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
-		return CRYPTO_AKM_FT_OVER_8021X;
-	case IE_RSN_AKM_SUITE_FT_USING_PSK:
-		return CRYPTO_AKM_FT_USING_PSK;
-	case IE_RSN_AKM_SUITE_8021X_SHA256:
-		return CRYPTO_AKM_8021X_SHA256;
-	case IE_RSN_AKM_SUITE_PSK_SHA256:
-		return CRYPTO_AKM_PSK_SHA256;
-	case IE_RSN_AKM_SUITE_TDLS:
-		return CRYPTO_AKM_TDLS;
-	case IE_RSN_AKM_SUITE_SAE_SHA256:
-		return CRYPTO_AKM_SAE_SHA256;
-	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
-		return CRYPTO_AKM_FT_OVER_SAE_SHA256;
-	case IE_RSN_AKM_SUITE_AP_PEER_KEY_SHA256:
-		return CRYPTO_AKM_AP_PEER_KEY_SHA256;
-	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
-		return CRYPTO_AKM_8021X_SUITE_B_SHA256;
-	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
-		return CRYPTO_AKM_8021X_SUITE_B_SHA384;
-	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
-		return CRYPTO_AKM_FT_OVER_8021X_SHA384;
-	case IE_RSN_AKM_SUITE_FILS_SHA256:
-		return CRYPTO_AKM_FILS_SHA256;
-	case IE_RSN_AKM_SUITE_FILS_SHA384:
-		return CRYPTO_AKM_FILS_SHA384;
-	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
-		return CRYPTO_AKM_FT_OVER_FILS_SHA256;
-	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
-		return CRYPTO_AKM_FT_OVER_FILS_SHA384;
-	case IE_RSN_AKM_SUITE_OWE:
-		return CRYPTO_AKM_OWE;
-	case IE_RSN_AKM_SUITE_OSEN:
-		return CRYPTO_AKM_OSEN;
-	}
-
-	return 0;
-}
 
 static void netdev_append_nl80211_rsn_attributes(struct l_genl_msg *msg,
 						struct handshake_state *hs)
@@ -2514,7 +2469,7 @@ static void netdev_append_nl80211_rsn_attributes(struct l_genl_msg *msg,
 		l_genl_msg_append_attr(msg, NL80211_ATTR_USE_MFP, 4, &use_mfp);
 	}
 
-	nl_akm = ie_rsn_akm_suite_to_nl80211(hs->akm_suite);
+	nl_akm = ie_rsn_akm_suite_to_akm(hs->akm_suite);
 	L_WARN_ON(!nl_akm);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES, 4, &nl_akm);
 
-- 
2.42.0

