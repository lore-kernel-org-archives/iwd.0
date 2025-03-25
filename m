Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81228263F4E
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925663; cv=none; b=TnUNbj80xjBrBvyaAP/kStnF4W+K2Hsk21uakjHQzr7pW2bX7BYSlbJ5ppe0UIUhDqhp6taVksdpUHKK0v2ICWAjKKxqFHgD+fwKSP4h4r96PpP1ZQkMtw4J2pJgStpcTDMQLYOi8f90BaVCX2BveJr1ejiyOh4Jw2CZh/ngu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925663; c=relaxed/simple;
	bh=UTWSdGV7N/nqbDQ89jLPU5TtZCOHjphPYWtLZIOGDZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFtayc9ex/9N0PFVbDBhJMO1bqVAliedcv5aGLdKe6/mox7LxTlmoAyumP4571HWnCoHd+/yHbNQmaKXEMhuguLwKAXUmsLqhqwFORZqhqs+6oRpaFKy/31tKsxTX2FGWPeCZX6EuiMCmVQmCZlj2Zx1Vqd7llKt1Enbccw/Wqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhKo16nU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhKo16nU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fd89d036so123028445ad.1
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925660; x=1743530460; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WgcEy3egH4EODY2iMZiNLVsCjOejr9DCG+RV+YGYTs=;
        b=LhKo16nU/7dku5jdA5ncyxJPY5aI1f+PmShMMldNhEP3l0b5hCyS3v8ajZu84nQvs7
         faIpG9WZxve9a+obZsWu6oFTtOtSFdVdbxCBVZ9VWuyLUHbwmanIA4oHc0KiBuuYKyLU
         bvko+oJC6MGhUVuYFhj/Or7WuR1V3CHiFFUOf5EOhfo9mT1Js3dbgaCP+Sf1aRkkb6/B
         Jbg71EODEcEv2VkTeTzysAtR0ahUATkPqoy7V6U69a5A9qqT3tx1FqtFasccAImX1q2E
         rJgWwtTpUvnehzOYovYbaO/tsnqQTjUB8x0lxDRteJaTaGPWmFgkt1w92Bll95fp5ZTE
         Ekeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925660; x=1743530460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WgcEy3egH4EODY2iMZiNLVsCjOejr9DCG+RV+YGYTs=;
        b=J630trDulvo7XnBy3pNcMlRH3KnxSy/Iux6j0xE4+nK/5ig+SkIUBddKUIi/4U8H+Q
         MCc1JR8OVqbtl7Xw7T/Us8gEyYVD2eMJA7k/7byRr+fdNTq/y8bbaMyepuvNPgbkLJ25
         64FLWE10qIkwlasUfarqZHrJyt6d7fUG6b2PTnFN6PBtNTVHAPWpuuA9G3aHO3jV9JSE
         oSpfi+kztW6DqV8GORa7G83bAWx/Crxu6ujIMLAga2EgGPQ1m1NfR2l3x11Sp3a71sLf
         cGQV5Grk5QxwfRgahX0Gkpq+eejgPFZuDuNSJ75sxHhEkoJKAx4Nfiz7w3WtEPDiQG86
         Yelw==
X-Gm-Message-State: AOJu0Yz18FSIne7rm7fwLE7V3yzve92qRS8iybeSWGXEgfeEM081mTw6
	9iLTXOumzwHSENA/jpOdfr4/szF2lLo53ku8JZ+y0xfk4BiveN+aIdRkXw==
X-Gm-Gg: ASbGncvXno/WW7ukSLhMPF1pctca5tJzqGwqy9Mo2bdHRXYTB/KxY/CjezM5Onbhkvq
	UwIZpzGqEabRPUApFISnXvSk4GB8mT1IOEtS5MiQDjYtHKp4dHB+u+b++pKGkIoOf/DWoMi30BI
	FPhVijcrUEKLWLAKW8fN+ShKkuY127k96WpL6MRaM8ycMMj1JSxC6E05RSYgS8IOldT6m6afV/x
	XdEWenKCmcsVZF+JTNQwfrjJICfzSXk9ZW+VovM7QChXskQQVqY9W3POsZgtsH/yw1MxLL3b3J/
	k9xeGkaGG0h2NZqX8eAfTU7angGeVuqVO/oJycNU03iGE7MAJxdpUcZS20Wn0opfUgEpENN6EJ4
	LM9Q=
