Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0263D2
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 18:23:52 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id d3so5719219plr.10
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFdDBkNcJ7FMvuxzZpwR36JLJ6QHLaWElsNYLEHpDg4=;
        b=g21smc7hCVsbqwB9DppwsfrofSGx4Lg6rO+9Vay9qfcsNkQNigmkFX9KuNHnoyWRhT
         XddWRnhnucTbMxqjUvtBGe+ZBsnHRKNjWWXkguH4UbHkrb3qANplkryH1m4ZT2wdf6u7
         ZxhlE7IUs1blaQql4E1FwcUssgwqSxigMUqaKtwwMehmr+kfWjUlSNf1UVCA/dtqvdz2
         M89TEv8wIpiyKQCXNUQlpLHIUkyoz8x13sgz/gkYoDlX4dyqRVMFTcQ3VQx4zm23nuai
         fEGlqG9Ed03AaOf44xBSnrxgGRcrTvquBtRLcCV49rXnE+n/IHmikwOH4VBhewiHKP9Z
         ++Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFdDBkNcJ7FMvuxzZpwR36JLJ6QHLaWElsNYLEHpDg4=;
        b=wo5QYTeQ1F3NUze/Krgr27lQloNkScpCbrKbnrmtg99yibJpcfHHF9Y/fLPSVuCTc1
         5Mj+zqVfhq1S7tOEALgon42QtjvimVI5OJrkSkp16iXTHI9Ygs7iKWu21wJrAyhVoIWT
         3pobh4o7FMnBN+ixU6hHzXmRmhoOgKf5IdssKmGnn90/bhXVrISoV2Pfw5RVckQ8co/Q
         nICwTXnXt1Y6tvJXxFdW8MRbAynpqB2TZrHJaypbvQto+tKHRNoUXDcz+aN9a+ZgvEs6
         aQkj+A+kxEYYDcH5kkMzNSTcA9MrKlo4Csty+bQ9v6hz73jdsfpZ6sPchBeDfs2k4NH4
         orFw==
X-Gm-Message-State: ANoB5pmWuiOJqzfSHiwWR6zgigCqmY0yf44YzQbNsnnuk+ZgAEAEIm00
	K6+hPvjtdlnNwot9zNt8pKskYw2AzI0=
X-Google-Smtp-Source: AA0mqf44PnXExEJDfm3LasT79A7NewTos2XgVTzBqANhq4VImRN46HXMvsXUVWfgX4hk19gNW7EFKQ==
X-Received: by 2002:a17:903:2349:b0:189:9311:d1fc with SMTP id c9-20020a170903234900b001899311d1fcmr7976179plh.9.1670610231972;
        Fri, 09 Dec 2022 10:23:51 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b001897de9bae3sm1635790plb.204.2022.12.09.10.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 10:23:51 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] wiphy: use enum band_freq with rates getter
Date: Fri,  9 Dec 2022 10:23:44 -0800
Message-Id: <20221209182347.838602-1-prestwoj@gmail.com>
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

