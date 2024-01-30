Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF384374C6
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583277; cv=none; b=lmVwaavEIM0VO6CHRdL75NpWqI1FXs8bP3ns4RVlDMb67sqyRvPL5nG+kWbfGR4i2qAU+YSIP6QLRSNc5Kfb/x5AARz0uD1JcpdXx+9FnQ685VUQZO6eDr/EZ4UTUhYDy7Cjiv+HAEX6rOpebbk4j2BJkpBQA1xJ6wMwoWEglKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583277; c=relaxed/simple;
	bh=lDzsTa3oUbgZUQ3LH6lCfFwm3BcSGW1hnNsW8jdAUWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e7eqLUnFNZw0r+y8dhDzxrgcE6UmIMGovyZhST2IxewnCvZ6mtO2nQ3fbvluEk7lUUdN/WQMa9FJNRSXreeiWbO3g2KbbcA5CfbLCBakl3D3hD7m4pdjLK15mvlmaF6CfuiIPnsbGYpbT04Wd70efJg4rvan9J68xg6+AUf9OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJH5WyfF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJH5WyfF"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e118da997cso1331198a34.3
        for <iwd@lists.linux.dev>; Mon, 29 Jan 2024 18:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706583275; x=1707188075; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZUH4dsINnp62xiDQNOufMMiZExQZeCD+Vppwx+7TfE=;
        b=KJH5WyfFAyH0Mfx64I2B+A4KmlYugwFv6+llvzUx5fIU5R8DrxaxzPMEFhAodUqi4s
         vBT+KcmSrFGKcJnvtEPAHkwogUnUSyUZ3On1o5oTOMMTs8jUKQDsjmCDD/ThQIGrLVnO
         C5aICzG2hdZG53y2flW5hJuPySG/AW9Z+2FmJdVI9an6nas4uKrhguIqywPtfVeTL6I/
         9oYgIqfj22ZnWACIbRABBAYKnqV7/VlNhUmhH9qJx83Kw8h/p3kWM0ZwHsI2grO0D/3i
         cMqbof7fxMoSorx+3kZLkBpOynkulIut15p37uyKPRS0j9WzEokTr72RSbMCis94dGJM
         hJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583275; x=1707188075;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZUH4dsINnp62xiDQNOufMMiZExQZeCD+Vppwx+7TfE=;
        b=ehrdzZ8qhVeQGctCeGJEwnnGJvF07fZ8bLhhB2d5WJEjesBOHwmHP6Hrb7h+UN49iX
         N3n6JeOPd+0aJsQU3GiBxuEiub+PU2zR5RHGeA6GUz5L11OMwsyb3WM/XT8KL3sujywv
         a7+mdNDkn/QNaB6rzAw9Gm/XVvKvkT3wUb0okzsCshnnfW/FG9L/zLFCSqxBRzmS1BXb
         sUG5cGiuQdhc9EJffwTAyeRTxrLCX3fIglmKtgZ6ntA+34Huk1m3OCpv/S5kPL2fmc4u
         UD26xXWXl9wQIXUP9npGuvL+LMfiOJV7zZuF9+GWY+Oil9aEFctZxDYbsNRv3FdI8HHt
         WSlQ==
X-Gm-Message-State: AOJu0Yz2nLd010c9UcwZkWLRF4fl4D5ZT+G0GybpAz6fBLiOad3AhxpA
	EozqXSLmKw1MvFs0WhrwJsXQQ4LIlyL0T0TwUH5eogMWy6a1q5//
X-Google-Smtp-Source: AGHT+IHGGGxcofy2bpaqoxPU37jbYKKtcUkofWz+sNzakltcvcGlj5ZuO7GX2lEkYBwD2ir5ntHw7A==
X-Received: by 2002:a05:6830:1691:b0:6e1:13ba:f255 with SMTP id k17-20020a056830169100b006e113baf255mr6119059otr.20.1706583275040;
        Mon, 29 Jan 2024 18:54:35 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z26-20020a9d7a5a000000b006e1362f71b5sm359775otm.42.2024.01.29.18.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 18:54:34 -0800 (PST)
Message-ID: <6fc2ba34-e9fe-4d91-9709-1e9233903c4f@gmail.com>
Date: Mon, 29 Jan 2024 20:54:33 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] network: add network_update_known_frequencies
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240126202243.91947-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240126202243.91947-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/26/24 14:22, James Prestwood wrote:
> In order to support an ordered list of known frequencies the list
> should be in order of last seen BSS frequencies with the highest
> ranked ones first. To accomplish this without adding a lot of
> complexity the frequencies can be pushed into the list as long as
> they are pushed in reverse rank order (lowest rank first, highest
> last). This ensures that very high ranked BSS's will always get
> superseded by subsequent scans if not seen.
> 
> This adds a new network API to update the known frequency list
> based on the current newtork->bss_list. This assumes that station
> always wipes the BSS list on scans and populates with only fresh

Sort of.  Strictly speaking it takes the frequencies scanned into account.  So 
for example if we scan only certain 2.4GHz channels (say through DBus Scan API), 
then only BSSes within that frequency set will be updated.  However, such scans 
are initiated one-after-the-other, so it is probably okay in this case.

One thing you might have to be careful of is limited scans due to roaming logic. 
  But I think this series is good enough for now.

> BSS entries. After the scan this API can be called and it will
> reverse the list, then add each frequency.
> ---
>   src/network.c | 40 ++++++++++++++++++++++++++++------------
>   src/network.h |  2 ++
>   2 files changed, 30 insertions(+), 12 deletions(-)
> 
> v4:
>   * Added an API to do the insertion once all the BSS's have been added
>     to the network object.
>   * I'm also ok adding something to ELL like:
>     l_queue_new_reverse(list);

Given the sizes of our queues, it might be faster to reverse it twice than 
re-allocate / free one.  Might even be a good candidate for l_newa() if you can 
keep a known bound on the number of entries.

> 
>     The current reverse is in-place, so I cant really use it unless I
>     wanted to reverse twice to get it back to decending order.
> 

<snip>

>   bool network_bss_add(struct network *network, struct scan_bss *bss)
>   {
>   	if (!l_queue_insert(network->bss_list, bss, scan_bss_rank_compare,
>   									NULL))
>   		return false;
>   
> -	if (network->info)
> -		known_network_add_frequency(network->info, bss->frequency);
> -
>   	/* Done if BSS is not HS20 or we already have network_info set */
>   	if (!bss->hs20_capable)
>   		return true;

This part looked like it belong with patch 2, so I moved it there.

All patches applied, thanks.

Regards,
-Denis

