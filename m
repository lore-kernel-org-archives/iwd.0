Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA83C0C
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173000; cv=none; b=X5d2K3CEg1lFPOdgKmeBBT/UqYogTr9k5XPWRMiCXB2uGkUKQ9w6XGXano7gNJuUKlql8dN0WONsHHjxHnq+SWokTXdID6u5yVPLpaUYc8oXjk/ivUui8hAKBXYKMa/mkjkUtA+XRo/W52x4wTNdP3nE61gODuaq+iZ+OQ/vM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173000; c=relaxed/simple;
	bh=ZoDKJGPnGKMx36DKOho//j5S6HpC+6EGSHdhC2FaqhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+2gk91HCTt/LdAL2Qu8biPzZgi21RqEbKo+VSf5ynPHTMCRW4/F61JGhejU6lXb1cRd7xIOOQm46bEf2p6lsYHfQhPX86wqRJU7J0gq3gHyDlMbbBhLbTyhmQUaLnTybVBXvchQJdxKauEdu6hviVupeXA85u/0sNfsjsYrrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dePCDYzL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dePCDYzL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224019ad9edso5989235ad.1
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172998; x=1743777798; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EORRNsfPkTWjHTPGcs+V54wVY+ikpXkKwLm6j8BBCZI=;
        b=dePCDYzLsuSueAYs8IRPtlgOcmSoksffI4W8yjtcEpCBFu8zrB2/a0UxHe8znedken
         q/AnjAPHYhvbkJDVYal2dBZZMl/bak/+R2QpT3a4mec3pnXgsPohoDq8u1owpCqJPrSY
         xUMdC1Az/QaR20VCWTyWsJu9g26qZwL4MZVoZtioykSYubTMLmwgOnV6samOG60DPmrt
         TLCDeKpEC45svATngPZ1iwvIkZ+FcIQYB8sBwD7I54yFxr6+K5R1ZZ7VtwJ/0UTojQub
         TWW1mCmRo+ITzD7gzXHpWUZv1c45UQ9mJcruhvjwcWpgM9mfDBRdj+PpzyqC3B9M1/+8
         1/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172998; x=1743777798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EORRNsfPkTWjHTPGcs+V54wVY+ikpXkKwLm6j8BBCZI=;
        b=jnt3dEU2/xlxVT0LtWR7k8vOrKJDwwPMG4fewiG4KoXxXRE9uqGp3eJLQY71Pc85rN
         C8NFqrFbGXMFDvcFbgYKK8MAbC0w7o8KhaUnOqlsxPAwHHabZu6c73i2UwH2P8fhteIQ
         fffKt7+DTolSp7gL70Dn8aZfDpsf12tJrYjTsNrQaSrq/oNCKREwXOsvWEwjOwCiZFfb
         C87UvewuGzyB4wS7TxZ/0yHMzNQp0w1pZ4cK7jF+Cu8Ova7G6CGdUFlA2ZSqGHfAwOCy
         z4etjAj4FhFSaTuLYlLsNGy6AsMtIM9t/mGL8dk8z0XEhjydtEOs1F+m/d3eMjyeDcdk
         EA7Q==
X-Gm-Message-State: AOJu0YyqOglahkbQPA+GKZXXjEWmA4ke5LATNyhoDUrxrxyQ3vcw+ikh
	yFQw4LpBp9dBx3AG+VlBGVk8pBv8l2k+oTY77wXW7+wdf/T2/ZEgCmyLBQ==
X-Gm-Gg: ASbGncuL+elm8laArFMY2YAw47RVkqePsbVwilveyeuj+pBqfdfLNYNFyMFn4guXtLy
	rVZA4Vn0H0zjdOPUlA2xpe5E88xyzNUy2/8SyNcAqGvW0e1YHzu3KgyYylPChN9+xZOSX6lmvQx
	f3GHD8UKSDDl3UT3f8dXnVTbfx5FbARNj/lhWrrcE6v8xftbazyJPgU+zjMzPYXmGO3ksdCeLlF
	IKVhEB9qV1XcQp/qI0t0tZqV1j9njHx8ziQBu+UvvmHWakNC260lZIJ5EmwaXSoheWEUFSAtzeu
	JvjcWFZK6Qn3zROmkoj/J7nZ7LV/bT0jbfH008ixUA+WfMl0GMIt4PvmPcOh62CBRBbx3rRrKPc
	=
X-Google-Smtp-Source: AGHT+IGjaIelmYhsnQvevKD4M6GzFT6FN3vd0ICgxuKLnUmCznKF2aqx8QVCtnVoUf3Yw8QCf7aEWQ==
X-Received: by 2002:a17:903:1a2b:b0:224:1ec0:8a1a with SMTP id d9443c01a7336-2280499f4eemr122808345ad.51.1743172998277;
        Fri, 28 Mar 2025 07:43:18 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 11/11] netdev: fix invalid read after netdev_free
Date: Fri, 28 Mar 2025 07:42:53 -0700
Message-Id: <20250328144253.421425-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netdev frame watches got cleaned up upon the interface going down
which works if the interface is simply being toggled but when IWD
shuts down it first shuts down the interface, then immediately frees
netdev. If a watched frame arrives immediately after that before the
interface shutdown callback it will reference netdev, which has been
freed.

Fix this by clearing out the frame watches in netdev_free.

==147== Invalid read of size 8
==147==    at 0x408ADB: netdev_neighbor_report_frame_event (netdev.c:4772)
==147==    by 0x467C75: frame_watch_unicast_notify (frame-xchg.c:234)
==147==    by 0x4E28F8: __notifylist_notify (notifylist.c:91)
==147==    by 0x4E2D37: l_notifylist_notify_matches (notifylist.c:204)
==147==    by 0x4A1388: process_unicast (genl.c:844)
==147==    by 0x4A1388: received_data (genl.c:972)
==147==    by 0x49D82F: io_callback (io.c:105)
==147==    by 0x49C93C: l_main_iterate (main.c:461)
==147==    by 0x49CA0B: l_main_run (main.c:508)
==147==    by 0x49CA0B: l_main_run (main.c:490)
==147==    by 0x49CC3F: l_main_run_with_signal (main.c:630)
==147==    by 0x4049EC: main (main.c:614)
---
 src/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netdev.c b/src/netdev.c
index 048681f5..b81a475f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1109,6 +1109,7 @@ static void netdev_free(void *data)
 		l_timeout_remove(netdev->rssi_poll_timeout);
 
 	scan_wdev_remove(netdev->wdev_id);
+	frame_watch_wdev_remove(netdev->wdev_id);
 
 	watchlist_destroy(&netdev->station_watches);
 
-- 
2.34.1

