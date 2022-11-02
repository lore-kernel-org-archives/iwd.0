Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAD2772F
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:34 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id k22so43359pfd.3
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4Yp6AA1FXvkE6qMPo7pF3xcKK+LRYMCI/7aXmF7FFw=;
        b=phWEBdGHj6eyO7Ia/EqNfrlmmhC+eNu7/+LDPV/c6dEZf3bmUuYVz0SHOkq6JJ9YZd
         GHrZSQ5oThppvzLEJTv1CTN2ELTNBAMOpqUajSHULQfSkUaJoiudyBgCxRW726QAg8g9
         gW9OGdv/Z6prBjfGo6U35FzF38hLvvtfJmZrxbc4zMt+s41Iz5bj8v5Ar5FPrP+Wmkzf
         uI6isk3KnC5mubKuRS13X+zr/TPUmZ2Du35Ql/BnNGBeMtRN1IR94p49Iq739VGa8zTL
         QRVIaE00V0gxwRmKUAWxRJWN8FeNj8JDOVC+xEUkNnaC3ILgmHQuELc3PJ3yDdZjh4NU
         gsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4Yp6AA1FXvkE6qMPo7pF3xcKK+LRYMCI/7aXmF7FFw=;
        b=C4Di8e3UvtTbotpphAvrcUfhhhRSX/w+JVTqewbSj3e/BZLhggDWawjWocZzNWl4mY
         wStiotRnX4UAHtWSdKNT0/cBWpdU+pexp1IqpYe1Jq1v3+wFK0aPaZt+BfxJSIVxRqnF
         uHMjQe/ldRnG4P00xg/7fN6+2JO/7c2uHYkWKqeBLv02YYvpQjihz17FMe8jHMC+xcpk
         aGumB56I5s2+ObG6C2r5ebuP3vyzibDchrOiFzHsTcDtN45l71TWwAJMkOKzQkk/zW0y
         yPpcOnBZCc1dPbIkQWLCvRzZ9sQJZI0t8Dzq1hh6rOmVmSWuiOD9OR2F6cQURQMih48s
         5ZLQ==
X-Gm-Message-State: ACrzQf2yJTICKmZM8iE3YH5MZss6XF25PmVgESPNHvMhZ/Td3ciy3wTE
	wJogAw1UCefPaLnjlwfmfKd3CZJWv8o=
X-Google-Smtp-Source: AMsMyM6hCcWGbHVjzM0g2Q8Yi1c+4NHtKFsvdP+3/+I/4+Ut+l/0AF4d+/1TXvkOBUr3FU1nyd1/rA==
X-Received: by 2002:a63:fd4f:0:b0:45f:d7ef:9f94 with SMTP id m15-20020a63fd4f000000b0045fd7ef9f94mr23947910pgj.137.1667429493784;
        Wed, 02 Nov 2022 15:51:33 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 01/11] wiphy: add wiphy_get_supported_ciphers
Date: Wed,  2 Nov 2022 15:51:06 -0700
Message-Id: <20221102225116.297129-1-prestwoj@gmail.com>
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

