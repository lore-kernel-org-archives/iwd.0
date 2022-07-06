Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F156648
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:13 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id y18so6678691plb.2
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBza7GTBinUd6pDhR8LmGnIFuQRHAGBueMNiYVmpyNY=;
        b=DL0ZmfvMKAZQIvdbl24SAIxaLpzkjnXrvGbNnJHvIR8jgRx9L92qjRJTOaVd47nTkr
         g4Kh1aWrrORX5YEKoYOMWjyrfLqOEjweBUc5LhrbEeSWEQjeJI4tco2wQiEVxTfMNJpG
         /R4iIIXa2wfS5qHMhdKFJTlwGUFG9EYJhTqgm7c3F/A8YADxs6F1Aw8p3nJG6rQWduMr
         7wkZWSn16U7AGOQ5Q9rozeTnco0vQt/rt3UPjrau4AGKyByosv3cIPHPZXV7MHywqkMC
         pXjkhxF1pD02UUhUB6UQrtxGOaInvGrdeUqxOFNjmPtHSYCbbgjaBB8uxHGn4hLGgmzJ
         JbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBza7GTBinUd6pDhR8LmGnIFuQRHAGBueMNiYVmpyNY=;
        b=1Nj3S9G2/NYIpL6QpqBgvVQEheJ+JYhtg8Y5MoZI3FhrkBfo7QcAd0oi//ODktBjVB
         w7OzT3Bq1bebHL8E/psCXp7lfzdvOywlyKWZje6JgrXA5ODt87FD+3WIoED9vQDCcrTQ
         /2GcWXkajb1ayFhvz3+/BRXLUAA69gt5kBDSI5PSzaNbzmCdqB+kNI7cZ+l2FVCahh5p
         Armb6ZW/Y5hzq/a3OO82kOHFsyzxZ/weZQeot/Yp7sLGUdt2EWaRzwsqhGeYEm2cFbil
         qH99CSZukzhTBLh+8ooXLAlLF453J6THE5xcWRBcXkSAU+g79Kln2VxZPZ5+ne30jVES
         jOGA==
X-Gm-Message-State: AJIora/pEpdB78W0W80iHzDBg3hzfDgzXpXeXLJh5f3BW2S6gyZL+kOq
	V7+HQXQoziVjDggqOQqh8HxUd/AFjds=
X-Google-Smtp-Source: AGRyM1uRC4iJT+psddy9XksWWcfse6azy6Clo41yXDykDw4+yZaxK6vW9sG3dypbuCDZRanUARVbEg==
X-Received: by 2002:a17:903:2d1:b0:168:e83e:dab0 with SMTP id s17-20020a17090302d100b00168e83edab0mr47834480plk.118.1657143072771;
        Wed, 06 Jul 2022 14:31:12 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/14] client: update ad-hoc table header
Date: Wed,  6 Jul 2022 14:28:51 -0700
Message-Id: <20220706212851.92685-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706212851.92685-1-prestwoj@gmail.com>
References: <20220706212851.92685-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table header needs to be adjusted to include spaces between
columns.
---
 client/ad-hoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/ad-hoc.c b/client/ad-hoc.c
index 33bff9ca..49c97f74 100644
--- a/client/ad-hoc.c
+++ b/client/ad-hoc.c
@@ -117,7 +117,7 @@ static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 	struct l_queue *match =
 		proxy_interface_find_all(IWD_AD_HOC_INTERFACE, NULL, NULL);
 
-	display_table_header("Devices in Ad-Hoc Mode", MARGIN "%-*s%-*s",
+	display_table_header("Devices in Ad-Hoc Mode", MARGIN "%-*s  %-*s",
 				20, "Name", 8, "Started");
 
 	if (!match) {
-- 
2.34.1

