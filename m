Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37DA1E378C
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642882; cv=none; b=EZwlXrlqRmEEgJN79PH9wbm/2ifupAvg6k3SyEdbs13BalYUXWuCMWBwX/1A0PaUg/XZ/qSomA17H7nyRgYviH/nDSyDfNpXFgGZhD/3DBRIkDBQmkmXSsGhQtLRBPQ8s3+RxnHiAmLdkSyzHzTIWiL7+x6NXYR+SJkKv0hN4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642882; c=relaxed/simple;
	bh=qP4Pn+/RcHhTltFTDAx0815WcMG9CbxDW03yuCc0fGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4DSltWKrXi9dQ/eLk20s6iVpnFz/MguqHPpqlQS+/1nzcsc1YunKTrTsmU+8sxu7PWdV5LgsJy5b6Q02yUW5yMDm1ujfNYy28uwJGXpjEcQRaMjJuPWes7aobeQlLVB++xwl2gQiLURmulDGwNUZv1wxf1//2CLfxNJjDhBgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUeQMF4u; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUeQMF4u"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-474f0c1e1c6so55079721cf.1
        for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642880; x=1742247680; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIc8rPcrNtR6O/5fFmMP+J568N4+MXOB1YbviJJpRkM=;
        b=lUeQMF4u7vlB7ACs3iAf6DGQFu9KySm3Z3gQNYs24UsnMxBvhpeDf7lJknAAVz02tZ
         pWwOQDePnPQ2cbG3KqWHhBvMCXd1Ub75RP/fu/CzgRgN58FyoIv241ybCpgAJ3KOhdKV
         5l3z31/KLd07URS0UxzrqW6mTOURpgzV0q/svjVEuJOLHe66Z0YJURVZJJepXHT7kVVN
         j/J2qmljP8WPZzClQjDSEH07jiKI3sFKrYnTKhToS2SUeTHgj7Xaa/9wiP9h23clNCCp
         iApCmahJJe2pOUkw92VPoQxBLBfWEOkOXJY3rwXvzIe8LWWHolusWR6j693V9/L+0wzx
         LDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642880; x=1742247680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIc8rPcrNtR6O/5fFmMP+J568N4+MXOB1YbviJJpRkM=;
        b=tOMFHB8SFbe1bXsv1JWo7O8nZ7cEPW/1mnoufeZTcWeOxbpQ54i37DoqvTjdyuQq2X
         KkvxZpPbiB6D632m6bITbuRifQTSoBuQazkb55PAXHfD1s2hdM/vJ1U0m+YWS3cCT4Ia
         edgYWD0puFoLT3+Oh8oeyBl/NOCpo2oC4BhbBdfPQmhnjCI3Dh05Lf9RW2dE8+vVfH4t
         +G+iqF5qHAZY2vhs9njHlwT/frbotJWRDWkZUFZLxoBIP8iMeljLEuGBO54QT7vkHRIB
         OUifQMavmvmv2YeHMtgly7b822Vz0e9Iqs9q/LjHJ1L+yHdcCx/3kkWlEW+m5X1kyi4w
         N8RQ==
X-Gm-Message-State: AOJu0Yw8QhR9HbSTGpwbcIYYlHQMsYfSq1U5YTBovz8Td/A3KJXIG+N2
	WFy0yKmEQCtRSw7jnjjkaDKXSiXqai5H2SqP25FdmfQ3UzzrudqUle4fSg==
X-Gm-Gg: ASbGncvjsdkhnu2xnFrCQUwoZDNw/eEkt4rnf/3w9pcTdQKvGdvc19AgGnpyckhMQGe
	emRxDWj/YX02bw4wN1m1DFMfXI6XBVy/a+KjBHdOoZ1XZBqccXHEuLkhFA5t9XpRTcEFPwb+xzp
	gPj6lrVCWOpC9vC+f5n87pCeGDK3Fs60MxJlC0MueCjYH+x4HTsVtAzUK12JgpQJxujy0tZurUe
	u7O2axhlVlnnAkJpHM8CN5kMjZL8N0/TroCNL57Z+Kqy0bpqM96+q04tyoPVXMW0+JBL9hDhTM5
	XsP7kJX2sVKNx1YaG77w1HyH24I3EN0XajtfwvrjeyEI1LyGOEcTY2z5U0F3cmfWIU2QTK9bWXQ
	iSUA=
