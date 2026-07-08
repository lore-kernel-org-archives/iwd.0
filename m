Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130D2ED872
	for <iwd@lists.linux.dev>; Wed,  8 Jul 2026 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549282; cv=none; b=K1C2+BbKcICimoOti+2q95sApOR13BbtsvKaim3YJdSsxDXh7lIAEmi5w6kwJPZW6C2GmS9x60WnV940uMCWCkHrg4khzzKxgseG8F6qsvCLkkLGTEwxLPRr6dg7Y98En6uy1kKk6w/ApO9+95eTspuWV+zpDk7ok63SNRCC1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549282; c=relaxed/simple;
	bh=NizH098wFjanZOsBRUroseDBKjUwmj//jJtNlvi9JaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WisFJrD5tRM1Y4aum2vL1KjAhwZxR7Il71uueDOINtpLukxJ1ak+oDBjMQdwrJi8V9Uw+DKMBJB3KvxRLJPjF2W2uClS70HAG4svaAzq4QQpMhNOGsg/x//EzZcOKe4EwG/In+D606740+kzIlrEA9dCEBR3iPazJAGI4L1F4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnUvzk2a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnUvzk2a"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so2261855e9.1
        for <iwd@lists.linux.dev>; Wed, 08 Jul 2026 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783549279; x=1784154079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcGFAfrURYIlfuZaBHWi3CkVLkW9ZfxUhTBFntox6+I=;
        b=nnUvzk2aVhQXv6ioNOcy4HQEbdCyIthUmzhw0gwn9x6gBgmILaxqw+SeuhjbtLa6yT
         apbaR8wGWU8Wse+fLdaNRi2x0VaeN2DqAxzpYf5UyyADyH5Wn27MhTugUPdIniAA4b+2
         if6gRP2g0UndzQWZG/s1XGGgExH9lAJs4/vmANqmhVQoetnpLvsxZBxF1Mz4v6PDXCEL
         rTQicwz8f9TJIMBfj+tpRDJ1dIJoRTp+XROGLiG195WPAq+huvGiIay0kkRJ6vIYsCwE
         rVx6PUfLR6bs+dCvkX9GsK2YDuH8uFgsPUpFa2j6Nhc/YUB4MAaOy5GbIykYdHuEodN/
         Z2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549279; x=1784154079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HcGFAfrURYIlfuZaBHWi3CkVLkW9ZfxUhTBFntox6+I=;
        b=CUAZejeA0/nDhByI+Pm+g0trxxicP81lICXn2UFfaJg3aGlrZcYcWBdLovDExiwrea
         pRo1wUQuHA1ZZvB8li12/GqO+WqNx9MMkEmdNLMImmN+2WUE01xQwJVwWK5dMSkYjFtT
         7Kp9TYuRKvGfJ4/ZfrXSFL9Clb+qEQGKV3OsvgrifuoLAWTSvQc2jrUkOOedE/vGImP4
         OQWXyv4p2FO0j3aQ8wRdLfE7GuWrNAYeab8EYFzn9SACPNFfgXbhNsKMPEli3+S4yXY1
         Kfo75t1e/OXyQbmU4Wq0t3sYC5o9Ev08kFMO8pNYg+PJ90N1l7j4iZ2DMGGpluW2lOP5
         oqug==
X-Gm-Message-State: AOJu0YwTXh+2eaySnz/Ik6mI8fuIPKYkmtmH35OTpt4Ztcf/l9pjlj+h
	6ioyZirM3+t81/VbK7fnUduaMNyl0tSgnwf1abxKIOloqMjsNpxbtRVIYG2S9A==
X-Gm-Gg: AfdE7ckjgy8A52dpZIKAj43wmlpPtCp46DT0mxN7wx+r4znUVqlFpzzlJZCazHpBVK9
	2pcT3Q3vuTgNT0wM4s1kjGUKABcB8lAZhM2QNOuCWcLlJWbX/jKubEXTtrkz11wBbxDx9Yuxiuy
	14Pex+C1RL1aW49uwFgUyuXzsGocqKpwXoOI2A6+W9H305nLj86E6+Kf2iMMVKNdtXM04mfzIMQ
	ShCERnkxlagIE9OCVC9uA0qqwNoW4tALpLyjBoA8yMk9uHkHQPLKk7yjIdzUV9VMe5GGLurx9uF
	cbsQ893Sehps7VcjyxbaGvMiTrhQhiEsp1sX39kv4sadULkE4qZ+rVqcFhM+pw9OtjPwo8+2Yp1
	62fr30hef4XRgatSN73VxJAGfMtvBWLVm97f00QP0qOxe/vHT4t2IXG6vDJaTWNnOxs+0JojGpN
	jo4Oy4SVl2THc45AnkvrpwNnIAewurahag+G0CFA==
X-Received: by 2002:a05:600c:8a0a:20b0:493:c2ac:58f with SMTP id 5b1f17b1804b1-493ec665a0bmr933365e9.8.1783549279300;
        Wed, 08 Jul 2026 15:21:19 -0700 (PDT)
Received: from localhost.localdomain ([2a10:4440:fff:d1a0:d438:d408:8c5e:d0ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f373csm19920295e9.14.2026.07.08.15.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 15:21:18 -0700 (PDT)
From: Dierk Modrow <dierk.modrow@gmail.com>
To: iwd@lists.linux.dev
Cc: pmenzel@molgen.mpg.de,
	Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH v3 2/2] station.c: Fix SEGV in station_roam_scan_notify on roam scans
Date: Thu,  9 Jul 2026 00:20:56 +0200
Message-ID: <20260708222056.273-2-dierk.modrow@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260708222056.273-1-dierk.modrow@gmail.com>
References: <20260708222056.273-1-dierk.modrow@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>

It fixes SEGV in station_roam_scan_notify when performing repeated roam scans
at legacy roaming after a failed FT-handover due to a
ft_auth-/ft_reassoc-timeout. The issue occurs with all WLAN drivers.
We have seen the issue with SIEMENS SCALANCE W700 AX APs, but it may also
occur with other AP brands supporting FT-handover.
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
2.49.0.windows.1

