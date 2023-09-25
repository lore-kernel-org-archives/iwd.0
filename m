Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F4D304
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 18:54:47 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59f4bc88f9fso58197227b3.2
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668087; x=1696272887; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDy28uXZrbGTpOP0KLpU8nD9DUXgLGSe8pMEDTV5SB4=;
        b=ZqhqYfd6izfmWoYVWFFNKJ81MpOmZJP7Kc+/C04Ax8HNluPDX/r4Dogr3t1MQEPoea
         CGk+JNKiKFO6sJFhgZIGW3cGjvwCMLpwbLesVncQ+MbKGXKVlFgKqA7vqW/nixOj+I51
         jnaZdgNkOTpR1ajjwi11dKKpel1/hRXxv/vywp+qxRtptQdo8lPlzIUQaoq97eK+o5da
         6mNRrcoGWNFaawMlmksG2cvKv+McktkA8vzIx55XLkReu+vcb3zKLCle5O5zOoH7XEQI
         FdiXiEEbtnii81NjijR9xuBTTCqY5MrVV4c2Ra8rOCm5oFdvtZ69JjzJMGcRqHwGiUHW
         XwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668087; x=1696272887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDy28uXZrbGTpOP0KLpU8nD9DUXgLGSe8pMEDTV5SB4=;
        b=fR9z9Ny0DqGtOyj9NhtfUdt2CT9Qsf1NFRKicp17KwYMOkjdCgn3gR1nY/WQdYhQmT
         vjE2qxot1imSlSKCaWs4DbA1caCw6wgibiojnkf7cCSqxhAv3IoxDMAofri12undQHDN
         vLoALxyKNCHmC6ti6um5BmsEpw9yx+9SZ8lWPWaeK1JbY3bx3fJFIvHm0W/t/BOqjeW6
         IJpE/d4oc2P2ss0XlVKyxgiExcy3aGHKZHj+WlDtP1QdNpl9RgQN9IzaGnFVJTEGsWow
         ciALtu3rS7kw0NyVM/rZ5ea2A8g/j94YYbAd0i3oxG9ktsXyftkkkPKgpnvC2RFwzAdB
         J2Zw==
X-Gm-Message-State: AOJu0YzxcTr/jVK2JheVHljWuBj9KMnv0Zl6e/+hUvGE3ekhF8DcqpYL
	cdiVgC7aIu6wiQ0NqaJlXTjG1H7muCs=
X-Google-Smtp-Source: AGHT+IHQCiAOqxVceCwICydKYNAaDRS//P9jRS5muf5Ch2eIVCH4Lds9dWpH9SK57nfWiZEcRkoUyg==
X-Received: by 2002:a0d:f2c1:0:b0:586:9c7a:d9ec with SMTP id b184-20020a0df2c1000000b005869c7ad9ecmr6939316ywf.9.1695668086672;
        Mon, 25 Sep 2023 11:54:46 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b00570253fc3e5sm2518920ywa.105.2023.09.25.11.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:54:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] station: support user-disabled bands
Date: Mon, 25 Sep 2023 11:54:21 -0700
Message-Id: <20230925185422.2242494-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925185422.2242494-1-prestwoj@gmail.com>
References: <20230925185422.2242494-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support to allow users to disable entire bands, preventing
scanning and connecting on those frequencies. If the
[Rank].BandModifier* options are set to 0.0 it will imply those
bands should not be used for scanning, connecting or roaming. This
now applies to autoconnect, quick, hidden, roam, and dbus scans.

This is a station only feature meaning other modules like RRM, DPP,
WSC or P2P may still utilize those bands. Trying to limit bands in
those modules may sometimes conflict with the spec which is why it
was not added there. In addition modules like DPP/WSC are only used
in limited capacity for connecting so there is little benefit gained
to disallowing those bands.
---
 src/station.c | 134 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 24 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9e4ee69a..8e552f84 100644
--- a/src/station.c
+++ b/src/station.c
@@ -73,6 +73,9 @@ static bool supports_arp_evict_nocarrier;
 static bool supports_ndisc_evict_nocarrier;
 static struct watchlist event_watches;
 static uint32_t known_networks_watch;
