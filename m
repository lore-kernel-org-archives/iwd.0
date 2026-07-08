Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD33D0934
	for <iwd@lists.linux.dev>; Wed,  8 Jul 2026 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540571; cv=none; b=sKr9dLnHU9IlDQsPrRpokPxPKOYyiarD6POFHlBI1iNbcjaOnumin/Ldg0h7MWK3Z39PIG08JLvlQ3l2MdA+cFE7sy7ZNKhwnQOU7Y4sDkrPxBkpe9VBWFhEAKI87WcZDiwj24hnQRvBDM7FkeL0ywbDpbDuXaB4wq9hteVBG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540571; c=relaxed/simple;
	bh=hJiAV3N3cO6eFyLbRO0pM3N8pUaKxLmFzqXS3GaOS1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dh6pMXRLFag/TvgeyNVkPOCIAFJ4gKKDi1S2PBZkwZrcJw2fnIFxNGF8r4l+W1PLDWavDL70Fy54kHLF0UJWpc/S+P475DE/I4NTS/LQybmPdpBnVbOLAswInYLvY14RVQsD70mDDzLTJ0NRh1LEzm/DW1Ue+eEkqHg/y7P3N0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkXnggEC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkXnggEC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so1368095e9.2
        for <iwd@lists.linux.dev>; Wed, 08 Jul 2026 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540568; x=1784145368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYqjG2FvDnDofNim76s28/lCt25fY1DfnzC9fP9Pe7U=;
        b=hkXnggECEi2Jfudl9Wr6UBHkClyOowNbfdD2PL+kmOgjCd/SuhDuq9wBVGf88fFeVB
         tm0FembJC6BFKGsZXFYeRUrxvWMfHygOV2wd/juqowIpBIT/uEmm3LDSafD7kbp6zmgE
         WjrA7/MNaEMcpazSlqqZHe1KDsyPX2KGjikhMaGFcjmjAAqC8WyU7S5LC1SFcTNeepKo
         tW7jbVOWeS3CoE7ahM5Gw8MnqIFpFeppoR3jQrka3qvxKkGCmtV2krP5kLGeYugvh4w7
         XvNFCKWqK0ZHcFtr7L0OIAjCvnjBFzpZvyJ/NRryz9FWLzt34qXyeDhb9tLk9lJjChXY
         MGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540568; x=1784145368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WYqjG2FvDnDofNim76s28/lCt25fY1DfnzC9fP9Pe7U=;
        b=grSk3A1t0uolAUnp5G6bBrs0mw8y9o18Ib3a/hq83ToIDyScnQzD2nhez063qSVVpv
         aPmejmaESAdvgsh4nWC8u4lsdSr0JadU6y57zsPGy3rZp+3lapXFpGTgMjEAZ1OuvHeW
         EZaw3sSW4pHcn8nVyDR1s74kTH8Uc5VjK4BDUyI5qGhHVP/+dlnSdaf8PhZPcV6LUwej
         2B785c94vuRtsQb1Lt5DwlTI53Pnd6G4doDj9OSl8FCjQely2CJv3TiaV1on5cecPJrr
         VgD6l+9NNuj6Pnc7rJSsVKubF0bQweYMmAs5kL2TOVqAXx1UwRdid+RJD21X9wEn2m/d
         gOgw==
X-Gm-Message-State: AOJu0Yxd/6nvxe/rAZu8vkg5YL8HHN615V8xja6NwP6MT6mDigzKxtdV
	id++4ZszGulUaDSGEngelAOblK6rRR8Gt53q1i6sfi/VzIwFnKkJQMpo/Pl5aA==
X-Gm-Gg: AfdE7clohsW6a+YmTogNntUURcEUGyMq10NC6RD4mAayVdij9SHvsRQ2LFLlDgxNP/D
	KZRnvirs49GXg12PKQRE0U6qXH7TkpxfzeXocpoqxsemgaCn4MslPhWg/uw8fLEH1z1u8+ssLUK
	ARou/pNKQETavTF+UhSDQB38Ak2sCfMHtsC/hGr1n1s3xwAo5iFaGCVBlb8zxuK+qddj99ffSf5
	zmIZCJO7R4W919EfAvVOJErMygJKGyH5Gt46PRyWbkf5+Cn2x2shHS4ueG6avRabgy2epRhwDKU
	iwU1Iep0PwmTsHHe772WHiVi59iRta+T1iHdZtLfrw+aevlvf6jqyFHrP+jL0MllxhWfsfxYg2A
	g/2NfRhwk6LWko/JGAaw4C2sAuMvicxbdiqLd3CEMA7jmwGalaaUkYuAXkWIRbYs8fLcwSfskOz
	DJxBa2XwMIKnh4O/xZUtRhAUGdqigFLz9UoZK7hA==
X-Received: by 2002:a05:600c:19d0:b0:493:cce0:3724 with SMTP id 5b1f17b1804b1-493e68aed4dmr35482795e9.4.1783540567952;
        Wed, 08 Jul 2026 12:56:07 -0700 (PDT)
Received: from localhost.localdomain ([2a10:4440:fff:d1a0:d438:d408:8c5e:d0ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3b85sm5485835e9.2.2026.07.08.12.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 12:56:07 -0700 (PDT)
From: Dierk Modrow <dierk.modrow@gmail.com>
To: iwd@lists.linux.dev
Cc: pmenzel@molgen.mpg.de,
	Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH v2 2/2] It fixes SEGV in station_roam_scan_notify when performing repeated roam scans at legacy roaming after a failed FT-handover due to a ft_auth-/ft_reassoc-timeout. The issue occurs with all WLAN drivers. We have seen the issue with SIEMENS SCALANCE W700 AX APs, but it may also occur with other AP brands supporting FT-handover.
Date: Wed,  8 Jul 2026 21:55:50 +0200
Message-ID: <20260708195550.165-2-dierk.modrow@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260708195550.165-1-dierk.modrow@gmail.com>
References: <20260708195550.165-1-dierk.modrow@gmail.com>
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
2.49.0.windows.1

