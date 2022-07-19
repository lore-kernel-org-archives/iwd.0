Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D36004
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 23:41:35 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id y24so155396plh.7
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 16:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FV3ZpLus/RuN8M1hW2/B/wQfyRuD9KYav22lI7JUmSk=;
        b=ojmEYREk1pgUOWpsntwgOD0cwF4YRrM5zUmLTfWv4wJg3BkmjHtuoULEqvV1GQbepo
         p7X+Lf1UdA4kxPQuYi8nWQObr0Lo87vMKztPoIeG6hSrHesjx5lUYGqQOTGR1+s3hQN5
         agRCpMkTfvu3SLeT76RuGlPeqjaaQCJ5VtKl4PehwRu8orQXfNKTlefbVdo+fkOsYMIl
         0hkKoa9FfdemFnDxqqDpt2HndK21T1kzJInc1f8CW1NsYLNzd9eON8RL580DsvSGdk9w
         70LQq4i/6IlknGNAnSUhAPQ/ILCa9rj3NRy8eXb2t3DlVLDyF1TTvb2Mcsbmb6LAKl2f
         GtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FV3ZpLus/RuN8M1hW2/B/wQfyRuD9KYav22lI7JUmSk=;
        b=3hVy2y7viRCnL1IioHKo1KpXZ7SUNJdPk1S+KpEp5RZWb9PPmeLWLp2IHRwOqLLGlI
         ihjlt4aiByqjUC2B+AZH/DyV8JLB2XILvUDJIjFSKtowCND2KPxzL0vRcMun6/d+PgFb
         GXI4YpMrKdVfXUtC/uuIzMlRFuDBxelqEL/W9uIKgVChhhFfmZ11WIaTbfyWrE5iWUQl
         P2eXDPHZ2XbWBx3crokqaXcCST0YsK5dCc7MeTZZLbxC//Kt5Xtq3ylxjX3tnIrjxc9D
         hFbx73fV1J1FiUZkL7LL4ObZVXmcj2dW+3KTdgwWbWZG6drMXUOpiV2+Z00pv/WYD4uW
         WnZw==
X-Gm-Message-State: AJIora/Yn5AnjFIalTbf83uZ06ddw5ht/iH45C3RzUoxCX3T+7Gd/94c
	hkWh+jTeG8ww6nnHMk9ei4lBw/bB8BU=
X-Google-Smtp-Source: AGRyM1sCjsjFdSouD8Z9VO9rR47nQHCs0aubWe302WBtqmKm7NnCgPllYLE7exbL4wSuv2XGUByxgA==
X-Received: by 2002:a17:90b:1b0d:b0:1f0:2407:6b17 with SMTP id nu13-20020a17090b1b0d00b001f024076b17mr2032926pjb.214.1658274094515;
        Tue, 19 Jul 2022 16:41:34 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7842a000000b0050dc762816asm11988401pfn.68.2022.07.19.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:41:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] wiphy: use HE element for data rate estimation
Date: Tue, 19 Jul 2022 16:39:24 -0700
Message-Id: <20220719233924.559329-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719233924.559329-1-prestwoj@gmail.com>
References: <20220719233924.559329-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an HE element is found, prefer using this for the rate estimation
since it will likely yield the fastest rate.
---
 src/wiphy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

v2:
 * Increased length check by 2 which includes the first MCS set.

diff --git a/src/wiphy.c b/src/wiphy.c
index 696064c0..9bcbea77 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -788,6 +788,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	const void *vht_operation = NULL;
 	const void *ht_capabilities = NULL;
 	const void *ht_operation = NULL;
+	const void *he_capabilities = NULL;
 	const struct band *bandp;
 	enum band_freq band;
 
@@ -847,11 +848,22 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 
 			vht_operation = iter.data - 2;
 			break;
+		case IE_TYPE_HE_CAPABILITIES:
+			if (iter.len < 23)
+				return -EBADMSG;
+
+			he_capabilities = iter.data - 2;
+			break;
 		default:
 			break;
 		}
 	}
 
+	if (!band_estimate_he_rx_rate(bandp, he_capabilities,
+					bss->signal_strength / 100,
+					out_data_rate))
+		return 0;
+
 	if (!band_estimate_vht_rx_rate(bandp, vht_capabilities, vht_operation,
 					ht_capabilities, ht_operation,
 					bss->signal_strength / 100,
-- 
2.34.1

