Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95E612FC
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133796; cv=none; b=MrFXg/iDUxsqMyoOMwGqRKQvca2X6r3CTUnVS3QGIFUrNAZ83lQl6sXSYZWBB7gIZ0zP0JB7WnEQFhaw/aiBFohpnME9ch7XmWsJXvvtD2LFa9T55C5HFmAfaWlVcfRsi6orQoeSRCjM5Yem87CGk9ZPlnekjk+vb3nv5kXLrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133796; c=relaxed/simple;
	bh=RxW4BAjZTSyWlytBU/cHjTWuZn1tD7drqye3tWX6kL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LTXpu79mBKvHNfmjjerXNxH9Ykht1NncmvGk1KyWSeV+gevYWwo22VH67dTjcVJrLREbRp7kQx3jEFAPHry32qHT0Th3fkegpGfLg3YMqbR3WPp9lelKjmJalgJ9bIj7EadG+JSituKh+bXv3Lde/aRZWWnb8e3eaJlXW9xqUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ymo3rn6G; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymo3rn6G"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59fcb025b99so422653eaf.0
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 07:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709133793; x=1709738593; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3lviJXjIRlUDgZbfxOMhJxWFNZ57TMLt5v7UOBEFmI=;
        b=Ymo3rn6GuU7V3dt1SPgKcUokRE3E+dWLeStXqnECtByWm21owWZ7xmiBw5f5I8TMX7
         VvhJB9U091Inj7bKo3kV9qPsNFtJ7kZs+OOJBge5/UeGviv9R25S6YCJjjxNqpeunkaM
         6DBjHYeVpteMpgruWnKO70m4k03U79a5WupjvZ6qOTbPH6l6fGlVahEZb2HhEu2raFi8
         Bd2vp9U7kfbZ6u9QQUcPTyqx/ZC6x+Dhh/S0fhO+UtxhdoxZneEuK8fWKHiLUfrv5Coo
         YxN3pOZdxwenJrmhOdizs6jeSO79FfXlxcR6bBbCugEVrsA0Owzh1P16jbYZGbhJp7Yb
         0WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133793; x=1709738593;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3lviJXjIRlUDgZbfxOMhJxWFNZ57TMLt5v7UOBEFmI=;
        b=VEZgIjQt7Y4JB5mP2D9lCKitCvzFvLitjuRuZQXvUD15U6igkH3vNmFpDJlP6LApDw
         4T5rUIxTnleF9DL11Erl3cztE3sx2JRPVfp/lZ7KAiRM8ljgcDc1W3ivxWCnPZFHHubj
         BCsE2AY8G/EjVVntrvJHFY/cchKOikAnnbyGnhmxx33bvmEIy4flTwWlTbcdsWWjA/UZ
         y4kTPeK0iCknEMEaJyvaxg2lfXCL2dpmFFlMlMGJ3BMqtcK3+Fa3khqD5h2wyfEh2+sY
         LURktwP+iJZlRFZK81g4Ldlf7Q8dRi1Eg2JLy05WRKkPL4HBjX5ZZf7xkMxLmFb0MG/1
         fieQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxFNCAsiuQecKqMP7IdKb3Bm2c/7VV9gSwT6ZwVBo/+5/yp7X3wovfFvuvoLLlof6Wau+oi0phPXbstaDY7JsGP7eL
X-Gm-Message-State: AOJu0YwjLd9SWirHhB7BgAtE0rgu/M+8pURF2TtfysReAOeXvxN/DTJ1
	9Mh+TudjCsew+QbKp86DtcLLyc+8cTtrXyMt+Qwo12CEjG/AcMQx81MUyOvg
X-Google-Smtp-Source: AGHT+IH/RkzlwrVLSYRFLxse03zv7uBpjlJUw4UtBvFj2Ch+FXa96yuk5PNGCa/X0vzoc7WXfCWbmg==
X-Received: by 2002:a05:6820:2c09:b0:5a0:2a61:9f38 with SMTP id dw9-20020a0568202c0900b005a02a619f38mr1110065oob.2.1709133793648;
        Wed, 28 Feb 2024 07:23:13 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h18-20020a4a2812000000b005a0a891d51bsm864179ooa.40.2024.02.28.07.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:23:13 -0800 (PST)
Message-ID: <fc42922f-d595-4394-9234-2a3d8600d12f@gmail.com>
Date: Wed, 28 Feb 2024 09:23:13 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: auto-t: fix netconfig to handle resolvconf values
 out of order
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240228124018.334892-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240228124018.334892-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/28/24 06:40, James Prestwood wrote:
> The slaac_test was one that would occationally fail, but very rarely,
> due to the resolvconf log values appearing in an unexpected order.
> 
> This appears to be related to a typo in netconfig-commit which would
> not set netconfig-domains and instead set dns_list. This was fixed
> with a pending patch:
> 
> https://lore.kernel.org/iwd/20240227204242.1509980-1-denkenz@gmail.com/T/#u
> 
> But applying this now leads to testNetconfig failing slaac_test
> 100% of the time.
> 
> I'm not familiar enough with resolveconf to know if this test change
> is ok, but based on the test behavior the expected log and disk logs
> are the same, just in the incorrect order. I'm not sure if this the
> log order is deterministic so instead the check now iterates the
> expected log and verifies each value appears once in the resolvconf
> log.
> 
> Here is an example of the expected vs disk logs after running the
> test:
> 
> Expected:
> 
> -a wlan1.dns
> nameserver 192.168.1.2
> nameserver 3ffe:501:ffff:100::10
> nameserver 3ffe:501:ffff:100::50
> -a wlan1.domain
> search test1
> search test2
> 
> Resolvconf log:
> 
> -a wlan1.domain
> search test1
> search test2
> -a wlan1.dns
> nameserver 192.168.1.2
> nameserver 3ffe:501:ffff:100::10
> nameserver 3ffe:501:ffff:100::50
> ---
>   autotests/testNetconfig/slaac_test.py | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 

Looks reasonable to me.  I'm okay applying this even as an RFC, unless you want 
to resend?

Regards,
-Denis
