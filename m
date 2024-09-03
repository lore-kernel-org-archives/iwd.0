Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E018FDAB
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386822; cv=none; b=WhtAZaYWbwVWoanTwF3yHSrZ0nxXccUEt/uotYyxk8n/S4JVxjaaVTC2tNF/XVnFNDpq3Xh+XDaGJL/tpTCFtPe45QlhXtzV8cfX3qkmPoEMdyMP4pg4Ss8L9zKx8PE1wps6SZfX3dSDYC3QltkhjisHixAWXVXvyCUHvMeVBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386822; c=relaxed/simple;
	bh=1lK8htMrTJuM9yw+fHTuRgSrcQFlz1DtVe3JEm/DUAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMUn8QVKhQ33x1AsasIXsEoQWd6hXwj7qh/XCWHxFwPRterVXtLMyTSScI1IrT6jb/1ZCen2nQevFm0DUHFPLsiV6J8p05m91NWXr8MtbKtNeb+mImvWI8buGiP+923Yk08/fLZeH4O5CL0mPb3xjE/mj4jYIiUCD3X/Jz7K0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGdKslwK; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGdKslwK"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c35357cdacso18492896d6.0
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386819; x=1725991619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghbp8IS4SHsOBD2MNWHtUS0hszG9oFKiByzgcx/NTM0=;
        b=NGdKslwKGPJduEP+zHrHPJzKeiAn4uBMepUa2ps2U8bTGe3BHvW0mAYbVFyxhH0fDe
         i/8RqXeonenGP0z8G0OmyagdfapCyVHQzrNb38X9PeU+UmmteGrqXNe+2+0ehZ/pKdkO
         LALoKRhkDawLKOcZ9F22ENscwFi8KToyeGodzfxR9axIQNyXGmzofjtfExqCn7iulmoG
         mWff9gzenPwnHCroYE7nyfwvhNwF9SDC3qDDZ7YzESnG48mGIE9qpx1kznT0MvlzKSN/
         ju3T5PMEz6MP3Q8QH8HfDjemp/rwMIaujqH4yTXc1M7PIGrYRvshgAZlb67hFy44OAAc
         A3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386819; x=1725991619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghbp8IS4SHsOBD2MNWHtUS0hszG9oFKiByzgcx/NTM0=;
        b=PUCBH//FftR+rVjyPHoK23jOnZdf06xps46C9oEaqCP8AQbi0v/trLO+Ka+SVam7Ue
         uia5sTz+RKRfj383qzSlcxdpdA10OQdmhjzIELtjI0HDtdmRcWa5aOZ24mNRMCfgqD5o
         6zieSNk9O3cbO9FOwnsX/3xU5CPoTo8E4qmuHOdeZ+kciGm8PwzUBd9cYMrA7gw+CIdu
         Llbb+0/sYWsfQ87cBBTjg9cILfI2jePEuwB4JlpGUDkz7iImfOUwJrO9GsqM6PoCv6Pa
         ffrTAGrGJwFP5I/asRVtjuYdu+YKxmIwXWUBTw+2ZHfxbCbcRK554EjjQgkMVyjgbAlB
         c7sQ==
X-Gm-Message-State: AOJu0YwcckZXahs7C7G7OZAirVk0hRHq5LkLOvp9WVWz9oLeLySkB1AV
	orCxNNoMeORH/noAIWS057ND4m2j9KIR0GkmoiSnQ6rgbxfjGuOXSy005w==
X-Google-Smtp-Source: AGHT+IHPwqiSzlKkfkhsoT6cTDt1vqgLG7mgQA5nZBZ1gXRLeylcofFr3HixJuuwVFuIqtfo2W2trw==
X-Received: by 2002:a05:6214:398e:b0:6c5:112e:4e32 with SMTP id 6a1803df08f44-6c5112e4f0dmr32147086d6.19.1725386819113;
        Tue, 03 Sep 2024 11:06:59 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340db129bsm55248936d6.144.2024.09.03.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:06:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/2] netdev: fix potential command ID overwrite setting CQM threshold
Date: Tue,  3 Sep 2024 11:06:53 -0700
Message-Id: <20240903180653.205405-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903180653.205405-1-prestwoj@gmail.com>
References: <20240903180653.205405-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of affinities the CQM threshold can be toggled
by a DBus call. There was no check if there was already a pending
call which would cause the command ID to be overwritten and lose any
potential to cancel it, e.g. if netdev went down.
---
 src/netdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 14fe41b4..d95a2a1e 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3715,6 +3715,9 @@ static int netdev_cqm_rssi_update(struct netdev *netdev)
 
 	l_debug("");
 
+	if (netdev->set_cqm_cmd_id)
+		return -EBUSY;
+
 	if (!wiphy_has_ext_feature(netdev->wiphy,
 					NL80211_EXT_FEATURE_CQM_RSSI_LIST))
 		msg = netdev_build_cmd_cqm_rssi_update(netdev, NULL, 0);
@@ -3752,9 +3755,7 @@ static int netdev_set_signal_thresholds(struct netdev *netdev, int threshold,
 	netdev->low_signal_threshold = threshold;
 	netdev->low_signal_threshold_5ghz = threshold_5ghz;
 
-	netdev_cqm_rssi_update(netdev);
-
-	return 0;
+	return netdev_cqm_rssi_update(netdev);
 }
 
 int netdev_lower_signal_threshold(struct netdev *netdev)
-- 
2.34.1

