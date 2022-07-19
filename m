Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3134C82
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:58:04 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id o18so14311987pgu.9
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VoRF+IS0P8HyLxSEtJ8kTVgZC8KOdpY1QA4H07S9Gls=;
        b=CV5KVQ+bxnarZe2XwHtYvgamI609F4bWHGf+rKnwts7kP8bYMTB7360AMpqHtNmsYu
         V2bmpM+vA7yDAQf5gQ3ML8e1JUR7Vyn9FRNUSKa75eLLDl1i7I+teHCCszKPdQU4viPx
         WYs9XbYe7zWaMkUh1KmHQucegdKq2yUE18EIfMuRCcNg/nVCl2GSef+vvlQ3qxaSOKgj
         smFmdhHl8M1PY18OPj/YhWFVxZGherP+dzJjHHJvuCYed1Pahg43juw3LASZ3tZttWYJ
         4MDdOZ46yJSjQxJYSYFCVrexNfsie8K7h5/LlEqRWjFRih9HBQVfHBZ8k90C+q9du0V3
         vXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VoRF+IS0P8HyLxSEtJ8kTVgZC8KOdpY1QA4H07S9Gls=;
        b=V2JsufSSF7XxE38+hfL6je6mAPkwt/p0uDb1ikGU+/gp5I0J0c2jUVzfF4KPL46z0Z
         5otqwbM4H0KuOA9akQuE5TU2WKFIal2Rjnz3JPF0VaydU7SEdZjLBoogUnwO7qVparCM
         +dkGIT/sdljTKuL99OmeNo0C7AWtTekaqVkg0z4JXV7oiILNSVlb2Lc7WrZUxhALjX1V
         gXRqdpXG8Nwl733NZCRanew5nrO7XbvnpgUSzt7m0u7Z3HwqWC8CzXPUKJKn4qIBO4O+
         WyqIWZOexIy/OE3mIJhVE51jL1o4MMp4Sdf79Et5+YqgwEIdM6qsy6h6Sx+hYojjXLOT
         lYRg==
X-Gm-Message-State: AJIora/vUfJh0HE1PbiRKr4JKf7xYGoq7S9w2ekYGRpSfq+EAr+4LE6t
	/P267Y0g91r0X0hyWh7rhNhjMoPTbMg=
X-Google-Smtp-Source: AGRyM1tGPjnaD1D1n+EwJu5Ov2Mh7eNz090caZZk6w1EBTHXNr4A6PHKqXiUPVgnxLZyyIA99HFg/Q==
X-Received: by 2002:a05:6a00:1412:b0:528:47a6:8569 with SMTP id l18-20020a056a00141200b0052847a68569mr34590830pfu.39.1658257083980;
        Tue, 19 Jul 2022 11:58:03 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:58:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/12] band: add band_estimate_he_rx_rate
Date: Tue, 19 Jul 2022 11:55:42 -0700
Message-Id: <20220719185544.456727-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the HT/VHT APIs, this estimates the data rate based on the
HE Capabilities element, in addition to our own capabilities. The
logic is much the same as HT/VHT. The major difference being that HE
uses several MCS tables depending on the channel width. Each width
MCS set is checked (if supported) and the highest estimated rate out
of all the MCS sets is used.
---
 src/band.c | 274 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/band.h |   3 +-
 2 files changed, 268 insertions(+), 9 deletions(-)

diff --git a/src/band.c b/src/band.c
index 0728b0cc..5afe1004 100644
--- a/src/band.c
+++ b/src/band.c
@@ -28,7 +28,8 @@
 
 #include "ell/useful.h"
 
