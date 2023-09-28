Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A2374EB
	for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 12:41:32 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68c576d35feso11431000b3a.2
        for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695904891; x=1696509691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TBti7/t+aGJLcMCcdxlyRovtfZ90qTdg6+WUx8k96I=;
        b=M+WslJ68+f91xvJ2xF4uLTTVrgF0pirwQPmDetmG1tuj2ATBrIBsoYZ+0S07CWhreV
         vT2sG04GQXtRvtFwKIpHQuCdpaiQbdirgGLMV00GmyYyUAAq4Qzq5R6V/Zq0qimwakHX
         QXrdke8DP372ZY78rydCX9PKdm0jQk1e/0il+JuMvxw9QR4mOIG8IfdTQpKwR6+a6oeP
         oEc2WDs1Q8xsSQeuOJV1dSHm/imzow/srYWlaVtw447lhV+znETQ00GQZpHdmA2hwBh+
         W5ATdERfX1T7LDU1+bI6i12EwQuHM4SBpZVn6TAZ6RClnEpXDPqnneuLTvr92TNVxKpM
         GbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904891; x=1696509691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TBti7/t+aGJLcMCcdxlyRovtfZ90qTdg6+WUx8k96I=;
        b=gcCLqoU7lupRMJWM0fdEkAfwqEx/WMNvPfwbrmhgo0XR46xgL85Efb9Bp/03fz6AU7
         BZ7DyyiEAIezjeNrt/T+fxv+XtYbg8Aq5JGIFinwu9yRfuWLw8UBj+2lD6dIBLIYDfI2
         Dqu0XRtzTeaMYK6++wI81Eu7IaHcRXXeB89sd/0bUIr/iru3RHtY37b3SPdSoIr5YAKQ
         k/Ei5/PBk6Od6aN/ojTk7wJ02Pi0n68iam+8QE/wC7/JU1e6DOkBfIh3i3GyHQemAF5Z
         5yWhs88rfcXHJM2nL8KuDaiqBvzaztkKHBKwv8hOhcUj/scj8WTS02TF+iLccieKI8x5
         4Mkw==
X-Gm-Message-State: AOJu0YzYsgTPtR+fssiPkXBUCeH7Jm2C0nhhv48ILBvDgwRDCO5mZyzW
	fbtbP7raJQAqdz9kVPaV/yiI/L3xopQ=
X-Google-Smtp-Source: AGHT+IEwuqP5DQWlgDBMN1wkCA7NanTm8JIHRbn/4EyC1QiTweq7J3aL94U2eqL/bNfDc0/oTlwgig==
X-Received: by 2002:a05:6a20:f3a4:b0:15e:9d1b:84bf with SMTP id qr36-20020a056a20f3a400b0015e9d1b84bfmr827218pzb.23.1695904891451;
        Thu, 28 Sep 2023 05:41:31 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001c5d09e9437sm14983105plb.25.2023.09.28.05.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:41:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] station: support user-disabled bands
Date: Thu, 28 Sep 2023 05:41:27 -0700
Message-Id: <20230928124128.3793788-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928124128.3793788-1-prestwoj@gmail.com>
References: <20230928124128.3793788-1-prestwoj@gmail.com>
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
 src/station.c | 120 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 23 deletions(-)

v2:
 * Compute an allowed band mask in station_init rather than separate bools
 * Let all scan paths include frequencies which may be disabled but
   supported. This opens up the potential for 6ghz to be unlocked, and if
   a frequency is disabled the kernel filters it anyways.
 * Optimized the dbus scan subset creation. Clone the 5/6ghz sets based
   on supported freqs rather than foreach.
 * Added a warning after computing the subsets if none were created

diff --git a/src/station.c b/src/station.c
index 9e4ee69a..12823142 100644
--- a/src/station.c
+++ b/src/station.c
@@ -73,6 +73,7 @@ static bool supports_arp_evict_nocarrier;
 static bool supports_ndisc_evict_nocarrier;
 static struct watchlist event_watches;
 static uint32_t known_networks_watch;
+static uint32_t allowed_bands;
 
 struct station {
 	enum station_state state;
@@ -1326,6 +1327,21 @@ static bool station_needs_hidden_network_scan(struct station *station)
 	return !l_queue_isempty(station->hidden_bss_list_sorted);
 }
 
