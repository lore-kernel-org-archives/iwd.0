Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6213FFC
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704046; cv=none; b=cNUFJVzOIuzVvo7MTA2h4jjSs/28+gyHlJ+tggRoFBTU0Fbb7XUmnXZiCokGLtkELy2G1PpFHrwXYzQAyk/JmFZRe+NMDoDHFhlcvPk1n2fq9XOzEjxq8owj452ydweoEPpKQRfbSHEvAah4QzLwuL2z2EnPxeRoThjEY9kZuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704046; c=relaxed/simple;
	bh=Ne09aV/bABuP0YqcwfKF2nlerO45xRpbn200bYN7DjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzFhp+YrUhC/1R8jmKcAcIwDYbcCr2MzQ87C0AfzxizV4LTOM7UMdU8TWyQCllKS5+hpFkJOfpEhwi3zGvyi5R9DoKrLIqjFnyXgn9ZLQToE/R8HU/lRnBxRt2NCMKvt4hlNGTzqT1Ucv7fxWEpknliEnRRO6C02f5bdSdjpGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcwdShd3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcwdShd3"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ab1ddfded1so2876434a91.1
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713704044; x=1714308844; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZCBRJ6KKyf1ut9BMuJ50apuGKXn4zyytljFybP+OJ0=;
        b=YcwdShd3GtW94yxMe9XSr+qrpwlXajZKT6lTmSwopK1Fl8daYaQf6QYI33w3ynYAHz
         ThzHXx6iWTNFtm0jQTfYOubdKgO5dp/b1ewA9tIjKrFPLYSZ/JCfpeAR7jwMTHED+fBZ
         Q2xkhh+HPqQf8csOVSTEvEL8BP1gMA65UsFMsobOM9mg57ixaJnnUMwDZmu00xiBQgx0
         b6I56t6sWTeK9DmdbJAP5jtk8d4FqLpsLlkgpZyC7yxGvyAtfayIjTtKkBBTUBOUv76T
         5+QUrqgwgQZTcS8yBU/BZe0TtNd4C7BDFW2XYJrg283H7YsEin16OSI1k8dpstfJGwWQ
         6TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713704044; x=1714308844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZCBRJ6KKyf1ut9BMuJ50apuGKXn4zyytljFybP+OJ0=;
        b=clo+HjlS2PCF29B2PICatTdE8xRijGxYzeH7raBCAtVxdRheV6ZJrq7Ykt/KffY/ow
         Lu9gNPbSiDOfsS4Fxv5sdI7nT8TuztQU6Dz65GsyUvwd+IVSlJZ5H1aQ06a6IbjIRda2
         6P4a44+sOnGzDoZ3uAltG5RsuRSuRnyj8bkuztJeNuZF5ipUVacT3/NNMJKx51vQi656
         WPXYUnjZv8GEjXL1+eGfdh0NmKWurQSQn2hz9279t1BkM92XWrEzblqD05TaECiCLvAy
         MZphRHajIiDM7Ng1uQYo6vebRPBuM34eJCFJmB90/eF4fn+0uP4TsB0/pwwbeeeQaWu1
         RLWg==
X-Gm-Message-State: AOJu0YwyVr92u+H/yMr2QiioS6MKoKDVZHoYJfGBuL+HxF2DW3AHuKQc
	i/CL2UX8S3Nrx0QTHJQRVhHtpw/lAFmM/LKQoycY42JF2x/2S2eFjMgbiRvAGlk=
X-Google-Smtp-Source: AGHT+IHlAQo3WhY+9+GvQvPp+SVSs87meZoHE3xf89lrIP5a+0AcnAMtTgJk4qPN2AHB3EXjeyonDA==
X-Received: by 2002:a17:90a:aa87:b0:2a5:2870:6d with SMTP id l7-20020a17090aaa8700b002a52870006dmr6145610pjq.48.1713704043856;
        Sun, 21 Apr 2024 05:54:03 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a6b4600b002a0544b81d6sm5834222pjl.35.2024.04.21.05.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:54:03 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 09/11] ap: enable start of 4-way HS after SAE
Date: Sun, 21 Apr 2024 05:50:39 -0700
Message-ID: <20240421125050.6649-10-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421125050.6649-1-brandtwjohn@gmail.com>
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept association frames that request SAE if SAE is enabled by the AP.
When SAE is being used, get the PMK as negoticated by SAE.
---
 src/ap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index ab0cbdcd..27b30e5b 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1500,12 +1500,19 @@ static void ap_handshake_event(struct handshake_state *hs,
 
 static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_rsc)
 {
-	/* this handshake setup assumes PSK network */
-	sta->hs = netdev_handshake_state_new(sta->ap->netdev);
-	handshake_state_set_authenticator(sta->hs, true);
+	/* this handshake setup assumes SAE or PSK network */
+	if (sta->hs && sta->akm_suite == IE_RSN_AKM_SUITE_SAE_SHA256) {
+		handshake_state_set_pmk(sta->hs, sta->hs->pmk, 32);
+		handshake_state_set_pmkid(sta->hs, sta->hs->pmkid);
+	} else {
+		sta->hs = netdev_handshake_state_new(sta->ap->netdev);
+		handshake_state_set_authenticator(sta->hs, true);
+		handshake_state_set_pmk(sta->hs, sta->ap->psk, 32);
+	}
+
 	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
-	handshake_state_set_pmk(sta->hs, sta->ap->psk, 32);
+
 	ap_start_handshake(sta, false, gtk_rsc);
 }
 
@@ -2258,7 +2265,7 @@ static void ap_assoc_reassoc(struct sta_state *sta, bool reassoc,
 			goto unsupported;
 		}
 
-		if (rsn_info.akm_suites != IE_RSN_AKM_SUITE_PSK) {
+		if ((rsn_info.akm_suites & ap->akm_suites) == 0) {
 			err = MMPDU_REASON_CODE_INVALID_AKMP;
 			goto unsupported;
 		}
-- 
2.44.0

