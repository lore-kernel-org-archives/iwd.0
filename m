Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB27747B
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 21:31:40 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id e16so17583578pfm.11
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jX5Jz6wpvPmfRZyxqfpqynSsVi7aM3tkBSczKbckP2s=;
        b=bI+Nwzo3MlTtpzws1Jp7F8nA3fcpHiC/buDfvAPQhCDISrKP3VqoCPcBzYIp2whVnz
         uLOZcjhFixDyyV8B176M6y4P3XgZB9nIoRd6SoZNlMLrhunJLhJNFM+jTQBsTQUm0KJI
         xC+Lt0QvxpZOiEdpQSWOkX1i7OxH3zQvitBpe3A48L66pEi7d+yGmvmsTNW9saRBzSk/
         Af88nEgj8zPFwljHe9LKSZqBLimBGDuTcnPmF4HD+2oxdAQA0WY2zKPYWUnOdQuo01t5
         DYGTww6eG6yKkzuhMagFn8oJ6FquUXVtgTCYCMlbHi4wPdUMUoCXbbcVPYvH5fgZwIjj
         GUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jX5Jz6wpvPmfRZyxqfpqynSsVi7aM3tkBSczKbckP2s=;
        b=fCJ7fkKvHKQF7yGNNXTDxbXjUxq/kh8l4RNU9y1fscnk9qrey7lzkgMSicxR3FoGe3
         UiCnT9UCW4y0HMLENK7DsMlIFGNH4vD2CBJnpl+lcmOKsekRo7RFq7TrjkBLbUdymEeX
         I71GAyulh33G0uLpsyBlRpMm+Lr5Sz3KEtOtMqF+QG3Vui3lzk3ONa859NdJjYunJw1i
         /bWsA5MS3f0NchwyeeFEgRHabBCuJW7YYvK1ioKVnne+Xo5mf1MVIGqjzQrf1vWg6/1u
         YE3o1MIY8Ud5BgxBWtcHUSq1vHs99vjDo+rC5Ho5HKsrVM7GHZWuU0ewNuuYSBaUQIXR
         jCPg==
X-Gm-Message-State: AJIora93mEJvpd6P/DhfxQJPjLIWoeTzlUvEf8BKisHJ0bn2sNiTbqBU
	LI+Ib275hXoOhss8zWae/4ZXEDLc84I=
X-Google-Smtp-Source: AGRyM1t+Jl6mLeadToKpXrERHnZuBD+cdi/28ILCo7nPDE0tQPehTPdOiybEUyTIG4EC1QVWuFmTiw==
X-Received: by 2002:a05:6a00:17aa:b0:52a:e94b:67e5 with SMTP id s42-20020a056a0017aa00b0052ae94b67e5mr41402615pfg.76.1658352699805;
        Wed, 20 Jul 2022 14:31:39 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016c5306917fsm41475plr.53.2022.07.20.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:31:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 2/5] band: add band_estimate_he_rx_rate
Date: Wed, 20 Jul 2022 14:29:29 -0700
Message-Id: <20220720212932.873353-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720212932.873353-1-prestwoj@gmail.com>
References: <20220720212932.873353-1-prestwoj@gmail.com>
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
 src/band.c | 218 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/band.h |   3 +-
 2 files changed, 212 insertions(+), 9 deletions(-)

v5:
 * Removed length checks and sanity checks on the width set bits. This
   is now handled by ie_validate_he_capabilities

diff --git a/src/band.c b/src/band.c
index 0728b0cc..6ef9f9f3 100644
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
@@ -495,6 +503,200 @@ try_vht80:
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
+	bool mcs80p80 = false;
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
+	 * 802.11ax Table 9-322b
+	 */
+
+	/* B0 indicates support for 40MHz */
+	if (test_bit(&width_set, 0))
+		width = OFDM_CHANNEL_WIDTH_40MHZ;
+
+	/* B1 indicates support for 40MHz and 80MHz, choose 80 */
+	if (test_bit(&width_set, 1))
+		width = OFDM_CHANNEL_WIDTH_80MHZ;
+
+	/* B2 indicates support for 160MHz */
+	if (test_bit(&width_set, 2))
+		width = OFDM_CHANNEL_WIDTH_160MHZ;
+
+	/* B3 indicates support for 80+80MHz */
+	if (test_bit(&width_set, 3))
+		mcs80p80 = true;
+
+	/*
+	 * The HE-MCS maps are 17 bytes into the HE Capabilities IE, and
+	 * alternate RX/TX every 2 bytes. Start the TX map 17 + 2 bytes
+	 * into the MCS set. For each MCS set find the best data rate.
+	 */
+	rx_map = he_cap->he_mcs_set;
+	tx_map = hec + 19;
+
+	/* 80+80MHz MCS set */
+	if (mcs80p80) {
+		if (find_rate_he(rx_map + 8, tx_map + 8,
+				OFDM_CHANNEL_WIDTH_160MHZ, rssi, &new_rate))
+			rate = new_rate;
+	}
+
+	/* 160MHz MCS set */
+	if (width == OFDM_CHANNEL_WIDTH_160MHZ) {
+		if (find_rate_he(rx_map + 4, tx_map + 4,
+				OFDM_CHANNEL_WIDTH_160MHZ, rssi, &new_rate) &&
+				new_rate > rate)
+			rate = new_rate;
+	}
+
+	/*
+	 * <= 80MHz MCS set. Adjust width to this range (if needed) and check
+	 * every smaller width in case the rate is higher
+	 */
+	if (width > OFDM_CHANNEL_WIDTH_80MHZ)
+		width = OFDM_CHANNEL_WIDTH_80MHZ;
+
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

