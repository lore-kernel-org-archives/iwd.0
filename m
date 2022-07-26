Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5E6007
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:31 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so1379061pjh.0
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFOXt4NLA1qf7OkljVUl1M49aAtiCV2fvoraDTrBFZU=;
        b=lYUyZv6Eq/DGCHbJZExjNBfmVEDVlyqU4sEPt5zMct0Ur8XTq4aFB7xDEMl8n8J2V+
         zWaRp/cd8qjtfHf9IjKrI72RfXYnegR+8ulXpf4D4YYGIM4AwyRRohdP3MmKgSzO7U8l
         zczsfw58YXd9HHU7k9bYwreRvKvXPl8en9HJdlz1iq5BOYxPdsxpo3ehheFiQ12G867T
         4+iyDyNhq/ApGxKGOQ2PPgYNJgqaQ2N4CslbssUM61rya1zO2dMwuBOfv8z3/RHwzo32
         ZwSyOdhex4dZsem9ANqPxukLvcGVj2hS6SH1M+kWHfAtQd0JpFCgduY/n/ThmnF/CTfD
         qCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFOXt4NLA1qf7OkljVUl1M49aAtiCV2fvoraDTrBFZU=;
        b=sOoJ/vC7PPKVoUcnFNquo8VrDru1dVaZMvCMzPYC5oI0O9k1zhZDwn9ZFBJrxYpVFm
         cw8ShJpORFqipokP1ocZSoZ9VOcgbt1/HE78IwaYqqAH5Hkz9dxs5qWDGypRrRTMPhFx
         0CTLLZoc6DMGabj0oZeWE4cmUc/QXcjkfk2PlvbX8wRc4DBlT/9PPmoM67JRlE+siPWR
         FsxuWd4iS8+NafAx+6JO3JqkWKlXTuEYdVC711C8jC0kOF9DrKLO3wNJEvNBcwDxMXq3
         ZEewkpNgJM1qy1hjtXqMrGz5SBOkzhox43qMDPx9OzfJe5WNII/stDsVi/aM2aGIMKpG
         GAng==
X-Gm-Message-State: AJIora+Euo0PQwSKtlZoVxH9AuEHOwrAlJ25fZII0JcTZrgpNIKhNb33
	2agHE+QbNDwgF3qeeKnbV5DFZHUm+LA=
X-Google-Smtp-Source: AGRyM1tozcRUqdrbXpFU/r7YGBjc4J2e57s7dauOM5DHRRfP1HGFu/VUjqGQ9WiFho1Rc/H04B+lFA==
X-Received: by 2002:a17:902:848b:b0:16d:4c6b:bf00 with SMTP id c11-20020a170902848b00b0016d4c6bbf00mr17168178plo.58.1658855371115;
        Tue, 26 Jul 2022 10:09:31 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/10] wiphy: add disabled_freqs list
Date: Tue, 26 Jul 2022 10:09:18 -0700
Message-Id: <20220726170920.15929-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a frequency is disabled, it should not be added to the supported list which
it previously was. In this case its added to the (new) disabled_freqs list.
---
 src/wiphy.c | 26 +++++++++++++++++++++++---
 src/wiphy.h |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 98bd3aa4..5329e8e4 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -104,6 +104,7 @@ struct wiphy {
 	uint16_t supported_iftypes;
 	uint16_t supported_ciphers;
 	struct scan_freq_set *supported_freqs;
+	struct scan_freq_set *disabled_freqs;
 	struct band *band_2g;
 	struct band *band_5g;
 	struct band *band_6g;
@@ -316,6 +317,7 @@ static struct wiphy *wiphy_new(uint32_t id)
 
 	wiphy->id = id;
 	wiphy->supported_freqs = scan_freq_set_new();
+	wiphy->disabled_freqs = scan_freq_set_new();
 	watchlist_init(&wiphy->state_watches, NULL);
 	wiphy->extended_capabilities[0] = IE_TYPE_EXTENDED_CAPABILITIES;
 	wiphy->extended_capabilities[1] = EXT_CAP_LEN;
@@ -357,6 +359,7 @@ static void wiphy_free(void *data)
 	}
 
 	scan_freq_set_free(wiphy->supported_freqs);
+	scan_freq_set_free(wiphy->disabled_freqs);
 	watchlist_destroy(&wiphy->state_watches);
 	l_free(wiphy->model_str);
 	l_free(wiphy->vendor_str);
@@ -454,6 +457,11 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 	return wiphy->supported_freqs;
 }
 
+const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy)
+{
+	return wiphy->disabled_freqs;
+}
+
 bool wiphy_can_transition_disable(struct wiphy *wiphy)
 {
 	/*
@@ -1188,19 +1196,31 @@ static void parse_supported_frequencies(struct wiphy *wiphy,
 	struct l_genl_attr attr;
 
 	while (l_genl_attr_next(freqs, NULL, NULL, NULL)) {
+		uint32_t freq = 0;
+		bool disabled = false;
+
 		if (!l_genl_attr_recurse(freqs, &attr))
 			continue;
 
 		while (l_genl_attr_next(&attr, &type, &len, &data)) {
-			uint32_t u32;
 
 			switch (type) {
 			case NL80211_FREQUENCY_ATTR_FREQ:
-				u32 = *((uint32_t *) data);
-				scan_freq_set_add(wiphy->supported_freqs, u32);
+				freq = *((uint32_t *) data);
+				break;
+			case NL80211_FREQUENCY_ATTR_DISABLED:
+				disabled = true;
 				break;
 			}
 		}
+
+		if (!freq)
+			continue;
+
+		scan_freq_set_add(wiphy->supported_freqs, freq);
+
+		if (disabled)
+			scan_freq_set_add(wiphy->disabled_freqs, freq);
 	}
 }
 
diff --git a/src/wiphy.h b/src/wiphy.h
index acc64193..9a3b96f9 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -93,6 +93,7 @@ const char *wiphy_get_path(struct wiphy *wiphy);
 uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
+const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
 bool wiphy_can_offload(struct wiphy *wiphy);
 bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy);
-- 
2.34.3

