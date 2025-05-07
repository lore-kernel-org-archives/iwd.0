Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C728AB1B
	for <iwd@lists.linux.dev>; Wed,  7 May 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632419; cv=none; b=OsTkfJGeGWsv8RYjh3UciTcDsdXK3BiSUYHRIp7wihVbuT1w0MfM2VU+TfMdmvmi38yc5hpbTo8F/P099Pr0ksdtrOecyvSy9DQi0hdyZZlY/UGPLgKyCYVrc9UpxJjDMv5okSyRQ5jjwmq6hflsVQ34w45fR+Te9XUuY7qvlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632419; c=relaxed/simple;
	bh=Aw6Mip+BZm5HNTFNlP5Li9rrZqRZzM3wV9kMMHJpvqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fTU3iOLVRXWa94PqmbUUoFzEHb8jNc536frRtE+nekFm+BKAka3R4ulTbHEqy++OHEugVJ2HlNAU25wYF4fAGxcFnt4fCm7CHvB+uV8GJ4l5z4zEWfPcOAj6GX7Tl92tsy/JvAvpTjyGPgIs77T3YGb0CDHBN450PMyTp6McGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6h+Fc8D; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6h+Fc8D"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7cadc92771dso502279685a.1
        for <iwd@lists.linux.dev>; Wed, 07 May 2025 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746632415; x=1747237215; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qda1B33r2n/5BkBxNFzgiTNnwdqVIKghoN/pcBuTWDQ=;
        b=i6h+Fc8DvpkJUcppf5Cue+Kyktp/wSw442eNZmiwnJtYppHPi/kiBEIZxuNojEpoju
         Uz7GDkDUdfvPH3Wq6F1FkCZ5kq7A5+I7NjIIL6lMCzSTD43ytRKayKb7XryWP4HVESL6
         y+X70Xv/Y0S7+rdncstgtfit6enKbjGeEHRZP1vTd6O2Rb/onvsPNGeqnt0W2hXXqU5H
         LDAD8m0wtv/xZkySm6x5p6kQ/YV7XXFJ06NmAMHfxcoI11Dmr4cADgKovDsdGFK12Mxk
         9hZCKOpIPArsQscmLCV23zry+5qUP5y0mTpQUqtZeUXiFrbESkvmV1AhF1/U43PfLTjf
         b9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632415; x=1747237215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qda1B33r2n/5BkBxNFzgiTNnwdqVIKghoN/pcBuTWDQ=;
        b=L8AlyaWdgWQYP4x+7dx+Yk12Q5TbUK9D82dWwfWOou2DR7bLoS3jibS68G3dwGvpV1
         ce+zPU/QvjVCkPIFO1CFKoHpaILlr3P3zJhmOMScRwE2UV+MPQ9/EWv19KmybmjlQGc2
         J0F0sbWEuhc+8B74jOyo8cjOPgUrh6FwnQD5LvTR7O/enPll3QAIWYCSYip/9PBz9W/N
         BL24XUX1PBebPRbyPD6G2i8SmbfgRG/bnJSiEFkiUMzzu+4UYYgtQrj7GF8EndHed2eL
         2D6ooMePt7bv/A/SjoLHpsCGpOaGDKXU6TlTKxjImndJhGhYHda8R0RspsS/bCjU+DZ4
         oMtw==
X-Forwarded-Encrypted: i=1; AJvYcCW1vDLMNVmxpo3a4S2ucpWmV7umZ9T1YFUKY31zloREdcfZxAjivAME4g+CMXhzj0GXILY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyY8wiT00HD+ZArrt91dLbZUnznznYd9SzC+C1uCSoVYKqa17SE
	L88/cqoYiWoF5wWMYOomm28GY+UhX9Sb0zXbgzmckKPQYPS2iiF+
X-Gm-Gg: ASbGncsn6XserHnj8CKVtndJpjaA1w0JYq3ACTAhtjvfZdTpnxfoSJwMvpgbNNQsKwM
	k51Z4grHeGnfmnXOabBe3B+KwvCAyQFapFIROhY+q1MfrA05haJGu40hasktn9Ir+t9qFvJqz1n
	FkCJKO3ZCAeZq+HvHemTrW1XsCkNI6k18XD0hWHwxESVtliw7rIgQaSN6gi6CisGlrYq0WBgWMy
	lzQOLEH4Uas9ecKO08MGlaEhf8hIazicrstItXHFixpf0f9jczMgoHppjuSdFjtWt8nUOIWyC8a
	bD/FBhjqvpCGi3vIv2n9mtDIdHEcigjjCQ4NsQcd9XTT
X-Google-Smtp-Source: AGHT+IHN8jr/mLrvTh2AdPX6TLl07Fw9mNOm+kZFQQOKRu42qWqnMJCaa4YI7kgQFKb2YxUbwo8vMQ==
X-Received: by 2002:a05:620a:1a07:b0:7c5:57b2:2cb9 with SMTP id af79cd13be357-7caf73b16b6mr474072185a.26.1746632415527;
        Wed, 07 May 2025 08:40:15 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ccdfbd0db6sm23807085a.15.2025.05.07.08.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 08:40:14 -0700 (PDT)
