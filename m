Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275613469F4
	for <iwd@lists.linux.dev>; Fri,  3 Apr 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238651; cv=none; b=IM7lIeiKofcDzznP9S/MmACdOR175mFpt8MOAqmczNh/HfzAudW4lbYSuDTmqCLJEpMpGW+78+K0ULmLLn3P+hyMiDdFwIKM5biWCW4D/newdkX1BXApbLvLzRr8iSTRt2MkaqDG6U+4f/bQD5xCtaTF/AI5v/jI+7IGf5UgVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238651; c=relaxed/simple;
	bh=lY5hpJazlHIuZngs45Qugm1V+fInwlPiz4qgxR5gCBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fh9BrZ5rbtsW0UUva1OK/8VOHs1dUxwDglsTDMkxo+gvmnxE0biM3zl2rJaVBzIaKZjbAzNBmG0o9YefqFKbAiZZ4+ilv0T0yr1gvKKXp8TnSd7QNoAFWG4JAdyRJusPfTo+Rve5na9HDYThXg3iAo7Can7lxOxcDczAejYt2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeremyblum.com; spf=pass smtp.mailfrom=jeremyblum.com; dkim=pass (2048-bit key) header.d=jeremyblum-com.20251104.gappssmtp.com header.i=@jeremyblum-com.20251104.gappssmtp.com header.b=OcKPvUDN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeremyblum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jeremyblum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jeremyblum-com.20251104.gappssmtp.com header.i=@jeremyblum-com.20251104.gappssmtp.com header.b="OcKPvUDN"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b2b2aa276so20253391cf.3
        for <iwd@lists.linux.dev>; Fri, 03 Apr 2026 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremyblum-com.20251104.gappssmtp.com; s=20251104; t=1775238648; x=1775843448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBm6fTOctHbp8/LDRrkoukq+/S34DDnja2sBkieCWoA=;
        b=OcKPvUDNcXAL6pl2HK+bwhJT4ncJLe5MSMnP+cvO62DDejt4cGLd585h0a+WKpbVPj
         LbIsgCDzmuscyTm6bbwgGP0FUGqiL+2lzFa9O/wcyiwbOiIXkZfcpuuYT4/NTiiiZm04
         oFxoQAp170hHmssYmgvSR5DJ9DG2uFqWejtcfuUoUiFMTrz+fEOE4FjMJ+cNqEe9d/fj
         ATfu+7GoLpS4o1BCciVCqReyAjonpe5WsTTe96MMC6M633nQIEPQgTz1CkiuxXZAsFbF
         sG00BjdG2oEM54cwbW2wCwSkSj2KYmWtN4rF8cMwGAYfUs7tFEFucb/1L6pYZXuiXfT0
         tQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775238648; x=1775843448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBm6fTOctHbp8/LDRrkoukq+/S34DDnja2sBkieCWoA=;
        b=HDO1VwKGgFEgaki09kHGEHzJOVC632vk1cr5i5CnT75IZUkCPujuzeATVvJMEDxm7V
         hhu8/JNlKB25WsPrAd9kLIjKyNUIGUddElDEOaBbXK/Hfek+Ju/pQHnl9bIJ6XWfNNgq
         B2/CAlWzmcM2mQnt0gGVfaIju2NfOaMLBcfuEV/mCXnfFhg972+5T33LfHA6IAOS2Edh
         OhCC+XoeiXpxm08JIZulzzD6BXLpBXthubTYZGXb+XNC8+0nQU0+MaWLfMHlIp6f3g4Q
         RwyYJZo5dUY100jkfcLlB6QL6qizxsEXgzDoALhVsVLG43a7++YxhujP0Q0qFoiRHtyj
         03Ow==
X-Gm-Message-State: AOJu0Yztez6tfhWzi3DvecFXIY+zrWzQpH8IcibRvvmnWt/AMcknT4OR
	NgXmy/Imu0wPUOy1caHYGOKD8oKN4v9JVGYVTMCYMq+RgHsiFgLnzkmQTj7//DItmqI78iYkkm3
	OjCmG
