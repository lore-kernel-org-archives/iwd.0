Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9A19F128
	for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106429; cv=none; b=KsH6TMfPy4O+MUL1mHAakfE0ftKY4chOinFW/x3lQ+gIwU4GG0Uvxu1Pp+mSNnkX2jwyoTAb1AUKMNtPZQQqf3qGZYbGb3A5KBZ2lo3Pfhv7ocRmcd66s3OmutuF0PPo2l3BBfL02BpBPEqHv1V/VTjb3oCxwijKQvr4eTjU3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106429; c=relaxed/simple;
	bh=tL7h8l2Lv5ZdQCNoMY6DIsAevcwiD0JdDEqumDxjOHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k83XtUjvPUIoNPb34T1n76djPu0CCCRyvFZwrAylrsawuH+Wfn9GrXKFQwq6CXCMnyzUz3mo8nBFS3Os2QOD78Wb5QYJr+fDn/bktQGx37TzykyDAkTzPiLqvrpe/ujr6hYssPaZV4JHEL24TWsO7c2i/F3dS3dGDKEslCv2Fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=QEoJMBNt; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="QEoJMBNt"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e786167712so3403052b6e.3
        for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 04:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1732106422; x=1732711222; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyMA9KpKlHYpl7q8gHwd9/DuBWUVfizTcd9lbShtRLc=;
        b=QEoJMBNt91F6A4JDKGn60GfbRUYWNaDyFkXVhuYu/o9DniOHCA4owt3pV7/s/UfwBI
         2tzTEKvmQEyDvVTcZ7VTCaPr6X02nBlaqSvTNodKe4hcY6git9Wq+uifTBFK75tc2ESP
         nDauq0vRTyf91NrHtBbeTn2Oz7C4WNvckS9d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732106422; x=1732711222;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyMA9KpKlHYpl7q8gHwd9/DuBWUVfizTcd9lbShtRLc=;
        b=LIbaAa8X/0XdvpuKXj5zJMeVq2DkddD6HZI+Wdx4c8nmZZz8TB3JVXZhVV0GZvNCxW
         EgsAH9z7CSChuFSw+ygTi1T3wRUdMk+XpjGp/UhVGvfJQIAgapTH84i/DBjcj/RM6D23
         D4UR4DotBaTq+N5KQPxukp+wZaqpqaBkEAQqG4KgUdiLMybRefywHh3ndfgMqKWxD3qC
         apTg09jWtKrUIzEDs7rBh0zfCwPI3YGCkTt1/Tw4F95UPsSl46NnYd7kAbpqaYserU/v
         GB2rwBeMogJv5AcyZBm4Xj0FPuZJOq6PsT2+uTfTEWfELURkz2eq9/yITfxw9U8y/TVv
         Bekg==
X-Gm-Message-State: AOJu0YzyMhDVJhAx0d43eY0ureHKSSIGYHxIOXNydeDqn05lhlqgrPYf
	2RmgQ5msu853K9VHm2O1ItZh+fzxezLHOGghihHFk6eVm/TpMB7ATMmh3/mjK0m5QXA8sbopucT
	f
X-Google-Smtp-Source: AGHT+IFiMccLBRr1D2kqjuxvc2R0LNQwrAyVgro/SR/h7fv+TWOqX6f9tcxcRtpE6/bxvN/CHh+nQQ==
X-Received: by 2002:a05:6808:1513:b0:3e7:b800:fa0 with SMTP id 5614622812f47-3e7eb7a605cmr2252005b6e.10.1732106421979;
        Wed, 20 Nov 2024 04:40:21 -0800 (PST)
Received: from c8d99ad60702 ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dac9a8sm9382981a12.55.2024.11.20.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:40:21 -0800 (PST)
Date: Wed, 20 Nov 2024 12:40:17 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: iwd@lists.linux.dev
Cc: rudi@heitbaum.com
Subject: [PATCH 1/2] crypto: fix -std=c23 build failure
Message-ID: <Zz3YsU2pn-HtWvXn@c8d99ad60702>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `iwd` fails the build as:

    ../src/crypto.c:1215:24: error: incompatible types when returning type '_Bool' but 'struct l_ecc_point *' was expected
     1215 |                 return false;
          |                        ^~~~~

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 src/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/crypto.c b/src/crypto.c
index 35941a2e..9dcdb43b 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -1212,7 +1212,7 @@ struct l_ecc_point *crypto_derive_sae_pwe_from_pt_ecc(const uint8_t *mac1,
 	struct l_ecc_point *pwe;
 
 	if (!pt || !curve)
-		return false;
+		return NULL;
 
 	hash = crypto_sae_hash_from_ecc_prime_len(CRYPTO_SAE_HASH_TO_ELEMENT,
 					l_ecc_curve_get_scalar_bytes(curve));
-- 
2.43.0

