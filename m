Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C81C3029
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172991; cv=none; b=AMtn0XXhL4ZeWi8aWQvF/h0oojq8Asldou+sunNEJk5p0Dn8Q2OvxN6GSOqzFL46ZZ4ubWitu10BML7famMqy9cIsS/2U1vWdg54DddrKTWJ3ZDmhozML8H0xR5METFboX2Qz/a9kKXZwNbQTQgHZg9wjjOX2+qqx4fiDee208w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172991; c=relaxed/simple;
	bh=KuBb42mY9W8+cAGTQNXTbMSo9nwRnjwS45nS9d1KbIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtfBeQ3SnmEhfZI7v7kgE4Kx54ia5OjjO4I/V2OlRne2cqgFK1TsKu1jCk8FDNb8UnZpMuuCsD7IDyJGBtSgMWKQ643aHIBJcexlVPsPP5Y2N8mRBDN2f1DRkIkbssx2cJqVoGrH7/lZbKo0bi9Uxt+wBiO0zZiQsC3XmSds73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsDECINN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsDECINN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22580c9ee0aso48535775ad.2
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172989; x=1743777789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6OFv33F9hJCMlIs0vWDsTk16n+VMM7hXx9e3QcbRIM=;
        b=PsDECINNiuEJOdDjT+yFVTEo7cwLvjCnCRMq1ogLujRKZ4/Jw1XF89ojAvuBhYzXdz
         0NoYn4AdqfMxJKAyerCWeKRP2URhywWrJdaVxotjI5qvw/DxPLp+zvcb/Kv2HQHGbkAa
         0oZdk6JqS7BEq9465cH2NrCk8Kk+kwerk+Fmev7W15HZRdUbdn131ypT9D8Ed1XlI1e/
         KEG7ZihHFgKxZzdmO9/4yEaYOKOrYPvLRlwjfWiJ8VGixp8iNU5qZSEMoYIqmx6AvFgO
         rCXX5yd7cpitrlvZbwNZP+DFOok/o27kuI5jh3/6UcrJZu5/VYm9Y/+XXFFm7lCcFRej
         5msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172989; x=1743777789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6OFv33F9hJCMlIs0vWDsTk16n+VMM7hXx9e3QcbRIM=;
        b=iigBmViSwJVbUn3oqpgjL/8KHNbePFmQgCq4Z03Zpvt4Gz0d+OLPtBENHssiEPlZP1
         z/KGy/gNayj4m5r3Z3RQuJWMHWJHgDEVdZwREMUTrHFdM7MpN26A5dD4anaQT3oDnTs6
         R8cdBf7aHx6tjZ3slxbCtYSfYbUdSMRsHB48Uia5F9gSiX8GuTlhLwUxegItb+ph40k3
         oWm2kRIPkHJxWlXUWXkIbMWgFYiFEWTKtWhCXasl2FFK50bjGDy8Q9VpcKqCLhCIeMfJ
         HREvlOzahVQUE5XnIdSgd/y7gdKE9CtPY4mO/pW3L+0SHJP5WPTrtX9GSfKnRjvGil+f
         +j/w==
X-Gm-Message-State: AOJu0YyHoxjjc8M+mmDpvSiawxyon9eAO9GzjCWtTZz1qUGCHshykHVH
	CkqJM7UkIc7AOfxhQ2LoUQ1mu2g7RYwstM77Dxt89tkXVzVeX58855koHg==
X-Gm-Gg: ASbGncuLr9zY5PfY/jdO+jUz8fRAjKvzSg3ECZbp7CF/gZmtcJB92cckPEoMM5dIncG
	/L7wefUOZeJ0XMUbJYGrmYnUTuG0gEGg70ZwAw2CjORrqYx7cs/fCcwXf/Yd6+/7TNLGFEgKwmD
	Xezv4n74XNkxJMBjRCFmOifA3tIaaX1NysO7aLMIQCTWz8ueZhZW9xzjSloylgqg3lxXiMg67nv
	sGnHnvmLKGEVmPD2Zp10Z4aUFHhDdnhZAO59VzN37mG43N+HCjnGwbbKW0c01pLlmzktOL0yNUS
	bmjR6xXc1qH/4mPh4XV0sJ7N1o3Y9Hyb4Z6SNTJ2fzpi19TmshNBXuPt4uBcXPugLPhGGZXXLVZ
	5KSXUWKiexg==
X-Google-Smtp-Source: AGHT+IFFMi6XaGnHvXxFO01S1Wavb12gImmSle2QeIIceRe7M2vWOcnMkoNizuEJMTwVQWJ88SZneQ==
X-Received: by 2002:a17:903:3c44:b0:223:325c:89de with SMTP id d9443c01a7336-2280481cd01mr133183215ad.1.1743172988360;
        Fri, 28 Mar 2025 07:43:08 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 05/11] blacklist: add new blacklist reason, ROAM_REQUESTED
Date: Fri, 28 Mar 2025 07:42:47 -0700
Message-Id: <20250328144253.421425-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
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
 src/blacklist.c | 32 ++++++++++++++++++++++++++++++--
 src/blacklist.h |  7 +++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/src/blacklist.c b/src/blacklist.c
index 2539c5e0..4250618b 100644
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
@@ -132,8 +135,25 @@ void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason)
 	entry = l_queue_find(blacklist, match_addr, addr);
 
 	if (entry) {
-		uint64_t offset = l_time_diff(entry->added_time,
-							entry->expire_time);
+		uint64_t offset;
+
+		if (reason < entry->reason) {
+			l_debug("Promoting "MAC" blacklist to reason %u",
+					MAC_STR(addr), reason);
+			/* Reset this to the new timeout and reason */
+			entry->reason = reason;
+			entry->added_time = l_time_now();
+			entry->expire_time = l_time_offset(entry->added_time,
+								timeout);
+			return;
+		} else if (reason > entry->reason) {
+			l_debug("Ignoring blacklist extension of "MAC", "
+				"current blacklist status is more severe!",
+				MAC_STR(addr));
+			return;
+		}
+
+		offset = l_time_diff(entry->added_time, entry->expire_time);
 
 		offset *= blacklist_multiplier;
 
@@ -196,6 +216,14 @@ static int blacklist_init(void)
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

