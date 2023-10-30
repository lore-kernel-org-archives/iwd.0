Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366BF9E6
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXefuXKd"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-41ccd38eaa5so36551301cf.0
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698673724; x=1699278524; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMCxlwfN1TwbqEtAbFOnUzEcUArM+2VW/8atn2Lqf2k=;
        b=WXefuXKdCk70QcLgr8/iBqPLONaP/BWG6P/9VROZGwCzPOiryskKyEaAZmnRDbOcNt
         ipN6i93crpP7hbGKkPxSlXy2/eh3NN+FijXwqhB0Mpyw+LIH+9cmvPiHf58w/ZSNGvtt
         9nOEo/775A6gauMImlzZdad2JlA9+jTuEdnRQKv+K6lud9LYLKiXbwY6A3RXUxiOdgqY
         fnBWD17hA8w3GcnH/Gfd97gp5NOs9OkQ9dPrZc3dPZ4hn2frCWqzftJdbozuI9p74rOQ
         q12fQuwm6wM4YztjrD4TIBYOrk2Rx+zt34OFKKzZ2+CQcSkzyQllgks7nRoe4f/oyWyF
         eaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673724; x=1699278524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMCxlwfN1TwbqEtAbFOnUzEcUArM+2VW/8atn2Lqf2k=;
        b=UUSpOVaaoOilHHHw4BslLPv3BF6QU66Css+Z7DE/EPRs/A/TjCqNE9fCqojcKk7zyY
         WjiT97X5UjvxCAd9wxrH4uJFuXMr6gVZXC4fDYoP1sqnM+SQ//sDb0kNb7HaLNgQwHlG
         AvybMx8cCWp9+tfz92B9ZFEt0Bklxcw8gLuhcrUs4b0WfRe6ZOs4l6EVbwwdHGqqc9lR
         huyUt6ISBSaaYLdU6acmoaEUAZYuMxmV5HXkJwwSuWtcw87l/ZlfcDiJ7lfklKEluzB5
         mGq9J9TBfdoKIxwnrSi7cFKhj6fTW6zF47j5fypgiqkqHAMTvJzyRKP3GFLFf23RsXIS
         Rneg==
X-Gm-Message-State: AOJu0YzLccukfjUZ3xiCoLxR5W83wvQNQmKr2hKqxrPcwX1tstm3dos2
	Q/hsHHrTNmw95ERd2lGyMp+SHDLrxII=
X-Google-Smtp-Source: AGHT+IE4T/Scnba82+H83CVCjz5uyhMiLszwapXs/X3lanl7vlzOsRbe0dV2oTD037rA1128uQOG1g==
X-Received: by 2002:ac8:5951:0:b0:412:1c5f:478b with SMTP id 17-20020ac85951000000b004121c5f478bmr13720071qtz.15.1698673723826;
        Mon, 30 Oct 2023 06:48:43 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c18-20020ac86612000000b004181aa90b46sm3419929qtp.89.2023.10.30.06.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:48:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/4] Packet/beacon loss roaming improvements
Date: Mon, 30 Oct 2023 06:48:33 -0700
Message-Id: <20231030134837.452957-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rate limiting patch shouldn't be too controversial, but the
forced roam on beacon loss may be so I wanted to provde some
background. This behavior was only tested on ath10k, so I understand
if we don't want to impose the same behavior for all drivers.

We were seeing beacon loss events not resulting in an immediate
disconnnect (as I have always expected), still eventually but after
plenty of time to roam. I initially added handling for
beacon loss identical to packet loss (try and find a better BSS) but
noticed that if IWD did not find a better candidate it resulted in a
disconnect 100% of the time. I watched a client for a full day and
whenever beacon loss events arrived they were followed by a
disconnect within ~5-6 seconds if IWD did not roam. This led me to
believe that at least on ath10k a beacon loss is still very much a
sign that a disconnect is going to come, we just have a bit more time
than other drivers. This was the motivation behind re-using/re-naming
the 'ap_directed_roam' flag in order to force IWD off the BSS.

Again, this is just one driver. Maybe other drivers can
handle/recover from beacon loss. If we instead want to keep the
behavior the same as packet loss I'm ok with that (I can keep the
patch locally), or put the forced roam behavior behind a user
option e.g. [Roam].ForceRoamOnBeaconLoss

James Prestwood (4):
  station: rename ap_directed_roam to force_roam
  station: start roam on beacon loss event
  netdev: handle/send beacon loss event
  station: rate limit packet loss roam scans

 src/netdev.c  |  6 ++++-
 src/netdev.h  |  1 +
 src/station.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 58 insertions(+), 10 deletions(-)

-- 
2.25.1

