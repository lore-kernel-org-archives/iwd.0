Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50112E5D
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704020; cv=none; b=Zqg4sXqLXZQjAWLju9QKdVNNtWFbuPlp9lXzqAw7V4c9F50jv60aGJC/PwraT8lKVl02HhzYc8eeVTau2cMFznaEAUgn+mft4I4EdyXcBLzqL5V2yC/mRQaYmn/XeV9dw2fADVFDpmZaKXMBkwULFqBYk6wWkgSuWoHf4Wjwrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704020; c=relaxed/simple;
	bh=sPQxcd8jI0JgzeXjn8Pba5twbdYYSCaqwOiSEmoxPJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf8mm2FfbBVoaV1IQnoo9zLV2V0365OuuC5puvPtF/RVyLhro6zR0RfTrHPVJdGuv9uOkCpSenubqJN0HuESYsLM598O7uokHWcXQYZVZhXzfObzboZ3nmF1M6xqzzmvsBlhH9kOjI9x2aWCQ0dT3t3tbYJ9TNT1TK0iW5MI3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGS0saQx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGS0saQx"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecec796323so3644698b3a.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713704018; x=1714308818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLlVMSlAe4F5N1sLrJ8Ppth4eaMxLQpCenGNlzdR3FQ=;
        b=hGS0saQxv8wpR7M3TOq8GnHMZB40v4+DjE7eZMMxwM+Fi1JZBhFEcYp4UlJEiQD25C
         0UDnHK8dH/M9Wm39yIv6jPQktJPQFoOYq+t0G7bq1r4POeWTv9BLDrGpRGIHZLhhwdOC
         VfvKQ8xz9/jATCuyRzqWVb/udMQAcWx3ObUBtsYofGhRIafkGIdTsxwZpISMfzzGQioG
         Y6ggODCS9IeHhRI8OSb54vOUY70cvB1AKsZArxsznsQQUEGMG6kQYSozhuIy6U/LL7Af
         E4WDyI4HYjVxeMqsGEXdQMNsF84HoVdDw0XNNNT30D1VF6tzVsHW7ArwfGWdD/lPFih1
         UNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713704018; x=1714308818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLlVMSlAe4F5N1sLrJ8Ppth4eaMxLQpCenGNlzdR3FQ=;
        b=f36gON/P0L/86wHvXoZblNOMLAmL/Wf3czP0Qcx2xUSA0w2K1qkU/UVGRsxMj4siVz
         kZqJaWfiJOslfxxXj8u+XFGyMRG68SGo29vydrI4REhvFZKiyLFe5T1HQ2qjSgIj/+wN
         kzDLXTeEeeu/eE+YsAY6Rds1tEpkdefztz95lGleoOPEl6I6Q+MqrX3zSmZR8qMF0ZnV
         lclkuo9evg0q04NUhSu/eRjurPcyaPg10tpiuluoFdeZ8aLfjtxcVgO8qiBRgMIZH3lh
         B+dJQ1iHO7zrq14xmqMguGBKDVqUpZXjtRMQAYPvwntOMq2BSMmYSZE4w/6eEbFuuSlA
         bfhg==
X-Gm-Message-State: AOJu0YxeS81v7iFO89xWGOfUIgvgvNjzNhm5k6B08oLlYDmWzm4Sejxi
	A4JukuTQwM8oRQ04K/sZvd9yZydUSnAdFyCh3a3TYFIvXvfBpyqRme3kBdYwF6U=
X-Google-Smtp-Source: AGHT+IFtJmZ+JqXzyj5zMYTVtsy+L0Gcl37VEbNARCQ65UbGK+8FK3simP2vsHKXYZO+luCGwU66lQ==
X-Received: by 2002:a17:902:c944:b0:1e3:d8ae:df34 with SMTP id i4-20020a170902c94400b001e3d8aedf34mr10085792pla.11.1713704018022;
        Sun, 21 Apr 2024 05:53:38 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id ju24-20020a170903429800b001e3d8c237a2sm6279864plb.260.2024.04.21.05.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:53:37 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 05/11] sae: make sae_process_commit callable in AP mode
Date: Sun, 21 Apr 2024 05:50:35 -0700
Message-ID: <20240421125050.6649-6-brandtwjohn@gmail.com>
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

As an AP, the function sae_process_commit will pick the group offered by
the client. In a subsuquent commit the offered group will first be
verified before calling sae_process_commit. The AP will reply with a
Commit frame, calculate current keys, and move to the COMMITTED state.
---
 src/sae.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 314fc28f..2c97d94c 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -48,6 +48,8 @@ static bool debug;
 #define SAE_SYNC_MAX		3
 #define SAE_MAX_ASSOC_RETRY	3
 
+static bool sae_send_commit(struct sae_sm *sm, bool retry);
+
 #define sae_debug(fmat, ...) \
 ({	\
 	if (debug) \
@@ -797,8 +799,12 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
 					const uint8_t *frame, size_t len)
 {
 	uint8_t *ptr = (uint8_t *) frame;
-	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
+	unsigned int nbytes;
+
+	if (sm->handshake->authenticator && sae_set_group(sm, l_get_le16(frame)) < 0)
+		return -1;
 
+	nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
 	ptr += 2;
 
 	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
@@ -824,20 +830,22 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
 	 * it is evidence of a reflection attack) and the t0 (retransmission)
 	 * timer shall be set.
 	 */
-	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
-			l_ecc_points_are_equal(sm->p_element, sm->element)) {
-		l_warn("peer scalar or element matched own, discarding frame");
+	if ((sm->scalar && l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar)) ||
+			(sm->element && l_ecc_points_are_equal(sm->p_element, sm->element)))
 		return -ENOMSG;
-	}
 
 	sm->sc++;
 
-	sae_calculate_keys(sm);
-
-	if (!sae_send_confirm(sm))
-		return -EPROTO;
-
-	sm->state = SAE_STATE_CONFIRMED;
+	if (sm->handshake->authenticator) {
+		sae_send_commit(sm, false);
+		sae_calculate_keys(sm);
+		sm->state = SAE_STATE_COMMITTED;
+	} else {
+		sae_calculate_keys(sm);
+		if (!sae_send_confirm(sm))
+			return -EPROTO;
+		sm->state = SAE_STATE_CONFIRMED;
+	}
 
 	return 0;
 }
@@ -1008,7 +1016,7 @@ static int sae_verify_nothing(struct sae_sm *sm, uint16_t transaction,
 	/*
 	 * TODO: This does not handle the transition from NOTHING -> CONFIRMED
 	 * as this is only relevant to the AP or in Mesh mode which is not
-	 * yet supported.
+	 * yet fully supported.
 	 */
 	if (transaction != SAE_STATE_COMMITTED)
 		return -EBADMSG;
-- 
2.44.0

