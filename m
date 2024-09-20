Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF061E517
	for <iwd@lists.linux.dev>; Fri, 20 Sep 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850181; cv=none; b=bP8MpOhV8R4MP6RgI/1v+aU6WSW55QMk8hljgrHn0WI1Tvw8R1Um6I81YOEKaYa5IjnayihZUnvHgYqzh85f0U8CAcqhrzc8Rq75ETLx7Nr63To3LGiuRXC5APoodZB+8JvJMXT6d35PU0C34PLmBvvxue1TNI58zrq1HtUGMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850181; c=relaxed/simple;
	bh=FQD2IXKJcqCT5Jjgi9b5hTY//bIHixb3wpDzt0WFMdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fLOVLzGvNWcsOPKjc0eM9SQzxv6dFyqR7ydB3Iv4api8w/IFabTkc0wbz9f4ZdP5BGv5gUJmsv+HrWHjOV5Z0qGFNInJv8bl7Z4jTFhb2uR5nEeIFXg8HKnGJanFcTE9jEm0K/qMDjIx1Ww3RYKJhkVkyTzf6JJAzKs9fjtjP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBKBE7y2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBKBE7y2"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9aec89347so151971685a.0
        for <iwd@lists.linux.dev>; Fri, 20 Sep 2024 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726850178; x=1727454978; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQet0YO2AXyxAr8Dmlb+pXxsxbRR4AbREgvU1NjNX4A=;
        b=FBKBE7y2dJt1fUrn2gDL7wb5ojrPzzWHnyBaEaov8uTd7nQDsboxfG+vGrmsos18tZ
         fXln1Z2bHpvy1au6ZPfBDkV1hi4tE2RxlC38+iEBN4Ps7kDtS/5AGLCfCK4T17uRYvGV
         xHQkxXi39eWEbpwBpvFvhpgIEACR3eI3Kl8XHY0pI2flzj8XQOfAFBxK2GXDf2UMn73y
         +dh8Db9dVg1pI8+HOVrfvGv3f9XnYCYormdYWcy8sk83j1AKOjd2imniY7PaXJ/DXH0O
         PRKG39+r7U7EGPfP4uynF4Z/Gbj/dWm0K5Y2spla894dtOiNNv1O6FD7KXLxAspu4gRh
         QrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850178; x=1727454978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQet0YO2AXyxAr8Dmlb+pXxsxbRR4AbREgvU1NjNX4A=;
        b=IxJO9u0xHtXu+rlXSqpJUsdxarnAOpN/dMNUAd6a4zbZOonEyy2R/7IiA3H9GEi+rJ
         4UpJMs+V6oLd7ZA6CpuBDtBbPv7d3gz0OTbwEJg1/k7FJp7675a3t2kckbkdMmHGwhv0
         BCN1b0Xjn6SzdBZvQEBue9GiOjziboKpW/TZhOHbZUREmKNh4Ijna7pxjs0+LCPlhVnL
         GUa8D99O6m7XTtWafmfvK+mpsgSwYVQx5f8P8+oW2vl+owdrlNIAO9e8Y5MpDP3DBK+K
         Iiz+6gKl57pn5yCGY4b9ZjGQ0BiBsVAUWaDhojvIiORlmfNpvCjReqm2yzERI5nQ3uw5
         RLKQ==
X-Gm-Message-State: AOJu0YyYZwxnbLHwryIedVjZNUi1L5Bbd9S1NkhW3/opn2Eo0N9+Gn/H
	01ncNJ0D+Q+iOE8TQfYMNBy/c9gi3oNhEmTGvG6kU9T4XQ3FYRXxFVFPwQ==
X-Google-Smtp-Source: AGHT+IG3Zsmp2COyAr4vZ0V5qpCiBXAG0e1Fx0pdCpM9zhYn/IN5xLAELJ0wrmycCmjm43lqS33Q+w==
X-Received: by 2002:a05:620a:45a9:b0:7a9:b425:6 with SMTP id af79cd13be357-7acb8d8fb70mr416697185a.24.1726850178399;
        Fri, 20 Sep 2024 09:36:18 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08d51c9sm196943685a.99.2024.09.20.09.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:36:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] manager: fix UseDefaultInterface warning
Date: Fri, 20 Sep 2024 09:36:14 -0700
Message-Id: <20240920163614.207001-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This logic was incorrect here, we only want to print if the option
is used, not if its unset.
---
 src/manager.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 5bedfcc5..436daa56 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -894,11 +894,11 @@ static int manager_init(void)
 	}
 
 	if (!l_settings_get_bool(config, "General",
-				"UseDefaultInterface", &use_default)) {
+				"UseDefaultInterface", &use_default))
+		use_default = false;
+	else
 		l_warn("[General].UseDefaultInterface is deprecated, please "
 			"use [DriverQuirks].DefaultInterface instead");
-		use_default = false;
-	}
 
 	return 0;
 
-- 
2.34.1

