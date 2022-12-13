Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB86079EB
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:36:35 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so4789020pjo.3
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJXREFkvel0c4L4gtqez4v2nDnAVF4zkdtaZnt785yQ=;
        b=OM1XurCUfMo884TEtPUYK2RtjkvkEZmVlVhrg+bmatdxEIHUOX4iJNzcI+x2SF8AVO
         lVmO/wbpiuTnZduHHekspLD/r06a0gZDMaQ2F0I6+o31M+2KxwBNkStLYUWWHaPqUFGw
         G6fpOcBNF4frdoX5WxK1l8Kw0QdcgVf9Bbb6xjlf86jfynufZZ/B1miBg5vbgAbiCimC
         c/IR5FKcoqUpWbSdpH/sRS3QnxfZ+m+qlM9FeUApsSaNIxMT+3Gn1TDun99Vxa+k9xIc
         V5qgu0dyySnjAO+e24BkCpaNME6ign7lTK2C3BOI6N9nosHtCdgZmH2bv5a0S7/FgMch
         +pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJXREFkvel0c4L4gtqez4v2nDnAVF4zkdtaZnt785yQ=;
        b=MaQzwoAAPOsucHq0uM7XYWcU1Ve/5I/7PxLWLSi3OhnyyLCqLM1VODv84xMkUHTuGy
         aMWwTE5xc325YWF1sNGHtkM35A1xEk2I+TkS0NqrjTgLEiNPNL5bKPLdVHG/ICk0HttH
         yW7h5ussm96vcJ7y7c/NogZY6/ntyfkNRluarsoa6mw4M1RYlBT0CTn1xj72S7Ws7kok
         Yw5oP9ZGVwa/wFdHjWHDR2GS0l9RPhAEouXZae9yy/Kh6ecPso6qUIietw/xKm3dktja
         LZIUSJLwbhBG7Bhk4IunoRHkLWIs6oZQ7/tZL4ZlMiNKJKPXhTLePUvMa7JFee3iWBHm
         Qslg==
X-Gm-Message-State: ANoB5pkv6hgmW/nzk10KiXBIWzgg/yVxjSHeWY8lA65bDypaEN1WeJek
	CvflsMTelQPcLrKjVld07mLlYLRKtuQ=
X-Google-Smtp-Source: AA0mqf7OCH7mu65azVkoh+cAchqyyld6EApR199bM1+NA2YNVUrRh1Yb8g9dSiGDuXWnFABm3dA6/g==
X-Received: by 2002:a17:902:7fcc:b0:18f:15d2:308d with SMTP id t12-20020a1709027fcc00b0018f15d2308dmr12382262plb.42.1670963795195;
        Tue, 13 Dec 2022 12:36:35 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b00189f69c1aa0sm272113plo.270.2022.12.13.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:36:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] wiphy: remove disabled_freqs and related dump code
Date: Tue, 13 Dec 2022 12:36:24 -0800
Message-Id: <20221213203624.1423277-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221213203624.1423277-1-prestwoj@gmail.com>
References: <20221213203624.1423277-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The disabled_freqs list is being removed and replaced with a new
list in the band object. This completely removes the need for
the pending_freqs list as well since any regdom related dumps
can just overwrite the existing frequency list.
---
 src/wiphy.c | 38 ++------------------------------------
 src/wiphy.h |  1 -
 2 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index f5b7c05e..79dd2dff 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -105,8 +105,6 @@ struct wiphy {
 	uint16_t supported_iftypes;
 	uint16_t supported_ciphers;
 	struct scan_freq_set *supported_freqs;
-	struct scan_freq_set *disabled_freqs;
-	struct scan_freq_set *pending_freqs;
 	struct band *band_2g;
 	struct band *band_5g;
 	struct band *band_6g;
@@ -345,7 +343,6 @@ static struct wiphy *wiphy_new(uint32_t id)
 
 	wiphy->id = id;
 	wiphy->supported_freqs = scan_freq_set_new();
-	wiphy->disabled_freqs = scan_freq_set_new();
 	watchlist_init(&wiphy->state_watches, NULL);
 	wiphy->extended_capabilities[0] = IE_TYPE_EXTENDED_CAPABILITIES;
 	wiphy->extended_capabilities[1] = EXT_CAP_LEN;
@@ -393,7 +390,6 @@ static void wiphy_free(void *data)
 	}
 
 	scan_freq_set_free(wiphy->supported_freqs);
