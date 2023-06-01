Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE02342E
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 15:17:15 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b025d26f4fso8359485ad.1
        for <iwd@lists.linux.dev>; Thu, 01 Jun 2023 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632635; x=1688224635;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LygHhe3NYGva5Ma2FiPJZuEeG5SBpFCetbwbbVTtKJs=;
        b=ctDO5vNfrOut3BjbTgnZjgQtVQs0pRge3WSYyVgFMVfjetJP4xT/NJjcbmSLBCX6Lh
         quC8Wz3oMCj+b5xEoQrjWBsIAsJHgYc1HN8AjeQRV62A9t5aIc84tculg1hjo/7o5qto
         Artry369jgZudLB+hm5KfmE6jWZ2ikI3kXMJ+EoZ10raWlJbUXeNvwe6ckH3YiGXav9W
         E0ZghZ/XoZH4b5iTm47nw9O/W4N3xmNQZpvQROPVGQNY0mYRHdswYrMKXq+Z7M+CcAog
         kX++XJoeWmttWS1VT2D8wE/LyslPekuFFIR0ye16fJvzp2f9LjBS7DYig1BkZX+InzJr
         5Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632635; x=1688224635;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LygHhe3NYGva5Ma2FiPJZuEeG5SBpFCetbwbbVTtKJs=;
        b=f0kur2LPYu71LYm+WLd9vJiWDTSjdZM3/x+JVOvwvtXPqZ3JU2jH6vca1l2pN33JdD
         3tIJ80cQNx9T2F4OwzCLMtHZkaPEsgokKa5bg7/TfYJh/B+Jx9QNbKGENAMndER5Jxbt
         agG32pDQHdOcP57nOUJ/mXyIh5EdYDAHwlkluifCH4hgdHPq65SLGHQmzxjI5L6gqcg6
         LtnQhzm4HCJiryym0OKZBHRm5S2Hh0UeTjqtMwa2qIc/jctDI8OuiWnYj9DDa4Yxsh7C
         +3vrz44YsTy6vmVechzRgAPpnNHpg3Vsi6o8zC0dkrIT+G5WYSQNcOjeLGVBeoOuKBkp
         Iu/A==
X-Gm-Message-State: AC+VfDzZgrjQ7H2kMhBlRxKhNPkz0YzODj8FPtyKMi4OOLthL3UZSQ4w
	C3dSMvc5I6DHg5rnXdGKx20=
X-Google-Smtp-Source: ACHHUZ5ueGO95W2fvgNN935QS1iT3IVnGR8Dy9OaamiDa9eadcLg/yjLooKZdCD5ekD0vWlq5/3qXg==
X-Received: by 2002:a17:902:d510:b0:1b0:4a37:9ccc with SMTP id b16-20020a170902d51000b001b04a379cccmr10624252plg.62.1685632635105;
        Thu, 01 Jun 2023 08:17:15 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902da8400b001ac8218ddb7sm3627963plx.84.2023.06.01.08.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:17:14 -0700 (PDT)
Message-ID: <17dd827c-a2de-b7ec-75de-99d0b17cf6f3@gmail.com>
Date: Thu, 1 Jun 2023 08:17:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: issue using virtual interface with iwd
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
In-Reply-To: <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

On 6/1/23 8:06 AM, James Prestwood wrote:
> Hi Michael,
> 
> On 6/1/23 6:17 AM, Michael John wrote:
>> Hello,
>>
>> I'm having an issue getting iwd to recognize a virtual interface.
>> Using 'iw' I've created a virtual interface called wlan1:
>>
>> iw dev wlan0 interface add wlan1 type __ap
>>
>> This leaves me with the following two interfaces:
>>
>> ~> iw dev
>> phy#0
>>          Interface wlan1
>>                  ifindex 8
>>                  wdev 0x5
>>                  addr c0:ee:40:64:4a:1d
>>                  type AP
>>                  txpower 23.00 dBm
>>          Interface wlan0
>>                  ifindex 7
>>                  wdev 0x4
>>                  addr c0:ee:40:64:4a:1c
>>                  type managed
>>                  txpower 23.00 dBm
>>
>> When running 'iwctl' to list devices and APs I'm not seeing wlan1.
>>
>> ~> iwctl ap list
>>                            Devices in Access Point Mode
>> --------------------------------------------------------------------------------
>>    Name                  Started
>> --------------------------------------------------------------------------------
>> No devices in access point mode available.
>>
>> ~> iwctl device list
>>                                      Devices
>> --------------------------------------------------------------------------------
>>    Name                  Address               Powered     Adapter     
>> Mode
>> --------------------------------------------------------------------------------
>>    wlan0                 c0:ee:40:64:4a:1c     on          phy0        
>> station
>>
>>
>> When previously using 'wpa_supplicant' and 'NetworkManager' this 
>> virtual interface (wlan1) was usable in AP mode. The radio does 
>> support AP+STA mode.
>>
>> ~> iw phy
>>     ...
>>          valid interface combinations:
>>                   * #{ AP } <= 3, #{ managed, P2P-client, P2P-GO } <= 2,
>>                     total <= 3, #channels <= 1
>>                   * #{ IBSS } <= 1,
>>                     total <= 1, #channels <= 1
>>     ...
> 
> So this appears to me that you cannot do AP+STA with this adapater. You 
> would need to see "AP" and "managed" in the same block e.g.:

Actually sorry, I take that back. The interface combos always confuses 
me when I have to take a look again. The card in my laptop has a similar 
combo to yours and I can do AP+STA:

* #{ managed } <= 1, #{ AP, P2P-client, P2P-GO } <= 1, #{ P2P-device } 
<= 1, total <= 3, #channels <= 2

In my case I was having issues because the virtual interface was being 
created in station mode (despite passing "__ap" when creating). Looks 
like yours is already in AP mode from the "iw dev" command so I'd need 
to see the debug logs of IWD starting up to see why the iface wasn't 
recognized. You could also try bringing both interfaces up prior to 
starting IWD.

> 
> #{ AP, managed, ...} <= 2
> 
> For example this adapter I have:
> 
> valid interface combinations:
> * #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2,
> total <= 2, #channels <= 1, STA/AP BI must match
> 
> If you could get the debug logs of IWD starting up I could take a look 
> at those to see why the wlan1 interface wasn't brought up, but to me it 
> looks like the adapter simply cannot support AP+STA modes at the same time.
> 
> Thanks,
> James
> 
>>
>> So I'm left wondering if 'iwd' supports virtual interfaces created 
>> with the 'iw' utility and if so, what am I missing?
>>
>>
>> Thanks,
>>
>> Michael John
>> CONFIDENTIALITY NOTICE: This message, including any attachments, 
>> contains confidential information intended for a specific individual 
>> and purpose. If you are not the intended recipient, you should delete 
>> this message and any disclosure, copying, or distribution of this 
>> message, or the taking of any action based on it, by you is strictly 
>> prohibited.
>>
