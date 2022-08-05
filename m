Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712692563
	for <iwd@lists.linux.dev>; Fri,  5 Aug 2022 17:45:21 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id y141so2843205pfb.7
        for <iwd@lists.linux.dev>; Fri, 05 Aug 2022 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ZVHfGo7/GH4XOuJUFN8V+yD34WMqkzva1wkMEfuUpoU=;
        b=hUkY0zhA619CL3SkA/sQ+Q6vtIcxsWVDelHFTesXqzKQiZyafOIOp7N0AtgoJgg4+8
         G+3rkagH6PkaKzYuEq45ZqvW7NIxvB6LrcRxtIdOlZjUq3S5UPo5vowDQZp3zcoH9b6B
         KJZWb4zbto6Xf6CZAdPudnU5Q+BCB9Rcc5TGLLT/rzXSTDZmlQxDrGWX0Nywv7gqFIFI
         ge75A3W5zDlIgmgdaY3SuKZe+Ul4d7stqCYBzRR4DVnVonrjLekX96TY+xlu6POufgym
         vM378Y5EQLMePMclb0K1WJQIFfGTYMQalx0X+dCeFbIUNspAEOMef01Ez53AmtvXsGXe
         Vcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ZVHfGo7/GH4XOuJUFN8V+yD34WMqkzva1wkMEfuUpoU=;
        b=p7fX2+zSxlgP4xrXZ/Ee5F/KLCOOKcrKB6OIKtH4isHvUEIELEWkE6HhciD6GANKak
         O95miOZHuFg2Rp7xmtOXSoLkIGegVgh6uxDQ8V6xDW+0zNqsvlK6unic0YFiLNUuwNBB
         292uhWwU0VSCNAbdp3HMtwSqRD2a2n6gZafpeUHOzx6ydgngFWhjVGdSBRFXrMzfhFfn
         t+VLX1Cph047cK+/l1WwKxPoMLhIQwFzM+Y5kgX0zLWNdysWEHwzyOBAVsCPIWWc2b8A
         T5gxkvhr+YrugPbFfUsICaVX0edlcW9dbKVYo4VP91ILHmW0YJft5hD9yV4esyYVbOlY
         yUhw==
X-Gm-Message-State: ACgBeo32MXNNFveluN8QZW/UkGLmZOIPd5fXz9Q91BQzwI2Tx3kDxGG1
	q0v7hg78YaTyKPOrcFoZ1ccTlce8ZAE=
X-Google-Smtp-Source: AA6agR6FEeLkhSKrhrMzKJm4mGhtAM1e8ffMzNQx2hD6Acf/BNooqusoYEl/KQoMsv3ccQ8f6BFQzw==
X-Received: by 2002:a63:84c6:0:b0:41d:19d:d3cf with SMTP id k189-20020a6384c6000000b0041d019dd3cfmr3997135pgd.621.1659721520528;
        Fri, 05 Aug 2022 10:45:20 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id m11-20020a62a20b000000b0052d9d95bb2bsm3309323pff.180.2022.08.05.10.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:45:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5] scan: watch for regdom updates to enable 6GHz
