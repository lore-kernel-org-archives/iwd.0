Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF4161318
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094801; cv=none; b=Dl/cofcshj33N/V5aj+muJ2AAZfIkL8tYsVL9RsifMrj39M9cC3N6TPJMdc6iZ4blktvvV+kNjVdS8BBQkPKeROspUXl1Nil6fPkqDMWc0Two5Qmi6WEENX/v+aN79/sEBbXlGgVRMo1jQIFvHupjRSxDOf6MlHi8no8FmipXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094801; c=relaxed/simple;
	bh=GjHa9A2vjnKIznCuayBiQHm2mPw4f46OEszS2EoDcWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e+SObQ2CIpvVd0hbEby771+FRK++K9xesOBf2awFzyAZWVY4cvjdKa0BjszbUOsScbmWbwM4j8jIIGk+3QflzWzCyF13NiWt2kis5Vo11fRbHpgzWzBU7ulZPBXfqvPVpEXfkstyGFhtCLOtPtL1QnaOmj0HDt8ewml7oBpfBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5xVNtbI; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5xVNtbI"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c968f64cdeso780248b6e.0
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715094798; x=1715699598; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f3FBFWiEyX/wCQsxSu6kdaPCgfc1S8dPnTb9OcpUrXQ=;
        b=e5xVNtbIB0BKco2JkA1XcXKHVQPzxZCGdGxpGR09aha+FTCOpC3xVaF+ANqvCVoDv3
         cNiUYwJeLSNdRl52pOAGPkyAcrOwl+PQ5zbtYGXi0vY2MjkXbOO3UAbNiyaRrieLRjVt
         d/Hqz7dvmtgVF5i+EqTt1zWU+ji7J5TRdQxLrf3qLsQUioRcPh0ikZ9wrzAHDY1FiY+3
         Phomlgvdgiys0jKb+W5p0+iJ13f4vI8PRXfrAAXg6a2DwcT5aUSPIEjaRo1RciK6pxC+
         dHDIQKko+tuf5VxQxy0ZQ/ITz+QOA1V3Vc1pFJ6cKm3atJbsmUz76afTjHQsdit9SYRZ
         D+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094798; x=1715699598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3FBFWiEyX/wCQsxSu6kdaPCgfc1S8dPnTb9OcpUrXQ=;
        b=ZNNGb+Gvh+MrLK2PlirV3dKKzLeyPMS1VZRot/VF160vNr3r0y9dUDdHYjfGI7DOfB
         b67TVBxSP1aEsDtcVD1MOLnJ37pDKfmJBhFx7/dWRjoul4/9kpLlv7QPOlQAmX1fSJMy
         ZjdjYK7KYBwjWr1PiPpxLce4HWXlM6s+7nyO8XJWgTYp5S9o8ltSZcZZAmz9+66o1EQ4
         fwfVW92P5GnLGrXfrXdORZYQh3OtmCQZaTqh0wgvrsTqkg18kllgSf2Jslsyovdze/Lg
         XJPb21ksC37v41FBeKgu53rLbL27p5pqoHQyrRF27khwjadG/U9yI/Vvsng7Xj0qBQZ+
         4dSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRueIt3gCfc7CxZQIMYL+6ZiulDmul7Sd2czddr0zD6WM9FBZxsBhyD4v0sV4u0Irn03g7dqljYdY0j006gIaS9nnE
X-Gm-Message-State: AOJu0Yy1QRhQ+WotZ+Sb06ktTkLQj8HNY4TOPJSOno9FyC5SClcA+y28
	p1qD4MRO3CW7LwDLq1Arf2rzKdJJjQsqVc6S83qet4uuGHPIEaMl
X-Google-Smtp-Source: AGHT+IF1X8n3KsgFxWC8zJZRMrg/hlqnpZaTiBBERnZ7ajhvAEuUNLDW5ji6TGTv803YWy5sqIyViQ==
X-Received: by 2002:a05:6808:2181:b0:3c8:37b7:4a8b with SMTP id be1-20020a056808218100b003c837b74a8bmr22620775oib.7.1715094798431;
        Tue, 07 May 2024 08:13:18 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dl6-20020a056808614600b003c60d30f1afsm1857736oib.25.2024.05.07.08.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:13:18 -0700 (PDT)
Message-ID: <a94ed289-7e2b-4a5a-a4c8-3d4fb38929bf@gmail.com>
Date: Tue, 7 May 2024 10:13:17 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] sae: refactor and add function
 sae_calculate_keys
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-6-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-6-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/24 7:30 PM, John Brandt wrote:
> Refactor code by moving code to the new function sae_calculate_keys.
> This will make it easier in the next commits to add SAE support for AP
> mode.
> ---
>   src/sae.c | 86 ++++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 50 insertions(+), 36 deletions(-)
> 

<snip>

> @@ -825,6 +791,54 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
>   	/* don't set the handshakes pmkid until confirm is verified */
>   	memcpy(sm->pmkid, tmp, 16);
>   
> +	return 0;
> +}
> +
> +

nit: No double-empty lines please.  I took this out in my amend.

> +static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
> +					const uint8_t *frame, size_t len)

Applied, thanks.

Regards,
-Denis

