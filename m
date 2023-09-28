Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C08BF4
	for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 12:41:31 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c60778a3bfso85235745ad.1
        for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695904890; x=1696509690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUb2MfgnYrGbuZMByEg3cptxC6yq1OsAu+tX/YWyt3U=;
        b=ggdqCIEGcB1uSGPIj8w8YdyWzvb57/r8xPyDHdQibGLH2YbeuKam/KIo9I6XZf2XB5
         ktSGrDGhzjRVuonUBZzq/dl2TfkxdtPxmdGbJubfujIaMVAuWYA+8MUqsy8uO/4UzC1C
         X+nOODrlwTNbyL++JGmw2cNm5x1ED1osR+0nqGSFdpAGx+fnR1Xtim5utuTpUJJjOBq7
         pNY8FM6x3UxeCDNCL/SEvszUztZ/FarzUGgAUVXnW7kkZytGN9BC5JLLY/cc0ejXxM1x
         oNL4wxMlM7IjK0s9Kz0Gt7I48J6Q8SHq+wy05U14FBHt443xyVw5qLa4dqm0sOaW9U5Q
         scwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904890; x=1696509690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUb2MfgnYrGbuZMByEg3cptxC6yq1OsAu+tX/YWyt3U=;
        b=bSjnyk6J2UBWg6AonAxZoFAtGS3Yu51jw+XO52Yf4wNwWmsaApfqoSJ3x4CkArqKFR
         iWmvetTd4cX0W4ugTZ7fSGhiPpVfez0gf/1RziwCtL3aiMNYZBec/hTzgUM7CTumhmcr
         fSyTgL3Wfn6dUTu5Zp/jCqSmj+Bu2wP1xo2GqjKMfWdWq/3VLYO0eKD/2zPcOjBQkpzL
         0PF650OQ9tY20U7DT4arELpzFZze18Rnl6CAgK8WEsuJzn7H6y6CJq3uh6SNizzXDLCp
         R3wMzfYIQAYmu8l51NpficFPhk3SM6H68DAr3GsGaseQxP8tptLHd0ZVRe73QyUGANcX
         I7AQ==
X-Gm-Message-State: AOJu0YwbeEMIgIL3utcz8O+hBI8dPgQdlL9W2txKF4822Oz+3SrXa9gV
	TNjPDLj0rRBBuDu3IJaCTAP0Lg5JSDg=
X-Google-Smtp-Source: AGHT+IFsD1CoXY/6eGP/QN47RUW8bA838B7TIJZEA0VtVkZK2byFlp0gS8KHxs8ZKux+P/CJLzIGow==
X-Received: by 2002:a17:902:d50e:b0:1b8:8af0:416f with SMTP id b14-20020a170902d50e00b001b88af0416fmr1238741plg.1.1695904890477;
        Thu, 28 Sep 2023 05:41:30 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001c5d09e9437sm14983105plb.25.2023.09.28.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:41:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] scan: allow splitting of scans with defined frequencies
Date: Thu, 28 Sep 2023 05:41:25 -0700
Message-Id: <20230928124128.3793788-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the only way a scan can be split is if the request does
not specify any frequencies, implying the request should scan the
entire spectrum. This allows the scan logic to issue an extra
request if 6GHz becomes available during the 2.4 or 5GHz scans.
This restriction was somewhat arbitrary and done to let periodic
scans pick up 6GHz APs through a single scan request.

But now with the addition of allowing user-disabled bands
periodic scans will need to specify a frequency list in case a
given band has been disabled. This will break the scan splitting
code which is why this prep work is being done.

The main difference now is the original scan frequencies are
tracked with the scan request. The reason for this is so if a
request comes in with a limited set of 6GHz frequences IWD won't
end up scanning the full 6GHz spectrum later on.
---
 src/scan.c | 56 +++++++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

v2:
 * Use _auto_ for allowed frequencies in scan_cmds_add()

diff --git a/src/scan.c b/src/scan.c
index 915e2875..e6c105c0 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -107,6 +107,8 @@ struct scan_request {
 	 * and save these since there may be additional scan commands to run.
 	 */
 	struct scan_freq_set *freqs_scanned;
+	/* Entire list of frequencies to scan */
+	struct scan_freq_set *scan_freqs;
 };
 
 struct scan_context {
@@ -170,6 +172,7 @@ static void scan_request_free(struct wiphy_radio_work_item *item)
 	l_queue_destroy(sr->cmds, (l_queue_destroy_func_t) l_genl_msg_unref);
 
 	scan_freq_set_free(sr->freqs_scanned);
+	scan_freq_set_free(sr->scan_freqs);
 
 	l_free(sr);
 }
