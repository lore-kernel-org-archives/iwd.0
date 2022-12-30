Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB01101
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 00:24:34 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id 18so1402574pfx.7
        for <iwd@lists.linux.dev>; Thu, 29 Dec 2022 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww+HjbOuXFHg//xcdSjiXlDlDfs7IRjEgP0wi0q/1h8=;
        b=PooAorFA01h/7Usno7vL8zNIpRxBqVlyIuKVa8D1D7pOVw/ent+dcrveT/ZotO0E/S
         /gpckYWcS/VWfTPp6wLumahp4IdgzdA3FdIbqmudEGVVk8Rl1s94WF6diE1Fqykn8epM
         JyygAUzo9p7LxYHiExhNi6T70H6QIXFfFHIvtPgfSgjn5IjJcuTUBr13grl3u/wJNOmb
         uFwyzGkmu7f+rMVvuTgjj7sWdIGZ1NdO8Jv32oSJ4DllDD2O3DPcG9XZyGmXrmSb8Knu
         fGKI9gCepeJDJ8zc1RSxnlpmoq5ByfclZwHkUcK+4jiJPrrp4VZ1v9hBJ4+TC8GmCqOb
         Dogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww+HjbOuXFHg//xcdSjiXlDlDfs7IRjEgP0wi0q/1h8=;
        b=3HZ19DGmq/IEq2m/yBn81Ojtj8qGEyqwSz1SL2CRn6WjWDVcEWfDIGk8mslzL5HHGz
         YCEYCLrvlyjvfECzylSatyCghIEKTuewCEBqwVHTZi1RtK5214H0Fkx8EBLRacG+y8Ut
         0dOT9g4N6pKs1QoprP1Ar4ytI4txuOMvUCUuNI4YPRWdSuX/hT4fAM3+9s3muSi5OVpG
         ZtuqrFeitN5ehhiEZ6tOI6XaFWySsYvtywfvgNAFpC9OVdzMdzWokxEYUDgcBahCbPMP
         gdeLaTjReQ4w3qAv+xWbDuNcnxk01XMdYjaHCbuLveXPOgSivf9ubvsu9h8wY0xOyKMY
         zdEw==
X-Gm-Message-State: AFqh2kruROp3lPNcqKCcLoqJHAx6u1dBoWWPop+aZwjqaKdo7jNQO3bw
	Rr43NuXaCGjQL+KU4MQIkws/ndP6rL0=
X-Google-Smtp-Source: AMrXdXvNGaKd7jtLhRlNPJsU4D84oE4YcZO1DJoVadQLWIaDyaxbnk1AMr/qJdBLgcvYzC9K1VewOQ==
X-Received: by 2002:a05:6a00:993:b0:581:c2d3:dc5e with SMTP id u19-20020a056a00099300b00581c2d3dc5emr6671697pfg.11.1672359874158;
        Thu, 29 Dec 2022 16:24:34 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79726000000b0057681626495sm13018325pfg.141.2022.12.29.16.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 16:24:33 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] band: validate channel/freq conversions with E-4
Date: Thu, 29 Dec 2022 16:24:27 -0800
Message-Id: <20221230002428.2870506-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221230002428.2870506-1-prestwoj@gmail.com>
References: <20221230002428.2870506-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IWD's channel/frequency conversions use simple math to convert and
have very minimal checks to ensure the input is valid. This can
lead to some channels/frequencies being calculated which are not
in IWD's E-4 table, specifically in the 5GHz band.

This is especially noticable using mac80211_hwsim which includes
some obscure high 5ghz frequencies which are not part of the 802.11
spec.

To fix this calculate the frequency or channel then iterate E-4
operating classes to check that the value actually matches a class.
---
 src/band.c | 79 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/src/band.c b/src/band.c
