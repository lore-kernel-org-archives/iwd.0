Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0613AA39
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303121; cv=none; b=RKEx4Pdce7dUgdeHpaRZMW/m/ypj71vV08agXIrDsISkkt7fBFvZIJ/rgMnk1Thhz/gYR7V/sgusaAQmADAakg/XS9wPlzVlYjkVH1DEpeFLp34O9o/1FUDZUBsOzwHYIdrC4i5+OwLry3bH6ln3LWw2o7gl1XfDza3aHFoFqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303121; c=relaxed/simple;
	bh=EkoOn3dpDpQzEEVwsPsHcNdOnhGOx1B0BPKQbeFu6wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AQJ4i5XWZlAOY1oG0TNFX78pjaum7DCR83nNFvU1PsFhS1YJXyR2LfF7+zN99ZnKlDVbfI20uJNAMzSqRQKhuriUpfCEBCIlK+6tYLG78LaGfVuJpIco1XyDnI5Pjc8HKSfNPcju77AImvwYANtWlXCmFaiUEeJ12iagI2SF6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2Kfk6R7; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2Kfk6R7"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e05f2adab8bso689768276.1
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303119; x=1721907919; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fs9uBDk2AKuSpZ/cJ2wKHccSIh0serP7VMqC6HxMKvM=;
        b=T2Kfk6R79rAj9qDQrgaUB6lbg6GUglENmm/1NY+oyOy0oDa437QUQDwFGis3kMz5u3
         k4DSCJ8BuDxb2w8Anu+J9zzELBs0iV605vXmLjA9wcJlex21OTc0Mit04rAlU7nxkHgT
         8lOmSWNtj02FUefXaldvy4ui/3W94xAcVQeu3Ry6vG0FJtsLs7wteCnMgceGBEmJ7a2d
         GSAsx0oALZ5cuk5uU9BzUMki44x2STR67DEJgriMA1knvIBLNpa/MKdO9Mq0Y/FVkTye
         zVignzufQygcnqcDS9jZYpchGe/aqfCokTktMweFXtvma+ChTfF7ccuFQ6goOwLogPKw
         fOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303119; x=1721907919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fs9uBDk2AKuSpZ/cJ2wKHccSIh0serP7VMqC6HxMKvM=;
        b=lox7hatMWn1QvDWUFr8VsDLu5gl4RptBTmX4P5AzvOAxjw1X9fBf8L6lI1K9ZoO88B
         D6n4xVooaaEGPafbbplGFZZwiU8eqCopNlc/W3LdfRLsPjyRJ78WPN7FIbNbG8S8cg6j
         XGvhZNB4XQOfrxv7WR+BaW2JbLvJsB0xRGbgOiNVBuc8edfXWnxW8Gz+GjXk5BGJwmF2
         O9jYcJO1hfvBFEsKCWofm9MJaLXFwch3GF3Kl5OMkznmBHPGUEWu7VCJLcaXldA+INJM
         csr+BDKDTI15jv3t4vV2QCe4XI+YVjrWxplDrARn2E2CvFwryb+W0Il9FzmHoSv88w6V
         QF6g==
X-Gm-Message-State: AOJu0Yyj2ueoaxiEMhdT3nNyUCcavh/qI/uM5yIYSs5qVBtiuTE+EmbN
	86kW+wp02YGfZIb3X02o6Yj2vEGlGjcD28hTZVsrAtXCCPgaETOl9OobTw==
X-Google-Smtp-Source: AGHT+IEiMaKUPLGkZ32DsDmC+kQyybzv1YCb58M6LLwHRU0tE1aukkEtYMyXAIphMkRFG5N+rCKBaw==
X-Received: by 2002:a05:6902:e0d:b0:e03:62f2:8294 with SMTP id 3f1490d57ef6-e05ed798cf4mr5473495276.43.1721303118668;
        Thu, 18 Jul 2024 04:45:18 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:18 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 00/11] Refactor to unify connect failure code path
Date: Thu, 18 Jul 2024 04:45:03 -0700
Message-Id: <20240718114514.2916258-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 * Combined two earlier patch sets (autotests and netdev patch)
 * Call netdev_disconnected() rather than handle the logic manually
 * Add new NETDEV_RESULT_DISCONNECTED to cover any disconnect issued
   by the AP during the connection stage. This cover the 4-way
   handshake or key setting, or anything in between.

There are some additional unrelated patches, and more autotest fixes
that were needed as a result of some prior changes

James Prestwood (11):
  station: print unknown channel number in neighbor report
  netdev: add NETDEV_RESULT_DISCONNECTED
  station: handle NETDEV_RESULT_DISCONNECTED
  station: update logic for handshake failure
  netdev: handle disconnect event during a connection
  eapol: move HANDSHAKE_STARTED_EVENT to eapol_start()
  station: add handshake-started debug event
  auto-t: add clear_events() to IWD class
  auto-t: add reason/test arguments to hostapd deauthenticate
  auto-t: Add deauth during the 4-way handshake test
  auto-t: a few random autotest fixes

 autotests/testEncryptedProfiles/ssidCCMP.psk  |   3 +
 .../disconnect_during_handshake_test.py       | 112 ++++++++++++++++++
 autotests/testPSK-roam/failed_roam_test.py    |   3 +
 autotests/testPSK-roam/ft-psk-ccmp-1.conf     |   2 +-
 autotests/testPSK-roam/ft-psk-ccmp-2.conf     |   2 +-
 autotests/testPSK-roam/ft-psk-ccmp-3.conf     |   2 +-
 autotests/testPSK-roam/main.conf              |   3 +
 .../testPSK-roam/roam_ap_disconnect_test.py   |  12 +-
 autotests/util/hostapd.py                     |   6 +-
 autotests/util/iwd.py                         |   6 +
 src/eapol.c                                   |   4 +-
 src/netdev.c                                  |  19 +--
 src/netdev.h                                  |   2 +
 src/p2p.c                                     |   1 +
 src/station.c                                 |  39 ++++--
 15 files changed, 184 insertions(+), 32 deletions(-)
 create mode 100644 autotests/testPSK-roam/disconnect_during_handshake_test.py

-- 
2.34.1

