Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165927B
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 19:36:00 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id f65so17278290pgc.12
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5emzCppWGb1+r2atzWGkoZyAFiDEZViGr1I/Fx130FE=;
        b=RkW4GG3v/AeHbyRWumWFxjeb2fPgJkoFZCTy2bIFDcFugFpfcR6xYiOHw1At8Pc15K
         m+j9MBjzj5WmdYh3Zc4EjoMi1Bhfw6R9LaLr+t1AEekQ+I2E6PK99IV4CqJsvfIoJoRg
         3X1C0nSpQchu4I79rqzSqsrkVZZTsIfN1vsdQOsmFAUB/jyvRIMPjc1vzhOaQP+Fz+zg
         zm0N3+12tFbKtvIu19GQOYIwMEdXgna8StEadItHgIRLr+09cU49eCno6r7JPBJd565t
         hBN9Hzeg/QHwnQ7Rz1yQmFVfzTxQsXsffPWm6EXY1Jdx83qpOdoXEM5JBeWABdT1w3t6
         4KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5emzCppWGb1+r2atzWGkoZyAFiDEZViGr1I/Fx130FE=;
        b=RFkIHbUo9bRugj6uJGKcY2hsWQfM4CrHGSIzeU7OmMkL4KE+m5kBjxi1jgatuqGcvI
         XCs/7FhwJB7X5YaES0D4ElgA1uS+CHyr65dXXVKFmQPKx5uBq6OPfrXWYzvJFepjyMsu
         NbRuXA99jH9u6BvIX77vp+kEVpFpB+pqTq1FATcOZG9d8n8pzw71qjXAItwrQ2BvbsiK
         INyqCAxIVFX4hfBE1TXISbCkuJ/RD+0kFF1Bqt41UqCTJtTYmQKHshGYpbrQ8rXq3mae
         31ZR3TQNqtshr4iOPnUszRxMGz0LHbGYu2zBT6rOYBOO1LQDU5oULD3RW/eFQmP1GEFM
         kvEw==
X-Gm-Message-State: AJIora9eJHBBdjAmwjeo0pWMCcaykdiUgfMo6kgzjeWXDG7k7JqO88z7
	Po57yyKywyBWkhSP6c+9443Xt1gt9q0=
X-Google-Smtp-Source: AGRyM1ujdLBKTVoe4dfvsWzXQQaQ2sEd0kkGzs8SEcfYqdpxgH+0kPKjaIeiHHkYpTu4jWOWF2dkAA==
X-Received: by 2002:aa7:8318:0:b0:528:c331:e576 with SMTP id bk24-20020aa78318000000b00528c331e576mr40930618pfb.58.1658345759035;
        Wed, 20 Jul 2022 12:35:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b0016be4d78792sm14244601plh.257.2022.07.20.12.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:35:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] band: add band_estimate_he_rx_rate
Date: Wed, 20 Jul 2022 12:33:50 -0700
Message-Id: <20220720193352.806339-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 src/band.c | 248 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/band.h |   3 +-
 2 files changed, 242 insertions(+), 9 deletions(-)

v3:
 * Bail if previous width support bits aren't set
 * Loop over all <= 80mhz widths (rate may be faster)
 * Remove find_he_width_offset and check inline

diff --git a/src/band.c b/src/band.c
index 0728b0cc..542e99d2 100644
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
@@ -495,6 +503,230 @@ try_vht80:
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
+	enum ofdm_channel_width i;
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
+	l_info("he_cap=%p", he_cap);
+	if (!he_cap)
+		return -ENOTSUP;
+
+	/* AND the width sets, giving the widths supported by both */
+	width_set = bit_field(he_cap->he_phy_capa[0], 1, 7) &
+				bit_field((hec + 8)[0], 1, 7);
+
+	l_info("width set %02x", width_set);
+	/*
+	 * 802.11ax Table 9-322b
+	 */
+	switch (band->freq) {
+	case BAND_FREQ_2_4_GHZ:
+		/* B0 indicates support for 40MHz */
+		if (test_bit(&width_set, 0))
+			width = OFDM_CHANNEL_WIDTH_40MHZ;
+
+		break;
+	case BAND_FREQ_5_GHZ:
+	case BAND_FREQ_6_GHZ:
+		/* B1 indicates support for 40MHz and 80MHz, choose 80 */
+		if (test_bit(&width_set, 1))
+			width = OFDM_CHANNEL_WIDTH_80MHZ;
+
+		/* B2 indicates support for 160MHz */
+		if (test_bit(&width_set, 2)) {
+			if (width != OFDM_CHANNEL_WIDTH_80MHZ) {
+				l_warn("Support for 160MHz but not 80MHz!");
+				return -EBADMSG;
+			}
+
+			width = OFDM_CHANNEL_WIDTH_160MHZ;
+		}
+
+		/* B3 indicates support for 80+80MHz */
+		if (test_bit(&width_set, 3)) {
+			if (width != OFDM_CHANNEL_WIDTH_160MHZ) {
+				l_warn("Support for 80+80MHz but not 160MHz!");
+				return -EBADMSG;
+			}
+
+			mcs80p80 = true;
+		}
+
+		break;
+	}
+
+	/*
+	 * The HE-MCS maps are 19 bytes into the HE Capabilities IE, and
+	 * alternate RX/TX every 2 bytes. Start the TX map 19 + 2 bytes
+	 * into the MCS set. For each MCS set find the best data rate.
+	 *
+	 * Note: Since 'hec' is an extended IE index 0 is actually the length
+	 *       since wiphy offsets data - 2.
+	 */
+	rx_map = he_cap->he_mcs_set;
+	tx_map = hec + 21;
+
+	/* 80+80MHz MCS set */
+	if (mcs80p80) {
+		/* 21 + 8 - 1 (len) bytes into the IE, plus 2 for the MCS set */
+		if (hec[0] < 30)
+			return -EBADMSG;
+
+		if (find_rate_he(rx_map + 8, tx_map + 8,
+				OFDM_CHANNEL_WIDTH_160MHZ, rssi, &new_rate))
+			rate = new_rate;
+	}
+
+	/* 160MHz MCS set */
+	if (width == OFDM_CHANNEL_WIDTH_160MHZ) {
+		/* 21 + 4 - 1 (len) bytes into the IE, plus 2 for the MCS set */
+		if (hec[0] < 26) {
+			l_info("bad len");
+			return -EBADMSG;
+		}
+
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
+	for (i = OFDM_CHANNEL_WIDTH_20MHZ; i <= width; i++) {
+		if (find_rate_he(rx_map, tx_map, i, rssi, &new_rate) &&
+					new_rate > rate)
+			rate = new_rate;
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

