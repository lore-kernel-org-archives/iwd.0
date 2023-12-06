Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA4130FB9
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqBCHife"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-77f335002cfso24231985a.3
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875233; x=1702480033; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eo7LoRiyFHZnQYNRaVHQRhA860PQqGkYSjurFGA2CJ4=;
        b=BqBCHifeXcqyndb8VU9hoIGdDOUMnliZ8WzyhEcPfYvwmplINoAdxn8GgqV0Vj914X
         ODBlMdKOQZJIcVZDkgNIgK+uCYhr13xj8nF8oh7+T+pv2V++6xBi9ZHSC8oOdKI4t1jr
         cPT7iuuLD3/cFIlv4RP/reXzFsU/ZQzoCgM3d488EeP/KGQJDOUB9ckRzF3J2+7xUk7s
         p5z+uKxDmlDrKFOPu0oEJlcv18V0rXyWrdLLnxhqehWi1KgfxVS8gOEt6S1ypEPse3YD
         wHH/6YIs2JaK88G26TnE1gZhqZ0Tf/lDchJjhQzLiTWry3c0FNV2VJK7jNpgtqsVQV3E
         AZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875233; x=1702480033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eo7LoRiyFHZnQYNRaVHQRhA860PQqGkYSjurFGA2CJ4=;
        b=dPK4GHKmCBeFSNFGH4Bv4TMo5PlnpFGtHmNBRSJ1WjBBAzDdPC8pdoOa+NIdnpKtfy
         78/vADivwVIJU9d6KS4IP5MvB9Lr+pNzB0Rz321omSryevG09JGK6284xR307iLM4fxL
         OCw05c1uHqjk1peRkYd0Wbtylwce3P6kKoGrUC6UX/OlriyunXERRL7yjqYAHiNux1Mm
         fHmuuKOnGtJsInO4NGQedEuddTAFckar6/V+JHyEZUumaRPHRViY+aywojW+8SNzRt4P
         lLfhLTGp7H90SyCMfyl+1gJi3QiI7s8TCcEH6BsTVQoVIRMbujVV9FYITHO3K3SCgqUC
         pQcQ==
X-Gm-Message-State: AOJu0YxQRjntF2M6kZFD1yOVvsmWPnbDimeSK/KlpiB0EKrV5h/c9sow
	sJuZPOXW4Le6OsItTZ/RrIUVoKY1Sjk=
X-Google-Smtp-Source: AGHT+IH9LzBF6yvrdNUPVyH4i27FnCnxA8lxxDIiHJjxwMJ9M7CueO4giQlpP8yuXkA4V+xxJI8n9Q==
X-Received: by 2002:a05:620a:4589:b0:77e:fba3:a23a with SMTP id bp9-20020a05620a458900b0077efba3a23amr994491qkb.148.1701875232895;
        Wed, 06 Dec 2023 07:07:12 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:12 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 0/9] Reassoc/FT roaming unification
Date: Wed,  6 Dec 2023 07:06:59 -0800
Message-Id: <20231206150708.2080336-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intead of adding a layer of abstraction through ft.c I instead just
added netdev_ft_reassociate. I chose not to reuse netdev_reassociate
due to its handling of soft/fullmac cards, new vs existing handshake
object, and its use of CMD_CONNECT vs CMD_ASSOCIATE. The added logic
seemed too complex.

Side note, we probably need to look into abandoning CMD_CONNECT for
reassociation as the kernel _still_ sends an Authenticate frame when
it shouldn't. Maybe at that point we could merge netdev_ft_reassociate
and netdev_reassociate, but for now this patch set fixes the issue at
hand.

James Prestwood (9):
  auto-t: add explicit stop() to IWD class
  auto-t: add association timeout test
  auto-t: only call set_value for changed values in default()
  ft: add FTE/RSNE building to ft_prepare_handshake
  ft: add ft_handshake_setup
  netdev: add netdev_ft_reassociate
  station: use netdev_ft_reassociate
  ft: remove ft_associate and helpers
  netdev: station: remove NETDEV_EVENT_FT_ROAMED

 autotests/testPSK-roam/failed_roam_test.py |  56 ++++--
 autotests/util/hostapd.py                  |   9 +-
 autotests/util/iwd.py                      |   4 +
 src/ft.c                                   | 222 ++++++++-------------
 src/ft.h                                   |   4 +-
 src/netdev.c                               |  44 ++--
 src/netdev.h                               |   6 +-
 src/station.c                              |  20 +-
 8 files changed, 183 insertions(+), 182 deletions(-)

-- 
2.34.1

