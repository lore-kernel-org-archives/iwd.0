Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19504C2DA
	for <iwd@lists.linux.dev>; Thu,  8 Jun 2023 15:34:56 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-75d4fb03100so65415285a.3
        for <iwd@lists.linux.dev>; Thu, 08 Jun 2023 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686238496; x=1688830496;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEroX+daGzySOjbxBOtAm/++OIuQCHGjXKYrKYuZIec=;
        b=Z/q8Ws0lNqoIsnHjsf+vr6KVeWEnralR92ALWqXqzIOKGQNjKFr47tacklR46zBMf0
         dxoyom4jvy45fk0z4l+FnbrzupCoI4ulYqAJkguCZ5IWqyGhx2E1Bnc0qAwnbiF1rlzf
         wx7qE9f4VMSA9r6clfS7PQ//iAvttGGjNbymoxzHQBan+wG/1NtnD+n+ZTV00twe8Z1Y
         6YrBuSkp61ACr7JDaUaa2ntQ1qY5Uex3n08GARaalQuSg7Zi5yopp4PB1eCk2xDxzxyk
         UW6BHKGcAab+RGBvoiayUmPTDVvg3QJFOBRb2y7/t2NY1w3O5OzWqmqOsRxsY3SJ+z5L
         Qerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686238496; x=1688830496;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEroX+daGzySOjbxBOtAm/++OIuQCHGjXKYrKYuZIec=;
        b=hu30gEW4YWpVCSa/4rNLGwIJr3NMZKe6QBbTmcSzrq8fybgsddJdLWg7aG1I1Y547p
         QDmeOh4o8xEOnFtrbkfI3G6b38KEsIlImD2PvgNHShUUpXsBnlZajZ9S3V4ZTEBE4u1H
         zDWNlggzIpnFPBmcYMvUQO0Tin+FsWQDb8NoKAms562mASJBePxLksBJfuVWlhduPZ9a
         cZT+CLwfxzK1UnfHR6wLXDE8I2PoJFNqhEB3CBgpy3JyV6/i5GNmsf7VfFbeNZ/ESYnn
         PLAfzV7LN5qlEUW0Gr2erCp4zHgYDm8+tNp4D3KyVMBaZgT4lNytPynnGRJ/psaEqqTt
         b4dg==
X-Gm-Message-State: AC+VfDzgzVoBSDsUEKTIkXnX+us5JGqKQ3NvBVP6BRxxjYcEgFOeNvP6
	JKiQgxsjTOqz7g6dyRQ5+TG3oOy+y9o=
X-Google-Smtp-Source: ACHHUZ5JnrkFj0W+n8PMItKu/hZk+su4PlmOit4/WJM0yDEVvEgXvDhMigp2ErD6+SFD4oDQRFCpHg==
X-Received: by 2002:a05:620a:24ca:b0:75d:ba43:bc6f with SMTP id m10-20020a05620a24ca00b0075dba43bc6fmr8157281qkn.8.1686238495652;
        Thu, 08 Jun 2023 08:34:55 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id f6-20020a05620a12e600b0075785052e97sm390875qkl.95.2023.06.08.08.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 08:34:55 -0700 (PDT)
Message-ID: <970653a6-9fa6-e871-7ab4-3cb6943c86a1@gmail.com>
Date: Thu, 8 Jun 2023 08:34:53 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Bring up of AP fails on certain channels
Content-Language: en-US
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <BY3PR08MB7220600D62E8C2FD1334253FAE50A@BY3PR08MB7220.namprd08.prod.outlook.com>
 <826c0918-84ee-649d-2f4c-10c99e0e45a2@gmail.com>
 <BY3PR08MB72207A7A2387AD2D2908D805AE50A@BY3PR08MB7220.namprd08.prod.outlook.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <BY3PR08MB72207A7A2387AD2D2908D805AE50A@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/23 8:19 AM, Michael John wrote:
