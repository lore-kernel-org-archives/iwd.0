Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2024BBEB
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477904; cv=none; b=RR2mjA0mn/1TW6yy0cKGHdsb8zsDrgozCmmFjC7X2X6ro28Y086e21nu9tmJmlbTVa2v5kRVbi2z3JscZwfLiCtQP3Jz2kbueXJpv0zUR2dWcn/kFTYXQcfB3RprbTUbWa0nXPwWnR3qQkvZ1CGf1A4CyRQ+gtyokeeDerIn900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477904; c=relaxed/simple;
	bh=bdhE2WA0kEdZmVDiJQrQ6XimwONSW3uyJZoiPZYhifM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nlzzgf7PeyPfhAlMW4G/iTrYLPn3HduG8cJ3cr07Ac+95FVyKbwNSxQRtad1AAmTukNwTBfIc+eep+nlQmNMwFPeWQxcQD5n0CT4A6OqTKhB8UG+ciETHKfx7f5dhgCTSQXm8Tpii4U5jAaYKuIp/wpsLVHPpL0pc0M7+IOLI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcU8ewqS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcU8ewqS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c8eb195aso24799495ad.0
        for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477902; x=1740082702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yROj95t9y+ti4LnNZRJQk1J5y2qfKGbIHs+wqN8Hpp0=;
        b=FcU8ewqSsCbQhw2fLNVQJpA1EkK1Npr5qBvzSo4yO6UYh2/Oyrza54NfK5gPWPOcsz
         PR6rcnpqSP2O34nz4alu7T7QeSMNx5rXgnPyEne9FITibXIOjKARedXumsNEO0CnWSHt
         mwBLo/89o+aQnBWEYDFJW2eFGfjR3TNAWKHj9a1RwYUiC8rZy40/DFB7Wxy+BX8s6VEF
         nzKH9c2FbZcCxdVTxgM/Dhj96Vyf7dPe7mYDDT9OV0M2mrigyZRSSvdBDgF2hICkaVuC
         vHhVLquR+KpLlX2/jWRqLAwIoZDbMS1kmU1/f9Y/VNK+3qWOZNqQ4jLgfHk5WKXSzgje
         Cq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477902; x=1740082702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yROj95t9y+ti4LnNZRJQk1J5y2qfKGbIHs+wqN8Hpp0=;
        b=tdLQf2nIA87l1Bldbh27O3JTyETXZcSnzW+NlttmnDvQZfJagNRm7euekf1QqB6oGZ
         tn4v0Cqv2CxYn6WaE6A2DotSG03GtXWaZu8yItU5JZwa/i1PL8aWwTlxD1FCAEGBp4NC
         /wvyduZHUaOmDQ9I4X2Jrpbz8tqA7lJ192HUL+LvJn6nMQW/iEIyA5cyjasjf8z8oTr4
         FIGxlBu+rXm+OIrOLjndOU5+BlIsuW9ICPwFuE0BAYiQ7nx9u6bfsR6dAKnFl4F5mztl
         46V5aGLru9Xwkp8oeoDshNBokFQKym1fZ9HUVahlR2pGiQ6HvrHFwCXESgsYIiAz7F72
         QTng==
X-Gm-Message-State: AOJu0Ywap0uopEG3PM4qAdxTJrvOTueTrC6cqhG6vIeCPkeH9gMHnVnf
	JKLEK5n8T4Wguj0RyRyhWYJ9TD1VyJzId5+kK/w5+/GovAHGVWEHcKz41A==
X-Gm-Gg: ASbGncv62nQ8mEcsF08SvugSnAuwyfUeHlSCIVtBg6lI6EDdF2jrebcMGSQBNFcoIa5
	sKh/CSgXFkTLCZbxqgdaGlMjQL/2HswSnHTG9BHUIU4T0zDH1wB+PNa0HltUM64yT10AhClzXLL
	S89ggE6PAmIdGzHVv8gPlu4POesR/hD84S8nAD8Q4a3oP5FIXEB6hRJTGG6JMyBqmj9yfNgx8UU
	E/mOwY0Ie+0Dk9Hmel0Wgqo6gRzbK544918yvyQ++sqEBe9Tf8p425HiTBzFUPykuLW0lNVzTg2
	zC+4ZVjsLMOx9YwInedbN6+nnQ==
X-Google-Smtp-Source: AGHT+IG40WsFxef54/wacM7El2HVRUhwu/ur5EGI4ZExkaVVwpmPUxy+kl+zFgulxjA90xPlE4+EZg==
X-Received: by 2002:a17:902:d2cb:b0:220:e5be:29c8 with SMTP id d9443c01a7336-220e5be2bafmr30836105ad.32.1739477902288;
        Thu, 13 Feb 2025 12:18:22 -0800 (PST)
Received: from localhost.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm16419455ad.148.2025.02.13.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:18:21 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 0/5] PMKSA support for fullmac drivers
Date: Thu, 13 Feb 2025 12:18:11 -0800
Message-Id: <20250213201816.230112-1-prestwoj@gmail.com>
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

v2:
 * Reworked patches to utilize a new driver callback concept within
   the pmksa module. This avoids the need to expose any netdev APIs
   and makes the removal within the kernel transparent to modules
   using the PMKSA cache.

James Prestwood (5):
  netdev: don't set CQM thresholds for fullmac cards
  netdev: remove/update some iwd_notice logs
  pmksa: add driver callbacks and pmksa_cache_free
  handshake: use pmksa_cache_free
  netdev: implement PMKSA for fullmac drivers

 src/handshake.c |   6 +--
 src/netdev.c    | 133 +++++++++++++++++++++++++++++++++++++++++++++---
 src/pmksa.c     |  38 +++++++++++++-
 src/pmksa.h     |   9 ++++
 4 files changed, 173 insertions(+), 13 deletions(-)

-- 
2.34.1

