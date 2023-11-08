Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F85328A7
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx9MET5p"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d0760cd20so9262836d6.0
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464119; x=1700068919; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9eupdBqTqAszwIrocSgEH6akJ5mka/oW8dxb6rMGCg=;
        b=Gx9MET5phdGpvdd4vOoXcqrY47h+71BYeeF/GUMxt/nnmVUnbduqQA8oj9R67VJjOx
         x/G/ahsDwNYeCHc4LgGeDEIPspuZVoLfcn2YOCzcyfiwHeW9qoy97MGB6EY8baIpU7/w
         7c3p9egoZ/Fku+VhaWZJtkvH/n5+hEKn8YBGiUupEv5VE52FInIf55nqkhO7wQB/TOoA
         b211yVxbwcz/wttf4w1BHJnGWsmfJGBRwBwppSx07+ZE1QCiFFi/PzRQXlDGvM2sUib3
         ulAXqbEoGnTIpI1QY8kf2os9CWreOWA3TbvVxRWXhpa+cbEasoTud5dIKyB9Cw9K3BVH
         PhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464119; x=1700068919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9eupdBqTqAszwIrocSgEH6akJ5mka/oW8dxb6rMGCg=;
        b=cGiiDuUAOYhXbERZv9gfTLi8xw2sztgj/SAqelZ8GMiOpCSZDhBNdnHNTahmvxf30U
         aip/9H86sMzt1X6feocLqJNhEgEau/O8fYXHX3D5GG/hmLQeYca/ZORbCmTzwYn2aNq1
         /tDcYqC8/iNt/QqxZDaFXmH/Vbu4UL3TVjuOzetjqddaoLBT/cOUAHNnF0Apcz6MMpHr
         YLbOUGMxG72lBgByfraYVSJp2femZxhyInL3eHK3CkEbKUPGDspBRCWwE82dO7fyrlmM
         EFZMNRCaRiJH7R9b1NEA2iGsfD4hDo4orzYfOvk1dU1ciQb93ecWJ9iExaTu/5KGoUgb
         yKaQ==
X-Gm-Message-State: AOJu0YwKMjbnaooKZRt+uvmXIrBiQlR/ykEZG9tH6op7ahUoUcLcjQcz
	ar3HVLhfFz/Z4/UiFos+vY2oFQt1ZjQ=
X-Google-Smtp-Source: AGHT+IGaSW4zJLhPkPDHhdy3ND525VYHJhIN01PosZ2vOfdQLpNx5RtIaROKdfRxE/zSX12JpY8/ag==
X-Received: by 2002:a05:6214:51:b0:66d:6a92:16c2 with SMTP id c17-20020a056214005100b0066d6a9216c2mr8077868qvr.8.1699464118862;
        Wed, 08 Nov 2023 09:21:58 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:21:58 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 00/10] DPP PKEX Changes
Date: Wed,  8 Nov 2023 09:21:45 -0800
Message-Id: <20231108172155.2129509-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
 * Separate the DPP/PKEX interfaces using a new enum
   to distinguish which interfaces is using the dpp_sm.
   Similarly added a refcount to the dpp_sm object so when
   one interface goes away it won't destroy the SM for the
   other.
 * Removed unneeded checks on the identifier, and added
   some:
      - Assume utf8/null terminated when coming from DBus
        (just check length)
      - Validate utf8/length when coming from the peer.
 * Enforce any user-disabled bands when generating the
   default frequency list.
 * Return error on Stop() if not started. This is an API
   change, but I thought it made sense so its very clear
   when Stop() is called on the incorrect interface.
 * Included autotest changes.

James Prestwood (10):
  dpp-util: fix typo, 'REQUST'
  dpp: introduce dpp_interface type, prep for PKEX
  auto-t: fix testDPP after Stop() change
  doc: document Stop() correctly for both DPP interfaces
  dpp: initial version of PKEX enrollee support
  dpp: initial version of PKEX configurator support
  dpp: Add StartConfigurator, PKEX agent support
  auto-t: add utils for wpa_supplicant PKEX
  auto-t: add APIs for PKEX
  auto-t: add DPP PKEX tests

 autotests/testDPP/connection_test.py |    9 +-
 autotests/testDPP/hostapd.conf       |    2 +-
 autotests/testDPP/hw.conf            |    5 +-
 autotests/testDPP/pkex_test.py       |  209 ++++
 autotests/testDPP/ssidCCMP.psk       |   12 +
 autotests/util/iwd.py                |  152 ++-
 autotests/util/wpas.py               |   40 +-
 doc/device-provisioning-api.txt      |    8 +-
 src/dpp-util.h                       |    2 +-
 src/dpp.c                            | 1722 ++++++++++++++++++++++++--
 10 files changed, 2056 insertions(+), 105 deletions(-)
 create mode 100644 autotests/testDPP/pkex_test.py

-- 
2.25.1