-	scan_freq_set_free(wiphy->disabled_freqs);
 	watchlist_destroy(&wiphy->state_watches);
 	l_free(wiphy->model_str);
 	l_free(wiphy->vendor_str);
@@ -491,11 +487,6 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 	return wiphy->supported_freqs;
 }
 
-const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy)
-{
-	return wiphy->disabled_freqs;
-}
-
 static struct band *wiphy_get_band(const struct wiphy *wiphy, enum band_freq band)
 {
 	switch (band) {
@@ -2051,9 +2042,6 @@ static void wiphy_dump_done(void *user_data)
 
 	if (wiphy) {
 		wiphy->dump_id = 0;
-		scan_freq_set_free(wiphy->disabled_freqs);
-		wiphy->disabled_freqs = wiphy->pending_freqs;
-		wiphy->pending_freqs = NULL;
 
 		WATCHLIST_NOTIFY(&wiphy->state_watches,
 				wiphy_state_watch_func_t, wiphy,
@@ -2067,13 +2055,9 @@ static void wiphy_dump_done(void *user_data)
 	for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
 		wiphy = e->data;
 
-		if (!wiphy->pending_freqs || wiphy->self_managed)
+		if (wiphy->self_managed)
 			continue;
 
-		scan_freq_set_free(wiphy->disabled_freqs);
-		wiphy->disabled_freqs = wiphy->pending_freqs;
-		wiphy->pending_freqs = NULL;
-
 		WATCHLIST_NOTIFY(&wiphy->state_watches,
 				wiphy_state_watch_func_t, wiphy,
 				WIPHY_STATE_WATCH_EVENT_REGDOM_DONE);
@@ -2143,33 +2127,18 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 
 static bool wiphy_cancel_last_dump(struct wiphy *wiphy)
 {
-	const struct l_queue_entry *e;
 	unsigned int id = 0;
 
 	/*
 	 * Zero command ID to signal that wiphy_dump_done doesn't need to do
-	 * anything. For a self-managed wiphy just free/NULL pending_freqs. For
-	 * a global dump each wiphy needs to be checked and dealt with.
+	 * anything.
 	 */
 	if (wiphy && wiphy->dump_id) {
 		id = wiphy->dump_id;
 		wiphy->dump_id = 0;
-
-		scan_freq_set_free(wiphy->pending_freqs);
-		wiphy->pending_freqs = NULL;
 	} else if (!wiphy && wiphy_dump_id) {
 		id = wiphy_dump_id;
 		wiphy_dump_id = 0;
-
-		for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
-			struct wiphy *w = e->data;
-
-			if (!w->pending_freqs || w->self_managed)
-				continue;
-
-			scan_freq_set_free(w->pending_freqs);
-			w->pending_freqs = NULL;
-		}
 	}
 
 	if (id) {
@@ -2214,7 +2183,6 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 	/* Limited dump so just emit the event for this wiphy */
 	if (wiphy) {
 		wiphy->dump_id = id;
-		wiphy->pending_freqs = scan_freq_set_new();
 
 		if (no_start_event)
 			return;
@@ -2234,8 +2202,6 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 		if (w->self_managed)
 			continue;
 
-		w->pending_freqs = scan_freq_set_new();
-
 		if (no_start_event)
 			continue;
 
diff --git a/src/wiphy.h b/src/wiphy.h
index 469ccdc8..09ddca65 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -99,7 +99,6 @@ const char *wiphy_get_path(struct wiphy *wiphy);
 uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
-const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
 bool wiphy_check_frequency(const struct wiphy *wiphy, uint32_t freq,
 				uint16_t flags);
 bool wiphy_check_band(const struct wiphy *wiphy, enum band_freq band,
-- 
2.34.3

