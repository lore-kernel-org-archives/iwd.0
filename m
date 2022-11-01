Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A87E
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:17:55 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id y13so14485721pfp.7
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4Yp6AA1FXvkE6qMPo7pF3xcKK+LRYMCI/7aXmF7FFw=;
        b=i4LpWDq3A2fJrogppRp0erM+feRX1KiYYozpYfuPKGqU0AxGOPYZxYgetAauJzkZHM
         hmWoFWqL2gb7fMsbFNfoeuXSZmimWkOtmxAuS5Z6wy4j8adNrvvZpYOpYQdBHjGZjcBv
         9KbfXt1FFICfI0tBUq14XKhkzhmWUDjcpoCAKm34GTBJQASNP5h0+Kv283q2YL1BD+ya
         PyF4TkteQ1g5ObllzfzU/CX8CMsMHsQzEVKxjDFuM9tPn4EVHpG5i7ep6ldwQoDpNfnf
         d9TQkbb9eSIro0OxLpRn4xnMLGYmrdKyjVu2WgtoZNdEFEFOYrBLicleF4kzmk7KVJ+S
         t5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4Yp6AA1FXvkE6qMPo7pF3xcKK+LRYMCI/7aXmF7FFw=;
        b=acojGCy2ynTMM0mY+BAy+z2QDSaUcbXVpFCGCscndriJlCyEqjaBTtjzEzNLfFIlS3
         5pvx+jIdZgz2Fkki3cr1kmwZ7KiwCP76/La7xqyDEF89Pfw+jtu34lUT3rB1xhbRCuF2
         oCEOs8nGVzYh4020MVAuD+E6J3Olqnf777a6M0h3eN0TIq1v8NXpFBIaHVOOwm6MMTp1
         80KZmIK4zKwi1TFpkUvKa+7WO1RKvwSC2e6d+9IBU3q981ivqktH4xKtF//U9x/drFjn
         Dis7JwGDQw9vdc5+lnaarVw+sq5EduyEAukYLhsJ9zHcp1i98Yf+ItViI6AF+cf/ybLy
         HaOg==
X-Gm-Message-State: ACrzQf3BR9jLAylcyzzql6ZA+HLt1blY/lV28xLRPSrA0leUblD04UWX
	JqHrl+7YQcYO594ysWKjjir6o5p1asY=
X-Google-Smtp-Source: AMsMyM4TTmzFZAY52Mym8GRN5oddIhMBlIZt+d7ujNQ4y+z0KxAtiJtAIwIVfB32b+v6k42yqgvltQ==
X-Received: by 2002:a63:914b:0:b0:46e:dbd5:ae15 with SMTP id l72-20020a63914b000000b0046edbd5ae15mr18816907pge.94.1667333874482;
        Tue, 01 Nov 2022 13:17:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/17] wiphy: add wiphy_get_supported_ciphers
Date: Tue,  1 Nov 2022 13:17:31 -0700
Message-Id: <20221101201747.143379-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to wiphy_select_cipher but returns all supported ciphers
included in the mask rather than just one.
---
 src/wiphy.c | 5 +++++
 src/wiphy.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index bb83f814..10514572 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -180,6 +180,11 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wiphy *wiphy, uint16_t mask)
 	return 0;
 }
 
+uint16_t wiphy_get_supported_ciphers(struct wiphy *wiphy, uint16_t mask)
+{
+	return wiphy->supported_ciphers & mask;
+}
+
 static bool wiphy_can_connect_sae(struct wiphy *wiphy)
 {
 	/*
diff --git a/src/wiphy.h b/src/wiphy.h
index 2c6bf86b..f8de7e0e 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -68,6 +68,8 @@ typedef void (*wiphy_destroy_func_t)(void *user_data);
 
 enum ie_rsn_cipher_suite wiphy_select_cipher(struct wiphy *wiphy,
 							uint16_t mask);
+uint16_t wiphy_get_supported_ciphers(struct wiphy *wiphy, uint16_t mask);
+
 enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 					const struct scan_bss *bss,
 					enum security security,
-- 
2.34.3