X-Google-Smtp-Source: AGHT+IF/JYJwLGusBZE6ZQiCZUMiBd7LpwUI0ywF3NdwmlzQTjlPM3x1BEfexTaKkK0dDsPT9DRjQQ==
X-Received: by 2002:a17:902:e886:b0:227:eb61:34b8 with SMTP id d9443c01a7336-227eb615177mr24791115ad.25.1742925660247;
        Tue, 25 Mar 2025 11:01:00 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:00:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 05/10] blacklist: add new blacklist reason, ROAM_REQUESTED
Date: Tue, 25 Mar 2025 11:00:36 -0700
Message-Id: <20250325180041.238676-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325180041.238676-1-prestwoj@gmail.com>
References: <20250325180041.238676-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new (less severe) blacklist reason as well as an option
to configure the timeout. This blacklist reason will be used in cases
where a BSS has requested IWD roam elsewhere. At that time a new
blacklist entry will be added which will be used along with some
other criteria to determine if IWD should connect/roam to that BSS
again.

Now that we have multiple blacklist reasons there may be situations
where a blacklist entry already exists but with a different reason.
This is going to be handled by the reason severity. Since we have
just two reasons we will treat a connection failure as most severe
and a roam requested as less severe. This leaves us with two
possible situations:

1. BSS is roam blacklisted, then gets connection blacklisted:
   The reason will be "promoted" to connection blacklisted.

2. BSS is connection blacklisted, then gets roam blacklisted:
   The blacklist request will be ignored
---
 src/blacklist.c | 27 +++++++++++++++++++++++++--
 src/blacklist.h |  7 +++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/src/blacklist.c b/src/blacklist.c
index 2539c5e0..98713095 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -45,6 +45,7 @@
 
 static uint64_t blacklist_multiplier;
 static uint64_t blacklist_initial_timeout;
+static uint64_t blacklist_roam_initial_timeout;
 static uint64_t blacklist_max_timeout;
 
 struct blacklist_entry {
@@ -66,6 +67,8 @@ static uint64_t get_reason_timeout(enum blacklist_reason reason)
 	switch (reason) {
 	case BLACKLIST_REASON_CONNECT_FAILED:
 		return blacklist_initial_timeout;
+	case BLACKLIST_REASON_ROAM_REQUESTED:
+		return blacklist_roam_initial_timeout;
 	default:
 		l_warn("Unhandled blacklist reason: %u", reason);
 		return 0;
@@ -132,8 +135,20 @@ void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason)
 	entry = l_queue_find(blacklist, match_addr, addr);
 
 	if (entry) {
-		uint64_t offset = l_time_diff(entry->added_time,
-							entry->expire_time);
+		uint64_t offset;
+
+		if (reason < entry->reason) {
+			l_debug("Promoting "MAC" blacklist to reason %u",
+					MAC_STR(addr), reason);
+			entry->reason = reason;
+		} else if (reason > entry->reason) {
+			l_debug("Ignoring blacklist extension of "MAC", "
+				"current blacklist status is more severe!",
+				MAC_STR(addr));
+			return;
+		}
+
+		offset = l_time_diff(entry->added_time, entry->expire_time);
 
 		offset *= blacklist_multiplier;
 
@@ -196,6 +211,14 @@ static int blacklist_init(void)
 	/* For easier user configuration the timeout values are in seconds */
 	blacklist_initial_timeout *= L_USEC_PER_SEC;
 
+	if (!l_settings_get_uint64(config, "Blacklist",
+					"InitialRoamRequestedTimeout",
+					&blacklist_roam_initial_timeout))
+		blacklist_roam_initial_timeout = BLACKLIST_DEFAULT_TIMEOUT;
+
+	/* For easier user configuration the timeout values are in seconds */
+	blacklist_roam_initial_timeout *= L_USEC_PER_SEC;
+
 	if (!l_settings_get_uint64(config, "Blacklist",
 					"Multiplier",
 					&blacklist_multiplier))
diff --git a/src/blacklist.h b/src/blacklist.h
index a87e5eca..f5c899e0 100644
--- a/src/blacklist.h
+++ b/src/blacklist.h
@@ -26,6 +26,13 @@ enum blacklist_reason {
 	 * connect to it via autoconnect
 	 */
 	BLACKLIST_REASON_CONNECT_FAILED,
+	/*
+	 * This type of blacklist is added when a BSS requests IWD roams
+	 * elsewhere. This is to aid in preventing IWD from roaming/connecting
+	 * back to that BSS in the future unless there are no other "good"
+	 * candidates to connect to.
+	 */
+	BLACKLIST_REASON_ROAM_REQUESTED,
 };
 
 void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason);
-- 
2.34.1

