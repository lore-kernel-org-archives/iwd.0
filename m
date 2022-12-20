Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE28F75
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:27 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so99984pje.5
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwFeoDNVXoxMz9Xc4iy4fI0FlAsU/4vYOHosD/5Cras=;
        b=dYzk5u7cTXE45YgMZXVNMiTJ9PEwEU/UGL5MYXhL9uHfJUjPebvHGgKjXQbztogh7B
         gC0Kd3qWCTUwZ4L3gWbb/9Bz/8a/D96ffKxXplMKRe97Fvvmk7SoakPFpnwCzExGrsnE
         3mAkNAgMJYaWA9oKOMKcHhFXaEuvVkCMV/0Q4G3QIpoNnVWh9UsHpXfEn7doISLDh1tq
         yaXAky5KrztupJ5UEOq4hb2g86aZWxO4BPZTJ62QsHQqG8ZTxCAhqrn3cjaSQXTf19cu
         5e9Jpq/Sf9W3KbrXEUaHVKk9oipG4oG2YWy3X8td6lpN/eAGZpnmRuloCRUCfxDWSqz/
         TTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwFeoDNVXoxMz9Xc4iy4fI0FlAsU/4vYOHosD/5Cras=;
        b=27envnonQmgZgKDSl/mRfpeVmrEe+4vvE+Bd6vWG46K1DZ1vpJvJSswOkn1jC4RxcL
         a4JBv8q29LXM0UcO6CzA3Bm1MuCYGjgKP/p48rufWFowXG+1TRxnJ2kkW9uZnSYAQM5j
         FbWqkD4WC5tHgLzMe/H7bcNV2aX24pOfKv5MOB1IlS84yI+IzpTpWqHUpO2zR6od2EAf
         u7+aoRjBdEWKcA8oaXqpYXDQgDuVHIYHMZh6nxezgUt27v4sf/6CjmbNbclJ9+zJXrSl
         gUoRBE9fcUWmlxugbl8Ai1SdvE52HPBRTzdh7cgM97rJWePmNy66UFeuaor/GXZ2RRuy
         6PiQ==
X-Gm-Message-State: ANoB5plnMH7f35aXPbMySd8IwgmConYCRlQ3Drd4tKoneQh1rPqsEV0m
	zDRoIzWDJxEtKdRq63ZM8H2Og0ldplo=
X-Google-Smtp-Source: AA0mqf4AWG/iiRoZrG7H7fJoB5pOtGXwae48J/vvE3770xf7wB0+cMibtHjSTPgE02R85h9Auv+vsA==
X-Received: by 2002:a17:90a:1b0e:b0:219:787c:4925 with SMTP id q14-20020a17090a1b0e00b00219787c4925mr49646943pjq.14.1671572606504;
        Tue, 20 Dec 2022 13:43:26 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/10] band: add APIs to generate a chandef from frequency
Date: Tue, 20 Dec 2022 13:43:13 -0800
Message-Id: <20221220214318.2041986-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For AP mode its convenient for IWD to choose an appropriate
channel definition rather than require the user provide very
low level parameters such as channel width, center1 frequency
etc. This adds two new APIs to generate a channel definition, one
for legacy and one for HT.

The legacy API is very simple and chooses the first matching
operating class using 20Mhz channel widths.

The HT API is a bit more complex since it has to take into account
40MHz and check any channel restrictions. If an operating class is
found that is supported/not restricted it is marked as 'best' until
a better one is found. In this case 'better' is a larger channel
width. Since this is HT only 20mhz and 40mhz widths are checked.
---
 src/band.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/band.h |   4 ++
 2 files changed, 163 insertions(+)

diff --git a/src/band.c b/src/band.c
index d89b2a90..b1e319d7 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1194,6 +1194,165 @@ int oci_from_chandef(const struct band_chandef *own, uint8_t oci[static 3])
 	return -ENOENT;
 }
 