X-Google-Smtp-Source: AGHT+IG6BTR5hFUgU3JYHDejT/cUbhsN3Vk9LzUkdZcPNxE+GLjrAEFPv9HQEQ51ZrIn6HTThjO7+A==
X-Received: by 2002:ac8:5714:0:b0:476:8c58:4f68 with SMTP id d75a77b69052e-4768c585117mr70444391cf.2.1741642879612;
        Mon, 10 Mar 2025 14:41:19 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476772de5absm30487841cf.66.2025.03.10.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:41:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] scan: Introduce higher level scan BSS groups
Date: Mon, 10 Mar 2025 14:40:57 -0700
Message-Id: <20250310214059.20809-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310214059.20809-1-prestwoj@gmail.com>
References: <20250310214059.20809-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces a higher level grouping to BSS's to improve sorting
as opposed to purely rank based sorting. The reason for this is to
handle roam request-based blacklisting where we want to encourage
IWD to avoid BSS's that have requested we roam elsewhere, but also
not fully ban these BSS's (i.e. BLACKLIST_REASON_PERMANENT).

This new concept introduces 4 group types, in order of worse to
best:
 - Blacklisted - the BSS has a permanent timeout blacklist
 - Under threshold - the BSS is under the set RSSI threshold
 - Above threshold - the BSS is above the set RSSI threshold
 - Optimal - The BSS is not "roam blacklisted" and is above the
             set RSSI threshold.

When sorting the BSS group will be considered before rank. This
means we will still prefer roam blacklisted BSS's above those that
are under the set RSSI threshold. BSS's within the same group are
still compared by their rank/signal.

The new group sorting logic was added via a macro
__scan_bss_rank_compare. This was done since station uses a separate
roam_bss structure to sort roam candidates which can also take
advantage of this new sorting. The macro is agnostic to the type as
long as the structure member names match.
---
 src/scan.c | 42 +++++++++++++++++++++++++++++++++++++-----
 src/scan.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index aeab6516..2787028d 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -51,6 +51,7 @@
 #include "src/mpdu.h"
 #include "src/band.h"
 #include "src/scan.h"
+#include "src/blacklist.h"
 
 /* User configurable options */
 static double RANK_2G_FACTOR;
@@ -58,6 +59,7 @@ static double RANK_5G_FACTOR;
 static double RANK_6G_FACTOR;
 static uint32_t RANK_HIGH_UTILIZATION;
 static uint32_t RANK_HIGH_STATION_COUNT;
+static int RANK_OPTIMAL_SIGNAL_THRESHOLD;
 static uint32_t SCAN_MAX_INTERVAL;
 static uint32_t SCAN_INIT_INTERVAL;
 
@@ -1910,15 +1912,41 @@ int scan_bss_get_security(const struct scan_bss *bss, enum security *security)
 	return 0;
 }
 
