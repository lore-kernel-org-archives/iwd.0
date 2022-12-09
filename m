Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA466D24
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 19:39:34 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id g1so4427112pfk.2
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 11:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFdDBkNcJ7FMvuxzZpwR36JLJ6QHLaWElsNYLEHpDg4=;
        b=E8gLGwfUq1OHQmITCJqi3O9lwSf5wSTMWRn5toWhTesmuYzFYq0grnHZa49/W/VIyt
         /Ia8mzmofCxLKJRZlHZ91Htlirkrm+0PeZSDpT7e0alAal3qfKmHXjdykVo/g6r+WzAA
         VaELP7rqDeftSH/fIZzAnMi/THBdw7ewm4H30m9fxCIwe/xAghWGYZPLXZk/XnyNfG1e
         HAWI0ipRKwNfiwMknFTsbe6u9gk44fwV3KmpTM6Kpx8NJ5ndJsLRMxsiJAYbqzDVg+Fh
         Q9nKP66ZiLo/orr7hQDgFe8HKSZ7Fv5s+7QV2NdJmkP6saRuz9up4o6ZhiVFfpgYFWxE
         s0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFdDBkNcJ7FMvuxzZpwR36JLJ6QHLaWElsNYLEHpDg4=;
        b=p/Mebnzp0qcWe3XBLJ8KyC7erx4BnHFhiOowb4ar/s/TJfCDxh7kflLC1Yc/7+xC6Q
         vsQ6E5dt6e1AxCJVUfIIU3tbtvTkqH3n9iOOUfzj5ByIWdMZHo1Rn+jNkxEUrdGKLNFS
         d+pJv1WdY0UBVZbuboKquIjPY62Ls/TGwX5D+DUB1IZRacW+IbRTGZ8cE7wMfvtd70c5
         IBwsKMMfqMpn6+NXmhUpk+7vghKPTDMqRJbxgjUgmh+d8INFedwL93IzhVu6GHs1QwBT
         GBvTncCmTwpnZA6o8EQLLo3E7NS1sxmu5NYDiQT/ncg3tt9eKGsALis3zmG6+uDL18JB
         ai2Q==
X-Gm-Message-State: ANoB5plTvoTa5Irw99hj+lvP8KPerAS0C5RDE1MiaPPp8j9L63TVFMy8
	zFz9+wuJoT2Iu+T6Y+1TdKIwTy32NEs=
X-Google-Smtp-Source: AA0mqf7bbGhflaPloKfOQJQ2ViqojWPuC+z42YPLSnfd5LvbHcZdY11KEesOBFHeUPthA0qmqQImwQ==
X-Received: by 2002:a62:e21a:0:b0:576:d2cc:1ad2 with SMTP id a26-20020a62e21a000000b00576d2cc1ad2mr6928739pfi.6.1670614773467;
        Fri, 09 Dec 2022 11:39:33 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056bc5ad4862sm1587638pfr.28.2022.12.09.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:39:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] wiphy: use enum band_freq with rates getter
Date: Fri,  9 Dec 2022 11:39:27 -0800
Message-Id: <20221209193930.845238-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wiphy_get_supported_rates expected an enum defined in the nl80211
header but the argument type was an unsigned int, not exactly
intuitive to anyone using the API. Since the nl80211 enum value
was only used in a switch statement it could just as well be IWD's
internal enum band_freq.

This also allows modules which do not reference nl80211.h to use
wiphy_get_supported_rates().
---
 src/scan.c  | 2 +-
 src/wiphy.c | 9 +++++----
 src/wiphy.h | 4 +++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index ef222f66..5d2f2957 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -426,7 +426,7 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
 		 * rates we don't want to advertise support for 802.11b rates.
 		 */
 		if (L_WARN_ON(!(supported = wiphy_get_supported_rates(sc->wiphy,
-							NL80211_BAND_2GHZ,
+							BAND_FREQ_2_4_GHZ,
 							&num_supported))))
 			goto done;
 
diff --git a/src/wiphy.c b/src/wiphy.c
index 10514572..37e0cdb8 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -788,19 +788,20 @@ bool wiphy_supports_iftype(struct wiphy *wiphy, uint32_t iftype)
 	return wiphy->supported_iftypes & (1 << (iftype - 1));
 }
 
-const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy, unsigned int band,
+const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy,
+						enum band_freq band,
 						unsigned int *out_num)
 {
 	struct band *bandp;
 
 	switch (band) {
-	case NL80211_BAND_2GHZ:
+	case BAND_FREQ_2_4_GHZ:
 		bandp = wiphy->band_2g;
 		break;
-	case NL80211_BAND_5GHZ:
+	case BAND_FREQ_5_GHZ:
 		bandp = wiphy->band_5g;
 		break;
-	case NL80211_BAND_6GHZ:
+	case BAND_FREQ_6_GHZ:
 		bandp = wiphy->band_6g;
 		break;
 	default:
diff --git a/src/wiphy.h b/src/wiphy.h
index f8de7e0e..410105dd 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -29,6 +29,7 @@ struct scan_freq_set;
 struct wiphy_radio_work_item;
 struct ie_rsn_info;
 enum security;
+enum band_freq;
 
 typedef bool (*wiphy_radio_work_func_t)(struct wiphy_radio_work_item *item);
 typedef void (*wiphy_radio_work_destroy_func_t)(
@@ -112,7 +113,8 @@ uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy *wiphy);
 uint16_t wiphy_get_max_scan_ie_len(struct wiphy *wiphy);
 uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy);
 bool wiphy_supports_iftype(struct wiphy *wiphy, uint32_t iftype);
-const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy, unsigned int band,
+const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy,
+						enum band_freq band,
 						unsigned int *out_num);
 bool wiphy_supports_adhoc_rsn(struct wiphy *wiphy);
 bool wiphy_can_offchannel_tx(struct wiphy *wiphy);
-- 
2.34.3

