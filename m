Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EFB224E8
	for <iwd@lists.linux.dev>; Thu, 25 Jan 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197203; cv=none; b=Yf4hQR8qaG46xdeQiiIWenhc5MtKZdWqKpljQ1CjpkooEinZelN0i4tI4hs7juU5fEYDB6c8UA6Vtmknk+UbuU8VKqrmiJgWe++IXFYIojCy9+h5geQfAHNATkE56ORAumV3GspKU3tUZRlXvbZ2EWrWl5ffo7JS7qP+y0Tafjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197203; c=relaxed/simple;
	bh=O8TDU2/QDBWbbRvuAjAjRXO4coZNrFWSiT7NO1cm+o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u2oUYHORjsfuuX0iqgtb7kgLb9p58+uugKIglDhqP19lz3NHbAXiMTbU9zDfhp/d+0Ivo1prkLuDcq9TTLywRcCwyBWHxfNTyUdZLw9BLIXL7lW34w7Ci83zxkI6ghgIuBpxfxV6pvIIDU9iZafwANP7WhkDFTD8bGL1aYjfUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8fMHtDh; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8fMHtDh"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ddef319fabso4478303a34.1
        for <iwd@lists.linux.dev>; Thu, 25 Jan 2024 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706197201; x=1706802001; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x40vXZDXY4H2oSBq/UspAstlQhxApdSnBM8R6Ng3Teg=;
        b=V8fMHtDhnRuAwPPD8sf6lFScrUSFmWdaDp2gCzEMD+lx18ZQRW3UxpRhqMEUEjZF1p
         72QtMtfRda38Nmh5Ws7czPyBR6LapCtgYpXiyfrVFi5k6nILckbplFajwYR9HW6RJziI
         C96cDnVcVRDIjF/8aNG63UC1bnw00UFdHMMRgnvghpAvd5E4yHWVONozL8jC71h9/4wT
         BvTZ/hwIuWL5ktd6TVEvTjQxrBnqF/SeySPRzVv6TBDNZMGwwFQV1B7PO5zUJD0OsN4w
         686oOBAh48BLbZacdJatz/3uLc5OtY4u7gYD9zny9BZb7WRSTsBhQGUyJNIOZ/AcyQ+U
         7xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197201; x=1706802001;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x40vXZDXY4H2oSBq/UspAstlQhxApdSnBM8R6Ng3Teg=;
        b=VAhlgNDh7O2LuraAHUSkcgFIDu4JEZnMt51yvMypaMdf2hfs9d0RtpYVHbhO1vwdVp
         bPx0xDZz69q0d58cx1d5CehMS57qIi+gDbymiw9KR2BlbYwD64nOYdo/FNJh9qvaizCF
         ciWT2b3/8xUV5BjJHant32pJ8x4eAio88KY19sIuPLQrXVxHo16Zw1SefJRIbj+IWlfJ
         BqeDnFwUHBaEQLKHyanPMRcVWoC6iPNdi48UVm7k5Xwn2IVOclH8LaIULKY25hVEZLEF
         BvHsRQ17nTs5YE7AFrJ3SZwNzZ1faFo2TvMUbCTFUGlfBEimMrAdlhWvJ8IwkJg/vzkE
         QM9Q==
X-Gm-Message-State: AOJu0YxQuSNhY8epjWQd0p2+y+Y35WbGVPV9IrqeKqGj+tx3+ZOvlNSW
	+y6f8m1xy3BWlGXPAcpaJX/pDkjG5Wj288eZlpVlT8kqv7H1MKpSecpWUoSR
X-Google-Smtp-Source: AGHT+IFfdhd0v2XOZF6fVdCJ3q8+y485JEKg8+gnXg3EKoCDq+5XuhYcpaXPmb9RwjvwUi+0aUNQjQ==
X-Received: by 2002:a05:6870:9e86:b0:210:e860:c4fa with SMTP id pu6-20020a0568709e8600b00210e860c4famr1115515oab.32.1706197201087;
        Thu, 25 Jan 2024 07:40:01 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id vs16-20020a056871a11000b0021498a0d1bfsm1176860oab.28.2024.01.25.07.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:40:00 -0800 (PST)
Message-ID: <88c1268b-014d-48d1-b924-22555228cb91@gmail.com>
Date: Thu, 25 Jan 2024 09:39:59 -0600
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
 <3eaadb6e-53ff-443f-a638-ae091482a74f@gmail.com>
 <63932e26-03c1-4f32-8596-32fb23bf5567@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <63932e26-03c1-4f32-8596-32fb23bf5567@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 1/25/24 07:21, James Prestwood wrote:
> Hi Denis,
> 
> On 1/24/24 11:06 AM, Denis Kenzior wrote:
>> Hi James,
>>
>> On 1/24/24 12:55, James Prestwood wrote:
>>>
>>> On 1/24/24 10:44 AM, Denis Kenzior wrote:
>>>> Hi James,
>>>>
>>>>>> Perhaps an easier way to accomplish this would be to add known frequencies 
>>>>>> in reverse bss->rank sorted order.  That way last seen frequency with best 
>>>>>> ranked BSS would be first?
>>>>>
>>>>> I'm not sure I understand, how would this be any different than just reversing
>>>>
>>>> Well, right now we maintain the least recently seen frequency list in a very 
>>>> simple way:
>>>>
>>>> - When scan results become available
>>>>     - Walk the result list (which is sorted by bss_rank?)
>>>>     - Add each result's frequency to the frequency cache
>>>>         - Remove any matching entry in the cache
>>>>         - Add it to head
>>>>
>>>> Since the result list is sorted, the top entry in the frequency cache is the 
>>>> least ranked.  This doesn't matter for small networks since there would only 
>>>> be a couple results.
>>>>
>>>> What we should do is to add the frequencies to the frequency cache in 
>>>> reverse order.  That way the highest ranked bss is at the top of the 
>>>> frequency cache.
> 
> Ok I understand what your getting at now, but providing the list in reverse 
> order is somewhat problematic. The majority of additions are going to be from 
> station's can results, via network_bss_add(). We _could_ reverse the BSS list in 
> station but that seems like an expensive operation for each scan, and I really 

Nah, it is a trivial operation.  In fact, l_queue_reverse() already exists.

What you can also do is remove the known frequency update from network_bss_add() 
and have station manage it explicitly.  You can then do all sorts of fancy 
things in station_set_scan_results().  Couple of examples.

example 1
   - allocate array of l_queue_size(new_bss_list) pairs: [network, frequency]
   - After calling station_add_seen_bss, jot down network/frequency into the array
   - Run another loop after to add the frequencies in reverse bss rank order

example 2:
   - Allocate array of l_queue_size(new_bss_list) struct scan_bss pointers
   - run qsort and sort the entries however you want (say by bss->time_stamp)

> don't want to muck with that code. The only somewhat simple place to reverse the 
> list is when a known network is added. But again its expensive.
> 
> To avoid refactoring elsewhere, I think the only way would be to timestamp 
> entries (based on bss->time_stamp) and sort by both rank and timestamp. We could 
> also limit the list to e.g. 5 values if we wanted to avoid storing a ton of 
> u64's in memory.
> 

See above.  I'm really not sure that sorting by timestamp AND rank will do 
anything.  If the driver does things properly then it will report 
NL80211_BSS_LAST_SEEN_BOOTTIME value, so all entries will have a unique time_stamp.

Another thing I thought of is that we probably should be updating the known 
frequency list based on any neighbor reports we obtain.  Just in case we get 
disconnected for whatever reason before we attempt to roam.

Regards,
-Denis
