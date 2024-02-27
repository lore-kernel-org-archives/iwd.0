Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4C51C4C
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068592; cv=none; b=dvWaXZEJi75171Y0cGOvBmIAd4/yMJ2JuUjcyrqj0q6aEnIzscl+77duSYhDPXZJzntW2lSvTHET46zwa/GGWIEpXhpWg0lE23ZEV0Rw0u4Pyu+WpMnOBYblej28JaQnGa1ETXfMTIsgrOlmbsEKdzBdZfU8lW5gT35+8O6sj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068592; c=relaxed/simple;
	bh=kCslBJNcYo9jQMNbRJDZmhFCf7WoLvM18Emq9JAylMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MhNsBXvNO5dyfqvEzpj/n42DvCR2LuB45OHvSjCcjJjmkj+iPbzy8DYMrCXNtSqnlWxePUsKRRtbNnIytYNEOaVC53vWtMQC0ZcDDmP3GRfVtraD/haO0Fznti05Kr0YZq+ItY5tSna9eD1mHbUHqgBiYmREq6TBATHjFxii42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F993SMfB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F993SMfB"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609390cf8b0so2962927b3.3
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709068590; x=1709673390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+E/Hz3U965BYjNinPlCXee33YjJs+nDgeWVFolJDYsE=;
        b=F993SMfBHkM1AvQaOoOeQdcCC0g3zkqaAa0/X0QuqSwnpOboge9UKlIkEaib2cuHCB
         +gBryYepZZJjAw6dzl2Jijp85xH6MzREkn/o4N/ljHv9P/BVmsnbAlaAeY17cBTFCbGH
         3Jr8t6rFSQGhYWcO3Ce/i7sKpFvguaXH87xCjT4iz2c7bSUwNRHqB2/89uj8/1F4wCfS
         BMhNs+tZpSyyQLQLhKPLKs5m8IzbjJEiiMGmSzlms3xs+yW6vkJ0LS1s/zEF4vJq5pQZ
         pbJmi0k0S1a71ZObWXZ0sCH2hAO1sxKE4U76rs2x63Q+yPPVIx7gfnML+8vJWL0miWUy
         5UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068590; x=1709673390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+E/Hz3U965BYjNinPlCXee33YjJs+nDgeWVFolJDYsE=;
        b=KNwGz2YWN1R08RdlezYCJpldq0KfP2fxiVg0lkKMux15nGgAyZzUzH3xymVQWcWhE/
         pkiE5j1vbs1ttoCdraB42qN6PyWvhbDfqGsye28idH6b/JD719IYuzzYgJgf5xFlDC8P
         S+MRH436LIQtqMzRW9N1zgq56Ldn/8MZpnZuVWCOhFlRPrBHye5ZCjZURkxiQysAV/Hl
         YhJQVuDrDEXxshmbr7W/gk5ffxskXmS1q9pE6BhwCbqvZoJU0XyfSN+09hHUjSfsPcjY
         4EhTsmlwOi5MXbvvrG/RChF4zKeXClqYFaGFLeATRIW23aK5X3dSRbVgJ+mOEipYKp1C
         2XQA==
X-Gm-Message-State: AOJu0YwoOCvSSr7D4Z1XrQHSUb0SrqGwCrera6GkiijROby76aQn9F8x
	5w6i+T9yBUf5c2jG9ssmp5+QvDy3X9rpH3tToLfPFnxgxi1AyPYCtInjBvJp
X-Google-Smtp-Source: AGHT+IFw99u1WIuwjIL+GQV7nW2AEEoRJArRpXWygJ2OodGi/gFF/rQivuMbXXkvvN1UF4wKZYY+DQ==
X-Received: by 2002:a0d:ca13:0:b0:608:b681:5faf with SMTP id m19-20020a0dca13000000b00608b6815fafmr3132813ywd.10.1709068590047;
        Tue, 27 Feb 2024 13:16:30 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id fu38-20020a05622a5da600b0042e09c6b82dsm3903649qtb.24.2024.02.27.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:16:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] crypto: fix uninitialized variable coverity warning
Date: Tue, 27 Feb 2024 13:16:17 -0800
Message-Id: <20240227211618.318442-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same as for aes_siv_decrypt, check num_ads before calling memcpy.
---
 src/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/crypto.c b/src/crypto.c
index 7235e3c2..15a7cde7 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -390,7 +390,7 @@ bool aes_siv_decrypt(const void *key, size_t key_len, const void *in,
 	if (in_len < 16)
 		return false;
 
-	if (ad)
+	if (ad && num_ad)
 		memcpy(iov, ad, sizeof(struct iovec) * num_ad);
 
 	iov[num_ad].iov_base = (void *)out;
-- 
2.34.1

