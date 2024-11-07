Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF8212647
	for <iwd@lists.linux.dev>; Thu,  7 Nov 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985980; cv=none; b=T8uzekDrqIxtq6GNt2wyGP4oI8JAFeCM7agZ01Uf0xZtfksz7VG8TnKnz8FromcLth0a8zF7fvLQM1Z9jEm3IulaqYR+OTD0KIurFBcdZcbKN98dwVH3LUCB1EST8qpL5VeXI/FRvRNtM/6tpV5+OZo3Q4safiEY4xiVQXjCXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985980; c=relaxed/simple;
	bh=jeUFyaNOLZWWpbe7pW5Adk2yd51FUiv1E1QpMn2+OAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8zGymu+GnW2szhZOo9hlaZbv1jPkkNArWwREu45lNi1aiyUbdgiWTh5RCCKVSUrI9bTqDwLEnVajDXLSXEoH3xXGbgceWZiSUoogHFm9avttJDcq9pjUCVfov8h90uDiIEeFRjL0O36i8j9zGE40Yb/3247HgANdJH5FCmtMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldFBDBpF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldFBDBpF"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so695256b3a.2
        for <iwd@lists.linux.dev>; Thu, 07 Nov 2024 05:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985978; x=1731590778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AaSelimVWx2SSW133FcKhog1lnOLdJzmNA+QsvYKvM=;
        b=ldFBDBpFqCfMBwgVREuNOmZveE0SmB4jZEEpRvLe+cPZWJOzr5IHWYw4CO3i2hhA32
         f5ry5dZmlVzbB2FurtjFxTGWBlUCgNVvTik9tG+FjN7FaZOwPiQ6YAANmUXFtUR8X4lb
         jjDwVp0VAkxmu3SGFq6LnvebIIbvU6LHSexuT/jflBI2abH9dYOf3hDa3rylfleypTkL
         DwvueG3krlo2tOoocQ02oRGDXY/Gk2/MF4Rj+Jajsk4Opr2o9YTxHtqo2DfVSKA6y4MI
         IKYawXGTLIo5GE+ZYaF7jnfDASTKHqeUDw8aUbDrbXDZuLKzWxQDSgtZrLmk3GEUKToN
         pj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985978; x=1731590778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AaSelimVWx2SSW133FcKhog1lnOLdJzmNA+QsvYKvM=;
        b=HHLnk/mOwnvnupPWg9R4RcdrEWgftJldwD7wQvuCeo7yX500fDjPJiU++F2X4+kXnv
         LirTin2Otdgdf/6noUhQAZO0EYATTswtlzDOHV7AGSEV4+p3KkhsfW6fqYaMPi4Sf3F4
         ujVplkHs8arT/Ve9otKNcq7LweI0wsehmieWNScHWtdLHY4BlxGR+MzL2KcGI/69RBox
         NSn9Qv92JmnxhUii4ceMgzETjjs4GZX7t4Wy/2A8POipqT+pQJBvYYDSw06OjKJ01n+Q
         DOFWChxmssHdw+fiNnLbZLjf0b34nPeM/HXR/jfW9oSt9I2ohJC6ZpPFqCVJoMLZiqOY
         OjjQ==
X-Gm-Message-State: AOJu0YwfHCZisqEfEYDa7JzaMHPd2JiL3+7FJM70b3LYJrsbs3brN0Uq
	ncXq11s9+IKEWtgklSIffjbO+AMe19SuEaDE5PYA6GIGzpZZLjNvAnGPwQ==
X-Google-Smtp-Source: AGHT+IGnkUZbmHKU3xd61QF/x/fmq2voqP+kmsn8N2XLTTv3dNGE3gLBn/Y+B/aLo3BcWopZown1Og==
X-Received: by 2002:a05:6a00:992:b0:71e:7ab6:8ea6 with SMTP id d2e1a72fcca58-72063093c2amr58317464b3a.25.1730985977733;
        Thu, 07 Nov 2024 05:26:17 -0800 (PST)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644036sm1344385a12.66.2024.11.07.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:26:17 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] general: add .codespellrc file
Date: Thu,  7 Nov 2024 05:26:13 -0800
Message-Id: <20241107132613.1463237-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107132613.1463237-1-prestwoj@gmail.com>
References: <20241107132613.1463237-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is what was used to get clean output from codespell. Common
words/abbreviations and exclusion were added that come up in the
code base.
---
 .codespellrc | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 .codespellrc

diff --git a/.codespellrc b/.codespellrc
new file mode 100644
index 00000000..49586988
--- /dev/null
+++ b/.codespellrc
@@ -0,0 +1,3 @@
+[codespell]
+ignore-words-list = fils, FILS, SME, assertIn, OCE, clen, aci, ELL, sav, ths
+skip = build-aux, linux, autom4te.cache, aclocal.m4, AUTHORS, libtool, configure*, *.5, ell
-- 
2.34.1