@@ -341,20 +344,6 @@ static bool scan_mac_address_randomization_is_disabled(void)
 	return disabled;
 }
 
-static struct scan_freq_set *scan_get_allowed_freqs(struct scan_context *sc)
-{
-	struct scan_freq_set *allowed = scan_freq_set_new();
-
-	scan_freq_set_merge(allowed, wiphy_get_supported_freqs(sc->wiphy));
-
-	if (!wiphy_constrain_freq_set(sc->wiphy, allowed)) {
-		scan_freq_set_free(allowed);
-		allowed = NULL;
-	}
-
-	return allowed;
-}
-
 static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
 					bool ignore_flush_flag, bool is_passive,
 					const struct scan_parameters *params,
@@ -582,22 +571,28 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
 				bool passive,
 				const struct scan_parameters *params)
 {
+	uint32_t bands = BAND_FREQ_2_4_GHZ | BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ;
 	unsigned int i;
 	struct scan_freq_set *subsets[2] = { 0 };
-	struct scan_freq_set *allowed = scan_get_allowed_freqs(sc);
+	_auto_(scan_freq_set_free) struct scan_freq_set *allowed =
+				wiphy_get_allowed_freqs(sc->wiphy, bands);
 	const struct scan_freq_set *supported =
 					wiphy_get_supported_freqs(sc->wiphy);
 
 	/*
-	 * If 6GHz is not possible, or already allowed, or the frequencies are
-	 * explicit don't break up the request.
+	 * No frequencies, just include the entire supported list and let the
+	 * kernel filter out any disabled frequencies
 	 */
+	if (!params->freqs)
+		sr->scan_freqs = scan_freq_set_clone(supported, bands);
+	else
+		sr->scan_freqs = scan_freq_set_clone(params->freqs, bands);
+
+	/* If 6GHz is not possible or already allowed don't split the request */
 	if (!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ) ||
-			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ) ||
-			params->freqs) {
-		scan_freq_set_free(allowed);
+			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ)) {
 		scan_build_next_cmd(sr->cmds, sc, passive,
-						params, params->freqs);
+						params, sr->scan_freqs);
 		return;
 	}
 
@@ -613,10 +608,8 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
 	 * extra 6GHz-only passive scan can be appended to this request
 	 * at that time.
 	 */
-	subsets[0] = scan_freq_set_clone(allowed, BAND_FREQ_2_4_GHZ);
-	subsets[1] = scan_freq_set_clone(allowed, BAND_FREQ_5_GHZ);
-
-	scan_freq_set_free(allowed);
+	subsets[0] = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_2_4_GHZ);
+	subsets[1] = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_5_GHZ);
 
 	for(i = 0; i < L_ARRAY_SIZE(subsets); i++) {
 		if (!scan_freq_set_isempty(subsets[i]))
@@ -1918,9 +1911,8 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	struct scan_request *sr = NULL;
 	struct l_genl_msg *msg = NULL;
 	struct scan_parameters params = { 0 };
-	struct scan_freq_set *freqs_6ghz;
 	struct scan_freq_set *allowed;
-	bool allow_6g;
+	_auto_(scan_freq_set_free) struct scan_freq_set *freqs_6ghz = NULL;
 
 	/* Only care about completed regulatory dumps */
 	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE)
@@ -1934,14 +1926,14 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	if (!sr)
 		return;
 
-	allowed = scan_get_allowed_freqs(sc);
-	allow_6g = scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ;
+	allowed = wiphy_get_allowed_freqs(sc->wiphy, BAND_FREQ_6_GHZ);
+	freqs_6ghz = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_6_GHZ);
 
 	/*
 	 * This update did not allow 6GHz, or the original request was
 	 * not expecting 6GHz. The periodic scan should now be ended.
 	 */
-	if (!allow_6g || !sr->split) {
+	if (!allowed || scan_freq_set_isempty(freqs_6ghz) || !sr->split) {
 		scan_get_results(sc, sr, sr->freqs_scanned);
 		goto free_allowed;
 	}
@@ -1951,13 +1943,9 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	 * Create a new 6GHz passive scan request and append to the
 	 * command list
 	 */
-	freqs_6ghz = scan_freq_set_clone(allowed, BAND_FREQ_6_GHZ);
-
 	msg = scan_build_cmd(sc, false, true, &params, freqs_6ghz);
 	l_queue_push_tail(sr->cmds, msg);
 
-	scan_freq_set_free(freqs_6ghz);
-
 	/*
 	 * If this periodic scan is at the top of the queue, continue
 	 * running it.
-- 
2.25.1

