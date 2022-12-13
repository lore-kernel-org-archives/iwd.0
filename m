Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484079F2
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:36:35 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id jn7so1044734plb.13
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTK4CnFF1tJOjUo4j3UDYWjurXfIsH8HMOlpTtb+EtQ=;
        b=dCemuh3KT+tcI2w4p44z87QoPVWa+mRCRtsOgODZGCbpXCa/StzA4SoNfxlAf5Ak1+
         qe1Btq9bodz5cwC1gT3d8YqmwqllGG3w5ACArgmSWfVT91VWF485Uw9Ha/7WhwaXKO5b
         YV1dCNDnBkvk/uBlffkZNlviZhcpanPLu+Xu0i9yuuIV7yf7VXqbR26FvMWVs7V2dfe9
         295vjl4h3oyarQ7sacC2tBw1kvVWuxTGCA3hzA5N5GO0TnJxF6OS78mql67Fqey4TOy+
         bbJlJRGzT8BTxt2pQCcnB+9cXdb3lol1yisMYqcC6UEt5BCyBhNWvjRM3NP8MSjDd/Nn
         69uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTK4CnFF1tJOjUo4j3UDYWjurXfIsH8HMOlpTtb+EtQ=;
        b=c/j5KQU9aq1IBcoX1DGkZOiBuwpYQXMDyjg8+sX+Qh9b5zAU9VUcfG0GurHdwSc8L/
         SMVrjjMYTpJ3HAVjEmpeqUM3ChJSIx/D417BkW4vS4K5hh+cibcY61/u7He36bp/Ezzd
         Yj0lz+M56hrWikrXjhEpLIPnAYlFKD/gYA+UzVDKHHZyInDIuO11hSf8JWkficBqnV4V
         SjC8MUPGRvRK90VxSiVMD05GnF+9Fqrz4YF9/EczfYUUIFYNJDF4LWPQ/Um8f9h1boyu
         /GuC5OIK63sfIFWAtlFIN6JmX2wwDt4i09n44D0Fr1OKOZC/fcUubnkkyI8+rbIXFdu6
         /uJA==
X-Gm-Message-State: ANoB5pl7e3XpRH4VeiNa5yWLgO3p19UsOSl+EEFn9crrCsHIRmAPEXjq
	J8xTRPEjtaVqZnrZnSiD2SO5mfvz/gc=
X-Google-Smtp-Source: AA0mqf5oWkAQ5KKjQB/lXwDxtF1FjAVgZeQNqATkRx3jT6HdAixFB1oWBzzucOGNj2h8VE659jh26A==
X-Received: by 2002:a17:902:ab92:b0:189:6076:ab95 with SMTP id f18-20020a170902ab9200b001896076ab95mr20585882plr.18.1670963794612;
        Tue, 13 Dec 2022 12:36:34 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b00189f69c1aa0sm272113plo.270.2022.12.13.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:36:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] ap: use wiphy_check_{frequency,band}
Date: Tue, 13 Dec 2022 12:36:23 -0800
Message-Id: <20221213203624.1423277-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221213203624.1423277-1-prestwoj@gmail.com>
References: <20221213203624.1423277-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace disabled/supported frequency list with the new
wiphy_check_* equivalent APIs.
---
 src/ap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 32d9e1c4..ed20d763 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3174,8 +3174,6 @@ static char **ap_ciphers_to_strv(uint16_t ciphers)
 static bool ap_validate_band_channel(struct ap_state *ap)
 {
 	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
-	const struct scan_freq_set *supported;
-	const struct scan_freq_set *disabled;
 	uint32_t freq;
 
 	if (!(wiphy_get_supported_bands(wiphy) & ap->band)) {
@@ -3191,15 +3189,12 @@ static bool ap_validate_band_channel(struct ap_state *ap)
 		return false;
 	}
 
-	supported = wiphy_get_supported_freqs(wiphy);
-	disabled = wiphy_get_disabled_freqs(wiphy);
-
-	if (!scan_freq_set_contains(supported, freq)) {
+	if (!wiphy_check_frequency(wiphy, freq, BAND_FREQ_ATTR_SUPPORTED)) {
 		l_error("AP hardware does not support frequency %u", freq);
 		return false;
 	}
 
-	if (scan_freq_set_contains(disabled, freq)) {
+	if (wiphy_check_frequency(wiphy, freq, BAND_FREQ_ATTR_DISABLED)) {
 		l_error("AP hardware has frequency %u disabled", freq);
 		return false;
 	}
-- 
2.34.3

