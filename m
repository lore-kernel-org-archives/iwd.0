Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D214F6E
	for <iwd@lists.linux.dev>; Thu,  2 Nov 2023 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXrqjDYY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-777745f1541so52885085a.0
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698926329; x=1699531129; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCKJQk0MfenyT0gDjhzop2Eymx8ozm/Dtv3nqDt9QXU=;
        b=NXrqjDYYKEYpzHzmk8J+hKzpHXhCTXovJtdgVz0AFG+Q3KhZ8ynns6aW5dRrMn6nE7
         Mw0PzGYDmWuiPHj66isjo1D1pNShBkc14HY0WoKZqGUG9HscY7Do2yjvYjUsWlwd9oRM
         R0pkZdUiBuepR487hhh3buH+3hLaLCDKEWIASTOQO/+aJHGqdyQfsjNcOtLn/LChWrOJ
         HPkfvgAqw4jRZdjG/S77j/nhoSy6edWFN4G1Rpp5VlRqZBaLogRMr7T6LAon3q++g+ud
         yif41vRNuBM7pSnRLYoyNAwCOwQCR8llIUGaSdwrYY71PvYCOjPWpm4gA6tHpaR/WhXR
         m5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926329; x=1699531129;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCKJQk0MfenyT0gDjhzop2Eymx8ozm/Dtv3nqDt9QXU=;
        b=k3MA8a2/2E9Pmb8wTX7AZUENcHy57UntuyISD3ClcV7UhyLXyutTTQ/T5FNChl4eG7
         L7konqXxGt1D27h5qqjGRakveB83S+JCI7Mwx7AIutUPuP/VyRoxIYoUe99ste9maw0g
         ThUy7FWWVs5XIt7D6QzMlcN8cP4nOR/Dn5oXD/ncMZGNsiLCPcAzyGMk7hp0kGHmNErK
         VbeteTSSZ978Ta3J6CL4mC/OHMxs4HQp7maK/aKqFqcah6uyHjg8+Sib3CBVuXJ9h1oG
         YAZAq4oN0ExR3xulwVi2O7IztUA2lsm4u0x6fceBMuwovghOlik5zPpMvtmyqnXAvtvg
         N5Gg==
X-Gm-Message-State: AOJu0Yxlmuu7Shk7N6oTU1nUXxATjHYGmZeuZzfy+edE6anOi7evoXJ8
	iOkHIl9f6QwBXEP3OKwKYaFoEDxKYRg=
X-Google-Smtp-Source: AGHT+IEj1Q8BA8/nMgcydo3aj6gWsBjj95Q/f8Si1STgW5zRBLIkVjCP08ow7ryjN4XFytRSzx9qtg==
X-Received: by 2002:ad4:5747:0:b0:63d:3bea:f663 with SMTP id q7-20020ad45747000000b0063d3beaf663mr24432079qvx.47.1698926329363;
        Thu, 02 Nov 2023 04:58:49 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id f2-20020a05620a15a200b007759e9b0eb8sm2267821qkk.99.2023.11.02.04.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 04:58:49 -0700 (PDT)
Message-ID: <27703a4f-a071-4ff7-afbc-8dda1c5b0b27@gmail.com>
Date: Thu, 2 Nov 2023 04:58:46 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
 <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
 <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
 <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/1/23 6:39 PM, Denis Kenzior wrote:
> Hi James,
> 
>>>
>>>> If the kernel has a hard limit after which it expects the connection 
>>>> to be disconnected, we can start a timer for 2-4x that limit?  Looks 
>>>> like kernel uses probe_wait_ms parameter for this with a default of 
>>>> 500ms. Is your setup using the default values for beacon_loss_count 
>>>> and probe_wait_ms?
>>>
>>> Yep, everything is default as far as nl80211/driver options.
>>
>> I found an old thread I asked on linux-wireless back when I removed 
>> the beacon loss handling [1]. Johannes explained that behavior did 
>> apparently change in order to support power save (your memory was 
>> correct).
>>
> 
> Hah, funny.
> 
>> I identified the behavior change with hwsim, and apparently took his 
>> word when he said:
>>
>> "I'm pretty sure real hardware will behave just like hwsim here, 
>> albeit perhaps a bit slower"
>>
>> And I never added "proper" testing of beacon loss, i.e. block several 
>> beacons as opposed to just tearing down the AP. And this appears 
>> closer to the behavior I'm seeing in reality (AP not going down, just 
>> dropping beacons).
> 
> Right.
> 
>>
>> So this is my bad, I didn't take into account the situation of beacons 
>> being dropped but then being picked up again, or the nullfuncs/probes 
>> coming back successfully.
> 
> So the question is still how we handle this properly.  When the kernel 
> sends the nullfunc / probe request, are we going to be interfering with 
> that logic by initiating a scan right away?  A scan would force the 
> device to go offchannel, preventing it from receiving the AP's 
> response.  Given that nullfunc should be extremely fast, maybe we should 
> delay any roam action we take by a second or two?  If the AP is truly 
> lost, then we'll get disconnected soon after the LOST_BEACON event.  If 
> it isn't, then an extra second/two is not going to make much difference 
> since the scan should be limited and quite fast most of the time.

Yes scanning likely kills all chances of recovery. And this may very 
well be why I was seeing a 100% rate of disconnections. Granted, our 
devices are always moving so its very likely that once beacon/packet 
loss starts its only going to get worse, but that's not the case for 
everyone. Scanning just makes things worse.

I'm fine adding similar handling that I added for packet loss, except 
always delay rather than only on additional events. But I would like to 
explore other options in the future.

I'm not sure how, but being able to detect if the AP responded to 
nullfunc/probes prior to the kernel blowing away the connection would be 
great. (like send our own nullfunc frames or something, not really sure...)

Its taking IWD about 4-5 seconds to reconnect, 3 seconds are the quick 
scan and ~1-2 seconds for DHCP. (I need to look at why the quick scan is 
taking that long, that seems like something isn't right). So if its at 
all possible to roam that is best, obviously.

Thanks,
James


> 
> Regards,
> -Denis
