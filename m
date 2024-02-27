Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9513AA36
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068594; cv=none; b=gKwaEHDuWlSGqdNZVqle8zbHbyZH1in1qWT7CFPmVW7rKGUTwOP30/rZfnpyGKGUN3k4xjyxnBMYDUpm2uU1HnUOYGHV69ucOVw18QOknhrwqLMevjZLGoJqVJYPYJcSU2dvOj8ap67ndDZ/gavYtje0Ff2j5INc5yZK9bshi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068594; c=relaxed/simple;
	bh=B4m1lowvxlBk7uxsyH9ditth8TidlFJuplczoJUP58U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVmRRj/Xg95jQtvEtvjbunqc68pK7aC88Uqs7QLVChj6jDiM0KLjNzr3HrKQPVPusQ+0GbVbg+Zt3/d/YM5OrElCMnu28JJydiBidBqcLRW/dpof1IHWm15TVNQP6lqYr1nBCZnWHxIxkdXA9IdCXo/Qp2XTEryUOuaogapRpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyl0qQD7; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyl0qQD7"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4704c073becso795138137.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 13:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709068591; x=1709673391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sx55m2LJF60ZaH7ztqVGSeNxvM7qfacle8nXlqC26dg=;
        b=eyl0qQD7JLwMLMEnvegjgUcW3U+f8HB4zdVwKYWs6/sACgWaWp0PFfVDLQhabplm07
         vAIS9CCjOgcljM8/kquMsAIU33huDFuD0PUFFrr0kilr5WNmBsUBpl2I17MqoKDz7YbY
         hpQR0Yx7Cv/RWPMCc7XCrRPJTyFIspBLl7aGOAQgc3RJiNtWnRj8sMe6CNSVhuYiFNEO
         eLIclmlyUFdgLpcD66fMQhzlx0bHuOyBpGv/MOYukKHsaGIht+hXN8BoIZrRhsCIcmYu
         xO64Uie/2AOi1IlXgPuYGzUwdFsfKQ/ocvGUfIv3k0oj6leso1sGscQWGeM2M2HXMwdA
         e2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068591; x=1709673391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sx55m2LJF60ZaH7ztqVGSeNxvM7qfacle8nXlqC26dg=;
        b=RiRSl8whA7lrsPB1OUUR1h13NZJfbxWbwC1igeYVMIrsYZDvKJHIShlGNHkm2KGNfP
         peTUz5TJnJQmgZYuc+m7LxuclxhZF/CJ1oSdspB9dYGwACg/B92jW+UMrJ+hUYg3nFY1
         t4/wSf+jT7El/ghoz9Z/KLAYz7A8ru+dCczHSKlceG/rmwMK0eT2de75UIklbds2gbgc
         Lg8gEQqfLtdNl4g2aCmlxbfY6YPTalE4c3o1WmMcvWIYQfxqGfegUg2jstwfbMdjuX/m
         iJm5a52xIawJ7XjzuD3iEf8rQ2iiyi78kuiNOnzwCAK4G31a8WwyJZIQ2ph9Sj9ZBH6Z
         pIAg==
X-Gm-Message-State: AOJu0Yxv4FHLTCVybRToztQQRqUinuTJOgWRue+Vk40+XaUDGOAPcg3z
	dsw2sjFW4xg2PZXnULSZPwu3f2KPVxzQoTeAQKWyatv5zT/0uUz3+yZTAub8
X-Google-Smtp-Source: AGHT+IF+OAg4sfAq1Qov3vm/kVyMvB1PF2qUD7DWq27E3JwuXTV5wVG1v4m33whyvsD1e9ef3N/asw==
X-Received: by 2002:a05:6102:c13:b0:470:534b:722d with SMTP id x19-20020a0561020c1300b00470534b722dmr9780504vss.17.1709068591159;
        Tue, 27 Feb 2024 13:16:31 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id fu38-20020a05622a5da600b0042e09c6b82dsm3903649qtb.24.2024.02.27.13.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:16:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] station: warn on missing scan_bss in station_transition_start
Date: Tue, 27 Feb 2024 13:16:18 -0800
Message-Id: <20240227211618.318442-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227211618.318442-1-prestwoj@gmail.com>
References: <20240227211618.318442-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This shouldn't be possible in theory since the roam_bss_list being
iterated is a subset of entire scan_bss list station/network has
but to be safe, and catch any issues due to future changes warn on
this condition.
---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index 477f444a..641068cc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2533,6 +2533,8 @@ static void station_transition_start(struct station *station)
 	while ((rbss = l_queue_peek_head(station->roam_bss_list))) {
 		struct scan_bss *bss = network_bss_find_by_addr(
 					station->connected_network, rbss->addr);
+		if (L_WARN_ON(!bss))
+			continue;
 
 		roaming = station_try_next_transition(station, bss,
 							rbss->ft_failed);
-- 
2.34.1

