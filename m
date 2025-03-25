Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7E2641DB
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925670; cv=none; b=CnRBx3dNWl8StoOWsUj0Nhr3TSEG04NMVqDYW7iJuldbVHi00lmv5GdSxZlq35RxYk35/h9icfZdh6lo4LwQMC2QaZgfkjXDyeNBrdfGw/cQXjFtfZ4E7MkVeTHvuHqU4LE2ly3f31JlGVPmV3mDDqdV81Ol5XZV8AfWtNS+sGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925670; c=relaxed/simple;
	bh=MyM83L1eBpowQ6pWl7EN/W4VKQ1GrBqt0uY75TwPUAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLn843Ti3YErigbDM4gJ42CGWFIA8Xi04rVSA924vE2j/nxQ8PD8fYZzM5gAoUrffqEslrPwjxUQwQnlGJJQBcSQd6kAg8u9PhgMS0+rqJZLDtNztrDkO6op7FHc2GNmDJK/rbX2cJR9KPeR+BPlZfsUFtj7D/wKOGugui/BkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cf/cCZlZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf/cCZlZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso10125703a91.3
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925668; x=1743530468; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccTKIiVTHaYhZLj8hvKA0e5OsXRQ+klutkUMg9gJHMU=;
        b=cf/cCZlZsNeT/bmJhgUZNLZIUri2E10q911zODQHKniLGkmK9996mkFTnrUdJ0B9Jc
         ehCX2lJPdsuhqi9MXs8IAM0oaqOytDrWm28ulBHHZRT4m7hDJCGv8UH+Al2vRDRIZUjV
         R0MU6zy9olfyKV1l4ZMAk/xskGTq6WK5VjSZejmdlmh/ObpoGGerlrpTZsC/YBgcQNk1
         06lne3B70C5nuWCnIGah4XHZlDwzPl/qQqiyyhvUcl7ob5bBDmu9PGI9l3P3gRGA7F81
         qIuV25u/kHmLOqVD4fJrwB9qrT9oLib4508uKmb1FT8dmx2+Zg9vY3IoN8gkBP8RmajH
         BYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925668; x=1743530468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccTKIiVTHaYhZLj8hvKA0e5OsXRQ+klutkUMg9gJHMU=;
        b=Ld/MzwODdS2nMa+mw2OXvNyMd3MCs5fCxfoZ70/d4kZJBAIW/s3O8L6EfqAmoJrSgy
         E3JSTsvUht2xwwoOKDteMHlCdAu+b3fOptoeVxwSJWzGe4X6oeBAOopKU7Sj2IDiac2A
         Qv0za7IMI0YuwTrMJvrE20MQUjQhgm8E2h9F+YNq2AWz+tH2FozecGqlWspuqcbfyZNS
         dxTSmS5QB083wi5DQ1a1Ynxbr4ZUsf8Ga5lUYX9jZIuHBq2UVl3ulbfgoYvuePHwe1iD
         5DYlRXVfhsibV59qydqaCjgS+EfAcBk4/qWpAvHNUNJ554A0IdXaPkQGMU39jqAfXvwA
         tleQ==
X-Gm-Message-State: AOJu0Yxyp1QOmGyygpumDKD9irafHU+T2j6OkBuQO7GIkHI5RivbKdTm
	gvhnw+0S04jhDfuvPYakfi8i4NFg9vS/MYG9jMble5np6tIYb6XLWaHPmg==
X-Gm-Gg: ASbGncugVDrCUGq0VBVgJrDG1h7wt79wB8vv617flTIyJVSmR2aIQpjICTs6EJl1by0
	SdhOmKczWMkQA1o+qkmeKjtjFXnzQ7QPVvSeMdjT+NJn4TATRSisCd2IXsetrCarv/+FXt2mG6/
	y+EGNdvSIbOj+SVd7gfOOS2gqVxs0fqyxqmdUadV4V45AgCgqmp8vtBq5CKJx6u+d0JrwVPXe7s
	RSnmUZUhRzb6m/FpOzqrImGufF5LOB9ZeCcDAtSdFhFnZondnWO82S0ts09VWG5qSsxKt2Xz2mQ
	tvzuJTGbwPeL1Pgp5IstNoGqX68HH2gzBpK1iNBIbeJzBTznzU+QT4RH0ziT1OuKF+fqJlcTEuL
	UjKw=
X-Google-Smtp-Source: AGHT+IFhOEOs6yee9NaaTwg4pJy/Ch6kp6qeUKtz5fvSCt5oy3CQc9I2Ppui5rqI3pbAWYnQaWe8UA==
X-Received: by 2002:a17:90b:540b:b0:2ff:52e1:c49f with SMTP id 98e67ed59e1d1-3030fef7845mr23844282a91.26.1742925668255;
        Tue, 25 Mar 2025 11:01:08 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:01:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 10/10] doc: document InitialRoamRequestedTimeout
Date: Tue, 25 Mar 2025 11:00:41 -0700
Message-Id: <20250325180041.238676-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325180041.238676-1-prestwoj@gmail.com>
References: <20250325180041.238676-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 895a1012..9761e8fd 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -292,6 +292,12 @@ control how long a misbehaved BSS spends on the blacklist.
 
        The initial time that a BSS spends on the blacklist. Setting this to zero
        will disable blacklisting functionality in IWD.
+   * - InitialRoamRequestedTimeout
+     - Values: uint64 value in seconds (default: **30**)
+
+       The initial time that a BSS will be marked after a BSS requests a roam.
+       This is to aid in avoiding roaming back to BSS's which are likely
+       overloaded. Setting this to zero will disabled this form of blacklisting.
    * - Multiplier
      - Values: unsigned int value greater than zero, in seconds
        (default: **30**)
-- 
2.34.1

