Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF816BE34
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846888; cv=none; b=TuZ5A0rFjXxMXm8QEWIyoy13UuDEelNWiWYxj7bogSTUx9QBBr+NB64DdRC97W63vpjfsHEid6FE51hTnVkcSoAktfXq9hdtOhlfVinjLR4HQWMHncv48xbdQUjOkZTjog4fGjkeZEHJjs67QfnFo9tYR7AAxfma6Gqrya9zyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846888; c=relaxed/simple;
	bh=KRTT+fiS5dw8icB/UDcr3RdYRRcJ6qXverKlSBDIuQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zri0t79UGUxPXQMz4TawWxpdKAr4m6ATAKxxY5C/E9Ot/9NLUHVKyFD717a9N0z5H8GzOiS15SMHHtnbWoqwiV47/P/s/pFpNIuTl3OJJHF9alTRkgGv6SkAec3WpfGJ/EeO3JvO2EHaCZ6tKseBNOS9++z6JcLtuYYXeKhUPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYQ6aDM2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYQ6aDM2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc47abc040so57905785ad.0
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724846886; x=1725451686; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0vfPvlqMqix0WWwnk7T5dCbfxCIyaFmXu6roj4Z3g04=;
        b=TYQ6aDM2y+z/zy4QAiEs91Mp5GS6AhUBzFhop81DQOmgsJiv2eTIhk4KfFWUhVtDFG
         RW+0ZYIiCyrJIXd6z1DqdY/EuFX1w08NXNgAzleFva1Xwe1a1+g19hg8sUSRPzbjZpKv
         Dj1Iuo88H/CefDWS25BKOsCavoy/PpNAvv2PFh/9G4QyuGHSjTkz4ciV0CZEpwmcNwPP
         AvuHZhUcZVoPJ3Ts2eM/nN5z/NxNkXwBpFs91qaCdD/NGlLamn3MJI72eafhmwHsGEZZ
         kSvyvYAaxeBBVWTCKkogIqgdvXTAMHjM2Wq9F9sQk7exgDrWI6uu0054K5tdyGw2Erki
         Zicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724846886; x=1725451686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vfPvlqMqix0WWwnk7T5dCbfxCIyaFmXu6roj4Z3g04=;
        b=lqCF1ve+JsJBHsITqlfOk4Wy6lLNOS4jImWuBKEkDbAz5LuZOXvx10nuaSeQYV0Fba
         J46T5QOqvqlzNPz3otOKKHIdYT4yJ+rYR24O6UBYIWgAXh6hln34mtV/lWBOmoQ6YMqv
         VM51Z9KQ36XbUVGNbak0lL45enjqdjGCP4gMdU0HD/fW38/yRC1m612PL3rAJclF8+yq
         txT8fjkq8xod2xwhcQ+EnN3vIwH6nOh0nNflO8xnYMjS5Xr4zBpljqaqH4ssLrFwtILr
         JCNUE/bHUSWw+Dfz7v0gMC9oFSGfP6u0cJ4Q+2J4Jmz+kTfTlj752FhhcRGdmUXM4RIO
         IrMw==
X-Forwarded-Encrypted: i=1; AJvYcCX1cjNtQVMPgWf1y+6cSseh5qyzvNfj8dJeoQxO4Ebsdvta6fKEkujk+VV1ij7LH/rLvCc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yytrxl8kSIhpHLSEleGqviFf3ZBFGZRD+FZzypL3Pg+d0Woi/uX
	Vi15WxzIM/6JnJvlaG1a4AQK4Axl/eGO51N3+YtZ3iqFB4hKNdmq
X-Google-Smtp-Source: AGHT+IHqaJaEWvPkaIZMq0Xspx+MXN/7ydK/svI6LCotvMRrWLwG0k+eVGQPJJ718j/7Drm5sQvQfg==
X-Received: by 2002:a17:902:db02:b0:1fd:82ac:7c39 with SMTP id d9443c01a7336-2039e4ef32bmr156250495ad.41.1724846885921;
        Wed, 28 Aug 2024 05:08:05 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609a88sm97826515ad.208.2024.08.28.05.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 05:08:05 -0700 (PDT)
Message-ID: <96473c52-e2d9-4a3c-b38c-0cc430d18d17@gmail.com>
Date: Wed, 28 Aug 2024 05:08:01 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: check for roam timeout before rearming
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240827141037.745738-1-prestwoj@gmail.com>
 <0c2294f1-8b91-446e-ab08-048d40e0aeff@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <0c2294f1-8b91-446e-ab08-048d40e0aeff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 8/27/24 7:36 PM, Denis Kenzior wrote:
> Hi James,
>
> On 8/27/24 9:10 AM, James Prestwood wrote:
>> A user reported a crash which was due to the roam trigger timeout
>> being overwritten, followed by a disconnect. Post-disconnect the
>> timer would fire and result in a crash. Its not clear exactly where
>> the overwrite was happening but upon code inspection it could
>> happen in the following scenario:
>>
>> 1. Beacon loss event, start roam timeout
>> 2. Signal low event, no check if timeout is running and the timeout
>>     gets overwritten.
>>
>> The reported crash actually didn't appear to be from the above
>> scenario but something else, so now all instances where the timer
>> is rearmed we also check if there is already a timer set.
>> ---
>>   src/station.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index 30a1232a..e188aed4 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -2221,7 +2221,7 @@ static void station_roamed(struct station 
>> *station)
>>        * Schedule another roaming attempt in case the signal 
>> continues to
>>        * remain low. A subsequent high signal notification will 
>> cancel it.
>>        */
>> -    if (station->signal_low)
>> +    if (station->signal_low && 
>> L_WARN_ON(!station->roam_trigger_timeout))
>
> I'm reading this as:
> if signal_low and roam_trigger_timeout is NULL:
>     1. print a warning
>     2. rearm the timer
>
> Is 1. intended?
>
>> station_roam_timeout_rearm(station, roam_retry_interval);
>>         if (station->netconfig)
>> @@ -2260,7 +2260,7 @@ static void station_roam_retry(struct station 
>> *station)
>>       station->roam_scan_full = false;
>>       station->ap_directed_roaming = false;
>>   -    if (station->signal_low)
>> +    if (station->signal_low && !station->roam_trigger_timeout)
>>           station_roam_timeout_rearm(station, roam_retry_interval);
>>   }
>>   @@ -3202,6 +3202,9 @@ static void station_low_rssi(struct station 
>> *station)
>>       if (station_cannot_roam(station))
>>           return;
>>   +    if (station->roam_trigger_timeout)
>> +        return;
>> +
>
> One thing I'm a bit worried about with such a simple approach is that 
> we might have different roam timeouts.  For example, the 60 second 
> roam retry interval is active and we get a low rssi event. In this 
> case we probably should schedule a roam sooner.  Maybe we should 
> book-keep timeout information better better and make sure the timeout 
> happens within the minimum time (active time remaining / new timeout)?
Sure, the thought crossed my mind as well. Looks like there is no way to 
get the active timeout within the l_timeout itself, it doesn't track 
that so we can manually.
>
>>       /* Set a 5-second initial timeout */
>>       station_roam_timeout_rearm(station, 5);
>>   }
>
> Regards,
> -Denis
