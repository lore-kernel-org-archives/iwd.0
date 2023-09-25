Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440CBD304
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 18:54:41 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59bc956b029so86759727b3.2
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668080; x=1696272880; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxDJG92KL3Fmh2baF9X4/Or/RbQCCbW5E6lHabmhxdU=;
        b=VWm8ixxtXTE0JL8BEASNxXMpDkCCiZ8kAEibJgSbCZrAJ30Xbcy4I+3OAhiAViwdG6
         wRbjGlD92ZaGmkFA1R/pJdtno3qIhMXowkP+jEo9mMWf3nh33nPYZ4NeT2HF222Jzevb
         ZipkZIBZ5yP7iit9JTn4KBXBt+FSqzho3lG2Xwp40MZNS9k/YQWH0FAm8WNm57RJitS2
         m9/LJ1mJxHh66vcmU5Rx1P5IgF5krMdDMU942C2RY1gKTv/e7L6JtFM5N1DxesCd8o7G
         3SBc2QSKobA9RhKfYmUAJHBWkiY8+adV6LimeMOmLiPHeQeATiDDiHET+wrO/zwc5buo
         Mutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668080; x=1696272880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxDJG92KL3Fmh2baF9X4/Or/RbQCCbW5E6lHabmhxdU=;
        b=fAIQ/3kLAPyKF0KuVmNIDUeqoixXSM4BEtkABhW7fPJDwwikXEZgKC/3m+RR299/oQ
         OzjUutPa0iTts/c8hbbixq19c8XNmI2MgsQUI0a1MwOGPSDLcCSegcYpzvbdTbkcQcXo
         LkPjStQFBv6ejjGPEES3wr5dXHVCb4jJl04szxaGZLqErTsg6M1dM2sj7/tKMHhVG1gP
         9lMkRAbxppulWOgXh6mU/rlT63SVN66aFpihztPJZteY7TLalktVjzSj1mhUT85mkfYX
         hrz+vQ3L9ZAKefKsEGKoEKQ8XL8YOZ/oDcxP/1XW6WYYbB3A1ZYzvwE6++D/URMJgMwt
         5TVQ==
X-Gm-Message-State: AOJu0Yw/G7uzCgCtXoZF10uefSYM7zXz/EZKLbFlNYywl5B0NZk0Dfo4
	6vLYUTnOlPGz8MZGWcfqPnc4nUt/y7Y=
X-Google-Smtp-Source: AGHT+IEt2JCqsF2aHMpfrv9mnxPt9IkZe+tVqUogL8kI8kK8ArMOFb7lklX4hfaJWUJMux33mY1miA==
X-Received: by 2002:a81:b665:0:b0:59f:63fb:2261 with SMTP id h37-20020a81b665000000b0059f63fb2261mr5604630ywk.19.1695668080046;
        Mon, 25 Sep 2023 11:54:40 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b00570253fc3e5sm2518920ywa.105.2023.09.25.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:54:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] scan: add [Rank].BandModifier2_4Ghz
Date: Mon, 25 Sep 2023 11:54:15 -0700
Message-Id: <20230925185422.2242494-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the 5/6Ghz options, allow modifying the rank for 2.4Ghz
scan results.
---
 src/scan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 5a972efb..3979dc03 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -53,6 +53,7 @@
 #include "src/scan.h"
 
 /* User configurable options */
+static double RANK_2G_FACTOR;
 static double RANK_5G_FACTOR;
 static double RANK_6G_FACTOR;
 static uint32_t SCAN_MAX_INTERVAL;
@@ -1634,6 +1635,9 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
 
 	rank = (double)bss->data_rate / max_rate * USHRT_MAX;
 
+	if (bss->frequency < 3000)
+		rank *= RANK_2G_FACTOR;
+
 	/* Prefer 5G networks over 2.4G and 6G */
 	if (bss->frequency >= 4900 && bss->frequency < 5900)
 		rank *= RANK_5G_FACTOR;
@@ -2355,6 +2359,10 @@ static int scan_init(void)
 
 	scan_contexts = l_queue_new();
 
+	if (!l_settings_get_double(config, "Rank", "BandModifier2_4Ghz",
+					&RANK_2G_FACTOR))
+		RANK_2G_FACTOR = 1.0;
+
 	if (!l_settings_get_double(config, "Rank", "BandModifier5Ghz",
 					&RANK_5G_FACTOR))
 		RANK_5G_FACTOR = 1.0;
-- 
2.25.1

