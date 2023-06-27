Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747119501
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 15:15:12 +0000 (UTC)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3456fda4ed1so18024005ab.0
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687878912; x=1690470912;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cX8DG9qcX1n52C+q4rx0eHSIum4Maa1dyT/qoEOrmT4=;
        b=khO3nlUqdFnZKzDv+wreTLW05RdXThDSi4P0R4k9NdT7te376sgxXesWxH1SEkkGXz
         pIcAPHuBiHRe2q2UHfPH7OEX3VP4TlHKAAyi1cJDI54d/1bF+0mTRmbLBGvwAyfmgVA/
         ExI2oMwz8jf65c9RUwIOoDXJ6/Lc2AOD/+3pff6f04Qq4aqVdvuknz9g4jYULFAFhIMv
         cfLM/zm4cAnyzGYSuktkU6U26IeKmvOernqJLUEHl0/R1j5IIYa6o3QJoyp2HZyd3mVJ
         H6+Y5//Xjchl6c7ou9t4rsWkEzBruRdztfaFx45S4iYxQwOJYNwlgmxDtYMDA04+b0Hj
         sUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878912; x=1690470912;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cX8DG9qcX1n52C+q4rx0eHSIum4Maa1dyT/qoEOrmT4=;
        b=anP1lFqrzb8SDKz4v4tOq2PNPvzA/6rvdTfppYPOjybbajl4PrPm9V6l0RyX7/UT/R
         JaaXV8xhbSRNFEX43uS7Uy39ZyiJrBxS7B/2SjuBQM2MO0mMfFVWo0CzdZC8p5C1/BWZ
         kqMc+FtzA4m5O3G8AbcceXKDkBjJPoRjeT1VBF9P4CEU8eRajjyJIMXphW1dQpL9AxDK
         mYE5Xd7sTP/3eQyOaUXBT1XD5DUBB5YL3rJ3KIE8vpFQaHMrl+8lds2FR0ix7pbAJCTF
         mW9wTxdkZkJU+sMHIoW5XYnVh0f6XDZc0Z+Q2gYV4/XjgF//OY5AxsjGOlK01Ti5dU5o
         5k7Q==
X-Gm-Message-State: AC+VfDyS3VEffS+l7WWZwwIf1/EbAXBXCk36WOJvmvGkRWxABB71LpmM
	YMcWjtLaW0ePalun+y+iMFXpiOSymjU=
X-Google-Smtp-Source: ACHHUZ4GvPdMcMbUyjxg+Jbl/moE0STxziKXGCRxwPpn42PYeqsZxexHM7e8Ao1uaQfwCPGx0NgzUw==
X-Received: by 2002:a92:da02:0:b0:345:3378:4258 with SMTP id z2-20020a92da02000000b0034533784258mr10699049ilm.30.1687878911651;
        Tue, 27 Jun 2023 08:15:11 -0700 (PDT)
Received: from [192.168.254.84] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id l10-20020a17090b078a00b00262d079720bsm5801771pjz.29.2023.06.27.08.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 08:15:11 -0700 (PDT)
Message-ID: <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
Date: Tue, 27 Jun 2023 08:15:10 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 6/26/23 7:31 PM, Denis Kenzior wrote:
> Hi James,
> 
>> Just an update here. The reason hwsim was behaving like this was 
>> because DEL_WIPHY isn't handled but DEL_INTERFACE is.
>>
> 
> Funny.
> 
>> So when hwsim starts it dumps and tracks all the radios but when a 
>> radio gets moved into another namespace only the interfaces get 
>> cleaned up. Then a frame comes and hwsim won't find a matching 
>> interface->addr to send the frame, and bail out. But when I removed 
>> that block of code it wouldn't bail out and since the radios still 
>> existed in the queue the frame could be sent out to all radios 
>> including "removed" radios. Since the kernel doesn't care about 
>> namespaces those "removed" radios still got the frames.
> 
> Ok, that makes sense now.
> 
>>
>> So at least that's sorted out. How we want to support namespaces is 
>> the question. A few options:
>>
>> - Peek into the frame at the destination address and use that as 
>> ATTR_RECEIVER, but this won't work with address randomization for phys 
>> outside of the root namespace. IMO this is probably fine for testing 
>> purposes, if we know about it ahead of time.
> 
> You can try to see whether HWSIM_CMD_ADD_MAC_ADDR works?  See commit 
> 5cc58a9ecfa1 ("mac80211_hwsim: notify wmediumd of used MAC addresses")

I hadn't seen that before, but looking at it they don't expose that as 
an API, its only for internal use for scan address randomization and 
monitor interfaces (see mac80211_hwsim_config_mac_nl()).

> 
>>
>> - Add support to hwsim to move radios to other namespaces, and keep 
>> track of those radios (similar to what we erroneously have today). 
>> This is fragile though because you no longer can remove 
>> radios/interfaces, nor do you know if they have been removed.
> 
> Hmm, but radios are namespace independent.  They can only be 
> added/removed via HWSIM_CMD_ADD/DEL_RADIO, no?  Since phys are moved 
> wholesale across namespaces (you can't only move a given interface), you 
> could assume that once a radio is created and populated, its interfaces 
> do not change for the duration of the test, even if they're moved to a 
> different namespace.

For testing yes this is probably fine. It may require some adaptation in 
hwsim to do it better from a test-runner perspective. Currently we just 
use ip to create/delete namespaces and move radios. It may make more 
sense to add this to hwsim so there is one path. Then at least when 
hwsim gets a DEL_WIPHY event it doesn't have to assume the radio was 
moved (I'm thinking if we ever added hotplug tests this could be important).

I'll pursue this path.


> 
> Or if the HWSIM_CMD_ADD_MAC_ADDR API works, that might make things even 
> simpler.
> 
> Regards,
> -Denis
