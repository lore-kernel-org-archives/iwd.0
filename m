Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4AB23A7
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:36:32 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id fy4so4683993pjb.0
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFLHIlYMqpETMIkWpY5nQdiElLfdcu0YuZVEnntzEfM=;
        b=bk4ApI+uVadCbP2Sws3OirWjW0WR1GWRrOdyzetFhtGpAS+rYEggIdkfnCeI/pWM4O
         7t1gjyeiUK4OUnl7wukZCNWwTtvQNDuNWRYldgmCtXjREgBvvG1VBLjOdqSmfQx1c0gt
         wpwQDtusrVYFYghg10BySsjA1FjfhdpcRGkVOVnutr+Fsd967hMo5V6tUSjH13AxjVRp
         f6K7abpSHe4/33vsY0I5FpuqCCiZOWWTbAlIXD7WGOMGG+Z/qIQ92I2zI9ZtzjmsY9mJ
         Egb/yhLcKMlmMDok4850x+ss5mjSTLcoQGr+AuPfOzkNsS4PZjJHAA+J8nglhxlg0whw
         zPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFLHIlYMqpETMIkWpY5nQdiElLfdcu0YuZVEnntzEfM=;
        b=yMV4Qn1zXIeW0wiONiqxZ1TyfkEAbxvw8IMTp/0iWHWSWK4Y4KRsUIsMXIdBtmRMa5
         B+6plkit0mjycFpoe3U5IETFpWWTgyeD3P/6pS1z0VlqVOYCHUXtM/B3caBQ7RJR/8GH
         AMWXBkOC/uPBeqqksxl5wvn8i4shfFMIPSUwqnxDUX+NIyAYNsxitwVIG4eqVXlAMoW3
         Eqj8ubjtLC9u9RTqcqdTWJ85dJauKu3BavOQNUGftCS4T3ythD+v4S2ZcS0LtbUPx0cj
         poS+U92z8XxUC8FBdi77BYlzMkoONlrqNJddp4KdQpu/7J/qYR2LcGLBADL44I88oVNf
         5fgw==
X-Gm-Message-State: ANoB5pmAnz7pwDuxMxaSAVjbSzvW+4reGkVfVExVu6g/mrSfMTCTjHBa
	gn0GZ38lEjVaW5Oxj8bln1DYTjoHR7U=
X-Google-Smtp-Source: AA0mqf6OAUDmtHN9zu4mMlMKsY0o9qHEsFzc+GE2zas9/3qEi8/9zD0z8a6HKuDo3YvxZ5937QouUQ==
X-Received: by 2002:a17:902:9044:b0:186:daeb:bc0a with SMTP id w4-20020a170902904400b00186daebbc0amr20346880plz.67.1670963792161;
        Tue, 13 Dec 2022 12:36:32 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b00189f69c1aa0sm272113plo.270.2022.12.13.12.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:36:31 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] wiphy: parse/store frequency info in band object
Date: Tue, 13 Dec 2022 12:36:20 -0800
Message-Id: <20221213203624.1423277-3-prestwoj@gmail.com>
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

As additional frequency info is needed it doesn't make sense to
store a full list of frequencies for every attribute (i.e.
supported, disabled, no-IR, etc).

This changes nl80211_parse_supported_frequencies to take a uint16_t
array where each index corresponds to a channel, and each value
can be filled with flag bits to signal any limitations on that
frequency.