> Hi James,
> 
>>
>> Hi Michael,
>>
>> On 6/8/23 7:01 AM, Michael John wrote:
>>> Hello,
>>>
>>> I'm trying to bring up an AP and ran into an issue where iwd
>>> will fail to do so. My AP profile is below and I'm trying
>>> to bring up the AP on channel 64 but iwd gives a failure.
>>> If I change the channel to 6 iwd is able to successfully
>>> able to bring the AP up. I'm curious to why it fails
>>> if the channel is 64? The reason I needed channel 64
>>> is because my radio requires the AP to be on the same
>>> channel as the STA when in AP+STA mode, and me test
>>> network  for the STA is on channel 64.
>>>
>>>
>>> ~> cat /var/lib/iwd/ap/470034.ap
>>> [Security]
>>> Passphrase=myphrase
>>> PairwiseCiphers=CCMP
>>>
>>> [General]
>>> DisableHT=true
>>> Channel=64
>>>
>>> [IPv4]
>>> Address=10.42.0.1
>>> Netmask=255.255.255.0
>>> Gateway=10.42.0.255
>>> DNS=10.42.0.0
>>> IPRange=10.42.0.50,10.42.0.60
>>>
>>>
>>> ~> iwctl ap wlan1 start-profile 470034
>>> Argument type is wrong
>>>
>>> ~> iw dev
>>> phy#0
>>>           Interface wlan1
>>>                   ifindex 6
>>>                   wdev 0x3
>>>                   addr c0:ee:40:64:4a:1d
>>>                   type AP
>>>                   txpower 23.00 dBm
>>>           Interface wlan0
>>>                   ifindex 5
>>>                   wdev 0x2
>>>                   addr c0:ee:40:64:4a:1c
>>>                   type managed
>>>                   txpower 23.00 dBm
>>>
>>>
>>> ~> journalctl --no-pager -u iwd --since -1m
>>> -- Logs begin at Thu 2023-06-08 12:39:15 UTC, end at Thu 2023-06-08 12:55:04 UTC. --
>>> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_register() agent register called
>>> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_register() agent :1.193 path /agent/2814
>>> Jun 08 12:55:00 V2470034 iwd[1229]: src/ap.c:ap_validate_band_channel() AP using frequency 5320 and channel width 20MHz (no-HT)
>>> Jun 08 12:55:00 V2470034 iwd[1229]: src/ap.c:ap_get_gateway4_mac_cb() Error: Operation not supported (95)
>>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 0000: -114
>>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 0020: -114
>>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 0040: -114
>>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00a0: -114
>>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00b0: -114
>>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00c0: -114
>>> Jun 08 12:55:00 V2470034 iwd[1229]: START_AP failed: -22
>>> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_disconnect() agent :1.193 disconnected
>>> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_free() agent free 0x1d57d18
>>
>> One thing to note about AP mode on 5GHz is there are many more legal
>> restrictions. You can check if 5320mhz (channel 64) has any restrictions
>> and look for the frequencies section:
>>
>> $ iw list
>>
>> Frequencies:
>>       * 5320 MHz [64] (22.0 dBm) (no IR, radar detection)
>>
>> For example in my case "no IR" means I cannot emit any radiation, which
>> prevents AP mode from working. It all depends on your hardware, but
>> sometimes you can simply set the regulatory domain to unlock those
>> frequencies. IWD can do this:
>>
>> # file: main.conf
>> [General]
>> Country=<CC>
>>
>> Or you can use:
>> $ iw reg set <CC>
>>
>> But in my case I'm using a 'self-managed' device (iwlwifi) which doesn't
>> allow setting the regulatory domain. For me, I would need to scan as an
>> AP first to get the regdom set, but IWD does not currently support this.
>>
>> Thanks,
>> James
> 
> I appear to have the same restrictions.
> 
> For a network configuration is it possible to specify the BSS you want to
> connect to?
> For the network I'll join there are multiple APs available, it appears iwd is
> selecting the best 5Ghz AP. Using the 'BandModifier5Ghz' option in my
> config I'm able to give preference to 2.4GHz APs to partly avoid my issue, but
> it would be convenient to specify a specific BSS so I could avoid one that
> is on a channel that I have a restriction on.

No, there isn't (apart from using debug/developer commands which aren't 
meant to be used outside of a test environment). IWD aims to be as 
minimal as possibly in terms of APIs/configuration so it will pick the 
best BSS it sees fit.

I guess it depends on what your needing this for but for a consumer 
device use-case relying on station+AP to be on the same channel is 
fragile. For example, if the user's network only uses channels that are 
restricted in AP mode.

> 
> Thanks,
> -Michael
> 
>>>
>>> Thanks,
>>> Michael
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
