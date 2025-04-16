Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672498F6E
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806865; cv=none; b=KShvyoqCV2nn7Jo5DiCPmEGmt4eG04t4irFfChckEXx4p8IMH8I9d/Riem9ZpfdcpgFM2rkwef+s0S4er1ITVkLnIwPaiH2KKJbyUQwSyAXWED9++XYPLKihwAdN5Idokh08yMzmyL9fIz4+7+mTvWA4Hj7QxR3lIkLcMBLfHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806865; c=relaxed/simple;
	bh=uJKMo5PB5ADdJZksTQn0Mgpsurz+5jVOM7gr6PS/+Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADeX9ONwCxbtmarlSryFQmTL2Ja8qYmNJrMdUgoo3EUhG1x5w4takx3TWR9kuLDvz3gykPnUqLGNPa4Of6uTR3M8dxPpCvMfkAaB2iOeFzofJNQPCHc/ey/je/MJ243quNb8uXuaZmNqAWro9hOokBdS9HN5I1Y3AkOb5kaJbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXuhdRtu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXuhdRtu"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736c062b1f5so5693740b3a.0
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806863; x=1745411663; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuBuJVN3VcLDZOw5KkmN4LMw9QR8NX3S3BVrFSQunUA=;
        b=WXuhdRtuNtNqMcj7yGrk0jrURI3oAfsmflWt3eAcNfwHTLlzwX0WEPHOUEnzxnfGuX
         1Tb7+J4wpxX/rbJvZYcx10fJj5DmBomXrWFQCuOd8gVZDWDoY14b5FKa/jTx+ffXlTK1
         9Ogg7k6yFjYU7LR8HMD4tV53URnQiuuu+Ub5qs4WHlsKCRf5uRg1MOzfTopM7p/XsVYP
         JV7gFngEFgxcbU6NQgzux9ilVXE46G4qJbVLoMldTZPpkj2C2om7+Yoc5B7I8x+sgV9H
         T9Of96/tbTBti6RCRslk4KnYOCsG2Z1FAhniOAsgVV3KNq47g1hHO+tiA0uTIq1xnBKq
         w6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806863; x=1745411663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuBuJVN3VcLDZOw5KkmN4LMw9QR8NX3S3BVrFSQunUA=;
        b=NoI32FzhTCkWwZHKP90zBo/ON1ymktRW6mT2/BAsTGk//iFi/5rFe0qnQ5bdA4RSa2
         pIgZt14Zhz9jHXkpDxQ8LRoOI58tbzaZhoVGPUn6OKOPpdwKDLYh9ZtcTwcnP1wa6bmd
         cr85hekr/kDjmXm4lMPFdgN5qSoclK9AexUi3lhVrCGSUQhSc66HTW8CM+4DDHTRrZOa
         dW3TUyO1rZIohHVkfmDGpkZw+uRghl6hM8xgUJSYFWCgz9xGOE/ah5txwH86LBXCnJgy
         GDyy12qJStBKwM09A01ooiDge1+NzviMnfHLQ0qq7+poMDydV8nuwCx1nqQaKs8l8nVo
         5EmQ==
X-Gm-Message-State: AOJu0YxN2XW5cZ9tTbidhH6OEDCCqiDpkJHzxNW+LopVghfVtx1Bqok6
	7kxZB6NyL6jwcbeqBMCgoxWeRvkFoFNSRpqiuATNgUHJ6L3ofAPWui8KQg==
X-Gm-Gg: ASbGncs/iQ9SsaftWHBt/EOpYIQLz1ZWgRiPnJD30LGQkVh9rvQTmN87gU6PJRLb1/j
	a/buNF2XccUGg9wD1XDGsDgxa2JO5Hjn+IWZM8F3YoT8nQ9I8VK7uCWUnI5+ByVNuxos0buOY8U
	+y7led9E+nYwjjfJDs8iDip1/29Eq8z4oHaV28zouTxWNSHFaglo4eU+c9u5MwneQKmXHPsgrNC
	R93Z+fvvkjsUAxA/vk+SEyQy5XvZR2D9efHU3//yhAPKrd9nykD7kIYDJQKzxasWASRXXU1KxyH
	AENWZx8dpCdC18ZIgKoo4XbqmXqECQWHwzGGPaImFJMCo7w1OedkHrhk4ijaPrlP9PBGNC6T3GN
	DeFhVoNYC3kTijp3suWp+6kQ92sU=
X-Google-Smtp-Source: AGHT+IFTI+C4yz0IXFhH1YP7O8wpFJVPMOtapKQrJ1ID7Z/oqTy0Z79TOU+I51ymWN6AInWRkCwwwQ==
X-Received: by 2002:a05:6a00:3d09:b0:739:b288:13e7 with SMTP id d2e1a72fcca58-73c267d3801mr2271627b3a.15.1744806863114;
        Wed, 16 Apr 2025 05:34:23 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/9] storage: add length check in __storage_decrypt
Date: Wed, 16 Apr 2025 05:34:11 -0700
Message-Id: <20250416123414.114231-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416123414.114231-1-prestwoj@gmail.com>
References: <20250416123414.114231-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length of EncryptedSecurity was assumed to be at least 16 bytes
and anything less would underflow the length to l_malloc.
---
 src/storage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/storage.c b/src/storage.c
index 843581fd..2115a879 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -500,6 +500,13 @@ int __storage_decrypt(struct l_settings *settings, const char *ssid,
 		return 0;
 	}
 
+	/*
+	 * It should likely be far larger than this, but that will get caught
+	 * later when reloading the decrypted data.
+	 */
+	if (elen < 16)
+		return -EBADMSG;
+
 	/*
 	 * AES-SIV automatically verifies the IV (16 bytes) and returns only
 	 * the decrypted data portion. We add one here for the NULL terminator
-- 
2.34.1

