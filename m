Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC2A480
	for <iwd@lists.linux.dev>; Thu,  8 Dec 2022 23:48:19 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id 140so2514321pfz.6
        for <iwd@lists.linux.dev>; Thu, 08 Dec 2022 15:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY27r6VV9EGnwsY3q7cRIeqts5AhXIbdJYB/93nKAco=;
        b=e2xeAZ+TBkytvRDVHI0PB2C4Qi/iq7wlpvVVxrL99DkMrgvDRw6yeXrodsO3NhhgIm
         VyPDqwAExJSHeA2BiVCacTv5drcp530HfQInKoUBPE6IzuhJ59HbKJX2ikuylsBIhBs1
         RKMTEj981wSkVwz21ZQ9cU3csdX/XMJjUrtedm5V5YM+yvsp0vzgDeyp0L3/arEoRUuP
         Athjwndy2nPlOOrREITl8ppHo5I5pzIpntuPgE0v6cnVdPeZpJ/5qEmwL0pFMnDDPixr
         W1jQYN0S/+iZ6wyLS/XrO7VDogtcN8Pi8+jY4675jpSlT8pYa9VoFpPfU2juRrDgrN/b
         UFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY27r6VV9EGnwsY3q7cRIeqts5AhXIbdJYB/93nKAco=;
        b=GB/QAdbpFwMBXfjZU+nq0StnMgKnRTAqwkEoik9WsWqoY2c9eA+paWCIU0bGqzROXz
         RlosiuB4n+wcqdXQ+KfCZwkArHvx63w2+9J2Iin5v2YLuB7h4yp9Syb8vEiHzk95EHbP
         /u20aQswheEarIjdr/nuITb3+VrwhoOVouIMYPq49uTgnordnyh3jAI7yTtwQNbyO0eA
         ZhR86r5SPMLKRHrc0n9z7+lOBoJcXlb2C86iFor5qiG1vYpYNJhL+QDAfQ3IH9u0ra5i
         QTq/u0zgxxEa4loB2/wTq/xcjo7ZoF+N8c/M41+itoWpsmt+aZL2mr3cndKdTYWyzYQf
         Ucew==
X-Gm-Message-State: ANoB5pkVcZ2huleeE47GSEcCpeJRFKxwu5+N8qot6rBycZi2L+ngjdLJ
	pvKFLvncXZoHhFLpVuscVtP1q/ziaeo=
X-Google-Smtp-Source: AA0mqf44IBZwkcJWMNCo8+VySjuAzFBpqQjbM/GJZ4dhj/LMxhMold9oEKQl1ar/DudD63s82A9i9g==
X-Received: by 2002:a62:3846:0:b0:577:7cfb:a896 with SMTP id f67-20020a623846000000b005777cfba896mr3994567pfa.31.1670543299282;
        Thu, 08 Dec 2022 15:48:19 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id f67-20020a62db46000000b005767cb32fdasm41392pfg.188.2022.12.08.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:48:18 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] wiphy: track no-IR frequencies
Date: Thu,  8 Dec 2022 15:48:09 -0800
Message-Id: <20221208234812.778191-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221208234812.778191-1-prestwoj@gmail.com>
References: <20221208234812.778191-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track these frequencies as is done with disabled frequencies, and
update on regulatory changes. AP mode needs to know if any
frequencies are marked no-IR since it cannot start on these.
---
 src/wiphy.c | 59 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 4744e7f4..af0443bc 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -106,7 +106,9 @@ struct wiphy {
 	uint16_t supported_ciphers;
 	struct scan_freq_set *supported_freqs;
 	struct scan_freq_set *disabled_freqs;
-	struct scan_freq_set *pending_freqs;
+	struct scan_freq_set *no_ir_freqs;
+	struct scan_freq_set *pending_disabled_freqs;
+	struct scan_freq_set *pending_no_ir_freqs;
 	struct band *band_2g;
 	struct band *band_5g;
 	struct band *band_6g;
@@ -346,6 +348,7 @@ static struct wiphy *wiphy_new(uint32_t id)
 	wiphy->id = id;
 	wiphy->supported_freqs = scan_freq_set_new();
 	wiphy->disabled_freqs = scan_freq_set_new();
+	wiphy->no_ir_freqs = scan_freq_set_new();
 	watchlist_init(&wiphy->state_watches, NULL);
 	wiphy->extended_capabilities[0] = IE_TYPE_EXTENDED_CAPABILITIES;
 	wiphy->extended_capabilities[1] = EXT_CAP_LEN;
@@ -951,7 +954,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 
 bool wiphy_regdom_is_updating(struct wiphy *wiphy)
 {
-	return wiphy->pending_freqs != NULL;
+	return wiphy->pending_disabled_freqs != NULL;
 }
 
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
@@ -1515,7 +1518,7 @@ static void parse_supported_bands(struct wiphy *wiphy,
 				nl80211_parse_supported_frequencies(&attr,
 							wiphy->supported_freqs,
 							wiphy->disabled_freqs,
-							NULL);
+							wiphy->no_ir_freqs);
 				break;
 
 			case NL80211_BAND_ATTR_RATES:
@@ -1921,6 +1924,16 @@ static void wiphy_setup_rm_enabled_capabilities(struct wiphy *wiphy)
 	 */
 }
 
