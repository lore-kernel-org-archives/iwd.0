Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BFD5B1F4
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617846; cv=none; b=WlNMvVB9pH/+GlXYxDslvEiPxuh4bcpl9sUbQRr4Iwd3TfyxNvbwehVU4KEuPLZGuwepvTrbTjGJ+3tyHm2w1rnBhfaQdZHFTrqzHAvWmZ6mPitMmdwPvmmrrSOSRkPumSVt99p4qIWSGwRrLjHBS+Qea9RlkQ7rqFcsBSV25+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617846; c=relaxed/simple;
	bh=+ODzU/ruBsNJjF0XBFV/DeBk8cPY+RRJvPhj+6T5KfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jPRvx2asSCO7uRkPESThTrUH/qNx2MJZ+l8xQj3Mq0CSvAKzq5oEcTf2F5Dalb+EGBjV6fVk6d0z2dmYqpIiKHY/4Lzekn1OIywlxio/Sv2Z/sJdOzWqt1pzA1eOiW2lc9H0i1r3hlGK73vdx9klv4eH2J8XPFKDA6VeWpWzZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwGr91be; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwGr91be"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so1871519b3a.1
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 04:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706617844; x=1707222644; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BaVW1tai2xQBKTAt7/Cv79zQSGIW+gbdxWqYnKWACks=;
        b=EwGr91bekHb3UwzyfLtqKjyZefZgJ9vcxxtHNgKYWJR+Hi6uPS34sCvQvc0aH1J4ax
         /LyY/cpO+7awojr+isFslrJyzoYtGSk93sAX0sVkqqMS5357T/y6yKSfRJ51mkNG7YJk
         8IS+/M65s0UBX1OkzFDfwVnTOlKXz5Iv8q+YMvFJX2F8mY+mhlrJf6IBriDFnM0AY+6d
         9jtsrHByurBML2QOYyFno21jOvkm/2VB8uYv9O2Jcu/bbK74kTZ/wr9mDzreZeZLtpuM
         JHd41AdZVygzFkDihJi2UKw27OJCJSfYHuTF0TdYDxty7V/qhky3+6GloCnzPOB2XWRC
         m0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617844; x=1707222644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaVW1tai2xQBKTAt7/Cv79zQSGIW+gbdxWqYnKWACks=;
        b=eRzR05B6vQwMWbuPMztkkC4gCOtBa/qlkzvR5lAeWNyuvWYOmW3zkrGwNlgy3g3Um/
         Q3wXItRyBzEJiPIZ+/zAVjCG+vRFJo9gtbFALszNCPNrog7T8Mam/ajLhK5x+cvUJ8sd
         2O5EtAnNj4q14yNKbgBy1izvfUSmfpWOrQ5Zy0V66ouvC86iFpWVnJM7pwJWY4vF+RiO
         A3gn0Z93y9YZxMsX/Z77sWlamr0ehccakzdLIyyp/FXEq72f2WibpeObc8BTcB0k1iWm
         wvUaV3l4Rh7jvhyOA4T4FtSOdmg+f/JSM+i07yy8JEjR1sVQnRn1CZAK89tsv5KT2xT+
         fryw==
X-Gm-Message-State: AOJu0YwAeiie+1kZB2zEIqF9ZD/XnmyJro9yvxeP995EkV7J4eqICeTx
	xzwDua9vtHmuHbLt5JXpoOGXeE77WxM83/UMy6RPjJzKEUI6xUDI
X-Google-Smtp-Source: AGHT+IHV/Fr2CBjrMqxxdufpuU/CNFputxN6KFnUZS33BhJVsirfV0L4UvvTQbCdb46LHiqHsLGbTg==
X-Received: by 2002:a05:6a00:349b:b0:6db:cfd7:102c with SMTP id cp27-20020a056a00349b00b006dbcfd7102cmr6828712pfb.15.1706617843696;
        Tue, 30 Jan 2024 04:30:43 -0800 (PST)
Received: from [192.168.254.83] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b12-20020a63cf4c000000b005ceac534e47sm8070354pgj.51.2024.01.30.04.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 04:30:43 -0800 (PST)
Message-ID: <6c91283d-7126-4233-9843-7ef6e0974ecb@gmail.com>
Date: Tue, 30 Jan 2024 04:30:42 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] network: add network_update_known_frequencies
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240126202243.91947-1-prestwoj@gmail.com>
 <6fc2ba34-e9fe-4d91-9709-1e9233903c4f@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <6fc2ba34-e9fe-4d91-9709-1e9233903c4f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 1/29/24 6:54 PM, Denis Kenzior wrote:
> Hi James,
>
> On 1/26/24 14:22, James Prestwood wrote:
>> In order to support an ordered list of known frequencies the list
>> should be in order of last seen BSS frequencies with the highest
>> ranked ones first. To accomplish this without adding a lot of
>> complexity the frequencies can be pushed into the list as long as
>> they are pushed in reverse rank order (lowest rank first, highest
>> last). This ensures that very high ranked BSS's will always get
>> superseded by subsequent scans if not seen.
>>
>> This adds a new network API to update the known frequency list
>> based on the current newtork->bss_list. This assumes that station
>> always wipes the BSS list on scans and populates with only fresh
>
> Sort of.  Strictly speaking it takes the frequencies scanned into 
> account.  So for example if we scan only certain 2.4GHz channels (say 
> through DBus Scan API), then only BSSes within that frequency set will 
> be updated.  However, such scans are initiated one-after-the-other, so 
> it is probably okay in this case.
Yeah we are technically re-adding the same frequencies for each 
successive scan.
>
> One thing you might have to be careful of is limited scans due to 
> roaming logic.  But I think this series is good enough for now.
Yep this is why I didn't add anything in the roaming results just yet. 
That and neighbor reports will require a bit more thought. I think for 
roam scans/NR's we might be able to get away with doing the same thing, 
but limited only to the connected network. In theory a roam scan should 
still yield more updated frequencies than past scans, so we probably 
could shove those to the head of the queue in the same fashion.
>
>> BSS entries. After the scan this API can be called and it will
>> reverse the list, then add each frequency.
>> ---
>>   src/network.c | 40 ++++++++++++++++++++++++++++------------
>>   src/network.h |  2 ++
>>   2 files changed, 30 insertions(+), 12 deletions(-)
>>
>> v4:
>>   * Added an API to do the insertion once all the BSS's have been added
>>     to the network object.
>>   * I'm also ok adding something to ELL like:
>>     l_queue_new_reverse(list);
>
> Given the sizes of our queues, it might be faster to reverse it twice 
> than re-allocate / free one.  Might even be a good candidate for 
> l_newa() if you can keep a known bound on the number of entries.
>
>>
>>     The current reverse is in-place, so I cant really use it unless I
>>     wanted to reverse twice to get it back to decending order.
>>
>
> <snip>
>
>>   bool network_bss_add(struct network *network, struct scan_bss *bss)
>>   {
>>       if (!l_queue_insert(network->bss_list, bss, scan_bss_rank_compare,
>>                                       NULL))
>>           return false;
>>   -    if (network->info)
>> -        known_network_add_frequency(network->info, bss->frequency);
>> -
>>       /* Done if BSS is not HS20 or we already have network_info set */
>>       if (!bss->hs20_capable)
>>           return true;
>
> This part looked like it belong with patch 2, so I moved it there.
>
> All patches applied, thanks.
>
> Regards,
> -Denis
>
