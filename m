Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101591E487
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570936; cv=none; b=mkAHup2w0a5knMOxJlgaHzJHkmXfFiVY6cFpUqnS83D7NcDJ3icDE+buSzSi1KHxSyjd/zTDf2aTgjGtE1rhyGAJ9YUGdCGUdKwltK6cVfgYo9jKU37fIB+WFMWoX/DFKRm1O8txlC6/Y00B3Fr5xIh2MlomhIq0xCkTEMRapSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570936; c=relaxed/simple;
	bh=nZpVwVH0BR3YhEBXu280vi0WI9FThxj+xd+dr4gRZSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MY6XNMz2RkvWRRXanyvXn7kHn5C/gc9p8Bp7ZhmaB+cF3cudZVK/R7sSHf6xXs0ekp+T/Ftb3zL551X6BSVN70YUVRIErfITjbSfA4km+ydkaI9PBFVcj+67ZVZgeTxPO2DHhZfruzeaNjEs94nJYhp7zEJ2wIKyXb51bKGqL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce8nPGCn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce8nPGCn"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68fb3a3f1c5so25664196d6.3
        for <iwd@lists.linux.dev>; Mon, 04 Mar 2024 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709570934; x=1710175734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6c4ULGYfSqW+RPKDMPo8yq9tibiiE2qSK9J63ajOtY=;
        b=Ce8nPGCnRVfieK0860agbRtx0qXoAsx5Y79OOHf+4E3sxV/90rkl2/bw1nfLRQo0TQ
         2VN4RxMFxEbOOseyQMdltJ6ngsACQPLwkHNPoPoyRSU2/Z8EpyAn5Wxb6u6/ykIb5ItC
         HSzOXUjMLlrFBSNha7apS6C1sdp/RJJUrAkEV58h2cZ1iWrBInR/8qXMrsu2Bv3uLHEL
         lTr5jQEAIXUHir5R94qrb0mZc0hyQWMIyioPG2n6yRFETP+3yHLxRTuJmkfNUBClUkUh
         Hzri59+e71dQCU6FW2O+DiBvktbN7Nway7lZUzf7uqzXsJK6swWo+A03Y/63+gaKFYmw
         /dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570934; x=1710175734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6c4ULGYfSqW+RPKDMPo8yq9tibiiE2qSK9J63ajOtY=;
        b=H9eABtfCDJYFFhNS/zHbHAyjoE4SNM/ifgwNBM+VFxVXH5/tHTL7IzfuEPiXGXUpk5
         ZX5Hkl9ButKZZnH/XxMeEUlzw4mimHIA0/fYQFBu2hrdL67QuLSs/ULub/W+yQHWB7qV
         Ml2+GaiVvRzXnFP1F7gJXn9y86X+1Ob99cvUj6jayt95XMn7qTRxcJIgeO+qLMcvISoi
         snq2kyxn1ikm+xUOg2vdD/r1CV56uJZeqZqFGqUKULXKaOovGlgFA77wIDySV5t16yDp
         1NUQgLTloYPovlRWGqN7f3aypuH5z9ST/t3CMYUEOBTsfLV9SfEtWIRMAfssoK3cac4I
         ADLA==
X-Gm-Message-State: AOJu0YzMAkVrSKeRJCUMa2wG+eR4Not/5oYrZA7g5PlJfTyPHOyEJvhP
	ahRDnR2tRq8/lzYgEjGBQrw/uFAdE4TlBqE2/tp+ZklGp8qTIVFNXTPKMKNh
X-Google-Smtp-Source: AGHT+IHRM/GkUq1Vr+0XfqX9ruRsxNkSJBz4dCsX+shgVddlPCNnmICzOgxSesLOOqq12ieuSq2wzg==
X-Received: by 2002:a05:6214:a4a:b0:690:59a9:2704 with SMTP id ee10-20020a0562140a4a00b0069059a92704mr8724899qvb.20.1709570933637;
        Mon, 04 Mar 2024 08:48:53 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0068fdc55ec7dsm3858466qvb.68.2024.03.04.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:48:53 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] client: remove unneeded initialization
Date: Mon,  4 Mar 2024 08:48:42 -0800
Message-Id: <20240304164846.1783148-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index 83214c86..f0f3282a 100644
--- a/client/display.c
+++ b/client/display.c
@@ -194,7 +194,7 @@ void display_refresh_set_cmd(const char *family, const char *entity,
 
 		for (i = 0; i < argc; i++) {
 			bool needs_quotes = false;
-			char *p = argv[i];
+			char *p;
 
 			for (p = argv[i]; *p != '\0'; p++) {
 				if (*p != ' ')
-- 
2.34.1