index c89762a9..27b4d174 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1283,6 +1283,8 @@ int band_freq_to_ht_chandef(uint32_t freq, const struct band_freq_attrs *attr,
 
 uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
 {
+	unsigned int i;
+	enum band_freq band = 0;
 	uint32_t channel = 0;
 
 	if (freq >= 2412 && freq <= 2484) {
@@ -1297,10 +1299,8 @@ uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
 			channel /= 5;
 		}
 
-		if (out_band)
-			*out_band = BAND_FREQ_2_4_GHZ;
-
-		return channel;
+		band = BAND_FREQ_2_4_GHZ;
+		goto check_e4;
 	}
 
 	if (freq >= 5005 && freq < 5900) {
@@ -1309,10 +1309,9 @@ uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
 
 		channel = (freq - 5000) / 5;
 
-		if (out_band)
-			*out_band = BAND_FREQ_5_GHZ;
+		band = BAND_FREQ_5_GHZ;
 
-		return channel;
+		goto check_e4;
 	}
 
 	if (freq >= 4905 && freq < 5000) {
@@ -1321,10 +1320,9 @@ uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
 
 		channel = (freq - 4000) / 5;
 
-		if (out_band)
-			*out_band = BAND_FREQ_5_GHZ;
+		band = BAND_FREQ_5_GHZ;
 
-		return channel;
+		goto check_e4;
 	}
 
 	if (freq > 5950 && freq <= 7115) {
@@ -1333,17 +1331,31 @@ uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
 
 		channel = (freq - 5950) / 5;
 
-		if (out_band)
-			*out_band = BAND_FREQ_6_GHZ;
+		band = BAND_FREQ_6_GHZ;
 
-		return channel;
+		goto check_e4;
 	}
 
 	if (freq == 5935) {
-		if (out_band)
-			*out_band = BAND_FREQ_6_GHZ;
+		band = BAND_FREQ_6_GHZ;
+		channel = 2;
+	}
+
+	if (!band || !channel)
+		return 0;
+
+check_e4:
+	for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
+		const struct operating_class_info *info =
+						&e4_operating_classes[i];
+
+		if (e4_has_frequency(info, freq) == 0 ||
+					e4_has_ccfi(info, freq) == 0) {
+			if (out_band)
+				*out_band = band;
 
-		return 2;
+			return channel;
+		}
 	}
 
 	return 0;
@@ -1351,26 +1363,33 @@ uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
 
 uint32_t band_channel_to_freq(uint8_t channel, enum band_freq band)
 {
+	unsigned int i;
+	uint32_t freq = 0;
+
 	if (band == BAND_FREQ_2_4_GHZ) {
 		if (channel >= 1 && channel <= 13)
-			return 2407 + 5 * channel;
+			freq = 2407 + 5 * channel;
+		else if (channel == 14)
+			freq = 2484;
 
-		if (channel == 14)
-			return 2484;
+		goto check_e4;
 	}
 
 	if (band == BAND_FREQ_5_GHZ) {
 		if (channel >= 1 && channel <= 179)
-			return 5000 + 5 * channel;
+			freq = 5000 + 5 * channel;
+		else if (channel >= 181 && channel <= 199)
+			freq = 4000 + 5 * channel;
 
-		if (channel >= 181 && channel <= 199)
-			return 4000 + 5 * channel;
+		goto check_e4;
 	}
 
 	if (band == BAND_FREQ_6_GHZ) {
 		/* operating class 136 */
-		if (channel == 2)
-			return 5935;
+		if (channel == 2) {
+			freq = 5935;
+			goto check_e4;
+		}
 
 		/* Channels increment by 4, starting with 1 */
 		if (channel % 4 != 1)
@@ -1380,7 +1399,17 @@ uint32_t band_channel_to_freq(uint8_t channel, enum band_freq band)
 			return 0;
 
 		/* operating classes 131, 132, 133, 134, 135 */
-		return 5950 + 5 * channel;
+		freq = 5950 + 5 * channel;
+	}
+
+check_e4:
+	for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
+		const struct operating_class_info *info =
+						&e4_operating_classes[i];
+
+		if (e4_has_frequency(info, freq) == 0 ||
+					e4_has_ccfi(info, freq) == 0)
+			return freq;
 	}
 
 	return 0;
-- 
2.34.3

