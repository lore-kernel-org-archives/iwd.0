Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB404C82
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:58:03 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id f65so14289629pgc.12
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KcvNn+AQjlEqAPy2h2PYY6FrxxoPivkqhcSN5c1hIno=;
        b=Up9X9HOlaNZB8wGFI/zvDWukJflJM+WP6NFPmNoR1OS8mNEmGygMu4TKyHBJ+4oiSi
         x0HcbdnwNGBm8MXEvxv9WosVBHl59Y53BiA7OmggQ5MVolTk88CZYOvteesBU+jTUG9P
         GiStsS3J9SwxUz+cL6P9QsdJGQWc51CfGg9+/UoVkMVBmkRWSx+cHSh+nTcZ6XS7SZZ0
         Dle44/OhBd9wSEYa6CfP2usRyn9UlxVLudGCp2yvJ8CQ5SXk1RnGEsiEMbOYWCVNHCAh
         Y0y2NK3FGZu867zjUbphcnGobNUUUgffJ3qVZ7gDedJy1DCsaSeN9iARfuMGq7QUokiB
         MacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KcvNn+AQjlEqAPy2h2PYY6FrxxoPivkqhcSN5c1hIno=;
        b=lB9T0y+QvapxGIhMc37baQUvXiahm+XpczRtHLDeXP7QrYEtiGIaD8v4z5LttEMhiH
         NpQYDgXDNPkEqvdkNd/ELx8226ajwYvQ5xgYnvR0t0jcHkJCqXKYlp1D1KuS+QnFCRIC
         viUmBqSwKOC5Wqa2VTSYuLilkk6zcxc3oo9gtLssqXZKDetQLIFiwy1Paxwt+HWMaB4x
         qud7nHGm5zno0OyWyS+sqDg4DvmwvJ+iTTQ8kv7XqcftwOHyfgbJUMGUqRin0Plnl1Qd
         QFw0i2fzw31Miwjf8ozgOpSFUgAtcAfilAQDT1xmQy2bkobB30Q8qQeukGkpx32aGYeI
         rndA==
X-Gm-Message-State: AJIora9+iCviqzng0I4q2fRPLKgzF7BjtO/pTqSQyfoxmJZFrCFHfB9H
	Kbz2GLT4R43KSxYWD4HT4ZHkt28Bgac=
X-Google-Smtp-Source: AGRyM1sXiKGzmBwKxWo3Cqs8haYexY/iu8WEEc36ZvHYMs3w0oRxE+FHBEHVmpDJwozltNZxblCbLg==
X-Received: by 2002:a65:6151:0:b0:412:e419:d651 with SMTP id o17-20020a656151000000b00412e419d651mr30660252pgv.378.1658257082836;
        Tue, 19 Jul 2022 11:58:02 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:58:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/12] band: add find_best_mcs_nss
Date: Tue, 19 Jul 2022 11:55:41 -0700
Message-Id: <20220719185544.456727-9-prestwoj@gmail.com>
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

This is a general way of finding the best MCS/NSS values which will work
for HT, VHT, and HE by passing in the max MCS values for each value which
the MCS map could contain (0, 1, or 2).
---
 src/band.c | 75 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/src/band.c b/src/band.c
index 67bbcd79..0728b0cc 100644
--- a/src/band.c
+++ b/src/band.c
@@ -334,6 +334,56 @@ static bool find_best_mcs_vht(uint8_t max_index, enum ofdm_channel_width width,
 	return false;
 }
 
+static bool find_best_mcs_nss(const uint8_t *rx_map, const uint8_t *tx_map,
+				uint8_t value0, uint8_t value1, uint8_t value2,
+				uint32_t *mcs_out, uint32_t *nss_out)
+{
+	uint32_t nss = 0;
+	uint32_t max_mcs = 0;
+	int bitoffset;
+
+	for (bitoffset = 14; bitoffset >= 0; bitoffset -= 2) {
+		uint8_t rx_val = bit_field(rx_map[bitoffset / 8],
+							bitoffset % 8, 2);
+		uint8_t tx_val = bit_field(tx_map[bitoffset / 8],
+							bitoffset % 8, 2);
+
+		/*
+		 * 0 indicates support for MCS 0 - value0
+		 * 1 indicates support for MCS 0 - value1
+		 * 2 indicates support for MCS 0 - value2
+		 * 3 indicates no support
+		 */
+
+		if (rx_val == 3 || tx_val == 3)
+			continue;
+
+		/* rx_val/tx_val tells us which value# to use */
+		max_mcs = minsize(rx_val, tx_val);
+		switch (max_mcs) {
+		case 0:
+			max_mcs = value0;
+			break;
+		case 1:
+			max_mcs = value1;
+			break;
+		case 2:
+			max_mcs = value2;
+			break;
+		}
+
+		nss = bitoffset / 2 + 1;
+		break;
+	}
+
+	if (!nss)
+		return false;
+
+	*nss_out = nss;
+	*mcs_out = max_mcs;
+
+	return true;
+}
 /*
  * IEEE 802.11 - Table 9-250
  *
@@ -355,7 +405,6 @@ int band_estimate_vht_rx_rate(const struct band *band,
 	uint32_t max_mcs = 7; /* MCS 0-7 for NSS:1 is always supported */
 	const uint8_t *rx_mcs_map;
 	const uint8_t *tx_mcs_map;
-	int bitoffset;
 	uint8_t chan_width;
 	uint8_t channel_offset;
 	bool sgi;
@@ -378,29 +427,7 @@ int band_estimate_vht_rx_rate(const struct band *band,
 	rx_mcs_map = band->vht_mcs_set;
 	tx_mcs_map = vhtc + 2 + 8;
 
-	for (bitoffset = 14; bitoffset >= 0; bitoffset -= 2) {
-		uint8_t rx_val = bit_field(rx_mcs_map[bitoffset / 8],
-							bitoffset % 8, 2);
-		uint8_t tx_val = bit_field(tx_mcs_map[bitoffset / 8],
-							bitoffset % 8, 2);
-
-		/*
-		 * 0 indicates support for MCS 0-7
-		 * 1 indicates support for MCS 0-8
-		 * 2 indicates support for MCS 0-9
-		 * 3 indicates no support
-		 */
-
-		if (rx_val == 3 || tx_val == 3)
-			continue;
-
-		/* 7 + rx_val/tx_val gives us the maximum mcs index */
-		max_mcs = minsize(rx_val, tx_val) + 7;
-		nss = bitoffset / 2 + 1;
-		break;
-	}
-
-	if (!nss)
+	if (!find_best_mcs_nss(rx_mcs_map, tx_mcs_map, 7, 8, 9, &max_mcs, &nss))
 		return -EBADMSG;
 
 	/*
-- 
2.34.1