+static void wiphy_set_pending_freqs(struct wiphy *wiphy)
+{
+	scan_freq_set_free(wiphy->disabled_freqs);
+	scan_freq_set_free(wiphy->no_ir_freqs);
+	wiphy->disabled_freqs = wiphy->pending_disabled_freqs;
+	wiphy->no_ir_freqs = wiphy->pending_no_ir_freqs;
+	wiphy->pending_disabled_freqs = NULL;
+	wiphy->pending_no_ir_freqs = NULL;
+}
+
 static void wiphy_dump_done(void *user_data)
 {
 	struct wiphy *wiphy = user_data;
@@ -1932,9 +1945,8 @@ static void wiphy_dump_done(void *user_data)
 
 	if (wiphy) {
 		wiphy->dump_id = 0;
-		scan_freq_set_free(wiphy->disabled_freqs);
-		wiphy->disabled_freqs = wiphy->pending_freqs;
-		wiphy->pending_freqs = NULL;
+
+		wiphy_set_pending_freqs(wiphy);
 
 		WATCHLIST_NOTIFY(&wiphy->state_watches,
 				wiphy_state_watch_func_t, wiphy,
@@ -1948,12 +1960,10 @@ static void wiphy_dump_done(void *user_data)
 	for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
 		wiphy = e->data;
 
-		if (!wiphy->pending_freqs || wiphy->self_managed)
+		if (!wiphy->pending_disabled_freqs || wiphy->self_managed)
 			continue;
 
-		scan_freq_set_free(wiphy->disabled_freqs);
-		wiphy->disabled_freqs = wiphy->pending_freqs;
-		wiphy->pending_freqs = NULL;
+		wiphy_set_pending_freqs(wiphy);
 
 		WATCHLIST_NOTIFY(&wiphy->state_watches,
 				wiphy_state_watch_func_t, wiphy,
@@ -1989,8 +1999,8 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 				continue;
 
 			nl80211_parse_supported_frequencies(&attr, NULL,
-						wiphy->pending_freqs,
-						NULL);
+						wiphy->pending_disabled_freqs,
+						wiphy->pending_no_ir_freqs);
 		}
 	}
 }
@@ -2002,15 +2012,18 @@ static bool wiphy_cancel_last_dump(struct wiphy *wiphy)
 
 	/*
 	 * Zero command ID to signal that wiphy_dump_done doesn't need to do
-	 * anything. For a self-managed wiphy just free/NULL pending_freqs. For
-	 * a global dump each wiphy needs to be checked and dealt with.
+	 * anything. For a self-managed wiphy just free/NULL
+	 * pending_disabled_freqs. For a global dump each wiphy needs to be
+	 * checked and dealt with.
 	 */
 	if (wiphy && wiphy->dump_id) {
 		id = wiphy->dump_id;
 		wiphy->dump_id = 0;
 
-		scan_freq_set_free(wiphy->pending_freqs);
-		wiphy->pending_freqs = NULL;
+		scan_freq_set_free(wiphy->pending_disabled_freqs);
+		scan_freq_set_free(wiphy->pending_no_ir_freqs);
+		wiphy->pending_disabled_freqs = NULL;
+		wiphy->pending_no_ir_freqs = NULL;
 	} else if (!wiphy && wiphy_dump_id) {
 		id = wiphy_dump_id;
 		wiphy_dump_id = 0;
@@ -2018,11 +2031,13 @@ static bool wiphy_cancel_last_dump(struct wiphy *wiphy)
 		for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
 			struct wiphy *w = e->data;
 
-			if (!w->pending_freqs || w->self_managed)
+			if (!w->pending_disabled_freqs || w->self_managed)
 				continue;
 
-			scan_freq_set_free(w->pending_freqs);
-			w->pending_freqs = NULL;
+			scan_freq_set_free(w->pending_disabled_freqs);
+			scan_freq_set_free(w->pending_no_ir_freqs);
+			w->pending_disabled_freqs = NULL;
+			w->pending_no_ir_freqs = NULL;
 		}
 	}
 
@@ -2068,7 +2083,8 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 	/* Limited dump so just emit the event for this wiphy */
 	if (wiphy) {
 		wiphy->dump_id = id;
-		wiphy->pending_freqs = scan_freq_set_new();
+		wiphy->pending_disabled_freqs = scan_freq_set_new();
+		wiphy->pending_no_ir_freqs = scan_freq_set_new();
 
 		if (no_start_event)
 			return;
@@ -2088,7 +2104,8 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 		if (w->self_managed)
 			continue;
 
-		w->pending_freqs = scan_freq_set_new();
+		w->pending_disabled_freqs = scan_freq_set_new();
+		w->pending_no_ir_freqs = scan_freq_set_new();
 
 		if (no_start_event)
 			continue;
-- 
2.34.3

