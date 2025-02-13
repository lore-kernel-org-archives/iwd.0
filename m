Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F2724BC19
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477909; cv=none; b=V65VkEyNt8zhjz+28/v5PTVGiiePopfhaz90egQZ131VzdjHl2QQWUZKIaeg73gJ/IYQh/1fnWzxVYLeNox1hI28wwddZRCMnZuaxTTHl7XfbJ6fOXSnm0vrjUDRMTLKuNvsLiPkUCidjFF7fAbbnWPKcgiFmZM6EZ7lYVQRV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477909; c=relaxed/simple;
	bh=0LYcfQ+aRzf4n/L9kV2VTm5UGyYk7d9/ryiNba9lIDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBl8w7FIa3r+sBpShH5xk0KwhpHftUF2aBxW4Lvpgm7Ba7aajhQCKRO5ahB4OevaKXJ3Q4d+2aea3vbegP833Psymhp8Omkoy6K6FN2jHA5bBzOJDcQIb8rAvA5FkK2fvgIFs3plNdt9Rv+XMOLxO2l8qoW5JyZHWK2qLF5moE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMfFJ6NN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMfFJ6NN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220ca204d04so17213395ad.0
        for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 12:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477907; x=1740082707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmz4C0A5XvthaH79KKOZeUtXZsVrurUc7g/Q/cbgHnA=;
        b=LMfFJ6NNC9DXLjhcywVkwNy1xCBAj4vXOhCqXE2kMFz3NY9IbNRLEPuy7LbAxmOO8X
         LCvThQojjhcPmqzO14PEiNu6dStQA2NDFsLighgY/OfBfr+opvu6x4+4CSQ5WJsdLB4F
         RCQ8mLyrdWWlKLMAtW9S+8GiAO5Nj8bQJSoTgxaHrQgmCPP2FBh2/zj3+FwM20WZMlar
         50vjG2auz/fZuzoihHirUCQkoKpIm2H5QxzEePFFrg2m3yaaW/Z7fB4Md6yqwV8vDCrk
         N64bQck2/J2cjO/+VtOO7Z6ofda1hfm368xlLFUWj/HX41hWo4Vxi4Rl67SkOoCFDakn
         D48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477907; x=1740082707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmz4C0A5XvthaH79KKOZeUtXZsVrurUc7g/Q/cbgHnA=;
        b=bqlcX1RkB9MHK2nQG07b6I+LbcZ2boQiwyplRWuC2HtwNymA3lDO/VCeW1dWYRPIoD
         tLUsNarcm/ZopUvcG43lgTYrQmLhYQHGECZBQdwC0NFccGfBZI5TYKgIQjwb41H9Ax8f
         ef8ATZOyK4uCYNI0Xhj2Z8C4d5EEK3J7fOoPUyO0Ih+C7IRYqIu81ljAFYXF7/KTV4/X
         MOeVicxkRqNE+37qi/JIDa5BOsZ5qNbo31YO0fjgDukJquF85EZxKPAoH8NthMPkpSa9
         P9fNBOOmGWUQGHORAxnpXNd9MorEB11yb6pRdXZgk4w/6WVFsNkfrXDjymukKKZrkMJc
         pPWA==
X-Gm-Message-State: AOJu0YyUDi5Oyk7tB2YK7MNkLyDZRn/JPT+j+TCIKdqMscZ5XtkNFQj6
	3xQTS4siBXAVD/D9yAUTn5EFoUjThLnFxsPqKKWYRwaSMZwQZ7dyq31sbA==
X-Gm-Gg: ASbGnctgD04RojvguiIRpPEOLrehw06Es8+XwUBTXOO6Rfa5XYrEhihZS0J8qk1pjd5
	8BESsyepuGLZT9CSgStGSjrlMfmQ6UPVnTcbpZA05VUanh0xAEzcTuSVT5HQ7vmAMqGx9ulMCqW
	c3EC1AgKS6KAO6QP6K9jxxD1jfb87wIihg8oBwMbyWLNM8/fD33ylZkLTuy2zclHaKoOW2kFItn
	v6TrA3aY3jHEsIoNMBevWXoaLoDTTkIF/sCSvjg+/pcIHh+OaSl1E6AJ67Zh5IbOVBEikCEbdk4
	dlI1lhtkuvwxoa+NeeruB3xZSg==
X-Google-Smtp-Source: AGHT+IGliSOrXqbkDiyd/U/etgbyVW8gSFkb82ePL5hGgPjSgPs0N+45uZVRUXExFWgbzs8GtdoS2w==
X-Received: by 2002:a17:902:c942:b0:216:386e:dbc with SMTP id d9443c01a7336-220bbacbb1amr117597725ad.13.1739477906918;
        Thu, 13 Feb 2025 12:18:26 -0800 (PST)
