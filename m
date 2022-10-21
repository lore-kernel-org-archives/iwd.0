Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5243D60
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:31 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id a14-20020a9d470e000000b00661b66a5393so2363807otf.11
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Ibed61Ib+SV6Yaz0OB1rjHTNi5wIEaKelOVBT1S9w=;
        b=dxEFQd4KQwak+moi6CR1OK81wCYxr3ig0ZbihaBHfbbXmXkbGReMUA1UBzRjNx7vSq
         TLXNQgy3Lbp77Y4QwAAXUw4yn2dE/0C4FvVG1RCAYT8Vk5g7PLOWE61oQuLCcf3cHv6C
         LgFV+yRy7teS+wCuch47R7Wx8KH+xQjXSwYxxjSe1SsKFDejtNcya7NlmJD/ru5FLROx
         QcAA8HvNMfSp38Fyl66biUDBPmxH6pPvE0GrTF5xIXjvIk9YhZnusiA4T3W+XpBuFFho
         wN8T76vZOyVijhkqM5cMkF5PCNcst0z8i6vChK4RFzDoRVUPKs1u1siWidI+Ogulee3s
         r9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2Ibed61Ib+SV6Yaz0OB1rjHTNi5wIEaKelOVBT1S9w=;
        b=SNP26GO9YehQLMFOHinM9oockvFXS/OFfDfM6hLsuXlyYRLJqhvim2+66o3pvGNSJ2
         Ncs+H9dNITLCv3DH/diK++4Xrlylszst8VOaFqJZ9TUr62ySGrDsqhGc4yNDQgpNYSui
         Oz404wq9WXRkCQ9i+WeNVfTJ5MlBExfuu6knTqW8JzkRY6kHMzEmR82rZ6LC03rnJ2Jr
         nLLnXVfC/v8lIp7FkuxHWf2pa0aRe0x2QtRHLkbNzA+lcQRaxKlu6Hh7JnXv0VjQVd5F
         cU6sGQpJLjDIlAihZ0uixtVWwWLY/WrdKoU6Y8mMd8vQUNLyxJkJggUctI434WN/zUxQ
         amMQ==
X-Gm-Message-State: ACrzQf3JPWhMtjJzM1Rs77G5vI4KVke+tGT5eze2p8gnccgGgaOqK2bo
	gk0/3+7OwQVZrQA5P8lwrbdwVE7BbDQ=
X-Google-Smtp-Source: AMsMyM6Pn3UOkfDSdv5hqwPYrCL011lgj+TcBjTPgiWX/Vah/H16G0e+yw3eBBuAPtMveYvGzFne4Q==
X-Received: by 2002:a05:6830:3703:b0:65f:c2ff:c526 with SMTP id bl3-20020a056830370300b0065fc2ffc526mr10528199otb.302.1666379610301;
        Fri, 21 Oct 2022 12:13:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:29 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/26] ie: Rename _BIP to _BIP_CMAC
Date: Fri, 21 Oct 2022 14:12:44 -0500
Message-Id: <20221021191307.31492-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/ie.c       | 15 ++++++++-------
 src/ie.h       |  2 +-
 src/wiphy.c    | 13 +++++++------
 unit/test-ie.c |  2 +-
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 245b59c91ad3..7159222a4f6c 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -428,7 +428,7 @@ uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite)
 		return CRYPTO_CIPHER_WEP40;
 	case IE_RSN_CIPHER_SUITE_WEP104:
 		return CRYPTO_CIPHER_WEP104;
-	case IE_RSN_CIPHER_SUITE_BIP:
+	case IE_RSN_CIPHER_SUITE_BIP_CMAC:
 		return CRYPTO_CIPHER_BIP_CMAC;
 	default:
 		return 0;
