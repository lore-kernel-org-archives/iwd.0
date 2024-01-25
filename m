Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B34F61E
	for <iwd@lists.linux.dev>; Thu, 25 Jan 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188913; cv=none; b=MUAWWbLEUUI3TFiqIJmZO8/aLzP57Va1sLI68EIDp7bHMqfQR9gejGKwoLIZV9E9brc5eXvYQIqWIG+No1qqMb58nte6Q4PbXGb4/CB9AJevfbicMG1YZQsk3tQsMO9hXag6PFjdD06vinUvJCijsAruXcX1DXTk7TAFYCUnAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188913; c=relaxed/simple;
	bh=wHWmI9gJMgSwHua0pLkv3sJrknHSACgMS3gDlOJOsck=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rXi+PETaV0v7vXAyurzjWHQWQc5g5vKL1fzhz6BLR8ZBluWK9Gge7P4s8ianMrWqPTw38gCvIOKeIXEGpLGgg2/keQFDIhpoVJIKjueYVODXRcGQhtQdvEnij5NHOndcPTFiZpm7040gFvKaGvx3bVx4NEjT0AaiwpuYjwyvniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDSVnCga; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDSVnCga"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d71cb97937so42971895ad.3
        for <iwd@lists.linux.dev>; Thu, 25 Jan 2024 05:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706188911; x=1706793711; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hX+tXTL2aV5heDlbGuEpAlqYfR/FTt7L+8+70eg32Ic=;
        b=lDSVnCgaAMZ4nl/fQPG6amAsJO8OkRvva0wZxzawIJEdHr5PqG1BU8qWjq/cJgx/fQ
         wr0SPVhftkPW7mpvdrdSjHbE+1WRnExfL61fP028aiI5v0IXw3eU3OzwEkwg3Q5p/w9n
         G2lup1BpurHe6PPiXiFXLsUtDeeSNsCtHHqvvIfng+428VqUdRloTITOXNETf0Bq3pSK
         zPMP05EUitMoymQo73bulGqGCjF0gs3pGQgW1fIl7Pv5NQ+VpJ+qEFfrk1W+rYpPUp1o
         J3uzbMxskXR1Tv+YzIwAp11Zizsa1IXJKnWP79bKmcLjU7t86E6+liNbtfbKqeLVC36C
         bmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706188911; x=1706793711;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hX+tXTL2aV5heDlbGuEpAlqYfR/FTt7L+8+70eg32Ic=;
        b=KL+zXIaTNfLQwpfwSjDHLWHDIZ7BXo5APyfNGM3HwixXEDIbns3zxJP/afa1sfLRcv
         GifVzjtnbgQdUzISfcSQboRfJR+qblTAm6uF66kyslq1YsXLgXNWy9dNYAiK0EGRPdAK
         JiBpJG1P6YK9hQS0lwGXnZblyAscSZtjmXhRKn+7BaPZ40vwDWpLGk6JOxx5ojiHdciD
         A9ltAdppBEGYll7C5wEY6hGsuL07lq3DAfBGaKh9Je1qEG3swiX6F/UgzwUZFYMLnkPw
         Q++tJCcdCy6CqcnU1exsdqnr12q1EmE1bBEfzXfS1XAEDZrJ0YoVbPBe78d+aRuPA1Jm
         WyoA==
X-Gm-Message-State: AOJu0YwI3hcgm5LWfio35olaQ86NjNurahVg5a6Wq16LmTCkwWq/lwqu
	ycr6URhoNCsZXhykfhBZ6+kFAy3cARE8f13zSf9M7P2mnIoBQmTO
X-Google-Smtp-Source: AGHT+IFm+q9CDHzGRaSegQdlxxaP775LjtW5hKugV86BGZicK6/xzwwEfhLiRnb4qFHsBxSigvlocQ==
X-Received: by 2002:a17:903:25d1:b0:1d7:3554:979 with SMTP id jc17-20020a17090325d100b001d735540979mr680049plb.126.1706188911030;
        Thu, 25 Jan 2024 05:21:51 -0800 (PST)
Received: from [192.168.254.83] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id p13-20020a1709028a8d00b001d73d445e4asm7635010plo.178.2024.01.25.05.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:21:50 -0800 (PST)
Message-ID: <63932e26-03c1-4f32-8596-32fb23bf5567@gmail.com>
Date: Thu, 25 Jan 2024 05:21:50 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] knownnetworks: sort known frequencies by BSS rank
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240124134001.20453-1-prestwoj@gmail.com>
 <20240124134001.20453-2-prestwoj@gmail.com>
 <703a48ba-41f8-4104-bb1d-6b017ae76e15@gmail.com>
 <ac057182-4b8e-44ef-ac32-9b039d13e45f@gmail.com>
 <8015796a-e94f-44bc-a01d-0339b1a156a2@gmail.com>
 <edaa845f-5e5a-47c4-90da-820c294637e4@gmail.com>
 <3eaadb6e-53ff-443f-a638-ae091482a74f@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <3eaadb6e-53ff-443f-a638-ae091482a74f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 1/24/24 11:06 AM, Denis Kenzior wrote:
> Hi James,
>
> On 1/24/24 12:55, James Prestwood wrote:
>>
>> On 1/24/24 10:44 AM, Denis Kenzior wrote:
>>> Hi James,
>>>
>>>>> Perhaps an easier way to accomplish this would be to add known 
>>>>> frequencies in reverse bss->rank sorted order.  That way last seen 
>>>>> frequency with best ranked BSS would be first?
>>>>
>>>> I'm not sure I understand, how would this be any different than 
>>>> just reversing
>>>
>>> Well, right now we maintain the least recently seen frequency list 
>>> in a very simple way:
>>>
>>> - When scan results become available
>>>     - Walk the result list (which is sorted by bss_rank?)
>>>     - Add each result's frequency to the frequency cache
>>>         - Remove any matching entry in the cache
>>>         - Add it to head
>>>
>>> Since the result list is sorted, the top entry in the frequency 
>>> cache is the least ranked.  This doesn't matter for small networks 
>>> since there would only be a couple results.
>>>
>>> What we should do is to add the frequencies to the frequency cache 
>>> in reverse order.  That way the highest ranked bss is at the top of 
>>> the frequency cache.

Ok I understand what your getting at now, but providing the list in 
reverse order is somewhat problematic. The majority of additions are 
going to be from station's can results, via network_bss_add(). We 
_could_ reverse the BSS list in station but that seems like an expensive 
operation for each scan, and I really don't want to muck with that code. 
The only somewhat simple place to reverse the list is when a known 
network is added. But again its expensive.

To avoid refactoring elsewhere, I think the only way would be to 
timestamp entries (based on bss->time_stamp) and sort by both rank and 
timestamp. We could also limit the list to e.g. 5 values if we wanted to 
avoid storing a ton of u64's in memory.

Thanks,

James

>>
> Regards,
> -Denis
