Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019E3F12C6
	for <iwd@lists.linux.dev>; Wed,  8 Jul 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524195; cv=none; b=VOVkdZkBsRRh9Xsw/aqrIMY+YxEYkmmgvcRUUuOE0oDMhunXS9vChxjPlJaMVFi/q4DqAL7CldK4CG1H2mdn+bfLVB9Ielsle0CC+/N3gVFdRqT1QzzmIDK58bd4O0A9iGub1huRJdhZE+PiIlk4YQa3LpumJhrKBkQ2wCsnqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524195; c=relaxed/simple;
	bh=0F2OW2XL/TofmzNHZSSET/+m39sVdc4dBNx2/8ooz9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghXRpgbTNdWA+WsNePbQzKlYoNsfufmvCXNyPc07QeSWQrQAzKATNfLTjN9TP099Fr2nx/xjsAdziC4min9AsQQ2KdneCrhBdFtF6mAFKzygs/o9lxU7xSVxluKyaueFdkK2iecT3AQZL93XFGBvOCwFwvPVmQtgDiC7epuqmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjjiu7rH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjjiu7rH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b6f1b14bso3711285e9.0
        for <iwd@lists.linux.dev>; Wed, 08 Jul 2026 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524193; x=1784128993; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTYyHLv+JFcTBWT9WahDmWAeXG05epmCD+11TXuczQs=;
        b=Jjjiu7rHQcykgZaRNE7c9X+CnDga2+owKbAZHrmpMIm46qFNY7G7NfI2OvcUMPndh/
         wn2SurP+x6EJVzyOiVmCfwreqA2SxmdS17THYZENDOE9OqY4E/UPEJxYMXVnOiEWCz3g
         uA1XgxCGeO22hM8gXhx7lJ3qb3YoZB887cpTrFAWsZH+P7LWMCJHNLRyWum7M3JY/tyX
         A7I/yZC1NYafqnycoIrEuLKX3FjTxArDIpRPu9HF3iFntHnWdTX6qH1EiubprQonwYF4
         MEFCixJ7+cA2fpdYrcPOh7oSG26RbxGpG7MTzeoI59c15gQos7hMSX+uiivEUvUBi8rw
         inWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524193; x=1784128993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xTYyHLv+JFcTBWT9WahDmWAeXG05epmCD+11TXuczQs=;
        b=ITqs/VRyuOBUd1RgNMJwYfhdGEPwGX8XeaS61G72zHJQMAK7eHLl3Ufu26NWQRe+dg
         Eo74U7R6YC0mTcSOr8dTVvxLHMhSESOo/msKXk/8HBUqwZut9NMZD3vtgag0ZHu5JA6o
         LYCGyNh/+tLYArekh+ovSf0SYvDjt+PcXr3XabdxYS7MorBXDLm4HTLEcy96/kU2qCaW
         70cPtb4bvQLAeLOfmSlItH6dPbfZv18E0GKQ6yOZ7PGAFrrQS6SSmECW5zPuAaDUsita
         7/qUeE/zH07pI+jGFu4OvPJwRHWbksnT2pWcXZMmhPVXZoyehUxI117W+8ANTzO2JRxn
         9MHA==
X-Gm-Message-State: AOJu0YxdY/pC8D6sHKZq7/aMUt8i4lU0R5nylT0e/zO5vDBD7ZZonYVk
	xRc0Cp8iJmjHlSHe7FLuO5oN6CIG56ldCnjrCX/DUUfzKqgVbAUFAHPgFRaSFg==
X-Gm-Gg: AfdE7cmhdCWzYoBnLE50DrElX9oaT1m54JhBI+wkT72cYzYtmw153MnGp+td4/S6uPv
	l6A/zUyksX+UzoyHkemZtxldZG/9wxDS6fDeDOfEA+i0UY5y8zSg4IEsUmeMDbm8pI4Tbxi6XZy
	7Kgs6IpcoHtc9uBaq9kwi3uz1JOHHoEwW1U900/vWHL3ky5Gr7x7B4espjJOnwQEYvVIeK1wimd
	EnfAMr4L/CuO4cBAjsO/rUp7zWD/zyDEVsU1GHghR49IhmDv98YjpwfKnYym0ZZsdpRCs59Ew5F
	wE8NimoI7EKfUjvq0lWl+RTsXN4wpFPF1EHNlQobHxTEnjCdL6aJQ/qOnfA7vCOfnTHC4EufrwY
	jag/cFIHT6uEEBZfVzNugP4VBqzhjO+aHxOuPvxi9+hu02o3VJ4GsECznj0g/rrybrbv+qe5KCM
	Ypw4LB0xo3r02anirK4mLMocESxR5todl2VyCgAQ==
X-Received: by 2002:a05:600c:528c:b0:493:aa28:38ad with SMTP id 5b1f17b1804b1-493e6844228mr31995895e9.10.1783524192359;
        Wed, 08 Jul 2026 08:23:12 -0700 (PDT)
Received: from localhost.localdomain ([2a10:4440:fff:d1a0:c58e:91f1:416f:77dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a61135sm42412065e9.1.2026.07.08.08.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:23:11 -0700 (PDT)
From: Dierk Modrow <dierk.modrow@gmail.com>
To: iwd@lists.linux.dev
Cc: pmenzel@molgen.mpg.de,
	Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH 2/2] src/station.c: fix of SEGV in station_roam_scan_notify when performing repeated roam scan at legacy roaming after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
Date: Wed,  8 Jul 2026 17:22:28 +0200
Message-ID: <20260708152228.1191-2-dierk.modrow@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260708152228.1191-1-dierk.modrow@gmail.com>
References: <20260708152228.1191-1-dierk.modrow@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>

---
 src/station.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index 8fcf8c70..077e510e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2253,7 +2253,7 @@ static bool station_can_fast_transition(struct station *station,
 {
 	uint16_t mdid;
 
-	if (!hs->mde)
+	if (!hs || !hs->mde)
 		return false;
 
 	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
@@ -2917,7 +2917,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 
 	orig_security = network_get_security(network);
 
-	if (hs->mde)
+	if (hs && hs->mde)
 		ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
 							&mdid, NULL, NULL);
 
@@ -2930,7 +2930,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	if (bss && !station->ap_directed_roaming) {
 		double cur_bss_rank = bss->rank;
 
-		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
+		if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			cur_bss_rank *= RANK_FT_FACTOR;
 
 		cur_bss_group_rank = evaluate_bss_group_rank(bss->addr,
@@ -2967,8 +2967,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 			goto next;
 
 		/* Skip result if it is not part of the ESS */
-		if (bss->ssid_len != hs->ssid_len ||
-				memcmp(bss->ssid, hs->ssid, hs->ssid_len))
+		if (hs && (bss->ssid_len != hs->ssid_len ||
+				memcmp(bss->ssid, hs->ssid, hs->ssid_len)))
 			goto next;
 
 		if (scan_bss_get_security(bss, &security) < 0)
@@ -2986,7 +2986,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 
 		rank = bss->rank;
 
-		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
+		if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			rank *= RANK_FT_FACTOR;
 
 		group_rank = evaluate_bss_group_rank(bss->addr, bss->frequency,
-- 
2.53.0.windows.2

