Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C721426F
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 18:09:29 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-3f9e5c011cfso37996751cf.1
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687198168; x=1689790168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvjSP7iTjh3+N0OkRVEY+dGRNgXvdcsmdCzw187tvH8=;
        b=LAXJAQ9S3lHwE5iNWIxCjx1C/0IvH/yjnKMItuXPYczMQlIgM2Y3gi+FjfB4sP0hMO
         0o1Bu+6zNO8vz2SMKemIFVxMRIW5s7VxR9U2hvpT85jtUcJh+c7zbcbJTYpTTyyNcO0V
         NFKlGUkhWJ5n2/Y8dpJArepG3Rt6137Tg6UzLpS3oqvMJfMyCOfOuFbCbmBrLqqYCE61
         HtIPM7zdxAYOsDO2SBnu7PJ3qXs/VEmLBJmmTxd31S08+NaT1CjoMZ5bHq6+T8HT7/b7
         HovuUddshDKvIFWvXpqCSxQyOJruwmclU0kLXC9dMCdHBpYhFy8c+Da5C35SXvrhKHSa
         HzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198168; x=1689790168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvjSP7iTjh3+N0OkRVEY+dGRNgXvdcsmdCzw187tvH8=;
        b=Iz6RgOzhvdpgXwJaGr9A0kiBitNGy0zCHzAHzMCMKMpDEPqSzCMKDlMViVEcMChP/x
         IYUQz3E99D9dkYelrJElqwvctxaJyar5lcuh86SqFdpPoXy4n3zo97V4QOFJI+nfkvzf
         qvgeOOXdP9Fdbrq232RCTnAHAWU1yZbknBbmFTuUvAQU0PIoCKEwu5mEIx78YnSUmMy4
         CJd1LMXNZS9haojZyI5o9kL/oKP0F62OxTnJokWluTDdtdxsxVzuXIzR0/1iGu/wJCAL
         lvWZeSZY4amOsGAHdPf8V52J4+TBVvgs6y4rqU5lEQ94g3pZNvg3l4sKr+/Wz0PNcBYB
         GTEQ==
X-Gm-Message-State: AC+VfDwYjBYo19cP12iZx47yvyl/J0RZslaMay/3M7PstUP+/D6raubU
	tSfE8CHGt/iKd+8oHR3nDOw5TAbXkF0=
X-Google-Smtp-Source: ACHHUZ51b7i8/EwQzYK+jNOEauvsL4M2R+7tF/6hrDH7tcvHpzWIIuxUr8tWVNpf4WJBXSfqIS7c5w==
X-Received: by 2002:ac8:58ca:0:b0:3ff:230f:63a7 with SMTP id u10-20020ac858ca000000b003ff230f63a7mr3054211qta.27.1687198168582;
        Mon, 19 Jun 2023 11:09:28 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i21-20020ac84f55000000b003ff0d00a71esm148930qtw.13.2023.06.19.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 11:09:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] wiphy: remove l_info's for control port/power save
Date: Mon, 19 Jun 2023 11:09:22 -0700
Message-Id: <20230619180922.231506-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619180922.231506-1-prestwoj@gmail.com>
References: <20230619180922.231506-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These should not have been put into a getter for wiphy and now
the driver quirks are printed out in wiphy_print_basic_info.
---
 src/wiphy.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 39ebe276..77ed2acf 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -708,11 +708,8 @@ bool wiphy_control_port_enabled(struct wiphy *wiphy)
 	const struct l_settings *settings = iwd_get_config();
 	bool enabled;
 
-	if (wiphy->driver_flags & FORCE_PAE) {
-		l_info("Not using Control Port due to driver quirks: %s",
-				wiphy_get_driver(wiphy));
+	if (wiphy->driver_flags & FORCE_PAE)
 		return false;
-	}
 
 	if (!wiphy_has_ext_feature(wiphy,
 			NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211))
@@ -727,11 +724,8 @@ bool wiphy_control_port_enabled(struct wiphy *wiphy)
 
 bool wiphy_power_save_disabled(struct wiphy *wiphy)
 {
-	if (wiphy->driver_flags & POWER_SAVE_DISABLE) {
-		l_info("Disabling power save due to driver quirks: %s",
-				wiphy_get_driver(wiphy));
+	if (wiphy->driver_flags & POWER_SAVE_DISABLE)
 		return true;
-	}
 
 	return false;
 }
-- 
2.25.1

