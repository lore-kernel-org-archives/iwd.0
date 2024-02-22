Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965E14F9F6
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618570; cv=none; b=J7ARmMZfvDZZZmhu/RyaJAekHfBeTLYhW5rjkmpq59Bq51ZfIJFHwf450EkVBGxwSlo96ngbvl7TFHQYx3h+aeT0dyIIhMTdtVEY8GmZcx10flv6AbGFH9QakuGoxNyarPYvSJXNmU/7xGz2b9HL85y2fvIB2H428mKu+5veuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618570; c=relaxed/simple;
	bh=fLj4U+5tlqxonJUNUk9Qp4fdMUy1h8naXGf0MmbK0PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jzIPBnxocF2MLG/aO+HNbq/b1p01Y7UPgkoeiT1bnJi7Kabuv9md/fycXwVU/hIabYA0Mc+oiX0msQy0/xHGbiaCnQTWYm/XXZ37Jc9glbnZGOLCY9K/B5rM0Rz8JgHVB6LuzLpgeGoZh0eGocMUSDdJ7V6sJtKJNgAsKLT6Y2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzbnecgv; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzbnecgv"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2185d368211so1017887fac.3
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708618568; x=1709223368; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0OfMHHP5ULAr/QusxCuWrlxz9qKE39/gbMzWeXr2ZI=;
        b=DzbnecgvE84xc9fpSWQ+osiBDJl8oGmGyf6yiv01rAnFJ4DCW7vBMqCbxTs1EHhdb+
         UA3xuSj1kESF3AvAi8cl5tRiujwEQ5b9Mmqf16Zd8jvwzCRAU/93JR/dgcphYFsYVcGp
         LdecqdNpaqS6Lg1QGYYN7854/CWbCYzdxn9lpBTtr57/VXIZdpMGbUQOhqVWV2v+RciA
         WwrnL0goihyrUpAHTT2iSf6fLohIXMWlVVI3QQNMU21dgA/v4rxFBRO64rDB/6pBLPqP
         36Gt7Cvp6OReCspnQVkt/Znj1JMT5lql3aPst/9RDynrt67Swi3lLFY8t9QbDQvhpu3R
         KOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708618568; x=1709223368;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0OfMHHP5ULAr/QusxCuWrlxz9qKE39/gbMzWeXr2ZI=;
        b=BFG/dmrYpLArdsP1uMrVJZTO0D5khWFaF0aK6FPOVJs7lCbskQGPv1j2CUdNPORJu1
         v7JWe0nwe8JiAEreuDVNVQUk6oK72QjjXVJURaIeRiIusJ+VjxbokCUOX4Gvndq9nSYX
         S94qLiMG08NUFzptWj3pco4LohIxjrQOyZhWw9K8UmXYdy9VhUla5vcomIc6RbzYCxdF
         vU5qHYXb+KJUiv4TC7UJVoRY/XAHm2bdP39AII1/+fmDJf6K9sJGX9pEvOCPzpvs6PLr
         iykyAM646I4q3u1u1I5sJyMq9vfXId5ob5wrH6U4yI/5WudPFIv2z7mJp2xdchgvlCqz
         8YlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT4nZuGxmpJ4V3j0Z+QAT6uRXA/R1GSW2JXqpj+r5+SiELe7YPFc2rqSaeMBs1EgxkHxRo9HENAJAmelFr+KMfX8yi
X-Gm-Message-State: AOJu0YyEmBZmxxABcRWGnZPld7ujjompiYNs5FzxJYmOBZtL+kSXaKUB
	W8RjYvRABuVCB7X90yNaexbwNS2Ue1qv0lAOqfqfk+hYOiTq2QRJ
X-Google-Smtp-Source: AGHT+IE7OIuoYY13oTyDSoYvKrnBcPv4FUG877ARBZo/kMuYj/WbsEAyK/1ALGKd9LF5MomYn0GKRA==
X-Received: by 2002:a05:6870:b4a5:b0:21e:7a82:3feb with SMTP id y37-20020a056870b4a500b0021e7a823febmr19905686oap.33.1708618567705;
        Thu, 22 Feb 2024 08:16:07 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id nz6-20020a056871758600b0021ed5ee3c77sm2127292oac.16.2024.02.22.08.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:16:06 -0800 (PST)
Message-ID: <7a8d7491-95a5-4823-b749-79198a04f24e@gmail.com>
Date: Thu, 22 Feb 2024 10:16:05 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] main: add runtime flag for setting the logger
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240222152451.1541682-1-prestwoj@gmail.com>
 <20240222152451.1541682-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240222152451.1541682-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/22/24 09:24, James Prestwood wrote:
> The --logger,-l flag can now be used to specify the logger type.
> Unset (default) will set log output to stderr as it is today. The
> other valid options are "syslog" and "journal".
> ---
>   src/main.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 

Patches 3-7 applied.  1-2 should have been applied using an earlier series.

Regards,
-Denis

