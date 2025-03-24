Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1825E836
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825767; cv=none; b=A/u8udcJo5cSaqRWE9Gj6EO7oSBPuf53I6+ug9Lkba0fzyJzGjW1DQVabPJZ4yS55WY0RDDg9cToZDvfnloYfp3wDywHPSltVqYCGedhMQuYWXlS6Yp5oz7JJbpcLCaMpK8cp4AfTP0Cw8QNBOkQxZb3vMaEVVYGp64i/5/JX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825767; c=relaxed/simple;
	bh=VPIc09Q7xegK52vnPkYEver9dV/TDr9T3t7jfB9mNIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VVfyJXS+ZeFTXffn5GTAKK5NuILoz972a/G4PpX1Z7RbECKEEKuesjMfEZfGrBKF6kYNVs8Tyi55jSSp8SkmDTrq/7ovX77JLI1D36HEjfMubtOl93i5Q1dBuqpl9dCtKtJG5IqiPB6wty1/HVSkHX7+VsvJBS1xI9huJbAwi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkHJxLYI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkHJxLYI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223a7065ff8so8990155ad.0
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825765; x=1743430565; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n9NMyuov+hct+RSjLtovym+JxrfPfi1Qf9x+d/3hJg=;
        b=jkHJxLYIttl1XswGVXBwiRxiqhxGNl8+wzmozldTsgCP2pWoTYHkUDbTUtRWFoD8mi
         DPYs+/g/yKJ/gYesgqsWGqmxfATfGVlJbhOpvnQFw3pBVm0GbzuQk4fvBdq/QztuhBfK
         TZejGsyv4rrAKuiCWR5iJcUG4bbSM2I55vm0MEf1FmpeSgkL2zsYxw42mMsjVvNCBw9/
         8EqGUklCbphDOPWsmTqwQghlq0j74QOfoyVgUUplzz8xOIr8vG0T22hZ5XmilKWl6INA
         r0ErMDeIW4g7o5B22YzYXyl43HnPNIh4g/TfAHX38JIjsG20XQPg7ERS4eQ0no0SaEUs
         vqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825765; x=1743430565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n9NMyuov+hct+RSjLtovym+JxrfPfi1Qf9x+d/3hJg=;
        b=U+J4GeaLwvMX+a9WnweJgvRnA+xxEhsRA4B2GcNj50caRNkhLPHIeiLOyQ9NdhlWBI
         e9HlLviZ1XcTFSsNsCcY3Lk2mtkLt7K5h4sY10mX1LsEB/EIOtd4jRUTRsYzA6IGfnX0
         0yTwmjQPZu5OWqs7RPnEoLFq/jyHPC+x7HclxdEm8A1RhDYhBrDuuh2ea61X47i5YKHu
         gp5U9eHpgJTjcgyQlPFnwFf/4CK9rhkxXIdiL4JDK30xPxDU7Du+cK/U+Hha/bL9X18O
         xkRyLT4FyHUVTIH+waXZQ+4v3zf81+nZKS/gHGnRxnAr36gsgY3GdS00lOkBZrgbv3Xa
         +AaA==
X-Gm-Message-State: AOJu0YzoC+lTZuL5kR3PeJnRADsH6bphbc+0MnB8Js4PLVNuuffRKHsT
	ul0U340nGJUUqyxe7iuNhyCmvQ35mpLAdPPyMvlJxLEiNJQ/0RtGWNTvlw==
X-Gm-Gg: ASbGncuDYxG0m6YVmvGzIHtO62cmRzJXVJmTgx0Kxb7MPn6Cqe2SjCNky52tcM2umFd
	JvueZrKarDtq9JiKT5aGagxBcaU5pMC7Y96GZLsbLm8rFH/ZnuWz7LqpmIbnJcDepc0TwKftXU4
	4IzK79+wOLsoSmou5zwGDE2BwyDerA2vQU9tMxYs3VavqzfsIqvrQl2xeQwjweCStTtOSXiu/gB
	No4h8/VNs3uZP7fgzx38ojJoRdlcln22N823xLMYqpCPF1B03R9C9bKqsgg3RqLy+n1JXERhoEl
	eGEzfdd9o/g+OOgoVXKetpQ5ez1oUsnEkwiteK6BiIYC/11Y6C0VvRQ=
X-Google-Smtp-Source: AGHT+IHxBPOm/QgV/XEFRfqZC1lWT98gmHDf8QgQBbRvjPr1AYI+38QhfX8g9tOnGW5x3nNcrOlxpw==
X-Received: by 2002:a05:6a00:1885:b0:736:ab1d:7ed5 with SMTP id d2e1a72fcca58-73905623ea3mr21164512b3a.0.1742825764426;
        Mon, 24 Mar 2025 07:16:04 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 08/13] scan: Introduce higher level scan BSS groups
Date: Mon, 24 Mar 2025 07:15:33 -0700
Message-Id: <20250324141538.144578-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
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
not fully ban these BSS's (i.e. BLACKLIST_REASON_CONNECT_FAILED).

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
index aeab6516..6c03e408 100644
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
+	if (blacklist_contains_bss(addr, BLACKLIST_REASON_CONNECT_FAILED))
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
 
+	if (!l_settings_get_int(config, "General", "OptimalSignalThreshold",
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

