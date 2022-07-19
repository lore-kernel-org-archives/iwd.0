Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E75392
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:58:01 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id w185so14447915pfb.4
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//r93Qm4EDqxkYxB+yOq3hqVZ4W3qRJu2Fr2LmUnJU8=;
        b=RqIEaplDZaIPqtjSNjGG64Hl0e1OT+TGzesfcddCfkl2XZhAjKBxql7kjAT6UCeShX
         emdJwMaa8Vsu2obFo1Z3v2ZSdENhBXbNbpw5zRa3QkqKZ2WGT3RaSPRAhFGmRdzLDpqk
         yITxJiQ9amtReX9s19VCKnRN0ZwfU3dnfOARX5hWUi/WUqjkkX7j/jIO6NNOC4BnRAYq
         F1iLpvGSTKnTNihAc188Zb2bt7Ip3IGJ4r4GF3+OPDhEpEYy+34movo+nLRKyb6yaTmX
         gM5F3cAFqDb0aZgRKO5dejfj7lNaLLkILZnIWVJbtCvodZn/18KG/4Gp8AJTdctsCMMF
         P9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//r93Qm4EDqxkYxB+yOq3hqVZ4W3qRJu2Fr2LmUnJU8=;
        b=PWxjSbA+Bli6+rWx5vs4VLl9yGipW7l2FRaKsDAxlVSk8XOzYg2bsQHskQt+Hz2D94
         1cbUgLtbIrYztm8HjB8wQ4kyn2elsh/524pS0p4c7MCWFRMnRL+qM+8HH+J6FkEwPImM
         L7s9gdLvLMn3I7txr5U8xMdvvI8YQSejT7avdVK9qBNfN58/ymkg6i2pd29j1qR2+IyU
         DEq4+hCjYOv6lVH5wSJFvTu58xiVm2wBNYn7ECokN9s7H+IYDJ1kdCUVbzfiZqamYT0l
         kDW+0xyHqlgQuZ8y1ZFnIaTbfs8d7cjTQFekWV5WAFEO1WZnPxf3j4MsGt+3r+vLx/HS
         OdAQ==
X-Gm-Message-State: AJIora+thdvgjcjUbDyQCKQ3yvP2xFzJer30aJK1AZNf4G9/w7enfkN+
	GC/uBDtMeZjjBCWCSkkm25U/+HTg2P0=
X-Google-Smtp-Source: AGRyM1seqk+wHLr5+zWw/BZDQXbXsddcC/zXOATvSNJGll4fXuVS/1HN/hxYOFj92QG/4sRIluwpLg==
X-Received: by 2002:a63:2051:0:b0:412:6d61:ab0a with SMTP id r17-20020a632051000000b004126d61ab0amr31441165pgm.52.1658257080914;
        Tue, 19 Jul 2022 11:58:00 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:58:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/12] wiphy: use a 16 bit tag for extended IEs
Date: Tue, 19 Jul 2022 11:55:38 -0700
Message-Id: <20220719185544.456727-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an extended IE is needed a uint8_t tag would overflow.
---
 src/wiphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 22305d5d..d3cbe73d 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -811,7 +811,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	ie_tlv_iter_init(&iter, ies, ies_len);
 
 	while (ie_tlv_iter_next(&iter)) {
-		uint8_t tag = ie_tlv_iter_get_tag(&iter);
+		uint16_t tag = ie_tlv_iter_get_tag(&iter);
 
 		switch (tag) {
 		case IE_TYPE_SUPPORTED_RATES:
-- 
2.34.1

