Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA5186E4F
	for <iwd@lists.linux.dev>; Wed, 31 Jul 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437247; cv=none; b=NrU2/WK0H2iCWHKpfp4waCqD5kEUkt0FuYw7jCgZIqS07sC4LvA+WKjScLOpCq0KBmrFah2PmdYfR8H+vqgAgziAiP1WmRcu7MW4vojAki5rgCsf5VHEjoLNVyea/4xm537MZVkzjeoikilxAcGTgZsBvv5OBWET5aszyawhQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437247; c=relaxed/simple;
	bh=EJVq3YtoBHQdiUeaBivSluK6tGsTjxtrT/TmONA2Kgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=phjDHlnjRzcZfpPJaMNLDASCDPxbYKxOge4t83dyHsvUOlUEJzK0THGA3w4g88ky97pXEqZKOpCRBL6CkLBWBcNd8gA1WMmONd4XA4VXP1EajM5N9r1psS59CYXnJseOzuRnIFVob/c6sZ8RYsd4QQynvdtb/dR0frojSD7w8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMSkryY6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMSkryY6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so1797361a12.1
        for <iwd@lists.linux.dev>; Wed, 31 Jul 2024 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722437243; x=1723042043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0h1pynJn5wg+KyT5uWC3UL1Be1Bfv/LJeS4M1QTKc/4=;
        b=KMSkryY6USF4VSsQrz/D7SviJA2lfUHrghlwwnTkUIo3pVgpRR+gmmsdukytRcDrac
         YMwotoir17exc0TbkvOWuxmS9FXp3Hh5wnKPjoio6rWLDW8VsODbSotRKQCunFzumka6
         c9pA2oDQJ39YdeqttDWs0xlMc/akRuisPBgt+MJ3/JpzW1c+uOpM0SWPm5ZCbXyAsu0E
         8gq6zHus3JN1dIgON+M8CuMAqGu/uSZchaEW23qlqUrm9bIERcw0tDnJRTpauNWUQ4yX
         xlP16if7ITM70aN2UfOEiq2i5SH/XjveaFjLiHcLJMXrSR1NafR5gJ7vxlxryBfvPf6U
         JZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722437243; x=1723042043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h1pynJn5wg+KyT5uWC3UL1Be1Bfv/LJeS4M1QTKc/4=;
        b=tPKsTUnduQzch46Zoxk7qZ6rEmXWzLvwN8HelUMr6AZn6ZXbJ9J6px/KC6m49JOdeI
         ki1pMcvQ3Up5hVZOjvCn4wRLvzWR40fmwEfMZ2CxgjNic9BUXo/SQnExJX5F/NuqYFLf
         HWHAiSvKrV13ikM1lwezCiWjTmgW4Y0NoppuwjKpibDrUxishytpp+z+9Ire4h7EJKXn
         qDae4Lg0aYrVY8+BFKFeanSz2ZeSu7gMmqXuOuysrGGq3SCLpP+Hf48cckjxDlWtrESE
         JoD2Tb8UpbuPpTKp+MxA+/cGsRmzH2qaUxi+IHKfPeYBdZTpH5wYUaKC3JtyHNjMHOCq
         glmg==
X-Gm-Message-State: AOJu0Yw+QTJJrjXMxuoNG+sfc7x6xG73nOaNDixeS2+TiagUrLlzwrrA
	Icm8U8GSA0o+yTI2X2SI8zg+hGd+QECX1xH5NOR6gfKEiDyr/T246IpAVg==
