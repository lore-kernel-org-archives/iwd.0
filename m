Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACCBA2F
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 15:53:18 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-626157a186bso13083296d6.1
        for <iwd@lists.linux.dev>; Thu, 01 Jun 2023 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685634797; x=1688226797;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TS3H/rJYt865wDluKEcaXzyMMnUEyA51UHcSNAOUhWc=;
        b=O2+hZOSSkc+WrGDmLnzDG9E2oCU7MgkFin35pDEIxkzg0SJqvbpgQ4//fS8uXP3p0x
         TOiezY1WBiJn7HlHX5MK74QVBHUbx4LB1S6Z8doqeBgvB1dpdrCshPKion6RHj+DQSPK
         0FjMyGTlA+26mMNmssCZNjzJ+W2TB47kXu9WXfRlwRy6rO96MFVOzsc43BaY5JUejjbX
         8CceBdDJtvSHPC6LzUuPbTgiI88qGdFOia51wtg/4VA7oXS6zZRUNv4gllzR9hzluOXG
         j/fE5UhLf++G/Jx7C5hua3aqDh+r9gZu0/oIOT2/XK8u3bhqs8Z1Fds2HZgkYgpG1fDK
         wxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634797; x=1688226797;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS3H/rJYt865wDluKEcaXzyMMnUEyA51UHcSNAOUhWc=;
        b=fUJhW1F0M1Ba6laCd4X6UVzSaILedzIyan2XEUT63VC2g1AcJV3+zj34oFVFfU4Cam
         CgMzaLOPZbHeTiAx1z0wSVei7vMX427M1dpsueA6Z3aD4dyFOswBH58wUXcXuakTJr31
         KnwlaMKsO+C5CYyG2lJC30FzZp2D11qxwAXF8CNw7GN84mR2GdcgBf35gqK8LSNj4G/U
         RqlO5UcPm1a+JVsMXqz1VSrGEdF0dvhVokNftDc8L7EgWHtZOjKePG3ZqwgcCkQmPPCu
         DdhWwrroxJADFEJQvf2hhB6Cvhv89uFZdBCITsCXjOS0LSEsprp3H7fA21fP8lEMMGsL
         fWag==
X-Gm-Message-State: AC+VfDwHBxRKvS4yyqDM34HoR1ut9Ibo6Og5K5k9Ml0t0+cpHKsVqroQ
	YHJaGhYd5aSotN8awf6Bu/5Vp6qBAVg=
X-Google-Smtp-Source: ACHHUZ7AJO2OnwdrNvtS2sRjwGqVuIcXQ0JMaA/d+joPjMeRKnCgRS2YZK0cT6HldLJDhxvNaB4Oeg==
X-Received: by 2002:a05:6214:1d2a:b0:61b:65f4:2a15 with SMTP id f10-20020a0562141d2a00b0061b65f42a15mr3104758qvd.12.1685634797144;
        Thu, 01 Jun 2023 08:53:17 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g3-20020ad457a3000000b0062824b0517fsm2242961qvx.67.2023.06.01.08.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:53:16 -0700 (PDT)
Message-ID: <eba9839e-55ab-d532-c52f-c58cac465ea1@gmail.com>
Date: Thu, 1 Jun 2023 08:53:14 -0700
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
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
 <17dd827c-a2de-b7ec-75de-99d0b17cf6f3@gmail.com>
 <BY3PR08MB7220AB646467DBCE1A4B7433AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <BY3PR08MB7220AB646467DBCE1A4B7433AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/1/23 8:42 AM, Michael John wrote:
