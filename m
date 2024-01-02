Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9EC15E9F
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ2qwkKq"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f07f9d57b9so24032427b3.1
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704225123; x=1704829923; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zd9brvwf8rKysW9i4GA32M3wm6kWcaitWE7qQmFim18=;
        b=PQ2qwkKqj8IiqE3l1ddTU6Bxhc0bFDXdYRwHDFYP9NUlXOv7eKRZXcjsDWYBsAQqQ3
         U/KJBrA0Ipefmw+XlFs2eaGbvKEp1AS0Hu5kAlKuevgkkhBVoom+me9gf4SeAQ9oE5v9
         3X36PoSLbILVORH1dq1k2MuS20uOFrC2CmOEwq5q4qzcSPlYYMIwSdQxZyO+wbpOw+4q
         86WoSNssqGPCahUANMlA3IJAi5XPi/klE3/52WSnan92g0vhlj0OIXQ+NGksYt1F/ZZE
         9xtkVHR6qt4s8kEncFqeoZb3kb0/uxU3Ax9geRVKFAWv0wkWF8LMVuamt30jmfLfuxsC
         B76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704225123; x=1704829923;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zd9brvwf8rKysW9i4GA32M3wm6kWcaitWE7qQmFim18=;
        b=gJSHurNKnSNlmaLMPZDMBkRwEQAVkeL83Pf0ecfNoHx0U2i5U5BNAX5eWEcSMID0+y
         n/NX82mO+tV7WLWanFTbXD5amV8viZViZMSEXz7qhP6GKvZaxD94Ze9P3bbjuF4N11wt
         s0rBZiumUPStASyQ2RAhg/sOqr+Me8opqeFjZHyxrBUMtMPBWzdgWwgBOZDDgepPeTfT
         vMPXXPHUuxBJkOhoQgx/AwsfoCItWcWC1vJIwgyAsz09PccfNdqteuy65Xs4mQMM7x+h
         7QDpcl0tF0jhtfQMVKcAu2MutKVVN3U3/KreZ1zTBSFkZRT+t80eK8wgmCu3rud/BI5m
         VMnw==
X-Gm-Message-State: AOJu0YwTEMsg98gw/JgKYqVDBkXazy2GNpPPoAYKlS+EatuVBRN3d/yI
	mL1pPzesPfTowNPxyHlhwdjuHljwSnUgWA==
X-Google-Smtp-Source: AGHT+IHVBgT/A7uUdj/BsYXVe0hqQXDfh1R+vXQim1LWcd2233w90RpvTLtZc0kOgbL9r9e/6FbweQ==
X-Received: by 2002:a81:ae61:0:b0:5ee:97c7:a0f0 with SMTP id g33-20020a81ae61000000b005ee97c7a0f0mr5210522ywk.91.1704225123392;
        Tue, 02 Jan 2024 11:52:03 -0800 (PST)
Received: from [10.175.163.107] ([67.226.156.137])
        by smtp.gmail.com with ESMTPSA id bp17-20020a05620a459100b0077dc528fd6asm9637117qkb.73.2024.01.02.11.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 11:52:02 -0800 (PST)
Message-ID: <353502c4-2da3-40e8-a6b2-7535b5c864a2@gmail.com>
Date: Tue, 2 Jan 2024 11:52:01 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
Content-Language: en-US
To: Mauro Condarelli <mc5686@mclink.it>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
 <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
 <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>
 <b3c259af-ee4f-488c-ad81-a734302fc6d6@gmail.com>
 <2aaed79f-9fae-4750-8e85-994a48a45da1@mclink.it>
 <5f3370ee-14a4-4921-b337-944cf1d5aaf4@mclink.it>
 <b99e05cb-6661-4f57-8519-e88082975f1a@gmail.com>
 <c98b7094-a11d-4368-b979-9e8be3cd37b4@mclink.it>
 <278c2319-ddcb-4be5-84fd-dbc7a3b835f1@gmail.com>
 <d747eb7b-f345-4867-9dbb-738535bab25c@mclink.it>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d747eb7b-f345-4867-9dbb-738535bab25c@mclink.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mauro,

On 1/2/24 9:45 AM, Mauro Condarelli wrote:
>
>
> On 1/2/24 18:30, James Prestwood wrote:
>>
>> On 1/2/24 9:09 AM, Mauro Condarelli wrote:
>>> Thanks James,
>>> comments inline below.
>>>
>>>
>>> On 1/2/24 16:36, James Prestwood wrote:
>>>> Hi Mauro,
>>>>
>>>> On 1/2/24 7:11 AM, Mauro Condarelli wrote:
>>>>> SNIP!
>>>>>
>>>>
>>>> Ok, so I'm not seeing any request to even connect from the AP side 
>>>> of things. Since your clients aren't even asking for a password I 
>>>> suspect it thinks there is some issue with compatibility. You could 
>>>> try using hostapd with a very basic configuration and see if that 
>>>> works, then we can go from there:
>>>>
>>>> hw_mode=g
>>>> channel=1
>>>> ssid=testssid
>>>>
>>>> wpa=1
>>>> wpa_pairwise=TKIP
>>>> wpa_passphrase=secret123
>>>>
>>> I had to add `interface=wlan0`, but that works... almost.
>>>
>>> It actually asks for password, connects and then fails because 
>>> there's (currently) no DHCP active (so no IP).
>>> I think that's expected.
>>> Behavior is the same with both clients.
>>>
>>> Do you have any further suggestions?
>>
>> Ok perfect, at least it connected. Could you run iwmon before hostapd 
>> and connect (same as you did with IWD), and send me those pcaps/logs. 
>> I'll be able to compare and see what its doing differently.
> I changed the script to:
>
> #!/bin/bash
>
> iwmon --write /tmp/iwmon.pcap >/tmp/iwmon.log 2>&1 &
> IWMON_PID=$!
> systemctl start hostapd
>
> mc
>
> systemctl stop hostapd
> kill $IWMON_PID
>
> cd /tmp
> tar cJf iw.tar.xz iwmon.pcap iwmon.log

Thanks for doing this. I do see some slight differences between hostapd 
and IWD but its difficult to know exactly what is causing the problem. 
Hostapd is very old compared to IWD and has had a lot of time to get 
working with every possible driver and client device. This also means 
there is a lot of extra cruft that has no effect anymore. I hate to 
"mimic" hostapd to a tee because it would likely add unnecessary bloat. 
What client devices are you using to connect? Also, what wifi hardware 
is in your beelink miniPC? maybe I have something similar I can try and 
replicate the issue.

For the time being it may be easier to use hostapd for your specific 
needs. As I said AP mode is experimental in IWD, and my day-to-day work 
priorities aren't really with AP mode. I can poke around with it on the 
side, and maybe provide patches to try out sometime in the future.

Thanks,

James

>
>
>>
>>>
>>> TiA!
>>> Mauro
>>
