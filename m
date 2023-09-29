Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC9521C3
	for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 16:20:02 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so109019985ad.0
        for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696004402; x=1696609202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glMZ92Y3miq9lZIPy8MGDnefdMMOFsKZr/WVg7MwE7g=;
        b=BqdXtJe7oEaE5OkAuyFwpJ45T17RlIi7njPqtvGIZy7R8vjMDvVm+RjRO/fWKlu6tK
         0TsQit8p2ZMjTzxduuE7C+Nyi/Up+YehLgH9YMN7fmtott6y3dCwEpW2nmVgAZA4yyUS
         6PJTa6XooveCJpqgvdLYWa6QJad4iaDRsVV5SNQkL140zdhFCqA1shS9rxs4tqc+53Va
         S3IE8e6hOk9Q3GMCusjqNvfK2BefkwxeSsDAK0rUz48USVIkW+5Mhgd4hFboIKrSi7pe
         VU0SJjCthtMr3tucTYo3NG96nXdJu3X4TI1AXtDRUMCxe/Cyq2ap/cIFj3r/4y/UIvyJ
         rBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004402; x=1696609202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glMZ92Y3miq9lZIPy8MGDnefdMMOFsKZr/WVg7MwE7g=;
        b=jsqIpv9rKnwZQRYBWAcV6hK/YrWuZ0wetloXIliOqw3o/oqO+Asti4u7KthljHi7DU
         iYpizwOvWr2qRR9U3/qf2xaeun7m0SjQx0LMrsNoQUqdpdAA9rFPITB3DV//I6j8MzjT
         JSqxkjWt+7NpqwhU/oouFz7/i4Gz18NV9KYREhz5y1AyxtI/4tgcIjkaaTTJiM0oaGZX
         9hCSzZVRUMahn2pMpjqf2hsQbnu51ipyJ915yrpXrlumFtoitZGJwAL6GbN+bN7HVGbD
         Yv75926wRqinQym5Grw1SBXej2GRBAtSYQlPWntKLzq3E1RFHf4RIA7iO+xUUBd8pABO
         ZqSA==
X-Gm-Message-State: AOJu0YyKPdkHaeoQ2bgMMnfRQWb1ztfF6MOCM+XBiq4fdo7+JEQXAgcG
	/QetjBenvcFIi4LkisVdZb0hqBb6xHY=
X-Google-Smtp-Source: AGHT+IEsVHqS5XOrxbCYBtPTejoYveWi5b+XS5qMTbep/vwVwBTof+ADd6RWuym8U5bCXXS3tAoNlA==
X-Received: by 2002:a17:902:c38d:b0:1c0:d5c6:748f with SMTP id g13-20020a170902c38d00b001c0d5c6748fmr4365898plg.67.1696004401898;
        Fri, 29 Sep 2023 09:20:01 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001b8b1f6619asm17223766plb.75.2023.09.29.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:20:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] scan: remove use of wiphy_get_allowed_freqs to optimize 6ghz path
Date: Fri, 29 Sep 2023 09:19:58 -0700
Message-Id: <20230929161959.3840935-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929161959.3840935-1-prestwoj@gmail.com>
References: <20230929161959.3840935-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wiphy_get_allowed_freqs was only being used to see if 6GHz was disabled
or not. This is expensive and requires several allocations when there
already exists wiphy_is_band_disabled(). The prior patch modified
wiphy_is_band_disabled() to return -ENOTSUP which allows scan.c to
completely remove the need for wiphy_get_allowed_freqs.

scan_wiphy_watch was also slightly re-ordered to avoid allocating
freqs_6ghz if the scan request was being completed.
---
 src/scan.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 93047a6b..57fcae6f 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -574,10 +574,9 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
 	uint32_t bands = BAND_FREQ_2_4_GHZ | BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ;
 	unsigned int i;
 	struct scan_freq_set *subsets[2] = { 0 };
-	_auto_(scan_freq_set_free) struct scan_freq_set *allowed =
-				wiphy_get_allowed_freqs(sc->wiphy, bands);
 	const struct scan_freq_set *supported =
 					wiphy_get_supported_freqs(sc->wiphy);
+	int disabled;
 
 	/*
 	 * No frequencies, just include the entire supported list and let the
@@ -589,8 +588,8 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
 		sr->scan_freqs = scan_freq_set_clone(params->freqs, bands);
 
 	/* If 6GHz is not possible or already allowed don't split the request */
-	if (!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ) ||
-			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ)) {
+	disabled = wiphy_band_is_disabled(sc->wiphy, BAND_FREQ_6_GHZ);
+	if (disabled == -ENOTSUP || disabled == false) {
 		scan_build_next_cmd(sr->cmds, sc, passive,
 						params, sr->scan_freqs);
 		return;
@@ -1947,8 +1946,8 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	struct scan_request *sr = NULL;
 	struct l_genl_msg *msg = NULL;
 	struct scan_parameters params = { 0 };
-	struct scan_freq_set *allowed;
 	_auto_(scan_freq_set_free) struct scan_freq_set *freqs_6ghz = NULL;
+	int disabled;
 
 	/* Only care about completed regulatory dumps */
 	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE)
@@ -1962,18 +1961,19 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	if (!sr)
 		return;
 
-	allowed = wiphy_get_allowed_freqs(sc->wiphy, BAND_FREQ_6_GHZ);
-	freqs_6ghz = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_6_GHZ);
-
 	/*
 	 * This update did not allow 6GHz, or the original request was
 	 * not expecting 6GHz. The periodic scan should now be ended.
 	 */
-	if (!allowed || scan_freq_set_isempty(freqs_6ghz) || !sr->split) {
+	disabled = wiphy_band_is_disabled(wiphy, BAND_FREQ_6_GHZ);
+	if (scan_freq_set_get_bands(sr->freqs_scanned) & BAND_FREQ_6_GHZ ||
+			disabled == true || !sr->split) {
 		scan_get_results(sc, sr, sr->freqs_scanned);
-		goto free_allowed;
+		return;
 	}
 
+	freqs_6ghz = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_6_GHZ);
+
 	/*
 	 * At this point we know there is an ongoing periodic scan.
 	 * Create a new 6GHz passive scan request and append to the
@@ -1988,9 +1988,6 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	 */
 	if (l_queue_peek_head(sc->requests) == sr)
 		start_next_scan_request(&sr->work);
-
-free_allowed:
-	scan_freq_set_free(allowed);
 }
 
 static struct scan_context *scan_context_new(uint64_t wdev_id)
-- 
2.25.1

