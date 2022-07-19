Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F653B7
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 23:41:34 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 23so14880163pgc.8
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDEaMPEEeRMksUIZ9R5VBhwi2TaLhlhH9HDV2FIYK1Y=;
        b=YuSL11TfLduUSPFJg6tNhcPIAJhuzGiXq0TUtB91SegdD06bU0gDV2EePKuQ7rAQlY
         sI+xd17RV5LKq1aFnNkfArgmaEJteTAG84vsOov2s4jHPgTjoAUZXJ7blZIovrKgRPB9
         FUrP4KE9fSyfqW+3xg9nfUKSz/ZdWLrCQxW1na3QSys6j+ynBgE3Af8zqdD+Rzf+zUQ5
         Zal039FQ2GvUeaXXPFUOTGqCIh/DZXIF7zLHVh7YQVk0/PBj3pHKipEeDLD51wqPTod5
         w5/R44Tzx9w4u22jo3mVHw1wNPoEujlaY20J8HfbHzEkVUY5bw4rgSCA7YLCNtuZJHxB
         a70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDEaMPEEeRMksUIZ9R5VBhwi2TaLhlhH9HDV2FIYK1Y=;
        b=JY0ss4IsYakpdCt1xWrjSUNsd/iD6qUqiNEhU/ZrnaAP+zTEEc1bvHw/H+xUJKNPW5
         UBgWfxUPf+LAv9EZKw8n+Squ+P2d6g305IiUnaU39Xpy0an7LWY25UKr8yQBfpiYMvrb
         HuWz+ZDjBzIlVc4Il109gnGx+rOYtWy7+/sSH03myqR8xCle1zWXDxV42457mVVyvU6u
         txL/umkH3mdzkGEaSozDN/+gLPySlB7GlYq65XZFaNQr9t28irF/7L3UqerXemNW8QXG
         JnrQSe0VASrK5Y3qimMnajVCszWpS5dXNHt4HkpNwugYlG1B7w0oL2WBR4lgEKweOP1L
         u7Jw==
X-Gm-Message-State: AJIora8cUjYS2kJ7KxAWYrTNwCNdY0oMEwUf2zwTKhIguyCdKmsS1jjd
	a4/d9EuEauLGd83zd1bMQOjx2F5DG4w=
X-Google-Smtp-Source: AGRyM1s1pZ3rvrTMsQ/EA+i7/6AppNmMG0VV3BBY1WGwx9C+ZSIr4mMOtzS1URy1tMMZMy16DXlejQ==
X-Received: by 2002:a65:590d:0:b0:41a:2b17:b6f8 with SMTP id f13-20020a65590d000000b0041a2b17b6f8mr11066460pgu.143.1658274093950;
        Tue, 19 Jul 2022 16:41:33 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7842a000000b0050dc762816asm11988401pfn.68.2022.07.19.16.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:41:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] band: add band_estimate_he_rx_rate
Date: Tue, 19 Jul 2022 16:39:23 -0700
Message-Id: <20220719233924.559329-1-prestwoj@gmail.com>
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
 src/band.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/band.h |   3 +-
 2 files changed, 238 insertions(+), 9 deletions(-)

v2:
 * Removed confusing loop to iterate widths. Replaced with 3 if blocks
   that calculate the rate based on the MCS set
 * Use OFDM enum instead of band_chandef_width. This did require a special
   case for 80+80, but really simplifies everything else.

