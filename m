Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974221A1C
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812603; cv=none; b=gF4EJc+kU3yAmdSyIVjg7+G+A3azmaigKAyWAS0Z/hNc8d6onromnih129SaY9Qsnqp9GBS1+e7tTHxbyWIm8Nj8XqBiG7Vzhh8ApJO5Q/NPrdyp8tDtFcragWpDjrhRVUFzuz4lK+cbleAdLAfAfZltqKV5TXe6YCzlJuqUsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812603; c=relaxed/simple;
	bh=MsvqHBgo5m7pve80PAyQQSuLnTwLSieFAnx0yrtskv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B6ooy+h3vCGXQoyE1hoFjXmkS+MRO1sLD5uN/R0n7p8jaH4Huf9I5oMzUhIJCEocCuqytZfqQmRTBNfoX5RT20iGdHH7JGnRjqHPHLyj5roTPqV79zrpUu5ixoXm6pBghsrXHYpkSaj0VSUN/0AccgY4rOc0eUZdSmXDWMBNaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8NLB2DW; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8NLB2DW"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5bb2ac2ddso84611eaf.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 19:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724812601; x=1725417401; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aKOp2E1F0dJkdwNPoO/DhzQgMD0huq5vkzj5oYnDCUw=;
        b=a8NLB2DWzgg8e7adFp10M9lpqDHyFxy+wPBkSsXjWaQLgS58nD4B2rWAk0bksFEulw
         3kpl49YAL3m5pxXBkH+lUggol5AL9dj51LA0a+H8ZJHK/ZOEeBeXP9K21gV1+LN9OUVW
         mZIrw0+6Lo+MG+7eWRWiWQ++5jb2VlkZZ/zZU1riYRNZirxqEigSl72cdxz4llUc7vd0
         oTR7aDOKveHyh89ARfLAwgvceiiheOJcZ3RN281VtG0NXYRWtA1pwceXmVh46wgY2qnm
         vG7Ta442nOxmye06fXhN/foPbMC0BLNy2yNknWZGK2NSiADk3L/+hNCmkJhYZq8SWoGh
         fKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724812601; x=1725417401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKOp2E1F0dJkdwNPoO/DhzQgMD0huq5vkzj5oYnDCUw=;
        b=aQydhALdNeVMj6k1+ZZ2K2V8GtZDyufYdxy20wYec+WglJ/zXSTkMZaeZlpvePlobo
         czqGRPbleeT1fN0ItKv5gzJyEIWuNld/1pIF4GRWtSHPUgZX1tQ+Eng8m+6sC5HofHwM
         layiKaUG8aQZIuJeEaPuScXtNubfM/+6IoMkFR/5dPnqTI6tgNECqQSJc7QebDmGqSPO
         3txiF+o76htJo8PlL/lEWo49jdnYS0rS9X4E7/x5JxZtYGoQkNglTFY3xT3ly+kPMfuo
         qwUhgArPPJNVZIRPNg93Fxz0JhtitE3Zf6TpFo0nLtDgCf2IVelUEQtQsEyoVDjeBCwo
         HrDA==
X-Forwarded-Encrypted: i=1; AJvYcCWa90AS0FVZP3yORDU2f0CohDf9o9E5izJjonWRvr2G5ItyDepjALyxOF//irvgCDM9Tkk=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywvkx+q7wOP9zKzEoWdfRtl+gnO1N3WD+1q09TlyHNUt5YJBGHK
	mI1AEGYEPNg+6Kx4roLW7g36l8Cov3h5sJ/owtncG83bqbWLUCI1QU4kxA==
X-Google-Smtp-Source: AGHT+IE+ZcKVP/8TN6nEUyM/j8yltGNIBPwUsvaQIUAFlOqSFaU0pEQ+zTQH4scfO2hbBAmZOuvoUQ==
X-Received: by 2002:a05:6820:1acf:b0:5dc:99d3:d3bc with SMTP id 006d021491bc7-5df85fb3f5emr279988eaf.3.1724812601303;
        Tue, 27 Aug 2024 19:36:41 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5de842d3ca9sm1783342eaf.17.2024.08.27.19.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 19:36:41 -0700 (PDT)
Message-ID: <0c2294f1-8b91-446e-ab08-048d40e0aeff@gmail.com>
Date: Tue, 27 Aug 2024 21:36:40 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: check for roam timeout before rearming
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240827141037.745738-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240827141037.745738-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/27/24 9:10 AM, James Prestwood wrote:
> A user reported a crash which was due to the roam trigger timeout
> being overwritten, followed by a disconnect. Post-disconnect the
> timer would fire and result in a crash. Its not clear exactly where
> the overwrite was happening but upon code inspection it could
> happen in the following scenario:
> 
> 1. Beacon loss event, start roam timeout
> 2. Signal low event, no check if timeout is running and the timeout
>     gets overwritten.
> 
> The reported crash actually didn't appear to be from the above
> scenario but something else, so now all instances where the timer
> is rearmed we also check if there is already a timer set.
> ---
>   src/station.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/station.c b/src/station.c
> index 30a1232a..e188aed4 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -2221,7 +2221,7 @@ static void station_roamed(struct station *station)
>   	 * Schedule another roaming attempt in case the signal continues to
>   	 * remain low. A subsequent high signal notification will cancel it.
>   	 */
> -	if (station->signal_low)
> +	if (station->signal_low && L_WARN_ON(!station->roam_trigger_timeout))

I'm reading this as:
if signal_low and roam_trigger_timeout is NULL:
	1. print a warning
	2. rearm the timer

Is 1. intended?

>   		station_roam_timeout_rearm(station, roam_retry_interval);
>   
>   	if (station->netconfig)
> @@ -2260,7 +2260,7 @@ static void station_roam_retry(struct station *station)
>   	station->roam_scan_full = false;
>   	station->ap_directed_roaming = false;
>   
> -	if (station->signal_low)
> +	if (station->signal_low && !station->roam_trigger_timeout)
>   		station_roam_timeout_rearm(station, roam_retry_interval);
>   }
>   
> @@ -3202,6 +3202,9 @@ static void station_low_rssi(struct station *station)
>   	if (station_cannot_roam(station))
>   		return;
>   
> +	if (station->roam_trigger_timeout)
> +		return;
> +

One thing I'm a bit worried about with such a simple approach is that we might 
have different roam timeouts.  For example, the 60 second roam retry interval is 
active and we get a low rssi event.  In this case we probably should schedule a 
roam sooner.  Maybe we should book-keep timeout information better better and 
make sure the timeout happens within the minimum time (active time remaining / 
new timeout)?

>   	/* Set a 5-second initial timeout */
>   	station_roam_timeout_rearm(station, 5);
>   }

Regards,
-Denis
