Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAD2FCC06
	for <iwd@lists.linux.dev>; Thu,  5 Feb 2026 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316325; cv=none; b=WAEvm82QMmvbICQzf7AS68TgZpoMvz/EaLoy8lt/tMDIORV4ozPnPJIviRH+jD+4LrmrWXwYOmhjtmT7cc61kVGRQA4+QVzV/vJJN2QWn0t/PQKi7whZS1uXq06y92Spvyoq3HSf/LJTtfX7AJBxO1fqpXRR3Ds0GawwVKVZ6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316325; c=relaxed/simple;
	bh=3iK9KnaapEGz+yrCfFf0BjL+vP4uuAt25OULk9oCYFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jcQKCWv1+PgxP+TsKIpKsgokgui9m7iloBJ0+CpyujbTVNtdEUbvMAv2ninhG2X+H5tegCTtPuHu2Whm7SLAqqDeQYwsmcLtG05OVVajDMdvYz5icO0GHy45EAkp09UZeAuicXesg5teFJsXhkWF+2Xj4kuSuZ11A8AAHBz8+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbKx9BtA; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbKx9BtA"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-404254ffe8aso961759fac.0
        for <iwd@lists.linux.dev>; Thu, 05 Feb 2026 10:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770316324; x=1770921124; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RZmjkey7F3LFDSBFQ5BGKqnfJBDDQMSMdZ3M7I1fVtM=;
        b=QbKx9BtA3mBTjs08t4J2wa+zCMT7jkSjcrZt9czMKuw+yuyo4hnXDk3k2mTDqwliRJ
         yBDZSt8ZAC6oz5au87z9x/GEodeTETnwR14B+cG58XUUcCT7p0Ku7RMFrQhmR8xxlUcR
         3TV7ovzasKuQ+EnJ76tPFHKcVTaPMMhtRb7GYewTb62zu3BaWzzjdCvv6ztbxOSxxJgV
         zh2NnSkcq2Hk+RHZ5BNotvuZMjF9aInkfFAOKIpUbS0PMmxXeVSu5vB9Axb7CCZZn18z
         NKPsljKJ0kSSkzzBaR51WOHjf8Ujs0BqhNqXy476McfwaQFXzt/uwCHYIvGDqWxCEu4x
         0N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770316324; x=1770921124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZmjkey7F3LFDSBFQ5BGKqnfJBDDQMSMdZ3M7I1fVtM=;
        b=tvYsP+tMS0rjHJtItDSf0+EX91XO5qjAuI7X/wpebR1Bu52s+U7dyptuH93GH6u4bM
         nCPS0HfTJdisJfJy6lh2pZ2PKGWYoRnblBnJOJg3QPOJxFQQ1MVUuACCBXNQ1o1eGiOF
         YUbfQ7v98JcKmcAKuHvRpPzBZjzfJfpGutxQ0mJMss/ZFQEINTUgU+e8l8LaXKuOz2nH
         /Cw2FwEHsaZSZze3u7CO0qWF162sPQdNBQCWvZ1A+rubCs4jh9agbEUNEJOFHLnIdMXr
         W2mWh8/d8f8piqRfLiGi/cWJkVZq9TP37vrNci7Vvhzrruc/ta5sLzHLrhs2cDFRztEM
         3irw==
X-Forwarded-Encrypted: i=1; AJvYcCUvVY9ODLvWnob+sK1HQnZ/KxDsr4ZqQ52b8a0x6nk96oY9QrEdlhfMRhuUqhFMqxLKbZU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzgk/CKoW+J4DXbH1nkCEdD/LJ4CgBt9JOixQWOBTWVFTOyqKFU
	/eqYJeD1MO3WnUGPw5jABrBWuon79yLdh9ODuc6UPxIQpOg4/PREAsiu+siRlA==
X-Gm-Gg: AZuq6aK0vqfW60GgSfkh6WPqM+VHDRvc+a25yrgbjsZCt2wxHuW47TqcAHDamqIwMV8
	BsG/c8MYtWoIQGCjtfpxlT/NYwZaKwDbg57NnWx/y0Ujy4AGCwRSKkqwFF0CdZgP6XANbnzf/cE
	tgLfi/YxMm3wK26nOk58W3y7freYOGCXQ8ehovpn0DXwHQB3q3/eFT2NAIUuiw0rOisooXa397e
	59+83LG3OO7AhjYLPBITp3I2/5WvmhloatFq8m/UB+3+CFRjsAcVAQiGYlRMtWlcAhICKFtcuLN
	GNon8NzCQoReVdAp6se1GDrOeKnB+a8tIZZFkNj5EkNJLRNSCcKRRDFz879fhKvC2DAlY0frr8W
	3UECpj3LmgLSDoDxDFRQYmwSrHUbo/Ia6XjKfvMarS/Mw7vvM+JW5A8eYnmtKmulyDQ46GQfENa
	SES6i+jVUGBNpSVfgZyQpe
X-Received: by 2002:a05:6870:2426:b0:3f5:b761:5234 with SMTP id 586e51a60fabf-40a757b53ffmr2084824fac.28.1770316324014;
        Thu, 05 Feb 2026 10:32:04 -0800 (PST)
Received: from [172.16.49.130] ([70.112.199.191])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-40a541e222dsm4428419fac.8.2026.02.05.10.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 10:32:03 -0800 (PST)
Message-ID: <69b859ec-e2fc-42f8-9996-12163d71105f@gmail.com>
Date: Thu, 5 Feb 2026 12:32:01 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dbus: register interface before acquiring name
To: Ronan Pigott <ronan@rjp.ie>, iwd@lists.linux.dev
References: <20260131215410.173845-1-ronan@rjp.ie>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20260131215410.173845-1-ronan@rjp.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ronan,

On 1/31/26 3:53 PM, Ronan Pigott wrote:
> If the interface isn't available by the time we acquire the well-known
> name, clients can get confused when the expected interfaces are missing
> during bus activation.
> ---
> changes in v2:
>   - put the NL80211 request back into the name handler
>   src/main.c | 38 +++++++++++++++++---------------------
>   1 file changed, 17 insertions(+), 21 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
