Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D458286A
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054479; cv=none; b=OMRtwqr1GBz8kfpOfTyJpWvnJZtwOViW2bHRdcO2dDTs0CeKwlNLc1rTerBdbXsmLfy+A3yFS0nlphEHgrN0lm2IKErWrrXXda6+qReEpfBGKxuchi0V7OUb2RPhDNc4bAgQME/hPKCYDVkulsAoI5xS/iF8OXrV8f5CRP/OxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054479; c=relaxed/simple;
	bh=jT2jOrG27/w/HrkUAbjILDUv6bAsEM1IJLK4FKAIhWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+3AYP0g0v6+cvuHJ6N5tkBhObab5Ez3w+XhStLg9sQx7OJGjYr/y7/9Pf9Gzv25j4HM6+B6GFXxzw0Qit7SnbjJJtK8jyd8J98ZmfFWPT0FdU/UQ/rdJDJgd0f3hk4UVWZCPEPHRgiJppnZ9g6kcNb0jP6M823nrsQ9M7sbJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzO90Vbw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzO90Vbw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1d42da3e9so12951185a.1
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054476; x=1723659276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV2pDDJt19SgNsYn1dvCmgJMDADL+XSydLEn2aJzO8E=;
        b=IzO90VbwskZEXqWs272jRnMVX8rRST/JCwzSSySGvZmo1+37nhuSR3jrNQYKvC5PBt
         Ijf3a3xIkuhaL9/UHxvKU04KR4LhBkfLHlZlmvVeYaQ2Tm20lrMXhYKjHjOfzfg1aRAb
         8MSrUqO3T25u57y+5bXongx3aRmMBI9zKVQph8CU1/LBuY6mRWe2B4fDYd9Ih9GUqs/s
         g7FwV4OgQ5CJSO+lEnjp0a4CB4SgBWFjL32tYPT8SPwC5qA+KcAoraMtz7Z6dmoMiaHH
         HjHxhKpw9H2k7UTE+qsKPUbiNi5jvudZvnkUKNKOo41aUdo8wOL3pew5NU9Rwwv4/5kt
         j6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054476; x=1723659276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV2pDDJt19SgNsYn1dvCmgJMDADL+XSydLEn2aJzO8E=;
        b=sxqvUa97WHVJ5uSqjHIn/FoB9nJK/339kg05bcdgPcurtURBGltxGRu4qnOgKOVxhc
         +w9DbsEXMVAd2I4Qpm/75RUP8SSb6iOlEoQdQK3brisz71iVxMJT89O+ZVt79l43l9xg
         KsfbbLWZ/ffuWXOFMifr8OYqM4r343U6p0gwEDl4dVLAZL8Q03JlMP2RZLG0y+WUw/gk
         gWT5oyzsieX5ieTrCnaRuNCuyQPBuNE5e3Zmt48bGQ5/gSua00ShR95W++FYHc4qUBsp
         PWhJd3lNx6X1ILaqlIWcmo/j2zAIrc1M3KCbEvP4HcdO6fMCNwZduFUpCtXDKgyr0Jfl
         Bg/g==
X-Gm-Message-State: AOJu0Yyla70lkHg4JGt/V0J2Eic8zp+XYhnJAAO3zbh/fmgWSVuW8HMX
	FgF4+3KvxX0IAmXsTSCB5PT0jg3dGDiJfTaW7Aw5/KhrSmrOzynKlzpbPA==
X-Google-Smtp-Source: AGHT+IHliC8Nhan7r32glzsSPZiFWJ33Qyj1FUDGiwvjlTRoEmcQEl4Y2ZbPAOo3sLof4Jx5V85c1w==
X-Received: by 2002:a05:620a:4056:b0:79f:17cb:7046 with SMTP id af79cd13be357-7a34efc0429mr2559010585a.69.1723054476536;
        Wed, 07 Aug 2024 11:14:36 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/14] network: remove network_bss_list_clear
Date: Wed,  7 Aug 2024 11:14:16 -0700
Message-Id: <20240807181427.170515-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/network.c | 6 ------
 src/network.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/src/network.c b/src/network.c
index 6d7e5ec4..c63d53b8 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1184,12 +1184,6 @@ bool network_bss_list_isempty(struct network *network)
 	return l_queue_isempty(network->bss_list);
 }
 
-void network_bss_list_clear(struct network *network)
-{
-	l_queue_destroy(network->bss_list, NULL);
-	network->bss_list = l_queue_new();
-}
-
 struct network_prune_data {
 	struct network *network;
 	struct l_queue *new_list;
diff --git a/src/network.h b/src/network.h
index be81c150..29bc57ee 100644
--- a/src/network.h
+++ b/src/network.h
@@ -70,7 +70,6 @@ void network_connect_failed(struct network *network, bool in_handshake);
 bool network_bss_add(struct network *network, struct scan_bss *bss);
 bool network_bss_update(struct network *network, struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
-void network_bss_list_clear(struct network *network);
 void network_bss_list_prune(struct network *network, struct l_queue *new_list);
 
 struct scan_bss *network_bss_list_pop(struct network *network);
-- 
2.34.1

