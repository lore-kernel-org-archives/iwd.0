Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69C8BE4
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 21:27:50 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so7352274pjs.4
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60sk+vLRmwuqdeOu/v6s9kr3MLw6uSc9YqTFiCxIBcs=;
        b=dDTLHSqREL4Jr9PkUh7OPF5Qzg1aieOK8aCZPO8CAnY6Vg20uTbuRZ3oSxRbNQd4zm
         xfZ3YCdSas1/BhM/8CHuS7FCD8t8M5OhvJlaaWit72W6lOSNIjBY56siEC6O3xhXOY95
         Tww7UmZJINJT0ccJs8cc03I2NdSoYTu3ERGEqlRQXfrOHaiF4s5j4KbAdxNTj0sXn5Zt
         bW3/d/qrw/k0u1UrkbAcNT1GYLEG6hkXIGjYvHTNFJSWWmskecpfiU2u6p4AyQvLiK/u
         3vECYYgjOySG8P7peAvsyDOaRFQeH9iJ/TwByOQWbZhbbCNqH6rFIz43brJOfBltR+A4
         o8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60sk+vLRmwuqdeOu/v6s9kr3MLw6uSc9YqTFiCxIBcs=;
        b=4C5X5KOcSSEYN0dgF6+7+ABur1teaWDI5B6FNjyyuIzi6FeDgb5plxCCYIROqaDBaU
         JXPnMUovtG+EJnB0FhDIilDzNfVzTtD3DzB4QoqWp6eWYQRBfIGQvLGbYwhiCgJYuwp8
         p91Baa5kqYNJ4zGhuRcXhZUpNFgVBOnCLl+gpbzfLnbx/vk4KvtjBUz4aJE0uCGBTy6u
         271fT6BsUXcrN5ZaTphSVxCb7PU6Lo4UA2czaOM9sTmwi6c5kSHw7qFV+5eWuixzpN5r
         Zm6tn5x3HJHSUIt0nv2snno1/1pd91g4ucoPvGqXykYGnJwMZOeedtZxdsvfx2BJLn65
         IZ/Q==
X-Gm-Message-State: ANoB5pnllckPg6zggVjTYqRVNgkN5ZvBa5EwQ06358XsQf/lINNwql90
	TQClKp30X40/bQkr/OR67sclUfNEoGY=
X-Google-Smtp-Source: AA0mqf4AauM4rgYRnrO0b5DNHoL5nmVtPbq2Y0AyHjK12WzMXbSiixRw85zs3eQUPS7fB0RSj7O0Pw==
X-Received: by 2002:a17:90a:db04:b0:219:b936:6bd7 with SMTP id g4-20020a17090adb0400b00219b9366bd7mr34651051pjv.19.1671226069739;
        Fri, 16 Dec 2022 13:27:49 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b004785e505bcdsm1905404pgz.51.2022.12.16.13.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:27:49 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 6/8] station: use wiphy_get_frequency_info
Date: Fri, 16 Dec 2022 13:27:39 -0800
Message-Id: <20221216212741.1833286-6-prestwoj@gmail.com>
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

Remove uses of supported/disabled scan_freq_set's and replace
with the equivalent calls to wiphy_get_frequency_info() and
wiphy_band_is_disabled().
---
 src/station.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9a646934..bad067c8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1407,8 +1407,6 @@ static int station_quick_scan_trigger(struct station *station)
 {
 	_auto_(scan_freq_set_free) struct scan_freq_set *known_freq_set = NULL;
 	bool known_6ghz;
-	const struct scan_freq_set *disabled = wiphy_get_disabled_freqs(
-								station->wiphy);
 
 	if (wiphy_regdom_is_updating(station->wiphy)) {
 		l_debug("regdom is updating, delaying quick scan");
@@ -1430,9 +1428,11 @@ static int station_quick_scan_trigger(struct station *station)
 	 * this since its so limited, so return an error which will fall back to
 	 * full autoconnect.
 	 */
-	if ((scan_freq_set_get_bands(disabled) & BAND_FREQ_6_GHZ) &&
-				wiphy_country_is_unknown(station->wiphy) &&
-				known_6ghz)
+	if (wiphy_get_supported_bands(station->wiphy) & BAND_FREQ_6_GHZ &&
+			wiphy_band_is_disabled(station->wiphy,
+						BAND_FREQ_6_GHZ) &&
+			wiphy_country_is_unknown(station->wiphy) &&
+			known_6ghz)
 		return -ENOTSUP;
 
 	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
@@ -1812,10 +1812,6 @@ static void parse_neighbor_report(struct station *station,
 	struct scan_freq_set *freq_set_md, *freq_set_no_md;
 	uint32_t current_freq = 0;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
-	const struct scan_freq_set *supported =
-				wiphy_get_supported_freqs(station->wiphy);
-	const struct scan_freq_set *disabled =
-				wiphy_get_disabled_freqs(station->wiphy);
 
 	freq_set_md = scan_freq_set_new();
 	freq_set_no_md = scan_freq_set_new();
@@ -1828,6 +1824,7 @@ static void parse_neighbor_report(struct station *station,
 		uint32_t freq;
 		enum band_freq band;
 		const uint8_t *cc = NULL;
+		const struct band_freq_attrs *attr;
 
 		if (ie_tlv_iter_get_tag(&iter) != IE_TYPE_NEIGHBOR_REPORT)
 			continue;
@@ -1853,8 +1850,8 @@ static void parse_neighbor_report(struct station *station,
 			continue;
 
 		/* Skip if frequency is not supported or disabled */
-		if (!scan_freq_set_contains(supported, freq) ||
-				scan_freq_set_contains(disabled, freq))
+		attr = wiphy_get_frequency_info(station->wiphy, freq);
+		if (!attr || attr->disabled)
 			continue;
 
 		if (!memcmp(info.addr,
-- 
2.34.3

