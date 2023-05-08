Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3305682
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 18:55:24 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-75771dd7242so102146785a.1
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683572124; x=1686164124;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3OQFEgROYXPxQx+48UMiX+P/dccPRhG51HuZRnYasQ=;
        b=ZwgFmPyOmHdtU86bFlxDUrc3pT+23skg8ppSW9LvPJdRke5qlxLBXoHrhS94sWB6WY
         hp7sIfuzPMKpFgs3u5yph3fQBRo9txOm7W/meuQa0oUJzZ5DJswNTS+ai7j743SIGDqj
         xJdWg4oClR1VKe+GX9vHE7/AlQv4T/LKQfXNn2KHZ9DBccE7OC1Hz68My70UqeaRynZ3
         /qK7dfcd02526/aezmkeWrMxLyftH8nZTDc4ps7GMbp5AbkTEv6RIFA7yvNIP0EGJLYI
         hkeKFrU894eHhu5JzUAlJkXdl0fsGcUaOmcs/PCkZNahq4doAzEyHoctG0weioBAdnNp
         +xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572124; x=1686164124;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3OQFEgROYXPxQx+48UMiX+P/dccPRhG51HuZRnYasQ=;
        b=GfNU0dz1kG6MV0fnkDnMQDNodYR86re68BVSKmx8dbNhC1BeV5gfQv/hwdcFpmWwFq
         VF6d0AWtpLROhB6fwr1uwHr4U8VLpKF2JeXuq3N3mcV0hMT/k7/Qp1kCuoU0OuN4i9ia
         ZWrWcnf3bckwDYt8befTMgoWkkfi73IHOEzDEgeXvjwlrrv9sVD/vVS8hEXmWYZzlNh2
         Iw56+jFSoiaow7qOybnWQrVoxbvJLAD7nyTGYSoe28ZEJJKr1/zdneIFDHD3FQrOZwH6
         ZF6bbcZKzVikBbCfGXzQ0fNBgfmIB0KaX7HANtsAF+1Pf2KfOEi2OD40ApWdtwnAmBjv
         yNtQ==
X-Gm-Message-State: AC+VfDwvE5iKwgiPVLhqP9yaq8X5TDC2IItUX1Pmb6RY+/jAfRJPTI/R
	RxR2c/oBWdlhJSJMI2hs+wXYdmdepP4=
X-Google-Smtp-Source: ACHHUZ68DYAItrsBnRrmn2Hu47Ex+q8v8zTXtx+GJdULCZeUQ+nmMVih303feWi7lu0RZp9iFUKAEw==
X-Received: by 2002:a05:622a:1995:b0:3e6:941b:47e0 with SMTP id u21-20020a05622a199500b003e6941b47e0mr16688280qtc.11.1683572123723;
        Mon, 08 May 2023 11:55:23 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bs7-20020ac86f07000000b003f21593c690sm3165565qtb.86.2023.05.08.11.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:55:23 -0700 (PDT)
Message-ID: <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
Date: Mon, 8 May 2023 11:55:21 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 5/8/23 11:05 AM, Denis Kenzior wrote:
> Hi James,
> 
>>> Second, if we're passing unicast frames, and the unicast frame is 
>>> addressed to a radio in a different namespace, how does that radio 
>>> get the frame?  We don't have it in our radio_info queue?
>>
>> The namespace bars hwsim from seeing radios in other namespaces via 
>> GET_WIPHY. So yes, the radios are not in the radio_info queue. But 
>> since the radios are on the same kernel any MAC the kernel knows about 
>> is accepted when sending a frame, regardless of namespace.
>>
> 
> I get this part.  What bothers me is that the current dispatch code 
> seems to be completely wrong?
> 
>>>
>>> The comment for the code you're taking out makes it clear that the 
>>> intent is for unicast frames to be sent only only to the radio with 
>>> the target receiver address.  And the optimization is simply about 
>>> not sending frames to radios with addresses we know do not have the 
>>> target address.
>>>
>>> What you're doing here seems to indicate that our implementation (and 
>>> the comment) is completely bogus.  And we can simply send any frame 
>>> to any radio instance (once) and the frames will be forwarded 
>>> automagically.  If so, then you might want to explain this better and 
>>> fix the code to reflect this.
>>
>> Maybe I described this badly, but I was trying to make 2 points:
>>
>>   - Historically, before namespaces, hwsim should never be in a 
>> situation where a frame is addressed to an unknown recipient. Hostapd 
>> won't do this and IWD won't do this. So all that code was doing is 
>> looping through the radios. Maybe there is some case I haven't thought 
>> of, in which case the kernel would drop the frame anyways.
> 
> Sure.  To put it another way, hwsim works today by doing roughly the 
> following:
> 
> Suppose we have a setup with a single namespace, with 3 radios.
> 
> Radio A with address aa
> Radio B with address bb
> Radio C with address cc
> 
> When a _unicast_ frame with target 'cc' is seen by hwsim, it loops over 
> A, B, C and compares the addresses.  If the addresses do not match, then 
> no HWSIM_CMD_FRAME is issued for that radio.  So we'd only issue 
> HWSIM_CMD_FRAME with Radio C's HWSIM_ATTR_ADDR_RECEIVER.

Ah ok, I see where you're coming from now. I overlooked that part. I can 
re-work this and if the destination is a known radio then only forward 
to that radio. If the destination is to an unknown radio I think we have 
to forward it regardless.

> 
> What you're doing in this patch is to now issue the frame to each and 
> every known radio.
> 
> So suppose you change this to 2 namespaces, with Radio A+B in namespace 
> A, Radio C in namespace C, etc.  Are you running 2 instances of hwsim? 
> One per namespace?

Yes, a separate hwsim instance per-namespace.

> 
> How does it help if namespace A receives a frame with target 'CC'? It 
> doesn't know about Radio C, so how would radio C even receive the 
> message? And if it somehow does anyway, then it would seem like the 
> above dispatch logic is bogus in the first place?

If a client in namespace A sends a frame to target CC then the hwsim 
instance in namespace A gets this frame. It doesn't know about target CC 
but the kernel does. So it forwards into the kernel and target CC 
receives it.

I don't think there is anything wrong with the dispatch logic. There is 
just a disconnect between what information hwsim knows vs the kernel. I 
think tweaking the optimization I removed (described above) effectively 
keeps things the same (assuming clients are sane and don't send frames 
to completely bogus addresses).


> 
>>
>>   - Then with the introduction of namespaces we actually do hit this 
>> case of having unknown destination addresses. Not because they are 
>> bogus, but because hwsim simply cannot know about radios in other 
>> namespaces.
>>
> 
> Right, I get that.  But this is not what my question is about :)
> 
> Regards,
> -Denis
