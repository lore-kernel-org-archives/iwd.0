Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2712D76E
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939028; cv=none; b=PEfTTp7Qvl0kGPm+t04yB2bbeJa6QC/xG432pTzV5mowTEQNKiscB4g5hdJkdDPR0ru6IL6kpIOPGAgwNLRGlCky6FttJi32UsjGTZeczUzirzgrCpTemG5dLpoLyjc1bFqv6+rrndqtuF8aX8KWtYJ2ilF5RzBofRahj4NHKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939028; c=relaxed/simple;
	bh=dwQbPdnc1FNTeX+J9KjgqKHbfWmrO57tWH3a1XkdmfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DEnhDmP3phQHQFNVHNbryecgIl0izsaIQ5WamEV62YjPV1S4dYpAM42R324rPuHTb6smVVLMubA6i2xF3lcx+4VZ4cVjZ7/4oYSVrGj7Gx4TPd2bGf3l3JBkokaWDqSua/bynugyNPaDnYbaCxPHjII9w4pddq9H3JCOR4IbNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sux8NFl1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sux8NFl1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d944e8f367so905665ad.0
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939026; x=1708543826; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AplTx8lk3ahbEDq1TvxC/vGihZ2iHC2LpbAOxobz3ZY=;
        b=Sux8NFl11PTrkIii9894B2CArDI/xI7hWNZUHwFxbybq/Y7P5wigVEmLoT9pcWO7nJ
         agksPUuIdyKg/wVgh+JTyhZfmann1+JDBW52Ng6z9bbGr29HiMBSr5KYNB3btP9AdS3P
         p8a7UtH3DHcVLjjhtIZZ/MrXmjN816Zk22ZMgaP9wYGAd9prZYT/sHLpybZxTmjEfxC1
         2ZxCmZrMM1n68XSIJM/KKIhAnnUbLc9irqWUVEJhmwkBCbiFXPrEhbXxy9RrfYiwS9Ub
         JXvxl1gBHDmpKGroAS7KYafzDXb839HM2B5B20od5CCHC7ZmjEEotwKRGCV31/O0eTuX
         CLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939026; x=1708543826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AplTx8lk3ahbEDq1TvxC/vGihZ2iHC2LpbAOxobz3ZY=;
        b=fAkVhcvgI7vY3a7NV0Z/FRvWkcCeFoRzLaw1N/iUsynRhpDKN4Qz6jOl3RTcSy4wWR
         Pmqy49In5pqWtUOMOh5lTPYd53T5RojVwH6Jx9DbSP7Apb2eyMvvLVPtOl5auhW6dtUG
         eDKu9LWZennsllAdTuVrwl6InH4aGTbMECTbBM7/Nc4i3GghyKxFxPqJS6m8BXQE0gsd
         txpY3/i5YcYVYD03TdUkZ2XihXEpLxz9NDRz9b3vzVkbf3H1TsPqUCDxe40z4swQVaAi
         cTF6A3qv4jcszcxAR9vrDq0aVfXl2GvqZbK1fLtGAqhSDY64e8MgRzzITPYR0Yy0Smrb
         Jx3A==
X-Gm-Message-State: AOJu0YxZLnGFM4/X54YQ4dCYQXBWFbvAatj6hX7OsunLJ9HrbVA3nD6p
	vYjy/hZ6akVkeThX/0KPljJXYHD7wzBSGiiEBUXjjEF90SL/dD8NX2mfG+tM5Wc=
X-Google-Smtp-Source: AGHT+IFBaiQGeLEOY8GykQVTSSqh5jcLxy79GrlYK81IhJxw+Ogvm0ecJDHgDn9UZKILcIOdj5sBaw==
X-Received: by 2002:a17:903:230e:b0:1d9:2369:d0f8 with SMTP id d14-20020a170903230e00b001d92369d0f8mr4288203plh.9.1707939026317;
        Wed, 14 Feb 2024 11:30:26 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001d8e5a3be8asm4028120pld.259.2024.02.14.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:30:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: fix failed_roam_test to pass when run on its own
Date: Wed, 14 Feb 2024 11:30:20 -0800
Message-Id: <20240214193021.963130-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running this test with others the hostapd neighbors are already
grouped which lets the test pass. On its own this does not happen
and it fails.
---
 autotests/testPSK-roam/failed_roam_test.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index 12e439f6..8cce8bb5 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -221,6 +221,8 @@ class Test(unittest.TestCase):
         cls.rule_bss2 = hwsim.rules.create()
         cls.rule_bss2.source = hwsim.get_radio('rad2').addresses[0]
 
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
-- 
2.34.1

