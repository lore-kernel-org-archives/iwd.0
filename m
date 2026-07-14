Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E925CC57
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069454; cv=none; b=SHbP0daJZIOiEUHCLvU462w4/CwnTJR242kQtw8IbnIFETPaQjNvgr5XA6jeLw8/Paf6GGfsZhdLlTourD4+ukhI1wGZKAyyZ94QzcLoqhY4V0zKBMyWSHq5UzZoog4Em9FCMdM6Ne7voxH/VwqC9msWJc5uxH2MSIoeaa9dkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069454; c=relaxed/simple;
	bh=M2FfY5nWfNnWuMDJFIOzlc3fo+mUFOOGOU07kEfUXXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xgx0YR0YgsoaNVNrK/aD5oF3s15WmefXH8ToXrmEkRPrF+MpKlPyT+h2O+QAQI41RkR/r55iRWAlfjENQybh+qe6pQBCvh/Qri1GIIVqv6S29ygIJcb8s3bo8p2n1rlwND8XjMQmBj+uid4s5Ci8toRwlpnkB7a8jaw2UChOoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm3VN7/C; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm3VN7/C"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso4447868e87.3
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069451; x=1784674251; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4JRpeJyN1+2FJe4KumW2C0bvIhWKXqKAoqpwddebiKk=;
        b=mm3VN7/CCISfSqrBnwWksjAyhO7T/V9Daa6RgwMXXRQrIv7OOBJRxRMaA8mIq9yoet
         tQM6TsUKkPNvosSAEJVyQ9cAlDgzQRfPQ0PAzSAXZrJfW/hKdsqTGYCUHNcxWWGZzX8j
         P/6wYrOW3/ZZNHLF6oLWt8f0s3eIbz14EdTHXFy5mSEN/pL2G1sa6cWVzBh4BHBLhwEI
         Wit2mfs4C8zSkCPG0mY3QngPEDcaBMMbjggm91j1jb330BjVIVyVSZskrhiq3Pkrkagl
         4uPz1/FSmmL+PFTugSkavOPzEG3gS7wtQRDe6Ar74UbAOzVYpa+0DV6RJqU1k2gSXyme
         EIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069451; x=1784674251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4JRpeJyN1+2FJe4KumW2C0bvIhWKXqKAoqpwddebiKk=;
        b=alWM3wF1YTIDg+Ndg8OSfva9e9soetGN5C3+CC2bHerZ+X1A/4/2d4Qy9yTuTx7VVt
         pnlkUaRL8t0yJqHbXDDScnM2B/o4o08v8Xsc9sjiWECl6W5rNCUp9rJmPJXDqMLRa/o9
         nP7T0kYOv9IDtnn/LybBJKE5KWhcQLX9TUtM+ktYPyzQU7hUs0x8hhoA4ex5e2WHVv+w
         icKwy3yuf4MT9paLBShUPYc39taUrAvEFr5nczyXsVr5P9ZOhj3McE6TvdrLDT1xLONF
         wPP/C5dsV6sX4olWarizR/+ThBynwXd9sDY6AuZAM2oeSLgvkBOP/HB66LG+ZgikRUaR
         YxEA==
X-Gm-Message-State: AOJu0YxrCGIlkoJ/D3jsz8W3Gq6v2q5jmyc94f5lQkbK/4RXz8rvpUk+
	eK6odomyKjuJeyCoL8Q0RCN87aDnkocToPVOM+9TtImAJ2fY5ZZtk6yIAKYeeTTqmto=
X-Gm-Gg: AfdE7ck9oEZY6tZC/lkEZ1oquMC/K/05ndex1wgTr1qH4Wn/uP6dqfdesh+lKKKuMUB
	faLgwP+Qo/tuvaaO5kZQVibAYeHH+C8g51pidL+kCa7femmNaJHUdL9JuA9PmKexfjUaTLf4o3I
	+qJjTTd7c31fHK4R+KjTAoIz//ulgJg5WribebAHWZr2R9ZtvmVqwKmREyK1B/cjc0ylW2YZCqq
	L+hweP7hO0kKYTNjvfTa0ZJByWxN2CNl8sqFtFQwdXuyppaHrhrCEOsbeSMXQgxazD9XLn+c6CF
	Y5Jyxslk6Ejs/R6tphtGGenSG5rRmkguEwDufTOzWW56qF5gvL+pPAXi+2ee8PQ6FNwiFWRX5Py
	msEdrvfLnNkMbSyCK4IskCvbbtcTpnmVtN/vypUZSRM1nMLqViB6yZoLOblThzcgdVHcxmo3h7v
	iNpLDnDP8WVEUxA65mChA=
X-Received: by 2002:a05:6512:6185:b0:5b1:4fab:fbd4 with SMTP id 2adb3069b0e04-5b159b8bbf7mr790191e87.59.1784069451156;
        Tue, 14 Jul 2026 15:50:51 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca9ddf0sm3791060e87.50.2026.07.14.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:50:50 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: [PATCH v3 0/3] dbus: expose per-BSS RSN capabilities
Date: Wed, 15 Jul 2026 01:48:46 +0300
Message-ID: <cover.1784069194.git.aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784062938.git.aleksman4o@gmail.com>
References: <cover.1784062938.git.aleksman4o@gmail.com>
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
  - The upstream CI auto-t runner passed the v2 series.

Changes in v3:
  - Shorten the auto-t filename so the generated patch metadata complies
    with GitLint's 80-column limit.  There are no code changes.

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

 .../testBasicServiceSetRSN/bss_rsn_test.py    |  70 +++++++++++
 autotests/testBasicServiceSetRSN/hw.conf      |   9 ++
 autotests/testBasicServiceSetRSN/ssidSAE.conf |  11 ++
 .../ssidTransition.conf                       |  12 ++
 .../testBasicServiceSetRSN/ssidWPA2.conf      |   8 ++
 doc/basic-service-set.txt                     |  23 ++++
 src/network.c                                 | 110 ++++++++++++++++++
 7 files changed, 243 insertions(+)
 create mode 100644 autotests/testBasicServiceSetRSN/bss_rsn_test.py
 create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf

-- 
2.55.0