@@ -462,7 +462,7 @@ static bool ie_parse_cipher_suite(const uint8_t *data,
 			*out = IE_RSN_CIPHER_SUITE_WEP104;
 			return true;
 		case 6:
-			*out = IE_RSN_CIPHER_SUITE_BIP;
+			*out = IE_RSN_CIPHER_SUITE_BIP_CMAC;
 			return true;
 		case 7:
 			*out = IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC;
@@ -625,7 +625,7 @@ static bool ie_parse_group_management_cipher(const uint8_t *data,
 		return r;
 
 	switch (tmp) {
-	case IE_RSN_CIPHER_SUITE_BIP:
+	case IE_RSN_CIPHER_SUITE_BIP_CMAC:
 	case IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC:
 		break;
 	default:
@@ -746,7 +746,8 @@ static int parse_ciphers(const uint8_t *data, size_t len,
 	 * management frame protection enabled
 	 */
 	if (out_info->mfpc)
-		out_info->group_management_cipher = IE_RSN_CIPHER_SUITE_BIP;
+		out_info->group_management_cipher =
+						IE_RSN_CIPHER_SUITE_BIP_CMAC;
 
 	RSNE_ADVANCE(data, len, 2);
 
@@ -905,7 +906,7 @@ static bool ie_build_cipher_suite(uint8_t *data, const uint8_t *oui,
 		memcpy(data, oui, 3);
 		data[3] = 5;
 		return true;
-	case IE_RSN_CIPHER_SUITE_BIP:
+	case IE_RSN_CIPHER_SUITE_BIP_CMAC:
 		memcpy(data, oui, 3);
 		data[3] = 6;
 		return true;
@@ -1115,7 +1116,7 @@ static int build_ciphers_common(const struct ie_rsn_info *info, uint8_t *to,
 		else if (!info->mfpc)
 			goto done;
 		else if (info->group_management_cipher ==
-				IE_RSN_CIPHER_SUITE_BIP)
+				IE_RSN_CIPHER_SUITE_BIP_CMAC)
 			goto done;
 	}
 
@@ -1136,7 +1137,7 @@ static int build_ciphers_common(const struct ie_rsn_info *info, uint8_t *to,
 		goto done;
 
 	if (!force_group_mgmt_cipher && info->group_management_cipher ==
-							IE_RSN_CIPHER_SUITE_BIP)
+					IE_RSN_CIPHER_SUITE_BIP_CMAC)
 		goto done;
 
 	/* Group Management Cipher Suite */
diff --git a/src/ie.h b/src/ie.h
index e56df984e53c..e7ffaa63f74d 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -329,7 +329,7 @@ enum ie_rsn_cipher_suite {
 	IE_RSN_CIPHER_SUITE_TKIP		= 0x0004,
 	IE_RSN_CIPHER_SUITE_CCMP		= 0x0008,
 	IE_RSN_CIPHER_SUITE_WEP104		= 0x0010,
-	IE_RSN_CIPHER_SUITE_BIP			= 0x0020,
+	IE_RSN_CIPHER_SUITE_BIP_CMAC		= 0x0020,
 	IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC	= 0x0040,
 };
 
diff --git a/src/wiphy.c b/src/wiphy.c
index 1283bede923e..3e08047910e1 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -157,8 +157,8 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wiphy *wiphy, uint16_t mask)
 	if (mask & IE_RSN_CIPHER_SUITE_TKIP)
 		return IE_RSN_CIPHER_SUITE_TKIP;
 
-	if (mask & IE_RSN_CIPHER_SUITE_BIP)
-		return IE_RSN_CIPHER_SUITE_BIP;
+	if (mask & IE_RSN_CIPHER_SUITE_BIP_CMAC)
+		return IE_RSN_CIPHER_SUITE_BIP_CMAC;
 
 	return 0;
 }
@@ -178,7 +178,7 @@ static bool wiphy_can_connect_sae(struct wiphy *wiphy)
 	 * WPA3 Specification version 3, Section 2.3:
 	 * A STA shall negotiate PMF when associating to an AP using SAE
 	 */
-	if (!(wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_BIP)) {
+	if (!(wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_BIP_CMAC)) {
 		l_debug("HW not MFP capable, can't use SAE");
 		return false;
 	}
@@ -488,7 +488,7 @@ bool wiphy_can_transition_disable(struct wiphy *wiphy)
 	if (!(wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_CCMP))
 		return false;
 
-	if (!(wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_BIP))
+	if (!(wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_BIP_CMAC))
 		return false;
 
 	return true;
@@ -1145,7 +1145,7 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 		if (wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_TKIP)
 			len += sprintf(buf + len, " TKIP");
 
-		if (wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_BIP)
+		if (wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_BIP_CMAC)
 			len += sprintf(buf + len, " BIP");
 
 		l_info("%s", buf);
@@ -1216,7 +1216,8 @@ static void parse_supported_ciphers(struct wiphy *wiphy, const void *data,
 			wiphy->supported_ciphers |= IE_RSN_CIPHER_SUITE_WEP104;
 			break;
 		case CRYPTO_CIPHER_BIP_CMAC:
-			wiphy->supported_ciphers |= IE_RSN_CIPHER_SUITE_BIP;
+			wiphy->supported_ciphers |=
+				IE_RSN_CIPHER_SUITE_BIP_CMAC;
 			break;
 		default:	/* TODO: Support other ciphers */
 			break;
diff --git a/unit/test-ie.c b/unit/test-ie.c
index 709b745428b9..7ea84c387121 100644
--- a/unit/test-ie.c
+++ b/unit/test-ie.c
@@ -423,7 +423,7 @@ static const struct ie_rsne_info_test ie_rsne_info_test_6 = {
 	.pairwise_ciphers = IE_RSN_CIPHER_SUITE_CCMP,
 	.akm_suites = IE_RSN_AKM_SUITE_8021X,
 	.mfpc = true, /* Management frame protection is enabled, not required */
-	.group_management_cipher = IE_RSN_CIPHER_SUITE_BIP,
+	.group_management_cipher = IE_RSN_CIPHER_SUITE_BIP_CMAC,
 };
 
 static void ie_test_rsne_info(const void *data)
-- 
2.35.1