Message-ID: <bc3af7d0-90ba-4336-999d-3c3b08c426a9@gmail.com>
Date: Wed, 7 May 2025 08:40:12 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] station: improve roam scan strategy
To: Alexander Ganslandt <alexander.ganslandt@axis.com>, iwd@lists.linux.dev
References: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
 <20250415-roam-scan-improvements-v1-3-12827e086895@axis.com>
 <ab31a956-b65b-4b42-b37c-a1c63385d3c9@gmail.com>
 <c56180f6-8eff-479e-93ab-522bd8a43ad2@axis.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <c56180f6-8eff-479e-93ab-522bd8a43ad2@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexander,

On 5/7/25 5:53 AM, Alexander Ganslandt wrote:
> Hello James and Denis,
>
> Thank you both for the feedback! I want to focus on the overall idea 
> here and will look at the code details later.
>
> On 4/16/25 18:46, James Prestwood wrote:
> > Won't this start reusing the same frequencies after a few scans? Say
> > your first N scans take more than 3 seconds, you'd then begin using
> > those frequencies again on subsequent scans since their ages are under
> > the threshold?
> >
> > Rather than a hard threshold simply sorting by age seems like the best
> > way to do this:
> >
> >   - Sort the frequencies by least recently used -> Take the first N
> > frequencies -> Scan
> >   - No candidates found? -> Repeat ^^^
>
> Yes, it will start reusing frequencies and might never reach the less 
> common frequencies depending on how long time the scans take. That's 
> definitely not ideal. Looking at the age as you suggest has the 
> problem that it will eventually spend time scanning uncommon 
> frequencies when that time would have been better spent scanning 
> common frequencies that are getting old.

I think we can say the #1 goal is to avoid full spectrum scans. But 
entirely avoiding frequencies even if they are uncommon is definitely a 
show stopper. We do (eventually) need to scan all the frequencies even 
if they come after the 3rd, 4th, 5th scan subset.

>
> Maybe this is an impossible task to solve perfectly as there will 
> always be a trade-off, maybe it's better left as configs for the user? 
> In my livestream use case the APs should be configured such that most 
> good frequencies are in "neighbor" or "known", so I would like to 
> spend most time on these frequencies. However, for a use case where 
> the network setup is unknown, having more exploration of uncommon 
> frequencies might be better.

I see your point, and even for my use-case we generally know a subset of 
frequencies that the APs are on. But this really doesn't align well with 
a generalized use case where you may be on various public network, 
traveling between countries, etc. We should definitely prefer 
neighbor/known frequencies but we need to account for all frequencies at 
some point during the scanning process. Completely ignoring certain 
frequencies will end up biting us when some user comes and says their 
device refuses to roam to some AP in their network because its using an 
"uncommon" frequency.

>
> We could have configs instead where users can define the subsets and 
> age threshold. If they don't set anything, the default is the current 
> behavior. If they set subsets, the roaming algorithm will pick 
> frequencies from those in the prioritized order, just like this patch 
> does. It could still get stuck scanning the same frequencies if the 
> age threshold is too low, but then it would be a user configuration 
> error. We then also get rid of hard-coding frequencies in IWD and all 
> problems that causes, but still give users the possibility to do so if 
> needed. Does this make more sense?
I doubt your going to get such a configuration parameter past Denis :) 
We need to figure out a path for a dynamic/learned configuration based 
on prior frequencies seen/used, neighbor reports, while still 
(eventually) scanning the entire spectrum.
>
>
> On 4/16/25 19:19, Denis Kenzior wrote:
>> Have you considered maintaining a scan_freq_set of all the 
>> frequencies scanned
>> by the neighbor and known-frequency stages instead of maintaining an 
>> hashtable
>> based on age?
>
> I don't completely follow what you mean here. The reason for having 
> the hashtable is to know how long ago a certain frequency was scanned 
> in order to not scan it again too soon. So that info will have to be 
> stored somehow, or did you have some other approach in mind?
>
>> So the idea is to add up to STATION_MAX_SCAN_FREQS to a new set, 
>> starting in
>> order of preference with:
>>         1. neighbor frequency set
>>         2. known network set
>>         3. scan frequency ordering set
>>
>> while filtering the frequencies already scanned.
>>
>> How do you know when to give up the current attempt?
>
> Yes, correct. Do you mean when to give up on the roaming attempt 
> completely? The current approach is to never give up, it will continue 
> scanning frequencies in the subsets until it finds a better BSS, or 
> until the current BSS signal goes above the threshold and roaming 
> stops. I believe this is also what IWD does today, except it uses full 
> scans continuously.
>
> Regards,
> Alexander
>