+static bool band_2_4ghz_disabled;
+static bool band_5ghz_disabled;
+static bool band_6ghz_disabled;
 
 struct station {
 	enum station_state state;
@@ -1326,6 +1329,20 @@ static bool station_needs_hidden_network_scan(struct station *station)
 	return !l_queue_isempty(station->hidden_bss_list_sorted);
 }
 
+static struct scan_freq_set *station_get_allowed_freqs(struct station *station)
+{
+	uint32_t band_mask = 0;
+
+	if (!band_2_4ghz_disabled)
+		band_mask |= BAND_FREQ_2_4_GHZ;
+	if (!band_5ghz_disabled)
+		band_mask |= BAND_FREQ_5_GHZ;
+	if (!band_6ghz_disabled)
+		band_mask |= BAND_FREQ_6_GHZ;
+
+	return wiphy_get_allowed_freqs(station->wiphy, band_mask);
+}
+
 static uint32_t station_scan_trigger(struct station *station,
 					struct scan_freq_set *freqs,
 					scan_trigger_func_t triggered,
@@ -1411,6 +1428,7 @@ static void station_quick_scan_destroy(void *userdata)
 static int station_quick_scan_trigger(struct station *station)
 {
 	_auto_(scan_freq_set_free) struct scan_freq_set *known_freq_set = NULL;
+	_auto_(scan_freq_set_free) struct scan_freq_set *allowed = NULL;
 	bool known_6ghz;
 
 	if (wiphy_regdom_is_updating(station->wiphy)) {
@@ -1440,9 +1458,14 @@ static int station_quick_scan_trigger(struct station *station)
 			known_6ghz)
 		return -ENOTSUP;
 
-	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
+	allowed = station_get_allowed_freqs(station);
+	if (L_WARN_ON(!allowed))
+		return -ENOTSUP;
+
+	scan_freq_set_constrain(known_freq_set, allowed);
+
+	if (scan_freq_set_isempty(known_freq_set))
 		return -ENOTSUP;
-	}
 
 	station->quick_scan_id = station_scan_trigger(station,
 						known_freq_set,
@@ -2656,6 +2679,11 @@ static int station_roam_scan(struct station *station,
 				struct scan_freq_set *freq_set)
 {
 	struct scan_parameters params = { .freqs = freq_set, .flush = true };
+	_auto_(scan_freq_set_free) struct scan_freq_set *allowed =
+					station_get_allowed_freqs(station);
+
+	if (L_WARN_ON(!allowed))
+		return -ENOTSUP;
 
 	l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
 
@@ -2666,8 +2694,14 @@ static int station_roam_scan(struct station *station,
 		params.ssid_len = strlen(ssid);
 	}
 
-	if (!freq_set)
+	if (!freq_set) {
 		station->roam_scan_full = true;
+		params.freqs = allowed;
+	} else
+		scan_freq_set_constrain(freq_set, allowed);
+
+	if (L_WARN_ON(scan_freq_set_isempty(params.freqs)))
+		return -ENOTSUP;
 
 	station->roam_scan_id =
 		scan_active_full(netdev_get_wdev_id(station->netdev), &params,
@@ -3597,6 +3631,7 @@ static struct l_dbus_message *station_dbus_connect_hidden_network(
 	};
 	const char *ssid;
 	struct network *network;
+	_auto_(scan_freq_set_free) struct scan_freq_set *allowed = NULL;
 
 	l_debug("");
 
@@ -3647,6 +3682,11 @@ not_hidden:
 		return dbus_error_not_hidden(message);
 	}
 
+	allowed = station_get_allowed_freqs(station);
+	if (L_WARN_ON(!allowed))
+		return dbus_error_not_supported(message);
+
+	params.freqs = allowed;
 	params.ssid = (const uint8_t *)ssid;
 	params.ssid_len = strlen(ssid);
 
@@ -4268,38 +4308,77 @@ int station_hide_network(struct station *station, struct network *network)
 	return 0;
 }
 
-static void station_add_one_freq(uint32_t freq, void *user_data)
+static void station_add_6ghz_freq(uint32_t freq, void *user_data)
 {
-	struct station *station = user_data;
+	struct scan_freq_set *set = user_data;
 
-	if (freq > 3000)
-		scan_freq_set_add(station->scan_freqs_order[1], freq);
-	else if (!scan_freq_set_contains(station->scan_freqs_order[0], freq))
-		scan_freq_set_add(station->scan_freqs_order[2], freq);
+	if (freq > 5935)
+		scan_freq_set_add(set, freq);
+}
+
+static void station_add_5ghz_freq(uint32_t freq, void *user_data)
+{
+	struct scan_freq_set *set = user_data;
+
+	if (freq > 3000 && freq < 5935)
+		scan_freq_set_add(set, freq);
+}
+
+static void station_add_2_4ghz_freq(uint32_t freq, void *user_data)
+{
+	struct scan_freq_set *set = user_data;
+
+	/* exclude social channels added in initial scan request */
+	if (freq < 3000 && freq != 2412 && freq != 2437 && freq != 2462)
+		scan_freq_set_add(set, freq);
 }
 
 static void station_fill_scan_freq_subsets(struct station *station)
 {
-	const struct scan_freq_set *supported =
-		wiphy_get_supported_freqs(station->wiphy);
+	_auto_(scan_freq_set_free) struct scan_freq_set *allowed =
+					station_get_allowed_freqs(station);
+	unsigned int subset_idx = 0;
 
+	if (L_WARN_ON(!allowed))
+		return;
 	/*
 	 * Scan the 2.4GHz "social channels" first, 5GHz second, if supported,
 	 * all other 2.4GHz channels last.  To be refined as needed.
 	 */
-	station->scan_freqs_order[0] = scan_freq_set_new();
-	scan_freq_set_add(station->scan_freqs_order[0], 2412);
-	scan_freq_set_add(station->scan_freqs_order[0], 2437);
-	scan_freq_set_add(station->scan_freqs_order[0], 2462);
-
-	station->scan_freqs_order[1] = scan_freq_set_new();
-	station->scan_freqs_order[2] = scan_freq_set_new();
-	scan_freq_set_foreach(supported, station_add_one_freq, station);
-
-	if (scan_freq_set_isempty(station->scan_freqs_order[1])) {
-		scan_freq_set_free(station->scan_freqs_order[1]);
-		station->scan_freqs_order[1] = station->scan_freqs_order[2];
-		station->scan_freqs_order[2] = NULL;
+	if (!band_2_4ghz_disabled) {
+		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412);
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437);
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462);
+		subset_idx++;
+	}
+
+	/*
+	 * TODO: It may might sense to split up 5 and 6ghz into separate subsets
+	 *       since the channel set is so large.
+	 */
+	if (!band_5ghz_disabled || !band_6ghz_disabled) {
+		struct scan_freq_set *set = scan_freq_set_new();
+
+		if (!band_5ghz_disabled)
+			scan_freq_set_foreach(allowed,
+						station_add_5ghz_freq, set);
+		if (!band_6ghz_disabled)
+			scan_freq_set_foreach(allowed,
+						station_add_6ghz_freq, set);
+
+		/* 5/6ghz didn't add any frequencies */
+		if (scan_freq_set_isempty(set)) {
+			scan_freq_set_free(set);
+		} else
+			station->scan_freqs_order[subset_idx++] = set;
+	}
+
+	/* Add remaining 2.4ghz channels to subset */
+	if (!band_2_4ghz_disabled) {
+		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
+		scan_freq_set_foreach(allowed, station_add_2_4ghz_freq,
+					station->scan_freqs_order[subset_idx]);
 	}
 }
 
@@ -5194,6 +5273,13 @@ static int station_init(void)
 						station_known_networks_changed,
 						NULL, NULL);
 
+	band_2_4ghz_disabled =
+			scan_get_band_rank_modifier(BAND_FREQ_2_4_GHZ) == 0.0;
+	band_5ghz_disabled =
+			scan_get_band_rank_modifier(BAND_FREQ_5_GHZ) == 0.0;
+	band_6ghz_disabled =
+			scan_get_band_rank_modifier(BAND_FREQ_6_GHZ) == 0.0;
+
 	return 0;
 }
 
-- 
2.25.1

