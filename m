Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29C8BE4
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 21:27:51 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d15so3552214pls.6
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlS97Z3hCrtARLTNqZypWK9XF0Bh04mG7Dh5mTeHizM=;
        b=MLgre3b9+K/cVm9eRHEvq4nvDAgEXbgigMh4oJnGRYfHXPptG1+8DpHoPWcvHC2ie/
         eN1c0iulS++cOFJhH8ozXBts9Fh7CulwNgxQCP4U1L1zoxoYmOHxOUh0CsBkVpKZ8zDE
         mHUr6bum2D9S+7O9vOWXozIWh8rywU8Aj6BglazJybvx7KNhn6GTf99SlIWBrL71cXAD
         j57Z23TikkkgoBLFysZw1SV8QxS5IlpkzvwUo5n/mmdth120cAwFv3OAbEpDefHQ4/W7
         k+9HwU47wcrkFW3+c4Y8exH71cpqvopcDX/aSRn8/iae87EB6XK8xHh+oHALXrzfnViw
         omUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlS97Z3hCrtARLTNqZypWK9XF0Bh04mG7Dh5mTeHizM=;
        b=lcYTzi4pieY58lNZsTfQQU82eG+FanuWu+87Jblukfb4zic4iXETR5rOPvtuQiQ/3J
         1Dr0B3bgVqbVZg0oSw0lQNCYXxeBTGcr8Em6aXKAii6Ped1YoO9nzwaMTjtSD9PW3ASr
         98XnXYM8SdzgJbzF7DLAa7iupRH31l+7ly/pXYI4EYaYfVOai14UNTb5R7qvAoKxayUt
         X7oQymwm2bbKwkkxop5BJeUv1Jev1J3/3D0vZGfwWdkcGgAe6fSNzEohwRdq8x3KnHJj
         xUf8ESg6/2RAkINkeZfYC2YMqNc1DLpzgpibMwntrzOA/BOA0WI8baVyJLzEHcpOmVSc
         sJ6Q==
X-Gm-Message-State: ANoB5pnS6GGtHzueCSSo6Wapv6BHdMELZ5mBS8ls3SYJd7ZxSRZp4Gxq
	bKVwBq7FsaVO1QnJWZNBnALP39wXTyo=
X-Google-Smtp-Source: AA0mqf7jLcmgweyZXaGqg7GcwI0JQYiWDyfcGZ/umxQCXT1j1X5MPoKvP1eKG9XZ0uHma9wllcROQg==
X-Received: by 2002:a05:6a20:3210:b0:a3:6f97:e658 with SMTP id y16-20020a056a20321000b000a36f97e658mr56060637pzc.58.1671226071089;
        Fri, 16 Dec 2022 13:27:51 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b004785e505bcdsm1905404pgz.51.2022.12.16.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:27:50 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 8/8] wiphy: remove disabled_freqs and related dump code
Date: Fri, 16 Dec 2022 13:27:41 -0800
Message-Id: <20221216212741.1833286-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216212741.1833286-1-prestwoj@gmail.com>
References: <20221216212741.1833286-1-prestwoj@gmail.com>
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
index 714da9bc..4ea7c3f8 100644
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
@@ -2003,9 +1994,6 @@ static void wiphy_dump_done(void *user_data)
 
 	if (wiphy) {
 		wiphy->dump_id = 0;
-		scan_freq_set_free(wiphy->disabled_freqs);
-		wiphy->disabled_freqs = wiphy->pending_freqs;
-		wiphy->pending_freqs = NULL;
 
 		WATCHLIST_NOTIFY(&wiphy->state_watches,
 				wiphy_state_watch_func_t, wiphy,
@@ -2019,13 +2007,9 @@ static void wiphy_dump_done(void *user_data)
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
@@ -2095,33 +2079,18 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 
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
@@ -2166,7 +2135,6 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 	/* Limited dump so just emit the event for this wiphy */
 	if (wiphy) {
 		wiphy->dump_id = id;
-		wiphy->pending_freqs = scan_freq_set_new();
 
 		if (no_start_event)
 			return;
@@ -2186,8 +2154,6 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 		if (w->self_managed)
 			continue;
 
-		w->pending_freqs = scan_freq_set_new();
-
 		if (no_start_event)
 			continue;
 
diff --git a/src/wiphy.h b/src/wiphy.h
index c1919b4c..6616da61 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -100,7 +100,6 @@ const char *wiphy_get_path(struct wiphy *wiphy);
 uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
-const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
 
 const struct band_freq_attrs *wiphy_get_frequency_info(
 						const struct wiphy *wiphy,
-- 
2.34.3

