Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE723B8
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 17:26:20 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d15so2972385pls.6
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 09:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jQMzcO0uR64xROqAzCyXdPXu0ZvqOvLqo/eTOcf2oo=;
        b=BsMM8U1T0m8wfJGVm2k9zyGq/yA0FKNVspKHOEpI+GCVUl7Laya5IC/FqAlbGEJogb
         B7qjicCfYu6K19aleKKrjIPUp8HKNtqPXmubuTCGVwm1peF9s0pSOLeKklWV8bQYqsqL
         9I12/F+vnrWcao2pyOOD9fxKBujtLUqdWm8gUpaHJVX4EP+Uh9ATLKGug6vj7jn3fRDQ
         c9NUjNb+G8AsOhsx9Qb/vUtAhP4cYRKeP6pWiXWaAp13bT05xtdlqfxxoYYlQP3/2lcJ
         pgJC2YpWJ1laivCmQyQQ8DIUkcgP/HODd1pABsmF+EoK6kUPP6hkcKp6myaqNrjBZhCN
         QRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jQMzcO0uR64xROqAzCyXdPXu0ZvqOvLqo/eTOcf2oo=;
        b=vScw005V39xTa1ZXH6P757+6RvZqTq4N6KFpw1zcE47E4g73/fbT4oYwGCy/JoZOlE
         R31UsLQa+sIkJ+nIxv8kJDhv9FUjpVC7oLdDXakSjpeZmSjsR2mKh2Db4YUmVtG+vwcq
         45F6MJ/PC9AZwyxYhrXr1aBQVNMmYm5MgGpmbmslXZwVdCevT/ZdodTgMbsHFoOqctWv
         O0ojP5I3bZE3slrN9VPddRzNPlsQltmkjJgd4jDOk5v3YqeI1liOldlOe2ecVCCZ+jby
         kaHW+I7kNgVSCNSyYAIV73eu24+0JIPpJBr8tO6fylxqIzJi5yo/B/XOhqFyRl5fvfx7
         /AuA==
X-Gm-Message-State: ANoB5pniSjdzLuBlo0r1QR7qRLBp4mGxtUKtIm4Zdv+eTG+JOc8ATVRG
	qEVw0xp6LKtfqYrq2for2NCjrixswiE=
X-Google-Smtp-Source: AA0mqf7efOg04LBHyVBQPv3hkotMqYPOnghLRhfzmFaIhEktgm21lCcEKE0OwocBI41HF44paT1+EA==
X-Received: by 2002:a05:6a20:42a2:b0:a3:c099:3a7a with SMTP id o34-20020a056a2042a200b000a3c0993a7amr47576636pzj.22.1671211580273;
        Fri, 16 Dec 2022 09:26:20 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm1913636plx.44.2022.12.16.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:26:19 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/8] wiphy: parse/store frequency info in band object
Date: Fri, 16 Dec 2022 09:26:00 -0800
Message-Id: <20221216172606.1799396-2-prestwoj@gmail.com>
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

As additional frequency info is needed it doesn't make sense to
store a full list of frequencies for every attribute (i.e.
supported, disabled, no-IR, etc).

This changes nl80211_parse_supported_frequencies to take a list
of frequency attributes where each index corresponds to a channel,
and each value can be filled with flag bits to signal any
limitations on that frequency.

wiphy.c then had to be updated to use this rather than the existing
scan_freq_set lists. This, as-is, will break anything using
wiphy_get_disabled_freqs().
---
 src/nl80211util.c | 22 +++++++++++----
 src/nl80211util.h |  6 +++--
 src/wiphy.c       | 68 +++++++++++++++++++++++++++++++++++++++++++----
 src/wiphy.h       |  2 ++
 4 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index da36d936..712cdec3 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -502,19 +502,21 @@ int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out)
 
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 					struct scan_freq_set *supported_list,
-					struct scan_freq_set *disabled_list)
+					struct band_freq_attrs *list,
+					size_t num_channels)
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
+		struct band_freq_attrs freq_attr = { 0 };
 
 		if (!l_genl_attr_recurse(&nested, &attr))
 			continue;
