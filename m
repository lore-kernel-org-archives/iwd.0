Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694E199931
	for <iwd@lists.linux.dev>; Mon, 19 May 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672594; cv=none; b=hIVMAhirphOG7t+9gJsdw26m8x/pzE83qhPdy0qYgeM4IdRwnTgvOJqt8VAvHCJMxUaOJvyXpeTSo5PyyBITBPXasA5QRufzqP2WdN3co+u1gmcgc6qWqcPs61aVtCZEWUKDk32K72/rkMHTfaxWo/MxNFRZkyhX2yaTZBFX4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672594; c=relaxed/simple;
	bh=uinAOSKkIwR/Ux8TVYb+SGGlN7e2KidXrBQXxzMATfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9tAN8oajVGSa87+gfO6Q4xQ/5imPjWwlmOdoqRw8P/MwH34xGCaDv28/HCPepWnEgz5lNJpUubKtpZQQm0Z4WHbJti80uZOcX7IwwJCBVjFLRRWNIBY0rzS7/s2YvmHieGExBn1uUaeGOOYJi1V2QTwVL2tAusbcvKIRKYmWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaeBDURP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaeBDURP"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399838db7fso4443256b3a.0
        for <iwd@lists.linux.dev>; Mon, 19 May 2025 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747672592; x=1748277392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXY+CSHMo5mMqElGYVKwZUi/+ko0HOSh380mNc+I/vM=;
        b=gaeBDURPC4Kuq3P7EqPa5SGPrNeer/2Wq4X43NNa6uqVt9W9tDBM8ae82+UQ85R+sf
         HFsCmxSedbtbJskLqS45Y6SDOJ5Orkk25xrvuVWdOM3b5gsoY1hPURvnGAM5pZkjjswc
         987qVfKoUbsuIAbIhJKy8O+1CHv2mYApyN2wvffCwDTWjEcsbWtwDtv6gjay6Jo3GlMQ
         UD7dVrfzYs6Duy8HRKDiO8X2Mjj1wW7COWeSOde77/KgLVQe5i/5bIUr6P6OtJ21ypU9
         eBN91/vV0UIJ+lxnMPO4h1R/abMWgVv8eXNswAvrmYE7R4kKLrHbLETZReSFhwVe2rnu
         2pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672592; x=1748277392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXY+CSHMo5mMqElGYVKwZUi/+ko0HOSh380mNc+I/vM=;
        b=ExboHoYOpbnFTgVUO/TAZzNVnfFF6rhTIQHr+c9RrdDmQmtbZB4CdyqaRMbrInbtwD
         55ghIWN0j11nyVJG0UcO5LbbAj6LvruiWFv663vg/hB1SsNNaut0iFMYLPce8N44L2R1
         mI1SBU/Gszw45ScnxWzcVRa/p77NjrIkGk1xFvnVhG5VgbEkjfAGZbKe4D9I45qltvy8
         hf2ggwQHhyaWT8B2dj4ujyRo2jnZjUow2s/dZGIP30DA23UjC135ImqYKUU0dGuw8GgK
         fopi3vT85T10KL7cUM+BbMfw9YbvgohphM7HrHefBZ+2WXkiB/RhCadlVqlzvIQE9v0e
         kytw==
X-Gm-Message-State: AOJu0YwTH6Qx0tZDSXgja7XAyoP+S+FRs12JSleErKZRloem9mC+1B/K
	o/bsBF20i/Nr4DtYUXiG3guKR9nZ0s4lmLO7vAB9OZ9jjlN7doNlw1swY9KQpg==
X-Gm-Gg: ASbGncvQ90pyNb2fE55CsUjzauunRLBoKtzWyKhZJv3A82vmCPoePdsH0/PyrCykL9I
	lqH+/swU2VWa+GRobHT9n2X9sAZssTcv6U6WuJI+37A/FN7bTqVLa2pkU3BJGPL5WKOQXZm4j99
	EIecvcIrMoog5GLxpR2f/bRXKVGkHmTBHBhdvkG5+hKuF68tm2BRKU/qQgMQX2cUK7WukV3N4UH
	3TLQ9UuQ9nRkKB3mmWwMeGgXyQhUa413ft8eM+Kf71aRvxh8JrKFiG+ruwMcBgkLA7YVusQ+wpx
	jtPheYMf5oBOjvpXLReXwz9Cgo8wAaiYn2uYeCalOMh3OrEYB3OVvttmAfppPuhWXrg/sPLHGBH
	bsUl5h2z9mQ==
X-Google-Smtp-Source: AGHT+IErFDBsrF9cM2vtO2cb28TejC2BIHM3Ph7L21o/ZCBsMAXv1z/DZZHd17i9USBdmTk32sGV0g==
X-Received: by 2002:a05:6a00:3406:b0:73d:fdd9:a55 with SMTP id d2e1a72fcca58-742a9afe7a8mr19650671b3a.8.1747672591703;
        Mon, 19 May 2025 09:36:31 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970bae4sm6401731b3a.43.2025.05.19.09.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:36:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] docs: replace/deprecate InitialRoamRequestedTimeout
Date: Mon, 19 May 2025 09:36:22 -0700
Message-Id: <20250519163624.198865-2-prestwoj@gmail.com>
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

This is being replaced by InitialAccessPointBusyTimeout but will
still be supported until full removal.
---
 src/iwd.config.rst | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 9761e8fd..b54670de 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -292,12 +292,22 @@ control how long a misbehaved BSS spends on the blacklist.
 
        The initial time that a BSS spends on the blacklist. Setting this to zero
        will disable blacklisting functionality in IWD.
-   * - InitialRoamRequestedTimeout
+   * - InitialRoamRequestedTimeout (**deprecated**)
      - Values: uint64 value in seconds (default: **30**)
 
-       The initial time that a BSS will be marked after a BSS requests a roam.
-       This is to aid in avoiding roaming back to BSS's which are likely
-       overloaded. Setting this to zero will disabled this form of blacklisting.
+       This setting is deprecated, please use
+       [Blacklist].InitialAccessPointBusyTimeout instead.
+   * - InitialAccessPointBusyTimeout
+     - Values: uint64 value in seconds (default: **30**)
+
+       The initial time that a BSS will be blacklisted after indicating it
+       cannot handle more connections. This is triggered by either a BSS
+       transition management request (telling IWD to roam elsewhere) or by a
+       denied authentication or association with the NO_MORE_STAS status code.
+
+       Once a BSS is blacklisted in this manor IWD will attempt to avoid it for
+       the configured amount of time.
+
    * - Multiplier
      - Values: unsigned int value greater than zero, in seconds
        (default: **30**)
-- 
2.34.1