+static bool freq_in_oper_class(uint32_t freq,
+				const struct operating_class_info *info,
+				enum band_freq *out_band)
+{
+	uint8_t channel;
+	enum band_freq band;
+
+	channel = band_freq_to_channel(freq, &band);
+	if (!channel)
+		return false;
+
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		if (info->starting_frequency > 5000)
+			return false;
+		break;
+	case BAND_FREQ_5_GHZ:
+		if (info->starting_frequency < 5000 ||
+				info->starting_frequency > 5950)
+			return false;
+		break;
+	case BAND_FREQ_6_GHZ:
+		if (info->starting_frequency < 5900)
+			return false;
+		break;
+	}
+
+	if (e4_channel_to_frequency(info, channel) < 0)
+		return false;
+
+	if (out_band)
+		*out_band = band;
+
+	return true;
+}
+
+/* Find a legacy chandef for the frequency */
+int band_freq_to_chandef(uint32_t freq, const struct band_freq_attrs *attr,
+				struct band_chandef *chandef)
+{
+	enum band_freq band;
+	uint8_t channel;
+	unsigned int i;
+	const struct operating_class_info *best = NULL;
+
+	channel = band_freq_to_channel(freq, &band);
+	if (!channel)
+		return -EINVAL;
+
+	if (attr->disabled || !attr->supported)
+		return -EINVAL;
+
+	for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
+		const struct operating_class_info *info =
+						&e4_operating_classes[i];
+
+		if (!freq_in_oper_class(freq, info, NULL))
+			continue;
+
+		if (info->channel_spacing != 20)
+			continue;
+
+		best = info;
+		break;
+	}
+
+	if (!best)
+		return -ENOENT;
+
+	chandef->frequency = freq;
+	chandef->channel_width = BAND_CHANDEF_WIDTH_20NOHT;
+
+	return 0;
+}
+
+/* Find an HT chandef for the frequency */
+int band_freq_to_ht_chandef(uint32_t freq, const struct band_freq_attrs *attr,
+				struct band_chandef *chandef)
+{
+	enum band_freq band;
+	enum band_chandef_width width;
+	unsigned int i;
+	const struct operating_class_info *best = NULL;
+
+	if (attr->disabled || !attr->supported)
+		return -EINVAL;
+
+	for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
+		const struct operating_class_info *info =
+						&e4_operating_classes[i];
+		enum band_chandef_width w;
+
+		if (!freq_in_oper_class(freq, info, &band))
+			continue;
+
+		/* Any restrictions for this channel width? */
+		switch (info->channel_spacing) {
+		case 20:
+			w = BAND_CHANDEF_WIDTH_20;
+			break;
+		case 40:
+			w = BAND_CHANDEF_WIDTH_40;
+
+			/* 6GHz remove the upper/lower 40mhz channel concept */
+			if (band == BAND_FREQ_6_GHZ)
+				break;
+
+			if (info->flags & PRIMARY_CHANNEL_UPPER &&
+						attr->no_ht40_plus)
+				continue;
+
+			if (info->flags & PRIMARY_CHANNEL_LOWER &&
+						attr->no_ht40_minus)
+				continue;
+
+			break;
+		default:
+			continue;
+		}
+
+		if (!best || best->channel_spacing < info->channel_spacing) {
+			best = info;
+			width = w;
+		}
+	}
+
+	if (!best)
+		return -ENOENT;
+
+	chandef->frequency = freq;
+	chandef->channel_width = width;
+
+	/*
+	 * Choose a secondary channel frequency:
+	 * - 20mhz no secondary
+	 * - 40mhz we can base the selection off the channel flags, either
+	 *   higher or lower.
+	 */
+	switch (width) {
+	case BAND_CHANDEF_WIDTH_20:
+		return 0;
+	case BAND_CHANDEF_WIDTH_40:
+		if (band == BAND_FREQ_6_GHZ)
+			return 0;
+
+		if (best->flags & PRIMARY_CHANNEL_UPPER)
+			chandef->center1_frequency = freq - 10;
+		else
+			chandef->center1_frequency = freq + 10;
+
+		return 0;
+	default:
+		/* Should never happen */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
 {
 	uint32_t channel = 0;
diff --git a/src/band.h b/src/band.h
index a4652fd8..f7f0c318 100644
--- a/src/band.h
+++ b/src/band.h
@@ -101,6 +101,10 @@ int band_estimate_nonht_rate(const struct band *band,
 				const uint8_t *supported_rates,
 				const uint8_t *ext_supported_rates,
 				int32_t rssi, uint64_t *out_data_rate);
+int band_freq_to_chandef(uint32_t freq, const struct band_freq_attrs *attr,
+				struct band_chandef *chandef);
+int band_freq_to_ht_chandef(uint32_t freq, const struct band_freq_attrs *attr,
+				struct band_chandef *chandef);
 
 int oci_to_frequency(uint32_t operating_class, uint32_t channel);
 
-- 
2.34.3

