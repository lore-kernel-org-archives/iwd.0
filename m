Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6F1E766F
	for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377449; cv=none; b=DCs2maduP3UAcS6rKYShfVOq9ESawzvrYh9obGPjyw+zQTYMXUrUNTVff40geIwJNEAhIpWxOtSZJ2zmB/hxdM1x7YHssk3AZtJAn/pyC6lX0ugT/uf2v07Tcu0zulYsA4JCmKd0yDgU/lrcsAdilMKeeWcn9FtyvWtUaFb5ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377449; c=relaxed/simple;
	bh=ID9NGlLmnJfefIeoO+siNY6YJBUO3b0ne/IaoNiPTmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dX8PvGCxVf84d9OTSqiqptEAyJJmD14CxVzIz4gYILp3phjgiZaEkCGRo3YjrwvILz7zuAj+UtrH17FYHdAHPd5xfL2AYbQpn6We0RBlZ16mLbBKaz89QL5fU5HwqlgUnHCXCfA7OJwFKADcNGLmUgglRPSsSuvDl5i02OgOfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK7aoJ4b; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK7aoJ4b"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c05c22d32aso606396785a.2
        for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739377447; x=1739982247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jfXpqtX04gW7LLMXWIzuwjmICydD240aw/dxDK31JJA=;
        b=IK7aoJ4bYyOHXNLui8cxk4kwMNrdO2B43/sqswsbrTYl37kKfr2G6PdtpZVJZaxBOU
         DFFc5tCMd1JPQLsopcYMoez8ngDT++1KNJWl6RAcpY4w48WROwcEVZwxBZL1yIdSw1+1
         UnAL/tYS8xujYOspIRgzEm+1FIAMKPMiGOl5gAdGkKunA+1ZICL240dcgFGGtN5A/f6F
         J22AHcKB65Rp3G3QXvAWc5zfyKJn5VeifLuCDs8cm3rY12WB5SPMC5SLBef756wD7LXY
         WjaT6iTN0IB7vVK+l0RFUERBLWfQrgtcVlt/iC9Ci850NdyDDPAdPTtjxc5hO7Bl4tjV
         IfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377447; x=1739982247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfXpqtX04gW7LLMXWIzuwjmICydD240aw/dxDK31JJA=;
        b=oSrLDwIpHVvo4wQBeCz25X3GlWjSZ56bZirxZrpuFqU6K1uh/qVaM4/qCbaCGb23kI
         hECR6cJY1phSDxfcWv0qcMqDhNLz8NVWKQGvMTEDceS1BumVkLbhMezy0NhFkHysAX0a
         70E8Q8/cDBos0poILQ12fLCB9nZ/5uL7atj7PlyUKpLJ18c4F2Bswod9vtLdcpnSCVOM
         DI+ng0fVLmDMgc7lD/hQPYHzWn7cmfxnpv4RbFDjuQUquO5FQnhFQ5gSWJ6DSN5hE2Kd
         mEZv7QvKsyC+fotRCLsgZ8c5Fz5WoiAcNh7jTTB9LbNbx+jaa/1ICx/WIa7kob9gWT8Z
         1JTA==
X-Gm-Message-State: AOJu0YxpQfvXVQSfc5j/OiB6kPjxFAHf3DH7e32uwPgAOcZc0BHAeHnS
	Q3UON2KOwRmoL9BLYG154B3hxs0Bs5lA+f82YoxsJHKrCiFw7/Gdz2ePIg==
X-Gm-Gg: ASbGnctk03Grgud50h0k0odsICAYPyivE5Vk6peec/fqT317fWU1oxuMc+gnE8vBBNt
	yzM1kFcT2P7xu4nI+ibRPS13bJwTXZ4dHpganLm0jZrGQ/svFZKz/oSBhwVDUGlKlmUg8BswrcE
	qWEBx5K130stpH9OSqQIjDVlq8SYoRWKx7EILSuyv65X+Z98V3isqC/n7+csjNuiZnGd0szU+Oi
	b6IQOoJTA/ChrcKx/aze9+dwR2Payt+eWJQk+5nqyfABWjLD5dyR7EP2TKpSA1Vqa9WkAlW9Ywo
	d/kOvcmYyDMOf7ZF8VT1Rhk+7geqLN4S7CreXEjdb1F2OeEDJw==
X-Google-Smtp-Source: AGHT+IE9SMJSzGJgLRlr3jA6Nzeg5ZBl3NCXbt4Fnr50hGCw19s5Yj6+WEpa1qz1rBAXVyRF6VuyiA==
X-Received: by 2002:a05:620a:45aa:b0:7af:c60b:5acf with SMTP id af79cd13be357-7c07a112c25mr3369085a.10.1739377445250;
        Wed, 12 Feb 2025 08:24:05 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0768e23casm73272685a.44.2025.02.12.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:24:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/4] PMKSA support for fullmac drivers
Date: Wed, 12 Feb 2025 08:23:57 -0800
Message-Id: <20250212162401.130792-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set removes the need for the prior patch on the list:
[RFC] netdev: avoid PMKSA for fullmac drivers

And instead implementes proper support for PMKSA as opposed to
disabling it.

James Prestwood (4):
  netdev: don't set CQM thresholds for fullmac cards
  netdev: remove/update some iwd_notice logs
  netdev: implement PMKSA for fullmac drivers
  station: use netdev_remove_pmksa

 src/netdev.c  | 88 ++++++++++++++++++++++++++++++++++++++++++++++-----
 src/netdev.h  |  2 ++
 src/station.c |  2 +-
 3 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.34.1

