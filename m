Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65882D978B
	for <iwd@lists.linux.dev>; Tue, 24 Mar 2026 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380060; cv=none; b=KkEjwVsx4ziwvp3Znil8IZzfn0jO6UV3el9kqgg/o+PGSWSZIUlgjkz9r3xb0raFj8mUvC8/G5T+2EqdaHZgd+GQTNZV7m5imq++lGYGz+8laaRjpVjbDaA3dTBcX5GkJrqPgdJr8gjZa9YfTdKYT76smOuv8yyHU3669/Sgc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380060; c=relaxed/simple;
	bh=deNiPkM2affAwlt/TLqptey07RDa4L5QTFfMU8r/qlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2BWfMyj9jEUuhcX3qDnxQG6zhoXxvO9ZCyEUntSRtje8bvGQd0vVcGfAJevhZFh5PtmGBMJ0BVohPZi4DD5G8ah0687BFt54CqQ69J6h8jzaiVtUuZOOErhMZfORSwfbpZdaTPCBM/UJeD75t6d7GIEld+TiG7gq3KfCUCplFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=padfDWYD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="padfDWYD"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70f91776fcso764258a12.0
        for <iwd@lists.linux.dev>; Tue, 24 Mar 2026 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380059; x=1774984859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/taDBm6ievwdfh1tcdLISpwDGpjrlkH6M1oupmO+yqQ=;
        b=padfDWYDyexyIb5PCJhRrpHymFEsfxtacUrAryRjaCz516trToLkzGx4QbwYERp5nM
         nIPimmR43zMw6XsUe64U4brOEelrBzx373N7pyjDNBDg2XA5BOkbBX710kPsuqhPzF2T
         FFdmA6w+600pL2gUspiAhdbpN+iurQPDXLBSKcK+A+JogzpDHLQNcBPSJPdKRafuKM0z
         FNB4iGnQHBrHM0cmhhtBT4l+FPmHDRAL1inippBWAkPy4a/aU9hB7t8G/8Nd34q9fFvj
         ZzzzrVk5m2MxAg714RrrIh9NWyQFjyJAOEtZEoHf2h8dDg4LV+JevqMorfY8aCq6g/dp
         Jz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380059; x=1774984859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/taDBm6ievwdfh1tcdLISpwDGpjrlkH6M1oupmO+yqQ=;
        b=p9Y4X8bxeBIVmL5/r5Eih+ABrRXr1XhmVUP2BZZL3RUnXn+CZrC6vd+kiKNuL18jvU
         Uwv0GKGAYZ2olKND43wDNYLVcIMuj5wwLlJNyCeO9tQejsAiyxose8LgeL+AhBhNjzsR
         ZAbsQ+5B2VzzBPe+zWvVy490thtmhMuHcl6s5pSEHNi4/UqkdAcKVpcqzmJ0JY/awGZh
         NVfQcKKgn4VfNMiIoje6FKPz7dQ4y7BrvNat5u+gWdxkhpw3rp1w6u+UoIyYLXIoJcRJ
         bc3o+jDEuUf8BSz4DPt84cCfvteHzOw6StE8Ccikv0XrlACqmsTARWN9hgT8upS5V36p
         Ko2w==
X-Gm-Message-State: AOJu0Ywf9LAY0BbzdeFY+lgvJSAJCcKLtE6CAND4aYvAo8xadZ2Mwarg
	2PpUGanhrli8EMIg33kEuT8Vuey0izXur/jlp9+XeghByuKop5dK5xUAY4wDxg==
X-Gm-Gg: ATEYQzyJYAt4wIdoXtHsQA4AOeEYMtuTKLRDzbIZFEMjjvNkWKjXuDEvQIBS1kxn9O7
	s1/Q5TRlleEz7mSZLtvlC1NFkSlMkzBL/LlZ5tqAQuMIM6fglIzt/N1TNbisGtxNUmn5CkEyEVf
	tc25fZzVdkILHJeC5qhumSH/uAbjPz2o3hpgGz5xAj7Vl0s4eaCdyM/njNCFCVNleKsoT3k8Fki
	yy9CFgNoAie9dU5VGJA4bvdIyiRcefKWotGc6fiSDfFW8ILZ82bWANaK1kBSyZzgIQhVKUSOamp
	7UBkMSsSdV8w1zjrfehHgJS9fbKiPQ+6OTW3RvPGRum3louK1jRFewTGoZ1GFvb81GeFGlvp7K4
	dO5isho4lTEZAyGLbTI3mL7NYfdPHeuLwCv49GqiqPNQQDTkipeCrkQXGH0JJRPCcIBGzFX4teU
	6hHB6At6MHt1ESBI9AJXQyZyydRd8m6UTjBBxaSQ2XQlYhQiLUpo3mbaPIrlntEIsy+SHACGokj
	MU=
