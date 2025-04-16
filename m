Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE7CA6B
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806860; cv=none; b=W3XVPItTx4F5M5EEm4/xVkzkEk+lzW7FjRbkQbZZMQAds9ILMHytzKNfVl7tLvkaza4Bne2wXot6VKqgJsidC9yipD70BB55KCYVXEBwu6x3pz18YZk9TA1lLdiG3gkzpvWviVlXw6+VaNjXRALrRFf+6g1z4ftkg2Y55NYN0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806860; c=relaxed/simple;
	bh=qVR1AS3v9gQDPv4ONB+jhyh/jHW9TY89lKV9BEI3pAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fdenKQrdWhtfbseJRCWEBznWA7gaIv40cTJlp0C3JF95G3j8kSwMHnO5MkyqCHfhGtgrJ+Yl3NFK3id6CxC0/vOIoiX/KpFnFbR4wMWqEEWP7F/3hBASLaaiQzchPfQFfiwzIGS4KhmZ1EulqTDeYtX12Dg+5VmBGhTKq2fVDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNXDfm4G; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNXDfm4G"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso6354517b3a.2
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806858; x=1745411658; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlRY89FVuehqC2se3vmldzUOR9RVMfzzwRftgmgrSf8=;
        b=GNXDfm4Gmf4xLqhHytDiEAkj8ep3q1SaO2Eg0UbuNDvtN21opC28LpEJAj71iZBxJk
         3dIpdXlyuVe2DaE8pHajRP9+5RaavEmCYhbiMo5Xo7Pttj3E+uKL2MqI8pLd0pOFqATU
         1hlgQI9SXqkYW+UHaLK5no4bsuEh1vhg0hdz5Kylux4UaA3VGd6bvDHir7PlXm+Zdzam
         JDDfWYpld+m56nHWYpYAxjHksOE3AHEHQXpG9h9nvhxoOkKvHlTSKHVspQAirkOh60t6
         JNEQ93qgcC1o5fEgKMU2NS0cMfqdjTvN9XIaI4OklLM7JWpiv9stpSraRzITBJ0ReSf7
         EooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806858; x=1745411658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlRY89FVuehqC2se3vmldzUOR9RVMfzzwRftgmgrSf8=;
        b=s0oGmEh8hP/SF749VOA+04wspH36vwcD07GtiacY8KzYgLJEuWNEiYyC0lQW0TYiZh
         4VwtivxVdLS6a9befWOKv7fIzhYG++UWvNgKmuqRbfKjl4I4jZjI/BrXrp7MBwUGYZMP
         q5+GVVXWImwy4o8uNBV0M5kt68DAHQO7prjN4ueeiqDRsuPFlkjRbotAlsGY5wB9U4V8
         x6rl8UUldtkm3zjOKfIbQvFPYYgLsNcP/ThrIXIjkMqmw8IJOU8v88sERmGmminXrW57
         /CbtwoFWVwKu0lVqT1e+yVZ5nU3CeHfZgpnw9PdK7PYM9ch1d26M8MdDTN3VmUUkxl8B
         hSfw==
X-Gm-Message-State: AOJu0Yxlz+06QxofaJ1fTyb+UA9F8ZmWkwiLdCwZbaBx+15MzNpSHE1+
	oNZyArVkYMO3dbFdXi+fwd/beDYOQgrv2STw1VTI8fxbffnYxT8KtaThPw==
X-Gm-Gg: ASbGncuh2sFdaj6iESlYHhTT9MWB1tSfOWFPlN3v65QdwasTXCCnAprvZ+Q04+Qy8WV
	/oruSxGOSb/QRORqjhIhAiCwAxbXCd26QNdxchASFPK3ot7snXg8u57fNzj58gxEQBxHsvN31oE
	c2lXDccZbNAUOKUFO2+JgxyD8ij5kR93f0oNVm3EUl2cyIe4Nbdul11aoEy4A3ZZ8nvAiHSeDXM
	wdCemfB3xITL5iv/dAahqzP87LMhBv2FzbSX8rsuSyRU3fuayhkstjt1F5Z7pGk4yCls9eUBxeP
	yOSTq2gKkiXInPZzEVT+T2ffwpWqIXZsSVW7PbpH/x/OFHA52gmd0WBHbUfle2RpqdV32G06QSB
	3UobD07nEj2ukzzZaxMEiEB12vbE=
X-Google-Smtp-Source: AGHT+IGL+1v57W8WcgTA1AiqLddCYq61HSHU5S+zSc/RxBuyU8E5yMc5mK3UqjT4xmRHa278iD89yQ==
X-Received: by 2002:a05:6a20:c901:b0:1f5:8f65:a6e6 with SMTP id adf61e73a8af0-203b3fc27c1mr2454546637.27.1744806857880;
        Wed, 16 Apr 2025 05:34:17 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] monitor: fix spelling Exausted -> Exhausted
Date: Wed, 16 Apr 2025 05:34:06 -0700
Message-Id: <20250416123414.114231-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caught by codespell
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 76eb2db6..14a29eab 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7433,7 +7433,7 @@ static bool check_pcap(struct nlmon *nlmon, size_t next_size)
 
 	pcap_close(nlmon->pcap);
 
-	/* Exausted the single PCAP file */
+	/* Exhausted the single PCAP file */
 	if (nlmon->max_files < 2) {
 		printf("Reached maximum size of PCAP, exiting\n");
 		nlmon->pcap = NULL;
-- 
2.34.1

