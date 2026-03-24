Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B22C11E2
	for <iwd@lists.linux.dev>; Tue, 24 Mar 2026 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380062; cv=none; b=lWQIrvYQ4SBDPzCxR24n8sSdgyawGFf5ccykjDGNy0JVjt4oVMjLj2p1YmTl3bvL2iX7Zj59IABXFz2CUw2TV1/DeMpGvX0LjyrZQUXeC8WzM1ir+T278kk0UR6fg5GUmWB39kWFmj3SPFFYsuqT2rv6LDldOtMCwZ3BDKd76FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380062; c=relaxed/simple;
	bh=yegxOTNbvkWHPr1/8r51RwojkfCNzbpc1pyp+uDAGa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQO16JGWJfdgECAkAX0DCqHAKGUrkvmUHP8Buwd6gGIyx5lx5+AiBsScoOH7EPcl19GIQcNGAMcsxxZeZtsipN0iKsGevhxhUCG8k1KAiQI/GafF220WOBqT5ydPQ1W+SkFcz/l16GOi2oGKs+MTLx0PaF7eTyvacJ+nF4l3eJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMkrJ6Yv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMkrJ6Yv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a27414a3so2645272b3a.3
        for <iwd@lists.linux.dev>; Tue, 24 Mar 2026 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380060; x=1774984860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O25yJO5gBWdk0tAdzi3eWFvU/bu++LQEDuDsCeXK/6o=;
        b=bMkrJ6YvBwcUfuqvYpP7q8+54n8x4J4Q55coHlkq9hALN7T5rAnYy/tJnDkDcP1ONj
         9nyP22F0DuL1c/NelaxTWloAqJno9SZjSwaM/HwJf7+znbnLY6LbVyyQZJ2ZkipMa7/+
         mOGbj8r9zuwQ/K3uxH1IThozUasDJFzCSmc7Xs+fDTcQqUY99FQj2H4FGDWXFvfOZtfs
         uH7FH6kxRbioEqp81AzLjGQzvggSz2qtWTGyP8VmYm+myPtHYY/EB2MdB5fB+pytalMo
         r/7MVn/XPRxvGODHEhag3yLFAq62WXEEg4p9mYaRmAPcrnW4eNEMI5FapSSveCovEvJj
         2D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380060; x=1774984860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O25yJO5gBWdk0tAdzi3eWFvU/bu++LQEDuDsCeXK/6o=;
        b=QG7DwbpCbDw2MaXcNxCCFsPW7XXE7HJHSbBYgdypnJDfnr9Peh0nWjpckHhX86TiYW
         vxCf1VStzeQDUc061MgvoCf0W5Iqtko2cfs7Nfsu+dKTaoAY+KeqRPaUrg1TRCj2x8GN
         5o+fFcHFTfc4/TPdaSnR4U8sHBw8aGEx8rap73X87tTcvwooz4ZE4UYwgaK0VdegSMw5
         k3dX1ZLq9ZzMT90rSHtLWyFyHUBx7bbRWCPKfneYEKvWORgVE9giIWedXC+ivXcBfg1R
         Rai5FkuiuitzwUvH5wGc3HZAse1rlRORmQQ2hm6l7ucXgH5SgwRa6ImO2V5TOUeMdqdX
         +rqw==
X-Gm-Message-State: AOJu0YzLJnnkyej70wJKd4qqghqHx4JmfJjg32Blq/bKPt6LOUcBQUE5
	7TEaOzDflxemc311Tghl3YbID5Nrc2TBH9oIyGSDOYc9P+/gSbCXA9p2aHN3zw==
X-Gm-Gg: ATEYQzypOEebc9GsfgPRW1f9vQOLTTSlhCQLnHhSs9EY1x+9eV4rxmq56fWkwJz98ry
	yPHjCB043DuP4iRYIwjfdGKSClypBjWq2YrPIs4ia9WsyN/0Gsqw9mlbfVajljKu5cwReDywcV3
	Ty3IWacnB+lDAZpVUbJMcMT69nmL9FslZUyQ7lXrRSahnSfZyeEMtF93/ndc8jqeshwrVxMd3Cr
	Ln54+dmy6kL4Gjb7l8zUah/0ZrOh+VIKlITJvTh0o1GPQVtka8I6zLIVG6w4/6oYCpolP5XQAee
	BgXTCDP7FW7u58EA7WunXrxP+QC2AsUqho4NdakeDgbzYWwukB4wURjMt+VCtiXSkQcbdbUztkX
	L2Pz0i68cnukANP+lGKMkTVKCQQYhFr40kS355frzHKjwKgOlS9lRvb2+6fELWpmg7bzCYaVA/S
	zGqJojvLeVdRocv1H1FWjYBna1I8GFI8kTkuqhq75NbxrHkIgpteGB1uZ3gdT4g8rH
X-Received: by 2002:a05:6a20:2448:b0:398:7da3:e4de with SMTP id adf61e73a8af0-39c4aa5708emr887807637.6.1774380060198;
        Tue, 24 Mar 2026 12:21:00 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938743sm10311125a12.19.2026.03.24.12.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:20:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] network: remove PMKSA entries on known network removal
Date: Tue, 24 Mar 2026 12:20:50 -0700
Message-Id: <20260324192051.801196-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324192051.801196-1-prestwoj@gmail.com>
References: <20260324192051.801196-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a known network is removed we should also flush any PMKSA entries
associated with that network. Without doing this it would permit IWD
allow connect to that network later which would be confusing to the
user since they explicitly removed the network.
---
 src/network.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/network.c b/src/network.c
index a5a2375a..2d67383f 100644
--- a/src/network.c
+++ b/src/network.c
@@ -58,6 +58,7 @@
 #include "src/handshake.h"
 #include "src/band.h"
 #include "src/util.h"
+#include "src/pmksa.h"
 
 #define SAE_PT_SETTING "SAE-PT-Group%u"
 
@@ -2051,6 +2052,10 @@ static void emit_known_network_removed(struct station *station, void *user_data)
 
 		l_queue_destroy(network->secrets, eap_secret_info_free);
 		network->secrets = NULL;
+
+		pmksa_cache_flush_ssid((uint8_t *)info->ssid,
+					sizeof(info->ssid),
+					security_to_akms(network->security));
 	}
 
 	connected_network = station_get_connected_network(station);
-- 
2.34.1