> Hi James,
> 
> On 6/1/23 8:06 AM, James Prestwood wrote:
>>> Hi Michael,
>>>
>>> On 6/1/23 6:17 AM, Michael John wrote:
>>>> Hello,
>>>>
>>>> I'm having an issue getting iwd to recognize a virtual interface.
>>>> Using 'iw' I've created a virtual interface called wlan1:
>>>>
>>>> iw dev wlan0 interface add wlan1 type __ap
>>>>
>>>> This leaves me with the following two interfaces:
>>>>
>>>> ~> iw dev
>>>> phy#0
>>>>           Interface wlan1
>>>>                   ifindex 8
>>>>                   wdev 0x5
>>>>                   addr c0:ee:40:64:4a:1d
>>>>                   type AP
>>>>                   txpower 23.00 dBm
>>>>           Interface wlan0
>>>>                   ifindex 7
>>>>                   wdev 0x4
>>>>                   addr c0:ee:40:64:4a:1c
>>>>                   type managed
>>>>                   txpower 23.00 dBm
>>>>
>>>> When running 'iwctl' to list devices and APs I'm not seeing wlan1.
>>>>
>>>> ~> iwctl ap list
>>>>                             Devices in Access Point Mode
>>>> --------------------------------------------------------------------------------
>>>>     Name                  Started
>>>> --------------------------------------------------------------------------------
>>>> No devices in access point mode available.
>>>>
>>>> ~> iwctl device list
>>>>                                       Devices
>>>> --------------------------------------------------------------------------------
>>>>     Name                  Address               Powered     Adapter
>>>> Mode
>>>> --------------------------------------------------------------------------------
>>>>     wlan0                 c0:ee:40:64:4a:1c     on          phy0
>>>> station
>>>>
>>>>
>>>> When previously using 'wpa_supplicant' and 'NetworkManager' this
>>>> virtual interface (wlan1) was usable in AP mode. The radio does
>>>> support AP+STA mode.
>>>>
>>>> ~> iw phy
>>>>      ...
>>>>           valid interface combinations:
>>>>                    * #{ AP } <= 3, #{ managed, P2P-client, P2P-GO } <= 2,
>>>>                      total <= 3, #channels <= 1
>>>>                    * #{ IBSS } <= 1,
>>>>                      total <= 1, #channels <= 1
>>>>      ...
>>>
>>> So this appears to me that you cannot do AP+STA with this adapater. You
>>> would need to see "AP" and "managed" in the same block e.g.:
>>
>> Actually sorry, I take that back. The interface combos always confuses
>> me when I have to take a look again. The card in my laptop has a similar
>> combo to yours and I can do AP+STA:
>>
>> * #{ managed } <= 1, #{ AP, P2P-client, P2P-GO } <= 1, #{ P2P-device }
>> <= 1, total <= 3, #channels <= 2
>>
>> In my case I was having issues because the virtual interface was being
>> created in station mode (despite passing "__ap" when creating). Looks
>> like yours is already in AP mode from the "iw dev" command so I'd need
>> to see the debug logs of IWD starting up to see why the iface wasn't
>> recognized. You could also try bringing both interfaces up prior to
>> starting IWD.
>>
> 
> Attached is a capture of the log from iwd. I had a wlan0 and wlan1
> created before starting iwd. I noticed after starting iwd my wlan1
> in then gone.
> 
> ~> systemctl stop iwd
> 
> ~> iw phy phy0 interface add wlan0 type managed
> 
> ~> iw dev
> phy#0
>          Interface wlan0
>                  ifindex 15
>                  wdev 0xc
>                  addr c0:ee:40:64:4a:1c
>                  type managed
>                  txpower 23.00 dBm
> 
> ~> iw dev wlan0 interface add wlan1 type __ap
> 
> ~> iw dev
> phy#0
>          Interface wlan1
>                  ifindex 16
>                  wdev 0xd
>                  addr c0:ee:40:64:4a:1d
>                  type AP
>                  txpower 23.00 dBm
>          Interface wlan0
>                  ifindex 15
>                  wdev 0xc
>                  addr c0:ee:40:64:4a:1c
>                  type managed
>                  txpower 23.00 dBm
> 
> ~> systemctl start iwd
> 
> ~> iw dev
> phy#0
>          Interface wlan0
>                  ifindex 17
>                  wdev 0xe
>                  addr c0:ee:40:64:4a:1c
>                  ssid MIDGUEST
>                  type managed
>                  channel 48 (5240 MHz), width: 40 MHz, center1: 5230 MHz
>                  txpower 23.00 dBm
> 
> Looking at the ifindex ID it looks like iwd created a new interface for wlan0.

Ah ok, this is the problem. This is what IWD does by default. Since your 
managing the interfaces you need to specify them with "-i wlanA,wlanB,etc"

This will make IWD retain the interfaces it sees and not delete them.

So in your case:

iwd -i wlan0,wlan1

> 
> Thanks,
> Michael
> 
>>>
>>> #{ AP, managed, ...} <= 2
>>>
>>> For example this adapter I have:
>>>
>>> valid interface combinations:
>>> * #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2,
>>> total <= 2, #channels <= 1, STA/AP BI must match
>>>
>>> If you could get the debug logs of IWD starting up I could take a look
>>> at those to see why the wlan1 interface wasn't brought up, but to me it
>>> looks like the adapter simply cannot support AP+STA modes at the same time.
>>>
>>> Thanks,
>>> James
>>>
>>>>
>>>> So I'm left wondering if 'iwd' supports virtual interfaces created
>>>> with the 'iw' utility and if so, what am I missing?
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> Michael John
>>>>
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
