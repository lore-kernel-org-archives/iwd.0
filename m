Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D238A715
	for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943534; cv=none; b=QsZnmAZ6KG7UNP6vYSGVXwUsaOqd6MA4Q0XUFTgl6q4caGr0kY2mmux+IMABORMta1ZLXGYGijMYmB7DG2/Zwz6tITKzTDluJfWqPQ9Z6DdxdepVkD0Up8whBqB8lY4BSYMwpzoQNwpolG5gpjKWxz6alYAMdhSrheJsqBqIDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943534; c=relaxed/simple;
	bh=YSBKoObZZBsrXtXohGa4lqEchLgzWKqq5lJKU9AKYnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twbQPPxzE0pCVTs5VHd2NPgNp+tHHN1FWZjsO0JBSH1Z+7OuuPGpYkuzYcj2VDV6udrpbP8oRvKnIBCdjjQC7qo/xl9ONcUE1QYSVKCfaFmuoLt5Vj+pnXJdnwlavimftXpGJqpVizqN15YZNc6kvENXCz49EHyn1eEe7SKjr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il98TJ0F; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il98TJ0F"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so851583b3a.1
        for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943532; x=1774548332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZojWFuszy16iwOlWgaUJ2xcA+DM5HiPICrhgDj7pno=;
        b=il98TJ0FMV4pos3O375z60OtWsk63EWq6sPHKn3knthco+aWn2pNv1x/jcl4R5kff/
         uGbviCCta8aN963WX+2eMtMXLj/aPfuaSDk37qmJTACcTligH8mhi0K/9xh/m31oMhJc
         8RqvkJgpU0BVAi66oLfF5Lwm6HeaKr3z/KKh/vv4XGfo3FefOwWmF2l9z23kkk3gSvXT
         qNYRXmnvK2UVSkZftW1l5wx/+tMo9HBhWWb7mY/pm+J5afsAvAdoT53RMIipeadSMiCq
         kfFYsIyaeRpcG+BbPXXGTkIZ4C1Tzbq4Ann1BcfA+JBLBy1lvTy6flaI7yFp3wouJAoe
         JITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943532; x=1774548332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vZojWFuszy16iwOlWgaUJ2xcA+DM5HiPICrhgDj7pno=;
        b=XAKAciGfBh3er/wGqEozFz2d510oEZxfH/YgiN5fHJ/rtEebFf8uXZ++RhTg3iYfY1
         D+paVLCet9uM/ZPbwyCFqKL1JS4oJa0H8h0C/gktLXPCp4ALrSxYtTVfUIc8bIlHGVq6
         igAdCgHMiCNh47q7AsWD0lAV+PTdd/Z9QmmRCl2UQIVLi+3VSzZlLVj4/B24ErQhW6T8
         cfjp4nOCOTPhmYLiSg5HxSlr2URfwk4OFiHaBfNcMRIHNbx4HKIgbeiwiBln77ZTQtUD
         4w3cEMJzUXF7R2RQRh8KGOKcQw2H1n1TVeb8iH2kbGlv/SOPnB1wRSmjB4HtAzYfjpLH
         wwtQ==
X-Gm-Message-State: AOJu0Yy7dwhZkJpD7DYoB+ixTdruSZxRBg/LOzO/cBWmsUNlmj2Xjolv
	65IL/sA+pKXcJdyxSUr6B1q/CoqvceaG1epViNG3+ulvc2poC7ZVYN5LwukkVg==
X-Gm-Gg: ATEYQzyMxYJIhuYGyKgd2vDJc/k1nxiGaKQ+qQujDrsg5HgBzX4tn7ebJoolL/HV91g
	j5ZGi/g13tKx6JdGOQdPQ6ouRWV6FfgEk3T5rw44ANbbAx6qpjFRZMstjmlE2P6rnVsD9f/qclM
	QxywadPXflha3DUZP7BWFpNF8+ULuJJZTtiftGOZvaqe2Owb4lwCSK6QbRp/UpDRkUU9wS/3ogj
	Hky8i1Yt6aRaNwsWOHdaDtlfLvRnvW24RxYeYaT5mDblwDTkfoUjhusMMInkG9SAj+CXEU0uLjr
	Iibt4MgaByFG6vd5o2pTPRrLkkg7cPr6bjF0OLEg8ZwIyo/Kr3Xg6kBdiNOZjJluIbyxO5G09Wp
	09ifWNBa9SSrcPnb91sc5WgfmbHeX42lyaCTAx4W1GvNkYQERNXmD8U7gp0By108BtLCJ4NrleI
	Ae9bLisZDuS8YHyTiko6cPnuzVLdKxCD8roNec9zEoiBSEHAphpKswt7rSz2zpibZ9p4u9TOGsD
	j0=
X-Received: by 2002:a05:6a21:338e:b0:398:9ae9:7112 with SMTP id adf61e73a8af0-39bce9b7eb0mr293952637.1.1773943531861;
        Thu, 19 Mar 2026 11:05:31 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b541cafsm6699251b3a.12.2026.03.19.11.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:05:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] pmksa: add pmksa_cache_flush_ssid
Date: Thu, 19 Mar 2026 11:05:23 -0700
Message-Id: <20260319180525.136095-2-prestwoj@gmail.com>
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

Adds a new flushing method to remove all PMKSA entries for a given
SSID.
---
 src/pmksa.c | 27 +++++++++++++++++++++++++++
 src/pmksa.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/src/pmksa.c b/src/pmksa.c
index a50c8208..9b02d7e4 100644
--- a/src/pmksa.c
+++ b/src/pmksa.c
@@ -213,6 +213,33 @@ int pmksa_cache_flush(void)
 	return 0;
 }
 
+/*
+ * Flushes all PMKSA entries that match an SSID
+ */
+int pmksa_cache_flush_ssid(const char ssid[static 32])
+{
+	int i;
+	int used = cache.used;
+	int remaining = 0;
+
+	for (i = 0; i < used; i++) {
+		if (!memcmp(ssid, cache.data[i]->ssid, cache.data[i]->ssid_len)) {
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
index 6a624504..946ef0b2 100644
--- a/src/pmksa.h
+++ b/src/pmksa.h
@@ -45,6 +45,7 @@ struct pmksa *pmksa_cache_get(const uint8_t spa[static 6],
 int pmksa_cache_put(struct pmksa *pmksa);
 int pmksa_cache_expire(uint64_t cutoff);
 int pmksa_cache_flush(void);
+int pmksa_cache_flush_ssid(const char ssid[static 32]);
 int pmksa_cache_free(struct pmksa *pmksa);
 
 uint64_t pmksa_lifetime(void);
-- 
2.34.1

