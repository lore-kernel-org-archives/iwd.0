Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737D8BE5
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 21:27:47 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id n4so3577505plp.1
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 13:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jQMzcO0uR64xROqAzCyXdPXu0ZvqOvLqo/eTOcf2oo=;
        b=oCZO0nKJIRdr+NxGFUehmJjvXay4K9N+zfMnLTSIM4zmr5txUwEhdsU795gbtG2waZ
         dNVXK8dsamikmt5T2U2A8Z125ugMfmapl5vgQZg2k6fel4bLB0ybdsQTHzO78TKvQHav
         dDNQ4/TSFh2U5Al2+fWRTwMLI0TJ0yD5RDsZ9LeDy6hzLAVWT35JbSpYCW7jQWuhRpIB
         VfYR/7Xn9nxQEUWldSyguo/K4ytM8CHhyPVwTmf7lo55SnPZT1bZ4WjOwXKC8ZcJpGM3
         TleopbhOXepmp6kpGtcftcZYACOlhsBydfgAZWBUbNTefjZ4xmrtTgWKu0XjxHU1ZO3Z
         yDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jQMzcO0uR64xROqAzCyXdPXu0ZvqOvLqo/eTOcf2oo=;
        b=gww/tzc5RO0qmptGXAoR4aNjxmNK2JMMNJCqGzJghHaJ3lVVla1aLBdIEDwpkIKsXt
         MRAz+OJWDQWCDzTY0KqcAbhEwdEQn9rlcI4MoJQX+2vqKg4PkrDbleFs292HJJZA2X9F
         rXEBUW1go2RvODR2tuExijA9+430a4QNV4WNws6SAb16lbpH5SSTQrwJjmsR2N/POjtR
         CVRNkwxj7Z5actzOvRecCa0RTU2VddC7WqJ6WiqzyMAavEHj+5RdLZ0E51bpiDxg+pg/
         TGIS8d/skeRA5sFx9vevFBE5PEqlmPbjFRBZnLiEVZByUSe/8l+Zv+Zyhld5kGwArJA+
         rw/g==
X-Gm-Message-State: ANoB5pl40lfM3cJzIuQ7ybjMVqJ95Whh920WZN0SqxChdSmZh1GagNIQ
	gi+9a17ToIwfLEL9nlQY94sojLNLCkU=
X-Google-Smtp-Source: AA0mqf5w95DSsq7+MGZJGB2A8F/Ka8SMB9Nuh8KHb/305HCTARGSSgC/of+QUzD95eV3NpioyRvp/w==
X-Received: by 2002:a17:90a:4685:b0:221:71fb:387a with SMTP id z5-20020a17090a468500b0022171fb387amr18672987pjf.40.1671226066992;
        Fri, 16 Dec 2022 13:27:46 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b004785e505bcdsm1905404pgz.51.2022.12.16.13.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:27:46 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/8] wiphy: parse/store frequency info in band object
Date: Fri, 16 Dec 2022 13:27:35 -0800
Message-Id: <20221216212741.1833286-2-prestwoj@gmail.com>
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

