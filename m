Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66462BA3E
	for <iwd@lists.linux.dev>; Tue,  4 Apr 2023 15:56:59 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id l7so30999460pjg.5
        for <iwd@lists.linux.dev>; Tue, 04 Apr 2023 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680623818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouhW2BhYlI+rTVfRH/Goz/mEBAwSLbKpF8cy0RReObk=;
        b=bdvIpV6LtCLnBoOPsMejzQB21gv5coAszqlGYvlqgjYdXLjV4MsRg/sfAuHxQnpYbW
         1BnMWy09BOhwkSqiWZ47NA2TkGS3fxgkuRwK0Ge2xlFM7wAhlimmMovjZ2O4Hk4Fj3jb
         N9YBZEvpIVEeqABEZUAFPzCLrB7lT+GteoB4rgFba1Cot55Zs1E2wbouJ9jMYqUwWE+j
         rtcqGGAXIK2l4+EcZCjZ8UMbj/54CYm3b0v1dzyMlNXYadXSRhKAxvxofxPOIE/e4iUM
         TO24H7lcchqCNfuISh75RrC3zhfHqr6W6JsmzaOoLI9chiPWNdbtM4Yjt4ZdHVj37XFe
         wpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680623818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouhW2BhYlI+rTVfRH/Goz/mEBAwSLbKpF8cy0RReObk=;
        b=Mapul+5SokcK8bLma3c0tVADxUSxncRRIouRoejtsISMXwg9aDQmn/WDkFrCkrNjST
         rgJK3ivzH+yy5aiNQpYmNIZI79sQnVNWbSjc4OXZIbgbOa2tVdhBODh3qoEC+FbS2R24
         OJ9f+GZ8yKLrCCur5J5J5VfwUjzuojC3CQuBN3Vzq2GkGU5c6rOI8Gy8LPI2F8ZmcjYX
         CTRWP+J3rM7CaPWBt6P59GkE+pbBRxHY27O4PTT2fsT+GAZhTVlB4wnRPYUvW1rL0WXZ
         QJKxCqrEVNoZh40RYMpJMiapHB+bwBEVMJff/T58ik7QKsIhpA+XPzZUGV+MosQ+7qnJ
         NYtg==
X-Gm-Message-State: AAQBX9d45VTC+gjMLoSZFMp2KzxPvxgVY1gTKuAnJM7SW1MbKPE2TK5I
	1GoDNcQ7bVdszkE6u8ns5g43fjPs8QK1AQ==
X-Google-Smtp-Source: AKy350YdnNVPTQoguwfRvdZ0whju0WUDFEIpdnK9cl9kBTQcN1OdwhjzT7UF8zAx8bsCjp1JHT8CbQ==
X-Received: by 2002:a05:6a20:c523:b0:db:4c00:7918 with SMTP id gm35-20020a056a20c52300b000db4c007918mr2421675pzb.0.1680623818575;
        Tue, 04 Apr 2023 08:56:58 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b0062ddfce5cdbsm8785857pfo.45.2023.04.04.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:56:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Alagu Sankar <alagusankar@gmail.com>
Subject: [PATCH] band: fix HT40+/- checks when creating chandef
Date: Tue,  4 Apr 2023 08:56:40 -0700
Message-Id: <20230404155640.133794-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HT40+/- flags were reversed when checking against the 802.11
behavior flags.

HT40+ means the secondary channel is above (+) the primary channel
therefore corresponds to the PRIMARY_CHANNEL_LOWER behavior. And
the opposite for HT40-.

Reported-By: Alagu Sankar <alagusankar@gmail.com>
---
 src/band.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/band.c b/src/band.c
index 27b4d174..486df6e1 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1229,11 +1229,11 @@ int band_freq_to_ht_chandef(uint32_t freq, const struct band_freq_attrs *attr,
 			if (band == BAND_FREQ_6_GHZ)
 				break;
 
-			if (info->flags & PRIMARY_CHANNEL_UPPER &&
+			if (info->flags & PRIMARY_CHANNEL_LOWER &&
 						attr->no_ht40_plus)
 				continue;
 
-			if (info->flags & PRIMARY_CHANNEL_LOWER &&
+			if (info->flags & PRIMARY_CHANNEL_UPPER &&
 						attr->no_ht40_minus)
 				continue;
 
-- 
2.25.1