X-Gm-Gg: ATEYQzzvnoWGVeDOo9Yu3sNbawTPP884I5mlYhUD9ITT6rr8kE9gWQ8RN5onczLQZm4
	0Kl0XBwbRGq5v/GTZ+/HEiFVb3BMBZ67YuGuWcXgpK3IucmVHu86uSlfyt/UF74a8A/NFafl4Zz
	sZDES9zOK5z5fduhvpYW+Mwq0/0rLCktNLt2jyfS3/qE+0GoLBbsqOUGGXqEOOgzNd3x1fnvEV3
	wruFUEX0VeMBzmM4ZYFtF+rKYxTVU42Ne0szpOzUIn1q8h/atIr7VPUy9oxGeZ9oW0dEEW+Ued8
	QhsFVhKeN/VDPyVwk6LawCVuUZGvzoNFiQORq1J2tJKI2CGBcYkgmbIOTGweVA5Hd2yJ3wO4XMc
	2sVCONJjJGgn1a4xSPlTAI//f+IiZRpjBFvu7q7aXXpKpAlbLeJk26iziTXeKvXpgEP63lcci09
	WEQ0ZFs+Yv7uBnY4bM+nbjKILZ4w1piVE4xBJn3bXVX1uB/RmVRK7+BQ==
X-Received: by 2002:a05:622a:98d:b0:509:1220:dc21 with SMTP id d75a77b69052e-50d62b32e4emr52950061cf.55.1775238647944;
        Fri, 03 Apr 2026 10:50:47 -0700 (PDT)
Received: from localhost.localdomain ([50.219.109.230])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b32b59csm61258221cf.13.2026.04.03.10.50.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 10:50:46 -0700 (PDT)
From: Jeremy Blum <jeremy@jeremyblum.com>
To: iwd@lists.linux.dev
Cc: denkenz@gmail.com,
	prestwoj@gmail.com,
	marcel@holtmann.org,
	Jeremy Blum <jeremy@jeremyblum.com>
Subject: [PATCH] netdev: use SAE PWE both for fullmac external auth
Date: Fri,  3 Apr 2026 10:50:38 -0700
Message-ID: <20260403175038.4533-1-jeremy@jeremyblum.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For fullmac external SAE, iwd currently forces Hunt-and-Peck and does
not include NL80211_ATTR_SAE_PWE in the connect request.

This prevents successful association with H2E-capable APs on at least
some fullmac drivers, since userspace is effectively constraining SAE
to Hunt-and-Peck while not advertising the intended SAE PWE policy to
nl80211.

For fullmac SAE connections without PMKSA reuse, request
NL80211_SAE_PWE_BOTH and stop forcing Hunt-and-Peck on the SAE state
machine. This keeps the fullmac external-auth path aligned with the
actual SAE policy instead of hard-wiring HnP.

Tested on a CYW43455/brcmfmac fullmac device using firmware 7.45.286,
where this change fixes WPA3 association and traffic on H2E-capable APs.

Signed-off-by: Jeremy Blum <jeremy@jeremyblum.com>
---
 src/netdev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index e639a1f8..94520b5c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2600,6 +2600,11 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) && !hs->have_pmksa ?
 					NL80211_AUTHTYPE_SAE :
 					NL80211_AUTHTYPE_OPEN_SYSTEM;
+	uint8_t sae_pwe = nhs->type == CONNECTION_TYPE_FULLMAC &&
+				IE_AKM_IS_SAE(hs->akm_suite) &&
+				!hs->have_pmksa ?
+				NL80211_SAE_PWE_BOTH :
+				NL80211_SAE_PWE_UNSPECIFIED;
 	enum mpdu_management_subtype subtype = prev_bssid ?
 				MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST :
 				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST;
@@ -2618,6 +2623,8 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
+	if (sae_pwe != NL80211_SAE_PWE_UNSPECIFIED)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PWE, 1, &sae_pwe);
 
 	switch (nhs->type) {
 	case CONNECTION_TYPE_SOFTMAC:
@@ -4218,7 +4225,6 @@ static void netdev_connect_common(struct netdev *netdev,
 					netdev_external_auth_sae_tx_associate,
 					netdev);
 		sae_sm_force_default_group(netdev->ap);
-		sae_sm_force_hunt_and_peck(netdev->ap);
 	}
 
 	if (sae_sm_is_h2e(netdev->ap)) {

base-commit: d003d0e593323b3de427f01284ede81ba61e9dcc
-- 
2.50.1 (Apple Git-155)

