Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72368B91
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGAr/KQa"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f0f7e379dso3766376d6.3
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702580625; x=1703185425; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0otzcxbaBsJz9NnNV1NqoGgwhH54vYqJOotmZXaHNQ=;
        b=mGAr/KQaoxVOAUjjDe5uA8HJF6Ttm5HvHX6OmpCMyJdA2PAIMYhW2zWtydESsONxhw
         7rBTdTrr/JNP4BBD7Akc7fYSB+s2vyJT5nFyNft4HoMXKq7E9a7+EgCh+PuM6NoYiEiz
         mhsjndI1ftyHTfBRdYPWVs12Z/TQE9VSI6B17Nd2ynIeZTBMUYUYxDFVA1iOQ8ssDiOb
         BJDHWlKN2xybx175sxS+uHi+pX23hAe7BVAIbtQMYWWPItoie8/6ni+Q/qxeDkwNSJLJ
         4sJDXNhUkgq6Wmrf0F8exzI7/j7xI5TywDqkZHpXHepeFqvEE6F8FJDP1tMTf9u0/3g8
         Iprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702580625; x=1703185425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0otzcxbaBsJz9NnNV1NqoGgwhH54vYqJOotmZXaHNQ=;
        b=hsTnoKC31xHjqJHKbFpAsUzaOY/LrNC806HS7vHOJ7UPTEjQTLyVHSdcvIKWOFP/k/
         gm9+igfb6dzjYmphvKo3BVHT3AYz48mTxdsqqPlf/HlhgVEZVuCMwn4Drw4ClBKaP1oq
         rWw8ruK/HupY7E/gDPzb7DA7bjvvrBSWhusb9fZLou4Egn03M1BaoAx8BTAdGz6uqXi2
         wCuwKsuG1KYOVBHLmiGI76XKgz9VQaogkN1HO4Xye7ovPG+wBu/1ZXsG6KHFDjx8Hfn2
         xPxWSBRWqcwMPmSHWRbEe6hx2in1IKu9srZKlKHnns8g6B64ZEKkxGLhFU7G+2nz2FUy
         mwNA==
X-Gm-Message-State: AOJu0Yy/G0GxCpi58sH0PODImN8ykYbdrLR11Ry3JjQiI0Pj2AGhwUtW
	GYaPioAWCasJa6gmHj+Z0dZ8HySAsSM=
X-Google-Smtp-Source: AGHT+IHkf2I9WHpM24Kxv2rAgS20FaPxq8WIQYH5ghpP3OEyOb/8V/NbACtU3acCf7oJwblg3/p5lQ==
X-Received: by 2002:ad4:5c83:0:b0:67f:425:d20f with SMTP id o3-20020ad45c83000000b0067f0425d20fmr3677243qvh.90.1702580625245;
        Thu, 14 Dec 2023 11:03:45 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id re22-20020a05620a8e1600b0077891d2d12dsm5496591qkn.43.2023.12.14.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:03:44 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/1] Retry when ifup fails
Date: Thu, 14 Dec 2023 11:03:39 -0800
Message-Id: <20231214190340.133011-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some background, at its core this is a driver issue. The problem
seemed to happen much more frequently when power save was disabled
while the interface was down (this was reordered in a prior patch)
but I've received two reports of this happening now even after
that change was made. The driver logs are the same in both cases.
It appears to be some race between bringing the interface down and
up quickly.

This issue seems to have cropped up somewhat recently, in the last
few months (or nobody was reporting it). This specific code path
hasn't changed in a long time so I suspect other IWD changes, or gcc
variations slightly altered timing/scheduling and exposed this ath10k
bug.

After applying this patch I did see it happen again and the retry
was able to bring the interface back up successufully so to me this
seems like a viable option until the driver is fixed (if it ever is).

I do have an open thread with some ath10k engineers about this.

The one occurrence I've seen since the workaround was applied:

iwd[1571924]: src/manager.c:manager_new_p2p_interface_cb()
iwd[1571924]: src/p2p.c:p2p_device_update_from_genl() Created P2P device 15
kernel: ath10k_pci 0000:02:00.0: wmi service ready event not received
iwd[1571924]: Error bringing interface 14 up: Connection timed out, retrying in 1s
kernel: ath10k_pci 0000:02:00.0: Could not init core: -110
iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
iwd[1571924]: src/netdev.c:netdev_set_4addr() netdev: 14 use_4addr: 0
iwd[1571924]: src/netdev.c:netdev_initial_up_cb() Interface 14 initialized
iwd[1571924]: src/netconfig.c:netconfig_new() Creating netconfig for interface: 14
iwd[1571924]: src/station.c:station_enter_state() Old State: disconnected, new state: autoconnect_quick

James Prestwood (1):
  netdev: retry on failed ifup

 src/netdev.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

-- 
2.34.1

