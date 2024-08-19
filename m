Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6716D4E1
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083063; cv=none; b=CoaM5var1fzLuXyLrCB0vJsW4RBpZh9XS900jRjQikmD5RbNGoUh3tFqtAyJa0g9Cdz5TkNHhfsTeJIbD5HuLqZGjR+8wFe2bQNKL5lrYKo3+cB5MbzFKevRbwXNYmP5oaAncQg6PY+P+htitiiVawemXt6vVdWfu9YjDSSGcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083063; c=relaxed/simple;
	bh=Xo0jQKN0L3cPu7vcQ9s1yXgfKSMGdhZqcDWEIRz2Tbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7ToyjHd5pWgooG9Hfo6nq2JcGZaECT4r5ze+I9DZsu1FxEXvzBdGMwXDafgUv4WYAqZE5JpHZ0gCmKqZRtsAUrz8UPg2N2P33ZIugEUD5Byhj/yVQwaD27o7S+ytMRnEScJdjXgxaJTwvtl4zg6B4+xgqyjWA50NZOy8e7xUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVLTxSuA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVLTxSuA"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-713e460f920so1191959b3a.1
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083061; x=1724687861; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBTWjnhGFVMdytmi/xL+pxTD5kCqfJksEi160IRlQa0=;
        b=BVLTxSuAWA3uO0GegNCtjAKykv+Bd7dTGNq7Dkr+wDzM0OqRvq2LVP7AnV2Mlu6L/o
         4FaZZ/sUUnRzwMkCqq/5WccpChaijWlrxtJ2VxZoghkoAGpsob0G7ffCVzE0cpGxrU9Y
         DRPtVeV2rng5zlF3atjN43md6VT/MjZVB+NwGYpesUoU4Nn93R5nfBtQFO5hsNjkVmRV
         RpsSkeLg9Ngp8AeDRhWrlOsgBajPBqgN6s9zI0ZoVeE0I3eknQ7XVnSRRnSox8/MJ/FV
         oNkVViNa76KWiU3TkDXBLtALFy4x17kxirozefwPUetHwmUfxH7TSM2a4vjrSWV4TYJT
         37FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083061; x=1724687861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBTWjnhGFVMdytmi/xL+pxTD5kCqfJksEi160IRlQa0=;
        b=Lsdb8Hs4AoSM6vZJATR45XocHeXpuRaLcUGgUtz2G7bC3xiXXeAzbwPcSlS6sDtEPO
         0wemLfq1nCdm+bmROIq/Z0jcMzwihwAihmGV0OYligTmeZwB1g/xB3MMRFyQkDj2HxMi
         doPTurvIRmMWji7dSq6F2iUmyucpQum7YqUhJopRbkny2XZoWWMHHCRe9W39QkaxWz4d
         JdSNoj/+XAHwx9KwNB/rZngT3BA2iQGgw3P+y3+RSZmR5MsBNSoPl/bHofTKUAjajWyj
         vAVNceFa0gdBeIj5KGrl+pVdfF8m2a4t4/tAyinRlRko2LU70WIzee5zcGeH4yc1+HG+
         D14g==
X-Gm-Message-State: AOJu0YyPmkRwGoQWyNIU/oi7h/rcDmkqdAD6xR/aCa0McT/XMtkjYZdr
	JK3zGZmvzU2rZQYbKsRIxGYxx2GAUdr0hPrIHPJy10h4IaRNKaBNqSPtnA==
X-Google-Smtp-Source: AGHT+IEU/oobZL4/n/C4nv7c92gx4AA5jIZ9sli7ZgxbN9s2BuU4dURUiZprlM9t4M/oQ8QSjLjm4Q==
X-Received: by 2002:a05:6a00:1ad1:b0:706:284f:6a68 with SMTP id d2e1a72fcca58-713c4efc813mr11240759b3a.23.1724083061110;
        Mon, 19 Aug 2024 08:57:41 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb5asm6752277b3a.69.2024.08.19.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:57:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/6] network: add __network_path_append_bss
Date: Mon, 19 Aug 2024 08:57:29 -0700
Message-Id: <20240819155734.1276476-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce code duplication and prepare for moving the BSS interface
to station, add a new API so station can create a BSS path without
a network object directly.
---
 src/network.c | 12 +++++++++---
 src/network.h |  3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index 85d2a983..a8e61d48 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1130,17 +1130,23 @@ bool network_update_known_frequencies(struct network *network)
 	return true;
 }
 
-const char *network_bss_get_path(const struct network *network,
-						const struct scan_bss *bss)
+const char *__network_path_append_bss(const char *network_path,
+					const struct scan_bss *bss)
 {
 	static char path[256];
 
 	snprintf(path, sizeof(path), "%s/%02x%02x%02x%02x%02x%02x",
-			network->object_path, MAC_STR(bss->addr));
+			network_path, MAC_STR(bss->addr));
 
 	return path;
 }
 
+const char *network_bss_get_path(const struct network *network,
+						const struct scan_bss *bss)
+{
+	return __network_path_append_bss(network->object_path, bss);
+}
+
 static bool network_unregister_bss(void *a, void *user_data)
 {
 	struct scan_bss *bss = a;
diff --git a/src/network.h b/src/network.h
index 78ced99d..c9f73200 100644
--- a/src/network.h
+++ b/src/network.h
@@ -77,6 +77,9 @@ const char *network_bss_get_path(const struct network *network,
 						const struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
 
+const char *__network_path_append_bss(const char *network_path,
+					const struct scan_bss *bss);
+
 struct scan_bss *network_bss_list_pop(struct network *network);
 struct scan_bss *network_bss_find_by_addr(struct network *network,
 							const uint8_t *addr);
-- 
2.34.1

