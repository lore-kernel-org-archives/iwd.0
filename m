Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8022BEC55
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063591; cv=none; b=RKL+O2hJEkLjfmQJm5BI0SEzvkJ6LE3TbwbO/nIeNI9MupF1zYenSVpd1jojyUlh49T1jNKxfFHpQ/V7o4zfLPN9Tj9jFbOBOlp+oSHrn5QGGEntW2dpHbDKKb4zcuT77kVhFZUixwSi1+P5PoLjhGXP3uonjn9wNGJPkUNuQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063591; c=relaxed/simple;
	bh=qsXf5k0DIteG6ageANNTsTzemTNRbWROcoFVK+m1QWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPU2Y2uArHCOOfL8u4IlxTRiZ/+fIdEaat7Wj2v0CUB8SgkZ+DoVeshaR8vN/Ak+jeN4OAUCCr3ioBIpj3ixyS1MpAEWfdwzHvhS5frKuaIHlyY6H/S8DijDlUIYgj68VUkUxAJ1N1/22/HyzxcUD3zVICXVKTkE8RGfLbqNbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh4SCfUU; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh4SCfUU"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so1469232e87.2
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784063588; x=1784668388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWFMz4IKU9wqRpvGCO0213YXX1ept/BhRE/sOJAdsss=;
        b=kh4SCfUUFt9NUfsARBdER6BT5i+D79yUuw8aU9apxkRylzn4fmC+ZUO1qxI00rSRPX
         HWMqWUizktLYNCvl2SO+2MqNwDXORONJAyO1KEKb1rV+QmE8LVmiK0J3KFaPXhX/N6AA
         PjnYyFGe1gcDi/kCreTM0VIpBrBZ63cPgc3k2w+yrBUCepHSXq9UnT7syhZsE7trsUUT
         ce9xpsUF3mlnXDQZ8pI9P08vMILXvwChBIm8apkEjPYD3elPLz338sXeaLzoZ6hIqjhR
         pPAkRolDbT2XcAClQUOrIrlKmcWzl/zYuGHOiwaK+lgcnIIIgyS+Uirx25H/LN3qZQHR
         NQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784063588; x=1784668388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tWFMz4IKU9wqRpvGCO0213YXX1ept/BhRE/sOJAdsss=;
        b=Bjxu9Xs4atBhZV+XQnzWHdbaXvMKyjChJYxIeGuSspSGoUpy7LgRhBQ/M2krK5vje2
         w2fEjAOrSSLWaIGyTz9tKb04hyzvz/7dIIxVo1EDpZ690gVgqIXqODYxAfeiwo+kpKhO
         evv/MzimN29H9gd4Yl0DaNQC9Pqw2VaxDjl9i3ETaWWqFrpO1nxvFwhjwdhPklbK1L01
         rWJJ+RxtuxoMeyHstxzMWRzPwsEneEIcvrnk7C5e0iJB/KdTr/t4lDJ+M8nhDWf87SNb
         JMF2liUBq2Sbt7U3PNkCm04SJJbT7yDlmg6Nhiz0gg7902aRQ98NsjBbvTWaf3xXUl2W
         dswQ==
X-Gm-Message-State: AOJu0YzH9lITBI2lcGSX58edMBUvfwNUsdvbxf2PsIJEiQaXTcRg3Cri
	yZPJ7Hm1eSEVdagdO3NUSsOceCoo/RbHeVkvtYAIqV/JhDlj6xGg4ypk4sfQpEUK2o4=
X-Gm-Gg: AfdE7cndVrNb8JV+53PQBZNbEsj0BcHA+DdcqHiqyXreh+96TKXq4ur8agibwKBy0dd
	rvkY9WHTSLkajy5UIDU3vAeAs8Yhq0xiwk1nWfh8AkSCOMZQFtCNdNlCiQCENnm/FulFyQE6J/b
	sQKLrsFXYfCVtb0Ze+/7Iua5k2UQE0rLCyTGyGpiBaDSb9aBaA5O9YGGYyEETjtphDSy+kN/tWX
	GqK8XMPcFQTLOXHOys+wFoSqpPIwpA4VIKk6cfc9q7rz2xMT6ZooEF9CqaEPiOlaSy4S/KQWlSb
	z+476YetFZVOYFqwjBs2jAr45u9V1AyumhySGFiX3tvm2BNmIJQHSLhK3C1fnC6r1ulh4kcAHnU
	5OoUZO9nlF5WjE5zTLCv0T8coFRJUAGZ07v1Jp0fV21JLGLZsyC6BxuAMZpDu91JUA2WD0EJf3e
	bW0gjPh9+1JWL0E+rM4Q==
X-Received: by 2002:a05:6512:334c:b0:5ae:a9ed:162e with SMTP id 2adb3069b0e04-5b0236c9245mr2977590e87.65.1784063587391;
        Tue, 14 Jul 2026 14:13:07 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4f919sm3770435e87.20.2026.07.14.14.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:13:06 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: [PATCH v2 0/3] dbus: expose per-BSS RSN capabilities
Date: Wed, 15 Jul 2026 00:12:23 +0300
Message-ID: <cover.1784062938.git.aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com>
References: <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

James, thanks for confirming that extending BasicServiceSet is a
reasonable approach.

Network.Type intentionally represents WPA2-Personal, WPA3-Personal, and
transition networks as "psk".  This series exposes the RSN information
that iwd already retains for each BSS so consumers can distinguish those
networks without changing the existing Network API.

The optional BasicServiceSet.RSN dictionary uses the same KeyMgmt,
Pairwise, and Group fields and values as wpa_supplicant's BSS.RSN
property.  NetworkManager can therefore reuse its existing parser rather
than add another translation layer.  Older consumers ignore the optional
property, and consumers can retain their Network.Type fallback for older
iwd versions.

A corresponding NetworkManager series reads and combines the per-BSS
capabilities for its synthetic ESS access point.  It will be submitted
separately after this API series.

Validation:

  - iwd builds successfully with make -j4.
  - On a physical WPA2/WPA3 transition network, an initial PSK connection
    was reported as WPA2.  After changing the saved profile to SAE, a
    disconnect/reconnect through the stock Plasma applet completed without
    a password prompt and was reported as WPA3-SAE.
  - Cycling Wi-Fi subsequently auto-connected the SAE profile and kept it
    visible as connected in the applet.

The new QEMU auto-t test was not run locally because /dev/kvm is not
available on the test machine.

Changes in v2:
  - Resend with git-send-email after the Gmail web client corrupted the
    inline v1 patches.  There are no code changes.

RFC:
https://lore.kernel.org/iwd/CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC%2BRaJKsKz0sUivGAQHXA@mail.gmail.com/

Related NetworkManager issues:
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1489
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1693

Aleks Man (3):
  network: expose RSN capabilities on BSS
  doc: document BasicServiceSet RSN property
  auto-t: test BasicServiceSet RSN property

 .../basic_service_set_rsn_test.py             |  70 +++++++++++
 autotests/testBasicServiceSetRSN/hw.conf      |   9 ++
 autotests/testBasicServiceSetRSN/ssidSAE.conf |  11 ++
 .../ssidTransition.conf                       |  12 ++
 .../testBasicServiceSetRSN/ssidWPA2.conf      |   8 ++
 doc/basic-service-set.txt                     |  23 ++++
 src/network.c                                 | 110 ++++++++++++++++++
 7 files changed, 243 insertions(+)
 create mode 100644 autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
 create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf

-- 
2.55.0
