Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C43FB8B
	for <iwd@lists.linux.dev>; Fri,  6 Sep 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649522; cv=none; b=SMekbz3IVR2x9AdqAf207cZcm6gQVslF/Zo2iA7X3zlAHEiAfzCyDdi3zky/AdzczkyUsis+Oqhv2JPhIWqdBEzXcNk1Obec22cRMGLkycdocfH+hQugw0N+4DNLjh1Mh5BARv0hwD3yjyzAL9BIhpLWDYCLjVzlzTp+JJvQQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649522; c=relaxed/simple;
	bh=VHPsuxI0kBm+dyg9Yv8051CLlBBidCVZpVvgdHB+ZnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYDPpVvJ++VYekwXsb5+0XNryGVBTEE3DQvcQORM+58Q/2IMdyKDdbNQK6ixAvG4L9Rt3yD2BtxOJqCDDDFgVuOpYP838H6y8T55AEaEardvaDoalkYJ+9CSUGj5nBTb2LVvX4DscAzkiT1+KK37Hgs3ezFrSx6JaXJsWv7NWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh3q4J4X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh3q4J4X"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2068acc8b98so22475785ad.3
        for <iwd@lists.linux.dev>; Fri, 06 Sep 2024 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725649520; x=1726254320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AOBoKjN1onfAMV4CCLLkVQ+aeGk3/rLe9nsAUQ6cy0A=;
        b=hh3q4J4Xws5zS6LzZ05ypYnYv/MuQDlTkh8YV4B0ME7XIkiEFAgjLD6Rl79CbUc2Tg
         TBIpVVwlryxLKc7pQuuiO0QJFI+ERRhsJAkzxSOXAXfn1KUOaI3KTAQAx2zqrTL3QlV7
         sQqIznzf8Tof9ruhUBxbRarphvmUV+J2UomDT5orSIbVH2QGeqnQ+uzGzvgiPbUcEG/h
         r/nLzdAobw5q4v/rBbLAeWe0kZiiLVWMHD/bN7Zd7YTyvKbnwJ2Cz8j+bUG84BKhFgOE
         Dc5hGXba4aWc+iXvMi5pmh5UspL0tbYx4JZa6A7c5FEHHoARYkJHbjCvspIG4sPs3/qf
         Z1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725649520; x=1726254320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOBoKjN1onfAMV4CCLLkVQ+aeGk3/rLe9nsAUQ6cy0A=;
        b=QLo6P5XH2QL6xjRhZ5fONyMuMPH3whKW+F4tb2VE1O45vxaw6Y6e9mrxMt+kQlIuaS
         cBJK+DcHhzAc5cO+gDY476yTZ/OZHo9N+jPZpRnKrEVmPjdP3BisXD/XU+7pqir85HdP
         ae1Igc3Fi1rBIVS2iyL/1+IhQXuUIaLTj3uN9k3h4zMJEIjVSeGTvgn5YbUCT1jNJBJf
         4izu5Sps4G4iYClQdSHeV3c9Uaz7wp/1laAUwfP+AmEvIjm1L1W+Hh5+a1gSsHFL/YfZ
         lb6662pdc1zlU7fScn4t5X9lKLDl9XoI11x7j4ls5A43K9sRuK/VRAbMFXKc0nQf0U30
         2zdg==
X-Gm-Message-State: AOJu0YyOJqIU8VwEWZc14APR3DPzoHTcWnKFYtwX1Q67WlfOa/7wBDll
	PdM78eA+2T7GWsMmPoQbPSsleZUcKae2YuE7YWAa3ataQckshGVNiyV13w==
X-Google-Smtp-Source: AGHT+IE3SvlP6EAy7he8Mfj62cJOTRlUh8o6YBfPWiWeFt4sQwKW+BriQ/bdnDe+r4OeKaJq63hUYQ==
X-Received: by 2002:a17:903:283:b0:206:94f5:c2e6 with SMTP id d9443c01a7336-2070c074abbmr2393635ad.7.1725649520132;
        Fri, 06 Sep 2024 12:05:20 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea384cbsm46454115ad.170.2024.09.06.12.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:05:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] dpp: set cap on the PKEX timeout, and reduce once PKEX finishes
Date: Fri,  6 Sep 2024 12:05:14 -0700
Message-Id: <20240906190514.620603-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we scan a huge number of frequencies the PKEX timeout can get
rather large. This was overlooked in a prior patch who's intent
was to reduce the PKEX time, but in these cases it increased it.
Now the timeout will be capped at 2 minutes, but will still be
as low as 10 seconds for a single frequency.

In addition there was no timer reset once PKEX was completed.
This could cause excessive waits if, for example, the peer left
the channel mid-authentication. IWD would just wait until the
long PKEX timeout to eventually reset DPP. Once PKEX completes
we can assume that this peer will complete authentication quickly
and if not, we can fail.
---
 src/dpp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 6f2d45c2..03e2a7a6 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -2831,6 +2831,12 @@ static bool dpp_pkex_start_authentication(struct dpp_sm *dpp)
 
 	dpp_property_changed_notify(dpp);
 
+	/*
+	 * No longer waiting for an arbitrary peer to respond, reduce the
+	 * timeout now that we are proceeding to authentication
+	 */
+	dpp_reset_protocol_timer(dpp, DPP_AUTH_PROTO_TIMEOUT);
+
 	if (dpp->role == DPP_CAPABILITY_ENROLLEE) {
 		dpp->new_freq = dpp->current_freq;
 
@@ -4283,10 +4289,11 @@ static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
 
 static void __dpp_pkex_start_enrollee(struct dpp_sm *dpp)
 {
+	uint32_t timeout = minsize(DPP_PKEX_PROTO_TIMEOUT,
+			dpp->freqs_len * DPP_PKEX_PROTO_PER_FREQ_TIMEOUT);
 	dpp->current_freq = dpp->freqs[0];
 
-	dpp_reset_protocol_timer(dpp,
-			dpp->freqs_len * DPP_PKEX_PROTO_PER_FREQ_TIMEOUT);
+	dpp_reset_protocol_timer(dpp, timeout);
 
 	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
 
-- 
2.34.1

