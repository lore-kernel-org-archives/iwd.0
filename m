Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628A79EB
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:36:33 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id js9so4643985pjb.2
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBAdwWe5NuYlVb+xBDRLsvk1NYaBjwtZ8dCwBoV0LTc=;
        b=e8TrbHuyNVtZk8NOiY8sUhSGhnOGtkq0YQLSP4AI/VCiC3GTBs9RelmsqRtZw6L494
         N6Bo2T9t7QIOy7Mlpx69hEP93TC7JN6qx9/14CcLiescZKbtCZNmeiD5Luz1uA3dsiRA
         a+IQryZRoedLZVJAER1VuG4FPxEwDnh7weUAaUQomtWrei4/OTlX2oAsZXRFIWcSdCPc
         o1z54fNJl27yjgS1HWcibEQ7+hU8dPAjey4U5D9lLUdhxt5SUCE9Ig0aRXjPblwlzicW
         6ljX3SrpoaDGXykqot5HwE62cXUWq4KmVOn0h2L8QLMTvdKi+aY7VNMDB8PI7vUIyoi9
         D8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBAdwWe5NuYlVb+xBDRLsvk1NYaBjwtZ8dCwBoV0LTc=;
        b=C8NIh5qwGKf1XFKJIT1KHw/5Jtl5KB5N4BnwFznUPM+P98PHADqKtZEZuLZDsTpmkl
         8lg2t6bcRG36IVu4sgULP5H/+9opAZETwdfIM6uLie5GhC0vCSaiPBEwHTw4Pk4HWCR0
         q7rL84UGST0K96P6/DgdWQPR0U3q18Ky93QF9wyph8vRaHIqDOO78RKZFKANYvKvSwgA
         s/CRtpmNvY/dByVSbermOiuNCOv09zX40MDEK426bJvupL393rdxk+aRclTZ0FkWcA5J
         YY5EOJqlZahoSLGgjR6JZnEsByC6gyghvc43hGwmHdQ+rK96RHbL2Eujz9FnpmL33gbN
         6KJA==
X-Gm-Message-State: ANoB5pmR3foTuTIrMKJHkPKaJ6c0kKZMfjjrMzbF+jnS2k9H+XkGag9s
	edrA1ziCZsij5+cNL7kR7WQwLdsie5g=
X-Google-Smtp-Source: AA0mqf6KVFbI2Xi36Mr6aoeUfSrmTgqOPI7eD54ounJjoWroj6AYhRmUbX7BK9GVb3GVfX0e8XO83w==
X-Received: by 2002:a17:902:ee45:b0:189:894c:6b48 with SMTP id 5-20020a170902ee4500b00189894c6b48mr22744907plo.59.1670963793281;
        Tue, 13 Dec 2022 12:36:33 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b00189f69c1aa0sm272113plo.270.2022.12.13.12.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:36:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] wiphy: add wiphy_check_{frequency,band}
Date: Tue, 13 Dec 2022 12:36:21 -0800
Message-Id: <20221213203624.1423277-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221213203624.1423277-1-prestwoj@gmail.com>
References: <20221213203624.1423277-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new APIs as a replacement for wiphy_get_disabled_freqs().

wiphy_check_frequency() serves as a way to check a single frequency
for certain attributes, currently: supported, disabled, and no-IR.

wiphy_check_band() similarly checks the entire band. This is mainly
targeted at station which needs to check if a given band is disabled
and is only meant to be used with the supported and disabled flags.
---
 src/wiphy.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wiphy.h |  4 +++
 2 files changed, 93 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index c8ef5937..f5b7c05e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -496,6 +496,95 @@ const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy)
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
+bool wiphy_check_frequency(const struct wiphy *wiphy, uint32_t freq,
+				uint16_t flags)
+{
+	enum band_freq band;
+	struct band *bandp;
+	uint8_t channel;
+	uint16_t mask;
+
+	channel = band_freq_to_channel(freq, &band);
+	if (!channel)
+		return false;
+
+	bandp = wiphy_get_band(wiphy, band);
+	if (!bandp)
+		return false;
+
+	if (L_WARN_ON(channel > bandp->freqs_len))
+		return false;
+
+
+	mask = bandp->frequencies[channel];
+
+	if ((flags & mask) != flags)
+		return false;
+
+	return true;
+}
+
+bool wiphy_check_band(const struct wiphy *wiphy, enum band_freq band,
+				uint16_t flags)
+{
+	unsigned int i;
+	bool supported = false;
+	bool disabled = true;
+	bool ret = false;
+	struct band *bandp = wiphy_get_band(wiphy, band);
+
+	/*
+	 * Caller should either include the SUPPORTED flag, or verify support
+	 * before calling otherwise this return could be misleading i.e.
+	 * checking a band for only DISABLED that isn't supported would
+	 * return false which could be interpreted that the band is enabled.
+	 */
+	if ((flags & BAND_FREQ_ATTR_SUPPORTED) && !bandp)
+		return false;
+
+	if (L_WARN_ON(!bandp))
+		return false;
+
+	/*
+	 * This should only be used with SUPPORTED/DISABLED flags. For supported
+	 * only ONE frequency needs to be supported. And for DISABLED ALL
+	 * frequencies must be disabled.
+	 */
+	for (i = 0; i < bandp->freqs_len; i++) {
+		uint16_t mask = bandp->frequencies[i];
+
+		if (!(mask & BAND_FREQ_ATTR_SUPPORTED))
+			continue;
+
+		supported = true;
+
+		if (!(mask & BAND_FREQ_ATTR_DISABLED))
+			disabled = false;
+	}
+
+	if (supported && (flags & BAND_FREQ_ATTR_SUPPORTED))
+		ret = true;
+
+	if (disabled && (flags & BAND_FREQ_ATTR_DISABLED))
+		ret &= true;
+
+	return ret;
+}
+
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy)
 {
 	return wiphy->ap_probe_resp_offload;
diff --git a/src/wiphy.h b/src/wiphy.h
index 410105dd..469ccdc8 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -100,6 +100,10 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
+bool wiphy_check_frequency(const struct wiphy *wiphy, uint32_t freq,
+				uint16_t flags);
+bool wiphy_check_band(const struct wiphy *wiphy, enum band_freq band,
+				uint16_t flags);
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
 bool wiphy_can_offload(struct wiphy *wiphy);
-- 
2.34.3

