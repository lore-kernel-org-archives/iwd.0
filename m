Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693E2C9C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:37 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id 130so26427pfu.8
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uN6+aYGj6k7V4g/DCgsKy3i7CqFuahfEM74X3Yf0Sc=;
        b=I0PBjgY0BfGjIfIkWT8AWdWyxZDOaFA5vYyON6e5jAp7Ro1p1aL1+XRnYmd44zd/rF
         GlJE4jgWrx6a09OJdI6n6nlziEm3MrstXCKjVeWSWRSByYP8tL5fcoHhyzHxMDM/C9fd
         tcKN+zwAx+IJHSfdDIRVFFBI5dE03y8yk3YYGRP68zbtE1CRo38qcWXjJ62DZ3c7xOpf
         dnIEANeugTfghjarrjGTdPqSysp8aDGuvEEsx1GuIHstO2XLE2bSepMmvSN0uT1LkXfG
         Kpme2wJbsKuf+jOOzd4XNXmQGK+RJ4k1C812/n2VOxRXp9lzLULmjsKtlIXqRK72vVaJ
         VPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uN6+aYGj6k7V4g/DCgsKy3i7CqFuahfEM74X3Yf0Sc=;
        b=CYsdRk98KR8MEfQgdMgNbwFGWtHyAr1q8x1vA5Q1uZdlvomnTCmIe3CoKaME4cpELj
         aO7JG+rkvhoCn7jKG+7a/7U86QgIXsuKd+4MvMg8vn879yX9JgT1KZ1Y0KGVJUcg6K/T
         Z8hSCntEzjMMeDEXsckV+BscnZaE+nRMwnK410+aFLoiJnCmzF+xUreeNIiZQhpQEfEl
         +s2JzfgZAowkAb9jOd/OxzSi1HqDehpYsyMdskjkGh+4C549fHKsBj1bKidd/o1MN+m/
         1tsEvhrvr5sC2Xuhzm7tZawI7Fax/nX97J2H/b/+DTMHR2t7VjkWUO9Imrb/l8iR/lp7
         qjZg==
X-Gm-Message-State: ACrzQf3PylWn12uLWXY8S/bwrrDgudPM2TcjIFXWSpfbeikf35rCdRyP
	k9+Uv0yT6d8Ea+kFaXtzcvbGCLR4baE=
X-Google-Smtp-Source: AMsMyM4KmazMbLPnL503yQscq/XHMDy0lD/Ug5j3Fuc70e6bvcRd+UWNC2ufvLUjSV+AaZPrd/cLLQ==
X-Received: by 2002:a05:6a00:1822:b0:56b:f29d:cca1 with SMTP id y34-20020a056a00182200b0056bf29dcca1mr27724835pfa.65.1667429496504;
        Wed, 02 Nov 2022 15:51:36 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 03/11] ap: add profile settings PairwiseCiphers/GroupCipher
Date: Wed,  2 Nov 2022 15:51:08 -0700
Message-Id: <20221102225116.297129-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These can now be optionally provided in an AP profile and provide a
way to limit what ciphers can be chosen. This still is dependent on
what the hardware supports.
---
 src/ap.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index ba827728..44440191 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3132,12 +3132,38 @@ static bool ap_load_psk(struct ap_state *ap, const struct l_settings *config)
 	return true;
 }
 
