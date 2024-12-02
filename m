Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB771DF991;
	Mon,  2 Dec 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183719; cv=none; b=aRnKtSHlKOS0cX1aEgmDX/3FUtollfSznSKc2kNulvNl1bbV1w+gDq59w4aClShM4l3QdYnnSmE2ZQ6oDeUBLoXw16+Xs9O+Uqj9rHpjGLpaj56vVWb7iUH8+04ETVFoCzEZkt4m2jKoGDCB1Lkmy3w38Vyw6K+LHdjrWm793u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183719; c=relaxed/simple;
	bh=LrFGcjl6A5pKWxPrIHvga7JXdxjA9CAxtv0mffI13M8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BcEzpCHSuw2bC9TcSZmxwbD6GQ8ZkBNFY3f3QGq69cBPJMZx8oC8pe9jL6ELR73P9jTFFYwK8781F33MNYkH79yPa0Sje8Ml1pJ8jGxd9JoqewXrd3lL03IkD+Zuj/Xeve6KPTHyD0ZShSvL1y+a8SZ4EMY6kbPZW+wNmmS5I94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC+rYgvB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC+rYgvB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724d8422dbaso4071078b3a.0;
        Mon, 02 Dec 2024 15:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733183716; x=1733788516; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ns+YkfSIbX8LS6u01Nuhq7AUQUdAwLeALoNrZL3mzo=;
        b=GC+rYgvBNdu+SxuXb4qR3Jk725Gan7LwkOfEzD/9Ekmwj2Qhu6A5CvAhcCakcA0rrN
         IFxEGhcCYiIFHqXudqQfmFFX0nqCW4tqVK4Z55oNtZTY/4vFy3hGk3HYSbsX3qu16B0y
         HlHok9PjeXmUfqgtwj6LhOUDLs5fFRYJvpi5Cr6xdlZDkil7mO6lmbQJQqX0scNZYMqo
         8QXxJRCqdgcU0lF1ZFD2i84rKd03LDvjaEqDYIpJPWymQqmnaSq3Fb1b4zpuYW/aN64L
         0FO8pS/cACrfJIoAOTVn6CM9DamjaKd2VWjycwxEILg5NcVQMpzvXXiVpBEmASFnFAEi
         zqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733183716; x=1733788516;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ns+YkfSIbX8LS6u01Nuhq7AUQUdAwLeALoNrZL3mzo=;
        b=rgIsIF0cR+W5Q880jpGHX30MSq50RTsggOmt33SxXm6Zoc/vphbSUJ9w/QDeUQ/0a5
         lbY80SveJKZ/o2J0S2fXxZRk/0x1g8PMMURsiGiujNw+Z/eqnXNdVGwvPMqvRoL7m/XN
         VVYukqethpTnnvXlmgX4/mzgvjSTBB212Q23cYx2oOEUjSz4yMjCr7h5fvN/49Vnp5km
         3j0Hqdi7MoFSZ8HDzuCYcnrggr0qchMC8Kc3I+SkRyJ5MElq7M6WQCGeC4h5WvzM+Dea
         WgHUAWB8CfURQOI5fT8ZrlwvZEF0gaEWBBsQ4CXg6rdVh23yipFnmIw5s7S6sKEUowAi
         UteA==
X-Forwarded-Encrypted: i=1; AJvYcCX5dBuG7qiFqEmd3DVrkt78zUoKJSZ1NGuhCPkmpbrRgPs3MkfIBKCzxaSyqJ6vl0uhW+4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxqZ9fAhk0UUNAf8N6tRtQiSOhqJtFWTNGgIFWirBjyPfnkxWAO
	jZjRTVUN7PofmusRnBoiRyupnuYbbAzKh4TJj7GL/p1rEJ1BT9j3BCfpVBXu3qQ6ZuM/L8egFKR
	1htlO00PPcq1nHjSmO90xTiUmuyG6PxnZ
X-Gm-Gg: ASbGncuId/hwSY/eX7sD9PSD5fjDOtUFOd4SKL4+7ozHRZvqM0NcTpmRRLIsnQIzLld
	YjKWehoxJKh5zWwiaT4tvHQBM0cMOw1mYNg==
X-Google-Smtp-Source: AGHT+IFBzhxBdlEpNqVmXBQE/riWK8nZoCiDUFPxUiULIuxKtilrf5KONVgBcyapWJMA2oj2MMfzW1yt0KcpUF5YWZ8=
X-Received: by 2002:a17:90a:ec87:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2ef0120125cmr753746a91.14.1733183716581; Mon, 02 Dec 2024
 15:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 2 Dec 2024 17:55:05 -0600
Message-ID: <CAG17S_PQBh2ONe8Jv91rosrKj-Lx99U-i11dh_dpQB6qspCypg@mail.gmail.com>
Subject: Captive portal connection with connman
To: connman@lists.linux.dev, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I am trying to use connman to connect to a captive portal. I think I
know the web page I need to navigate to to get the connection
information set, but every time I try to connect via connmanctl, I
get:
connmanctl> services
    GI-Guest             wifi_b827eb52ccd0_47492d4775657374_managed_none
connmanctl> connect wifi_b827eb52ccd0_47492d4775657374_managed_none
Error /net/connman/service/wifi_b827eb52ccd0_47492d4775657374_managed_none:
Input/output error
this is with this connman and iwd:
connman-git/now 1.43.r2.g6bd97592-1 arm64 [installed,local]
iwd-git/now 3.1.r0.gccd91fe5-1 arm64 [installed,local]

Is this what is supposed to happen? I expected a connection then I
would need to manually open a browser then go to the captive portal
website...

Keith
