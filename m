Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D029AD
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 17:26:24 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so6741478pje.5
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hsmg+06NmeQovY9R3GIuEUIniH2y9nsyPGfA0hIb9k=;
        b=VS//l9BnhhTYbSZRKiwAGUew/UHCC2aHcfi/e6iGyMLa9+sDRxsQD7ywIQJ/BFrMDS
         CUbzMijfXFgjL1E49UfOF1bCz6rJRMKZMw/zsNnzC585Belk59koX1pw7pMcAHhURGy3
         uRh8URkusrsuPtCix7wE41IirONDOHxV+n0Gx4kNkfT48LyrdfbJLi7iaNAGicJrtwxC
         MNOO5CXAzNaWZeSUHt+ExvAlBXMgbA5WFGwqBHXB69qK1BO+9kArAfZkiasq/6smOs0s
         aNWIGBG4naXYuY+cFO5RHSlLM7sz59EgzuXtZC2W3b6qczliiPqhnbZYVmWwfS2A5OUI
         by0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hsmg+06NmeQovY9R3GIuEUIniH2y9nsyPGfA0hIb9k=;
        b=wmojqcKKTC65b5k1ZvacUSPfKi0a/k1Etbz6Y2FeoEZJSDyZfVpjzF/byWQF/3WImL
         IqHgB/fiD81G3/MbDQKNSrbaDqRAqrUgbXwBa3sEuER/i8DldcS8V2B1WAPQiAX//Mcy
         q1PQX6cNUr2Mtseu+WRzLSVOh91BIB+ctd4L5jAALXSPSLXYdLMBbyE3siGoIPpDRby4
         jlEBH1n+Ir8V+lOh1117oHku7xDsJ7hX8fS/tfhHxkuzNzbg1rGzFEDv+aZKgzUM9U8U
         8kpdDEv4XfgklHq/abZG6zE+ahY1UcLoS1axPmsq/HE/Z5segq5l90ImlvF7y4y+0Puu
         +gxw==
X-Gm-Message-State: ANoB5pmhfYeDg6lyIYMyGsi/f8j+1clQ4PL/Iq99ACbPPEFDs6b5sTy6
	Jvf9aMBmhWo269rPE0/Fkxui/Bjdp5g=
X-Google-Smtp-Source: AA0mqf4fk1fLRIAHXORtcZtdZ6/MKrzL3E5xSJsgrYFTbB9p3YsynmuTJBxs/qRkcU9xElE1TI1ChA==
X-Received: by 2002:a17:902:ce04:b0:189:323d:df17 with SMTP id k4-20020a170902ce0400b00189323ddf17mr37254798plg.67.1671211584110;
        Fri, 16 Dec 2022 09:26:24 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm1913636plx.44.2022.12.16.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:26:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 7/8] ap: use wiphy_get_frequency_info
Date: Fri, 16 Dec 2022 09:26:05 -0800
Message-Id: <20221216172606.1799396-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216172606.1799396-1-prestwoj@gmail.com>
References: <20221216172606.1799396-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace disabled/supported frequency list with the new
wiphy_get_frequency_info()
---
 src/ap.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 32d9e1c4..7ba1974f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3174,9 +3174,8 @@ static char **ap_ciphers_to_strv(uint16_t ciphers)
 static bool ap_validate_band_channel(struct ap_state *ap)
 {
 	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
-	const struct scan_freq_set *supported;
-	const struct scan_freq_set *disabled;
 	uint32_t freq;
+	struct band_freq_attrs attr;
 
 	if (!(wiphy_get_supported_bands(wiphy) & ap->band)) {
 		l_error("AP hardware does not support band");
@@ -3191,15 +3190,12 @@ static bool ap_validate_band_channel(struct ap_state *ap)
 		return false;
 	}
 
-	supported = wiphy_get_supported_freqs(wiphy);
-	disabled = wiphy_get_disabled_freqs(wiphy);
-
-	if (!scan_freq_set_contains(supported, freq)) {
+	if (!wiphy_get_frequency_info(wiphy, freq, &attr)) {
 		l_error("AP hardware does not support frequency %u", freq);
 		return false;
 	}
 
-	if (scan_freq_set_contains(disabled, freq)) {
+	if (attr.disabled) {
 		l_error("AP hardware has frequency %u disabled", freq);
 		return false;
 	}
-- 
2.34.3

