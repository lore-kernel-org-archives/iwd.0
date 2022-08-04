Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93656AAD
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 22:02:53 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id iw1so1032835plb.6
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wfLBRlYqB6Hhy3IEaoMJSS9tQKJKoI49aX+f7vXHaWU=;
        b=ZsHj5gL9H/JNWNoEP/KRIMSNOKWQc71MZArEA0ykDQDyWcYCTRpgbLcaS7TQknhSYl
         357j9818IhPHW6u+avvOCMUpzgbCJ/B0vfDzPblA3S0m9rU6cmy0N1zx/DLRIR54xWrk
         d/OYkozhrLJhziYzDCWNXg9xU3IfbkOuZKoFQuHVVfD+g4miIetHJDGdzZ5X8/xkdLhK
         9PY+ET2Ei2gFXAH7ouGO0L5kCCDx83QZIC0sH67B6y5DaULnqYv6am8meG2yneil6WUI
         6QiUZtsRydJ5Fi7VEmjx39pj44Hpt3MRNGc8SfyxWzpUBKoANUmPyA5541ux26jDt7q1
         wytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wfLBRlYqB6Hhy3IEaoMJSS9tQKJKoI49aX+f7vXHaWU=;
        b=32UBS8jLa1Od+mwgSrJCng0B1DFJ1JhXvyQ1gJEkyDscQtugH30ayRgb0h/tbgyZ1M
         58fb6ApSh2h/fmoKcc8zox37IrEs933VgdDPqVRpo8kDNJMUYMu0k+aYC81YUhgtStXR
         ErbBeg7IO93+8CZ4gSa2OsEj+4/sn6QEq60IC4U8IWkt1LjEzv9bIOiWmU5BSSz00fmL
         RqTtx/8upNMIuYZEZL7RTHVArx1MfvA0fVY1LFaDPRHy1beJwyFXJE1CCeCEFe8CgouT
         YojDuzbttMoxCnEDwYrAqeWTHS8hPe9YYuVseLrVyxPyTiHhbtw/1NPyORQ58WiXjTgY
         kuug==
X-Gm-Message-State: ACgBeo2ZVXDJjgbTaO3S2Wj7bU99bIQeFHBNzhw3qeFO8tEni+k/VeUy
	dyYWLd/e3hC6htqfWVrU1ubcTTY1ngQ=
X-Google-Smtp-Source: AA6agR6PgwSrMSNdKZlK3/hKcZmERhUvtxX7Emiw3yAnzHrxj6/W/1Re8pJbayxiBAnqkOnYF0hpxQ==
X-Received: by 2002:a17:902:c713:b0:16e:cbe3:29da with SMTP id p19-20020a170902c71300b0016ecbe329damr3642167plp.61.1659650573057;
        Thu, 04 Aug 2022 15:02:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902ebc300b0016dbdf7b97bsm1376886plg.266.2022.08.04.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:02:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/3] scan: watch for regdom updates to enable 6GHz
Date: Thu,  4 Aug 2022 15:02:49 -0700
Message-Id: <20220804220249.508207-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220804220249.508207-1-prestwoj@gmail.com>
References: <20220804220249.508207-1-prestwoj@gmail.com>
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
 src/scan.c | 146 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 114 insertions(+), 32 deletions(-)

v4:
 * Remove wait_for_regdom/expect_6ghz flags. This reduced the complexity
   and avoided the need to even check for the STARTED regdom event.
 * Fixed issue where a periodic scan waiting on the regdom wasn't parsing
   the NEW_SCAN_RESULT frequencies before bailing out of the notify callback
 * Fixed issue where a periodic scan was not finished if a new scan command
   was not appended.

diff --git a/src/scan.c b/src/scan.c
index 12c970a7..d044e80c 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -110,6 +110,7 @@ struct scan_request {
 
 struct scan_context {
 	uint64_t wdev_id;
+	uint32_t wiphy_watch_id;
 	/*
 	 * Tells us whether a scan, our own or external, is running.
 	 * Set when scan gets triggered, cleared when scan done and
@@ -186,24 +187,6 @@ static void scan_request_failed(struct scan_context *sc,
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
@@ -229,6 +212,8 @@ static void scan_context_free(struct scan_context *sc)
 	if (sc->get_fw_scan_cmd_id && nl80211)
 		l_genl_family_cancel(nl80211, sc->get_fw_scan_cmd_id);
 
+	wiphy_state_watch_remove(sc->wiphy, sc->wiphy_watch_id);
+
 	l_free(sc);
 }
 
@@ -2006,6 +1991,108 @@ static void get_scan_done(void *user)
 	l_free(results);
 }
 
+static void scan_get_results(struct scan_context *sc, struct scan_request *sr)
+{
+	struct scan_results *results;
+	struct l_genl_msg *scan_msg;
+
+	results = l_new(struct scan_results, 1);
+	results->sc = sc;
+	results->time_stamp = l_time_now();
+	results->sr = sr;
+	results->bss_list = l_queue_new();
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
+		scan_get_results(sc, sr);
+		goto free_allowed;
+	}
+
+	/*
+	 * At this point we know there is an ongoing periodic scan.
+	 * Create a new 6GHz passive scan request and append to the
+	 * command list
+	 */
+	freqs_6ghz = scan_freq_set_copy_bands(allowed, BAND_FREQ_6_GHZ);
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
@@ -2094,8 +2181,6 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 	switch (cmd) {
 	case NL80211_CMD_NEW_SCAN_RESULTS:
 	{
-		struct l_genl_msg *scan_msg;
-		struct scan_results *results;
 		bool send_next = false;
 		bool retry = false;
 		bool get_results = false;
@@ -2106,6 +2191,14 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 		if (sr && sr->triggered) {
 			sr->triggered = false;
 
+			/* Regdom changed during a periodic scan */
+			if (sc->sp.id == sr->work.id &&
+					wiphy_regdom_is_updating(sc->wiphy)) {
+				scan_parse_result_frequencies(msg,
+							sr->freqs_scanned);
+				return;
+			}
+
 			if (!sr->callback) {
 				scan_finished(sc, -ECANCELED, NULL, NULL, sr);
 				break;
@@ -2162,20 +2255,9 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 		if (!get_results)
 			break;
 
-		results = l_new(struct scan_results, 1);
-		results->sc = sc;
-		results->time_stamp = l_time_now();
-		results->sr = sr;
-		results->bss_list = l_queue_new();
-
 		scan_parse_result_frequencies(msg, sr->freqs_scanned);
 
-		scan_msg = l_genl_msg_new_sized(NL80211_CMD_GET_SCAN, 8);
-		l_genl_msg_append_attr(scan_msg, NL80211_ATTR_WDEV, 8,
-					&sc->wdev_id);
-		sc->get_scan_cmd_id = l_genl_family_dump(nl80211, scan_msg,
-							get_scan_callback,
-							results, get_scan_done);
+		scan_get_results(sc, sr);
 
 		break;
 	}
-- 
2.34.3

