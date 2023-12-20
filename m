Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B492574F
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZLtOXY7"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba46a19689so4576092b6e.3
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077929; x=1703682729; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWD8h77AKj+6i4QFAENQ4nHqTpGtoO4/PmE7KXlDtvw=;
        b=ZZLtOXY7pa/ePvNafnv5Hl8FZSW6TzGXXMC1ABCaAK4Kt7C8UsbXnTpviSeGwrxqqR
         uKtpQi55p2bWKy1L3RKq/s91xcvV02dbkQvtxCDjJ9YOW+99jzejynxLZ3Fk6KXmHz+1
         z0OGo/0Ljy+bswOw/ZPU2RfiJz9JK+56rgsA3P8hin6Ir6D+CLyw8OCUWZvzKCT7E9V7
         Fr97z36Jle0gG6OzIDsQHFnVNpuJyf1Cf60G3B1Vl3Ej/k2xx6vRUcqxhYe+zeAsdPNY
         HgBx4onKoWfU7237dAFojoFp5jud9kCQC95eSzRgsYASJIYBdcRaWFJC8NieVvpz46fl
         /DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077929; x=1703682729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWD8h77AKj+6i4QFAENQ4nHqTpGtoO4/PmE7KXlDtvw=;
        b=FrvDRe4jst6IswTbO+QrSznD6eErW/JkA4VFU5w80/7w7aiIx0G/tYorzRxqxE99We
         yWwxAEDHmYJyS0Puhzk2rPNXiCUaJv+HlSVDBMq5pZRsJl9nMDbjPp0jwOqqXbHnjkww
         sz+GdDe4/p0Kbl9zy97WQ8vK4Kwi+F7pr3Po09qQbbmz4lNDI95zXyIMvw+DhnboYuRx
         s3FxR6uRx+iUdPkkM819tjNrU9Pn+beqAQ4vgT2kOKn3y9+PtaA+HErbZKLzz611tbng
         TSJqpooiNmYf/x3lBIhyDmpvbVkla9zleaFrUgeNyqzLIdfMcASOO7FZSksRHYG7E3AB
         68iQ==
X-Gm-Message-State: AOJu0YzVtkJoykE9T7tU50lWwmnAA0WyWwHg8jToi/KinUE+MSTEb+Ef
	mNInx4AFwtGDvsU9c5dR8V+M7ss5S2c=
X-Google-Smtp-Source: AGHT+IFKKyNQQ5OjDxNI/IFp95xXrAEug97za/U3Wm1i3YrQWNSR1k2gmMKazK+SH03OS2o6CZdZfQ==
X-Received: by 2002:a05:6808:1442:b0:3b8:b063:adf6 with SMTP id x2-20020a056808144200b003b8b063adf6mr25462642oiv.83.1703077929237;
        Wed, 20 Dec 2023 05:12:09 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j15-20020aca170f000000b003ba3a9c553esm2109591oii.30.2023.12.20.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/7] Reduce and optimize quick/roam scan frequencies
Date: Wed, 20 Dec 2023 05:11:53 -0800
Message-Id: <20231220131200.267489-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For large network deployments with many APs the list of known
frequencies can grow rather large. Since there is no cap on
the number of frequencies for quick scans this results in quite
a long scan. Roam scans (with no neighbor report) do cap at 5
frequencies but this list isn't sorted or optimized to scan
the most recently used BSS's.

These patches separate the known frequency list into two
sections, first most recently used, then most recently
seen. That way previously connected BSS frequencies are scanned
ahead of others. This also caps the number of frequencies for
quick scans to 5 per network. This still could result in 25
frequencies scanned (worst case), but its probably not very
common for a device to see 5 separate SSID's it can connect to.
In most cases its one, maybe 2.

James Prestwood (7):
  known_network: rename known_network_add_frequency
  knownnetworks: add known_network_add_connected_frequency
  network: call network_connected with BSS
  network: add network_roamed
  station: use network_roamed
  auto-t: update known frequency test to check order
  knownnetworks: limit 5 recent frequencies per network

 autotests/testKnownNetworks/frequency_test.py | 122 +++++++++++++-----
 autotests/testKnownNetworks/hw.conf           |  10 +-
 .../{ssidCCMP-2G.conf => ssidCCMP-2G-1.conf}  |   0
 .../testKnownNetworks/ssidCCMP-2G-2.conf      |   8 ++
 autotests/testKnownNetworks/ssidHotspot.conf  |   2 +-
 src/knownnetworks.c                           |  66 +++++++++-
 src/knownnetworks.h                           |   6 +-
 src/network.c                                 |  19 ++-
 src/network.h                                 |   3 +-
 src/station.c                                 |   4 +-
 10 files changed, 190 insertions(+), 50 deletions(-)
 rename autotests/testKnownNetworks/{ssidCCMP-2G.conf => ssidCCMP-2G-1.conf} (100%)
 create mode 100644 autotests/testKnownNetworks/ssidCCMP-2G-2.conf

-- 
2.34.1

