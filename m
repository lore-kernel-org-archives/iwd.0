Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C319BBF
	for <iwd@lists.linux.dev>; Sat, 11 Nov 2023 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxnpoogy"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6cf65093780so1756874a34.0
        for <iwd@lists.linux.dev>; Sat, 11 Nov 2023 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699719921; x=1700324721; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05aLZ/bYEtyTIEeEft9TbVK5mvyP1bqSoX9r/Ds8wSs=;
        b=mxnpoogyw1lgFjJ95mgK1MSrJ3MXkJSIbsV4QIvbUwXWgw/dz621exQn1C5RQWA8q+
         vbfIExgBog4rsUhRZb8BusZ6e8eQIEwCYH10oRpOz/ATWY8KlZ6G0skxnHrLiWu5drYT
         3OFjNLsmnJ8RL9VhWBk+hEK+IgIjEAh9IZCXg0VMeuWfa4oRcQPTXinhFISPABJWljpw
         sYZSO0MeldKreQUuaQ0gdzjrncMsNaaNOd2ALbAYtGNiKja1Oyq4yFYj/xPkXxh0hzts
         7OPLop700aIfx24khuBRcFazZZchW1tWhPrOWNZqwov5bt6sozqnrYJ9jNSJcOElnwnn
         wPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699719921; x=1700324721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05aLZ/bYEtyTIEeEft9TbVK5mvyP1bqSoX9r/Ds8wSs=;
        b=R1Y8lNrxVDNUz1jVQUUDsR+mvzE2k64NXiOKaNPoHWs1HyRvM2vqFlGbbOATZj1R7r
         X6i6cz5gpvpxmCg7SDNm6cqjF/8NfZS9N8X6P7esltWjLnBKTpZQSGpVRSbz3oqFEz2+
         7a+6TQX50CwtIOXXOEQ7Q6WavlQ9cSujmRPhKPPfD4e4FxriEGPLD9jboWa3bbuA6fhU
         Ec5+9HCw3yx0dQpM1Vg8ke+CnMBCPEi5w8wuJ2P/TZ5fw+3PjeC8WqtDNx3LxTUim4PG
         g6OgNY9J10B5cD1d1YE+LKZMv912BqOP0dSLgGI8v9atkWamLyUSWr6en5EhP9xc3wGd
         E8Gw==
X-Gm-Message-State: AOJu0Yy5pPBYx4KRdnOivSycmfXfItReYZaaRMMnSl+9cwaCOu9pMDTB
	hVnVyiKgJtuAsBolbhFk5is=
X-Google-Smtp-Source: AGHT+IF+6k/Yl/I/0YBYRXaDZK4kfu9gaDMRDmEqMfN9SIOkM/38EDMO/4hjxor6VPiPUrrPJej3pA==
X-Received: by 2002:a9d:755a:0:b0:6d6:4e53:c81b with SMTP id b26-20020a9d755a000000b006d64e53c81bmr2987722otl.8.1699719921493;
        Sat, 11 Nov 2023 08:25:21 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v13-20020a05683011cd00b006d2e04a55e8sm270020otq.14.2023.11.11.08.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 08:25:20 -0800 (PST)
Message-ID: <cae87f8a-9b71-4ff6-9cb5-729e41c34c54@gmail.com>
Date: Sat, 11 Nov 2023 10:25:16 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] client: display_completion_matches add 0-byte check
Content-Language: en-US
To: Finn Behrens <me@kloenk.de>, iwd@lists.linux.dev, secure@intel.com
Cc: dev@leona.is
References: <20231110101558.30639-1-me@kloenk.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231110101558.30639-1-me@kloenk.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Finn,

On 11/10/23 04:15, Finn Behrens wrote:
> Check that enough space for newline and 0-byte is left in line.
> This fixes a buffer overflow on specific completion results.
> 
> Reported-By: Leona Maroni <dev@leona.is>
> ---
>   client/display.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