@@ -523,9 +525,13 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 			switch (type) {
 			case NL80211_FREQUENCY_ATTR_FREQ:
 				freq = *((uint32_t *) data);
+				freq_attr.supported = true;
 				break;
 			case NL80211_FREQUENCY_ATTR_DISABLED:
-				disabled = true;
+				freq_attr.disabled = true;
+				break;
+			case NL80211_FREQUENCY_ATTR_NO_IR:
+				freq_attr.no_ir = true;
 				break;
 			}
 		}
@@ -533,11 +539,17 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 		if (!freq)
 			continue;
 
+		channel = band_freq_to_channel(freq, NULL);
+		if (!channel)
+			continue;
+
+		if (L_WARN_ON(channel > num_channels))
+			continue;
+
 		if (supported_list)
 			scan_freq_set_add(supported_list, freq);
 
-		if (disabled && disabled_list)
-			scan_freq_set_add(disabled_list, freq);
+		list[channel] = freq_attr;
 	}
 
 	return 0;
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 44555a25..d26d286f 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -24,6 +24,7 @@
 
 struct band_chandef;
 struct scan_freq_set;
+struct band_freq_attrs;
 
 int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);
 
@@ -58,5 +59,6 @@ struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
 
 int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out);
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
-					struct scan_freq_set *supported,
-					struct scan_freq_set *disabled);
+					struct scan_freq_set *supported_list,
+					struct band_freq_attrs *list,
+					size_t num_channels);
diff --git a/src/wiphy.c b/src/wiphy.c
index 37e0cdb8..6b8f00a1 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -745,8 +745,35 @@ void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssid,
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
+			if (!band->freq_attrs[i].supported)
+				continue;
+
+			if (!band->freq_attrs[i].disabled)
+				continue;
+
+			freq = band_channel_to_freq(i, band->freq);
+			if (!freq)
+				continue;
+
+			scan_freq_set_remove(set, freq);
+		}
+	}
 
 	if (!scan_freq_set_get_bands(set))
 		/* The set is empty. */
@@ -1471,19 +1498,23 @@ static void parse_supported_bands(struct wiphy *wiphy,
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
@@ -1498,6 +1529,9 @@ static void parse_supported_bands(struct wiphy *wiphy,
 				continue;
 
 			band->freq = freq;
+			band->freq_attrs = l_new(struct band_freq_attrs,
+							num_channels);
+			band->freqs_len = num_channels;
 
 			/* Reset iter to beginning */
 			if (!l_genl_attr_recurse(bands, &attr)) {
@@ -1507,7 +1541,6 @@ static void parse_supported_bands(struct wiphy *wiphy,
 		} else
 			band = *bandp;
 
-
 		while (l_genl_attr_next(&attr, &type, &len, &data)) {
 			struct l_genl_attr nested;
 
@@ -1515,7 +1548,8 @@ static void parse_supported_bands(struct wiphy *wiphy,
 			case NL80211_BAND_ATTR_FREQS:
 				nl80211_parse_supported_frequencies(&attr,
 							wiphy->supported_freqs,
-							wiphy->disabled_freqs);
+							band->freq_attrs,
+							band->freqs_len);
 				break;
 
 			case NL80211_BAND_ATTR_RATES:
@@ -1970,6 +2004,7 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 	struct l_genl_attr bands;
 	struct l_genl_attr attr;
 	uint16_t type;
+	struct band *band;
 
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &id,
 					NL80211_ATTR_WIPHY_BANDS, &bands,
@@ -1980,7 +2015,24 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 	if (L_WARN_ON(!wiphy))
 		return;
 
-	while (l_genl_attr_next(&bands, NULL, NULL, NULL)) {
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
 
+			/*
+			 * Just write over the old list for each frequency. In
+			 * theory no new frequencies should be added so there
+			 * should never be any stale values.
+			 */
 			nl80211_parse_supported_frequencies(&attr, NULL,
-							wiphy->pending_freqs);
+							band->freq_attrs,
+							band->freqs_len);
 		}
 	}
 }
diff --git a/src/wiphy.h b/src/wiphy.h
index 410105dd..09dc4530 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -28,6 +28,7 @@ struct scan_bss;
 struct scan_freq_set;
 struct wiphy_radio_work_item;
 struct ie_rsn_info;
+struct band_freq_attrs;
 enum security;
 enum band_freq;
 
@@ -100,6 +101,7 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
+
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
 bool wiphy_can_offload(struct wiphy *wiphy);
-- 
2.34.3

