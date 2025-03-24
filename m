Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289487081A
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825772; cv=none; b=Zz2WHHeiFwRNEW33z5Gc84mZ90OvTUBtPzUV8Kdussf5icxtbEb3UCrtXMc71Fi3S4QWYpyJscVVaMumi2PvWDlKu6ysu0AgKedzTdowpBCaCMmJKFntgnb4Y0wRe1kXbKB7ZrOnvob0tS3t+Ahy8gyhR5eIGM5GIptmt689Qec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825772; c=relaxed/simple;
	bh=+Wfw9ngcS2v+v31vvf7UegVQzfvQl0BxIocCRwLvkTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQh0QPnBVgC6bhBRt6vUSZ9U6+RPv5BZyL+rNEIVTHaAxU4GWxMD2Fu0OKBFmwpeblsh1RJmcMC71PeO6oOKMi2wk+2zcqWZ56bLb6SbzYKjGhHOguHKIE3zC+mblkXiJsuHRppl6whqvuE/yVuZs+1CjUdpZ0FvvNq+jx1cRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPTiGCjN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPTiGCjN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227aaa82fafso27500785ad.2
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825770; x=1743430570; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y7nR1JnCTgYT7L9t49nkf3rFLk9KMFOLvHvRabt+BE=;
        b=VPTiGCjNs7Q7Uu6Lhat5iSyP6ohPE85qPo64FTUVdbBYfHTjvlhN7K3HSNybmVPLzc
         HDppafGpGbxno20uVKkHtk/OYZJ1Z/KmqnWcMQsa0SEIBrGxaQ2XLrYUfIpXVA3gDwSK
         GTIIp4HWhX3hsyW9Wyy4Zu/PmJTfWS6DJCLfap3T4pnCOruLl5z3rvYqhWFtpIxevKcU
         IRbzAD4N8+6o17sKzvOgjY9SiFyybikDj9/HTZF4YMuGTT9rRILtd6gxBARuLcVLLtEm
         8pWqH/vmSXDpgBWlRLOMMGXu3j9Ub0iActAuFOa1zHVHbiPe8CPsiP2PrOLAtBVndbUA
         Ee9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825770; x=1743430570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y7nR1JnCTgYT7L9t49nkf3rFLk9KMFOLvHvRabt+BE=;
        b=XSnKIB2KJjsQYVeH2e4M7PCiVmfOU6Pd1NxBtUrHvX9m7RZi878co3ISIp/OoJeLD2
         c23lt1+U+hmfN3EXej4FSuKIYhERDxvvFTqQjlrBahvBaRgRORK5SB2+H5oBhq+IlJxj
         qIRbmsJJ0qbGKM0iLk/rQidKOPNs5enlnlTkJLPFdNNGWxkF12QdaehrQ09wudEOu4t3
         b8NGxQ6esLq3MZ/zud6mL9/iZPABZ+21SFnkA1VFd/x1eqFHHAmBJXAtfg0uyZsHnL/N
         UHGVOWMeRZdgFE+66ejNRzTH6WxZRR7dA4wtBPnzeiLH3UNe6/RIqOKCoc9QKImVKuBk
         i2Og==
X-Gm-Message-State: AOJu0YwkOLSunZwKzmyHF2dVirtDrMwOZ8sEd7k4kl/Wo7D/Chz3Lljt
	9mC1KYsQgekkRlXfGGe5ql3hRxYIn/T6PUKYjnGvjJp3d4bJ601Gkpb8Gw==
X-Gm-Gg: ASbGncsTRpuIOgUyEEM/giumFPL2/AWcwGHaKuUAqjl/x9fi+SqQr6b9Kfw6nLF+ASL
	m+lp4mEGAJPJbuUbiljSw/pOFpGKO0GHGdSvg3DCzpRItGdDsbuRCtnlWisv0O5jRv479ldHZfJ
	6KnOAqyRSaTs2TryGE0bB4uKY+TS9+sGtI2Q8FuAU0kAolQRnydbgnEOBp70o3JdFEO80UR1Qgc
	yGvMry2MVNbJ+rXsOcWxzGSTEhysZ2XJAQQK3Lhcuuh9xkrrhBhdyaTY8qZ1zSNohCYBwwjPmKO
	QAwFKrxMyhvP+RS1yJHd3hUoqChIPQLVdnGx5NqekDv2S669nihJm48=
X-Google-Smtp-Source: AGHT+IFxHLKxoKZiFlwCfOBOG6NwyO5yeYtJqVJt1U5mFcesRYEgB0blNMEQxrr3wuLAuYdUf51j3g==
X-Received: by 2002:a05:6a21:7a42:b0:1f5:5903:edd3 with SMTP id adf61e73a8af0-1fe42f2cbacmr22159666637.11.1742825769931;
        Mon, 24 Mar 2025 07:16:09 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/13] station: adapt roam scan logic to look at the bss group
Date: Mon, 24 Mar 2025 07:15:36 -0700
Message-Id: <20250324141538.144578-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In station_roam_scan_notify BSS candidates were being ignored if
their rank was not better than the current AP. This check needed
to be changed to first check the BSS group, then the rank (only
if the groups were equal). This takes into account the current BSS
roam blacklisting status rather than only rank.
---
 src/station.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 066ca337..092d0b4d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2801,6 +2801,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct scan_bss *current_bss = station->connected_bss;
 	struct scan_bss *bss;
+	enum scan_bss_group cur_bss_group = SCAN_BSS_GROUP_BLACKLISTED;
 	double cur_bss_rank = 0.0;
 	static const double RANK_FT_FACTOR = 1.3;
 	uint16_t mdid;
@@ -2831,6 +2832,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	bss = l_queue_find(bss_list, bss_match_bssid, current_bss->addr);
 	if (bss && !station->ap_directed_roaming) {
 		cur_bss_rank = bss->rank;
+		cur_bss_group = scan_bss_evaluate_group(
+						current_bss->addr,
+						current_bss->signal_strength);
 
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			cur_bss_rank *= RANK_FT_FACTOR;
@@ -2855,6 +2859,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	while ((bss = l_queue_pop_head(bss_list))) {
 		double rank;
 		struct roam_bss *rbss;
+		enum scan_bss_group group = scan_bss_evaluate_group(
+							bss->addr,
+							bss->signal_strength);
 
 		station_print_scan_bss(bss);
 
@@ -2876,8 +2883,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (network_can_connect_bss(network, bss) < 0)
 			goto next;
 
-		if (blacklist_contains_bss(bss->addr,
-					BLACKLIST_REASON_CONNECT_FAILED))
+		if (group == SCAN_BSS_GROUP_BLACKLISTED)
 			goto next;
 
 		rank = bss->rank;
@@ -2885,7 +2891,15 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			rank *= RANK_FT_FACTOR;
 
-		if (rank <= cur_bss_rank)
+		/*
+		 * First check the group:
+		 *   - If worse, disregard BSS candidate
+		 *   - If better, keep BSS candidate
+		 *   - If equal, compare based on rank
+		 */
+		if (group < cur_bss_group)
+			goto next;
+		else if (group == cur_bss_group && rank <= cur_bss_rank)
 			goto next;
 
 		/*
-- 
2.34.1

