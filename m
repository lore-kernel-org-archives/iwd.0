Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D521D3EF
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748460488; cv=none; b=ihZTfdZuki8DgBumo+7H+l1BMaUy/LQrNcTlmjXUNfxNsYs/BzyAqVx4yEylPiU/3+uD14PmAvMPBCmw39X0Zg0PfFtTpaWqxGszELA1FdGl40R8woQKtBq3OTWUWM/f264c0n73VQ+mBnLZEo7BcZFp6a5x3/t7s23RF3w3wfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748460488; c=relaxed/simple;
	bh=wTRGe1EyDbNY41k5RWjgMD77QgQ66qJSPl0aN84unWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVwQLF6iZepjj500DghWtfsfGdCFzuJyJ6o/Z25FiwnXwC08mSpea9MnFZFzF1c6289/BmIizCyYw4UHIjUUt8o0Hke+fYoOMRRwJ71PnqCoVUR91M7UWHtsH3BFKE71seMK4OTJ4sxbmrWghu+ndnoX1g6YiBTpt/Fh3WMMvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5/BMnzo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5/BMnzo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fac1c60e19so9491176d6.1
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748460486; x=1749065286; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6xVv52Y7jpe9J9LkZThbWJDe8RkWjXx2YVfUOiXE1g=;
        b=N5/BMnzoOJMU1SHSQ3Bfo9ODoYpNko/Vm65eoHDINqW6jeMhImySBK7yddoHYn/TZF
         2N1xvCt1LSipa1FPrzmm3k2G9/kw5jIlJQCHpbDNOW1yGFzoPMWssHgHAHyHw2uiDCc4
         f2mkthjTLis+y8vb+NHl+M/B22Ld4DKaPGDrRbkAb7Fcd7BNF6gQ1d/iF4+V1vTkZdnp
         fkrY8lDgtKQ6Kud7wAu/0RwAJ/PqOyEWuy4ULNZoPTWq60xDkKAFjvLoarSopYI+wRYj
         +LckIQCLRnnW9cbzkbHoQv8qeSWaFUJECbeG2ifm6rFevIz9SmUJNRWCyqaDcVOclowl
         xlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748460486; x=1749065286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6xVv52Y7jpe9J9LkZThbWJDe8RkWjXx2YVfUOiXE1g=;
        b=Dn+O/3ltocj+twCn3ikxrr9d0lWQDEwt6ybN+7yMkK2c4wXhgeC0KgcDXxMC+sflDO
         jAlvMAYZY9NqGn/RmA/0BFgjxB/p1/XGTRxnLAO8DiD229Luwhjl7L0YJ1uMevArd+xP
         InVAMebx8CByTyY9V8YXVvuFgGjFiD0zKAyXzsErPeMTBc7jM9vbfI8n01Gg3p0L9HVl
         4xhWeG4D8ta/TN5KZONBxyNzgGzjBG8IuK8QCJwoBPfn2/tsAtzS8tIoeb4s3o6Jwup6
         FlQXre7Av4W6N0z3+c0JVjiBf0+mtU+8WGEboRVBDV0Kkt4Vl2CTzHfcgfbFdqTbh0YX
         +EBg==
X-Gm-Message-State: AOJu0YwQv2qxs8FJJtvPOGtGTMQwmuJsdI5xzv7qf9c1dLj43SiidQXF
	eCv6uLFIjb0gtJ75QbVgID2Ktva2FPgqXGuROHX62VafDeMTTApotos+clWLvA==
X-Gm-Gg: ASbGncszSlyQ92zrjA4/orEuiEOHAu/L6oeQfsxU26UejfzVtNbC2ANr/+KEnybD+BR
	BW6TNVBoUMWCYcidVVz0S8s0y9RU19G5uBuNQohJnv6Z51ELttIfmlhIlNZvcLF42Dc79OGQeZ8
	bYZXWyEnpsnilNPHuxBtWgvYKeydbmppyDj+ZRn4mkaohp7sllBFDPRzzX+lx91Wui9ShKUTc6X
	H3mhgOvnDxl3lYvmfgVyUP5e6bW0xM3NUHqu3F2es2AVNY8BBY47hTRqncjLUeSq0woehYVVuo7
	BSHRpv4fnkRdXR2+P7NjTKgGr/PHOErPS+BvPE7ejRDBY7ToQABZaW6XH9fQaim9hu5EPam3
X-Google-Smtp-Source: AGHT+IFruQwFVk392TwlUVCM1tlQu4nhNvy0VA9IEx7bTIPeitMew9flzAWOFZJMfeE3x0hSpvF4Tg==
X-Received: by 2002:a05:6214:4782:b0:6fa:b467:aa67 with SMTP id 6a1803df08f44-6fac5d6529amr13794746d6.20.1748460485841;
        Wed, 28 May 2025 12:28:05 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0bc7bbcsm9987626d6.96.2025.05.28.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:28:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] sae: prevent groups 21, 25, and 26 from being used
Date: Wed, 28 May 2025 12:27:59 -0700
Message-Id: <20250528192759.555623-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528192759.555623-1-prestwoj@gmail.com>
References: <20250528192759.555623-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These groups are not working reliably and until that is fixed they
should be disabled.
---
 src/sae.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/sae.c b/src/sae.c
index 87e64041..9ffdf648 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -169,6 +169,14 @@ static int sae_choose_next_group(struct sae_sm *sm)
 				!sm->handshake->ecc_sae_pts[sm->group_retry])
 			continue;
 
+		/*
+		 * TODO: Groups for P192, P224 and P521 are currently
+		 * non-functional with SAE. Until this is fixed we need to
+		 * avoid these groups from being used.
+		 */
+		if (group == 21 || group == 25 || group == 26)
+			continue;
+
 		break;
 	}
 
-- 
2.34.1

