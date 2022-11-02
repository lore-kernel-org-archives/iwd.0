Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A02C9C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:36 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id k5so10040868pjo.5
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SgPJKR2WAcaoWEQeb3b2tErOAn7cQvPlu0P7SL7rgc=;
        b=PPnnhroOTHdNaZ/sevSENSAVgV9LazrSjfs55uszNWs1fzzdVQrEIp7Btrzf+9/Ice
         TsvvCvO/x9FsldOvmuBK/UP8Asi9HB6LenY/RlszMniVSyeIypnFJmtfrg38RFEXxfAZ
         FsTFT3dhmxg+nDBn61v+Wqi3QyEkgRtAT7RZG2vpcqLHpPEUsUXqH80g5d3NkDFezjnZ
         U5J3pFp+M/Y6H7jEeCjU9UaVHqr0MRBj79LHB3rDBvPqzmfIgOZK32s4+xIm4iVTkOyU
         QGpqffuN3LSlQO4AIF2NpXkcZjZw/pPMy6IW5veyveORgkw44wz3q2MULLLyRbrQO+lP
         Y2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SgPJKR2WAcaoWEQeb3b2tErOAn7cQvPlu0P7SL7rgc=;
        b=3jxkOGaLjb/6QK9sapCQpsc7FQN5fYmubqqwv7b5etR74nz1Zk4dyKvwNm5mb3+rsm
         cR+QYNbVhwNPJQv8A4M9KhVyS6/oYnG5EapEOx0ubyWi9yAzZ2di5G91AIW1ns6oE9KG
         k22rxN/A6hQwxDSHxPckJOmtTkiYibrmOWDzHiAzx/VZJ9KHR2nMDuXWYVhPgwH7izJP
         GZcknDfRjJSuJM/fD7+fIb1k+nl1bdZJxHLVMqw5XVoLFb1lH5UFU7WkFNPeF7LrKXs0
         yXqT3ANsd/gYshMvq8ZS2A+uykGjbVQnz0COKNNhcd5DVM9C5YK23uyVDq8FvR0bWydK
         /rsA==
X-Gm-Message-State: ACrzQf2VVAyzVNqEKDyTGXOUKr/g8VShnlOxq8nlmq1IWDGA6uRdTzKB
	hXE/4nHENb9bdOHRSot8j9LPy8Ybl5E=
X-Google-Smtp-Source: AMsMyM4ktphEsVGqiIW3LZKwV8m/FgXzGySyWcMEuGI2JqdGDFokih/WySYBAjeb+4neL8SI9ADz6Q==
X-Received: by 2002:a17:90b:3c8a:b0:213:e48a:3ac5 with SMTP id pv10-20020a17090b3c8a00b00213e48a3ac5mr18870392pjb.48.1667429495171;
        Wed, 02 Nov 2022 15:51:35 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 02/11] ie: add group/pairwise lists of supported ciphers
Date: Wed,  2 Nov 2022 15:51:07 -0700
Message-Id: <20221102225116.297129-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The validation of these ciphers for station is done when parsing
the BSS RSNE but for AP mode there is no such validation and
potentially any supported cipher could be chosen, even if its
incompatible for the type of key.
---
 src/ie.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/ie.h b/src/ie.h
index 53311854..c9a6c783 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -401,6 +401,25 @@ static inline bool IE_CIPHER_IS_GCMP_CCMP(uint32_t cipher_suite)
 				IE_RSN_CIPHER_SUITE_GCMP_256);
 }
 
+#define IE_GROUP_CIPHERS		\
+(					\
+	IE_RSN_CIPHER_SUITE_TKIP |	\
+	IE_RSN_CIPHER_SUITE_CCMP |	\
+	IE_RSN_CIPHER_SUITE_GCMP |	\
+	IE_RSN_CIPHER_SUITE_GCMP_256 |	\
+	IE_RSN_CIPHER_SUITE_CCMP_256	\
+)
+
+/*
+ * Since WEP is unsupported we can just use the group cipher list with
+ * "Use group cipher" appended
+ */
+#define IE_PAIRWISE_CIPHERS			\
+(						\
+	IE_GROUP_CIPHERS |			\
+	IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER	\
+)
+
 #define IE_LEN(ie) \
 	((ie) ? (ie)[1] + 2 : 0)
 
-- 
2.34.3

