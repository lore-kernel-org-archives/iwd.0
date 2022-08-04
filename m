Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000B5381
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 18:51:17 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id p18so630376plr.8
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YKsn5N8WM2TITn5H+mBaX48uKeeMhXvkmYo3teNknnk=;
        b=n/2mZyYy35hmGVef7Lm8XWS+kP7RMSnb/QQbH1LJeGAGUgjXQWTbhPW8/KgWqSvZxM
         N5g8bNHtoHstJf6aw9CYItRYKXQqW1Q2W4OFt+SsD1oYJJMAC3DUHf4AZLw2BHXPGJkE
         l7EakuTp9o1+s4T/ivChDVA/tzPFPPn8rr9oIuKutXwPKsxMBRi+jZCnjdYN0QyAVl5F
         Z5MimlrH+ETEYkRhVfN11atVGSw/Jj1Ke+wxSYiBBmwuCIXJco5fNM4JucvBNt1/bEq1
         YDMU2DeVWoaE5fW6cQFUqtlQl2SjI+q2ubBKKcWIMeADC+KQDerKrsM61pizbzAymLLw
         RI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YKsn5N8WM2TITn5H+mBaX48uKeeMhXvkmYo3teNknnk=;
        b=C7HeET2S3QIJS5WrktAEem7r5uPk5Wbahkgih8bJSsiLH/Zr+CN0tl8G7BAGWsEFXk
         JW+hNj9awSSEE+Wqpazw18scUYaG0KQOOdP/kkbCmYOYeMx40VG2YSV+OuyMMFTdF7xW
         XOEHUNt6nZBgdoxsPPwb0nqVZ2odQHnzLMAccLTJzHMYLgKjxhzAONtJ3u5TQnCDxEq/
         iMJDAAuI3gsmeL9+KYvKZE7LXoIcZI4fdtZZIqPNAXEeZ+tHPGWJu30RiUCvJYO496eg
         6m3Rd/6SR/2SfslUB/FLfth8mAl1STZshmQR+Y1KmeEfdpsoTfadD73UhhuY1zlKRn/j
         jFUw==
X-Gm-Message-State: ACgBeo2pJYh6x3UIMz5DEFa2F2dCtGDeh7WMi3wsB7L3NEcHSo7wfo4i
	En/7FHD+Iq0XW8YDU89oNuhwfg4CbqA=
X-Google-Smtp-Source: AA6agR4FnjVJM8ntUN+KLsoxHZeoE32QG2FXlLVLwomGMYgVHA5RrIAI6c27n5pc68AHWsC+BAroPw==
X-Received: by 2002:a17:902:b786:b0:16d:a8f3:b2c2 with SMTP id e6-20020a170902b78600b0016da8f3b2c2mr3161657pls.91.1659639076921;
        Thu, 04 Aug 2022 11:51:16 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id c7-20020a634e07000000b0041b3c112b1esm219954pgb.29.2022.08.04.11.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:51:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/7] wiphy: add wiphy_regdom_is_updating
Date: Thu,  4 Aug 2022 11:51:08 -0700
Message-Id: <20220804185112.457670-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220804185112.457670-1-prestwoj@gmail.com>
References: <20220804185112.457670-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows a module to check the current status of the regdom
in case it misses the wiphy event (e.g. registers after the
STARTED event).
---
 src/wiphy.c | 5 +++++
 src/wiphy.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index dfdca989..3beb351c 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -921,6 +921,11 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 						out_data_rate);
 }
 
+bool wiphy_regdom_is_updating(struct wiphy *wiphy)
+{
+	return wiphy->pending_freqs != NULL;
+}
+
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func,
 				void *user_data, wiphy_destroy_func_t destroy)
diff --git a/src/wiphy.h b/src/wiphy.h
index da2eca20..2159fc00 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -134,6 +134,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 				const void *ies, uint16_t ies_len,
 				const struct scan_bss *bss,
 				uint64_t *out_data_rate);
+bool wiphy_regdom_is_updating(struct wiphy *wiphy);
 
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func, void *user_data,
-- 
2.34.3

