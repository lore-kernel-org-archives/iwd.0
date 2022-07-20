Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F57485
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 22:17:15 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so3381286pjq.4
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/zjWwVdJxHADaVKlYCkgWUaHlck+/yVCOLJuk7Z/9E=;
        b=Rd0McP/IPeenz/njNCFdXIgWXRG0JAo+1+LXl+/qATANunwQIXcs0GfML6k5l2WMU+
         PTFOyRrZWpLdDTP+mHaE9Q5qDpxjvq4xw4FKF36zqCplR+wGki4+ucl7oVkWxOPGMgQk
         9A4UgL6ZqmYivyuXTjvl88P2YlN1qdcszZx4RXVZcQNKm2CED9z8BcFVtJs4FWf4CxlF
         hM88kw+ea+rOy535Rc6ij2vxn+6uAyRspXBGRFZb0PFIeoEXSU8PrwqR/AWSY7nbTfRS
         CVM/Rmz3akrI0O7X1dB/Qxnj9tkeic4tHZdWZuymn0llIghq6s1gdxmQ9ZLg4oUBANFA
         U87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/zjWwVdJxHADaVKlYCkgWUaHlck+/yVCOLJuk7Z/9E=;
        b=I7Dcyl1XmCyURCmVoHwraCyGMLp6UIp+r7lqwVrt/OoeUYVvPQQSVnVAVZt/3ue2IP
         TsGJ3E/De75u3kl6Q1Cd0lfkyk7bTxRh4UaHwy5xHNFYNA3imCeuW0hl2xHKVc4lNNdi
         xT/pSW5WAJ2amkCz6jZK4g7Ags0wHS4r4au1MEVTRCtdKkTFVALU0oxSYHaNgszffuSz
         WQN79jhKTmMcOtXzt++VHomxvJoej6EBc0PkPPIkajKjWuAa5cFnXE1hY8npbTTOuVQq
         615rxh+2nJGOnC+MTV7bFcQssqjEzhudcN+mGTDvUfH3egTF12jcKkvDQwTJFxO8doUK
         ViBQ==
X-Gm-Message-State: AJIora8B+NtBcca0OEC/qlG+DzryYBDpchDVKTKGv9NvPOLm0ksDovZr
	sQkHl/6W7FfkNmW2yStWeOdVoE+kZKA=
X-Google-Smtp-Source: AGRyM1uCZMbMO+ih02rXnZMm/jColl6NwwUtKF5zyv+rpvlUlYA6nNYg+R2X5/v5iyA9xTjSShFXaA==
X-Received: by 2002:a17:90b:1d92:b0:1ef:e28f:ff38 with SMTP id pf18-20020a17090b1d9200b001efe28fff38mr7972051pjb.32.1658355434656;
        Wed, 20 Jul 2022 15:17:14 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a170903204a00b0016a1e2d148csm75859pla.32.2022.07.20.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:17:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 2/5] band: add band_estimate_he_rx_rate
Date: Wed, 20 Jul 2022 15:15:04 -0700
Message-Id: <20220720221507.886811-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720221507.886811-1-prestwoj@gmail.com>
References: <20220720221507.886811-1-prestwoj@gmail.com>
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
 src/band.c | 204 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/band.h |   3 +-
 2 files changed, 198 insertions(+), 9 deletions(-)

v6:
 * Combined the test_bit blocks with the rate calculations for 160mhz
   and 80+80mhz. Bits 0 and 1 are checked as before and set the width
   accordingly, which is then used as the starting point for the
   estimation of lower widths.

