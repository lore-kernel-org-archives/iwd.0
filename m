Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8D2DB7BD
	for <iwd@lists.linux.dev>; Tue, 24 Mar 2026 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380059; cv=none; b=E0lu+PpxTZIRXldk3ayJ+pOjm+rUEvxJZwCQnmOoS/4N9eJ9PcwtkPhoHUHE3u0OcYdqSst6suCko1YafQn1loWPBmczqjOsr1ce2Gz6O3RjQWRR8jCyUOFasHy3ngyQQGYjiCS38O/J0Eop144M0QjwtnjFzrEJhaLVnhyDqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380059; c=relaxed/simple;
	bh=nf9lEsT74M1uW/H4bkNjV3/e1LS1woGVci0IVzua3/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uHDi6wucoQnqo/AAmwKAepOTLB0GpLN3LJoiHFWezVoafsMtizznHmJEmdQKSrPJe/kREMlu0qJqzQsJsYjeXyPBFa03D/0+yZL90SQuPt7MnhPOlI77/aUEeR4QdqsyTUJ9RgpXDJOZPeQbb1deDPQ+mfzT861VPrg5EV4C6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDAGXFWB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDAGXFWB"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82c2239140aso1608368b3a.0
        for <iwd@lists.linux.dev>; Tue, 24 Mar 2026 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380057; x=1774984857; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKWh3E4yW4BaApzpH64ZMim/XobyUPbSEyHeo7JDcFM=;
        b=KDAGXFWB0WqPZTUDMa5jgkiBHVvlixm8kTzMWdOk2PBFqfJRp2nGEiFwzzPTv1eMTG
         ka98nOiGt1X3Z/d5nkkORIQWRX9PmCsY0h98AanelDq33ZOi9YEDgvoj+BSIj8ciQaqw
         2ecrLujk47vG68HblearktW5LhlaC7G/5SSKZMIMPbAId9h4rsBm2wqsp5ta6r3gvrB0
         6G17PE1KqyxaXNqMfsNcwnreTqj34HhyXVLPzSF2FzBOTjMi5paegXuqIzUPHDYxYB8s
         WGV3Y3DKBWx5ePlkfRPF5SOySAfrTJJRrR3OZ9USEJoa+Mt583afuuPZkZZwfnVNzbWy
         mFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380057; x=1774984857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKWh3E4yW4BaApzpH64ZMim/XobyUPbSEyHeo7JDcFM=;
        b=Bur/MjG2czSr4XawrpwDzlDtlAyGzAhz7G9df97FP2/aNB8TolzMWPbYq2OxzWcZvL
         t/7BiitW+twn/OF0bDtptLi8sG+1dgeWghMOY9v6MBNlBw6jAIE2yCgy3Rl89fJV4ARp
         4MsQMP7A4j/MJ8wyF+kF97DWNn+DK48wa922GXIh2oCyB/7gyTBXO1CFbcuUwI3N9iYF
         OkZDJqy+YN2JDD9fxIvTUSd/axFQ03DFI5NfBRnydIfU8wZL0qI2EolK2Z7MRnHNYIbg
         4HPM+ckA11g7V7iFtxorljvTIfSpTbrXiaui/AR90CB10P9XA6h3CgMUKhzgAq0K/qOe
         bupw==
X-Gm-Message-State: AOJu0YxKCzRb22LJs7lg19NXjKJmm9pdGMDrfwSaclC+h022a5P4qrSp
	KBGrKCZnpwUxzFqYZNySYNDapkyG2uK6wKIdjmt6GfYdgyOt+lS01z/8bla8GA==
X-Gm-Gg: ATEYQzxZ+oXbAQgvxQ8a89KE2IUmIdC5YLvpdxAEH8uqN36Bc/73AWaqrk+wAqAEY+A
	N5QgHYZFsC3H8Sveqf9bpT/uzgW2AnnUxSrgaNoJTLY/i+Yq77VhtzeKiKYkNAYIhmYURized+m
	hlrBCZwm6M6vv1diw/QRN6znsjZrnsXigHFtp/O5byi+iy09vvwklo8ssFG58SaCtJpGh7fJsOc
	BNABu78NXqOknB+Ne30H6YVavgW3nBz6UmH+4UMYXmCjuaRdhGodd8aHXorpDMOUjZlznDf6IzB
	T5r+NZ116b9XEknoukkgM6HGzQZcoLb+0/dUC0rNol7m7YG65yRFw3GDLtWmR3QjjWJ4m3F7+rp
	/k6BaZ5YPKxbq6F67g7E1dx/C5jbQ2qolAr7E+HdxTloYjD8uyhvD2m/mYsdoRS1skM6G30eKQy
	NsRf0q5ODKmldYZwAU8M5c4v5Cmkw/XQnzcCz6rUhj8q4D3/+LUtB34wfUSewRkHst
X-Received: by 2002:a05:6a20:94ca:b0:39c:787:f197 with SMTP id adf61e73a8af0-39c4ae05071mr796432637.36.1774380056734;
        Tue, 24 Mar 2026 12:20:56 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938743sm10311125a12.19.2026.03.24.12.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:20:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] pmksa: add pmksa_cache_flush_ssid
Date: Tue, 24 Mar 2026 12:20:48 -0700
Message-Id: <20260324192051.801196-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a new flushing method to remove all PMKSA entries for a given
SSID/AKM list
---
 src/pmksa.c | 30 ++++++++++++++++++++++++++++++
 src/pmksa.h |  1 +
 2 files changed, 31 insertions(+)

v2:
 * Check AKM's as well as SSID

diff --git a/src/pmksa.c b/src/pmksa.c
index a50c8208..7f37f0c7 100644
--- a/src/pmksa.c
+++ b/src/pmksa.c
@@ -213,6 +213,36 @@ int pmksa_cache_flush(void)
 	return 0;
 }
 
+/*
+ * Flushes all PMKSA entries that match an SSID
+ */
+int pmksa_cache_flush_ssid(const uint8_t *ssid, size_t ssid_len, uint32_t akms)
+{
+	int i;
+	int used = cache.used;
+	int remaining = 0;
+
+	for (i = 0; i < used; i++) {
+		/* Check that the both the AKM matches as well as the SSID */
+		if ((cache.data[i]->akm & akms) &&
+				!memcmp(ssid, cache.data[i]->ssid,
+					cache.data[i]->ssid_len)) {
+			pmksa_cache_free(cache.data[i]);
+			continue;
+		}
+
+		cache.data[remaining] = cache.data[i];
+		remaining += 1;
+	}
+
+	cache.used = remaining;
+
+	for (i = cache.used >> 1; i >= 0; i--)
+		__minheap_sift_down(cache.data, cache.used, i, &ops);
+
+	return used - remaining;
+}
+
 int pmksa_cache_free(struct pmksa *pmksa)
 {
 	if (driver_remove)
diff --git a/src/pmksa.h b/src/pmksa.h
index 6a624504..9f059a11 100644
--- a/src/pmksa.h
+++ b/src/pmksa.h
@@ -45,6 +45,7 @@ struct pmksa *pmksa_cache_get(const uint8_t spa[static 6],
 int pmksa_cache_put(struct pmksa *pmksa);
 int pmksa_cache_expire(uint64_t cutoff);
 int pmksa_cache_flush(void);
+int pmksa_cache_flush_ssid(const uint8_t *ssid, size_t ssid_len, uint32_t akms);
 int pmksa_cache_free(struct pmksa *pmksa);
 
 uint64_t pmksa_lifetime(void);
-- 
2.34.1