X-Google-Smtp-Source: AGHT+IFbcTpnaCi1tMijCaQQtQPM3SV9uwMy2MmUnsL6lJIaV5TFe4PBSUDwS2FmfBtCJZzzk4Xngw==
X-Received: by 2002:a50:99d3:0:b0:57d:4409:4f48 with SMTP id 4fb4d7f45d1cf-5b46d108b11mr5053330a12.15.1722437242997;
        Wed, 31 Jul 2024 07:47:22 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([50.225.159.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59bfesm8833917a12.44.2024.07.31.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:47:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: improve zero oper class neighbor report workaround
Date: Wed, 31 Jul 2024 07:47:17 -0700
Message-Id: <20240731144717.473941-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workaround for Cisco APs reporting an operating class of zero
is still a bug that remains in Cisco equipment. This is made even
worse with the introduction of 6GHz where the channel numbers
overlap with both 2.4 and 5GHz bands. This makes it impossible to
definitively choose a frequency given only a channel number.

To improve this workaround and cover the 6GHz band we can calculate
a frequency for each band and see what is successful. Then append
each frequency we get to the list. This will result in more
frequencies scanned, but this tradeoff is better than potentially
avoiding a roam to 6GHz or high order 5ghz channel numbers.
---
 src/station.c | 145 ++++++++++++++++++++++++++++----------------------
 1 file changed, 82 insertions(+), 63 deletions(-)

diff --git a/src/station.c b/src/station.c
index db069981..e373b03b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1821,36 +1821,87 @@ static void station_roam_timeout_rearm(struct station *station, int seconds);
 static int station_roam_scan(struct station *station,
 				struct scan_freq_set *freq_set);
 
-static uint32_t station_freq_from_neighbor_report(const uint8_t *country,
-		struct ie_neighbor_report_info *info, enum band_freq *out_band)
+static bool is_freq_band_supported(struct station *station, uint32_t freq,
+					enum band_freq band)
+{
+	const struct band_freq_attrs *attr;
+
+	if (!(band & wiphy_get_supported_bands(station->wiphy)))
+		return false;
+
+	/* Skip if frequency is not supported or disabled */
+	attr = wiphy_get_frequency_info(station->wiphy, freq);
+	if (!attr || attr->disabled)
+		return false;
+
+	return true;
+}
+
+/*
+ * Some Cisco APs report all operating class values as 0 in the Neighbor
+ * Report Responses. Historically we could be very sure what band the
+ * channel was associated with since there was no overlap between 2.4
+ * and 5GHz. With the addition of 6GHz this becomes more difficult as
+ * the 6GHz channel range overlaps both 2.4 and 5ghz.
+ *
+ * To cover all 3 bands, calculate a frequency for each and see what sticks.
+ */
+static void station_parse_zero_oper_class(struct station *station,
+					struct ie_neighbor_report_info *info,
+					struct scan_freq_set *freq_set)
+{
+	uint32_t freq_2g;
+	uint32_t freq_5g;
+	uint32_t freq_6g;
+
+	freq_2g = band_channel_to_freq(info->channel_num, BAND_FREQ_2_4_GHZ);
+	freq_5g = band_channel_to_freq(info->channel_num, BAND_FREQ_5_GHZ);
+	freq_6g = band_channel_to_freq(info->channel_num, BAND_FREQ_6_GHZ);
+
+	if (!freq_2g && !freq_5g && !freq_6g) {
+		l_debug("Ignored: 0 oper class with an unusual "
+				"channel number %u", info->channel_num);
+		return;
+	}
+
+	if (freq_2g && is_freq_band_supported(station, freq_2g,
+						BAND_FREQ_2_4_GHZ)) {
+		l_debug("adding frequency %u from invalid oper class", freq_2g);
+		scan_freq_set_add(freq_set, freq_2g);
+	}
+
+	if (freq_5g && is_freq_band_supported(station, freq_5g,
+						BAND_FREQ_5_GHZ)) {
+		l_debug("adding frequency %u from invalid oper class", freq_5g);
+		scan_freq_set_add(freq_set, freq_5g);
+	}
+
+	if (freq_6g && is_freq_band_supported(station, freq_6g,
+						BAND_FREQ_6_GHZ)) {
+		l_debug("adding frequency %u from invalid oper class", freq_6g);
+		scan_freq_set_add(freq_set, freq_6g);
+	}
+}
+
+static void station_add_neighbor_report_freqs(struct station *station,
+					struct ie_neighbor_report_info *info,
+					struct scan_freq_set *freq_set)
 {
 	enum band_freq band;
 	uint32_t freq;
 
-	if (info->oper_class == 0) {
-		/*
-		 * Some Cisco APs report all operating class values as 0
-		 * in the Neighbor Report Responses.  Work around this by
-		 * using the most likely operating class for the channel
-		 * number as the 2.4GHz and 5GHz bands happen to mostly
-		 * use channels in two disjoint ranges.
-		 */
-		if (info->channel_num >= 1 && info->channel_num <= 14)
-			band = BAND_FREQ_2_4_GHZ;
-		else if (info->channel_num >= 36 && info->channel_num <= 169)
-			band = BAND_FREQ_5_GHZ;
-		else {
-			l_debug("Ignored: 0 oper class with an unusual "
-				"channel number %u", info->channel_num);
+	const uint8_t *country = station->connected_bss->cc_present ?
+					station->connected_bss->cc : NULL;
 
-			return 0;
-		}
+	if (info->oper_class == 0) {
+		station_parse_zero_oper_class(station, info, freq_set);
+		return;
 	} else {
 		band = band_oper_class_to_band(country, info->oper_class);
 		if (!band) {
 			l_debug("Ignored: unsupported oper class");
 
-			return 0;
+			return;
 		}
 	}
 
@@ -1858,13 +1909,14 @@ static uint32_t station_freq_from_neighbor_report(const uint8_t *country,
 	if (!freq) {
 		l_debug("Ignored: unsupported channel");
 
-		return 0;
+		return;
 	}
 
-	if (out_band)
-		*out_band = band;
+	/* Skip if the band/frequency is not supported */
+	if (!is_freq_band_supported(station, freq, band))
+		return;
 
-	return freq;
+	scan_freq_set_add(freq_set, freq);
 }
 
 static void parse_neighbor_report(struct station *station,
@@ -1873,9 +1925,8 @@ static void parse_neighbor_report(struct station *station,
 					struct scan_freq_set **set)
 {
 	struct ie_tlv_iter iter;
-	int count_md = 0, count_no_md = 0;
 	struct scan_freq_set *freq_set_md, *freq_set_no_md;
-	uint32_t current_freq = 0;
+	uint32_t current_freq = station->connected_bss->frequency;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 
 	freq_set_md = scan_freq_set_new();
@@ -1886,10 +1937,6 @@ static void parse_neighbor_report(struct station *station,
 	/* First see if any of the reports contain the MD bit set */
 	while (ie_tlv_iter_next(&iter)) {
 		struct ie_neighbor_report_info info;
-		uint32_t freq;
-		enum band_freq band;
-		const uint8_t *cc = NULL;
-		const struct band_freq_attrs *attr;
 
 		if (ie_tlv_iter_get_tag(&iter) != IE_TYPE_NEIGHBOR_REPORT)
 			continue;
@@ -1903,22 +1950,6 @@ static void parse_neighbor_report(struct station *station,
 				(int) info.channel_num, (int) info.oper_class,
 				info.md ? "MD set" : "MD not set");
 
-		if (station->connected_bss->cc_present)
-			cc = station->connected_bss->cc;
-
-		freq = station_freq_from_neighbor_report(cc, &info, &band);
-		if (!freq)
-			continue;
-
-		/* Skip if the band is not supported */
-		if (!(band & wiphy_get_supported_bands(station->wiphy)))
-			continue;
-
-		/* Skip if frequency is not supported or disabled */
-		attr = wiphy_get_frequency_info(station->wiphy, freq);
-		if (!attr || attr->disabled)
-			continue;
-
 		if (!memcmp(info.addr,
 				station->connected_bss->addr, ETH_ALEN)) {
 			/*
@@ -1927,26 +1958,14 @@ static void parse_neighbor_report(struct station *station,
 			 * its channel because it may still be the best ranked
 			 * or the only visible AP.
 			 */
-			current_freq = freq;
-
 			continue;
 		}
 
-		/* Add the frequency to one of the lists */
-		if (info.md && hs->mde) {
-			scan_freq_set_add(freq_set_md, freq);
-
-			count_md += 1;
-		} else {
-			scan_freq_set_add(freq_set_no_md, freq);
-
-			count_no_md += 1;
-		}
+		station_add_neighbor_report_freqs(station, &info,
+						info.md && hs->mde ?
+						freq_set_md : freq_set_no_md);
 	}
 
-	if (!current_freq)
-		current_freq = station->connected_bss->frequency;
-
 	/*
 	 * If there are neighbor reports with the MD bit set then the bit
 	 * is probably valid so scan only the frequencies of the neighbors
@@ -1968,11 +1987,11 @@ static void parse_neighbor_report(struct station *station,
 	 * automatically fall back to the non-FT candidates and then to
 	 * full scan.
 	 */
-	if (count_md) {
+	if (!scan_freq_set_isempty(freq_set_md)) {
 		scan_freq_set_add(freq_set_md, current_freq);
 		*set = freq_set_md;
 		scan_freq_set_free(freq_set_no_md);
-	} else if (count_no_md) {
+	} else if (!scan_freq_set_isempty(freq_set_no_md)) {
 		scan_freq_set_add(freq_set_no_md, current_freq);
 		*set = freq_set_no_md;
 		scan_freq_set_free(freq_set_md);
-- 
2.34.1

