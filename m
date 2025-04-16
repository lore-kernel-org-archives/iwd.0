Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD98DDC5
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824832; cv=none; b=cKrvGNhKM6ws1x5XbC8pRp9awEgS9VdPH9KDOVJVeijmeW/2seVo09OQCGr2avEHe6QprTcQ1K5VjupfmKtoWa1K6C/h39dv08SSy88YZ54/tnabGXhFln2hVsBwpmItuIKwXg9+oalNTJqdWxhg/XsTpZAgJVA7mDCI5CfCkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824832; c=relaxed/simple;
	bh=HQwkqnC6nnJbQHD8LN0g9bVl64MRWsflRJQ2ukkUPgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BbjSiZdl04iHS/sIrTD3c477NT/m238NSxL3ZDGUgmEO8oPV/Zm1EN3/Cqy5y0m7mmNpcnRi7JnxSdyAYivxGhFgvf+HHZfyUdfvRYE9d4+jYR7KTDAJKZp7zIIJHVo9wPXXRXog9lyPF5uGqADopkAntE9kTtr2tG5CGqE4IoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUJItw9K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUJItw9K"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22622ddcc35so97410945ad.2
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824830; x=1745429630; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZgRNrOJ46ZA5ePgG3flfo0wC+hGmexPOMFh+6Wr0HU=;
        b=UUJItw9K7LSFTBjiOk8ZbcdmtXbyk3x6VLYZ8utFmURDfpvksYVjPlKn3Dh0zdeN0P
         I0DP19NhbpbHoukPL5aEipHMZGlTafoN6IJvm/0fadTLsyblmYP3KzohUEiIsoNFzyGw
         4Fhk5TCDeQcgN6alIugDIbCMxpgL6oLA8RRiqe5ScITyz5O/Yujy3y8wsYM3qyQI0gph
         C9xiHwoqyck9EkGFX0e2tVJybl1AOVu4x1xxMInhH+7Mmf+meXFce8sLFv/JdYR/W6fy
         vKKJHwlzXg1SnQM0m15Xlp7mph/8S4YlkD2sqMKH/WRHLG/6Dz7dBfYyMcy/hF3EJ8yu
         JHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824830; x=1745429630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZgRNrOJ46ZA5ePgG3flfo0wC+hGmexPOMFh+6Wr0HU=;
        b=wtkFaGyOcqfMfUYENz3b8mQ++t2EWmGlnZl2c3dg1nAHAs/1kI0Fit7cyy/HIoQXrj
         FqNuorgn5BtE2AlyJ/GEBTqBLiJXjzdIufBlqkFfWOWVI06In17ihju4C+gBNznuO4pR
         hb+6M5kBXpnYHsz8u0gpU32JTfw146LgqpM7kETtDHzbr6JXYErwIUY7PfrN/YR3J+hu
         g23UWDcP/z+V7uWUGoLPlHc/pI1tMSKv2nTXNhbD31AMq/LWNCeCcnDH3vcxxsT0+bcQ
         uhxGQTPpqw4A/zkNALEVqNX9/zJdYNYNrTbrHVuIETRS6iM5v8bXdIpg3g6OJ5HHP08A
         E6SA==
X-Gm-Message-State: AOJu0YxqS1vYZCQ2fO2t865FDXUV8ZE8dLJFnLmmxrv3ZXjtteDRMcta
	16s3iEWaNOCehnfLUeKtSbNAd/tjk5GpU6jMND2bv5DoFxqbN1SrAKFx0w==
X-Gm-Gg: ASbGncu8VgQ/6yPm+Ssxtc1h5eWLSpR+8vbQ/2e7Aw2GT4UzMr/+qPROrw5UCzBNNaZ
	qGudlSpl+vRi/GbCwC8yDwlNb/NOFYWb0LO36S+tFpxdQQVwgw8+DaMkJP3NuVJYEKFBU1JyKak
	EtOKHewZbvcQmL8mjXdSpfq1i0iu55/fYoQx3OcQA9OA4k1+/CbxVNVzKsDudtkEXTbJckd6SAm
	xfHQQotbYHnmAfaJPlWdvPJBq9OhgSIYh3mx+7IKN4z+izSM7VLLvcwRhMWx0YF/fHSmAaRDQEP
	pOKBt1XNBRnbGhjRiJGEtQwYWixa0F+KmYoOX5NS8Jb70YxEImSY0xisjPoY/Q==
X-Google-Smtp-Source: AGHT+IGYw+Nq3Xyqvr0Wrwd42lSnXmfBKK4cpkR3yHm+8qbmuGbRKZhzPIbFjS6it0YR6NetPB/zGA==
X-Received: by 2002:a17:903:2412:b0:227:e74a:a057 with SMTP id d9443c01a7336-22c35983ca5mr48447095ad.44.1744824830182;
        Wed, 16 Apr 2025 10:33:50 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:33:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/9] monitor: fix spelling Exausted -> Exhausted
Date: Wed, 16 Apr 2025 10:33:37 -0700
Message-Id: <20250416173345.136025-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caught by codespell

Fixes: 83a24575 ("monitor: add support for limiting PCAP size/count")
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

