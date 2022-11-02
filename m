Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C724F2B
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:37 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id i3so17463356pfc.11
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4Yp6AA1FXvkE6qMPo7pF3xcKK+LRYMCI/7aXmF7FFw=;
        b=DUdkzatol/qpzR0uBltGZCd78bSYAyYMx+lBzT1r5p6oEL+dzxhwbKKQxlFwaGYASc
         f5SxtlHg6fX+8YFrMe0qc6On9qMVQ9uYt3UjSe0RXRKyQv3lzvzmzxXPzYN2ZxdewLYX
         buOK3DjkUtYpoUzfMcQHZ9YtvF63ib6pzYxFlpBuOfcDA9wHIL0rUzZ/+IeY/8gVs2+k
         N9XcnFhTYHoSItgtdyiGDVn3PaGe0Hlk2PToTfcibbCB20t6pq6lxuPMzygviS+erko6
         mDs+F9tuxStzU02irWO7acn1XAvqf325xnVOEZnlb/IW7Izo4emJ8iU6eCI/HjmIsRml
         uN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4Yp6AA1FXvkE6qMPo7pF3xcKK+LRYMCI/7aXmF7FFw=;
        b=ozOEfNgBW5Gc3QRSgARC3zBQnYmxQutywbf2XxMeuCREB/gETxbwkYUEFNQzZ529Pg
         YOfVOMtCjPvZQRZV1FmHVG1ssEkwv7JwutAkd9X59J69MSfoY5XVGhsshxmPHP7GlwO/
         Xi9IpB6mQ/SofJ3LyArxFoFTaaM1fa9Sn+yAMs6MrkLkrekqwjqv712TStUqmeksvg2T
         kjmi9lywsoR+uk6DeMpSebfZEAxCG6l93NgQavq0LHWiDQYa0+WXqVg3TnGi9vY0C4My
         RpeGdEqEKGdTdh25PgGNk8+tOAFiKbKYTif6Y15/2cXsPt6GkYPfbfFFs08WatfFjWNg
         aHNA==
X-Gm-Message-State: ACrzQf3WV6Ft+BM1Jk0IgwdVBpmYEWVIS/qe+7umvbMzrCFekmnT77SG
	BfRDPXEFW2wn79Ly59ItyKhf+BPyBcI=
X-Google-Smtp-Source: AMsMyM7wJ5Zx83j3/HfCUC3WqUu4303I/dU+ux0scXwNdeDu4RYL1nPvlo1JwRFcYXfkjgu+nb5GeQ==
X-Received: by 2002:a65:4cc9:0:b0:46f:f740:3b6d with SMTP id n9-20020a654cc9000000b0046ff7403b6dmr7450042pgt.584.1667422416868;
        Wed, 02 Nov 2022 13:53:36 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/10] wiphy: add wiphy_get_supported_ciphers
Date: Wed,  2 Nov 2022 13:53:18 -0700
Message-Id: <20221102205327.268693-1-prestwoj@gmail.com>
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