Received: from localhost.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm16419455ad.148.2025.02.13.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:18:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/5] pmksa: add driver callbacks and pmksa_cache_free
Date: Thu, 13 Feb 2025 12:18:14 -0800
Message-Id: <20250213201816.230112-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213201816.230112-1-prestwoj@gmail.com>
References: <20250213201816.230112-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support fullmac drivers the PMKSA entries must be added
and removed from the kernel. To accomplish this a set of driver
callbacks will be added to the PMKSA module. In addition a new
pmksa_cache_free API will be added whos only purpose is to handle
the removal from the kernel.
---
 src/pmksa.c | 38 ++++++++++++++++++++++++++++++++++++--
 src/pmksa.h |  9 +++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/src/pmksa.c b/src/pmksa.c
index bb539b85..a50c8208 100644
--- a/src/pmksa.c
+++ b/src/pmksa.c
@@ -40,6 +40,9 @@
 
 static uint64_t dot11RSNAConfigPMKLifetime = 43200ULL * L_USEC_PER_SEC;
 static uint32_t pmksa_cache_capacity = 255;
+static pmksa_cache_add_func_t driver_add;
+static pmksa_cache_remove_func_t driver_remove;
+static pmksa_cache_flush_func_t driver_flush;
 
 struct min_heap {
 	struct pmksa **data;
@@ -142,7 +145,7 @@ int pmksa_cache_put(struct pmksa *pmksa)
 	l_debug("Adding entry with PMKID: "PMKID, PMKID_STR(pmksa->pmkid));
 
 	if (cache.used == cache.capacity) {
-		l_free(cache.data[0]);
+		pmksa_cache_free(cache.data[0]);
 		cache.data[0] = pmksa;
 		__minheap_sift_down(cache.data, cache.used, 0, &ops);
 		return 0;
@@ -152,6 +155,9 @@ int pmksa_cache_put(struct pmksa *pmksa)
 	__minheap_sift_up(cache.data, cache.used, &ops);
 	cache.used += 1;
 
+	if (driver_add)
+		driver_add(pmksa);
+
 	return 0;
 }
 
@@ -167,7 +173,7 @@ int pmksa_cache_expire(uint64_t cutoff)
 
 	for (i = 0; i < used; i++) {
 		if (cache.data[i]->expiration <= cutoff) {
-			l_free(cache.data[i]);
+			pmksa_cache_free(cache.data[i]);
 			continue;
 		}
 
@@ -190,11 +196,30 @@ int pmksa_cache_flush(void)
 {
 	uint32_t i;
 
+	/*
+	 * The driver flush operation is done via a single kernel API call which
+	 * is why below we use l_free instead of pmksa_cache_free as to not
+	 * induce a DEL_PMKSA kernel call for each entry.
+	 */
+	if (driver_flush)
+		driver_flush();
+
 	for (i = 0; i < cache.used; i++)
 		l_free(cache.data[i]);
 
 	memset(cache.data, 0, cache.capacity * sizeof(struct pmksa *));
 	cache.used = 0;
+
+	return 0;
+}
+
+int pmksa_cache_free(struct pmksa *pmksa)
+{
+	if (driver_remove)
+		driver_remove(pmksa);
+
+	l_free(pmksa);
+
 	return 0;
 }
 
@@ -217,6 +242,15 @@ void __pmksa_set_config(const struct l_settings *config)
 					&pmksa_cache_capacity);
 }
 
+void __pmksa_set_driver_callbacks(pmksa_cache_add_func_t add,
+					pmksa_cache_remove_func_t remove,
+					pmksa_cache_flush_func_t flush)
+{
+	driver_add = add;
+	driver_remove = remove;
+	driver_flush = flush;
+}
+
 static int pmksa_init(void)
 {
 	cache.capacity = pmksa_cache_capacity;
diff --git a/src/pmksa.h b/src/pmksa.h
index 67879309..6a624504 100644
--- a/src/pmksa.h
+++ b/src/pmksa.h
@@ -32,6 +32,10 @@ struct pmksa {
 	size_t pmk_len;
 };
 
+typedef void (*pmksa_cache_add_func_t)(const struct pmksa *pmksa);
+typedef void (*pmksa_cache_remove_func_t)(const struct pmksa *pmksa);
+typedef void (*pmksa_cache_flush_func_t)(void);
+
 struct pmksa **__pmksa_cache_get_all(uint32_t *out_n_entries);
 
 struct pmksa *pmksa_cache_get(const uint8_t spa[static 6],
@@ -41,6 +45,11 @@ struct pmksa *pmksa_cache_get(const uint8_t spa[static 6],
 int pmksa_cache_put(struct pmksa *pmksa);
 int pmksa_cache_expire(uint64_t cutoff);
 int pmksa_cache_flush(void);
+int pmksa_cache_free(struct pmksa *pmksa);
 
 uint64_t pmksa_lifetime(void);
 void __pmksa_set_config(const struct l_settings *config);
+
+void __pmksa_set_driver_callbacks(pmksa_cache_add_func_t add,
+					pmksa_cache_remove_func_t remove,
+					pmksa_cache_flush_func_t flush);
-- 
2.34.1

