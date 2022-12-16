Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF08BE6
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 21:27:49 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id m4so3560165pls.4
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 13:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDEe1f6DOax2hSj/46o8i+xvls0SSIxpwlDKeHB+i6k=;
        b=YAdsFLQHBUyz31q8zUCOb6AmXWTGyYfkZC8n2tMpG3Hw5g4VBQI7IU9so8SenbzFI/
         RBuu1wtus6Pnv8286I3Uv2zCmL2HDcH72gzWlS06F3CMyH+TGJgAujzKqsZK5LesWi/k
         Z/lnyyomU6BuVTn3y9biQ9ygtx1wbR9WSzDo9ZC3uQ4lHBXE0Kk9LVj8I8tx2kV/am3e
         5OkQhoFKLu+NMuwn2HA5VxgZZ4RCwVYKKGkRMg2V1TxHVQTWRu6EsRsZWab3k77fabg4
         7iP48SNJWbveI+BYuRWDJxFgwFuguzspTMKAao3ZQzl6ebhhHs/R5SP8JaTbrMuDNqTw
         Orfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDEe1f6DOax2hSj/46o8i+xvls0SSIxpwlDKeHB+i6k=;
        b=vLszRgv6221hie8Su1BYnoDFRrhNra2PKYwBLnJ4Z/nLv3w6F5SkDUpx9ztFG6Augp
         C+pkdUVjELg3mIOKbMVu5Psgp3xvZds0RA1thD6Fw+Q4tXvj0DlixpNHvABahVUjbJI3
         go32uBQ8VvlRao2oa8lF3tqdeS7G/WsydVWQMgq7Y9DTvMgfuNfoQiTGgwIJrIcii7AX
         p6DEDZ8EQHsXBLpdCRuOsqpH+Qx8REXTallbfHmXCFOxUndVGcLyFjv2u7quXUr5qWk3
         mVKGXlTIqPymRD9i9NRhPqug6z/Ni6X+yzte5M4Ht3U5k0Fhe/dp10kQ/gtM7rXXawbT
         j6iw==
X-Gm-Message-State: ANoB5pnHHZTWpSRhwKU5GPfuxIfEvAvV6+YC34AWxT4tOj6y/gDtldci
	D07deY1+ABB5uyDMxcVMAiwV2/zOtw0=
X-Google-Smtp-Source: AA0mqf7n1nCCLQt7cv7AMhkszwaCP3XtW4KzBjVpZDA3yaUrGrzaTQdh4+sGVOd9YjfjO90K+D51Lg==
X-Received: by 2002:a05:6a20:bc82:b0:ad:79bb:7487 with SMTP id fx2-20020a056a20bc8200b000ad79bb7487mr25182401pzb.50.1671226069094;
        Fri, 16 Dec 2022 13:27:49 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b004785e505bcdsm1905404pgz.51.2022.12.16.13.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:27:48 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 5/8] wiphy: add getter for frequency/band info
Date: Fri, 16 Dec 2022 13:27:38 -0800
Message-Id: <20221216212741.1833286-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216212741.1833286-1-prestwoj@gmail.com>
References: <20221216212741.1833286-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds two new APIs:

wiphy_get_frequency_info(): Used to get information about a given
frequency such as disabled/no-IR. This can also be used to check
if the frequency is supported (NULL return is unsupported).

wiphy_band_is_disabled(): Checks if a band is disabled. Note that
an unsupported band will also return true. Checking support should
be done with wiphy_get_supported_bands()
---
 src/wiphy.c | 91 +++++++++++++++++++++++++++++++++++++----------------
 src/wiphy.h |  5 +++
 2 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index f3a2a039..714da9bc 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -496,6 +496,67 @@ const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy)
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
+const struct band_freq_attrs *wiphy_get_frequency_info(
+						const struct wiphy *wiphy,
+						uint32_t freq)
+{
+	struct band_freq_attrs *attr;
+	enum band_freq band;
+	uint8_t channel;
+	struct band *bandp;
+
+	channel = band_freq_to_channel(freq, &band);
+	if (!channel)
+		return NULL;
+
+	bandp = wiphy_get_band(wiphy, band);
+	if (!bandp)
+		return NULL;
+
+	attr = &bandp->freq_attrs[channel];
+	if (!attr->supported)
+		return NULL;
+
+	return attr;
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
+		return true;
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
@@ -819,21 +880,7 @@ const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy,
 						enum band_freq band,
 						unsigned int *out_num)
 {
-	struct band *bandp;
-
-	switch (band) {
-	case BAND_FREQ_2_4_GHZ:
-		bandp = wiphy->band_2g;
-		break;
-	case BAND_FREQ_5_GHZ:
-		bandp = wiphy->band_5g;
-		break;
-	case BAND_FREQ_6_GHZ:
-		bandp = wiphy->band_6g;
-		break;
-	default:
-		return NULL;
-	}
+	struct band *bandp = wiphy_get_band(wiphy, band);
 
 	if (!bandp)
 		return NULL;
@@ -891,19 +938,9 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	if (band_freq_to_channel(bss->frequency, &band) == 0)
 		return -ENOTSUP;
 
-	switch (band) {
-	case BAND_FREQ_2_4_GHZ:
-		bandp = wiphy->band_2g;
-		break;
-	case BAND_FREQ_5_GHZ:
-		bandp = wiphy->band_5g;
-		break;
-	case BAND_FREQ_6_GHZ:
-		bandp = wiphy->band_6g;
-		break;
-	default:
+	bandp = wiphy_get_band(wiphy, band);
+	if (!bandp)
 		return -ENOTSUP;
-	}
 
 	ie_tlv_iter_init(&iter, ies, ies_len);
 
diff --git a/src/wiphy.h b/src/wiphy.h
index 09dc4530..c1919b4c 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -102,6 +102,11 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
 
+const struct band_freq_attrs *wiphy_get_frequency_info(
+						const struct wiphy *wiphy,
+						uint32_t freq);
+bool wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band);
+
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
 bool wiphy_can_offload(struct wiphy *wiphy);
-- 
2.34.3

