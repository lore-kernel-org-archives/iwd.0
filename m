Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6303B7BD
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUrjZn1q"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c9b95943beso12148245ad.1
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140921; x=1697745721; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVXJyhuWpmh9lW4D60s/R9nS1tUxPnCO2z7TdE316vI=;
        b=XUrjZn1qkHX9e1zH4fzwnOLHwaOgUcofzv7joWZXOmCBNMdnjn1+o+uto5dAfuJHr9
         OqD9jw3NpGMKVd3EQ5VQRPTOj1aZ4/cA1VsLlb3MDlhI0F1qHI2wvDzQWW9ueLdHsLdm
         UbwL419Bep6tE3JSkJT/anVEGSnAHpgtIFyFGxR0kYDwD+r236iG/K2javoljFfFmucA
         Z56pY2+K1CGfNxdbtyaOVynCAgAwY4tAtI0P3nNqzv4yGzv1flVpHl3VuKkX2mIALCQ4
         53Y2DwAifyM0qx+2kbSsZNnLQT3B3AdifjOQ2HOJX6w0GYkt89vkEWYDEqA9zymg6d2J
         5paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140921; x=1697745721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVXJyhuWpmh9lW4D60s/R9nS1tUxPnCO2z7TdE316vI=;
        b=UOfWtHCjk9SxeYNYQ/FHXJeajcMV7aeA75huSeYRUiFKEzLbgCS0QFIuK4X5+3BIiZ
         L5JfMbFi+YoZIsD0opyPAx/fj48XuooinzLu+qMsMqC2QectFJuG1GJCUTxPQ9HGTKgD
         E2EacbpWdyZTWXqCGtQir4mcOFqw+K0UiFb5BtafgaG/kwFb7ekpV/jA/zTMi/gAwYSE
         YTnGB4Hy59GzvlOV/Av713bFUvrrjSpI6FVcryv1HLCZuCFnirYj5uUa42yuc84xNmTb
         Dc2nCG2r8h5Nr+QvcWRFhiVlqMHCfXeqdcpvm53NXKTLYt6l0TsH+sRenM5Ov4h0CIPA
         UN6Q==
X-Gm-Message-State: AOJu0YxRLJ6EXOIBQgpP4sIEpma+SuGwyiOIIWlf5VGBIzC2ZRhWPL+M
	nrgUpW4KySMHxG9dqL/tvZ4S/+zYfII=
X-Google-Smtp-Source: AGHT+IGY2zSgpnU3Niuexw0DpgaiHxxwViJ46E/u5DR5L+Jbj23dd7sX9Psd8tx/t/YZ435hlbAaBA==
X-Received: by 2002:a17:903:2647:b0:1c9:bdff:6c47 with SMTP id je7-20020a170903264700b001c9bdff6c47mr7596871plb.59.1697140920859;
        Thu, 12 Oct 2023 13:02:00 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/21] dpp: rename dpp_presence_timeout to be generic
Date: Thu, 12 Oct 2023 13:01:33 -0700
Message-Id: <20231012200150.338401-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PKEX will utilize the same offchannel timeout, so rename to
dpp_offchannel_timeout to be more generic.
---
 src/dpp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 25371fc5..3a20f8ae 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1555,7 +1555,7 @@ static void dpp_roc_started(void *user_data)
 
 static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq);
 
-static void dpp_presence_timeout(int error, void *user_data)
+static void dpp_offchannel_timeout(int error, void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
 
@@ -1588,13 +1588,13 @@ static void dpp_presence_timeout(int error, void *user_data)
 	dpp->freqs_idx++;
 
 	if (dpp->freqs_idx >= dpp->freqs_len) {
-		l_debug("Max retries on presence announcements");
+		l_debug("Max retries offchannel");
 		dpp->freqs_idx = 0;
 	}
 
 	dpp->current_freq = dpp->freqs[dpp->freqs_idx];
 
-	l_debug("Presence timeout, moving to next frequency %u, duration %u",
+	l_debug("Offchannel timeout, moving to next frequency %u, duration %u",
 			dpp->current_freq, dpp->dwell);
 
 next_roc:
@@ -1617,15 +1617,15 @@ static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq)
 	 * between canceling and starting the next (e.g. if a scan request is
 	 * sitting in the queue).
 	 *
-	 * Second, dpp_presence_timeout resets dpp->offchannel_id to zero which
-	 * is why the new ID is saved and only set to dpp->offchannel_id once
-	 * the previous offchannel work is cancelled (i.e. destroy() has been
-	 * called).
+	 * Second, dpp_offchannel_timeout resets dpp->offchannel_id to zero
+	 * which is why the new ID is saved and only set to dpp->offchannel_id
+	 * once the previous offchannel work is cancelled (i.e. destroy() has
+	 * been called).
 	 */
 	uint32_t id = offchannel_start(netdev_get_wdev_id(dpp->netdev),
 				WIPHY_WORK_PRIORITY_OFFCHANNEL,
 				freq, dpp->dwell, dpp_roc_started,
-				dpp, dpp_presence_timeout);
+				dpp, dpp_offchannel_timeout);
 
 	if (dpp->offchannel_id)
 		offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
-- 
2.25.1

