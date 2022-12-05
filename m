Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC3612B
	for <iwd@lists.linux.dev>; Mon,  5 Dec 2022 16:58:50 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1441d7d40c6so14135445fac.8
        for <iwd@lists.linux.dev>; Mon, 05 Dec 2022 08:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfN6XNuiyy3i7+AY1yzClJDYTf7ekRpsp4MKepiMqSE=;
        b=UjPVTigwdF365Zh++N4QDQnytElQnOOaanLzO4CabQDWD4wzn4CtSVObb8p4pbMCSG
         C0D284lca0243EBKc60N+QfujBx4umLo/46nOAl9joVh2N5YZWe3GieKX1AUbNDj26UB
         tNJNB/QcoBxcLylnFCHn5OyiYx8oGaUSVFPcd5TDIMhsrg301BVFktz/gIbwMmXSybXg
         3xDkZesT3iGSPl6GdNvlhzk6lGy7A088yFtTnxMm55ojF3G1uRTwtMqXosuHdsZBYEB4
         VxOM26EY25l4pNAZWnX/HzLjIxM78PqpaLJ1f3mytL/UQ0rycl24shrjB8wxtz51aw7J
         xZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfN6XNuiyy3i7+AY1yzClJDYTf7ekRpsp4MKepiMqSE=;
        b=hmwm28ERoSH5Ody076HvUs+upYrbYV6m1xMFEF0/JaRWqzUyWrScuFyfhPnFxJwroZ
         mFNUDzTmb0nBAEvvj4RfM/T0e0XLiwi5QhDqsqH87mmYIeuKtfPPLfWZRssFIz3Vn1W1
         A6AmGK55IwAsWz9SqFLValk+9dN8ZBQ6v6lFqKqGCI0I4Lkj5uNDGftlUorv47sCKv0d
         JpJpU6bnqUCEzNjqh6b6tMLBAjk3SMbN7wB1JO9rvMx2B8jkOCwjLGtSGhA59xcrV8a4
         g7aqCwMGQoJWhm8+fXJ4pZDY09vnn+sRZV5bt0ZoITsuwgdRhlApuONXClx4wSgPYHrv
         rjzg==
X-Gm-Message-State: ANoB5pkfoIQr6okQKlS16J/FRg52DJf+TcwVqHR6KcG0AAjemLh0inMh
	Az++pK7X1BBYKV8YWpjuv4g=
X-Google-Smtp-Source: AA0mqf4sU9XCCgeC5obq9uW2ZY54yO9S7Uf+PNMF8Nnmqft/JwOXpm94vQVdZVFCXWqKufRrDoBOGg==
X-Received: by 2002:a05:6870:2f0d:b0:132:44a2:f14b with SMTP id qj13-20020a0568702f0d00b0013244a2f14bmr45377182oab.238.1670259529834;
        Mon, 05 Dec 2022 08:58:49 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bq21-20020a05680823d500b0035a2f3e423esm7313146oib.32.2022.12.05.08.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 08:58:48 -0800 (PST)
Message-ID: <d2df3b8c-2b0e-b587-bd04-4892e4e84f5c@gmail.com>
Date: Mon, 5 Dec 2022 10:58:47 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WPA3 SAE passphrase limitation
Content-Language: en-US
To: Emil Velikov <emil.l.velikov@gmail.com>, iwd@lists.linux.dev
References: <CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,

On 12/5/22 10:19, Emil Velikov wrote:
> Greetings list,
> 
> I was playing around with a router using WPA3 Personal (only) +
> CCMP-128 (AES) and noticed something odd. Namely: the 8 character
> limitation imposed by WPA2 is enforced with WPA3/SAE.
> 

What 8 character limitation?

> Whenever I try to use such a passphrase (via iwctl) I get an error
> "Argument format is invalid".
> 

Refer to crypto_passphrase_is_valid() for what we consider a valid passphrase.

> I realise it's not the best practice but the exact same router just
> works with my Android Pixel phone.
> 
> Would anyone be interested in fixing this bug? Alternatively any
> pointers where the validation happens would be appreciated.
> 

What bug?  In theory the passphrase can be anything for SAE-only networks, but 
since there are plenty of cases where hybrid networks exist, managing separate 
SAE and non-SAE passphrases becomes tricky.

Regards,
-Denis

Regards,
-Denis
