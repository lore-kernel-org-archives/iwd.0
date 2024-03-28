Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607BD7E118
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633651; cv=none; b=hGOVIlv0ELrFaRts8LsvBfdhw3rcxwP8s4uaIQ/0CX7VlAPBBTi1cO1eIDwaxsDL5deuV5SQftVxdJTu+Z5SQrTM6FqrtqrLXC/wM9Us3nMKH/BZrm6bsBKGNaG5YhX631WK1xnSls+XfqHz+aoVAFV4nKlFdoeuNhmQE4rloQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633651; c=relaxed/simple;
	bh=jgeUEzg2kaUgbJEfU4Qff6iM+sLQ4Ep0ug7ZdG2tQPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GEsr8j2Jp/OG+ETviq8+5ILSZE2DMovOChkW9D6ByDvfPEXAanmNR2BynkxWAqYbqaEBUdV5cLzeZgbe2yfKrZ/KfTJG2pFs19XP0NoGAzMAu5qcA5itIAGycgYoc/R9w7vIWaw/QVQ94dpQsvw/thDTW0M71dGwEQ5Kl5tBaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9wLGnXV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9wLGnXV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1def2a1aafaso7582925ad.3
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711633649; x=1712238449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6/LQEbj47XgO1NSTRnIcQMXt+T1PN8lsmLYGnxkXkg=;
        b=S9wLGnXViS9HRBvIS37LyEHEXpLoljhBf+0K/enLv0iRwhwOpFb/BbmjMwRxPrM01V
         4vjW/EG1geOJT4UN9EScadZxh82p3KkDBwKRdJ5NaLJv3Ov7JOMe8W79Bu+kXBuHNn+x
         w34Jln5x1DI49deXvu/39VNdnI3flw+gAuBs6avZxNLa/vRPw2EZOKUbQxiqcboi6kLJ
         PaKZ/OQa9azjH2Rd9Oz79890Kdoj8oq/CXU4VPSotvzGDawLesIzZVXIW6l5+rRI2tYC
         KCnoRR6j+cOEGHlMabEo3PSE2CfSHNP1t40bLs4IyRDE7xjcRvkUAqTJvy3VAyIJ8R2c
         Lnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633649; x=1712238449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6/LQEbj47XgO1NSTRnIcQMXt+T1PN8lsmLYGnxkXkg=;
        b=Um813cT/T1h9vAhY40+/Fw+TAX+7WgyezBfgR7xUv5tWsDw2Srsvmq68Exx3aYStL2
         04EaDZSKtIrnXRHM+2F4Uj6+dC7gVrKVHdEtu11eFX6WaLk2ZYmIHNZufASiNa90xNBN
         r6k+LUCW4WbNKitD2gCNVZlKe1XENixJUcWocmgCjaZzXrD/Ecos5BxL0w4qnRhf1RZE
         mdCC0zhN4w3O0/3Nesy4Tmqbkb1cO9C32upm+96UOyUr6pLixWUVhOsh36wv3I9NDeyR
         r04Rx5JJqCZGoO1/G4UP+1kASZoFLUac1/ouU4Ff/ZMs8Yqpn6D8pbgAeckSZ2Hw37Sm
         c7KA==
X-Gm-Message-State: AOJu0YyMdvmnC5gAI0S/yaxuFrZuv2yGzCcJ+AsFGWxBM55RGx1KieWl
	HYvJq/bEL/p7Bblw6lo7OuEnpBHG+sT2I02Wq9+kHmPU3Z0H0IUEIrorl04X
X-Google-Smtp-Source: AGHT+IEpY4JfmbNfWW7ZrKmF3RW89G1pUPwaKMz9GShMSh6EgGWM7FPq0wdhtLODkdxI8npTirj1hw==
X-Received: by 2002:a17:902:6908:b0:1dd:6eba:c592 with SMTP id j8-20020a170902690800b001dd6ebac592mr2582676plk.56.1711633649245;
        Thu, 28 Mar 2024 06:47:29 -0700 (PDT)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170902f94500b001e10b6f45dasm1568838plb.295.2024.03.28.06.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:47:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] band: make HE/no-HT rate estimators return more descriptive
Date: Thu, 28 Mar 2024 06:47:24 -0700
Message-Id: <20240328134725.1484257-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the IEs were not provided return -ENOTSUP rather than -EINVAL
or -EBADMSG since this just means the AP doesn't support those
capabilities.
---
 src/band.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/band.c b/src/band.c
index bf40f789..11cd965e 100644
--- a/src/band.c
+++ b/src/band.c
@@ -90,7 +90,7 @@ int band_estimate_nonht_rate(const struct band *band,
 	int i;
 
 	if (!supported_rates && !ext_supported_rates)
-		return -EINVAL;
+		return -ENOTSUP;
 
 	/*
 	 * Start at the back of the array.  Rates are generally given in
@@ -607,7 +607,7 @@ int band_estimate_he_rx_rate(const struct band *band, const uint8_t *hec,
 	uint8_t width_set;
 
 	if (!hec || !band->he_capabilities)
-		return -EBADMSG;
+		return -ENOTSUP;
 
 	for (entry = l_queue_get_entries(band->he_capabilities);
 						entry; entry = entry->next) {
-- 
2.34.1