-#include "band.h"
+#include "src/band.h"
+#include "src/netdev.h"
 
 void band_free(struct band *band)
 {
@@ -125,14 +126,21 @@ int band_estimate_nonht_rate(const struct band *band,
 }
 
 /*
- * Base RSSI values for 20MHz (both HT and VHT) channel. These values can be
+ * Base RSSI values for 20MHz (HT, VHT and HE) channel. These values can be
  * used to calculate the minimum RSSI values for all other channel widths. HT
- * MCS indexes are grouped into ranges of 8 (per spatial stream) where VHT are
- * grouped in chunks of 10. This just means HT will not use the last two
- * index's of this array.
+ * MCS indexes are grouped into ranges of 8 (per spatial stream), VHT in groups
+ * of 10 and HE in groups of 12. This just means HT will not use the last four
+ * index's of this array, and VHT won't use the last two.
+ *
+ * Note: The values here are not based on anything from 802.11 but data
+ *       found elsewhere online (presumably from testing, we hope). The two
+ *       indexes for HE (MCS 11/12) are not based on any data, but just
+ *       increased by 3dB compared to the previous value. We consider this good
+ *       enough for its purpose to estimate the date rate for network/BSS
+ *       preference.
  */
-static const int32_t ht_vht_base_rssi[] = {
-	-82, -79, -77, -74, -70, -66, -65, -64, -59, -57
+static const int32_t ht_vht_he_base_rssi[] = {
+	-82, -79, -77, -74, -70, -66, -65, -64, -59, -57, -54, -51
 };
 
 /*
@@ -194,7 +202,7 @@ bool band_ofdm_rate(uint8_t index, enum ofdm_channel_width width,
 	uint64_t rate;
 	int32_t width_adjust = width * 3;
 
-	if (rssi < ht_vht_base_rssi[index] + width_adjust)
+	if (rssi < ht_vht_he_base_rssi[index] + width_adjust)
 		return false;
 
 	rate = ht_vht_rates[width][index];
@@ -495,6 +503,256 @@ try_vht80:
 	return -ENETUNREACH;
 }
 
+/*
+ * Data Rate for HE is much the same as HT/VHT but some additional MCS indexes
+ * were added. This mean rfactors, and nbpscs will contain two additional
+ * values:
+ *
+ * rfactors.extend([3/4, 5/6])
+ * nbpscs.extend([10, 10])
+ *
+ * The guard interval also differs:
+ *
+ * Tdft = 12.8us
+ * Tgi = 0.8, 1.6 or 2.3us
+ *
+ * The Nsd values for HE are:
+ *
+ * Nsd = [234, 468, 980, 1960]
+ *
+ * The formula is identical to HT/VHT:
+ *
+ * Nsd * Nbpscs * R * Nss / (Tdft + Tgi)
+ *
+ * Note: The table below assumes a 0.8us GI. There isn't any way to know what
+ *       GI will be used for an actual connection, so assume the best.
+ */
+static uint64_t he_rates[5][12] = {
+	/* no-HT not applicable */
+	[BAND_CHANDEF_WIDTH_20] = {
+		8600000ULL, 17200000ULL, 25800000ULL, 34400000ULL,
+		51600000ULL, 68800000ULL, 77400000ULL, 86000000ULL,
+		103200000ULL, 114700000ULL, 129000000ULL, 143300000ULL,
+	},
+	[BAND_CHANDEF_WIDTH_40] = {
+		17200000ULL, 34400000ULL, 51600000ULL, 68800000ULL,
+		103200000ULL, 137600000ULL, 154900000ULL, 172000000ULL,
+		206500000ULL, 229400000ULL, 258000000ULL, 286800000ULL,
+	},
+	[BAND_CHANDEF_WIDTH_80] = {
+		36000000ULL, 72000000ULL, 108000000ULL, 144100000ULL,
+		216200000ULL, 288200000ULL, 324300000ULL, 360300000ULL,
+		432400000ULL, 480400000ULL, 540400000ULL, 600500000ULL,
+	},
+	[BAND_CHANDEF_WIDTH_80P80] = {
+		72000000ULL, 144100000ULL, 216200000ULL, 288200000ULL,
+		432400000ULL, 576500000ULL, 648500000ULL, 720600000ULL,
+		864700000ULL, 960800000ULL, 1080900000ULL, 1201000000ULL,
+	},
+	/* 80+80MHz rates equal 160MHz according to 27.5.1 */
+};
+
+static bool band_he_rate(uint8_t index, enum band_chandef_width width,
+			int32_t rssi, uint8_t nss, uint64_t *data_rate)
+{
+	uint64_t rate;
+	int32_t width_adjust;
+
+	/*
+	 * 802.11ax treats 80+80MHz and 160MHz widths together in terms of the
+	 * data rate tables, hence why the above table has no entry for 160MHz.
+	 * We can't simply combine the two widths fully because they differ in
+	 * what MCS/NSS values may be supported. So if 160MHz was chosen, use
+	 * the 80+80MHz table.
+	 */
+	if (width == BAND_CHANDEF_WIDTH_160)
+		width = BAND_CHANDEF_WIDTH_80P80;
+
+	/*
+	 * The band_chandef_width enum is being reused for HE so we have to
+	 * subtract 1 to account for 20MHz being at index 1 (index 0 is no-HT
+	 * which isn't applicable to HE).
+	 */
+	width_adjust = (width - 1) * 3;
+
+	if (rssi < ht_vht_he_base_rssi[index] + width_adjust)
+		return false;
+
+	rate = he_rates[width][index];
+
+	rate *= nss;
+
+	*data_rate = rate;
+	return true;
+}
+
+static enum band_chandef_width find_he_max_width(enum band_freq freq,
+					struct band_he_capabilities *he_cap,
+					const uint8_t *he_phy)
+{
+
+	uint8_t own_width_set = bit_field(he_cap->he_phy_capa[0], 1, 7);
+	uint8_t peer_width_set = bit_field(he_phy[0], 1, 7);
+	enum band_chandef_width max_width = BAND_CHANDEF_WIDTH_20;
+
+	/*
+	 * 802.11ax Table 9-322b
+	 */
+	switch (freq) {
+	case BAND_FREQ_2_4_GHZ:
+		/* B0 indicates support for 40MHz */
+		if (test_bit(&peer_width_set, 0) && test_bit(&own_width_set, 0))
+			max_width = BAND_CHANDEF_WIDTH_40;
+		break;
+	case BAND_FREQ_5_GHZ:
+	case BAND_FREQ_6_GHZ:
+		/* B1 indicates support for 40MHz and 80MHz, choose 80 */
+		if (test_bit(&peer_width_set, 1) && test_bit(&own_width_set, 1))
+			max_width = BAND_CHANDEF_WIDTH_80;
+		/* B2 indicates support for 160MHz */
+		if (test_bit(&peer_width_set, 2) && test_bit(&own_width_set, 2))
+			max_width = BAND_CHANDEF_WIDTH_160;
+		/* B3 indicates support for 80+80MHz */
+		if (test_bit(&peer_width_set, 3) && test_bit(&own_width_set, 3))
+			max_width = BAND_CHANDEF_WIDTH_80P80;
+
+		break;
+	}
+
+	return max_width;
+}
+
+static bool find_best_mcs_he(uint8_t max_index, enum band_chandef_width width,
+				int32_t rssi, uint8_t nss,
+				uint64_t *out_data_rate)
+{
+	int i;
+
+	/*
+	 * Iterate over all available MCS indexes to find the best one
+	 * we can use.
+	 */
+	for (i = max_index; i >= 0; i--)
+		if (band_he_rate(i, width, rssi, nss, out_data_rate))
+			return true;
+
+	return false;
+}
+
+static bool find_he_capabilities(const void *data, const void *user_data)
+{
+	const struct band_he_capabilities *he_cap = data;
+	enum netdev_iftype iftype = *((enum netdev_iftype *)user_data);
+
+	if (he_cap->iftypes & (1 << iftype))
+		return true;
+
+	return false;
+}
+
+/*
+ * HE data rate is calculated based on 802.11ax - Section 27.5
+ */
+int band_estimate_he_rx_rate(const struct band *band, const uint8_t *hec,
+				int32_t rssi, uint64_t *out_data_rate)
+{
+	uint32_t nss = 0;
+	uint32_t max_mcs = 7;
+	enum band_chandef_width width;
+	enum band_chandef_width i;
+	struct band_he_capabilities *he_cap;
+	uint64_t best_rate = 0;
+
+	/*
+	 * TODO: Station type is assumed here since it is the only consumer of
+	 *       these data rate estimation APIs. If this changes the iftype
+	 *       would need to be passed in.
+	 */
+	enum netdev_iftype iftype = NETDEV_IFTYPE_STATION;
+
+	if (!hec || !band->he_capabilities)
+		return -EBADMSG;
+
+	he_cap = l_queue_find(band->he_capabilities, find_he_capabilities,
+				&iftype);
+	if (!he_cap)
+		return -ENOTSUP;
+
+	/* The maximum width sets where to stop checking MCS sets */
+	width = find_he_max_width(band->freq, he_cap, hec + 8);
+
+	/*
+	 * The HE-MCS maps are 19 bytes into the HE Capabilities IE, and
+	 * alternate RX/TX every 2 bytes. Start the TX map 19 + 2 bytes
+	 * into the MCS set. For each supported width beyond 80MHz
+	 * (only 160/80+80) increment to the next map, 4 bytes ahead.
+	 * Estimate a rate for each width, and track the largest.
+	 */
+	for (i = BAND_CHANDEF_WIDTH_80; i <= BAND_CHANDEF_WIDTH_160; i++) {
+		enum band_chandef_width check = i;
+		const uint8_t *rx_map = he_cap->he_mcs_set;
+		const uint8_t *tx_map = hec + 21;
+		uint64_t rate;
+
+		/*
+		 * The band_chandef_width enum does not use the same ordering as
+		 * the MCS sets (160 and 80+80 are swapped) so we can't just
+		 * iterate the widths and increment by 4 bytes. Instead 80+80
+		 * and 160 must be checked individually and skipped if not
+		 * supported.
+		 */
+		switch (i) {
+		case BAND_CHANDEF_WIDTH_80P80:
+			/*
+			 * 80+80 is the last map so if the width is not set to
+			 * this continue to allow 160MHz to be checked.
+			 */
+			if (width != BAND_CHANDEF_WIDTH_80P80)
+				continue;
+
+			rx_map += 8;
+			tx_map += 8;
+			break;
+		case BAND_CHANDEF_WIDTH_160:
+			/* If neither 160 or 80+80 MCS sets are supported */
+			if (width != BAND_CHANDEF_WIDTH_160 &&
+					width != BAND_CHANDEF_WIDTH_80P80)
+				continue;
+
+			rx_map += 4;
+			tx_map += 4;
+			break;
+		default:
+			/*
+			 * The <= 80MHz MCS set. If the supported width is less
+			 * than 80Mhz use that to calculate the rate rather than
+			 * 80Mhz.
+			 */
+			if (width < BAND_CHANDEF_WIDTH_80)
+				check = width;
+
+			break;
+		}
+
+		if (!find_best_mcs_nss(rx_map, tx_map, 7, 9, 11,
+				&max_mcs, &nss))
+			continue;
+
+		if (!find_best_mcs_he(max_mcs, check, rssi, nss, &rate))
+			continue;
+
+		if (rate > best_rate)
+			best_rate = rate;
+	}
+
+	if (!best_rate)
+		return -EBADMSG;
+
+	*out_data_rate = best_rate;
+
+	return 0;
+}
+
 static int band_channel_info_get_bandwidth(const struct band_chandef *info)
 {
 	switch (info->channel_width) {
diff --git a/src/band.h b/src/band.h
index 1f1269c7..9b307a77 100644
--- a/src/band.h
+++ b/src/band.h
@@ -74,7 +74,8 @@ void band_free(struct band *band);
 bool band_ofdm_rate(uint8_t index, enum ofdm_channel_width width,
 			int32_t rssi, uint8_t nss, bool sgi,
 			uint64_t *data_rate);
-
+int band_estimate_he_rx_rate(const struct band *band, const uint8_t *hec,
+				int32_t rssi, uint64_t *out_dat_rate);
 int band_estimate_vht_rx_rate(const struct band *band,
 				const uint8_t *vhtc, const uint8_t *vhto,
 				const uint8_t *htc, const uint8_t *hto,
-- 
2.34.1

