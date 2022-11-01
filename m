Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203F1EA11
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:17:56 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id b62so4008963pgc.0
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTzcns9s964zfXLhnNW1ut1TqxoVeZtTMpQTveIVTU8=;
        b=BqeciXp2EBK7ktkLscmIW7Dvtn1MYwaZwALT6bQb35TePYkdbPYTxLeZR5DDamUVqd
         fglw+k/L1217VqVZAzLN/mVJiY4HUft4OST3k9dAyh9B9tCt4VyB3L54VeWOB9gUstBM
         KJObG80QeOVZWLGOB7JNMUMAL7V/ll5x8n/UiIDiZgi5ZoTPa251OKMNriuo0sH+wsmB
         PmOgy/wfHgb8zR4Pxw4c8NX8KsmyJZZjH57rr6rKrWfEHIRUiF9RkcXUS+/E80aXzDBX
         wKCWdLhi+qQ2FVDnLD071HirTRiAp3x54cDvpphvAEGfYmd96cfsQTtP2fLNuGvoZTnO
         OHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTzcns9s964zfXLhnNW1ut1TqxoVeZtTMpQTveIVTU8=;
        b=zzYARRPD0b4mko0RHWLM5eWYacZU+EFnlFAwtHMIbmF3TXdmyH9wj0JeyOu2Q5DHHL
         H1mNX57Ec4Dphl82FgO6bDtmuZo2DW8OHlLWJGM33zqagt9h3ZMPtcnwcKA8K626NwlK
         MLCPcMDRUGhTjKchX/LFaUza120FMpzZu3/bm2AEqa0lnmhQht5xg1NfivmweBdcrLQ9
         +JrIlnYMjMaUBFobXHKULIMCoLYJtO8MzFur2+YoLCzI5LgalaQnPs3c1PPdP+pbo+Tg
         M2Izmzz8LWiT18zx1rtTAmLn60IrKJgAHPAzzgUaqBbJkBxnptFkxloPUXeiyRUF4AT/
         CDMg==
X-Gm-Message-State: ACrzQf34e7z30ZJI5w9yLUHSrjD9v7Cyy87GpGB3L3qmg6lFuQWZY6EP
	VPqo5qUKg8NEgqw38SfA3kmotRuATfk=
X-Google-Smtp-Source: AMsMyM4QphRfd5FKhQTrSgqcaTzxUy8uH95yMxzxCq/LbNQNJPcMnA8mTYzd1TjpkpAcRZw+Jl757g==
X-Received: by 2002:a05:6a00:993:b0:56c:80f6:db5 with SMTP id u19-20020a056a00099300b0056c80f60db5mr21281446pfg.45.1667333875859;
        Tue, 01 Nov 2022 13:17:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/17] ap: add profile settings PairwiseCiphers/GroupCipher
Date: Tue,  1 Nov 2022 13:17:33 -0700
Message-Id: <20221101201747.143379-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
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
 src/ap.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 2939a9c1..834fa089 100644
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
+	_auto_(l_strv_free) char **ciphers_str;
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
@@ -3260,6 +3288,47 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 	} else
 		*out_cck_rates = true;
 
+	cipher_mask = wiphy_get_supported_ciphers(wiphy, IE_PAIRWISE_CIPHERS);
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
+			l_error("Unsupported or unknown cipher %s",
+					ciphers_str[i]);
+			return -ENOTSUP;
+		}
+
+		ap->ciphers |= cipher;
+	}
+
+	/* No list provided, just set to all supported ciphers */
+	if (!ap->ciphers)
+		ap->ciphers = cipher_mask;
+
+	cipher_mask = wiphy_get_supported_ciphers(wiphy, IE_GROUP_CIPHERS);
+
+	strval = l_settings_get_string(config, "Security", "GroupCipher");
+	if (strval) {
+		enum ie_rsn_cipher_suite cipher = ap_string_to_cipher(strval);
+
+		if (!cipher || !(cipher & cipher_mask)) {
+			l_error("Unsupported or unknown cipher %s", strval);
+			return -ENOTSUP;
+		}
+
+		ap->group_cipher = cipher;
+
+		l_free(l_steal_ptr(strval));
+	} else
+		ap->group_cipher = wiphy_select_cipher(wiphy, cipher_mask);
+
 	return 0;
 }
 
@@ -3302,12 +3371,6 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 
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

