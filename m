Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F946A5
	for <iwd@lists.linux.dev>; Wed,  5 Oct 2022 22:46:36 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id v186so338154pfv.11
        for <iwd@lists.linux.dev>; Wed, 05 Oct 2022 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UFIgsLjhmO9Bdr2RMtLWJ7aV1L1Xu+W4RYBqVqD8pfk=;
        b=TUguWv1PxKNyd3inc/5z39se9H3QCXz4YKdDZmU5LW0sSPKd1uG1wl4UHJFdG5enXB
         hb0C3tDj5rgPKvH2ENbYYD37T2hkd1zF7Y9hDhKvcztNqh22SQbwya0ygJztWzNcEebS
         sUKPz5lhrnURMIICCRNEjqEkjg9B+NF8nC8yo5zZ3FkAlhvD9zi6vi/nHU9S5LCiwDPi
         FN2bZTBUHU7bsL6Bo6Ik9qkC7AZGZK8QsvyygdVM9sgzFzwrHN8bgplDQpztKuvPR0xq
         Bdrs+BiKc1tMl+BytAEPwo37ylSonHBcr+cYx1uFRcLq7yq/Vkr6Dts1f6UEy1+g5WpD
         mN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UFIgsLjhmO9Bdr2RMtLWJ7aV1L1Xu+W4RYBqVqD8pfk=;
        b=1OLM8LNZWfgKKcGcNxAVegtkOOCBWh0Kx578GwrQrKYXRJ2ARt5i86gN3+5sRJODGd
         MoJU7Saiy/miP+jqpu5c9JM9/6XizY4Mqq3oebuMRXTCoPFCLkS3tSyt9csBxjg5Xsrv
         zLrGKXDg7uYOgSpe7TiEKhEk2a8Nxqu6FvCJJOltniWhtEdLx3ZNCm1SY0hDsus8tjPq
         ejASiRNRM+igccTAsGwOpFNlGrXbsPsxEBB91aEPgUvN/llYjZ2E7onHVUu4sBuOEVKB
         K5U2PjY5vyo+mdxp61EL59PHX+pEXefvR9k3soo3jxYDaL0JoO9WbKsRAKe62Wu8ervK
         iK4g==
X-Gm-Message-State: ACrzQf0EX6TIivMWv+0v9N4BwAWNRzUQZQDO03oXXZqt79iWSZ1HIAuY
	OH0WfnXPYecGT9mXxKrfxceY3qoCi1g=
X-Google-Smtp-Source: AMsMyM4qgo6XdPQ4nOn8IxOVD9HMX6pVxIp33kYGRJjOI6dsJCH1eWGn5wcKxfaDW9PdDFC9p0/z7g==
X-Received: by 2002:a65:4bc1:0:b0:439:e6a5:122a with SMTP id p1-20020a654bc1000000b00439e6a5122amr1730101pgr.443.1665009996168;
        Wed, 05 Oct 2022 15:46:36 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm1590686pjz.39.2022.10.05.15.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:46:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] hwsim: fix early bail out processing rules
Date: Wed,  5 Oct 2022 15:46:28 -0700
Message-Id: <20221005224632.780575-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221005224632.780575-1-prestwoj@gmail.com>
References: <20221005224632.780575-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a rule was disabled it would cause hwsim to not continue processing
frames using rules further in the queue. _Most_ tests only use one
rule so this shouldn't have changed their behavior but others which
use multiple rules may be effected and the tests have not been
running properly.
---
 tools/hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 8dcb75c4..e5501904 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1204,7 +1204,7 @@ static void process_rules(const struct radio_info_rec *src_radio,
 		struct hwsim_rule *rule = rule_entry->data;
 
 		if (!rule->enabled)
-			return;
+			continue;
 
 		if (!rule->source_any &&
 				!radio_match_addr(src_radio, rule->source) &&
-- 
2.34.3

