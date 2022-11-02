Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F227706
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:39 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id l2so17709578pld.13
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxqprtzl4R002vqUzev019k/BsECRjvS5t95ymRTLR0=;
        b=JD72aaQkvkTqaK30aqGkzOI417utjW4KmBkiCG/j6kNctt1HKIE7uOwA74BPll7dOl
         eiXgvK70RORmp40gq0bXTHL/aYtgMgbdk2265JBlItN4eyiaKaQooDHAw3EdW3OxBOWo
         /VEbSORPNOPjZMFOTvu8yWoR/OKflAnQcTIRDdfoppPb9gXRPk1i981Njt1YrzICtGlY
         akt90Gc7mbDZzRiqoYvEdFCb/Piol/Qa0Q57Uhd0t3E5S/O0j9d9luAOBiShSpnh9x36
         8K1n92BIUnt0fsT9LFU+RLiT5+PqPC0CWQVaLpvqKV0zkDRHFnJxZpkc/Ak4Kb4oFnIN
         yN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxqprtzl4R002vqUzev019k/BsECRjvS5t95ymRTLR0=;
        b=kOzg24mYHL1BY8dXjp8l2dLMQAwa7n7FkcMvtxhZe/fhW28mNzhylcUjXKtX+lFau/
         u09Y5WNgOwMBd6nblL5aUjFyd1wqkftcWi6e0yEGka9PAv/+ne7xTr6YqKBUUTOyQKMj
         f50oK+0mH91SqX4dwSsdfStGNWbSiqY3M9HxYCHCDdIFBMpRP2COBwNGuH5al4eze2kz
         eosHzcDcdHf+e3KVRcd0Qx9dNC5ZQPWrLkdKhGSUjdOgZOBplBjlsMTY1EXOUWs6/Wjd
         i5kwLL/vYV9JsyrHRmmDNPF6LqVfY8pPxzmwi3iXoNMXDJEuTRYWQPVf6OFguzHxjbYv
         /LdA==
X-Gm-Message-State: ACrzQf1fZhFuGdSJWwRdQi6+BkiNdHzYN8IVUcuaR1Bo8lUQh8DFUl4M
	Q38s0YBeO/gG6ToP+krtrYm0iCpW558=
X-Google-Smtp-Source: AMsMyM6iun2XvDF66uXfaYtYSgUNDzT+6ktu+z0hN45kDg8qCoC50It9CgY/HXVVa5HuOto4a9OMyQ==
X-Received: by 2002:a17:902:6bc5:b0:183:4bef:1b20 with SMTP id m5-20020a1709026bc500b001834bef1b20mr26219793plt.158.1667422418496;
        Wed, 02 Nov 2022 13:53:38 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 03/10] ap: add profile settings PairwiseCiphers/GroupCipher
Date: Wed,  2 Nov 2022 13:53:20 -0700
Message-Id: <20221102205327.268693-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
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
index ba827728..341a1662 100644
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

