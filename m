Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051E131754
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123222; cv=none; b=t2v9OX81adESlyqIKwvgL0vyl+2U0eQNEXVtBynsXtk9QBfoOQRj2hOYcMrKIJoIu34JiVLzbd3n/rWSqHa7Amr6BuXOp2iI0m/Ai08b3QmYeEl1LPVP42eSRtlL1+yjdDKzAuIeyGimdBQ9Z/84nmJjR9D1g4fMOwwifa844yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123222; c=relaxed/simple;
	bh=aooE4aKCXNrCT3oZfeSISTVN3jxzLPVfzXF2Aml9904=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oxIofsug2DQCIYoW7N7yxWMxNscEjjxzIg+7BLZI1p5rZP+2f4w4QTV9F2zOGl1yow3HB3BOMp2/M6lQxBmF6pP2pup3GjxN+2Pb+spVFyLf9Rt/ddJIY3DDalySelhfKisgd2LkZA5VcW+Sp2fqi22G+LtmUDpLm7zP5zKvlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbbFukwf; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbbFukwf"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bdc2759468so1388606b6e.1
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706123220; x=1706728020; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLDqqgzZxFh+x9tN4hMYpgOj5ujtNic5cxXvkEeoJNA=;
        b=PbbFukwfpXuNUlO4f94oi8dWr01mNYxtOG4ywAyRpoQlBGDHTJSNCxfe4H/mfBKnpv
         SDr4w/Pl2qc/pXzrvhO0a28ujVGlGezEbwNkfd3wmyhDJD16ivNLaGblETRxG4wksl92
         83Sv4Ulcoi70gRMrS8C0PRnOYr+a+4Oe2G1jl731hxRA2nt3748X7XX8b0c/htxgKMKv
         jByEXJtOVjGmxdTPXdR/3EQzpDCNHIpaX363px4/H0HRl6PSNpRmJ7cDU5r8BVnW+lW6
         17ekXzcWWQapmw4hB6/rUMHLlBRBOC8SS2OFYimPujMKpWpiijffqvRCnCusm67VwH5R
         bEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706123220; x=1706728020;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLDqqgzZxFh+x9tN4hMYpgOj5ujtNic5cxXvkEeoJNA=;
        b=F0BBh6NjGLdixBDEg7koZQ5b3lMhBVwkW1v7r8Hd9zm3u4KOYmKAN8LBmo23G2FLed
         WCCsV3t2nMyh4dz04vXelIVRXpbaXytajDnPCU7SUQvYnZZDR2Czi1434LQHAziZ4OqG
         bMNVoDMWU+4wkJMNt8eLMC9x8ny/TNVX8g2/WmFACVp294FTAQQfmzmRCOfER7s/db3x
         42EVqog2nuzxIvZ3Qh4lQ8D+cRnOB972Y7pJfnjzMOMSPYrMg2OBWd5j/9yaRFP9V0ya
         /QUZX9JIut+BXc8wQnN10Tcrq/dQOB2vLmO5Lw91gJdSMWLdhhRKDkqgJ5Xa95cn20zU
         Ywtw==
X-Gm-Message-State: AOJu0YwMAVZAvhgvKQduwCjh/vf1VHEAamfk0OZEOAuZdDHTeTT3XH0T
	63IauQ5D86TMWSnZbYJp4DgVMuP2QobcMOpgJVUKdHZisOLmjw0t
X-Google-Smtp-Source: AGHT+IGJAllKkd5dmAVGOjcEdEwy98BMC2r2ejmv9Xj2jqLwbsFfVwptplJMDBH/nRoyH4vcwynWVw==
X-Received: by 2002:a05:6808:2796:b0:3bd:c15c:23c9 with SMTP id es22-20020a056808279600b003bdc15c23c9mr1593751oib.55.1706123220253;
        Wed, 24 Jan 2024 11:07:00 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n26-20020a05680803ba00b003bd8a7953a5sm2707188oie.19.2024.01.24.11.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:06:59 -0800 (PST)
Message-ID: <3eaadb6e-53ff-443f-a638-ae091482a74f@gmail.com>
Date: Wed, 24 Jan 2024 13:06:58 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] knownnetworks: sort known frequencies by BSS rank
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240124134001.20453-1-prestwoj@gmail.com>
 <20240124134001.20453-2-prestwoj@gmail.com>
 <703a48ba-41f8-4104-bb1d-6b017ae76e15@gmail.com>
 <ac057182-4b8e-44ef-ac32-9b039d13e45f@gmail.com>
 <8015796a-e94f-44bc-a01d-0339b1a156a2@gmail.com>
 <edaa845f-5e5a-47c4-90da-820c294637e4@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <edaa845f-5e5a-47c4-90da-820c294637e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 1/24/24 12:55, James Prestwood wrote:
> 
> On 1/24/24 10:44 AM, Denis Kenzior wrote:
>> Hi James,
>>
>>>> Perhaps an easier way to accomplish this would be to add known frequencies 
>>>> in reverse bss->rank sorted order.  That way last seen frequency with best 
>>>> ranked BSS would be first?
>>>
>>> I'm not sure I understand, how would this be any different than just reversing
>>
>> Well, right now we maintain the least recently seen frequency list in a very 
>> simple way:
>>
>> - When scan results become available
>>     - Walk the result list (which is sorted by bss_rank?)
>>     - Add each result's frequency to the frequency cache
>>         - Remove any matching entry in the cache
>>         - Add it to head
>>
>> Since the result list is sorted, the top entry in the frequency cache is the 
>> least ranked.  This doesn't matter for small networks since there would only 
>> be a couple results.
>>
>> What we should do is to add the frequencies to the frequency cache in reverse 
>> order.  That way the highest ranked bss is at the top of the frequency cache.
> 
> Oh I see, I didn't realize the list was already sorted since its coming from 
> network->bss_list. But wouldn't we have the same problem here? Old frequencies 

There are a few paths.  One if network becoming promoted from unknown -> known, 
one for scan results being reported.  But in all or most cases the order is 
predetermined and would be by bss rank.

> with a high rank would remain at the front unless they were seen by a recent 

No, because each time the frequency cache is updated, new entries are put at the 
top of the list.  This automatically pushes older (as in least recently seen 
order) entries further down.

> scan. So if you saw a really high ranked AP once then never again it would 
> always stay at the front.

Nope.  Not in the current used implementation.

> 
> Another thing I didn't consider is multiple BSS's on the same frequency :)

This is generally not a problem since frequencies are stored per SSID, so for 
well planned networks you wouldn't have this.  But yes, this possibility is 
something you need to take into account.  My suggestion would still handle this 
nicely.

> 
> Maybe introducing a last seen time would help, though that adds even more 
> complication.

Yep.  Only reason to do so would be for serialization to disk I think.

Regards,
-Denis
