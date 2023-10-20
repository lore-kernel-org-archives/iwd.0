Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0BC12E65
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqqvTZ/6"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d122e0c85so4485226d6.3
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697806228; x=1698411028; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdMg8DaOZqIjpQ7D0LR5TehYcPHaUI8tuTl8BR/DkIs=;
        b=SqqvTZ/67kX8KVQL9+yhQR1invar+liWf0SYjZV2tPwgeJ2Q1nFekLQ+M/8fi+28Jw
         sFBYJ2sUvYQZUNkTllXaVG+3b7bYWP9RooN+NetTDTeOS5HvscDfsx92HVgLqz7xvka/
         F/eH0q+9h78RpllH7VlAwL0GAHAaRGLxedSpBzaeNdSqhj5RLf15JAA/kbwVPZBx5EMR
         4NTx6tNOwMFyUAu1SAtQrDN+AzCSYsed+aNTpqzxfaVydWKDoBMD9T8gtVHQdb7Trpt1
         rKMfUKssPFxsDQd/TpXtJot+EEtVseKofqchZnGig8O20wJ7fDLwynVgUataXyDEkLnt
         iUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806228; x=1698411028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdMg8DaOZqIjpQ7D0LR5TehYcPHaUI8tuTl8BR/DkIs=;
        b=Z7T0CcpOwRzjlyEjPkID9AVqtdwBRQs9BlRj7pKCsl+85e36TrKIaMPFmJlVcItROj
         /PACTSvSZH6g6UIAwP0sloA02Qw+CfDPAblF6shxewPsvLa+GHT5DwGjKnBUKsWXj4ww
         R4ke25z/rVEOeR4nK1rk2+c9dn6tzwi+pKIxphvHVoidKsAw1ny/AsQCmzd/GAZG3kqN
         kX/SADcKWv8jmX0lTpdJzAgcWQM+72sGId5forZ3T0YZFy/wLZ9/uGw/hpqx8udF3sod
         BpOp3iaXUzWZKAWx5F51M8S/+wOaMI8U7oDRasUSD0NB8gvE6sc8YfqDoXCboiqRgTzz
         DCNg==
X-Gm-Message-State: AOJu0YzD81AZ1GJr0JGoh2TTXqIb5ETP/rQiTOdq7r7dWjzZdwt2YjBj
	EdbYM/eUYzAV/0rDJuHwYu+d/vUTEcc=
X-Google-Smtp-Source: AGHT+IHjdzJy/XkEyRfTT7MvDGC9/PGdjKyx1aNDRNkC3qutdRlt+t3EoFtdsRzxxWzo0Ve+UTAYCA==
X-Received: by 2002:a05:6214:21e3:b0:66d:15c3:62ca with SMTP id p3-20020a05621421e300b0066d15c362camr2259409qvj.24.1697806227739;
        Fri, 20 Oct 2023 05:50:27 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dw14-20020a0562140a0e00b0066d02f0af01sm657487qvb.72.2023.10.20.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:50:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix unintended netconfig_reset pre-roaming
Date: Fri, 20 Oct 2023 05:50:21 -0700
Message-Id: <20231020125021.107671-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 23f0f5717c did not correctly handle the reassociation
case where the state is set from within station_try_next_transition.
If IWD reassociates netconfig will get reset and DHCP will need to
be done over again after the roam. Instead get the state ahead of
station_try_next_transition.
---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index f24b9aca..e18847bc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2470,6 +2470,7 @@ static void station_transition_start(struct station *station)
 {
 	struct roam_bss *rbss;
 	bool roaming = false;
+	bool connected = (station->state == STATION_STATE_CONNECTED);
 
 	/*
 	 * For each failed attempt pop the BSS leaving the head of the queue
@@ -2498,7 +2499,7 @@ static void station_transition_start(struct station *station)
 	 * still should roam in this case but need to restart netconfig once the
 	 * roam is finished.
 	 */
-	if (station->netconfig && station->state != STATION_STATE_CONNECTED) {
+	if (station->netconfig && !connected) {
 		netconfig_reset(station->netconfig);
 		station->netconfig_after_roam = true;
 	}
-- 
2.25.1

