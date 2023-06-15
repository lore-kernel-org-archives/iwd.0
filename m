Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4019374
	for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 19:24:24 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so7747450f8f.1
        for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857062; x=1689449062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84doOLHYP9Wo8DpVqIzQZkQaC3mDx/ZwVQyuzJc8ZKk=;
        b=MSuyAy0DCiOwNB4HCmt0Ctkk+wWH5cTsKKyTx5BiSefeGgbCVgxIRkY2ww+FWrRFwE
         Y15yLhBpm9+7AvtC2DraNMIObQKiwwcvnW0ntkp+ND9Lv2uxg9ibalA97xZ6Y4VHanmT
         xI6o+B/Pt5StMYKgz4L9/Y/eEldOpOt3Vqigd8E0ZWdn/ukCZqXiK5zDpcIDfckvTByg
         ptzzhAqBrN65VbJW1LFvnjZRNRJExtRfdsBa/XUJzBh2P1uhpMJU3qc5+rJX7eqrf9J5
         idlb6SXOpFsEqdcooirygBj8QedhsjvPaG0amaE+tBVYgM+jXHqcp1tZqJZRbO0BfJWQ
         x78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857062; x=1689449062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84doOLHYP9Wo8DpVqIzQZkQaC3mDx/ZwVQyuzJc8ZKk=;
        b=WnJtszWojrkAmt4piUsqGv9dn+qTsw+YJrxuimV0n6kf+PilqOjkTe++8JGjpy5Ul1
         F5Yc3O7bMJRCxyHfebchE+ohVGUS1TzyQyA52vqtaJUBwwkv3skf7DmGq2wzx9csV/kU
         kZSFPaUU82xp5oGdHAQTJ1y3nPbxrO+vycaF9KHOzyMA/bi8C/UCvPD63fAGSBpaWWpD
         UqHlLBb14EkYtoKUWSq132bA+G7/BR6OffChTVV2gqHHWbN8tmz8HD+m1rAmdxFZoTwP
         IPOZlownLLJ+mRucuMr2Ci99DIGAn4wBcPoPx/3C78Zcm6xE1Cnn3iWn/SWz1X1EyKqe
         caEg==
X-Gm-Message-State: AC+VfDxH2+KtN9Hq6s1QPIq5xdVTCQrGdKmv9VXCnuPnDmF/1mJb8YvP
	+undv4omDOPZngtQYB2pu+qibXV4tOpfiw==
X-Google-Smtp-Source: ACHHUZ6XYEPDnvMsm6ngE1tP+umU986ssMALONs+Rab65yvtwr58LsTj6qm60Mwok0UuCR7FUuMBLg==
X-Received: by 2002:a5d:5254:0:b0:309:3bb5:7968 with SMTP id k20-20020a5d5254000000b003093bb57968mr12273024wrc.16.1686857062134;
        Thu, 15 Jun 2023 12:24:22 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003f6028a4c85sm28241wmi.16.2023.06.15.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:24:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] wiphy: store driver flags directly in wiphy object
Date: Thu, 15 Jun 2023 12:24:09 -0700
Message-Id: <20230615192415.1718516-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than keep a pointer to the driver_info entry copy the flags
into the wiphy object. This preps for supporting driver flags via
a configuration file, specifically allowing for entries that are a
subset of others. For example:

{ "rtl88*",          DEFAULT_IF },
{ "rtl88x2bu",       FORCE_PAE },

Before it was not possible to add entires like this since only the
last entry match would get set. Now DEFAULT_IF would get set to all
matches, and FORCE_PAE to only rtl88x2bu. This isn't especially
important for the static list since it could be modified to work
correctly, but will be needed when parsing flags from a
configuration file that may contain duplicates or subsets of the
static list.
---
 src/wiphy.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index d06b2447..ca8a4958 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -111,7 +111,7 @@ struct wiphy {
 	char *model_str;
 	char *vendor_str;
 	char *driver_str;
-	const struct driver_info *driver_info;
+	uint32_t driver_flags;
 	struct watchlist state_watches;
 	uint8_t extended_capabilities[EXT_CAP_LEN + 2]; /* max bitmap size + IE header */
 	uint8_t *iftype_extended_capabilities[NUM_NL80211_IFTYPES];
@@ -685,8 +685,7 @@ bool wiphy_uses_default_if(struct wiphy *wiphy)
 	if (!wiphy_get_driver(wiphy))
 		return true;
 
-	if (wiphy->driver_info &&
-			wiphy->driver_info->flags & DEFAULT_IF)
+	if (wiphy->driver_flags & DEFAULT_IF)
 		return true;
 
 	return false;
@@ -697,8 +696,7 @@ bool wiphy_control_port_enabled(struct wiphy *wiphy)
 	const struct l_settings *settings = iwd_get_config();
 	bool enabled;
 
-	if (wiphy->driver_info &&
-			wiphy->driver_info->flags & FORCE_PAE) {
+	if (wiphy->driver_flags & FORCE_PAE) {
 		l_info("Not using Control Port due to driver quirks: %s",
 				wiphy_get_driver(wiphy));
 		return false;
@@ -1885,7 +1883,7 @@ static bool wiphy_get_driver_name(struct wiphy *wiphy)
 
 	for (i = 0; i < L_ARRAY_SIZE(driver_infos); i++)
 		if (!fnmatch(driver_infos[i].prefix, wiphy->driver_str, 0))
-			wiphy->driver_info = &driver_infos[i];
+			wiphy->driver_flags |= driver_infos[i].flags;
 
 	return true;
 }
-- 
2.25.1

