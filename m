Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C163D2
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 18:23:54 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id g10so5718692plo.11
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aquXlOQ3CwSHuYRsco0TqVmnv7BMfzk8TjLyZdgx50g=;
        b=RwOIU++uQJLfJKswnfeXpYlRcBLkfgSsgrOjahDy27He0rG/BBl37AWr/LGTpju6Ct
         LyovoMSFZQkhu+x6NWC0IEvuUlCSvIiA6pCeOudNifybZx6a+hV5OZobd77TPOdad8N8
         kI9AZZ1MnC2IReje/jMM6gzo8HgZvkrYB4c0WHOvEKxZpO33zDUPsbLNfeByb3cDBNtV
         jiTRiFaUBQKmiG6HGuMR02QrAdUmOUmx0OWTJ51JKyYhlNiL+1Qd6qHvC03BGFPfMLPo
         kPDCj1DKpspgdAPDo7xuCySWcQ4PfLWP6VZUkO8GrpH94dyx5XacG7X0ONJkK+27Cwd9
         DafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aquXlOQ3CwSHuYRsco0TqVmnv7BMfzk8TjLyZdgx50g=;
        b=s5GQnZDvvz9ecTJjTbLWzUGq/1sMu8tvSfWNsv60z5JLbFS9bQvBV7JZGzI7j2pzp0
         bEvhCgb/bh8jO4qBAnSjrs2/3mRu4X6bFAMlPnuVXbFfWMh77IeUnPTgi/EFe9qW4Qa+
         s9N1gdlNA30AOG7ZuSqN5fC/GPCdfwp+pp6na/3VeRL2mJAGfzYJp9cf3p0DE6Ata8yr
         vFvidyqDY9MQwkTp39vdgHaFCWEbBDOOtlej3o7Us98QW1N37I4ztReh5TEwPrq4WIb4
         guv0FtatY6KUNHl3HFAL8vnx73CuXGdRe1UavhmjIDGKiRrHlz6FXHIEF5S5BRDpYXNY
         1r6Q==
X-Gm-Message-State: ANoB5pmzBH448ZhFVwSzd4EHQEnZZzFRilt4Q0GIaWh9AuogHDjWY/VO
	dofxm8tl6wF8A0ZTEyxziewnNRGaJ+k=
X-Google-Smtp-Source: AA0mqf4+35kQcTraUPF28tVYrgku58ML+sQl3znpGvmQEhSusGVdw95yUFGvetW7dN8e80RCjModCw==
X-Received: by 2002:a17:902:dad1:b0:189:8513:f6f9 with SMTP id q17-20020a170902dad100b001898513f6f9mr8563477plx.18.1670610233892;
        Fri, 09 Dec 2022 10:23:53 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b001897de9bae3sm1635790plb.204.2022.12.09.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 10:23:53 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] ap: select rates from hardware capabilities
Date: Fri,  9 Dec 2022 10:23:46 -0800
Message-Id: <20221209182347.838602-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221209182347.838602-1-prestwoj@gmail.com>
References: <20221209182347.838602-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than a list of static rates, choose what the hardware
advertises. For the case of CCK rates only include rates 11mbps
or lower.
---
 src/ap.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 72951320..77fdc561 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3438,6 +3438,9 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 	uint64_t wdev_id = netdev_get_wdev_id(netdev);
 	int err;
 	bool cck_rates = true;
+	const uint8_t *rates;
+	unsigned int num_rates;
+	unsigned int i;
 
 	if (L_WARN_ON(!config)) {
 		if (err_out)
@@ -3463,22 +3466,17 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 
 	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
 
+	rates = wiphy_get_supported_rates(wiphy, ap->band, &num_rates);
+	if (!rates)
+		goto error;
+
 	ap->rates = l_uintset_new(200);
 
-	/* TODO: Pick from actual supported rates */
-	if (!cck_rates) {
-		l_uintset_put(ap->rates, 12); /* 6 Mbps*/
-		l_uintset_put(ap->rates, 18); /* 9 Mbps*/
-		l_uintset_put(ap->rates, 24); /* 12 Mbps*/
-		l_uintset_put(ap->rates, 36); /* 18 Mbps*/
-		l_uintset_put(ap->rates, 48); /* 24 Mbps*/
-		l_uintset_put(ap->rates, 72); /* 36 Mbps*/
-		l_uintset_put(ap->rates, 96); /* 48 Mbps*/
-		l_uintset_put(ap->rates, 108); /* 54 Mbps*/
-	} else {
-		l_uintset_put(ap->rates, 2); /* 1 Mbps*/
-		l_uintset_put(ap->rates, 11); /* 5.5 Mbps*/
-		l_uintset_put(ap->rates, 22); /* 11 Mbps*/
+	for (i = 0; i < num_rates; i++) {
+		if (cck_rates && rates[i] > 22)
+			continue;
+
+		l_uintset_put(ap->rates, rates[i]);
 	}
 
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
-- 
2.34.3

