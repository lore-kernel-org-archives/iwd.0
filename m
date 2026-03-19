Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63E3ECBFC
	for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943535; cv=none; b=kB4eTCf5uEx/UL1rMjnwMtrHBol8Aug21sGXD0oapTPIAcPZICMwkWn0PurDuTS90rYQmSCd2hoJUWJZydEVHPTm5avTciWvJmbHwKLx1I6l7GR64vSefptWslAe+jkHi5Gt5sGJBDXeDCXcgAlTdAlNVjCJZxd119PFyiO2cGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943535; c=relaxed/simple;
	bh=KPMy6qTyXhsKHDy6MSIIOfZgdFcff/w2h3eNYLRO+xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1mve6ZIlQ+DxbVhu4fQHcNtcZpXs0QJzJ0X58TKCgr7HLF5WREUdE8UhrC9LkrTrOUBl6qi09cwZ5AahDOapwj0uyYm17AMDkF0afp8WJuv6SNbScRLcsCYKpvNv1DAGUH4mTEpTRuwScbYCrGU0J4dlod9Q8ZE1dcihqYvTwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6qUPP9B; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6qUPP9B"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8298fad2063so568874b3a.3
        for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943534; x=1774548334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmzjXvM3Gcg1cvG2a3qHJrow5QCCCjekISLQTzv4HxA=;
        b=b6qUPP9Bu2YqQ9CfULZOgV4lh65Saf54oBRGOEbEm9iJuNuicUVMna0McbqZ7VcRk2
         luTLg8keWx08U3bB3jXQc8jd48nkUZ36uSSlsIXul+/Nq4mCKGH+KMZlYX8XGMdI5qD+
         GrtDqNgbSKZjjfBhTpBaIsLYNY5xJDFUgG3e/qM3NNqurV0hbuskc65HOV1nysfPeiEe
         g+NuSOK/xH+BzaihtyPSi6uuzPGX3Hxg7NKLuP8bb8qEhbt+GON7Sf4axWBgYLZxCU+Q
         RQuCLF0UT/IaYNcD3GNKLzocyGwaU03bYIN1AL2VQJKBTAfPhAXFmHldRB5Z+pknKGix
         lRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943534; x=1774548334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GmzjXvM3Gcg1cvG2a3qHJrow5QCCCjekISLQTzv4HxA=;
        b=gRppjneBtBkT8TGztOsE0ua5RmJmgLSa75ESvR+RLwjBrIYdQ2I5vlj4qmuyI8/Tvn
         gfFhttkU09XEaQ3fGVRwyKoiiK0AYHta/P8uKKyHWf0VkCM8orFggKcaNRN+JYQ/Kwl8
         D12ITGRm77WAJlo0QccdZVSQdmP8k1uMsjYC24gOtfbufBR8/kT23CULLWNAWoldrUUf
         J0NVJqiQ1qrZrj4CA9vnF+2NtP/41bs0mSdgK0D840Ja7rPHGIKKNi2LM+ExbshyR/ef
         PqftiM8e68gBqL4D6XNZeOfjIYXI9YlhA3LgXSYsosA7Zfr/2Xgw3RNKAnB59LJaNK/8
         ZSzQ==
X-Gm-Message-State: AOJu0YxzC9IrpTsTnIeAsplpQIjJ4JskNhfw9yqQsGIh9Zf1q4Xvbul4
	TwCMinqWu9hwKZ7Uohijf/OXZPCc40d38YsxHii0R3idplh5ws1P4M+Ft4lAxQ==
X-Gm-Gg: ATEYQzy6qrDbJXNbt2yt+hPxi+/YMNpIx6+iiLnnqelMFqHQntRlvL+Q0s2vWSU++ka
	oPsudaoHO7qC9gIABq+5K0exXb0RZbg5s5a2P8S++1cSXwuCCGBBs/Uwr4p+rvC4RwkcaHG/Fcv
	AAHqE2XC3xfxYU1VKF+LV2+wVPhw7BHiXxvABQfMMzRDJMgxka9welpZTFFYUj9kRyNrP1Zit4d
	dFb2xqZdlMQ0hi4UUqP1LHLpYj4AnEGQ7zZ3/KhT09SD4Y063gKfBwhhNfPtHWZbOphUDO7lzy5
	MHUI8K1c/8YaLe9k0QiL/UfSDHXOTifyVVUfwP9QPgmAhtBBcKd0LMFt4bxIUTXOyWfPiYZx1SP
	kugMN9QWpNamuYtxZUMIuZJuRGhAut7FU9Ew4KDp2SsgzKY0dvbmUKvFIyRyHYHe8bODkLJR8WJ
	BqANV0IlTEfrf25rbjamPcKabzxKE37qxCQ4+raEUdaIVQ/L6jBcNjmyHPFMr6hiiD3gX3lmA3D
	gE=
X-Received: by 2002:a05:6a00:124d:b0:827:433c:ba7e with SMTP id d2e1a72fcca58-82a8c31fe74mr176645b3a.41.1773943533597;
        Thu, 19 Mar 2026 11:05:33 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b541cafsm6699251b3a.12.2026.03.19.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:05:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] network: remove PMKSA entries on known network removal
Date: Thu, 19 Mar 2026 11:05:24 -0700
Message-Id: <20260319180525.136095-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319180525.136095-1-prestwoj@gmail.com>
References: <20260319180525.136095-1-prestwoj@gmail.com>
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
 src/network.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/network.c b/src/network.c
index a5a2375a..570745cb 100644
--- a/src/network.c
+++ b/src/network.c
@@ -58,6 +58,7 @@
 #include "src/handshake.h"
 #include "src/band.h"
 #include "src/util.h"
+#include "src/pmksa.h"
 
 #define SAE_PT_SETTING "SAE-PT-Group%u"
 
@@ -2051,6 +2052,8 @@ static void emit_known_network_removed(struct station *station, void *user_data)
 
 		l_queue_destroy(network->secrets, eap_secret_info_free);
 		network->secrets = NULL;
+
+		pmksa_cache_flush_ssid(info->ssid);
 	}
 
 	connected_network = station_get_connected_network(station);
-- 
2.34.1

