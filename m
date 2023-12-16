Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAD1DFDA
	for <iwd@lists.linux.dev>; Sat, 16 Dec 2023 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCKtR83Z"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c824b199fso6956705e9.1
        for <iwd@lists.linux.dev>; Sat, 16 Dec 2023 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702761397; x=1703366197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcmqhckMd646HVZE36DJiTBbesLyKP4Njdok7NfXs7c=;
        b=CCKtR83ZPDp/LIItQrsfguR/F4s3+VSLI4tYmqcVZg9vAA61ShGNoHbNgbiBVftxT4
         bYmKgSoi+0oGXPcU7I36J3Io8N4oYP4b3TNzSdqLFyjdNKOgKiuTiz6dxwmi1/QDC52e
         JilqyN72fAamcNtLB7I+OZVmgiXzSUQ5L5Iw4O6Nr61OFrtaj0aVufR2cenQl99t4KEX
         gFfevSiRq2szmFUD9OMlucKm/9+ekR2KWQPEadSktWb9Ph+P5R3v0jHU0JyhwTJtml7i
         GTpAMqwJbJJ5aaBxf0ZB1BFvIO12d1BAPlet2hXZkcpNClc+Gl8DNRW+aq1NuVcGxiOU
         qxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702761397; x=1703366197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcmqhckMd646HVZE36DJiTBbesLyKP4Njdok7NfXs7c=;
        b=nF+IXl3JKGxjk13BNXrpLeCOGLgkwsfHNQ53UXKEC05Dv3Y8/BBJcjkErXOxbdKl8j
         urF9I6t/KAEhYiDkmhaJlxkBOZQVY4K2621Rnf8lpMGu4w0/qtp1gginNq4txAnWjHnR
         At4VikTXiPs7pIGr0v2EfmNaZKKH8JYrhvOnD8Pbt1oXm4R4AFprCdWiuDEYWVxEmkPq
         qz+nV2aks/VAgecXb2ST7mb/jVFCNQjEABFUOmrT9wgCtTZaxjI0rgGZ3p1mIly8RjFd
         5LT6UN031a1lq+Ljpv+CYOu+UZ3GOO+1iED5Clx3pmBfyGrYAEK/eXBByBxnaCVX/mef
         whsA==
X-Gm-Message-State: AOJu0Yw9U0Q6TdD9AiRjU3C02NzSXvZXVXQirdXvB+8dPoN7jwwygQ2W
	oTcNdvhMVYwmiDOZGSi/grY=
X-Google-Smtp-Source: AGHT+IG5OrQ1rVwS1x/s6k7q08UBuWvYFNLdTsbslrHYKuDkaRz/t88krm7QpqDAwD6gBM5fvOdk5w==
X-Received: by 2002:adf:fc86:0:b0:336:5988:21db with SMTP id g6-20020adffc86000000b00336598821dbmr1555891wrr.49.1702761396641;
        Sat, 16 Dec 2023 13:16:36 -0800 (PST)
Received: from nz.home (host86-152-202-149.range86-152.btcentralplus.com. [86.152.202.149])
        by smtp.gmail.com with ESMTPSA id q18-20020adff952000000b0033609b71825sm22001995wrr.35.2023.12.16.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 13:16:36 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
	id 9FD4113FD69D94; Sat, 16 Dec 2023 21:16:35 +0000 (GMT)
From: Sergei Trofimovich <slyich@gmail.com>
To: iwd@lists.linux.dev
Cc: Sergei Trofimovich <slyich@gmail.com>
Subject: [PATCH] dpp: fix data corruption around prf_plus() call
Date: Sat, 16 Dec 2023 21:16:33 +0000
Message-ID: <20231216211633.4000444-1-slyich@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without the change test-dpp fails on aarch64-linux as:

    $ unit/test-dpp
    TEST: DPP test responder-only key derivation
    TEST: DPP test mutual key derivation
    TEST: DPP test PKEX key derivation
    test-dpp: unit/test-dpp.c:514: test_pkex_key_derivation: Assertion `!memcmp(tmp, __tmp, 32)' failed.

This happens due to int/size_t type mismatch passed to vararg
parameters to prf_plus():

    bool prf_plus(enum l_checksum_type type, const void *key, size_t key_len,
               void *out, size_t out_len,
               size_t n_extra, ...)
    {
       // ...
       va_start(va, n_extra);

       for (i = 0; i < n_extra; i++) {
               iov[i + 1].iov_base = va_arg(va, void *);
               iov[i + 1].iov_len = va_arg(va, size_t);
       // ...

Note that varargs here could only be a sequence of `void *` / `size_t`
values.

But in src/dpp-util.c `iwd` attempted to pass `int` there:

   prf_plus(sha, prk, bytes, z_out, bytes, 5,
            mac_i, 6, // <- here
            mac_r, 6, // <- and here
            m_x, bytes,
            n_x, bytes,
            key, strlen(key));

aarch64 stores only 32-bit value part of the register:

    mov     w7, #0x6
    str     w7, [sp, #...]

and loads full 64-bit form of the register:

    ldr     x3, [x3]

As a result higher bits of `iov[].iov_len` contain unexpected values and
sendmsg sends a lot more data than expected to the kernel.

The change fixes test-dpp test for me.

While at it fixed obvious `int` / `size_t` mismatch in src/erp.c.
---
 src/dpp-util.c | 5 +++--
 src/erp.c      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index c805b14a..91d96297 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -1376,8 +1376,9 @@ bool dpp_derive_z(const uint8_t *mac_i, const uint8_t *mac_r,
 	hkdf_extract(sha, NULL, 0, 1, prk, k_x, bytes);
 
 	/* HKDF-Extract (since it doesn't take non-string arguments)*/
-	prf_plus(sha, prk, bytes, z_out, bytes, 5, mac_i, 6, mac_r, 6, m_x,
-			bytes, n_x, bytes, key, strlen(key));
+	prf_plus(sha, prk, bytes, z_out, bytes, 5,
+		mac_i, (size_t)6, mac_r, (size_t)6, m_x, bytes,
+		n_x, bytes, key, strlen(key));
 
 	*z_len = bytes;
 
diff --git a/src/erp.c b/src/erp.c
index 85923346..7aa80bab 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -325,7 +325,7 @@ static bool erp_derive_reauth_keys(const uint8_t *emsk, size_t emsk_len,
 	if (!prf_plus(L_CHECKSUM_SHA256, r_rk, emsk_len,
 				r_ik, emsk_len, 3, ERP_RIK_LABEL,
 				strlen(ERP_RIK_LABEL) + 1,
-				&cryptosuite, 1, &len, sizeof(len)))
+				&cryptosuite, (size_t)1, &len, sizeof(len)))
 		return false;
 
 	return true;
-- 
2.42.0

