Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BC21D48
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:02 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id 130so14496373pfu.8
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubYF7od8LpUmX6xZfvGxai9I4KTJyGC1bWjpg45IAkM=;
        b=F0dE0gxLMRg+Xhpry4CJKNZphly4OedwaZ3hvqAqx8FJxLgtuisfOC9Z77wbKRxqtD
         u7psbjU/4Yrsd4VIpF+UXRYK//CrxphUmWxOLtFs8nrpahlUPlbvnU2JXKQ04HPe0o8h
         D5LfAw/jG/f1gPpHMHHQ+nA7vf2/AbWlMkDg91WQ4esQGoMGfCa/3hWW1wTqWBJCZ+Ka
         lcBOVRUCBM8ZgjrDP2b+K2hsus/nI/EaBLoTxfB0eHwnDNbM9hKSmNgfrO+r2gmmLnG6
         4U3eqoN1cU7Fs6R6BUN2wKMzXirQMTXbh+DBfbf5MqalBBLNaePD2bQKAwqgVizjAoPr
         Kxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubYF7od8LpUmX6xZfvGxai9I4KTJyGC1bWjpg45IAkM=;
        b=4fV7FpmiQWZVCqVfh+w0o/+uypQ1Cl/fqANXhfkxQlkjPWgMWk2Ctwj/vVLmVXIxjP
         dDup191HywGyDmphcnmeHMOwJ7uedoktCZ2lk3gJceef9JLKU0rdCm18NL56nC7ZLEty
         L+rW3+FMCjRtfbMHWbTsRAJXaH7LpvGVu5tzOZXhnLr3xR8H4cpc4vzUv4y3av5dCBAz
         2wgeKpAXzccN4KyXCW46n9UWYAwZUCWFrJud+Cvwzf3kBXliHN4kkBZLo+SS0y8lXsVx
         1vYnrPgKk9NlZRlzsIN6eCueAXEwegMPPzXeqKhiJ2ML/BKbZsdnoLmmkFB+UbEZai0N
         qDZw==
X-Gm-Message-State: ACrzQf277VrMw2MlAt5x95z9q8uO8uhUBu7RP4KrquntCpiZZDsmfBDU
	rVXrcQHmpk4utlvW+eNBEv9hdZZKPrg=
X-Google-Smtp-Source: AMsMyM58kKbOrTuvKq0vzEsEf6tpTYB84keG3oA9dQWTXs7HvV1q6vV/Xr4JfFQPOlsUwHWvUaTiKA==
X-Received: by 2002:a05:6a00:23cc:b0:56c:12c0:aaf7 with SMTP id g12-20020a056a0023cc00b0056c12c0aaf7mr21585813pfc.0.1667333881659;
        Tue, 01 Nov 2022 13:18:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:18:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/17] auto-t: fix testAP-no-support disabled ciphers
Date: Tue,  1 Nov 2022 13:17:42 -0700
Message-Id: <20221101201747.143379-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The disabled cipher list contained a '.' instead of ',' which prevented
the subsequent ciphers from being disabled. This was only group management
ciphers so it didn't have any effect on the test.
---
 autotests/testAP-no-support/hw.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testAP-no-support/hw.conf b/autotests/testAP-no-support/hw.conf
index 06a9d7c2..7925b15d 100644
--- a/autotests/testAP-no-support/hw.conf
+++ b/autotests/testAP-no-support/hw.conf
@@ -6,4 +6,4 @@ start_iwd=0
 iftype_disable=ap
 
 [rad1]
-cipher_disable=ccmp,bip_cmac,gcmp,gcmp_256,ccmp_256,bip_gmac.bip_gmac_256,bip_cmac_256
+cipher_disable=ccmp,bip_cmac,gcmp,gcmp_256,ccmp_256,bip_gmac,bip_gmac_256,bip_cmac_256
-- 
2.34.3

