Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F306135
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:55 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso2401869otb.2
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvxEGWfH3iv4jxzU7pvZIEePTFMoZC0TyDgj4eDVwoY=;
        b=DuWB//0GHEwZIJcvLCjAAaFoldYHCpS/r/UTj/PJ79mdkfnDSM8SCJOSqH5BkhWu8R
         j79D8FmccJED66F5wS9xxhPNKbZOrA3PH/AwvQi2Bt1287bDuLC53cxcjQxwqNB5E7D/
         J8K9z0MBKOpBXy3UdXF7EqpTknZjl79NAyGdFPZHYH0ajweBVCHzFQyGQlaExRZ3yseI
         +jtmSx3LOUG7uD4gIjAV+iVelNUJFRD0nr+m6Ft0yRohWvm57rdhAc0gmJZbALmp2wX+
         rrBLRcge+Q26wAW5pu9cvmY/KNK4G7/AsHlw4X8KF1SMg88eBCWGhiWdgrXqNX8wAKUD
         hP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvxEGWfH3iv4jxzU7pvZIEePTFMoZC0TyDgj4eDVwoY=;
        b=dbwm+gOXn4eMMoVEc46bd9b8krhkjzXbBcVTasO/yI/WFcodYYd5xyjnH7resI3oN+
         VBsnrtBopTW/Rf4e7ReM3vTrswQjR7sWD8K1icnd+kUlvtb1o2570G4YD84mw1ElBbc5
         n04AVYrm84ohE+Kv51KSscayUwZNgm0IV0ErwYB+Jb7+DsT38JSHV2ttaCW0Hofc1wVc
         SZn2ZsQXE/CPRfrXShGIAlKHZOe/+AUT/iJDf5FhYGsrUDfp0133ZsORa9BVMtZzkNkN
         cDE8GMZs6l9/UNtdDmN34Agjq5KN7chkpRL85yMMteBbfkEYA4W90kUfBhulWMfzd3+a
         eD6A==
X-Gm-Message-State: ACrzQf2wesiav5OzmKcnc7Taxgg9QXbIp6fpgByKnm81KRRzINoQsNth
	py/MIYSR9zNdPJEnNVPFop22AKQ5H48=
X-Google-Smtp-Source: AMsMyM7k4P/pG8MaU5gvTdYPzob4TtOZcTSkHhQn/22yZlk5Xs8PMVBRDn0OgLib+N8ZmZ0hPrwzXw==
X-Received: by 2002:a9d:3e59:0:b0:661:c029:d7bb with SMTP id h25-20020a9d3e59000000b00661c029d7bbmr10677835otg.112.1666379634420;
        Fri, 21 Oct 2022 12:13:54 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:53 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 17/26] netdev: Add support for CCMP|GCMP-256
Date: Fri, 21 Oct 2022 14:12:58 -0500
Message-Id: <20221021191307.31492-17-denkenz@gmail.com>
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

These are similar to CCMP/GCMP, just a different key size which is
already taken care of by calling crypto_cipher_key_len
---
 src/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 4ca230e42b1f..7b8948604347 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1565,6 +1565,8 @@ static bool netdev_copy_tk(uint8_t *tk_buf, const uint8_t *tk,
 	switch (cipher) {
 	case CRYPTO_CIPHER_CCMP:
 	case CRYPTO_CIPHER_GCMP:
+	case CRYPTO_CIPHER_GCMP_256:
+	case CRYPTO_CIPHER_CCMP_256:
 		/*
 		 * 802.11-2020 12.8.3 Mapping PTK to CCMP keys:
 		 * "A STA shall use the temporal key as the CCMP key
-- 
2.35.1