diff --git a/src/band.c b/src/band.c
index 0728b0cc..01166b62 100644
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
@@ -495,6 +503,186 @@ try_vht80:
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
+static uint64_t he_rates[4][12] = {
+	[OFDM_CHANNEL_WIDTH_20MHZ] = {
+		8600000ULL, 17200000ULL, 25800000ULL, 34400000ULL,
+		51600000ULL, 68800000ULL, 77400000ULL, 86000000ULL,
+		103200000ULL, 114700000ULL, 129000000ULL, 143300000ULL,
+	},
+	[OFDM_CHANNEL_WIDTH_40MHZ] = {
+		17200000ULL, 34400000ULL, 51600000ULL, 68800000ULL,
+		103200000ULL, 137600000ULL, 154900000ULL, 172000000ULL,
+		206500000ULL, 229400000ULL, 258000000ULL, 286800000ULL,
+	},
+	[OFDM_CHANNEL_WIDTH_80MHZ] = {
+		36000000ULL, 72000000ULL, 108000000ULL, 144100000ULL,
+		216200000ULL, 288200000ULL, 324300000ULL, 360300000ULL,
+		432400000ULL, 480400000ULL, 540400000ULL, 600500000ULL,
+	},
+	[OFDM_CHANNEL_WIDTH_160MHZ] = {
+		72000000ULL, 144100000ULL, 216200000ULL, 288200000ULL,
+		432400000ULL, 576500000ULL, 648500000ULL, 720600000ULL,
+		864700000ULL, 960800000ULL, 1080900000ULL, 1201000000ULL,
+	},
+};
+
+static bool band_he_rate(uint8_t index, enum ofdm_channel_width width,
+			int32_t rssi, uint8_t nss, uint64_t *data_rate)
+{
+	uint64_t rate;
+	int32_t width_adjust;
+
+	width_adjust = width * 3;
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
+static bool find_rate_he(const uint8_t *rx_map, const uint8_t *tx_map,
+				enum ofdm_channel_width width, int32_t rssi,
+				uint64_t *out_data_rate)
+{
+	uint32_t nss;
+	uint32_t max_mcs;
+	int i;
+
+	if (!find_best_mcs_nss(rx_map, tx_map, 7, 9, 11,
+				&max_mcs, &nss))
+		return false;
+
+	for (i = max_mcs; i >= 0; i--)
+		if (band_he_rate(i, width, rssi, nss, out_data_rate))
+			return true;
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
+	enum ofdm_channel_width width = OFDM_CHANNEL_WIDTH_20MHZ;
+	int i;
+	const struct band_he_capabilities *he_cap = NULL;
+	const struct l_queue_entry *entry;
+	const uint8_t *rx_map;
+	const uint8_t *tx_map;
+	uint64_t rate = 0;
+	uint64_t new_rate = 0;
+	uint8_t width_set;
+
+	if (!hec || !band->he_capabilities)
+		return -EBADMSG;
+
+	for (entry = l_queue_get_entries(band->he_capabilities);
+						entry; entry = entry->next) {
+		const struct band_he_capabilities *cap = entry->data;
+
+		/*
+		 * TODO: Station type is assumed here since it is the only
+		 *       consumer of these data rate estimation APIs. If this
+		 *       changes the iftype would need to be passed in.
+		 */
+		if (cap->iftypes & (1 << NETDEV_IFTYPE_STATION)) {
+			he_cap = cap;
+			break;
+		}
+	}
+
+	if (!he_cap)
+		return -ENOTSUP;
+
+	/* AND the width sets, giving the widths supported by both */
+	width_set = bit_field(he_cap->he_phy_capa[0], 1, 7) &
+				bit_field((hec + 6)[0], 1, 7);
+
+	/*
+	 * The HE-MCS maps are 17 bytes into the HE Capabilities IE, and
+	 * alternate RX/TX every 2 bytes. Start the TX map 17 + 2 bytes
+	 * into the MCS set. For each MCS set find the best data rate.
+	 */
+	rx_map = he_cap->he_mcs_set;
+	tx_map = hec + 19;
+
+	/*
+	 * 802.11ax Table 9-322b
+	 *
+	 * B3 indicates support for 80+80MHz MCS set
+	 */
+	if (test_bit(&width_set, 3)) {
+		if (find_rate_he(rx_map + 8, tx_map + 8,
+					OFDM_CHANNEL_WIDTH_160MHZ,
+					rssi, &new_rate))
+			rate = new_rate;
+	}
+
+	/* B2 indicates support for 160MHz MCS set */
+	if (test_bit(&width_set, 2)) {
+		if (find_rate_he(rx_map + 4, tx_map + 4,
+					OFDM_CHANNEL_WIDTH_160MHZ,
+					rssi, &new_rate) && new_rate > rate)
+			rate = new_rate;
+	}
+
+	/* B1 indicates support for 80MHz */
+	if (test_bit(&width_set, 1))
+		width = OFDM_CHANNEL_WIDTH_80MHZ;
+
+	/* B0 indicates support for 40MHz */
+	if (test_bit(&width_set, 0))
+		width = OFDM_CHANNEL_WIDTH_40MHZ;
+
+	/* <= 80MHz MCS set */
+	for (i = width; i >= OFDM_CHANNEL_WIDTH_20MHZ; i--) {
+		if (find_rate_he(rx_map, tx_map, i, rssi, &new_rate)) {
+			if (new_rate > rate)
+				rate = new_rate;
+
+			break;
+		}
+	}
+
+	if (!rate)
+		return -EBADMSG;
+
+	*out_data_rate = rate;
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

