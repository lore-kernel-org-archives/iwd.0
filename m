Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5717C64
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866772; cv=none; b=ERMwLMIzSRaNVVklDM1qlpBwdVKRjBpFE0tAENveHqd+fcy1dRPiV4+cw1AQ0Jx6klz3S0oRWF6vut/dtewgW11Jfvoa0icg1fUdQOT8Di3tjCoAl8kYZ7P5Xhmk+wFryM6DKFYGyF53mQ9xGlZqUu0uu/4UhNqdtbPtOJ1mF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866772; c=relaxed/simple;
	bh=5Kh7239kURpGD3qNBNRZRfX8uNGWu7mX7K8jaMpPalA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b+yKHRuOgwrJDu84iGph6C/Tuy9T9/nyu3g0pOpp/7LhwknAxctLi3Fco9w87iCUypeoOp35xu834oo3uF7ZMIztn35AmZRlmPUDZS5edUJTg00ULmpjePCHzFjXTsOUFrQtgFDa+nm9e1xPEOnjT8/qnEDGwtZOcCRuqjgMnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMaVwWuC; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMaVwWuC"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db22c02a42so6616382b6e.3
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866770; x=1723471570; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6bY3mrqNIzuITrSIWRyTKXc88J/5bK+D4ESUTTV4UQ=;
        b=kMaVwWuCk+mP9fraYqzPxx2AL+cw8aIfygRGPed2b4s/mjSQr4+yh8onO3cdcrnnHr
         H+kWcKiGbV79nzqXHB4jsv5VPMg9bp/Nq44oCJ80yOeNCbj+VRfMpYEiT68Y9anlj42v
         l4qHv4Z0PKWoEKNslB3SxN20uxC5dKm8GFtg2hg2O2vRXLoC6pD0zgBROgNeDCi+k6p4
         Zg6pYe6iqpNkFYM5Y5z1BumR9MJxpWcUvgXMR4EYZj2YZ4H2T/AbATt75SuwkVYKKHoa
         NRY8cUBIvGR9iBsMlvbYTUl1GLymZ3n7cKsO14eqC9hu8+wSW5rP6mi/Eqhk+uXHIc6p
         hJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866770; x=1723471570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6bY3mrqNIzuITrSIWRyTKXc88J/5bK+D4ESUTTV4UQ=;
        b=ORH/3tn1O9hFwQK+wKj4+b0f6AxHxRmM//dAyPZouUFdWi154gc1L2qMt9B4LlAN1U
         uHibJuWpGT+a8iqjP3ONev1OmGowtp9KGvsIjD8woemk+Rdn1J1Jv85m1sj/NhkpnF88
         h0ALogLAVWew1r6EGdThPJq9ZLaasS6priVbMYhfwKOeFSIfRxSlKKt1ASSVZP548vBS
         Uv5Igt2uBnXHFn0vZ1qfB4QFUHn1EDfSq4tUCSbC3dLpJFb96RrW+oBYtNTHb2mxOP1y
         ZtkvkHz7y/dhoXGTemwmxo5TX4KuDvZXsgOwcuH06syk67AcmFfs2M+DaUbh5bnodilq
         aBjA==
X-Forwarded-Encrypted: i=1; AJvYcCXiM8HqVRnY+nceOXHva1Xhn1iny7PvS2Cex5Z26ZRVSN62TFdFv8O5NuzEreoDsfITZw3hV/PO61Qq0lw0Miaf2ehc
X-Gm-Message-State: AOJu0Yxae9+37HPqzH6Hi7yiBG9XU776SQJK0sjX7zeDOI9lCvZaRE7n
	qcd9TGAaG1NBhQTOWNse78fiZyODhfW41uFjSyzUvDgk2ItcBzrkNhH8Wg==
X-Google-Smtp-Source: AGHT+IHEggEP9/Xk/HR0G7p6D5QBKgJAboHU3yBpC1gzvZW4BiSx6Et8VKokhVKM8owkfc9j703YFA==
X-Received: by 2002:a05:6808:f8a:b0:3d9:dfef:d7c8 with SMTP id 5614622812f47-3db55817bf8mr16198380b6e.27.1722866770127;
        Mon, 05 Aug 2024 07:06:10 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3db563c76b6sm2658016b6e.55.2024.08.05.07.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 07:06:09 -0700 (PDT)
Message-ID: <6c55f881-d677-42a9-8bab-9be889e02978@gmail.com>
Date: Mon, 5 Aug 2024 09:06:08 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: improve zero oper class neighbor report
 workaround
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240731144717.473941-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240731144717.473941-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/31/24 9:47 AM, James Prestwood wrote:
> The workaround for Cisco APs reporting an operating class of zero
> is still a bug that remains in Cisco equipment. This is made even
> worse with the introduction of 6GHz where the channel numbers
> overlap with both 2.4 and 5GHz bands. This makes it impossible to
> definitively choose a frequency given only a channel number.
> 
> To improve this workaround and cover the 6GHz band we can calculate
> a frequency for each band and see what is successful. Then append
> each frequency we get to the list. This will result in more
> frequencies scanned, but this tradeoff is better than potentially
> avoiding a roam to 6GHz or high order 5ghz channel numbers.
> ---
>   src/station.c | 145 ++++++++++++++++++++++++++++----------------------
>   1 file changed, 82 insertions(+), 63 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