wiphy.c then had to be updated to use this rather than the existing
scan_freq_set lists. This, as-is, will break anything using
wiphy_get_disabled_freqs().
---
 src/nl80211util.c |  19 +++++----
 src/nl80211util.h |   3 +-
 src/wiphy.c       | 105 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 109 insertions(+), 18 deletions(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index da36d936..a2cd882d 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -501,20 +501,20 @@ int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out)
 }
 
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
-					struct scan_freq_set *supported_list,
-					struct scan_freq_set *disabled_list)
+					uint16_t *list, size_t num_channels)
 {
 	uint16_t type, len;
 	const void *data;
 	struct l_genl_attr attr;
 	struct l_genl_attr nested;
+	uint8_t channel;
 
 	if (!l_genl_attr_recurse(band_freqs, &nested))
 		return -EBADMSG;
 
 	while (l_genl_attr_next(&nested, NULL, NULL, NULL)) {
 		uint32_t freq = 0;
-		bool disabled = false;
+		uint16_t flags = BAND_FREQ_ATTR_SUPPORTED;
 
 		if (!l_genl_attr_recurse(&nested, &attr))
 			continue;
@@ -525,7 +525,10 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 				freq = *((uint32_t *) data);
 				break;
 			case NL80211_FREQUENCY_ATTR_DISABLED:
-				disabled = true;
+				flags |= BAND_FREQ_ATTR_DISABLED;
+				break;
+			case NL80211_FREQUENCY_ATTR_NO_IR:
+				flags |= BAND_FREQ_ATTR_NO_IR;
 				break;
 			}
 		}
@@ -533,11 +536,11 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 		if (!freq)
 			continue;
 
-		if (supported_list)
-			scan_freq_set_add(supported_list, freq);
+		channel = band_freq_to_channel(freq, NULL);
+		if (!channel || channel > num_channels)
+			continue;
 