+/*
+ * Note: only PTK/GTK ciphers are supported here since this is all these are
+ *       used for.
+ */
+static enum ie_rsn_cipher_suite ap_string_to_cipher(const char *str)
+{
+	if (!strcmp(str, "UseGroupCipher"))
+		return IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER;
+	else if (!strcmp(str, "TKIP"))
+		return IE_RSN_CIPHER_SUITE_TKIP;
+	else if (!strcmp(str, "CCMP-128") || !strcmp(str, "CCMP"))
+		return IE_RSN_CIPHER_SUITE_CCMP;
+	else if (!strcmp(str, "GCMP-128") || !strcmp(str, "GCMP"))
+		return IE_RSN_CIPHER_SUITE_GCMP;
+	else if (!strcmp(str, "GCMP-256"))
+		return IE_RSN_CIPHER_SUITE_GCMP_256;
+	else if (!strcmp(str, "CCMP-256"))
+		return IE_RSN_CIPHER_SUITE_CCMP_256;
+	else
+		return 0;
+}
+
 static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 				bool *out_cck_rates)
 {
+	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
 	size_t len;
 	L_AUTO_FREE_VAR(char *, strval) = NULL;
+	_auto_(l_strv_free) char **ciphers_str = NULL;
+	uint16_t cipher_mask;
 	int err;
+	int i;
 
 	strval = l_settings_get_string(config, "General", "SSID");
 	if (L_WARN_ON(!strval))
@@ -3212,6 +3238,8 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 			l_error("AP [WSC].PrimaryDeviceType format unknown");
 			return -EINVAL;
 		}
+
+		l_free(l_steal_ptr(strval));
 	} else {
 		/* Make ourselves a WFA standard PC by default */
 		ap->wsc_primary_device_type.category = 1;
@@ -3260,6 +3288,61 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 	} else
 		*out_cck_rates = true;
 
+	cipher_mask = wiphy_get_supported_ciphers(wiphy, IE_GROUP_CIPHERS);
+
+	/* If the config sets a group cipher use that directly */
+	strval = l_settings_get_string(config, "Security", "GroupCipher");
+	if (strval) {
+		enum ie_rsn_cipher_suite cipher = ap_string_to_cipher(strval);
+
+		if (!cipher || !(cipher & cipher_mask)) {
+			l_error("Unsupported or unknown group cipher %s",
+					strval);
+			return -ENOTSUP;
+		}
+
+		ap->group_cipher = cipher;
+		l_free(l_steal_ptr(strval));
+	} else {
+		/* No config override, use CCMP (or TKIP if not supported) */
+		if (cipher_mask & IE_RSN_CIPHER_SUITE_CCMP)
+			ap->group_cipher = IE_RSN_CIPHER_SUITE_CCMP;
+		else
+			ap->group_cipher = IE_RSN_CIPHER_SUITE_TKIP;
+	}
+
+	cipher_mask = wiphy_get_supported_ciphers(wiphy, IE_PAIRWISE_CIPHERS);
+
+	ciphers_str = l_settings_get_string_list(config, "Security",
+						"PairwiseCiphers", ',');
+	for (i = 0; ciphers_str && ciphers_str[i]; i++) {
+		enum ie_rsn_cipher_suite cipher =
+					ap_string_to_cipher(ciphers_str[i]);
+
+		/*
+		 * Constrain list to only values in both supported ciphers and
+		 * the cipher list provided.
+		 */
+		if (!cipher || !(cipher & cipher_mask)) {
+			l_error("Unsupported or unknown pairwise cipher %s",
+					ciphers_str[i]);
+			return -ENOTSUP;
+		}
+
+		ap->ciphers |= cipher;
+	}
+
+	if (!ap->ciphers) {
+		/*
+		 * Default behavior if no ciphers are specified, disable TKIP
+		 * for security if CCMP is available
+		 */
+		if (cipher_mask & IE_RSN_CIPHER_SUITE_CCMP)
+			cipher_mask &= ~IE_RSN_CIPHER_SUITE_TKIP;
+
+		ap->ciphers = cipher_mask;
+	}
+
 	return 0;
 }
 
@@ -3302,12 +3385,6 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 
 	err = -EINVAL;
 
-	/* TODO: Add all ciphers supported by wiphy */
-	ap->ciphers = wiphy_select_cipher(wiphy, IE_RSN_CIPHER_SUITE_TKIP |
-						IE_RSN_CIPHER_SUITE_CCMP);
-	ap->group_cipher = wiphy_select_cipher(wiphy,
-						IE_RSN_CIPHER_SUITE_TKIP |
-						IE_RSN_CIPHER_SUITE_CCMP);
 	ap->beacon_interval = 100;
 	ap->networks = l_queue_new();
 
-- 
2.34.3

