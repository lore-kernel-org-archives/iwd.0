Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE4D304
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 18:54:45 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59c07cf02ebso86741017b3.1
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668084; x=1696272884; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo9GvVGIYyDfs3W76IdQbrCPVd2t4pioZMSVx3WvBmo=;
        b=PVPqgEKuwkSbVxehecIigMdksr/Md+bHiEcZBxzsYX9LUWsoPG+1uceEb9HiJpX+45
         2gIKcCdaTwuWwZnOVCYh8wKv4k3g8HL7YN9GxbV+mKAZheu30OcqIscmKFfaCNDxsE5n
         SNyq21cM+UNbbqnI8NRLSzQOr8D1gPTRB1wu9NxBohiKl9c/sr8k8sL7zJs2/Yyh8+SP
         30qXJHiqv3xujesfRQM+UCwE6aCFpz1utx6jpAi8+cbAYE93bFq8fS46yY2J5sChWXwt
         8n3yeunt9caMnCiFsg1sSHKNBQb/y7YBJ41kB9qbWS/52MP5efkr8b73v09drEeOczSe
         h9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668084; x=1696272884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo9GvVGIYyDfs3W76IdQbrCPVd2t4pioZMSVx3WvBmo=;
        b=AL+KvSIlpgcmMq/ad21eZ0BOJfYzwyi++ebcpX6+mNtcM0SqJ4fYH5s0sddYLVUzDH
         WvJQpPZEL5IH0Ewn6iu1cYRPbChMDVtNSHdLUuGhowWgwrTvXIDU6MIBxSwpowUZul1e
         vzt0VWrwzsrAdZwz5Ok0O6ATYRpT678hcLWkjfYB6LzB42oFz5AAiuD83PfWqpSKGz/+
         CCoWXSsLYCmPog5IzSgwM4X+mamrISnF72j5z3Q3MN6Cwzweqiy0Vlw1IeSTRF7cTCRj
         b5F/p2RhyWTDn/L+kznIZ3+ZQzet8DxcMm2PxLTXLO9Mb0k1zzbvDpV9m70ax5bfH4Ns
         ORxg==
X-Gm-Message-State: AOJu0Yzimx3dGGWLN/Wj4Mbl1+bkTZXyLYZZMr98yAiAE8v0UNlNSNOm
	C4GU5I6GoW+gi2PNHqdzkCSNeyw7KOk=
X-Google-Smtp-Source: AGHT+IHYANLH7xVsNMNU9UOSOvu20K9QusgAStegmK2b3ELZLL2lVKiQWlgiF97T0M8U3ibAhSoG2w==
X-Received: by 2002:a81:5b0a:0:b0:56c:e70b:b741 with SMTP id p10-20020a815b0a000000b0056ce70bb741mr8337768ywb.20.1695668084480;
        Mon, 25 Sep 2023 11:54:44 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b00570253fc3e5sm2518920ywa.105.2023.09.25.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:54:44 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] scan: allow splitting of scans with defined frequencies
Date: Mon, 25 Sep 2023 11:54:19 -0700
Message-Id: <20230925185422.2242494-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925185422.2242494-1-prestwoj@gmail.com>
References: <20230925185422.2242494-1-prestwoj@gmail.com>
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
 src/scan.c | 53 ++++++++++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 915e2875..9b1cc30a 100644
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
@@ -582,22 +571,29 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
 				bool passive,
 				const struct scan_parameters *params)
 {
+	uint32_t bands = BAND_FREQ_2_4_GHZ | BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ;
 	unsigned int i;
 	struct scan_freq_set *subsets[2] = { 0 };
-	struct scan_freq_set *allowed = scan_get_allowed_freqs(sc);
+	struct scan_freq_set *allowed = wiphy_get_allowed_freqs(sc->wiphy,
+								bands);
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
+			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ)) {
 		scan_freq_set_free(allowed);
 		scan_build_next_cmd(sr->cmds, sc, passive,
-						params, params->freqs);
+						params, sr->scan_freqs);
 		return;
 	}
 
@@ -613,8 +609,8 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
 	 * extra 6GHz-only passive scan can be appended to this request
 	 * at that time.
 	 */
-	subsets[0] = scan_freq_set_clone(allowed, BAND_FREQ_2_4_GHZ);
-	subsets[1] = scan_freq_set_clone(allowed, BAND_FREQ_5_GHZ);
+	subsets[0] = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_2_4_GHZ);
+	subsets[1] = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_5_GHZ);
 
 	scan_freq_set_free(allowed);
 
@@ -1918,9 +1914,8 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	struct scan_request *sr = NULL;
 	struct l_genl_msg *msg = NULL;
 	struct scan_parameters params = { 0 };
-	struct scan_freq_set *freqs_6ghz;
 	struct scan_freq_set *allowed;
-	bool allow_6g;
+	_auto_(scan_freq_set_free) struct scan_freq_set *freqs_6ghz = NULL;
 
 	/* Only care about completed regulatory dumps */
 	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE)
@@ -1934,14 +1929,14 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
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
@@ -1951,13 +1946,9 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
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

