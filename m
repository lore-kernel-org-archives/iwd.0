Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DCD33F8B4
	for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019539; cv=none; b=kpFoSWtQdj6mcuQk2wF3EW00BxE70tKe59xESPl80O+qYAA0I+xnXvVh63ZApyszAGFm77lD5c4zo1FZlA8oCeS9xHLNl30Lj7R9bNmPvQHUYMuUemw+wr9862JOSk9n0dBqhqpD9IDrpdzcOE0HhZ9IwlImjvGZlR8sYAPSnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019539; c=relaxed/simple;
	bh=Dv35/HEVfGZs2d3IhUEJtKBCq0c8yK1+Vk4AFPJWxpc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XhoxKtlQwut+aAVy8DXFmIOb54+j/f3GhI34XeEWNCmRzACGFzmpI5+IxZVqTTlEVwjNO6yQcUxCudAOZt7n7zlj6CAwjE4Sqt7E6QUQiZgzzoHI1pdVQF98YrNHodJcJc0xS8/u/qeo0K8wzTDn10JJuJ1YNQpC5EVa88sgnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=i24xpUDr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="i24xpUDr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so80130135e9.0
        for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1777019534; x=1777624334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LH7UIrIGoltekZ9eEF0ie7xhiOgWuo4MBnsg4XL6VXc=;
        b=i24xpUDrRvLFX1WJ7HhdKpJNiC9X7KbN01hTTG/QFbi02P5nS7gMFL7TYE+nv+hpje
         DV+3qLifugxR+ajqnPKkK6fToiuwG8QM1ANbptEgZrCUaRe10Gl3LSJoxZGsIeODUv7+
         3BQTNZtYG0R1mpayu2IMPKVXFwhJRsJmXt/a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019534; x=1777624334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LH7UIrIGoltekZ9eEF0ie7xhiOgWuo4MBnsg4XL6VXc=;
        b=moTjCRDfQa7M3CcMjNEjD8bocZS9QFhxGk5MsOw+CATrPYECrbNzUtIA0njKGjmkmS
         WpTgoo4WqmdCYhxBk/Pqd1fnW5EkR47lFrPlC09F7cQAjkieIwqageWL50olx0ZwTAKl
         jNlKpM/Hre/djmHHUhVbzGC1zb1Da2faQFJqshiSOBVh5cKFh4yAc7sPDrrbzIcXDDoP
         IoIj+SsAlHAjjr7NMgjjZvUKiPZwqBgRpILZprlEIU3CMScaAb/nUFpUoEiPSIqyX7GN
         Q+gRp+r5/PUlvR75XUvdPs/0ViAecvj7RuZrtUaGVRrRlyPj5cXOQsxiClf4TZUPXzze
         4bLg==
X-Gm-Message-State: AOJu0Yz+i3GrxoiIEwGM3+LzIdm9chAj197+xbbXw4R2REitIVMpsBlD
	m9HmE+N1S66F9E7FQcWC6kKSHhFwOHK84sI7pt0mcybCX0nkmoiI2P8niP9VdGacqx+bPJWHKty
	pdpHV
X-Gm-Gg: AeBDiesCS27/RBPRy46LcU/dfpc4PgiAKNEuniQOOZ0aVF2UwXhRFDJEA9e3bj6ty+M
	sx87KBkGPWKSxQ8Um+AMsCaXJAOkEuJekvgfc4GzJxGDiuXCwxE+27PA2OY1MFAK88ON3kRgdGF
	x8sxcIfINIaD/z+r1h82rupQlF2As0vqWG/04GLscM6JQZ9FnZHj10j+zisfU0zMT51oGLKVzGg
	Fa/05dTefYns/INNdLb7wuaa5ItRrcnPRCGQ6j7q7MQYO59m6F09G8O3oEjSBp0YFsxDyP+yU8P
	Q6gBN9Xe2/9wpbzaNooCvAJDLCiHDkHC9oLYdYiznV2BFsryg2ASd2h4rJ4s4ew+IEh09JpxgTI
	iLRCagFqlV3wgAPbiPI7KwPNJQY+r9u8UZCi+F5gkSIHgJ9GSeWPae07hRFn8K7/eegyKCtLttO
	R2WLN9Lm/hh5sToMJmAMhlrgDvPrwyEVQGzdmpN22Xikl606tJKi8LKs9Zikk+3gUopOOGJyxgI
	nW8TxrA05qgvG8P+uBrDdb1MuhXnZ7Pgp8oXu+LzhSokSzT8Tkrp0PobQCGH75bm2C0HSzkoHcG
	KrnyWec679g4V8K2ipY4zCkxlTv3hMDoGKyy/oeSJgSky920OiwA2UDRFJV0l9ZYQSM9Kh02rxI
	Dv7pFSpPgwA==
X-Received: by 2002:a05:600c:797:b0:489:1a3a:9e45 with SMTP id 5b1f17b1804b1-4891a3a9f38mr192919005e9.26.1777019532943;
        Fri, 24 Apr 2026 01:32:12 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-8de6-cca3-34a7-690d.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:8de6:cca3:34a7:690d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm601386945e9.10.2026.04.24.01.32.12
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:32:12 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: iwd@lists.linux.dev
Subject: [PATCH 0/3] agent: add passphrase storage options
Date: Fri, 24 Apr 2026 10:31:56 +0200
Message-ID: <20260424083209.383093-1-m.kurz@irregular.at>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an agent API variant for PSK passphrase requests that allows the
agent to tell IWD whether the passphrase should be persisted in the
network profile.

This is needed by NetworkManager's IWD backend for profiles where the
Wi-Fi PSK is stored as an agent-owned or not-saved secret. In those
cases NetworkManager can provide the passphrase for the current
connection attempt, but IWD should not save it into /var/lib/iwd/*.psk.

The new RequestPassphraseWithOptions method returns the passphrase plus
an options dictionary. Currently the only option is Store. If Store is
false, IWD uses the passphrase for the current connection attempt but
does not write PSK secrets back to the profile.

The method falls back to RequestPassphrase for older agents.

NetworkManager-side draft MR:
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/merge_requests/2402

Matthias Kurz (3):
  agent: Add passphrase storage options
  doc: Document passphrase storage options
  auto-t: Test transient PSK agent secrets

 .../testEncryptedProfiles/connection_test.py  |  27 +++++
 autotests/util/iwd.py                         |  14 ++-
 doc/agent-api.txt                             |  12 ++
 src/agent.c                                   | 108 +++++++++++++++---
 src/agent.h                                   |   1 +
 src/network.c                                 |  12 ++
 6 files changed, 159 insertions(+), 15 deletions(-)

-- 
2.54.0
