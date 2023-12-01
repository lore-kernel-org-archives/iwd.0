Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EC63D1
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2boNIDn"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-587b1231dbeso914737eaf.3
        for <iwd@lists.linux.dev>; Thu, 30 Nov 2023 20:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403272; x=1702008072; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JZ04H0KHd/7CRdIBe8MKFs7HTyUfBrZorKfXbyThMU=;
        b=d2boNIDnnNF7zzX2YyvvaO6EXnrCrqN7lfCJF0CPTPK8S/GYxP25CeF/x2npupHgc2
         JrNP08DXOH2Aj+0/iT2i42miQmJpgu3JHOCb+eZ6NtEWcrEoKG3rgLzqY3OCZUZthwgQ
         lP4L/PHItzZdrWzk+RHWMfXuTzpToCs3HddEG10EQ9MngZDHMkpEldtQ3/jtC7AtffaG
         3CjhoLkqT/RzBljAB2dVs/zLoxFWeBwH1MA6ijtRHjpya+59opU/wyZL0m4QV3MNYKwH
         3mjIuT4etixU2WOPLbCarxz1X57UC3Po1Br2a2n5Txzw9nCznS9S4km8cfg2cL+gF1h1
         q5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403272; x=1702008072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JZ04H0KHd/7CRdIBe8MKFs7HTyUfBrZorKfXbyThMU=;
        b=IGgTZ7nGSN8M1FBBmC3kWSvP1Ct6kjZ3nD3+6GOQkDy524aDANMDkA7ApQSj/M0wCy
         haZA/sMCqcOTABpEoYdw1T4r4tHINaAGo0uiY6QXuSnne5/Xh4uRzo2rwMVf9gXdz36W
         NmRIBiC3RBPuu9JajGVdRUP+6msCnVYWCHqCZ5RDL30GoMGTQRevzftGe4N1raUYwJeo
         xznRuGJd9xzIry52tXJbj7GYm0fmPjeVIPDR2MB6kjDEFVm/FRwp2dawXo44N/wyfpWJ
         tyjEl7sOpWxJrYyFlQUnzFxdepB+Mx8nuLiGJbBMAZxDST2WdHEy+elgc46r4C093OaV
         PPDg==
X-Gm-Message-State: AOJu0Yy5GAdVvhVa3n4VuECLX62c4j7oCHd0vzZpm8k+lSYcknFbzzPV
	1z2mZkLS669vPQnEgncJ23IAUipjJV0=
X-Google-Smtp-Source: AGHT+IEbCHiRbHLFFDQIVd9ArXNmwrbrgA5TdiHalA/9o8Slcnb+bgI8FEeRlNgKqxdmE8PmWZFfIg==
X-Received: by 2002:a05:6820:62a:b0:58a:67b5:2df1 with SMTP id e42-20020a056820062a00b0058a67b52df1mr1815574oow.0.1701403272688;
        Thu, 30 Nov 2023 20:01:12 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o3-20020a4ad143000000b0058ab906ae38sm404005oor.2.2023.11.30.20.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:01:12 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/7] p2p: Use handshake to pass vendor ies
Date: Thu, 30 Nov 2023 22:00:05 -0600
Message-ID: <20231201040020.161143-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201040020.161143-1-denkenz@gmail.com>
References: <20231201040020.161143-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of passing them directly via netdev_connect
---
 src/p2p.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index b66a45cc0bcd..e2d752776cb8 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1550,11 +1550,12 @@ static void p2p_try_connect_group(struct p2p_device *dev)
 	handshake_state_set_event_func(hs, p2p_handshake_event, dev);
 	handshake_state_set_ssid(hs, bss->ssid, bss->ssid_len);
 	handshake_state_set_pmk(hs, dev->conn_psk, 32);
+	handshake_state_set_vendor_ies(hs, ie_iov, ie_num);
 
 	if (dev->conn_peer_capability.group_caps & P2P_GROUP_CAP_IP_ALLOCATION)
 		hs->support_ip_allocation = true;
 
-	r = netdev_connect(dev->conn_netdev, bss, hs, ie_iov, ie_num,
+	r = netdev_connect(dev->conn_netdev, bss, hs, NULL, 0,
 				p2p_netdev_event, p2p_netdev_connect_cb, dev);
 	if (r < 0) {
 		l_error("netdev_connect error: %s (%i)", strerror(-r), -r);
-- 
2.43.0