diff --git a/src/band.c b/src/band.c
index 0728b0cc..2f9741f1 100644
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
@@ -495,6 +503,226 @@ try_vht80:
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
+ * Finds the best width supported according to capabilities. The 802.11ax spec
+ * has a separate MCS set for 80+80, but in the end 160 and 80+80 are treated
+ * the same in terms of the rate tables. This MCS set still needs to be checked
+ * though which is why the mcs80p80 flag is set in this case.
+ */
+static enum ofdm_channel_width find_he_width_offset(enum band_freq freq,
+				const struct band_he_capabilities *he_cap,
+				const uint8_t *he_phy, bool *mcs80p80)
+{
+
+	uint8_t own_width_set = bit_field(he_cap->he_phy_capa[0], 1, 7);
+	uint8_t peer_width_set = bit_field(he_phy[0], 1, 7);
+	enum ofdm_channel_width max_width = OFDM_CHANNEL_WIDTH_20MHZ;
+
+	/*
+	 * 802.11ax Table 9-322b
+	 */
+	switch (freq) {
+	case BAND_FREQ_2_4_GHZ:
+		/* B0 indicates support for 40MHz */
+		if (test_bit(&peer_width_set, 0) && test_bit(&own_width_set, 0))
+			max_width = OFDM_CHANNEL_WIDTH_40MHZ;
+
+		break;
+	case BAND_FREQ_5_GHZ:
+	case BAND_FREQ_6_GHZ:
+		/* B1 indicates support for 40MHz and 80MHz, choose 80 */
+		if (test_bit(&peer_width_set, 1) && test_bit(&own_width_set, 1))
+			max_width = OFDM_CHANNEL_WIDTH_80MHZ;
+
+		/* B2 indicates support for 160MHz */
+		if (test_bit(&peer_width_set, 2) && test_bit(&own_width_set, 2))
+			max_width = OFDM_CHANNEL_WIDTH_160MHZ;
+
+		/* B3 indicates support for 80+80MHz */
+		if (test_bit(&peer_width_set, 3) &&
+						test_bit(&own_width_set, 3)) {
+			max_width = OFDM_CHANNEL_WIDTH_160MHZ;
+			*mcs80p80 = true;
+		}
+
+		break;
+	}
+
+	return max_width;
+}
+
+/*
+ * HE data rate is calculated based on 802.11ax - Section 27.5
+ */
+int band_estimate_he_rx_rate(const struct band *band, const uint8_t *hec,
+				int32_t rssi, uint64_t *out_data_rate)
+{
+	enum ofdm_channel_width width;
+	const struct band_he_capabilities *he_cap = NULL;
+	const struct l_queue_entry *entry;
+	const uint8_t *rx_map;
+	const uint8_t *tx_map;
+	bool mcs80p80 = false;
+	uint64_t rate = 0;
+	uint64_t new_rate = 0;
+
+	if (!hec || !band->he_capabilities)
+		return -EBADMSG;
+
+	for (entry = l_queue_get_entries(band->he_capabilities);
+						entry; entry = entry->next)
+	{
+		const struct band_he_capabilities *cap = entry->data;
+
+		/*
+		 * TODO: Station type is assumed here since it is the only
+		 *       consumer of these data rate estimation APIs. If this
+		 *       changes the iftype would need to be passed in.
+		 */
+		if (he_cap->iftypes & (1 << NETDEV_IFTYPE_STATION)) {
+			he_cap = cap;
+			break;
+		}
+	}
+
+	if (!he_cap)
+		return -ENOTSUP;
+
+	/* The maximum width sets where to stop checking MCS sets */
+	width = find_he_width_offset(band->freq, he_cap, hec + 8, &mcs80p80);
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
+		/* 21 + 8 bytes into the IE, plus 2 for the MCS set itself */
+		if (hec[0] < 31)
+			return -EBADMSG;
+
+		if (find_rate_he(rx_map + 8, tx_map + 8,
+				OFDM_CHANNEL_WIDTH_160MHZ, rssi, &new_rate))
+			rate = new_rate;
+	}
+
+	/* 160MHz MCS set */
+	if (width == OFDM_CHANNEL_WIDTH_160MHZ) {
+		/* 21 + 4 bytes into the IE, plus 2 for the MCS set itself */
+		if (hec[0] < 27)
+			return -EBADMSG;
+
+		if (find_rate_he(rx_map + 4, tx_map + 4,
+				OFDM_CHANNEL_WIDTH_160MHZ, rssi, &new_rate) &&
+				new_rate > rate)
+			rate = new_rate;
+	}
+
+	/* <= 80MHz MCS set, length checked as this field always exists */
+	if (find_rate_he(rx_map, tx_map, width, rssi, &new_rate) &&
+					new_rate > rate)
+		rate = new_rate;
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

