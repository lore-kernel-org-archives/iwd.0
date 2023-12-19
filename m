Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8BBBE55
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjSO4Kzl"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7418bea02so197027439f.0
        for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 20:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702959336; x=1703564136; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ab5fcQ4h7Q2UJGCxPGU0XAIGfjjwCb6JdovhVDXEwUs=;
        b=WjSO4KzlgU1u18Fls/HsTvRXVFizz/8iZw9SvMIKIcbahrYtWCE1ZBSLxrAhCQyYHZ
         QzfyoNzftEncTdkIpiPiBuukFR49n3yU6FtIP5DnzPPmyj0H7ggaTqvyzsgvo6kRnpOd
         9YupN4h1fzj9g++4q9COsHdd0Zt/ajC/hCRZ8AN7m71ediO2P057RWpO8Sp2veiel4JR
         hNPg4XDd5e/ZIy9lb7RSSSRI4brmbcFw1y8CdqpFfEVU320mZ5H3XRvbiG1FSmBNAn3m
         6N9+2KrVHIDgCbpndZFowGyfX0bvdIYDtsc8UH0RLUZg5ZK8m1ZLvMtENEI5L/+Im1MA
         Me2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702959336; x=1703564136;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab5fcQ4h7Q2UJGCxPGU0XAIGfjjwCb6JdovhVDXEwUs=;
        b=VWWNAtJXu/aC5h/yZHTPBVEWb7/fCac/oucr2bWM+QhwNEU4Eh9cWTM0SIwvXYD/Xj
         WRLa0XFjM/iG79at0en0aIQdlHouuZsrreh0diO7SZ3XQdejRkFVDnPj/K29au2eqEqu
         aHYwz1SYHpBQvqJhqSs7BMhX3tS8gGhe95L1SIyZ5rDPdZbVJILgU/7x+EkDMSVKV50T
         sKFVcIowEzq9uJiJo1qs9C1DitVmiS7Wlx+ino2g5qeUo0JZt+Eb4Tz3OjMr19t9qkbc
         8cJxzuc8X+Jd+CYNjLtiapwQwMxEX/1kkbDIykQxtyH8fOhPu6JeY17vEGQH39CR/pti
         KNkQ==
X-Gm-Message-State: AOJu0Yw+3ZNXRzEhW8pJdn9EKKFuCPoPKQEIr7+kPgCEB0IV+niUOSM+
	7rBHpB+JI8KUp9h07Y8i6jY=
X-Google-Smtp-Source: AGHT+IEEIYoyxLkCF8Lr/wtxDWVYSMuRTYhnlGhWxQbEJBt2SkE7wuXHIXM9JLlu10qrMc+gReiH+Q==
X-Received: by 2002:a6b:7312:0:b0:7b4:28f8:e0 with SMTP id e18-20020a6b7312000000b007b428f800e0mr22179338ioh.41.1702959336042;
        Mon, 18 Dec 2023 20:15:36 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id y4-20020a5ec804000000b007b0684e260dsm6252143iol.2.2023.12.18.20.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 20:15:35 -0800 (PST)
Message-ID: <c17d1f77-25c7-4525-8e0b-a9dc972a04f8@gmail.com>
Date: Mon, 18 Dec 2023 22:15:35 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpp: fix data corruption around prf_plus() call
Content-Language: en-US
To: Sergei Trofimovich <slyich@gmail.com>, iwd@lists.linux.dev
References: <20231216211633.4000444-1-slyich@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231216211633.4000444-1-slyich@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sergei,

On 12/16/23 15:16, Sergei Trofimovich wrote:
> Without the change test-dpp fails on aarch64-linux as:
> 
>      $ unit/test-dpp
>      TEST: DPP test responder-only key derivation
>      TEST: DPP test mutual key derivation
>      TEST: DPP test PKEX key derivation
>      test-dpp: unit/test-dpp.c:514: test_pkex_key_derivation: Assertion `!memcmp(tmp, __tmp, 32)' failed.
> 
> This happens due to int/size_t type mismatch passed to vararg
> parameters to prf_plus():
> 
>      bool prf_plus(enum l_checksum_type type, const void *key, size_t key_len,
>                 void *out, size_t out_len,
>                 size_t n_extra, ...)
>      {
>         // ...
>         va_start(va, n_extra);
> 
>         for (i = 0; i < n_extra; i++) {
>                 iov[i + 1].iov_base = va_arg(va, void *);
>                 iov[i + 1].iov_len = va_arg(va, size_t);
>         // ...
> 
> Note that varargs here could only be a sequence of `void *` / `size_t`
> values.
> 
> But in src/dpp-util.c `iwd` attempted to pass `int` there:
> 
>     prf_plus(sha, prk, bytes, z_out, bytes, 5,
>              mac_i, 6, // <- here
>              mac_r, 6, // <- and here
>              m_x, bytes,
>              n_x, bytes,
>              key, strlen(key));
> 
> aarch64 stores only 32-bit value part of the register:
> 
>      mov     w7, #0x6
>      str     w7, [sp, #...]
> 
> and loads full 64-bit form of the register:
> 
>      ldr     x3, [x3]
> 
> As a result higher bits of `iov[].iov_len` contain unexpected values and
> sendmsg sends a lot more data than expected to the kernel.
> 
> The change fixes test-dpp test for me.
> 
> While at it fixed obvious `int` / `size_t` mismatch in src/erp.c.
> ---
>   src/dpp-util.c | 5 +++--
>   src/erp.c      | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 

Applied with a slight style fixup and added a Fixes: line to the description per 
James' suggestion.

Regards,
-Denis