-		if (disabled && disabled_list)
-			scan_freq_set_add(disabled_list, freq);
+		list[channel] = flags;
 	}
 
 	return 0;
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 44555a25..f12f4695 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -58,5 +58,4 @@ struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
 
 int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out);
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
-					struct scan_freq_set *supported,
-					struct scan_freq_set *disabled);
+					uint16_t *list, size_t num_channels);
diff --git a/src/wiphy.c b/src/wiphy.c
index 37e0cdb8..c8ef5937 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -745,8 +745,33 @@ void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssid,
 bool wiphy_constrain_freq_set(const struct wiphy *wiphy,
 						struct scan_freq_set *set)
 {
+	struct band *bands[3] = { wiphy->band_2g,
+					wiphy->band_5g, wiphy->band_6g };
+	unsigned int b;
+	unsigned int i;
+
 	scan_freq_set_constrain(set, wiphy->supported_freqs);
-	scan_freq_set_subtract(set, wiphy->disabled_freqs);
+
+	for (b = 0; b < L_ARRAY_SIZE(bands); b++) {
+		struct band *band = bands[b];
+
+		if (!band)
+			continue;
+
+		for (i = 0; i < band->freqs_len; i++) {
+			uint32_t freq;
+
+			if (!(band->frequencies[i] & BAND_FREQ_ATTR_SUPPORTED))
+				continue;
+
+			freq = band_channel_to_freq(i, band->freq);
+			if (!freq)
+				continue;
+
+			if (band->frequencies[i] & BAND_FREQ_ATTR_DISABLED)
+				scan_freq_set_remove(set, freq);
+		}
+	}
 
 	if (!scan_freq_set_get_bands(set))
 		/* The set is empty. */
@@ -952,7 +977,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 
 bool wiphy_regdom_is_updating(struct wiphy *wiphy)
 {
-	return wiphy->pending_freqs != NULL;
+	return wiphy->dump_id || (!wiphy->self_managed && wiphy_dump_id);
 }
 
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
@@ -1471,19 +1496,23 @@ static void parse_supported_bands(struct wiphy *wiphy,
 		struct band **bandp;
 		struct band *band;
 		enum band_freq freq;
+		size_t num_channels;
 
 		switch (type) {
 		case NL80211_BAND_2GHZ:
 			bandp = &wiphy->band_2g;
 			freq = BAND_FREQ_2_4_GHZ;
+			num_channels = 14;
 			break;
 		case NL80211_BAND_5GHZ:
 			bandp = &wiphy->band_5g;
 			freq = BAND_FREQ_5_GHZ;
+			num_channels = 196;
 			break;
 		case NL80211_BAND_6GHZ:
 			bandp = &wiphy->band_6g;
 			freq = BAND_FREQ_6_GHZ;
+			num_channels = 233;
 			break;
 		default:
 			continue;
@@ -1498,6 +1527,8 @@ static void parse_supported_bands(struct wiphy *wiphy,
 				continue;
 
 			band->freq = freq;
+			band->frequencies = l_new(uint16_t, num_channels);
+			band->freqs_len = num_channels;
 
 			/* Reset iter to beginning */
 			if (!l_genl_attr_recurse(bands, &attr)) {
@@ -1507,15 +1538,14 @@ static void parse_supported_bands(struct wiphy *wiphy,
 		} else
 			band = *bandp;
 
-
 		while (l_genl_attr_next(&attr, &type, &len, &data)) {
 			struct l_genl_attr nested;
 
 			switch (type) {
 			case NL80211_BAND_ATTR_FREQS:
 				nl80211_parse_supported_frequencies(&attr,
-							wiphy->supported_freqs,
-							wiphy->disabled_freqs);
+							band->frequencies,
+							band->freqs_len);
 				break;
 
 			case NL80211_BAND_ATTR_RATES:
@@ -1970,6 +2000,7 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 	struct l_genl_attr bands;
 	struct l_genl_attr attr;
 	uint16_t type;
+	struct band *band;
 
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &id,
 					NL80211_ATTR_WIPHY_BANDS, &bands,
@@ -1980,7 +2011,28 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 	if (L_WARN_ON(!wiphy))
 		return;
 
-	while (l_genl_attr_next(&bands, NULL, NULL, NULL)) {
+	/* Unregistered means the wiphy is blacklisted, don't bother parsing */
+	if (!wiphy->registered)
+		return;
+
+	while (l_genl_attr_next(&bands, &type, NULL, NULL)) {
+		switch (type) {
+		case NL80211_BAND_2GHZ:
+			band = wiphy->band_2g;
+			break;
+		case NL80211_BAND_5GHZ:
+			band = wiphy->band_5g;
+			break;
+		case NL80211_BAND_6GHZ:
+			band = wiphy->band_6g;
+			break;
+		default:
+			continue;
+		}
+
+		if (L_WARN_ON(!band))
+			continue;
+
 		if (!l_genl_attr_recurse(&bands, &attr))
 			return;
 
@@ -1988,8 +2040,14 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 			if (type != NL80211_BAND_ATTR_FREQS)
 				continue;
 
-			nl80211_parse_supported_frequencies(&attr, NULL,
-							wiphy->pending_freqs);
+			/*
+			 * Just write over the old list for each frequency. In
+			 * theory no new frequencies should be added so there
+			 * should never be any stale values.
+			 */
+			nl80211_parse_supported_frequencies(&attr,
+							band->frequencies,
+							band->freqs_len);
 		}
 	}
 }
@@ -2178,6 +2236,36 @@ static void wiphy_get_reg_domain(struct wiphy *wiphy)
 	}
 }
 
+static void setup_supported_freqs(struct wiphy *wiphy)
+{
+	struct band *bands[3] = { wiphy->band_2g,
+					wiphy->band_5g, wiphy->band_6g };
+	unsigned int b;
+	unsigned int i;
+
+	wiphy->supported_freqs = scan_freq_set_new();
+
+	for (b = 0; b < L_ARRAY_SIZE(bands); b++) {
+		struct band *band = bands[b];
+
+		if (!band)
+			continue;
+
+		for (i = 0; i < band->freqs_len; i++) {
+			uint32_t freq;
+
+			if (!(band->frequencies[i] & BAND_FREQ_ATTR_SUPPORTED))
+				continue;
+
+			freq = band_channel_to_freq(i, band->freq);
+			if (!freq)
+				continue;
+
+			scan_freq_set_add(wiphy->supported_freqs, freq);
+		}
+	}
+}
+
 void wiphy_create_complete(struct wiphy *wiphy)
 {
 	wiphy_register(wiphy);
@@ -2193,6 +2281,7 @@ void wiphy_create_complete(struct wiphy *wiphy)
 	wiphy_set_station_capability_bits(wiphy);
 	wiphy_setup_rm_enabled_capabilities(wiphy);
 	wiphy_get_reg_domain(wiphy);
+	setup_supported_freqs(wiphy);
 
 	wiphy_print_basic_info(wiphy);
 }
-- 
2.34.3

