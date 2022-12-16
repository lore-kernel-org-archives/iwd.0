Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2D259D
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 17:26:21 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id n4so2999165plp.1
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 09:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+UuGXs7Kl6zzo4tjOaDH/TtKM7ac5Puc+p1Vnfy258=;
        b=Y3RBtprFEWamEoj2dOJ2kWPB5kFN6LSoe+OrJzUw2PKgpDx3VaGPnP5bbvCGMJ1SWJ
         r8q5XHseQjXY+F3bf2VkWwhvYXka9tkFCb2OjjQUb6nNCXFKV6ZLnEs2pxeOOHsQPixL
         Kp/dJ0+B9NYm1xCOhf1QcNAE9LxPcx+k8OLFKT+cn2jVGjXVeCK5WNU+wdnlVgyf4DCp
         n3HPYQwSo4tar9et7iKt/wb8DrMG8wwBAbydrpm08H+zQpJITNtPk/J6jVGluPfRQjUa
         1C5T+68IAzW/5qIReipsx3aVN1x4fVUQkKpcBrxAMVxPmNuy7de3IKWLYzoYpniuZUVf
         6NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+UuGXs7Kl6zzo4tjOaDH/TtKM7ac5Puc+p1Vnfy258=;
        b=o/9d5w4C4dAsTlI60sR8TtK4LLEZfshTBvkvzHoQc2IsuHj63IdTkUbSDrANUDhnq3
         TkV1BzhiZE7auuqCZrHPQLdeFfnShEACFqRdkJlyDMtJ5JnHdXm3nLwlE3JpEXBnaWXR
         OcsK3dBUqzTxBqNUI5w70CqIieh3suE2Zw9WQkv6n+C3UdlrUngY4oBK9u/zLoJNjYxv
         rItMv9+WdaEWlpNri715ygQbVtcfGga/CSICO5rPJk66Bm83nigF5AhhEGx17TsJFMXv
         22gI0d3ASB15656uz1Il7RkB1u+vXIBocnfuRg5/ufFJ2bTX2iL8nlBxeh/mfE0v1g/P
         Pk4w==
X-Gm-Message-State: ANoB5plJX8//jA0DPy/FGldTux8l/eCTt4GsXvEM3IcvRjqrBefoZggI
	+Gel+btpc8CxZH4ycAr2xi9Gx1RHLXs=
X-Google-Smtp-Source: AA0mqf5dW/xCi2MFQ3ZG19SphwA2nvsVr3ZNItbk4FOWxKAWweP52ZQnk+g80CZrMXDPK/U2w5FaWA==
X-Received: by 2002:a05:6a21:3a44:b0:9d:efbe:2082 with SMTP id zu4-20020a056a213a4400b0009defbe2082mr46307916pzb.56.1671211581094;
        Fri, 16 Dec 2022 09:26:21 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm1913636plx.44.2022.12.16.09.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:26:20 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/8] wiphy: remove pending_freqs from wiphy_regdom_is_updating
Date: Fri, 16 Dec 2022 09:26:01 -0800
Message-Id: <20221216172606.1799396-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216172606.1799396-1-prestwoj@gmail.com>
References: <20221216172606.1799396-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can determine this info based on the dump IDs.
---
 src/wiphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 6b8f00a1..3777bd58 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -979,7 +979,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 
 bool wiphy_regdom_is_updating(struct wiphy *wiphy)
 {
-	return wiphy->pending_freqs != NULL;
+	return wiphy->dump_id || (!wiphy->self_managed && wiphy_dump_id);
 }
 
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
-- 
2.34.3

