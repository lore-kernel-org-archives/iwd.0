Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD6259D
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 17:26:23 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso8871623pjb.1
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 09:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/OFUxs3WFoYK/4fYOXedIy+x4+CIpQqbONqf+WaA2E=;
        b=gZaib1NBuKmKm0nkuTbrnZkIgzARfdOknvM85oU7x4nYfPsLVP0zE6pvt2z4a3qWml
         pWYva+3cl0FoaC5ubLAq/DlvVf+MB+cQaVSnDG+Et3kLLff/70O0YaLf58oVe9LytmJF
         C1ViVhoj/NDBOAPw43IDraipgkMWCzJUV/zGnG5FmpsdmyhGqk2V626gnvZ+aJdejkpm
         dEIND3C1Y5uelvkqsxuqDJ01PToy+pVwsXyUiP3FZZn+hC/+3at6D0ktf+whDjzkFC/+
         1/LahjHAcq9pM8Q9tebByd/536nBzJirgNNzIfN0ea/L5hrw5E3WcOUz3j9XVZT0txLy
         8o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/OFUxs3WFoYK/4fYOXedIy+x4+CIpQqbONqf+WaA2E=;
        b=04sjLc7KPk89cQDHY3/oBcrc1ivJBhz1BeRhgb9lQFK75bKKCpPM6GsGfaJR9+pjel
         dSnU1ckeOF1hhqEjj+lCjcIDLSotdH4b9z21kHNdByRMPWCqjrWZwya45ujk639P2gOd
         KAYyyKcxE/kHISbqcUqJe0KzDClfufg86yNiFM2MA/7cZGiQcEz/oeHdU0H9JZHAeC7E
         lto52cctwopZh2YTFRTmTR+H0qGbbYc9+/msSyD37o0OvMZCWd/+Vd8KtE8wTitnjtLy
         HiEDSibcM7/ClYsXOf3P4O8s0RyLE+Xwpf8PG0Yr3HvWkq/p4lg3SZTsJf+4GYPS/142
         17Fg==
X-Gm-Message-State: ANoB5pkhaj9zOKMIbsuZMy9oyyfdl6akxOxwD4XelUVG+oD02diMgsF8
	kMQKq2H5gyBhFLrM9Crq9UbiGL8lJHk=
X-Google-Smtp-Source: AA0mqf7422I76HKY+ffUiTVJEPgTOn7aL4GqZnLEaxAhuoQcFf/C7Vii0hpH+dPJhwsjo6z0I6T+qQ==
X-Received: by 2002:a17:902:a416:b0:189:3fcc:f996 with SMTP id p22-20020a170902a41600b001893fccf996mr33108049plq.21.1671211582570;
        Fri, 16 Dec 2022 09:26:22 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm1913636plx.44.2022.12.16.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:26:21 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/8] wiphy: add getter for frequency/band info
Date: Fri, 16 Dec 2022 09:26:03 -0800
Message-Id: <20221216172606.1799396-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216172606.1799396-1-prestwoj@gmail.com>
References: <20221216172606.1799396-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds two new APIs:

wiphy_get_frequency_info(): Used to get additional information about
a given frequency such as disabled/no-IR. This can also be used to
check if the frequency is supported.

wiphy_band_is_disabled(): Checks if a band is disabled. Note that
an unsupported band will also return true. Checking support should
be done with wiphy_get_supported_bands()
---
 src/wiphy.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wiphy.h |  4 ++++
 2 files changed, 67 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index f3a2a039..7b72b6be 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -496,6 +496,69 @@ const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy)
 	return wiphy->disabled_freqs;
 }
 
+static struct band *wiphy_get_band(const struct wiphy *wiphy, enum band_freq band)
+{
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		return wiphy->band_2g;
+	case BAND_FREQ_5_GHZ:
+		return wiphy->band_5g;
+	case BAND_FREQ_6_GHZ:
+		return wiphy->band_6g;
+	default:
+		return NULL;
+	}
+}
+
+bool wiphy_get_frequency_info(const struct wiphy *wiphy, uint32_t freq,
+				struct band_freq_attrs *attr_out)
+{
+	struct band_freq_attrs attr;
+	enum band_freq band;
+	uint8_t channel;
+	struct band *bandp;
+
+	channel = band_freq_to_channel(freq, &band);
+	if (!channel)
+		return false;
+
+	bandp = wiphy_get_band(wiphy, band);
+	if (!bandp)
+		return false;
+
+	attr = bandp->freq_attrs[channel];
+	if (!attr.supported)
+		return false;
+
+	if (attr_out)
+		*attr_out = attr;
+
+	return true;
+}
+
+bool wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band)
+{
+	struct band_freq_attrs attr;
+	unsigned int i;
+	struct band *bandp;
+
+	bandp = wiphy_get_band(wiphy, band);
+	if (!bandp)
+		return false;
+
+	for (i = 0; i < bandp->freqs_len; i++) {
+		attr = bandp->freq_attrs[i];
+
+		if (!attr.supported)
+			continue;
+
+		if (!attr.disabled)
+			return false;
+	}
+
+	return true;
+}
+
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy)
 {
 	return wiphy->ap_probe_resp_offload;
diff --git a/src/wiphy.h b/src/wiphy.h
index 09dc4530..8411318a 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -102,6 +102,10 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
 
+bool wiphy_get_frequency_info(const struct wiphy *wiphy, uint32_t freq,
+				struct band_freq_attrs *attr_out);
+bool wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band);
+
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
 bool wiphy_can_offload(struct wiphy *wiphy);
-- 
2.34.3

