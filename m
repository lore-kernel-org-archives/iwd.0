Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A419F49D
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550025; cv=none; b=eGEzNpbGDVyDahYlZe6e746Q9TRtTHM2A7+Bwz4DXVxWtBgRxSHGtG9Beay36x8xtZmgpDmkd0r1aD9OIsHEmrizehr8JGkcKf9qBkd+E3xo9hRYzxzid6nvtJN4KY70gp5dRv9cC5LJZy8V+iABIBheicqpUyP7bcaJkObd+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550025; c=relaxed/simple;
	bh=0TviEBiizINVoJVFCcHUi7WHQiamQTbb0q40NggT10Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XP3bp9+nG1RlI8mkyIKdk1JDvTJHTEpcKAC2W6gV81bKe+IehfUzGJxmdqA9cjoQmKUwWk30uZEylF6TFFovrbwRWN00yrSd78w5/1ylmhksQsvjqbBUeCMJ4CSKYDPK51IDz6i6vxGqE+UB9rsEQruQ14anFoLlyvoJmDGz6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipoqEV2R; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipoqEV2R"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a7fd79ff63so59909285a.3
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725550023; x=1726154823; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOgdTkaFPcNnfG6DN9tOtN0jtWsCnmFd0ocBaA8jLP4=;
        b=ipoqEV2RCxp/lc4K/rwDnl59UzlTDAIl8d4QAeX1IQ5YErYV1sxGnRNZqLSMk8/0rB
         6TJO2Vjv8zKGc7bLX54ycEp+rPPk1rIY1nDcmN+0Oin0+gdG2KO8xxA6I4IdBILVjZkI
         FS20Cn9IpoVj3uFo3XDjNuTlccvY9sDjYmYvzRDK2YrTitflJkkEU4St8oSW1cuN2A+t
         k8L1+6Jtnsui6wJhfSeM6wQ/e0PwlGD81+O6y+kzBR9IDwZt6RJ0ZXcCqDDqq+seI1yZ
         XxUIC123SHB5KFAaZ4ed5FCNqslZqOJamA0EUjsNyR3hHYu5LeafjosayJ08My0GpBdV
         PCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550023; x=1726154823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOgdTkaFPcNnfG6DN9tOtN0jtWsCnmFd0ocBaA8jLP4=;
        b=VexWxLsPe0GvTgkI+mTaMGWrmjDuR2Ty/yuUE5FDcQ/7yAUwxWpOEGVYU7QT0EndG8
         bgbeX1OR6jThOe4//naZ0ZwAbUriIGb5vuiLiZM2Q7Snj/C1NYzMcJ0p6aa2xNzOLuyh
         67WPnpfNjrR8SysRBvfUpLyQsboR/ZqfZDi8Q9daZV0ODFjTK7vHMhrNDQ7kyqFxvmDf
         hVh9cgluc0qzi46KZ4NKoB7SOLvMzpLOm6hVyOc5O7K6Yt8wVI9EdJ2ZGO44FQAVDiqU
         qf/vOVsB7DDF9WfO3ng8BKR/X4gfYUDVAkIU4TvdLVyCqHCtCX7bzSxpqWjomRo2nL+2
         H+Tw==
X-Gm-Message-State: AOJu0Yzwy7HbOxbcmwJFI5pcnLilttZEqgEk2vvtOFPzSz2RV66l6gST
	hF4kv12z9fmpmN3oOZLCY7eGpSzPpx72QavwU0jq4ejEhVmyIe6XC7mVrA==
X-Google-Smtp-Source: AGHT+IFeUoQLXTaveqzov/0YFCdj4N+mq8W+iXnAQj1/V+Mxid5+u8ZK82stagxjtMTSqX6k69Lj5w==
X-Received: by 2002:a05:620a:472b:b0:7a2:317:a84b with SMTP id af79cd13be357-7a89322ecf1mr2015687585a.9.1725550022832;
        Thu, 05 Sep 2024 08:27:02 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b57347sm8026481cf.54.2024.09.05.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:27:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Daniel Bond <danielbondno@gmail.com>
Subject: [PATCH v2 1/2] scan: don't survey on external scans
Date: Thu,  5 Sep 2024 08:26:57 -0700
Message-Id: <20240905152658.380237-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since surveys end up making driver calls in the kernel its not
entirely known how they are implemented or how long they will
take. For this reason the survey will be skipped if getting the
results from an external scan.

Doing this also fixes a crash caused by external scans where the
scan request pointer is not checked and dereferenced:

0x00005ffa6a0376de in get_survey_done (user_data=0x5ffa783a3f90) at src/scan.c:2059
0x0000749646a29bbd in ?? () from /usr/lib/libell.so.0
0x0000749646a243cb in ?? () from /usr/lib/libell.so.0
0x0000749646a24655 in l_main_iterate () from /usr/lib/libell.so.0
0x0000749646a24ace in l_main_run () from /usr/lib/libell.so.0
0x0000749646a263a4 in l_main_run_with_signal () from /usr/lib/libell.so.0
0x00005ffa6a00d642 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:614

Reported-by: Daniel Bond <danielbondno@gmail.com>
---
 src/scan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

v2:
 * Disabled scan surveys rather than allowing a NULL scan request

diff --git a/src/scan.c b/src/scan.c
index debdeb1f..1cec9785 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2089,9 +2089,10 @@ static void scan_get_results(struct scan_context *sc, struct scan_request *sr,
 	results->bss_list = l_queue_new();
 	results->freqs = freqs;
 
-	if (scan_survey(results))
+	/* If there is no scan request (external scan), just get the results */
+	if (sr && scan_survey(results))
 		return;
-	else
+	else if (sr)
 		l_warn("failed to start a scan survey");
 
 	get_results(results);
-- 
2.34.1

