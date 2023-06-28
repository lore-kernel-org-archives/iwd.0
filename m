Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FAC8E3
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 16:14:09 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-63588812c7aso514786d6.0
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687968848; x=1690560848;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NzFW6mmX7+NGmHuB69JxYy9IjqkGMWOETPq9A4316g=;
        b=pWCivGptxz1hnDyMGVfIlG2EA+n1KEPifqX9qv+Q5QAPIJgUB61JlXjUeorYxMeOlb
         rxBy/x61M4AjY2Yu6kinfNkLEuWNJ13GP1eTCvj56InU3UU35tY/lNGwcihOO6aedCuZ
         HASjG2jWZYdfHU2hnelIw8NbN3se9oRzvIndWZhv47W+xuyEAjjXlr9iiOjpzUnuQ30e
         +7Z0ZOzbwNP4PEVwic8PdRTBefmgJjIfesBMxpy8dCkhcSdE2BAWrKYJzi9FqLzdjSSG
         qEY6VEUHLOWjl45Pw+YoxwwlRnMiY0UPHdwGhwd5lzrk9KBQ17ttBu/79hKej+9uaOuK
         QkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687968848; x=1690560848;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NzFW6mmX7+NGmHuB69JxYy9IjqkGMWOETPq9A4316g=;
        b=h3mJ+/j0GdUtzJPB2HO34DVK65n9ErADUHPmFPD8CFd5aYLIggXZZ0+Tc/p/kM+tz6
         dKJg3X9jwZPDp6A//MgPJYCSeczP4xJqqi/VEjQ+H3h83uTp8bajA/Kl8snDuntucmqL
         caWkG5hBevM2ZXNJRIJaPIoKrjFqN0wXmqAvtOGaqtkOxYRK3N5rBnbQ8JAZG8k3Ngt8
         D1qG4MLr4ZDTioSxft6ytKvr31ruLWXy4o3qFUokliT4whjwQdvmCH1vh36KIw7tyR6N
         9ORcH0y4vSQEV62dETNL1Y4CojXOaaMsZGeDFwhhfhVh53Gq7jDo4Rsy5Yu8+NiF0ibO
         EHDA==
X-Gm-Message-State: AC+VfDwN+Geq/8qaLWV3OQ8shLlQ5GwL3vpaFBr8pfym3TkqSpaOi9eR
	sqWu+H2BNOPkTy0s/2lElps=
X-Google-Smtp-Source: ACHHUZ5D9ncLbwL7cl6rbyMPcHnFLSY47zEGj02DbeGuoS4S2Ko0yMfo4mFiDLoa5Tst+W9HIh6Flg==
X-Received: by 2002:a05:6214:501b:b0:635:e286:d4b with SMTP id jo27-20020a056214501b00b00635e2860d4bmr2389989qvb.18.1687968847977;
        Wed, 28 Jun 2023 09:14:07 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a14ad00b00759554bbe48sm3299800qkj.4.2023.06.28.09.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:14:07 -0700 (PDT)
Message-ID: <6795644d-1ce8-6937-d8b8-4318f2720289@gmail.com>
Date: Wed, 28 Jun 2023 09:14:04 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
 <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
 <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
 <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
 <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
 <24a0ae5c-529b-a061-0fb4-0ba8a66fe76b@gmail.com>
 <2c35a14a-3ed7-fefb-5a78-fb29199f0fd4@gmail.com>
 <82ba7228-441f-ebf1-22d2-890b00c676e2@gmail.com>
 <7c2ca71d-5cba-c067-04bf-75a9341f3db6@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <7c2ca71d-5cba-c067-04bf-75a9341f3db6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 6/28/23 8:40 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> Unfortunately once you move the radio into another namespace you lose 
>> any events associated with that radio, due to the PID of hwsim being 
>> associated with a distinct namespace (I think). So ADD/DEL_MAC_ADDR 
>> won't help here.
> 
> Which events though?  You should always be getting HWSIM_CMD_ events for 
> _all_ radios since only a single hwsim instance is registered, no?  
> Aren't these all you need for the purposes of sending packets to the 
> right radio?

ADD/DEL_MAC_ADDR, which don't come once the radio is moved to another 
namespace (as far as I can tell with testing).

I think it comes down to port ID:

u32 _portid = READ_ONCE(data->wmediumd);
...
hwsim_unicast_netgroup(data, skb, _portid);

One other potential (but much more complex) solution would be to use 
multiple hwsim instances that communicate, making a sort of distributed 
hwsim environment. I'm working on a similar concept which could 
(partially) be upstreamed, at least the hwsim parts.

We could provide hwsim a socket/FD to communicate with other hwsim 
instances. hwsim would behave the same as it does now unless it receives 
a frame which doesn't match to any known radios. In which case it send 
that frame out to the external socket. It would also receive on that 
socket, and pass the frame back to its local hwsim socket.

I have it now where I just use the netlink protocol between hwsim 
instances, so you can receive on the remote socket/FD and send that 
directly back to the kernel for the local instance.

This is similar enough that some of what I've done already could be 
upstreamed and solve this namespace problem.

Thanks,
James
> 
> The NL80211 WIPHY events aren't really needed.  We only use these for 
> informational purposes (only the name is used, I think?)  I guess we 
> also use this information for the radio_ap_only() optimization we do, 
> but we could probably solve this another way.
> 
> Regards,
> -Denis
