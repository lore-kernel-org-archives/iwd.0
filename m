Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3128AD25
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 19:03:32 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-75788255892so51450785a.0
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683572611; x=1686164611;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Zpq26Yp2a0RLrPDd9SFsqNJZ1KsB6RTvAi9S8XxjHQ=;
        b=Vq++eC5OdP+djlJ3rFxZAt6yJUa0sYtp+AnTkTMKUMPXru1oniAoLmJPhvDAvpnz3N
         nWOXV7k8biWwpHfjR+ax9pyQ3sqRQmmkyUxFiN8rOK4mEepgnmK8PBnVEw/PbJxpQttV
         2d8XMJfZK+IzdCYXBEc8EkbyyolFrlFfpdz+6J71GbhlrHlbZSBiOIT8xs7WkRWsVE57
         wzPYT3IZbBo3mQdkUPdBojq8qFMhlRmfwBUyVpSs4BGPo257HKVQXULAnF+RQDzi37di
         LkxbRKM8QPnWuZqw8XseeYv7BP1xXb/2a1mLW8RPTT34jCT6GAydxEbqUTJoRZc1lUtj
         qWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572611; x=1686164611;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zpq26Yp2a0RLrPDd9SFsqNJZ1KsB6RTvAi9S8XxjHQ=;
        b=lLvx82ogKt0273pMjTRXqxZZI/9IkbziC90DWFk00K3vF7OqMF9CyfQVghElCveP2w
         J1chVQFItIW4kabuiTDKhhamFDXCprtDw4T5zJ0zq3j2EAtvOH3BNDktOrVWlSjtruZr
         1nfcNVWEKqicSZGBHXD9Ox2tVQU/Fhlje4EfzhmRkQ5v+hMfj2M+3wHb2an8sGG6UExA
         VUZZ8IvyaqO8JvvAphQy0V6J5jElgZafah7fnOqs0en7eZgmhOwEMwZqamg/3yJG/EXL
         qr/aO+g3ngcfqQ41VHmdfCVRjAUOYThxyhXTTrgG+btdkBlslHiy4hGGOHGTbv9r34Ef
         Bomg==
X-Gm-Message-State: AC+VfDy6p0D6ipTv3IqSg5YvV4PwCXGSUj0aYQRUX5KRiJnFWJhpWX3K
	MNE4AXyiAgfuXILRvAUrmsr+UByTxa8=
X-Google-Smtp-Source: ACHHUZ4hJcxnYqcTmMAnxqSV3ydChmnQPIdYJFRihT14QTGbuLj8SDiuz0u3u21IUroJd+KRAcQuEQ==
X-Received: by 2002:a05:6214:408:b0:621:3523:d7c2 with SMTP id z8-20020a056214040800b006213523d7c2mr629072qvx.22.1683572611447;
        Mon, 08 May 2023 12:03:31 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a01fb00b007441b675e81sm2761276qkn.22.2023.05.08.12.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:03:31 -0700 (PDT)
Message-ID: <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
Date: Mon, 8 May 2023 12:03:29 -0700
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
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
In-Reply-To: <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/23 11:55 AM, James Prestwood wrote:
> Hi Denis,
> 
> On 5/8/23 11:05 AM, Denis Kenzior wrote:
>> Hi James,
>>
>>>> Second, if we're passing unicast frames, and the unicast frame is 
>>>> addressed to a radio in a different namespace, how does that radio 
>>>> get the frame?  We don't have it in our radio_info queue?
>>>
>>> The namespace bars hwsim from seeing radios in other namespaces via 
>>> GET_WIPHY. So yes, the radios are not in the radio_info queue. But 
>>> since the radios are on the same kernel any MAC the kernel knows 
>>> about is accepted when sending a frame, regardless of namespace.
>>>
>>
>> I get this part.  What bothers me is that the current dispatch code 
>> seems to be completely wrong?
>>
>>>>
>>>> The comment for the code you're taking out makes it clear that the 
>>>> intent is for unicast frames to be sent only only to the radio with 
>>>> the target receiver address.  And the optimization is simply about 
>>>> not sending frames to radios with addresses we know do not have the 
>>>> target address.
>>>>
>>>> What you're doing here seems to indicate that our implementation 
>>>> (and the comment) is completely bogus.  And we can simply send any 
>>>> frame to any radio instance (once) and the frames will be forwarded 
>>>> automagically.  If so, then you might want to explain this better 
>>>> and fix the code to reflect this.
>>>
>>> Maybe I described this badly, but I was trying to make 2 points:
>>>
>>>   - Historically, before namespaces, hwsim should never be in a 
>>> situation where a frame is addressed to an unknown recipient. Hostapd 
>>> won't do this and IWD won't do this. So all that code was doing is 
>>> looping through the radios. Maybe there is some case I haven't 
>>> thought of, in which case the kernel would drop the frame anyways.
>>
>> Sure.  To put it another way, hwsim works today by doing roughly the 
>> following:
>>
>> Suppose we have a setup with a single namespace, with 3 radios.
>>
>> Radio A with address aa
>> Radio B with address bb
>> Radio C with address cc
>>
>> When a _unicast_ frame with target 'cc' is seen by hwsim, it loops 
>> over A, B, C and compares the addresses.  If the addresses do not 
>> match, then no HWSIM_CMD_FRAME is issued for that radio.  So we'd only 
>> issue HWSIM_CMD_FRAME with Radio C's HWSIM_ATTR_ADDR_RECEIVER.
> 
> Ah ok, I see where you're coming from now. I overlooked that part. I can 
> re-work this and if the destination is a known radio then only forward 
> to that radio. If the destination is to an unknown radio I think we have 
> to forward it regardless.
> 
>>
>> What you're doing in this patch is to now issue the frame to each and 
>> every known radio.
>>
>> So suppose you change this to 2 namespaces, with Radio A+B in 
>> namespace A, Radio C in namespace C, etc.  Are you running 2 instances 
>> of hwsim? One per namespace?
> 
> Yes, a separate hwsim instance per-namespace.
> 
>>
>> How does it help if namespace A receives a frame with target 'CC'? It 
>> doesn't know about Radio C, so how would radio C even receive the 
>> message? And if it somehow does anyway, then it would seem like the 
>> above dispatch logic is bogus in the first place?
> 
> If a client in namespace A sends a frame to target CC then the hwsim 
> instance in namespace A gets this frame. It doesn't know about target CC 
> but the kernel does. So it forwards into the kernel and target CC 
> receives it.
> 
> I don't think there is anything wrong with the dispatch logic. There is 
> just a disconnect between what information hwsim knows vs the kernel. I 
> think tweaking the optimization I removed (described above) effectively 
> keeps things the same (assuming clients are sane and don't send frames 
> to completely bogus addresses).

Ok, actually I see your confusion now. Removing that block of code would 
send the frame to all *known* radios only... So this actually should not 
work, but it does.

Its like the kernel is disregarding ATTR_RECEIVER_ADDR and just looking 
at the frame contents. Anyways, I'll investigate.

> 
> 
>>
>>>
>>>   - Then with the introduction of namespaces we actually do hit this 
>>> case of having unknown destination addresses. Not because they are 
>>> bogus, but because hwsim simply cannot know about radios in other 
>>> namespaces.
>>>
>>
>> Right, I get that.  But this is not what my question is about :)
>>
>> Regards,
>> -Denis
