Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69661DF256
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288570; cv=none; b=lOPHtJ8pA48QdSNO6m87kb+PLOupTIR6kG6GoOc7CBDXVJY1jVhIaLTjIpo0MAFBuCKP3riN27rG2anXsThnUiTAs+GsPCwF8jOYo4sy0nxeLD7TYz2QNSyicgP3XAsrekyIdl2ZeC4bdMqWJVfawG3OUms+4Z1VjQXAalyckD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288570; c=relaxed/simple;
	bh=4+jd0WaY3CCOXXrrr8nrvQWvNOU1N3FY4gtRXcAwUgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/HkLOGc0wn8Y35fWYKaJ9roWADiLo1cE7i+Zel5c1O2f4whAYXVPmRdEETPOJQd4M5ZdmM6yrpqFrDNMQfxT09E7LIhFJX3vD1khHhrOlVxNQaHgsiy+mXCsieo6d3jCccesWKDyl9iGm8NvZdIP8HnGrhLOp2hoZfY0j+lgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHK6w6DO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHK6w6DO"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d415acf76aso15817366d6.0
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288567; x=1732893367; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCiQSzxPcx5+c2otdncEyVvFElCasBr2HwAktaS1x0U=;
        b=LHK6w6DOMXYVGwTiJnJ41wA8GRghLuQ+loG6pB9eOmyl710AsoSI2EQlHcCC5PFZz8
         fv2S3P8sYs7m7GxAXSMwin0dvObLVZdUlX1OpLKaun3fGAlBAiEWJWhDJMR/xj5SFWbj
         p0A/lGX3xN7078yrcqZwUcF7NiZH+FLXHSCALQlysRwTEfFmKFVEwMWaRzUwz1CLQ/Y7
         TlZ9b4ibxvb31rGz+r36NugJnVfUODSkdXzzMWAXhTJsYNiajLWzr0shAdvlILkn05Ir
         pbc9cDGQy2KXOjWaggGVGt94Pcn0OyWkKRKligXpaapCrBZmImXmUU4jApAXVBjWJiXL
         USmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288567; x=1732893367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCiQSzxPcx5+c2otdncEyVvFElCasBr2HwAktaS1x0U=;
        b=vl+1VBEpun6gtP9FIR2C8Z26ICfdRjPHYhkc3zAass1K7r+/aXzfncVBuyCJsQuoYd
         eVCZtOdkzWlyOp2L9tiWHvIYElFORoDfE0UJxElT1nGSR1HfewrsquIrvcNReDyPAkmp
         J82SXQ2Iw2PPEhDXTJxaHJFe/QW8qyWVr27zhwU+DyS2uJPHH66en4YCI6BGDLzmkzgu
         VUJzRhl2nUakHu5qZtbbvET8xSqlDbsBHyXlmyLcU/QW9l99T/8zFfmKyE5+p9Ts4T/1
         19IR9TiMRrrvzWgBrigA7C8qTZgbxMuxA+nO7IkEHcMIezgd9qOdyHK1UZedk05cfE4o
         A9dQ==
X-Gm-Message-State: AOJu0YwMvI1FLKxrZbKoklKEGX7eiiYdDjcJN63J9eDAJaZWCPw3Tf3A
	mgqGWsofEtG6c3BB2xR9E+BxZGfMr/Gi8vPex/AI+ETomQrOIFmmqRaXmg==
X-Gm-Gg: ASbGnct+xEIDG4yPrrMo9B9O87T+nCfJtsOEsi+E/EY5Y0b8s9jqLG4Qfis1PfN8UMj
	wnTnHtlJZ0zckAv08cxRLu5waRXBMJ4gIxfEiMnp7De4OfGBOJUuGqkk2dw8FiHlBb0EPqVEdzh
	FJxXFvj0QMj3bpBXal100haJ8LW0tpwyAmuIvyWJpNCBKom+g825ODxg2kjLECrqEWUMOrAQtLh
	u9MIh0xtPey6iftBIWfrXVae5mwzzvNbqXyqxH0rmseHq1GY008zm6slPI5
X-Google-Smtp-Source: AGHT+IGQXB8yESpnzPLmWe7POURgu/O0nd0kFNNz9lWUzuMnUg6UtOcJKpUWMg7d3w4Q74b0AirbBQ==
X-Received: by 2002:ad4:4ea5:0:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6d450dd3999mr57782646d6.0.1732288567602;
        Fri, 22 Nov 2024 07:16:07 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/15] pmksa: Add debugging
Date: Fri, 22 Nov 2024 07:15:44 -0800
Message-Id: <20241122151551.286355-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

---
 src/pmksa.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/pmksa.c b/src/pmksa.c
index b2e65d17..bb539b85 100644
--- a/src/pmksa.c
+++ b/src/pmksa.c
@@ -34,6 +34,10 @@
 #include "src/module.h"
 #include "src/pmksa.h"
 
+#define PMKID "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
+#define PMKID_STR(x) x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7], \
+			x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15]
+
 static uint64_t dot11RSNAConfigPMKLifetime = 43200ULL * L_USEC_PER_SEC;
 static uint32_t pmksa_cache_capacity = 255;
 
@@ -108,6 +112,7 @@ struct pmksa *pmksa_cache_get(const uint8_t spa[static 6],
 				const uint8_t *ssid, size_t ssid_len,
 				uint32_t akm)
 {
+	struct pmksa *pmksa;
 	int r = pmksa_cache_find(spa, aa, ssid, ssid_len, akm);
 
 	if (r < 0)
@@ -121,7 +126,11 @@ struct pmksa *pmksa_cache_get(const uint8_t spa[static 6],
 	__minheap_sift_down(cache.data, cache.used, r, &ops);
 
 done:
-	return cache.data[cache.used];
+	pmksa = cache.data[cache.used];
+
+	l_debug("Returning entry with PMKID: "PMKID, PMKID_STR(pmksa->pmkid));
+
+	return pmksa;
 }
 
 /*
@@ -130,6 +139,8 @@ done:
  */
 int pmksa_cache_put(struct pmksa *pmksa)
 {
+	l_debug("Adding entry with PMKID: "PMKID, PMKID_STR(pmksa->pmkid));
+
 	if (cache.used == cache.capacity) {
 		l_free(cache.data[0]);
 		cache.data[0] = pmksa;
-- 
2.34.1

