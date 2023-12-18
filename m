Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE14F612
	for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry+Y/vpC"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-425cbee636fso33905901cf.0
        for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 04:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702902650; x=1703507450; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQWQjFwWNAyDLVtNPmmyMMa1eEPa4FTay7IOJuij8Xs=;
        b=Ry+Y/vpCymSmI3HFLfO2vRdPro/EIHKCdZS9rpPeeRzqUwjzu8GIOphQ7L7EaA5tJz
         m9PqSQrW65cgy6vyc10FXvM9ntA22yNPLoq8FtqzhDjRGWp7J2fr//e2p+pXopYz6UZn
         N6cKayguvCENRTw0uTV25VYGk/ouJU/hdzll3HZvn8EIteoewgI7/Q9I9+yMo1YMjepU
         zvQonWPR8bksKg93t3OS9UTXeVHIUa0lwd1YaD8uSZZmuuaiBZMMHjNoY6gbana0O706
         ez4zNHC2JCGB/hjVluNfXAmYpOYP+azolFzQaSj0mi5otn+427cX2Er0PULt5klZ7oih
         AzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702902650; x=1703507450;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQWQjFwWNAyDLVtNPmmyMMa1eEPa4FTay7IOJuij8Xs=;
        b=HXeDFQRppD71VzxongPwbIlW0KwJ8LIYocH2Lt3HkUg5VhvOSQ2kb57cHii8qPstEZ
         qnaC2SziDaYAMoQRUW3z32gj7tgR7Pg/5RFyW6dNJ99GI3+cCk6rFFArwk+BH1sXb81x
         2hgkpdh580OFSEHKae47kwTao8OD10N1Hbz0qpsJVzgdAEO8i1YdrcAO8Kgh+rl+SBVK
         +RHBgUapLqt25FIHBmd0bGLpVIFF403MEGs+lV1nXv1lCW0GiExDmg4IPKs+bjvZeIO0
         /KUmW6d202xrRKH3aCHvQUjtroatGfXk7HgTOMcks/77Bkq7qd+xf8AjN0df6u8vCaW1
         fXvA==
X-Gm-Message-State: AOJu0YyyxKD/HmkjespDs0Fd9wog3i8j9DyEC+H+ROJra+O2304s6zrw
	7vyILla15qcGHw7+iU2tLqg=
X-Google-Smtp-Source: AGHT+IG0H240+FiOJMBcrofB+d02eOPJI5mgs3SB2Nx2tNc2vzcTkl2wtJG49l+jRyKO8hReJ3Ecvw==
X-Received: by 2002:ac8:5cc4:0:b0:425:98b5:945e with SMTP id s4-20020ac85cc4000000b0042598b5945emr24962529qta.85.1702902650258;
        Mon, 18 Dec 2023 04:30:50 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id fu19-20020a05622a5d9300b00424046df696sm9249600qtb.43.2023.12.18.04.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 04:30:49 -0800 (PST)
Message-ID: <f2a75489-7a55-420f-bfe6-6d51dd9aef6f@gmail.com>
Date: Mon, 18 Dec 2023 04:30:48 -0800
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231216211633.4000444-1-slyich@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sergei,

On 12/16/23 13:16, Sergei Trofimovich wrote:
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
> diff --git a/src/dpp-util.c b/src/dpp-util.c
> index c805b14a..91d96297 100644
> --- a/src/dpp-util.c
> +++ b/src/dpp-util.c
> @@ -1376,8 +1376,9 @@ bool dpp_derive_z(const uint8_t *mac_i, const uint8_t *mac_r,
>   	hkdf_extract(sha, NULL, 0, 1, prk, k_x, bytes);
>   
>   	/* HKDF-Extract (since it doesn't take non-string arguments)*/
> -	prf_plus(sha, prk, bytes, z_out, bytes, 5, mac_i, 6, mac_r, 6, m_x,
> -			bytes, n_x, bytes, key, strlen(key));
> +	prf_plus(sha, prk, bytes, z_out, bytes, 5,
> +		mac_i, (size_t)6, mac_r, (size_t)6, m_x, bytes,
> +		n_x, bytes, key, strlen(key));
>   
>   	*z_len = bytes;
>   
> diff --git a/src/erp.c b/src/erp.c
> index 85923346..7aa80bab 100644
> --- a/src/erp.c
> +++ b/src/erp.c
> @@ -325,7 +325,7 @@ static bool erp_derive_reauth_keys(const uint8_t *emsk, size_t emsk_len,
>   	if (!prf_plus(L_CHECKSUM_SHA256, r_rk, emsk_len,
>   				r_ik, emsk_len, 3, ERP_RIK_LABEL,
>   				strlen(ERP_RIK_LABEL) + 1,
> -				&cryptosuite, 1, &len, sizeof(len)))
> +				&cryptosuite, (size_t)1, &len, sizeof(len)))
>   		return false;
>   
>   	return true;

Thanks for both finding and fixing this! Its always time consuming when 
we just get a report of unit tests failing and don't have the 
architecture to test on so thank you.

Denis may just do it during merging, but we also should have:

Fixes: 6320d6db0f ("crypto: remove label from prf_plus, instead use 
va_args")

Thanks,

James

