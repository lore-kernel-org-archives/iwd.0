Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C628EB
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956307; cv=none; b=laebd4JEGB7cT/2EX2Z77IEGFYJOAkJwwHV7ZdfFjqFGCC8SgF06cIxen+s4cqJRMRpZA7sE/C8jY/qjesNxeRlKsnjqAHYVsMuYODxGppfRqnJ38yFVgtoK67keDSQjy0I8UmjXS9Ri98TEcRtgxfRJUjXbMtPN9sfTmQ5P/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956307; c=relaxed/simple;
	bh=0pBoRNnugpiqvD6waumo2O3rMT4GsirVXqlASZu1Iss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGhc23sXVCuRM9569+dNV+U+ioWqUazcErxY7wff0DJc1VMSXbBJTpViKdxSToWN0OApI52tgCVI/fN2/yl9GswbMeBdd0HS8ZQEj1BVFDaXoXEJWU7oWasFhu5d30+jq4pWNmwuLfonCfRGJlBuiS1mCfoX6uJLJWCpAuHvShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OX3dDVBg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX3dDVBg"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-618a2b12dbbso2565603a12.0
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956305; x=1715561105; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9XVy0fnB8prYwdWnb0QATGPfSlPazpNNn6jF1CSDr0=;
        b=OX3dDVBgsIooLPzwSGqj8xuBLKYHhAoedkEzqswCawVclu++yYAbntq6/8CzdpJVOm
         aMrPx9dST+hbikuJnOQpmFtRxCHZ/WHuJR6F4ZzuDiFquMBwFrH1AZew6vetujTkiMJ3
         Q3OOlGEbyhpQfaNVeHuJ1M0eGGQf7tSv/S7j8NieVbLawI3uhAzp/Twrbxpi4TPcGp58
         TyWqIlVOa5E/7IvutXQIbqZlwmuWpCNwNdOiSZt53vIrsS5SO2uWXNAQQehZkWiVhOYs
         Ejaoj73RC5DuDzrmcZseshgRpaI7irkOdTsoZdXzwPfmOoholnByQukyArYwX4oQAO6F
         Ye2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956305; x=1715561105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9XVy0fnB8prYwdWnb0QATGPfSlPazpNNn6jF1CSDr0=;
        b=GbhFjlLe8tQwopl+9kFLg3yIvcJJTtVlnLIZd+VcZoTtNc9SahVw+gYwGtkrRlQTW7
         3hSv27BY38vHkmraz1DlrKk/ZanRVkkR5BjZSTJZGjyl0y0b+RKijD+maBTkFnowQxvV
         MM7ymjIYC/wZXlybtaz9UtZrnycBKr7F5iPe3hCCMINpfIKggiAbRdXVjgrs52u2Khw6
         /+kYoqSMJPu7M/u68TMYzP33yxVhf8Fyy7A6AlveK9azbdfE4nTEHcZhnpy2WexyHr2S
         Qrj9oSkTBFMfJDwc+6QMVa63DnIVLRYZ/q6mjNqyoXov+qYDzTSjUIHWtF69QuozyCKq
         Rpog==
X-Gm-Message-State: AOJu0YwuuAemCc3CRuc4LraXrtWzFxYMZHtTi5Twcx164uyFZ/5U41nv
	GsuVy55VudhkVusgztmlC+JlXlkD+zUjZPozWLGZJvp/dgcOVMImVoQx9Q==
X-Google-Smtp-Source: AGHT+IHe2k79kCJu7WMc6CN6t7Gy2dlF2rz6tx2Z23qAm5woce8xUep27EXdxjk96mXfXKLwFGpTOg==
X-Received: by 2002:a17:90b:4f46:b0:2b0:e9bd:e794 with SMTP id pj6-20020a17090b4f4600b002b0e9bde794mr13289747pjb.19.1714956305486;
        Sun, 05 May 2024 17:45:05 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090ac88d00b0029c472ec962sm8768219pjt.47.2024.05.05.17.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:45:05 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 00/18] Basic WPA3 support in AP mode
Date: Sun,  5 May 2024 17:30:23 -0700
Message-ID: <20240506003518.320176-1-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches adds basic WPA3 support for IWD in AP mode. It has
been tested by connecting to IWD AP using wpa_supplicant, both when WPA3
is enabled and when it was not. A unit test for SAE mode is now also
included and all other unit tests now pass again.

Compared to the previous version, this patch now also includes MFP
support for AP mode. The AP will generate an IGTK on startup, and
distribute it to MFP-capable clients. Sanity checks on received SAE
frames are now also added.

John Brandt (18):
  ap: ability to advertise PSK and SAE
  ap: accept PSK/SAE in auth depending on config
  unit: fix SAE unit tests
  sae: add function sae_set_group
  sae: refactor and add function sae_calculate_keys
  sae: make sae_process_commit callable in AP mode
  sae: verify offered group in AP mode
  sae: support reception of Confirm frame by AP
  ap: add support to handle SAE authentication
  ap: enable start of 4-way HS after SAE
  eapol: support PTK derivation with SHA256
  eapol: encrypt key data for AKM-defined ciphers
  unit: add unit test for SAE AP mode
  ap: move toward requiring MFP when using SAE
  handshake: add functions to save and set IGTK
  eapol: include IGTK in 4-way handshake as AP
  ap: generate IGTK on startup if MFP is enabled
  ap: propogate IGTK and RSC to handshake

 src/ap.c          | 270 ++++++++++++++++++++++++++++++++++++++++------
 src/eapol.c       |  70 +++++++++---
 src/handshake.c   |  34 ++++++
 src/handshake.h   |   8 ++
 src/nl80211util.c |   7 +-
 src/sae.c         | 209 ++++++++++++++++++++++++-----------
 src/wiphy.c       |   2 +-
 src/wiphy.h       |   2 +
 unit/test-sae.c   | 114 +++++++++++++++++++-
 9 files changed, 595 insertions(+), 121 deletions(-)

-- 
2.45.0

