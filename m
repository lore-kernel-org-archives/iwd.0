Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE538911B
	for <iwd@lists.linux.dev>; Tue, 28 Apr 2026 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376899; cv=none; b=ksuQmck0WlskNG9Vp7oaka7ZStXyy1Wg+bCzHqzeaYEXlRNU41oknWc2afVKJ/dbDr1mVH0ToIW3R7MUu+8/Eadr1xPKL72MzhQKxzFViIVABQanUq7a2LXPvGP41iKFZkScJEHCdqViness/Md1YCi/hDB940M+Ds/yLh91Ec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376899; c=relaxed/simple;
	bh=OUwTrWV1wYO2y+aYZt2QXpFpVF6PlE9n01IbEKlNU4Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ipx7Uadr7UA82GFdrjpqyOlnJecfii7za0EaeK6WxIOUQDKmtJqxwb7Spz67986WvU0Z41UaM9Ne3FptQpM+8Hp7seUsb+0myYzsoVDMpvfLfKmwGt2C9kdX4hK8aeGoB0O1Bj+rTZH/hSV8ngHSJRqMKcvDCIFAiqb2bZtAo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=n5eCMjIJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="n5eCMjIJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso156847655e9.3
        for <iwd@lists.linux.dev>; Tue, 28 Apr 2026 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1777376896; x=1777981696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PidOAtL0un3C+leNix8q6G8fJ2wNeK6h4VGpyjxjgg8=;
        b=n5eCMjIJipXt0XVTkh5zL/7o3Gx7b5cBIHQP7NzAXaKDU8pluneSqYEcX0w6Iu1T/c
         feQHStgi0ueYpB/JKZp3yEFVBif4ewSgC0CPH8dvImP7JFl30uELnP35zw0hpZPzNGyI
         HjgVc8bDfS5JqrIQ2578z8xyqmwb7u0+tX+DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376896; x=1777981696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PidOAtL0un3C+leNix8q6G8fJ2wNeK6h4VGpyjxjgg8=;
        b=IPbPOscRcfbQJQ7pDfEyCjkShyCx+Thgn0v0ExcGQiyngXo1GhlmGtBLrGzrTQn2Xl
         kIaQjE37xbBt/qhBW5z8jiZyQ8pNiJJK33oohexxpgMZ2ZKS+slhiVa1Dxr4LBSpEiWN
         KoqAFJjacNMLMV7+K6iXGpSip1CyOphXR9Ykqnd35ungR2Hlk5/hieFYrHOi7fH6CTiB
         Wy+4ltScbBQt6TkT/G11rz5aUic0ZFFB4atAWiggkXfSaJZ78jmvkAXkI7t6mckQT1i7
         yiVwqecNHzslaL3paTsxg/ndgHpqncy72GNR+Dn3hnXjvJZMZL2roOBFQIqdoh2QR1Fv
         QgaA==
X-Gm-Message-State: AOJu0Yxlqa6cKKJiBBLsGC/MzUirNMZRXu18x2aCdId4XZHbacjgv0Sp
	Onn9o9UIzyNenwQvlgTulCzPOHLIlBRfezqVStIcB+qiS3TIT6kj3VVsh4IUd8Y27SnssA4xS9+
	e/Fss
X-Gm-Gg: AeBDieuZcIvS48Tk3dhC33NN9WaAy2geL3h+Mc3qgcXXrfOQ2cR2qWEtfIk6cC97WWd
	sYHDhruv8JCsHd9IqemX3FKVSbyJLJbpeVObHvYtrZrOyzFVvwyhB26roGB97L5+HQ/YbgTCzJR
	WR4magTy2Px4X315yv/MyMPvIwXZACZ3LEpdZEiInxjB9OFMmGlgsoN1fDuJ3pySnGMRbSWZGIN
	+VpqRByjGXQ+tQgMsZehHbKDV2Z/l5Bkq/5XzBi1cdpMhYY4dG3bkB50gPG5ORbibkVT5xA37/O
	f+W+sWlu8LrENVKHbkrFbdzzJrG4rmF475LKS60uQ5aBZTBMCGFhIJooYKltMRz8HT3jYPc8gx8
	hoQkykLB0vs2e+DqyhJBU4VcS3xpF7VlAkZ2b0gCIqzq7lK32qS1ahykblWB8zBkQUIKTuoydX8
	bL74fsZFAaqpp8Kn8PdNT9Y9wg+i1vdmSDB+ngadHCeHyx12RINjevthIPTGpTTUEM6OwLUBABZ
	pDI2zThIPwDDBgmyAER8jBGDEQTnwj1iRRp7CipNYEEzq236fPb10ZMwCKanRJ5LXT/wXyn/SSh
	2Acn1H/ZH/DG9RfALxB9OyA68zXYX9xgSyEtpEAbMjLsNGpe+diU1mqFayEYeP/8/UNYxxVgNOc
	qgl8G5gH2jQ==
X-Received: by 2002:a05:600c:8590:b0:489:1fa4:50c6 with SMTP id 5b1f17b1804b1-48a77b19f8bmr30307945e9.20.1777376896158;
        Tue, 28 Apr 2026 04:48:16 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-411b-7cbe-f9f6-9ad1.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:411b:7cbe:f9f6:9ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775eb91dsm16862895e9.20.2026.04.28.04.48.15
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:48:15 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: iwd@lists.linux.dev
Subject: [PATCH 0/2] network: add externally managed profiles
Date: Tue, 28 Apr 2026 13:47:55 +0200
Message-ID: <20260428114809.75413-1-m.kurz@irregular.at>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add [Settings].ExternallyManaged for network profiles whose contents are
owned by another network manager.

This is intended for setups where an external manager writes iwd profile
files so iwd can read the connection parameters, but the external manager
remains the source of truth for the file contents and secret storage
policy.  In that case iwd should not rewrite the profile as a side effect
of normal network operation.

When ExternallyManaged=true is set, iwd still reads the profile and can use
it for connection setup, but skips profile writes during normal network
operation.  Explicit profile removal through KnownNetwork.Forget remains
available.

This works for handcrafted profiles and for profiles mirrored by another
manager such as NetworkManager.

Matthias Kurz (2):
  network: add externally managed profiles
  doc: document externally managed profiles

 src/iwd.network.rst |   8 ++++
 src/knownnetworks.c |   8 ++++
 src/knownnetworks.h |   2 +
 src/network.c       |  67 +++++++++++++++++++-------
 src/storage.c       |  17 ++++++-
 unit/test-storage.c | 114 +++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 196 insertions(+), 20 deletions(-)
