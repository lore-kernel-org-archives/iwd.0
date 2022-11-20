Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542520E0
	for <iwd@lists.linux.dev>; Sun, 20 Nov 2022 16:10:49 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id b11so8496380pjp.2
        for <iwd@lists.linux.dev>; Sun, 20 Nov 2022 08:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrZ3lDc9tO3ltkELdWLGHA2cuypljdkdASX4fBTpwSc=;
        b=KrQqjrMwTlOppUksKGI2Hwk3dlWD7PX5b7e2m0MscOZuSWDBBbVif4Tk88KOaHj1Zc
         pEwQgb/SFFHVUYuXsn7G+vVtbKS7RpLe/eBMLK5YCuaA7uqIgWfWUhAE9NSGES8pza7P
         11obLOeVk0406W+j8FTz9j9RYkbbgn3Tw4K9b4HVb/DvmaZaR4OK21U0y4fxmTbGJ/Du
         cfnM4/kyRgBw6jNrM4rVTHcy0K8GtWahvK4yQJPFTIXmcyo3BszKR7AXMpnS4apnGMyn
         +hFjn+aiQWX6ayRyHr3w/XOHzUt0sHqkCT2xILKQuPf1d5wjpQVO5IwCfimDZCN+xD28
         MqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrZ3lDc9tO3ltkELdWLGHA2cuypljdkdASX4fBTpwSc=;
        b=dLdeTbW+dxKJ3rr7suIi9q88vWesRdewChwIqDDzE4rFCrG2nH7VAeNDygukl/BLrP
         OW1HmjFcPKwjDnQPVURscC5JWOezZpgkcygv7aCDK6IhnCWIQYxZpkl61RiZK92ID0SU
         17ehppZHU40xMDG3ziaIdZHC6iQQJ5HsHNL4paS54GutnBVgTV2196WGcxRjsimC0sEG
         WnyqcTO3dd/QC1GvzWYy97BW8LDLB2P7waAM8++VhNKiucyhM1cC2vDxHmngZQvi4A0I
         JECDLBv6j4gTz5xsN7GN+a47cnoqGUL0SdlhD7tOSM1blYuPwrnHW96OaHZvSqRgwlxW
         9rDA==
X-Gm-Message-State: ANoB5pnwzo3V4q1rM/L1Hd2h3WKs//oY05RfehXYHCfZRH9vR+sCt98u
	Wk0kkcU10pkq4BPfTldCJlzlpNv0yIHXOw==
X-Google-Smtp-Source: AA0mqf5voU5iYPz/UyuqtgXlECeUz9mLs+pl4e5y6wFzCRXQ9zNc71zx5XtKJlG4R6u1N9Cdw3/ISA==
X-Received: by 2002:a17:90b:4382:b0:20b:c375:575 with SMTP id in2-20020a17090b438200b0020bc3750575mr16290295pjb.174.1668960648362;
        Sun, 20 Nov 2022 08:10:48 -0800 (PST)
Received: from localhost ([2a09:bac1:3680:80::1c5:81])
        by smtp.gmail.com with UTF8SMTPSA id 135-20020a62178d000000b0056ba6952e40sm6836455pfx.181.2022.11.20.08.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 08:10:48 -0800 (PST)
From: Neehar Vijay <env252525@gmail.com>
To: iwd@lists.linux.dev
Cc: Neehar Vijay <env252525@gmail.com>
Subject: [PATCH 3/3] client: fix non-interactive mode in some cases
Date: Sun, 20 Nov 2022 21:39:17 +0530
Message-Id: <20221120160912.72307-3-env252525@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221120160912.72307-1-env252525@gmail.com>
References: <20221120160912.72307-1-env252525@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this change, I noticed that some non-interactive commands
don't work,

  $ iwctl version

  $ iwctl help

while other ones do.

  $ iwctl station wlan0 show

This seems to be a typo bug in the if clause checking for additional
arguments.
---
 client/command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/command.c b/client/command.c
index dbd97703..84be680c 100644
--- a/client/command.c
+++ b/client/command.c
@@ -753,7 +753,7 @@ options_parsed:
 	argv += optind;
 	argc -= optind;
 
-	if (argc < 2) {
+	if (argc < 1) {
 		interactive_mode = true;
 		return false;
 	}
-- 
2.38.1

