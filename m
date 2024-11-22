Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398E7080C
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288560; cv=none; b=WYXMsclZ3QQreRWQQv8x72CXaTNtfDuyK8CYQZ9VGX1CHjAX6D/9ozz9WYCEzrj3379Vpqle9NRz2mYMGirJqpdQTAZQWr4sZa1Oi+nD6GiR6f7wnuM/x/kCAw85mzEiUgnZBV3ComIulCk2WhujS72UnvwJbzbtE6n+IRHPqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288560; c=relaxed/simple;
	bh=K/fLW27LxfEJrOJbmpJ3B1b8NsQ2KOANbyGao8CRw84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=daa4KxZjUJugdhQ82g+IdoAbpHqmSKhq3/FA3lYXliZJPrKqwYtgkePPaLVZqPQgI5BA6XbpIpe1YIeqCL9EzLFEYQBV+v0NtMSyCzyEVFykLT8lNysTWRct51Id4wgrAap+m62+IW1caJg2r/zcukfAtJCXvz8+kV2hJTvmYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtcqHDWD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtcqHDWD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d4035f2d18so13903156d6.1
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288557; x=1732893357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvOnqiFE2uBSnzvpH2QsGDN0jDfIYb85YFKOWWf8TYw=;
        b=HtcqHDWDMyhSeXwHB9mR9v4VLkYn1H8j8aMaQAuXmvjJ1GKqOEDN2aRA//hhCynmkz
         +erQajobyeZESwAYgDpLt4mfKs2o9u8KNnexMtMQ6Y7+2o3k3pbsgJKm+/KveiB9sXii
         VuOrVzOQlLAChKwT7FujzgjsL+4SUM0jfraABpPaEGgM9w7wT5X5WTQDskOu3EFJ14L0
         2fCtm6oFfgz+ynkAzXC0VRG79Gdijt3fDdZsM3Jf8F9DrxZXsVFxwOQsQoOA9RwUGNPZ
         QQtzoQQiJysxgTr0Uzl17ZhwdQ6FAQgLqL1PV20ZU1oVpE/qRgbofqBASx/awdpgYHIs
         rsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288558; x=1732893358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvOnqiFE2uBSnzvpH2QsGDN0jDfIYb85YFKOWWf8TYw=;
        b=NHcK2TXzcrzn05ihD8IUecLh2h1e2WHzOD1UkYUQ7/OOLn65L1NjkYlyfxJchFt1w3
         ufk+58lCHLuWg/4X51kvtpwqIWqsZqMUxvkHxBjjVu77bWD6zMDjBWzm4Zh8yJ5zFoLe
         csAoRa6v/MSPQ6Kbm9tC/XWf38KppHG2L+3q/Eyw/d+O8LzhQYzG8R6gSJO2FPLNOZ/U
         efX/cCmPzmy5WnSXIupsDNOiCBOvtOFpFJ+uuvpRER3UhaVkaD1PBEILXsn3BnwnTZTU
         fxr9YT/PzTNk/d/OrvCBtcQEogCN6JG545xorbO0EWdcteV1BA7gGYq5c/avB4qMN0mo
         dQaQ==
X-Gm-Message-State: AOJu0YxL1p3BuElBbtcqB1oCA9k8lKflJ2V/URuDVwLIgZP8frbwaygK
	HHstm9s2CHQ6zbKHFKhin00GJSMDbepQL3GqMhIeilvRUNrOTB4rVsIxJQ==
X-Gm-Gg: ASbGnctFNJ/UKpLSZjGnaomHeOej+1MmwAZrYvpY+boEnRDGUKuX/zEiJ6yRt5UoY7+
	A8nimz/hwvH3YRNv8f/31Me6Ne0ELbcSkeQYmUl4R2bsc+2Rxl44vePNpVpd0b5zSaZSmWJJ+fK
	bHa8k5bX+osMP8vX6PuzKDcIbJ4uf6t0I+7GdQCfq2sZVNPeFa3IqCYI+wnFqrcSX53PGPhyDf8
	dJcHmPY1ASlTLcYyxM7WhRZZTF/8q7t1B2m0Lgf1hHt0WDdk3rFQ3MXTwjQ
X-Google-Smtp-Source: AGHT+IGXDPgEF2EoAU4DdNQbZnHGHiZpS3NiGQyjgcCJAVB0UB5asovnEUDteUaPoQO6KL9tIyfoBQ==
X-Received: by 2002:a05:6214:ca9:b0:6d1:8755:5cbe with SMTP id 6a1803df08f44-6d450e69adbmr42263616d6.8.1732288557653;
        Fri, 22 Nov 2024 07:15:57 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:15:57 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 00/15] PMKSA support (SAE only)
Date: Fri, 22 Nov 2024 07:15:36 -0800
Message-Id: <20241122151551.286355-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for PMKSA-based connections. For now only SAE and
SAE-FT are supported. This was done for a few reasons:
 - PMKSA with WPA2 doesn't make a whole lot of sense. There is no
   real benefit to using PMKSA over full association.
 - PMKSA is required by the WiFi Alliance for WPA3 certificaion

Missing features include:
 - 802.1x support, this may be added at a later date.
 - Filesystem storage of PMKSA caches. For now this just hasn't
   been implemented.

Denis Kenzior (4):
  pmksa: Add skeleton
  unit: Add basic pmksa test
  pmksa: Add debugging
  handshake: Add pmksa setter & stealer

James Prestwood (11):
  handshake: add ref counting to handshake_state
  unit: update use of handshake_state with ref/unref
  auto-t: always initialize StationDebug in Device class
  auto-t: add pmksa_flush() to hostapd module
  auto-t: update testSAE to disable PMKSA
  handshake: add handshake_state_remove_pmksa
  netdev: add support to use PMKSA over SAE if available
  station: hold reference to handshake object
  station: support PMKSA connections
  auto-t: add PMKSA tests
  doc: document DisablePMKSA option

 .gitignore                                 |   1 +
 Makefile.am                                |  18 +-
 autotests/testPMKSA-SAE/connection_test.py | 114 ++++++++++
 autotests/testPMKSA-SAE/hw.conf            |   7 +
 autotests/testPMKSA-SAE/ssidSAE.conf       |  12 ++
 autotests/testSAE-roam/connection_test.py  |  60 +++++-
 autotests/testSAE/main.conf                |   3 +
 autotests/util/hostapd.py                  |   4 +
 autotests/util/iwd.py                      |   4 +-
 src/adhoc.c                                |   4 +-
 src/ap.c                                   |   2 +-
 src/handshake.c                            | 105 ++++++++-
 src/handshake.h                            |  21 +-
 src/iwd.config.rst                         |   5 +
 src/netdev.c                               |  31 ++-
 src/p2p.c                                  |   2 +-
 src/pmksa.c                                | 235 +++++++++++++++++++++
 src/pmksa.h                                |  46 ++++
 src/station.c                              |  90 +++++++-
 src/wsc.c                                  |   2 +-
 unit/test-eapol.c                          |  38 ++--
 unit/test-pmksa.c                          | 164 ++++++++++++++
 unit/test-sae.c                            |  15 +-
 unit/test-wsc.c                            |  10 +-
 24 files changed, 942 insertions(+), 51 deletions(-)
 create mode 100644 autotests/testPMKSA-SAE/connection_test.py
 create mode 100644 autotests/testPMKSA-SAE/hw.conf
 create mode 100644 autotests/testPMKSA-SAE/ssidSAE.conf
 create mode 100644 src/pmksa.c
 create mode 100644 src/pmksa.h
 create mode 100644 unit/test-pmksa.c

-- 
2.34.1

