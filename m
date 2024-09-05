Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0C1E481
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543804; cv=none; b=T5Jdf+iAN8yxuhrZuZVxDOZuYdWE3E0O93DuMDvDeV9CZ8U0X8ZQDx85kh/B1JGYrHGG8GVTTrBlGSnKnFuPGI3MoT2fv5nK7mai1oMpgz393T0BO4Gce6/VzqPp9GCMmRPnyeMREen8U9MXPQrhf2CxlOl60M/iAB1KgEdET+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543804; c=relaxed/simple;
	bh=L4kCd+mRYxncaGhRe6IsG5pTyQBc5X0+5Gy1mOv3gPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NmUY4HhssqjCgdQlbcFSTzyp4z34ZrmaKk8Fq4jSHN8J3fD9iEe+k8gtopLISjYPC3IMj5ZhDRHyFtSNpwsabO6lzx4aCUDH3oE9U54L/jbOVD84zdVDJp+Fo1hNikH8ZpD0eW3b/O/b4PGcz77TVcnjjgU66HdfrDRKK13ZFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHsLnHCr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHsLnHCr"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20551eeba95so7934165ad.2
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725543802; x=1726148602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4xu/ZPnb3qD7cfWEiehIy8y0efyircGovEgpw5rl9w=;
        b=DHsLnHCr8EJMVFyzjpdSeq4ansK8L/LzP94vJrwK04YaxH4A8pGlTRue6S8Vdl4ZeX
         0SxS7Zzps2OrWbgO40GAOuNPA8XG6HbiNoJdTP7aE+MHEzO7i7XUv03wuB1hUwmu5Rs8
         7QB226G0Jemr234IDNpTX4RV/GJd6T9hps4TjV/xpbdmjSgvOvEaxSdBLFk7dK3p2iht
         hl9/ADhVAd9kaduzvvD+dd99TAGtFdhdf3OFKg2yU2amckW1ZaULXKbrWlAFWu9fh1+4
         qZmNR2yWl6o0p9hTpz029nsC1HGBXS+mU/FLbY6JK0+R7/HkQUlxmA0u9eyUTr04UQOb
         m9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543802; x=1726148602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4xu/ZPnb3qD7cfWEiehIy8y0efyircGovEgpw5rl9w=;
        b=uMCmarGAH/3sh7Oq5lVfBtO6HQVEZO3kiliMnMM4ly8kCbqXdre3bUJfpjWlkxntRZ
         4YI5yMVDyPqhPgMcgyESuKXYh84L9+EESeUYWinUjm0pgju1Zs/xVUDsVyZVMYxHw8Zp
         BZSVf8/0GsIIhgl4Cd6TsG6hLWoOxiGFGJgF6Hkyca1MkzyzZOr8qQO6+0AEccrT2Dif
         cTsTl7ZuZzm1QgcOVc+nozBK7GF5P/CnG05wHy1t9Dli5mrVyry7AGt6aZG0HlvUTPtb
         LGub0BDFKCTklluCvG7bU3gt1c2Ol6opjbLlSKERucDDj/Dfgwg7MPVrFNjNIoXTzT4w
         Y+hg==
X-Gm-Message-State: AOJu0Yx/gEyBkASUVUS6VizpD9Vcqz1DiSKaJ+iptQWgblZ0++Ua63EG
	ZjBgG1e0zoZ6YADtTI7r05bgbCgFJnidzSVhY0bwyctfFgAP+lgijshm7Q==
X-Google-Smtp-Source: AGHT+IHYRnOvKl6iYkziRxlfSqi3uM1tLnmOfKlFsfA0mCJuHDsaD2MKPnndm0q1y21+SCGABI4tyg==
X-Received: by 2002:a17:902:db05:b0:206:ae39:9f4 with SMTP id d9443c01a7336-206ae390d5emr92532765ad.20.1725543801569;
        Thu, 05 Sep 2024 06:43:21 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea54f06sm28788405ad.207.2024.09.05.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:43:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Daniel Bond <danielbondno@gmail.com>
Subject: [PATCH 1/2] scan: check scan request in get_survey_done before deref
Date: Thu,  5 Sep 2024 06:43:14 -0700
Message-Id: <20240905134315.374800-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the possibility of external scans the scan request pointer
could be NULL. Prior to surveys IWD would still get the results in
order for periodic scans to utilize them. This behavior can be
retained by checking both if we don't have a request or if the
request was canceled. This check is identical to the one in
get_scan_done.

This fixes a crash when checking if the NULL scan request has been
canceled:

0x00005ffa6a0376de in get_survey_done (user_data=0x5ffa783a3f90) at src/scan.c:2059
0x0000749646a29bbd in ?? () from /usr/lib/libell.so.0
0x0000749646a243cb in ?? () from /usr/lib/libell.so.0
0x0000749646a24655 in l_main_iterate () from /usr/lib/libell.so.0
0x0000749646a24ace in l_main_run () from /usr/lib/libell.so.0
0x0000749646a263a4 in l_main_run_with_signal () from /usr/lib/libell.so.0
0x00005ffa6a00d642 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:614

Reported-by: Daniel Bond <danielbondno@gmail.com>
---
 src/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index debdeb1f..205365cd 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2056,7 +2056,7 @@ static void get_survey_done(void *user_data)
 
 	sc->get_survey_cmd_id = 0;
 
-	if (!results->sr->canceled)
+	if (!results->sr || !results->sr->canceled)
 		get_results(results);
 	else
 		get_scan_done(user_data);
-- 
2.34.1

