Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DB29AC
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 17:26:25 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id d3so2945877plr.10
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 09:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw/LXTkmcEjIn6ij5JNOYm+9X54kyb4McOKnjUJGnK4=;
        b=loIFxNFsQOOt3Q+T5oEJFPHw6e0PlNMta+icRbG+ufRAHPvo3awpbj0LPC068FRjXB
         MSrPOBiBXRErl4ekruBXD+BjZgZfzannGtJJdkBIg/JlCmVzIcGpS7n8DHT6JdxL4tnU
         Bt7zvGgJYujHQl7SffQeXHZ/r2l072/NKabr1eMybf3Ly/6rKWcotc5xVVMN+T9KTSGb
         C7QoxGtceyqn/SWwVw8WfpXFpTcKlfBYfoSn418snBMi2fZKptnaXKWiNr9kX0c+nDLz
         7Z1cyUZccE4pAHB0+F3rKQa4DLYlKJPQeEVU00w0sWQj9seOVydwRVLt2YS8hUr45Vkm
         q1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw/LXTkmcEjIn6ij5JNOYm+9X54kyb4McOKnjUJGnK4=;
        b=M6COdqLoQhsGfmZLCcEdPcmBN49ci1P+NuXeb59iqkK364BU6fjgUU0RGgLL7tlWcw
         O6jHiY5tmoiaMFRHvCq4NRDCpH1ruqSr82SIYjrnmHnhKbxYj9O5WInREeR1/412n/Hc
         1mA6E6SmyTpZGi4ZmPHSIYEd7po6kTyReetc6+AUE0gPyt3k9w3hcvMEd0Gt0h830tkK
         PtcaZye8UrQDf6nHR5YRo3CJQd5VdM4lcavTMz+JbD2zT6F+hoq1g2kKtXnXQZ2/3wOr
         GgqCNV5fRFnNnzOiRsgeLWD5BlaRs4IgPbyuNwczafyF3zXeaa/AtTeK19JMUmafyb+f
         l5tQ==
X-Gm-Message-State: ANoB5pk5P3+MrYNhVGxp9iDOUT0SxIkLs86A/D6c2etXunM7wqOx1QVx
	7U/PIn/YTF7Bd5ew03MWZ/RfOMNUk+M=
X-Google-Smtp-Source: AA0mqf5hVTYx8kC6yVadKJXmgsXEiGoyLm+n1OzqUq9DvPCz/lIfFzqCrHlE00/A2Vz0GoENdCfV5Q==
X-Received: by 2002:a17:902:768b:b0:186:865c:ea17 with SMTP id m11-20020a170902768b00b00186865cea17mr31637139pll.38.1671211584811;
        Fri, 16 Dec 2022 09:26:24 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm1913636plx.44.2022.12.16.09.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:26:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 8/8] wiphy: remove disabled_freqs and related dump code
Date: Fri, 16 Dec 2022 09:26:06 -0800
Message-Id: <20221216172606.1799396-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216172606.1799396-1-prestwoj@gmail.com>
References: <20221216172606.1799396-1-prestwoj@gmail.com>
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
index 7b72b6be..7d06aa3f 100644
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
@@ -2029,9 +2020,6 @@ static void wiphy_dump_done(void *user_data)
 
 	if (wiphy) {
 		wiphy->dump_id = 0;
-		scan_freq_set_free(wiphy->disabled_freqs);
-		wiphy->disabled_freqs = wiphy->pending_freqs;
-		wiphy->pending_freqs = NULL;
 
 		WATCHLIST_NOTIFY(&wiphy->state_watches,
 				wiphy_state_watch_func_t, wiphy,
@@ -2045,13 +2033,9 @@ static void wiphy_dump_done(void *user_data)
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
@@ -2121,33 +2105,18 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 
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
@@ -2192,7 +2161,6 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 	/* Limited dump so just emit the event for this wiphy */
 	if (wiphy) {
 		wiphy->dump_id = id;
-		wiphy->pending_freqs = scan_freq_set_new();
 
 		if (no_start_event)
 			return;
@@ -2212,8 +2180,6 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 		if (w->self_managed)
 			continue;
 
-		w->pending_freqs = scan_freq_set_new();
-
 		if (no_start_event)
 			continue;
 
diff --git a/src/wiphy.h b/src/wiphy.h
index 8411318a..27f4b7f3 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -100,7 +100,6 @@ const char *wiphy_get_path(struct wiphy *wiphy);
 uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
-const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
 
 bool wiphy_get_frequency_info(const struct wiphy *wiphy, uint32_t freq,
 				struct band_freq_attrs *attr_out);
-- 
2.34.3

