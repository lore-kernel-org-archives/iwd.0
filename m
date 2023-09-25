Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576ED304
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 18:54:43 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59c04237bf2so91257157b3.0
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668082; x=1696272882; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDJU7SYD0amvWzwOGqGm/wTZR2ZpJVaE47M/yoVuMJk=;
        b=CDfdC9HiMtyVYjde7/GejwOv4u/m9/nAQkzNROx3Lz+xN+ZEhezzs4P1pXpd3XMi9c
         ZLE8s4b0p5hnT2/5gTGgoICE6uNqAD0wzC5ruYN7llHO6lQZ3na+P8Y3dCL5EsdMrS6R
         NwA4TNxGTX63AJJRx39HedcYfW5YnnuiKjisFc71N3iFnSZbYTG9Y7hBu/hPyNfgMpVQ
         ePSlfbcNWSynooaBp33lBmINxwuNUzXmO1LAl0rhHmTxbQHtkSs8pEBtB1SmVDftSU9o
         xWqbk0I5KoR4IpxUAADjEROHohw6R6SOATb9Qp0Qc+XAPOQSRKBMr4zeRNW5IGq9kA0U
         i1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668082; x=1696272882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDJU7SYD0amvWzwOGqGm/wTZR2ZpJVaE47M/yoVuMJk=;
        b=QoSeGqWP0KxlKn9shooAzjFrsvRdjIVjFyBMIge2o4kX9wfDade/7omZEwutYKjhcV
         Viej+snPYG9hww03jTsoVsvKyXpt24pUUTOP/uMPenGnHtrzeyQnmUyWbOBGgKMCeyuV
         3mJw1eAfOlsa9ihFOgYBAec1WP5I5OFIVlB19UKVLj+CYE+s67b9tUKcbwklahAT9+5l
         y1e7m0sDX6vrGgLLZJt9HwjHPyfSzjx/7cUya/9811BDt/8Byok2ffQ/Y35gCxQ2B5Bw
         YuaxUPZJiGq5QSMJuWuWbB3Y/lZweiM5utsZHfkJakosPj+z9avUIC5ODm0h5gYDO77i
         iqwQ==
X-Gm-Message-State: AOJu0YygGST58qA9HmvEbA/kDFXGFvMXzT6lSNPiQzTV5S3d/XTTyQdm
	uGwLuURLqQl8xpvCojDHXPebnPPuGWQ=
X-Google-Smtp-Source: AGHT+IH1Ov4/AHCtUMT6sJsN7JxJZDGDcPUNufhRmwAHmOhp8JUos6SO/p4qQqV86F2LhSiWJgzo+A==
X-Received: by 2002:a0d:d4c6:0:b0:589:ca07:c963 with SMTP id w189-20020a0dd4c6000000b00589ca07c963mr7400187ywd.42.1695668082244;
        Mon, 25 Sep 2023 11:54:42 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b00570253fc3e5sm2518920ywa.105.2023.09.25.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:54:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] scan: add scan_get_band_rank_modifier
Date: Mon, 25 Sep 2023 11:54:17 -0700
Message-Id: <20230925185422.2242494-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925185422.2242494-1-prestwoj@gmail.com>
References: <20230925185422.2242494-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This exposes the [Rank].BandModifier* settings so other modules
can use then. Doing this will allow user-disabling of certain
bands by setting these modifier values to 0.0.
---
 src/scan.c | 41 ++++++++++++++++++++++++++++++-----------
 src/scan.h |  3 +++
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 3979dc03..915e2875 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2310,6 +2310,33 @@ bool scan_get_firmware_scan(uint64_t wdev_id, scan_notify_func_t notify,
 	return true;
 }
 
+double scan_get_band_rank_modifier(enum band_freq band)
+{
+	const struct l_settings *config = iwd_get_config();
+	double modifier;
+	char *str;
+
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		str = "BandModifier2_4Ghz";
+		break;
+	case BAND_FREQ_5_GHZ:
+		str = "BandModifier5Ghz";
+		break;
+	case BAND_FREQ_6_GHZ:
+		str = "BandModifier6Ghz";
+		break;
+	default:
+		l_warn("Unhandled band %u", band);
+		return 0.0;
+	}
+
+	if (!l_settings_get_double(config, "Rank", str, &modifier))
+		modifier = 1.0;
+
+	return modifier;
+}
+
 bool scan_wdev_add(uint64_t wdev_id)
 {
 	struct scan_context *sc;
@@ -2359,17 +2386,9 @@ static int scan_init(void)
 
 	scan_contexts = l_queue_new();
 
-	if (!l_settings_get_double(config, "Rank", "BandModifier2_4Ghz",
-					&RANK_2G_FACTOR))
-		RANK_2G_FACTOR = 1.0;
-
-	if (!l_settings_get_double(config, "Rank", "BandModifier5Ghz",
-					&RANK_5G_FACTOR))
-		RANK_5G_FACTOR = 1.0;
-
-	if (!l_settings_get_double(config, "Rank", "BandModifier6Ghz",
-					&RANK_6G_FACTOR))
-		RANK_6G_FACTOR = 1.0;
+	RANK_2G_FACTOR = scan_get_band_rank_modifier(BAND_FREQ_2_4_GHZ);
+	RANK_5G_FACTOR = scan_get_band_rank_modifier(BAND_FREQ_5_GHZ);
+	RANK_6G_FACTOR = scan_get_band_rank_modifier(BAND_FREQ_6_GHZ);
 
 	if (!l_settings_get_uint(config, "Scan", "InitialPeriodicScanInterval",
 					&SCAN_INIT_INTERVAL))
diff --git a/src/scan.h b/src/scan.h
index 0e06dabe..0db7752d 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -29,6 +29,7 @@ struct p2p_beacon;
 struct mmpdu_header;
 struct wiphy;
 enum security;
+enum band_freq;
 
 enum scan_state {
 	SCAN_STATE_NOT_RUNNING,
@@ -170,5 +171,7 @@ struct scan_bss *scan_bss_new_from_probe_req(const struct mmpdu_header *mpdu,
 						size_t body_len,
 						uint32_t frequency, int rssi);
 
+double scan_get_band_rank_modifier(enum band_freq band);
+
 bool scan_wdev_add(uint64_t wdev_id);
 bool scan_wdev_remove(uint64_t wdev_id);
-- 
2.25.1

