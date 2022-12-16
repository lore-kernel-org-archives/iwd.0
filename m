Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18E8BE6
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 21:27:48 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id fy4so3750746pjb.0
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 13:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+UuGXs7Kl6zzo4tjOaDH/TtKM7ac5Puc+p1Vnfy258=;
        b=h1lttBCj8y1QQN77UcQ0UiGVaooJucmTHXm7kwOHeU7WogumIuKyTEvzm9n1jqF45i
         bQZlWDQNtqtZ8iJqUauW/XQJmlqDGwYSYx1qQHeCvUs8xcv/LhSnnh/6nr9gsKXgZwDa
         yCysUV2BVXDYniwxw8z+DddVd3AYRqxnQupZdi11TmdVj58e9HkChhCoq6Mcx7b+Vokm
         hYvHdf/MC0sZBk6azV0wEQE9fWrZnJMH3+x0L0KyQk9+Nzh1976b5vptwKNjvaDtnucC
         MSh6P93NntGSSo7tbF6qMjmo2AEZLMM4R7vBjn50hmU3al3FPHLgbPN13q+hafj04NA9
         akBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+UuGXs7Kl6zzo4tjOaDH/TtKM7ac5Puc+p1Vnfy258=;
        b=XB0rJC3a6rlrBfPxkCnjYZnRDGujLfVq5VG5RYJ+DkcSQbxNa4kRmQnSErZQO5kyBu
         J2LzhwHOFPwAUjt+5LoGtzze/sieRDZQ8Vihe8DNfEISZgXRFFq84Q3mWJaDvWprcOln
         +ZT0Zba+2L8gxdhDB/hFRFHu92AKNqQgrTkdya7FBCmrMW7rrhudPVq55Mvl27GF2l0U
         3QogkDRvoxkkIIcXW2HLDDTchPZW8OFbt5ZvvDq/vk2sMN5CynksjFFhPVcAWkNS0Nbe
         vbhIkzRDtqAgHJl/DMAY33TIiLR96SNfhaonP3JfQtX5As6aBRvqLSKoYMVrYuMyMpLx
         DIOQ==
X-Gm-Message-State: ANoB5pkjuza4njNpMWXws7EXFuXE3c/0NR03PC9NI7vVnmeAjNEmTEOI
	zRKNfMC2nzwrkJJFgk1HULsVNweK9Xg=
X-Google-Smtp-Source: AA0mqf7IdJUq2gIn/VrKTPpckrG+L004IrAD9nADJEUfFysVfPZjVmFjL7eqOhYQDb3oT6Vv6UsZ2g==
X-Received: by 2002:a17:90b:1d10:b0:213:853a:83fc with SMTP id on16-20020a17090b1d1000b00213853a83fcmr34751396pjb.29.1671226067542;
        Fri, 16 Dec 2022 13:27:47 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b004785e505bcdsm1905404pgz.51.2022.12.16.13.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:27:47 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/8] wiphy: remove pending_freqs from wiphy_regdom_is_updating
Date: Fri, 16 Dec 2022 13:27:36 -0800
Message-Id: <20221216212741.1833286-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216212741.1833286-1-prestwoj@gmail.com>
References: <20221216212741.1833286-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can determine this info based on the dump IDs.
---
 src/wiphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 6b8f00a1..3777bd58 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -979,7 +979,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 
 bool wiphy_regdom_is_updating(struct wiphy *wiphy)
 {
-	return wiphy->pending_freqs != NULL;
+	return wiphy->dump_id || (!wiphy->self_managed && wiphy_dump_id);
 }
 
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
-- 
2.34.3