+/*
+ * Evaluate the BSS's grouping based on its signal strength and blacklist
+ * status. From best to worst the groupings are:
+ *
+ * Optimal: Not blacklisted in any form, and above the RSSI threshold
+ * Above Threshold: Above the RSSI threshold (may be roam blacklisted)
+ * Below Threshold: Below the RSSI threshold (may be roam blacklisted)
+ * Blacklisted: Permanently blacklisted
+ */
+enum scan_bss_group scan_bss_evaluate_group(const uint8_t *addr,
+						int16_t signal_strength)
+{
+	int rssi = signal_strength / 100;
+
+	if (RANK_OPTIMAL_SIGNAL_THRESHOLD == 0)
+		return SCAN_BSS_GROUP_OPTIMAL;
+
+	if (blacklist_contains_bss(addr, BLACKLIST_REASON_PERMANENT))
+		return SCAN_BSS_GROUP_BLACKLISTED;
+
+	if (!blacklist_contains_bss(addr, BLACKLIST_REASON_ROAM_REQUESTED) &&
+			rssi >= RANK_OPTIMAL_SIGNAL_THRESHOLD)
+		return SCAN_BSS_GROUP_OPTIMAL;
+
+	if (rssi >= RANK_OPTIMAL_SIGNAL_THRESHOLD)
+		return SCAN_BSS_GROUP_ABOVE_THRESHOLD;
+
+	return SCAN_BSS_GROUP_UNDER_THRESHOLD;
+}
+
 int scan_bss_rank_compare(const void *a, const void *b, void *user_data)
 {
 	const struct scan_bss *new_bss = a, *bss = b;
 
-	if (bss->rank == new_bss->rank)
-		return (bss->signal_strength >
-					new_bss->signal_strength) ? 1 : -1;
-
-	return (bss->rank > new_bss->rank) ? 1 : -1;
+	return __scan_bss_rank_compare(new_bss, bss);
 }
 
 static bool scan_survey_get_snr(struct scan_results *results,
@@ -2678,6 +2706,10 @@ static int scan_init(void)
 	if (L_WARN_ON(RANK_HIGH_STATION_COUNT > 255))
 		RANK_HIGH_STATION_COUNT = 255;
 
+	if (!l_settings_get_int(config, "Rank", "OptimalSignalThreshold",
+					&RANK_OPTIMAL_SIGNAL_THRESHOLD))
+		RANK_OPTIMAL_SIGNAL_THRESHOLD = 0;
+
 	return 0;
 }
 
diff --git a/src/scan.h b/src/scan.h
index 4c1ebc21..4d06f29d 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -45,6 +45,17 @@ enum scan_bss_frame_type {
 	SCAN_BSS_BEACON,
 };
 
+/*
+ * Groupings for BSS's. These are assumed to be in order of preference where
+ * the last enum is the most preferred group to connect to.
+ */
+enum scan_bss_group {
+	SCAN_BSS_GROUP_BLACKLISTED,
+	SCAN_BSS_GROUP_UNDER_THRESHOLD,
+	SCAN_BSS_GROUP_ABOVE_THRESHOLD,
+	SCAN_BSS_GROUP_OPTIMAL,
+};
+
 struct scan_bss {
 	uint8_t addr[6];
 	uint32_t frequency;
@@ -168,6 +179,36 @@ bool scan_get_firmware_scan(uint64_t wdev_id, scan_notify_func_t notify,
 				void *userdata, scan_destroy_func_t destroy);
 
 void scan_bss_free(struct scan_bss *bss);
+
+enum scan_bss_group scan_bss_evaluate_group(const uint8_t *addr,
+						int16_t signal_strength);
+
+/*
+ * Macro to compare two scan_bss-like objects. This is to share code between
+ * station.c and scan.c since station uses "roam_bss" objects which is a subset
+ * of a scan_bss.
+ *  - If the groups differ this is used as the comparison.
+ *  - If the groups match, the BSS rank is used as the comparison
+ *  - If the BSS ranks match, the signal strength is used as the comparison
+ */
+#define __scan_bss_rank_compare(a, b) ({			\
+	int ret;						\
+	enum scan_bss_group a_group = scan_bss_evaluate_group(	\
+			(a)->addr, (a)->signal_strength);	\
+	enum scan_bss_group b_group = scan_bss_evaluate_group(	\
+			(b)->addr, (b)->signal_strength);	\
+	if (b_group > a_group)					\
+		ret = 1;					\
+	else if (b_group < a_group)				\
+		ret = -1;					\
+	else if ((b)->rank == (a)->rank)			\
+		ret = ((b)->signal_strength > 			\
+				(a)->signal_strength) ? 1 : -1;	\
+	else							\
+		ret = ((b)->rank > (a)->rank) ? 1 : -1;		\
+	ret;							\
+})
+
 int scan_bss_rank_compare(const void *a, const void *b, void *user);
 
 int scan_bss_get_rsn_info(const struct scan_bss *bss, struct ie_rsn_info *info);
-- 
2.34.1

