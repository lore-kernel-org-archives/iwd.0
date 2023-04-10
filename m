Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C502F3F
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:44 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id la3so5720087plb.11
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHSUrASB8xUg930vAe2lW4BYfHfUwjeyNGwFHxh21Yk=;
        b=As+qyPQilk+9Pq+8bBxp9L1IX1hk5E54nkX5hFTFWc6YYTtV5rFj60JpxxmG/PuwGe
         vsPw31eTiNX8lh9me8cbVFs7mbbf3NBt+9p+Ka0hy3WqAAsLYS6g5DjGqIq31aXE8hq/
         Zw/LJsYZWjtQfyj4lMbgY7qEaTEzesCNP+QemS0wZkquh/9zS+nQhEq0CogJLb4ddhvO
         lDUhixRX1RVzdsTGslHUGxvGnMtQJ0eKFSYTzy8B+w4TLKOZyDzGDkZvhC8elqTdE1HJ
         7kHYYAfaV663z1+tGH8QRYEIbxEMv8JZ9o7gCEubOBzArXM1pH6+7M6z2NAuKEhFf0lH
         wXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHSUrASB8xUg930vAe2lW4BYfHfUwjeyNGwFHxh21Yk=;
        b=HzZHoLM2chM0yXeE/+EtZi0ANDUuypnmvudODxnDS55OJlE5ZTmh8Gu4XmHjwGO2MP
         A44KFmvoXXORTbJdMs1+yRST3cLA7dIdnAoAxBO42MlHi9aWWneCFacPkAYK091sJUi3
         44VGIQ/u0PsCIXFUDsn+v65thBbK4kLay35zcWQ1VG04DOmPHCxDKtvo3KH2YhKmGr1R
         8qwKfaq1BQF7LCJphtSZ678J/eNTG0HaDJ5JIPZVJen3ZGfR1oQS+VVm2Iy8sqejbftU
         9EPMl75CyrtEsV2A7pAkbV/5olWkVVKP1u+/c+pp9ok5l+JNdm0YsJS70i79eJl07CO8
         fYGw==
X-Gm-Message-State: AAQBX9fUNYxJ11uQE63zZ2+mOJ9h4EisVoxBehb8oOMuNx7Ns0iRGsRe
	O5x8QdvfvMfG5KNSAfgN85L6cBiJrcHEgw==
X-Google-Smtp-Source: AKy350Zl0Q5fcaGZORFcSJ3BB/N+PGZolw0N/x2ZXXWsvEaQjtlRIYCXw+Ser0D6108AaoivhktqRQ==
X-Received: by 2002:a17:902:ce85:b0:19e:874e:7275 with SMTP id f5-20020a170902ce8500b0019e874e7275mr17970457plg.23.1681164103445;
        Mon, 10 Apr 2023 15:01:43 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] eapol: add support for FT-8021X-SHA384
Date: Mon, 10 Apr 2023 15:01:30 -0700
Message-Id: <20230410220135.373872-5-prestwoj@gmail.com>
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

The SHA384 variant was not being checked for in any of the
MIC calculations/verifications or for EAPoL decryption.
---
 src/eapol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index 9e8f7c34..f290f40a 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -110,6 +110,9 @@ bool eapol_calculate_mic(enum ie_rsn_akm_suite akm, const uint8_t *kck,
 		case IE_RSN_AKM_SUITE_OSEN:
 			return cmac_aes(kck, 16, frame, frame_len,
 						mic, mic_len);
+		case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+			return hmac_sha384(kck, 24, frame, frame_len,
+						mic, mic_len);
 		case IE_RSN_AKM_SUITE_OWE:
 			switch (mic_len) {
 			case 16:
@@ -164,6 +167,10 @@ bool eapol_verify_mic(enum ie_rsn_akm_suite akm, const uint8_t *kck,
 		case IE_RSN_AKM_SUITE_OSEN:
 			checksum = l_checksum_new_cmac_aes(kck, 16);
 			break;
+		case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+			checksum = l_checksum_new_hmac(L_CHECKSUM_SHA384,
+							kck, 24);
+			break;
 		case IE_RSN_AKM_SUITE_OWE:
 			switch (mic_len) {
 			case 16:
@@ -270,6 +277,7 @@ uint8_t *eapol_decrypt_key_data(enum ie_rsn_akm_suite akm, const uint8_t *kek,
 		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
 		case IE_RSN_AKM_SUITE_OWE:
 		case IE_RSN_AKM_SUITE_OSEN:
+		case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
 			if (key_data_len < 24 || key_data_len % 8)
 				return NULL;
 
@@ -315,6 +323,7 @@ uint8_t *eapol_decrypt_key_data(enum ie_rsn_akm_suite akm, const uint8_t *kek,
 	case EAPOL_KEY_DESCRIPTOR_VERSION_AKM_DEFINED:
 		switch (akm) {
 		case IE_RSN_AKM_SUITE_OWE:
+		case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
 			switch (mic_len) {
 			case 16:
 				kek_len = 16;
-- 
2.25.1

