Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD04A3A
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:54 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id 17so2117485plj.10
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qe39BLq4IBDTBxHdRyJt9ZBbv1zb2MsXCAL9qTwxMkA=;
        b=mHkiRPYMLkjXu7hfhCqfhtMh8ZnSlSzAG17/PP9E4Z2SWqkZOKzfCJeW/of0u/zGrT
         4+CjBb+dpF/kX7n0CX/sDc7pj0TdOm5pkYmhAHysYg+NjhjECiygL8vGziBG1zlhyonD
         WOCJOtYE1esq/6lJV/SYo77uALYiscBxA+/i6kOQkcKdRcLQm/9WE/gVxSn3NFG9uXRR
         xDo6NxttwzGMyltcg78gTa0TMIffpl/h+6jylceH07Ub7oUO16rIeE2/ZHTt1cAPKpQV
         ua/+tJgjkbrG80Xk3JKmYmGvqxoa6BmQaNzWzqGZDYaNsyc/6WS1uYarbk0XJ7KtMkpT
         KXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qe39BLq4IBDTBxHdRyJt9ZBbv1zb2MsXCAL9qTwxMkA=;
        b=h7CNUstUYW1awLCQvAQdVPsZn5jGoJMFkpgRowkLOguM5/eHnjA/7681vUHAADuMtr
         foGuWLzezkgn42ERYgBL90XvMeyvC+iQAqVIj4FNq6bW9jxrz3fHWRdsCO7Z3PDox0g0
         3NEEgYcesPjtLwcFjAUDjCe2y7nzShMnk23nNMf5s8w2dEPHC2EvgrASsJfyzDlSu1rU
         sOsbf4W4wXQ99KrFDKOcr4Bt8dEVBohqUj1s6l6x5l+sVVGcbFBL/QKwxH58QgdC3TBw
         6OgQP5TaM6Z0sKFG66G21w4ppzdfo3InN5dstt6zgbaFtpfsUFaO4zD0iJ1aOgOLbEHz
         lU+Q==
X-Gm-Message-State: ACgBeo2AYIzAYurbX1493pgSeA+5ESBqWFylSyG+9Mp+Emi6i10VNZAg
	ZU+24WY1/IyoLANwLa+XI73GRpf86SI=
X-Google-Smtp-Source: AA6agR4JI+Fv0qEQOOlydZa0wOlOXEKPRGUXt/gKYmzvKKXJbdEltySAGxlOrzNIzEk2/Yq1oZ7baQ==
X-Received: by 2002:a17:903:234d:b0:16f:3e9:491b with SMTP id c13-20020a170903234d00b0016f03e9491bmr10302393plh.89.1659562613689;
        Wed, 03 Aug 2022 14:36:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 12/13] scan: watch for regdom updates to enable 6GHz
