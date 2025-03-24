Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533472E3380
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825754; cv=none; b=UiWvC5CqDSMj+X8qtqawp60LQHJkCDJzi8lJn9g2IwwtmKzpv4m/EN/Ox3ls+bMKCDH5IFe6fmFmQ69CN2O37thbIo3ZMsXdmE4JzY3PDbtSUpjMFQYTnmV1pZzSIRpOk4t4+nGmFGNemc/MmTCBX9Ex5cGXmPmgg5Sbms9YyM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825754; c=relaxed/simple;
	bh=t6IndlPpTsRMBtJkhbEYdE1rbROk1UhZxfteWOpH+Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r40ISTGMUOTKsVuKDNXINsxJV66YaB8dLaHZ5fPT38rittSKyTw1uXivptdAhQQWEL+uh8+GKSIf/DANSdufT5DKBdniQBCZWUNzBuNyIN2nzJNMHlD7bl6oP1BWaPX9axb6ElElb2K96VKMS+aIdsu5Z/echJQSxKS8Y5LMVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6BjMshI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6BjMshI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22580c9ee0aso85213235ad.2
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825751; x=1743430551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nM5ZORTTplFGslSEzARqtJLbWk1j5haF7xBCVDbIQw=;
        b=E6BjMshIylvw47+zECHzIyBFfthG+vJUajyAS720F73qyvyVAi+0/3r2j/FKIjPfI4
         wSLpAyfx/WaKOz0purb78QiT9xbFkveyW2uQnVqIxrwVZLm7rj5co1oyyHuMa7j2dP0R
         VNRPBiScqypuBT8Zu0wZFPl64/PIKyBIBbaFxZb76Ft4PfdGspFxYf9RAw7CUDMK7J7S
         Xg5nSDNBz+GlWBMTyR8NnP4gVsBOhgGXTEPGjZvkK0watgm9wVtSpqJeUDe3mJT/Q7GO
         8I5spCnovVIQ9+kV6S+7pbGQk1RLDxlLSQgoZkDNcEiVW0qdi94G4yrLnpxF9m1mZpoG
         K6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825751; x=1743430551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nM5ZORTTplFGslSEzARqtJLbWk1j5haF7xBCVDbIQw=;
        b=JTtbpUcb2aQ3nXAMd3SofuXGAr40DhZ3nldR3OgUvFToVh4XfnAh1XU2fHEK98yqxK
         GnTuJD8Dh9flNu32OZdmASF1jlGkPa1XVv4Yw/1xZ4n2tLFer6QENU1tMYeNlK/btkUw
         kVK9pAQE6OgfVnpYChK7/RTtg7vRceaM7YXZt0bHydGc4dzlLV7aPOPrB/CXplvLpYSZ
         5Dx3l/EDhlCfHc0l2AbWNktV4Z34bZnD/b8Xxjkwu9otYT21JTmHO8iHfoRyCEJ6h4JD
         49/8F0Vrq1nf6B3RFt7VDin3Qkj0DndtTxUMBNBXVaLQoRQhmpXEf65JF6vcboNIMKuR
         mKJQ==
X-Gm-Message-State: AOJu0Yxs0UuEvTLE5holP5CK4jFQKNKlSHVdnqM8b2/fTFlSwyS8OJ3a
	FTzw17PxwHjnnxQRH9KuUSl+5BkRXN5+wuGVtCvLuGkW43q5hOycSTHXIw==
X-Gm-Gg: ASbGncuqxrnDaiO/j56bizqZ7RthNP64V18ygiZzM5BAMm7wf5RGdWqdMBDeTwnb+tW
	bwBar4Hq+eavPgX8DmwaUO48SORgb1baYGQ0E56fa2J7V7KpSjxnj4qXLj89ouajiEPD509g8AS
	YgGSwVaZvPtzFwgpJZkiI0fHxviK16BGU/SS+m0ZgodjVfIp/9aM92y0MgJrU4iVqHicbyLThcn
	/XjSrlgjetIullR9zRHLaJcvHod+7EmOk4EYAczCqz12/XsyrizsuoaHJPykVLwP+1wPCaOyfMY
	7u4j9vXGhUdoHoOKCPni0buzJNgjSCKPy5TYheLwMHo/ae4xSa9ij7w=
X-Google-Smtp-Source: AGHT+IEnc0F9RMvUs3Rl6F9DhEC5BjLwWd1zkpiskJSc9QGM2NO1Bak3KB02whtK5/hxBIYaA/0rzg==
X-Received: by 2002:a05:6a00:1820:b0:736:4b6d:82dd with SMTP id d2e1a72fcca58-73905945751mr16634685b3a.2.1742825750859;
        Mon, 24 Mar 2025 07:15:50 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:15:50 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 00/13] Roam blacklisting and scan BSS groups
Date: Mon, 24 Mar 2025 07:15:25 -0700
Message-Id: <20250324141538.144578-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Version 2 combines the main patch set and another fix that was sent
individually. In addition there were some changes made to the
overall set of patches:

 - Renamed the blacklist reasons
   BLACKLIST_REASON_PERMANENT -> BLACKLIST_REASON_CONNECT_FAILED
   BLACKLIST_REASON_TEMPORARY -> BLACKLIST_REASON_TRANSIENT_ERROR

 - Added documentation for the two new main.conf options added

 - Added more autotests

 - OptimalSignalThreshold was moved from [Scan] -> [General] as
   it fits a lot better there along with the other roaming
   thresholds.
 

James Prestwood (13):
  station: always network (temp) blacklist on failure
  auto-t: add test for disabling the timeout blacklist
  blacklist: include a blacklist reason when adding/finding
  blacklist: fix pruning to remove the entry if its expired
  blacklist: add BLACKLIST_REASON_TRANSIENT_ERROR
  network: update to use blacklist's new temporary type
  blacklist: add new blacklist reason, ROAM_REQUESTED
  scan: Introduce higher level scan BSS groups
  station: roam blacklist BSS when a roam is requested
  station: roam blacklist AP even mid-roam
  station: adapt roam scan logic to look at the bss group
  auto-t: add tests for AP roam blacklisting
  doc: document OptimalSignalThreshold and InitialRoamRequestedTimeout

 autotests/testAPRoam/connection_test.py       |   2 +-
 autotests/testAPRoam/hw.conf                  |   2 +
 autotests/testAPRoam/main.conf.roaming        |   6 +
 autotests/testAPRoam/roam_blacklist_test.py   | 183 ++++++++++++++++++
 autotests/testBSSBlacklist/TestBlacklist.psk  |   2 +
 autotests/testBSSBlacklist/connection_test.py |  57 ++++++
 .../{main.conf => main.conf.default}          |   0
 autotests/testBSSBlacklist/main.conf.disabled |   2 +
 src/blacklist.c                               | 124 +++++++++---
 src/blacklist.h                               |  33 +++-
 src/iwd.config.rst                            |  21 ++
 src/network.c                                 |  37 ++--
 src/network.h                                 |   2 -
 src/scan.c                                    |  42 +++-
 src/scan.h                                    |  41 ++++
 src/station.c                                 |  87 +++++++--
 16 files changed, 560 insertions(+), 81 deletions(-)
 create mode 100644 autotests/testAPRoam/main.conf.roaming
 create mode 100644 autotests/testAPRoam/roam_blacklist_test.py
 create mode 100644 autotests/testBSSBlacklist/TestBlacklist.psk
 rename autotests/testBSSBlacklist/{main.conf => main.conf.default} (100%)
 create mode 100644 autotests/testBSSBlacklist/main.conf.disabled

-- 
2.34.1

