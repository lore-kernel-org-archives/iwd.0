Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56039620
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 22:32:34 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id t2so17288276ply.2
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 14:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QnAWux5Mu4OeJ+Ro6h/aXMnVu21qL7suveMybj17lbU=;
        b=AEVzOAAMBwIPOKey8jbhhtOJPQG6BUSFULOqm6+uBkE8kGitisR9zohrDaQu+P3VW8
         UMvQJPn5qzk3vTScTcs2D5T92NuiYs1DH2K0wS6q59pGOXIvDM1G2N+OZ2zXJ+1y1fgp
         Hwymj2OxdOnn6BAwpcbojMFEoPpB2RXWHqIRfWkkQypZdX8Du9VSfWOhq8JqKiSdw465
         r78Nrx2/KL7FVUyBiExFj/6JJyfAiiWnZewBF0eIXDx0EvUksYTbJ/dRedoPV/sm6Qhl
         H/Iu7aWUlu86SOX9m5oYggOrtdnP88h95zIT9+OEIHCJqKL3xUKru+/Bfd7lJa3vz1eX
         oJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnAWux5Mu4OeJ+Ro6h/aXMnVu21qL7suveMybj17lbU=;
        b=UzhfujPdRu2gQXl3yS+nSnqToUzJKIxc2E6ntWqPzZb9KMJS8yGarZOwQhJVEoSU+a
         emE/cOpNB7q0F8dhen6V5lVzLmFt3CrIS1QJaIb03dVMGifX7uN0cjvDOADwToWQ2PuM
         RZjMHZJfKSjyTHyGTOjBv/ZH6YVLV2W/WfBNKdZwtK3eSa4HULlZjMNm2gTf2DnGZ+hp
         M5nluGV5ofuX4BxQlprj8yoFYnuTg2CNXi17bnQz2O8BWq8sSGNl5xAxDRKLxZOttKnr
         juiqyvgt3TIl6oZm7OUc1/J5QE7F/wcZr3j0oro7dGa9+k8+rVQgkXs0Z6WKMujvWrZU
         Kk+w==
X-Gm-Message-State: AFqh2krmFW82wEFnb0kicx3INjFcMe2wHcVrYWm2DhjOHx0BR30rnIo5
	dTWmNuUFYeLrclrJ9wFg7wSPtRaaQ8Q=
X-Google-Smtp-Source: AMrXdXss13iq14INzjSS3U6vafGn5vQbU7Ds1VN/2q1cH5OEw7hv/62QrYeqZ8IxN7K0IHelz3yIJA==
X-Received: by 2002:a17:903:2404:b0:18d:61f6:e254 with SMTP id e4-20020a170903240400b0018d61f6e254mr44262469plo.33.1672266753595;
        Wed, 28 Dec 2022 14:32:33 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0017849a2b56asm11549544plg.46.2022.12.28.14.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 14:32:33 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] band: generate HT chandef from frequency
Date: Wed, 28 Dec 2022 14:32:28 -0800
Message-Id: <20221228223231.2686276-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
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
etc. For now only HT is supported as VHT/HE etc. require
additional secondary channel frequencies.

The HT API tries to find an operating class using 40Mhz which
complies with any hardware restrictions. If an operating class is
found that is supported/not restricted it is marked as 'best' until
a better one is found. In this case 'better' is a larger channel
width. Since this is HT only 20mhz and 40mhz widths are checked.
---
 src/band.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/band.h |  2 ++
 2 files changed, 89 insertions(+)

diff --git a/src/band.c b/src/band.c
index 53ce9495..c89762a9 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1194,6 +1194,93 @@ int oci_from_chandef(const struct band_chandef *own, uint8_t oci[static 3])
 	return -ENOENT;
 }
 
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
+	if (!band_freq_to_channel(freq, &band))
+		return -EINVAL;
+
+	for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
+		const struct operating_class_info *info =
+						&e4_operating_classes[i];
+		enum band_chandef_width w;
+
+		if (e4_has_frequency(info, freq) < 0)
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
index 0ae5f8c0..676c63d9 100644
--- a/src/band.h
+++ b/src/band.h
@@ -101,6 +101,8 @@ int band_estimate_nonht_rate(const struct band *band,
 				const uint8_t *supported_rates,
 				const uint8_t *ext_supported_rates,
 				int32_t rssi, uint64_t *out_data_rate);
+int band_freq_to_ht_chandef(uint32_t freq, const struct band_freq_attrs *attr,
+				struct band_chandef *chandef);
 
 int oci_to_frequency(uint32_t operating_class, uint32_t channel);
 
-- 
2.34.3

