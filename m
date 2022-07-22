Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED44A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 16:37:15 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso1254523pjr.2
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKhcnbNdSwvhA7rR0O08Kw3sCNSNtux7PL2RgOPbCKM=;
        b=OZeYF6CnQWXe8b15xAXRNVSKqAYnzsttgLd27b99fhMxQ1l8oehoobVtBUE7ouHsht
         30Cmc5gGa3k0HCKwivJyTHyACiTTaiTCCYn9ceR4Md2bF+0WhzzXuN0SKB8RPoImjcGB
         Hjx3MZuQa5LcZoPfgFjItcaANrEmomFsPmzm5o5XrSX/9/0tWWgpxQwEMUYI4mKF9d6j
         JDYXz9mDGYFpR2eaYGuVlFPKR/KWVhCiHmPWzsrTOEgoLEem3AnuuOPDd5hPwlbc+mpV
         eUqx1MvpRPHIm/fQccVexvL/YnaxGrEhXZ3k2c64cMqxrdBslE/nzF3zmXnXsA9WlrGs
         +bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKhcnbNdSwvhA7rR0O08Kw3sCNSNtux7PL2RgOPbCKM=;
        b=dm6aT078lGdF+WuwZIW16sjErK5sTMXMKsZ8Q3r8BwML89UDjm7RhS3xhwFJZpdVE7
         IROyU0dQbh1C0QMzCLM2FPUXFGUZcjIdli6wHczvPZRBCpRSM762n9LZcTQ8W11wHewu
         1775l7bR0pEaWt7Fka649ItAkAU0ldfj8FIFo7FxH+uY46gtis6QT9OCk7084DKPsKTC
         OPGpy65N81skS6G+uyNtwORtRypqZ0o731Cg8mqdw6pegUscEA9L2n81sJAQ8VxYRrBV
         tQ0XXARF6LI/cVZwewMRzd+W+iGh1BocgOiHDXKBJ8YaqDNWYZVUFV9uIBbvD/GNZc8x
         wxtg==
X-Gm-Message-State: AJIora9V1bK6+lMLhnwzw0sMY27hbdtZ9GyQ2smaDLnyI1DLxQ+cVzTe
	Eg1DsRxnIQX2txhZI8mGwFApn7UCP60=
X-Google-Smtp-Source: AGRyM1vOUJY0qUmuxCCfxp8xpvJ1ZcGYaBGDXlsLkZb/vcIfK0x946QmHTimmtPzgONm1BEdMa8cgQ==
X-Received: by 2002:a17:902:cf06:b0:16b:cc33:5bce with SMTP id i6-20020a170902cf0600b0016bcc335bcemr689713plg.152.1658507834555;
        Fri, 22 Jul 2022 09:37:14 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0016a109c7606sm4013887plf.259.2022.07.22.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:37:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] wiphy: track disabled frequencies on multiple dumps
Date: Fri, 22 Jul 2022 09:34:16 -0700
Message-Id: <20220722163417.1119334-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722163417.1119334-1-prestwoj@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a frequency is disabled, it should not be added to the supported list which
it previously was. In this case its added to the (new) disabled_freqs list.

Now that wiphy's are dumped on regulatory changes frequencies may be added or
removed from either the supported or disabled frequency list. These changes
are now tracked to keep the lists accurate.
---
 src/wiphy.c | 35 ++++++++++++++++++++++++++++++++---
 src/wiphy.h |  1 +
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 4b9e130a..7d123e0c 100644
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
@@ -1208,19 +1216,40 @@ static void parse_supported_frequencies(struct wiphy *wiphy,
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
+		/*
+		 * Wiphy is dumped again on every regulatory domain change which
+		 * may contain disabled frequencies which were previously
+		 * allowed. If disabled, remove from supported. If supported,
+		 * remove from disabled.
+		 */
+		if (disabled) {
+			scan_freq_set_add(wiphy->disabled_freqs, freq);
+			scan_freq_set_remove(wiphy->supported_freqs, freq);
+		} else {
+			scan_freq_set_add(wiphy->supported_freqs, freq);
+			scan_freq_set_remove(wiphy->disabled_freqs, freq);
+		}
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
2.34.1