X-Received: by 2002:a05:6a20:2583:b0:39b:b35f:2eb4 with SMTP id adf61e73a8af0-39c4ae08048mr905143637.59.1774380058408;
        Tue, 24 Mar 2026 12:20:58 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938743sm10311125a12.19.2026.03.24.12.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:20:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] common: add security_to_akms()
Date: Tue, 24 Mar 2026 12:20:49 -0700
Message-Id: <20260324192051.801196-2-prestwoj@gmail.com>
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

This takes a security enum and returns a bitmask of all possible
AKMs for that security type. The AKM list was refactored to be
reused by AKM_IS_PSK/AKM_IS_8021X.
---
 src/common.c | 41 +++++++++++++++++++++++++++++++----------
 src/common.h |  1 +
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/src/common.c b/src/common.c
index 91979423..1e5b3b7b 100644
--- a/src/common.c
+++ b/src/common.c
@@ -28,6 +28,8 @@
 #include <stdbool.h>
 #include <string.h>
 
+#include <ell/ell.h>
+
 #include "src/iwd.h"
 #include "src/common.h"
 #include "src/ie.h"
@@ -64,18 +66,15 @@ bool security_from_str(const char *str, enum security *security)
 	return true;
 }
 
-#define AKM_IS_PSK(akm)							\
-(									\
-	akm & (IE_RSN_AKM_SUITE_PSK |					\
+#define AKMS_PSK \
+	(IE_RSN_AKM_SUITE_PSK |						\
 		IE_RSN_AKM_SUITE_PSK_SHA256 |				\
 		IE_RSN_AKM_SUITE_FT_USING_PSK |				\
 		IE_RSN_AKM_SUITE_SAE_SHA256 |				\
-		IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)			\
-)
+		IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)
 
-#define AKM_IS_8021X(akm) \
-(									\
-	akm & (IE_RSN_AKM_SUITE_8021X |					\
+#define AKMS_8021X \
+	(IE_RSN_AKM_SUITE_8021X |					\
 		IE_RSN_AKM_SUITE_8021X_SHA256 |				\
 		IE_RSN_AKM_SUITE_FT_OVER_8021X |			\
 		IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384 |			\
@@ -83,8 +82,11 @@ bool security_from_str(const char *str, enum security *security)
 		IE_RSN_AKM_SUITE_FILS_SHA384 |				\
 		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |			\
 		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |			\
-		IE_RSN_AKM_SUITE_OSEN)					\
-)
+		IE_RSN_AKM_SUITE_OSEN)
+
+#define AKM_IS_PSK(akm) (akm & AKMS_PSK)
+
+#define AKM_IS_8021X(akm) (akm & AKMS_8021X)
 
 enum security security_determine(uint16_t bss_capability,
 					const struct ie_rsn_info *info)
@@ -103,3 +105,22 @@ enum security security_determine(uint16_t bss_capability,
 
 	return SECURITY_NONE;
 }
+
+/* Returns all possible AKMs (as bitmask) for a given security type */
+uint32_t security_to_akms(enum security security)
+{
+	switch (security) {
+	case SECURITY_WEP:
+		l_warn("WEP security type not supported");
+		/* Fall through */
+	case SECURITY_NONE:
+		return 0;
+	case SECURITY_PSK:
+		return AKMS_PSK;
+	case SECURITY_8021X:
+		return AKMS_8021X;
+	default:
+		l_warn("Unhandled security type: %u", security);
+		return 0;
+	}
+}
diff --git a/src/common.h b/src/common.h
index ca12d813..7e877299 100644
--- a/src/common.h
+++ b/src/common.h
@@ -36,3 +36,4 @@ const char *security_to_str(enum security security);
 bool security_from_str(const char *str, enum security *security);
 enum security security_determine(uint16_t bss_capability,
 					const struct ie_rsn_info *info);
+uint32_t security_to_akms(enum security security);
\ No newline at end of file
-- 
2.34.1