Date: Wed,  3 Aug 2022 14:36:43 -0700
Message-Id: <20220803213644.277534-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
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
 src/scan.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 147 insertions(+), 18 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index e016bd4d..40e527d9 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -71,6 +71,8 @@ struct scan_periodic {
 	void *userdata;
 	uint32_t id;
 	bool needs_active_scan:1;
+	/* Delay periodic scan results until regulatory domain updates */
+	bool wait_on_regdom:1;
 };
 
 struct scan_request {
@@ -108,6 +110,7 @@ struct scan_request {
 
 struct scan_context {
 	uint64_t wdev_id;
+	uint32_t wiphy_watch_id;
 	/*
 	 * Tells us whether a scan, our own or external, is running.
 	 * Set when scan gets triggered, cleared when scan done and
@@ -126,6 +129,8 @@ struct scan_context {
 	 */
 	unsigned int get_fw_scan_cmd_id;
 	struct wiphy *wiphy;
+	/* 6GHz may become available after a regdom update */
+	bool expect_6ghz : 1;
 };
 
 struct scan_results {
@@ -184,24 +189,6 @@ static void scan_request_failed(struct scan_context *sc,
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
@@ -227,6 +214,8 @@ static void scan_context_free(struct scan_context *sc)
 	if (sc->get_fw_scan_cmd_id && nl80211)
 		l_genl_family_cancel(nl80211, sc->get_fw_scan_cmd_id);
 
+	wiphy_state_watch_remove(sc->wiphy, sc->wiphy_watch_id);
+
 	l_free(sc);
 }
 
@@ -477,6 +466,142 @@ done:
 	return msg;
 }
 
+static void scan_add_6ghz(uint32_t freq, void *user_data)
+{
+	struct scan_freq_set *freqs = user_data;
+
+	if (freq < 6000)
+		return;
+
+	scan_freq_set_add(freqs, freq);
+}
+
+static void scan_wiphy_watch(struct wiphy *wiphy,
+				enum wiphy_state_watch_event event,
+				void *user_data)
+{
+	struct scan_context *sc = user_data;
+	struct scan_request *sr = NULL;
+	struct l_genl_msg *msg;
+	struct scan_parameters params = { 0 };
+	struct scan_freq_set *freqs_6ghz;
+	struct scan_freq_set *allowed;
+	bool allow_6g;
+	const struct scan_freq_set *supported =
+					wiphy_get_supported_freqs(wiphy);
+
+	/* Only care about regulatory events, and if 6GHz capable */
+	if ((event != WIPHY_STATE_WATCH_EVENT_REGDOM_STARTED &&
+			event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE) ||
+			!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ))
+		return;
+
+	allowed = scan_get_allowed_freqs(sc);
+	allow_6g = scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ;
+
+	switch (event) {
+	case WIPHY_STATE_WATCH_EVENT_REGDOM_STARTED:
+		if (allow_6g)
+			goto done;
+
+		sc->expect_6ghz = true;
+
+		/*
+		 * If there is a running/queued periodic scan we may need to
+		 * delay the results if 6GHz becomes available.
+		 */
+		if (sc->sp.id)
+			sc->sp.wait_on_regdom = true;
+
+		goto done;
+	case WIPHY_STATE_WATCH_EVENT_REGDOM_DONE:
+		if (!sc->expect_6ghz)
+			goto done;
+
+		sc->expect_6ghz = false;
+
+		if (!sc->sp.id)
+			goto done;
+
+		sr = l_queue_find(sc->requests, scan_request_match,
+						L_UINT_TO_PTR(sc->sp.id));
+		if (!sr)
+			goto done;
+
+		/* This update did not allow 6GHz */
+		if (!allow_6g)
+			goto check_periodic;
+
+		/*
+		 * At this point we know there is an ongoing periodic scan.
+		 * Create a new 6GHz passive scan request and append to the
+		 * command list
+		 */
+		freqs_6ghz = scan_freq_set_new();
+
+		scan_freq_set_foreach(allowed, scan_add_6ghz, freqs_6ghz);
+
+		msg = scan_build_cmd(sc, false, true, &params, freqs_6ghz);
+		l_queue_push_tail(sr->cmds, msg);
+
+		scan_freq_set_free(freqs_6ghz);
+
+check_periodic:
+		if (sc->sp.wait_on_regdom) {
+			/* Periodic scan results delayed until this update */
+			if (sr && l_queue_peek_head(sc->requests) == sr)
+				start_next_scan_request(&sr->work);
+
+			sc->sp.wait_on_regdom = false;
+		}
+
+		break;
+	default:
+		return;
+	}
+
+done:
+	scan_freq_set_free(allowed);
+}
+
+/*
+ * Should only used to initialize 'expect_6ghz'. This is only to cover the case
+ * of a scan context being created during a regulatory update, which means it
+ * would miss the START event. If a DONE event comes, and expect_6ghz is false,
+ * no further action would be taken which may be incorrect.
+ */
+static bool scan_expect_6ghz(struct wiphy *wiphy)
+{
+	const struct scan_freq_set *supported =
+					wiphy_get_supported_freqs(wiphy);
+
+	if (!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ))
+		return false;
+
+	return wiphy_regdom_is_updating(wiphy);
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
+	sc->expect_6ghz = scan_expect_6ghz(wiphy);
+	sc->wiphy_watch_id = wiphy_state_watch_add(wiphy, scan_wiphy_watch,
+							sc, NULL);
+
+	return sc;
+}
+
 struct l_genl_msg *scan_build_trigger_scan_bss(uint32_t ifindex,
 						struct wiphy *wiphy,
 						uint32_t frequency,
@@ -2120,6 +2245,10 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 		if (sr && sr->triggered) {
 			sr->triggered = false;
 
+			/* Regdom changed during a periodic scan */
+			if (sc->sp.id == sr->work.id && sc->sp.wait_on_regdom)
+				return;
+
 			if (!sr->callback) {
 				scan_finished(sc, -ECANCELED, NULL, NULL, sr);
 				break;
-- 
2.34.3

