Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFC6120
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 22:33:11 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id f24so113906plr.1
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=usREDfQOo5kAemiqiiJYAcUEZPacCNkVW6h+wSGJs88=;
        b=hk3TDqDLIHhEXq/ENliEWr93TFz2bJIpjt0vf//3Jel1hTgfQcYVcVslaYgaNQul+I
         NzOXWzabRtrTryiw2pEbiFZaP8kTp6knycrAtrbJjkalsyX9LKIu33Wtbx3XI4yk5JVQ
         1XGj8XxmyS4Cs609WDQY1Cgcm/Tj9yRxpEMM16EUNfocvij2GDDM2XnNpjAAEHE/sqKZ
         qD/6owSf2y6ljiyzcc0ycOJrmKfTHa9vV6t0dCelaCZkjDGXqqRHZntRPuxHrlfkaW+q
         WNx9L8v7JslOd2fkKF/t4yeeAfPsI4amN1Otv7RMbACMyuvtxDXeZVqx6kGJa99c+d2m
         9Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=usREDfQOo5kAemiqiiJYAcUEZPacCNkVW6h+wSGJs88=;
        b=dhMuKY0Aq9XaO6XbFmjn9zXYyLKJsgWQusJI+Lg1uF0FFiGpGddrlsFzpVdNevnyKt
         /TrxeFh+z/7L9HGqyW2gMbt0Ftl3Hzs54Hu6j1YD4C4VBEnFm49NFJnlfGLCPbjO9/Hq
         8IlhaGFvZpPqIe0xWa4wpw3oj1snCGau8QqXHoTWRF7jRG5oLrf86Clb8PIJ+2NfUn2E
         7Zmlxp5j3CxqJjgSCYZI636kd7Ec5ugHDQmVO+oRUudIHpUxdvbyVDd+jompTZ2vOJ+j
         hWUUh7EYBe3JhDxoEIqHgEj6pK8fezghc0H4/NrnJORuNZY+Xwr26oyVSgbSgm2k0SHB
         U5og==
X-Gm-Message-State: ACgBeo3gzffkMinlvHmNL2VaFUZTv8uORcXH1+fgAkNORNTS8daF2xR9
	M/a/FnV9Q0WoGUK159LvOHosoUS/wA4=
X-Google-Smtp-Source: AA6agR4ZuDB7qhGsvdRceUtN4JnYvPVdop6/S4EkjvDuPOIF/0AvSd2F9G2jODDOQBteW7uRe95seg==
X-Received: by 2002:a17:90b:1e0f:b0:1f5:37f5:159c with SMTP id pg15-20020a17090b1e0f00b001f537f5159cmr6360167pjb.189.1662676390795;
        Thu, 08 Sep 2022 15:33:10 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id p62-20020a622941000000b0053e7d2b2c74sm128749pfp.95.2022.09.08.15.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 15:33:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] rrm: constrain scan frequency before scanning
Date: Thu,  8 Sep 2022 15:33:08 -0700
Message-Id: <20220908223308.439085-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220908223308.439085-1-prestwoj@gmail.com>
References: <20220908223308.439085-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RRM module was blindly scanning using the requested
frequency which may or may not be possible given the hardware.
Instead check that the frequency will work and if not reject
the request.

This was reported by a user seeing the RRM scan fail which was
due to the AP requesting a scan on 5GHz when the adapter was
2.4GHz only.
---
 src/rrm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index 311e62fb..fceff5c7 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -443,6 +443,9 @@ static void rrm_handle_beacon_scan(struct rrm_state *rrm,
 	freq = band_channel_to_freq(beacon->channel, band);
 	scan_freq_set_add(freqs, freq);
 
+	if (!wiphy_constrain_freq_set(wiphy_find_by_wdev(rrm->wdev_id), freqs))
+		goto free_freqs;
+
 	if (passive)
 		beacon->scan_id = scan_passive_full(rrm->wdev_id, &params,
 						rrm_scan_triggered,
@@ -454,12 +457,13 @@ static void rrm_handle_beacon_scan(struct rrm_state *rrm,
 						rrm_scan_results, rrm,
 						NULL);
 
+free_freqs:
 	scan_freq_set_free(freqs);
 
-	if (beacon->scan_id == 0) {
-		rrm_info_destroy(&beacon->info);
-		rrm->pending = NULL;
-	}
+	if (beacon->scan_id)
+		return;
+
+	rrm_reject_measurement_request(rrm, REPORT_REJECT_INCAPABLE);
 }
 
 static bool rrm_verify_beacon_request(const uint8_t *request, size_t len)
-- 
2.34.3

