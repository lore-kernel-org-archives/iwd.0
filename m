Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC682874EF
	for <iwd@lists.linux.dev>; Mon, 19 May 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672597; cv=none; b=X+RbeMQ+xwQ5QWYgYurKQJ2GhS0DUXxH4DTXPB8K+gDMwFNkT5DkCVy7gAijFlnlHxw1/Nkid2vRT0e/7O3KSmDdefW9z3T5aVPA1p/kkMdaU2ugp0B7O7stutl5Ck7qzyyQTGNdtRa2lAPVmNsqWa6baoS0M3rhItcF6w/NZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672597; c=relaxed/simple;
	bh=GbJS97+OJnMzrQaa6m4nAdsQjXqnhpJAcHfOSWReHXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqxU22dyOgm0T18T77mNuHNdHRJSLVOscYRug39H/cvcUmxuds1HxxVx6DcAMg3RBpBdVOZiAhwVmEP0FxdroA10xv6D3XtcjzWLAKRssW1xE/ev7HYhCifETHiw3lr5+DzjV7iWSW7aM+E8yxpS6PvVykewy5W7bIIk0a+ayY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJZbajCs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJZbajCs"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74267c68c11so4174705b3a.0
        for <iwd@lists.linux.dev>; Mon, 19 May 2025 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747672595; x=1748277395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR/twYQdER9wlA5/YU6pj4L6WnYAFt3FNuWyLNollG0=;
        b=nJZbajCs66qSdvIubndMpFfm2U1y+oYbGSeVfDI+duXJka5iyXqSrWxSzG4+4uF/AB
         xmjCzhwUD7mVqKJ8bDyMgdr0mMBbtAx5DJoKYRh+2TI3xxZOr8pj20QQfQnJKKEBrlSJ
         0qb7hm/qF8dnf5lu0lBO8MST2Eonp3hb/v/r2o/Nj7PVz8+fabhDZBN0Vqd3BVv3oeqw
         8NilfKbdv+Sqchxh624DuROpJcPhfMJJ8JuDS7PMCyl0wfLQNI2Da3aB8Km9XynAMW8/
         sUVxqWZET9SVV0YEFBUB6ROFk0neEFAkmbxA3zv8HsaakyvlqCM2n/qUDxRZU+YMZ6Jb
         59Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672595; x=1748277395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UR/twYQdER9wlA5/YU6pj4L6WnYAFt3FNuWyLNollG0=;
        b=YRwvUQpQp6HwGdTxbIYJO1Z9yALoOGWA6U9swWTpVGnIJye8ma9QSz84oGctSrpHBD
         L8RjKPcyDfbr5aGJX6wl6IsdVTEU280fyLVGddaFdd1ecFiSwGLS8J4h5RrdIasOU1LE
         n3R584drn8cJh8mwuzegM3AVN0OlIVTbIu8HopFDwLbZg675o3Urgazg4fsttVcVMkd2
         bYEP0OR6GF2H4pVaIS3aC5/H3fHJE3zyDBU8dJjl/LI5nh6xM+XUWY8CCBNte8IrcuQ4
         HW9v43GLlFNXNdpklnEiBJ+Sd2tmxR2y9+slKwRr5aY9vZ2nvD7dcG+eJ3srgVnhfbXH
         /FcA==
X-Gm-Message-State: AOJu0YwxjLE747wnWfiBCGJuCVXhjRdigJ7Eo7DipC4owd5t4agWGCty
	lI+4WuuA0Hi9OxVlGilkxtHzXQpfjHyU3fab3X4CmF2bDjbLzg3ZsbzxClGIWw==
X-Gm-Gg: ASbGnctwO8SzzTATRKtCYGaGy1VQZml6Sr2j9gwaWo5I7EUWmSvWz+xqj7Wjk7gRQcC
	fjiZaIlYy+h1ep5/tvznA4likQcXnnhH1NYkiZDVokrw4m1pHl0gDPYVcqpb4zqBSIEHXBrWw5o
	mBIGDotvR9OEugJ+XaD5wvVen6jN6SQfAayKB9Wy1n45Kc/5rjgFRAo5MoixdRMfDuBrzRJbo/8
	pv2omH+cQvANKHNpIluoOCkhtR+yirCTq6Lh+RI1pKov1vyvoBP8p0u46lMo8dyyXid1PFlx9Q0
	h4WTK4iHK57iQ6Dffl9JYr4dXpEh+5y+aUpNiErD409mkxLNK6XY8mTLEPKL9IxgORaEGKyBVaX
	eh1NHCinikg==
X-Google-Smtp-Source: AGHT+IHo3MsvvcXEuyuj7qmm9cDfVnuxWl4X8LXA5fb4lsUIwgj1qXGFpJ2b277BqHeBf393QtpGiw==
X-Received: by 2002:a05:6a21:3a89:b0:20a:4698:9d3 with SMTP id adf61e73a8af0-2170cafa323mr19066029637.8.1747672595027;
        Mon, 19 May 2025 09:36:35 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970bae4sm6401731b3a.43.2025.05.19.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:36:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: use renamed InitialAccessPointBusyTimeout
Date: Mon, 19 May 2025 09:36:24 -0700
Message-Id: <20250519163624.198865-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519163624.198865-1-prestwoj@gmail.com>
References: <20250519163624.198865-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testAPRoam/main.conf.roaming | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testAPRoam/main.conf.roaming b/autotests/testAPRoam/main.conf.roaming
index 1ff23571..49a74685 100644
--- a/autotests/testAPRoam/main.conf.roaming
+++ b/autotests/testAPRoam/main.conf.roaming
@@ -3,4 +3,4 @@ RoamThreshold=-72
 CriticalRoamThreshold=-72
 
 [Blacklist]
-InitialRoamRequestedTimeout=20
+InitialAccessPointBusyTimeout=20
-- 
2.34.1

