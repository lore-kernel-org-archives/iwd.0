Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC017DE3B
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011881; cv=none; b=aidqj1pLPnQE2YBUoOrNn7sFGzfGQV96RwEJWykf6+pXS5oVPtkjOTk8grX3oZnG8Ay0rQsse6tquU+bCZifFKTk8ISvAaBY4bDhU5WnQ99IAPIuxkhsj0/FtEVCiq7Yl/SGVH4uq6Baz4YFFEEkpbxkpVv3tbqVz6yKH7pfW/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011881; c=relaxed/simple;
	bh=7zJusb69k140r21nHVW4UxozIWxBkc5LUReVwSFjqxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2GxMPC+cOIssEkVQFjVXpKK1QIXRCVPcqYCO337DXg1YUAqBAfT1r82euGbQtU4WJ+dxsUyScPRzFpFgfkRZqS06uNOVYfnWFqArodlbwWRNdu7p0sfpro8alGIq9+JV4Fm92rLvzDRjzc4NAGJhZIQLVg+ftl0oxvFIY1ezbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqlQk6Qy; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqlQk6Qy"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db14930a1aso764830b6e.3
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722011879; x=1722616679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvcG0Xm+bCBh7iuKYU4k3BgYlEk1+pMHhaLMzx/1EOs=;
        b=dqlQk6QycGjicaypwLbwdbijHRTRooldTic80lBJV14esZbWrThnGfthJLzLOeiUne
         jiPhiYAZRFVPS18e/iqLKf3KuxCbWntwzWfA36A0t2aMcXzX9cRGlhiLDqRt+B+90EgF
         UsdCZTXLLk2BlphYxFccUCCOH7S9Z8803eJxENhLV2X071DpPIcW10ogbOKtXYP86lzJ
         bw4ZLRFxRNHQAa8nSkq44mrRByvuFjzoFqlmOhqNsYuQLkV4O3a75J1Vo7Mg1FXNSfwW
         H5OcxC7qKYBPa2V1fLaBsrcBPTS6xUlBgwLZZHl41VkmZhyMoLPQaUskejXium4PF/Gt
         kliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011879; x=1722616679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvcG0Xm+bCBh7iuKYU4k3BgYlEk1+pMHhaLMzx/1EOs=;
        b=fs/eoj/BzdQmVquxkAnmVnz7z3vu0Tlx2B4hkt6x/XVysoEKYa+VQSLoG+ZcMEo0TI
         XV8LfPtitDIb3FKE8G+HdtR1mAsR4fuHMtgB+EM4qfA9o2iF5WzD8cRpyZldWub29s0g
         YjByaH2A6CJY6Btx0Y+raeLMaVlefsGSLdb91KbY1OndVlw6ouhXA34KqO5xn4uRGdmv
         u8V05IVRXAKJPkf2dCtHrx3D8lHghoKENOyjUPLissbYYPs7GGesgWLXjbHIippk7HW+
         jNlTKnHRH+WGUrSRQ5g8dd9q1INFi/ccYPy53GNONk/HArKS6uoqphzvuDLVV4YEcQvR
         Dlfw==
X-Gm-Message-State: AOJu0Yz0j+Tz6DGbbxtZAZEvKxYWP9FhH0/caUoVMunPC5A7gnFSFkUz
	DxFvWum6INLILHaFcDBr+7DHMPGqcedLiVaulBLJbmiHbVVgSGkoEdY1vA==
X-Google-Smtp-Source: AGHT+IF/gZSyKcTJ3JtKz9ZLa9mL9dSpN/YaI2Cv1brNWxhOUr8PccbkV1dz+Cd+16E6maSfCvr4Pw==
X-Received: by 2002:a05:6808:2185:b0:3d9:2920:bc2f with SMTP id 5614622812f47-3db238c0e08mr276075b6e.10.1722011878967;
        Fri, 26 Jul 2024 09:37:58 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81463easm14841081cf.26.2024.07.26.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 09:37:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: don't allow FT-over-Air without offchannel support
Date: Fri, 26 Jul 2024 09:37:51 -0700
Message-Id: <20240726163752.1651669-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726163752.1651669-1-prestwoj@gmail.com>
References: <20240726163752.1651669-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CMD_REMAIN_ON_CHANNEL isn't supported, don't allow FT-over-Air
---
 src/station.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index db069981..44f8d33c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2004,7 +2004,8 @@ static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
 				&station->roam_freqs);
 }
 
-static bool station_can_fast_transition(struct handshake_state *hs,
+static bool station_can_fast_transition(struct station *station,
+					struct handshake_state *hs,
 					struct scan_bss *bss)
 {
 	uint16_t mdid;
@@ -2032,6 +2033,16 @@ static bool station_can_fast_transition(struct handshake_state *hs,
 			return false;
 	}
 
+	/*
+	 * FT-over-Air in its current form relies on CMD_REMAIN_ON_CHANNEL. Some
+	 * drivers do not support this so only allow over-DS if this is the case
+	 */
+	if (!(hs->mde[4] & 1) &&
+			!wiphy_supports_cmd_offchannel(station->wiphy)) {
+		l_debug("FT-over-Air needs offchannel, using reassociation");
+		return false;
+	}
+
 	return true;
 }
 
@@ -2495,7 +2506,7 @@ static bool station_try_next_transition(struct station *station,
 	station->ap_directed_roaming = false;
 
 	/* Can we use Fast Transition? */
-	if (station_can_fast_transition(hs, bss) && !no_ft)
+	if (station_can_fast_transition(station, hs, bss) && !no_ft)
 		return station_fast_transition(station, bss);
 
 	/* Non-FT transition */
-- 
2.34.1

