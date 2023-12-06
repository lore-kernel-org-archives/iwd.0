Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EAF6F627
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRMZ71M3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d048c171d6so1453155ad.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893893; x=1702498693; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJARLQL5FvzCcPOG6EstqAKI+K/ZnM3CWBfY634KnYg=;
        b=cRMZ71M3FFJ8zvQqXNoBKXvsO7XHGfg4bR7iJbGlOrafHaxEWc/HGio9kOVeDroyTS
         r+vxod6homN+rnfGAItS6HsYopDumNnNBYfhbXHTmb99u6CEG21YxbDFRdI9EDnSPDJJ
         SmFuTcEjPrhfiXqOPTWMgz0TI3rIp8asf6rCOabgTcmfKpMS2XWMKXIiTpd62IM3V1AZ
         0eh/x3mwuqz6IVqur2L2N6IJxa0jpSqupMPxUxwLILHHVlF/aSogHIVIEFOYLUjEMApr
         Wwpm93iFwZFa/0cami5JAxnFPX0VIha9q2of/7nXIGVqms9kdMMf0jopHXHUV8a9uE6s
         mBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893893; x=1702498693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJARLQL5FvzCcPOG6EstqAKI+K/ZnM3CWBfY634KnYg=;
        b=Bw0KdbhycKHS5xC5wzTozC8J3EQKPrOz+UjmpxzL14OtJdTOGCaKEUA1Bbi2iajQx0
         l6WVMqw/BTBWWkav2nCikeYUgYZ4aEmYl697+H68bHKtIdI4w7tiGr+6EhX+G7OzYqC4
         9oDzLFqaeXzD72ybx2VhwQGNBlh29S8RSkIVCOmihxmASWHX8ooGKPW2UK3fULLBMIWs
         aVPLs/pK9GC1hOkP9bhqUKJSgU56cKntqkXPjtGGolNvpsVO4igIkJdVPmdPOoe9lB56
         x8FVwtr4DGdhfrpveJizjYZQFRVQ9NJG75Ojjxx8Bob2BYmyhv9iRtSmKE58HjcBo4OI
         z9KA==
X-Gm-Message-State: AOJu0Yxcv8e6aB35khQgABUlhtaWGh+782ds26alN6FRB9oU4lSSo8Fn
	aisFGPP2udTrDCDcT7YKkKcc8/vbJAo4fw==
X-Google-Smtp-Source: AGHT+IEjBEJk7pbCau2L7VejYayce3AixREfWQL6kLNfx1S0fetUYLB6VPw+YHHgEFe4DoT/Kgdk4Q==
X-Received: by 2002:a17:902:f546:b0:1d0:c445:8014 with SMTP id h6-20020a170902f54600b001d0c4458014mr1760273plf.76.1701893892980;
        Wed, 06 Dec 2023 12:18:12 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:12 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 11/13] station: use netdev_ft_reassociate
Date: Wed,  6 Dec 2023 12:18:00 -0800
Message-Id: <20231206201802.2139649-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using this will provide netdev with a connect callback and unify the
roaming result notification between FT and reassociation. Both paths
will now end up in station_reassociate_cb.

This also adds another return case for ft_handshake_setup which was
previously ignored by ft_associate. Its likely impossible to actually
happen but should be handled nevertheless.

Fixes: 30c6a10f28 ("netdev: Separate connect_failed and disconnected paths")
---
 src/station.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 48a595dc..52d87c84 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2181,7 +2181,8 @@ static void station_reassociate_cb(struct netdev *netdev,
 
 	l_debug("%u, result: %d", netdev_get_ifindex(station->netdev), result);
 
-	if (station->state != STATION_STATE_ROAMING)
+	if (station->state != STATION_STATE_ROAMING &&
+			station->state != STATION_STATE_FT_ROAMING)
 		return;
 
 	if (result == NETDEV_RESULT_OK)
@@ -2314,7 +2315,8 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 	if (!bss)
 		goto try_next;
 
-	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
+	ret = ft_handshake_setup(netdev_get_ifindex(station->netdev),
+					bss->addr);
 	switch (ret) {
 	case MMPDU_STATUS_CODE_INVALID_PMKID:
 		/*
@@ -2343,12 +2345,28 @@ try_next:
 		station_transition_start(station);
 		break;
 	case 0:
+		ret = netdev_ft_reassociate(station->netdev, bss,
+					station->connected_bss,
+					station_netdev_event,
+					station_reassociate_cb, station);
+		if (ret < 0)
+			goto disassociate;
+
 		station->connected_bss = bss;
 		station->preparing_roam = false;
 		station_enter_state(station, STATION_STATE_FT_ROAMING);
 
 		station_debug_event(station, "ft-roam");
 
+		break;
+	case -EINVAL:
+		/*
+		 * Likely an impossible situation, but since ft_handshake_setup
+		 * rederived the handshake keys we can't do anything but
+		 * disconnect.
+		 */
+disassociate:
+		station_disassociated(station);
 		break;
 	default:
 		if (ret > 0)
-- 
2.34.1