Date: Fri,  5 Aug 2022 10:45:17 -0700
Message-Id: <20220805174517.639930-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This functionality works around the kernel's behavior of allowing
6GHz only after a regulatory domain update. If the regdom updates
scan.c needs to be aware in order to split up periodic scans, or
insert 6GHz frequencies into an ongoing periodic scan. Doing this
allows any 6GHz BSS's to show up in the scan results rather than
needing to issue an entirely new scan to see these BSS's.
---
 src/scan.c | 157 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 121 insertions(+), 36 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index d50c703c..1db91f32 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -110,6 +110,7 @@ struct scan_request {
 
 struct scan_context {
 	uint64_t wdev_id;
+	uint32_t wiphy_watch_id;
 	/*
 	 * Tells us whether a scan, our own or external, is running.
 	 * Set when scan gets triggered, cleared when scan done and
@@ -187,24 +188,6 @@ static void scan_request_failed(struct scan_context *sc,
 	wiphy_radio_work_done(sc->wiphy, sr->work.id);
 }
 
-static struct scan_context *scan_context_new(uint64_t wdev_id)
-{
-	struct wiphy *wiphy = wiphy_find_by_wdev(wdev_id);
-	struct scan_context *sc;
-
-	if (!wiphy)
-		return NULL;
-
-	sc = l_new(struct scan_context, 1);
-
-	sc->wdev_id = wdev_id;
-	sc->wiphy = wiphy;
-	sc->state = SCAN_STATE_NOT_RUNNING;
-	sc->requests = l_queue_new();
-
-	return sc;
-}
-
 static void scan_request_cancel(void *data)
 {
 	struct scan_request *sr = data;
@@ -230,6 +213,8 @@ static void scan_context_free(struct scan_context *sc)
 	if (sc->get_fw_scan_cmd_id && nl80211)
 		l_genl_family_cancel(nl80211, sc->get_fw_scan_cmd_id);
 
+	wiphy_state_watch_remove(sc->wiphy, sc->wiphy_watch_id);
+
 	l_free(sc);
 }
 
@@ -2012,6 +1997,110 @@ static void get_scan_done(void *user)
 	l_free(results);
 }
 
+static void scan_get_results(struct scan_context *sc, struct scan_request *sr,
+				struct scan_freq_set *freqs)
+{
+	struct scan_results *results;
+	struct l_genl_msg *scan_msg;
+
+	results = l_new(struct scan_results, 1);
+	results->sc = sc;
+	results->time_stamp = l_time_now();
+	results->sr = sr;
+	results->bss_list = l_queue_new();
+	results->freqs = freqs;
+
+	scan_msg = l_genl_msg_new_sized(NL80211_CMD_GET_SCAN, 8);
+
+	l_genl_msg_append_attr(scan_msg, NL80211_ATTR_WDEV, 8,
+					&sc->wdev_id);
+	sc->get_scan_cmd_id = l_genl_family_dump(nl80211, scan_msg,
+						get_scan_callback,
+						results, get_scan_done);
+}
+
+static void scan_wiphy_watch(struct wiphy *wiphy,
+				enum wiphy_state_watch_event event,
+				void *user_data)
+{
+	struct scan_context *sc = user_data;
+	struct scan_request *sr = NULL;
+	struct l_genl_msg *msg = NULL;
+	struct scan_parameters params = { 0 };
+	struct scan_freq_set *freqs_6ghz;
+	struct scan_freq_set *allowed;
+	bool allow_6g;
+	const struct scan_freq_set *supported =
+					wiphy_get_supported_freqs(wiphy);
+
+	/* Only care about regulatory events, and if 6GHz capable */
+	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE ||
+			!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ))
+		return;
+
+	if (!sc->sp.id)
+		return;
+
+	sr = l_queue_find(sc->requests, scan_request_match,
+						L_UINT_TO_PTR(sc->sp.id));
+	if (!sr)
+		return;
+
+	allowed = scan_get_allowed_freqs(sc);
+	allow_6g = scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ;
+
+	/*
+	 * This update did not allow 6GHz, or the original request was
+	 * not expecting 6GHz. The periodic scan should now be ended.
+	 */
+	if (!allow_6g || !sr->split) {
+		scan_get_results(sc, sr, sr->freqs_scanned);
+		goto free_allowed;
+	}
+
+	/*
+	 * At this point we know there is an ongoing periodic scan.
+	 * Create a new 6GHz passive scan request and append to the
+	 * command list
+	 */
+	freqs_6ghz = scan_freq_set_clone(allowed, BAND_FREQ_6_GHZ);
+
+	msg = scan_build_cmd(sc, false, true, &params, freqs_6ghz);
+	l_queue_push_tail(sr->cmds, msg);
+
+	scan_freq_set_free(freqs_6ghz);
+
+	/*
+	 * If this periodic scan is at the top of the queue, continue
+	 * running it.
+	 */
+	if (l_queue_peek_head(sc->requests) == sr)
+		start_next_scan_request(&sr->work);
+
+free_allowed:
+	scan_freq_set_free(allowed);
+}
+
+static struct scan_context *scan_context_new(uint64_t wdev_id)
+{
+	struct wiphy *wiphy = wiphy_find_by_wdev(wdev_id);
+	struct scan_context *sc;
+
+	if (!wiphy)
+		return NULL;
+
+	sc = l_new(struct scan_context, 1);
+
+	sc->wdev_id = wdev_id;
+	sc->wiphy = wiphy;
+	sc->state = SCAN_STATE_NOT_RUNNING;
+	sc->requests = l_queue_new();
+	sc->wiphy_watch_id = wiphy_state_watch_add(wiphy, scan_wiphy_watch,
+							sc, NULL);
+
+	return sc;
+}
+
 static bool scan_parse_flush_flag_from_msg(struct l_genl_msg *msg)
 {
 	struct l_genl_attr attr;
@@ -2100,8 +2189,7 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 	switch (cmd) {
 	case NL80211_CMD_NEW_SCAN_RESULTS:
 	{
-		struct l_genl_msg *scan_msg;
-		struct scan_results *results;
+		struct scan_freq_set *freqs;
 		bool send_next = false;
 		bool retry = false;
 		bool get_results = false;
@@ -2117,6 +2205,14 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 				break;
 			}
 
+			/* Regdom changed during a periodic scan */
+			if (sc->sp.id == sr->work.id &&
+					wiphy_regdom_is_updating(sc->wiphy)) {
+				scan_parse_result_frequencies(msg,
+							sr->freqs_scanned);
+				return;
+			}
+
 			/*
 			 * If this was the last command for the current request
 			 * avoid starting the next request until the GET_SCAN
@@ -2168,29 +2264,18 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 		if (!get_results)
 			break;
 
-		results = l_new(struct scan_results, 1);
-		results->sc = sc;
-		results->time_stamp = l_time_now();
-		results->sr = sr;
-		results->bss_list = l_queue_new();
-
 		/*
 		 * In case this was an external scan, setup a new, temporary
 		 * frequency set to report the results to the periodic callback
 		 */
-		if (!results->sr)
-			results->freqs = scan_freq_set_new();
+		if (!sr)
+			freqs = scan_freq_set_new();
 		else
-			results->freqs = sr->freqs_scanned;
+			freqs = sr->freqs_scanned;
 
-		scan_parse_result_frequencies(msg, results->freqs);
+		scan_parse_result_frequencies(msg, freqs);
 
-		scan_msg = l_genl_msg_new_sized(NL80211_CMD_GET_SCAN, 8);
-		l_genl_msg_append_attr(scan_msg, NL80211_ATTR_WDEV, 8,
-					&sc->wdev_id);
-		sc->get_scan_cmd_id = l_genl_family_dump(nl80211, scan_msg,
-							get_scan_callback,
-							results, get_scan_done);
+		scan_get_results(sc, sr, freqs);
 
 		break;
 	}
-- 
2.34.3