+static struct scan_freq_set *station_get_allowed_freqs(struct station *station)
+{
+	const struct scan_freq_set *supported =
+				wiphy_get_supported_freqs(station->wiphy);
+	struct scan_freq_set *allowed = scan_freq_set_clone(supported,
+							allowed_bands);
+
+	if (scan_freq_set_isempty(allowed)) {
+		scan_freq_set_free(allowed);
+		allowed = NULL;
+	}
+
+	return allowed;
+}
+
 static uint32_t station_scan_trigger(struct station *station,
 					struct scan_freq_set *freqs,
 					scan_trigger_func_t triggered,
@@ -1411,6 +1427,7 @@ static void station_quick_scan_destroy(void *userdata)
 static int station_quick_scan_trigger(struct station *station)
 {
 	_auto_(scan_freq_set_free) struct scan_freq_set *known_freq_set = NULL;
+	_auto_(scan_freq_set_free) struct scan_freq_set *allowed = NULL;
 	bool known_6ghz;
 
 	if (wiphy_regdom_is_updating(station->wiphy)) {
@@ -1440,9 +1457,14 @@ static int station_quick_scan_trigger(struct station *station)
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
@@ -2656,6 +2678,11 @@ static int station_roam_scan(struct station *station,
 				struct scan_freq_set *freq_set)
 {
 	struct scan_parameters params = { .freqs = freq_set, .flush = true };
+	_auto_(scan_freq_set_free) struct scan_freq_set *allowed =
+					station_get_allowed_freqs(station);
+
+	if (L_WARN_ON(!allowed))
+		return -ENOTSUP;
 
 	l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
 
@@ -2666,8 +2693,14 @@ static int station_roam_scan(struct station *station,
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
@@ -3597,6 +3630,7 @@ static struct l_dbus_message *station_dbus_connect_hidden_network(
 	};
 	const char *ssid;
 	struct network *network;
+	_auto_(scan_freq_set_free) struct scan_freq_set *allowed = NULL;
 
 	l_debug("");
 
@@ -3647,6 +3681,11 @@ not_hidden:
 		return dbus_error_not_hidden(message);
 	}
 
+	allowed = station_get_allowed_freqs(station);
+	if (L_WARN_ON(!allowed))
+		return dbus_error_not_supported(message);
+
+	params.freqs = allowed;
 	params.ssid = (const uint8_t *)ssid;
 	params.ssid_len = strlen(ssid);
 
@@ -4268,39 +4307,67 @@ int station_hide_network(struct station *station, struct network *network)
 	return 0;
 }
 
-static void station_add_one_freq(uint32_t freq, void *user_data)
+static void station_add_2_4ghz_freq(uint32_t freq, void *user_data)
 {
-	struct station *station = user_data;
+	struct scan_freq_set *set = user_data;
 
-	if (freq > 3000)
-		scan_freq_set_add(station->scan_freqs_order[1], freq);
-	else if (!scan_freq_set_contains(station->scan_freqs_order[0], freq))
-		scan_freq_set_add(station->scan_freqs_order[2], freq);
+	/* exclude social channels added in initial scan request */
+	if (freq < 3000 && freq != 2412 && freq != 2437 && freq != 2462)
+		scan_freq_set_add(set, freq);
 }
 
 static void station_fill_scan_freq_subsets(struct station *station)
 {
 	const struct scan_freq_set *supported =
-		wiphy_get_supported_freqs(station->wiphy);
+				wiphy_get_supported_freqs(station->wiphy);
+	unsigned int subset_idx = 0;
 
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
+	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
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
+	if (allowed_bands & (BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ)) {
+		uint32_t mask = allowed_bands &
+					(BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ);
+		struct scan_freq_set *set = scan_freq_set_clone(supported,
+								mask);
+
+		/* 5/6ghz didn't add any frequencies */
+		if (scan_freq_set_isempty(set)) {
+			scan_freq_set_free(set);
+		} else
+			station->scan_freqs_order[subset_idx++] = set;
 	}
+
+	/* Add remaining 2.4ghz channels to subset */
+	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
+		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
+		scan_freq_set_foreach(supported, station_add_2_4ghz_freq,
+					station->scan_freqs_order[subset_idx]);
+	}
+
+	/*
+	 * This has the unintended consequence of allowing DBus scans to
+	 * scan the entire spectrum rather than cause IWD to be completely
+	 * non-functional. Rather than prevent DBus scans from working at all
+	 * print a warning here.
+	 */
+	if (station->scan_freqs_order[0] == NULL)
+		l_warn("All supported bands were disabled by user! IWD will not"
+			" function as expected");
+
 }
 
 static void station_wiphy_watch(struct wiphy *wiphy,
@@ -5194,6 +5261,13 @@ static int station_init(void)
 						station_known_networks_changed,
 						NULL, NULL);
 
+	if (scan_get_band_rank_modifier(BAND_FREQ_2_4_GHZ))
+		allowed_bands |= BAND_FREQ_2_4_GHZ;
+	if (scan_get_band_rank_modifier(BAND_FREQ_5_GHZ))
+		allowed_bands |= BAND_FREQ_5_GHZ;
+	if (scan_get_band_rank_modifier(BAND_FREQ_6_GHZ))
+		allowed_bands |= BAND_FREQ_6_GHZ;
+
 	return 0;
 }
 
-- 
2.25.1

