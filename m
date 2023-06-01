Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46C2342E
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 15:06:35 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-652328c18d5so146851b3a.1
        for <iwd@lists.linux.dev>; Thu, 01 Jun 2023 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685631995; x=1688223995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLz9ii7hbYdBijJL4NgNzDpr7lZ4rrhjj/K/ef+kGHw=;
        b=ecYv7kSohplPP6CDbeNkklLyn0mgJgVB807xBDF8mxFKSbc3qN+EQe5o4rPYvMw6vk
         xmZc4w3T6md4XZOQWidbjVyRMPkJjOfDsiOHh+3ThCD9zRv1xj4t0+3k9XsNwPNv3nhM
         3kD+d6LU0XH3q/5jvKmzC9LFM1KbM+1t/NJvnffUYY9YeTAfusv0uQoDKVdbMTNlI0Lj
         dGUoSegwpnarnXjVN6dwSZzM82jVqjC02yQV719/Huh9fKMkJxgbHpuuNKXiP4QtBiMd
         oEjgd4ZJVpiM3DxCNoHGNold8sS2S1vCQphZCZjobhsvHp4tG96iJQKupKU3Zq6spj5u
         AQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631995; x=1688223995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLz9ii7hbYdBijJL4NgNzDpr7lZ4rrhjj/K/ef+kGHw=;
        b=DZpEWpgfhVosK/a5C5Vqw/cBHMUZNP2Ss3X695+XM55VAGXRnQb2akpv/WkQaZWWAB
         CwCKATS4+tG/MPopWIYqavb0ohjmV+KqqQOXYHVpm7AHXw9ZBaf2+7ihKUT7vODLfD1b
         7ePT8mvfU3n+jaQeVVDs4Im6/9971BeFjfiMGXUp6G2sJcma8zzHjlUXfNWsEgcrFVGY
         Ib2DRhdXtW2OgXQPT/pSVevo0iRB1QQp6S8nbxVL/Y3ig78/kPGUIveFEPKaqKe9ztmR
         ud7bIaSRmLzyrpBdZ5CcyoRfryDnloB71bZ2BRvX0/7ociQBYNPueJe/4Hx5VLRfQqbS
         NMOQ==
X-Gm-Message-State: AC+VfDzW+c5gqatT7XPdwe9Yuwd5TtZqkMBuvPzp776YLyaeJCvHQIC4
	4K6HiLmQY/8Gkffl9eTPyM1zJ5pu8SIGZQ==
X-Google-Smtp-Source: ACHHUZ7OhJ3syn23GIW6L01+lU67prAf6E2+LW+gkggEwplsWzdv3nSG7krDn0FSHbb66KPwFhZZ4Q==
X-Received: by 2002:a05:6a00:1741:b0:644:d220:64ac with SMTP id j1-20020a056a00174100b00644d22064acmr8175457pfc.2.1685631994935;
        Thu, 01 Jun 2023 08:06:34 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78552000000b0064d3446df87sm5175833pfn.183.2023.06.01.08.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:06:34 -0700 (PDT)
Message-ID: <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
Date: Thu, 1 Jun 2023 08:06:33 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: issue using virtual interface with iwd
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/1/23 6:17 AM, Michael John wrote:
> Hello,
> 
> I'm having an issue getting iwd to recognize a virtual interface.
> Using 'iw' I've created a virtual interface called wlan1:
> 
> iw dev wlan0 interface add wlan1 type __ap
> 
> This leaves me with the following two interfaces:
> 
> ~> iw dev
> phy#0
>          Interface wlan1
>                  ifindex 8
>                  wdev 0x5
>                  addr c0:ee:40:64:4a:1d
>                  type AP
>                  txpower 23.00 dBm
>          Interface wlan0
>                  ifindex 7
>                  wdev 0x4
>                  addr c0:ee:40:64:4a:1c
>                  type managed
>                  txpower 23.00 dBm
> 
> When running 'iwctl' to list devices and APs I'm not seeing wlan1.
> 
> ~> iwctl ap list
>                            Devices in Access Point Mode
> --------------------------------------------------------------------------------
>    Name                  Started
> --------------------------------------------------------------------------------
> No devices in access point mode available.
> 
> ~> iwctl device list
>                                      Devices
> --------------------------------------------------------------------------------
>    Name                  Address               Powered     Adapter     Mode
> --------------------------------------------------------------------------------
>    wlan0                 c0:ee:40:64:4a:1c     on          phy0        station
> 
> 
> When previously using 'wpa_supplicant' and 'NetworkManager' this virtual interface (wlan1) was usable in AP mode. The radio does support AP+STA mode.
> 
> ~> iw phy
>     ...
>          valid interface combinations:
>                   * #{ AP } <= 3, #{ managed, P2P-client, P2P-GO } <= 2,
>                     total <= 3, #channels <= 1
>                   * #{ IBSS } <= 1,
>                     total <= 1, #channels <= 1
>     ...

So this appears to me that you cannot do AP+STA with this adapater. You 
would need to see "AP" and "managed" in the same block e.g.:

#{ AP, managed, ...} <= 2

For example this adapter I have:

valid interface combinations:
* #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2,
total <= 2, #channels <= 1, STA/AP BI must match

If you could get the debug logs of IWD starting up I could take a look 
at those to see why the wlan1 interface wasn't brought up, but to me it 
looks like the adapter simply cannot support AP+STA modes at the same time.

Thanks,
James

> 
> So I'm left wondering if 'iwd' supports virtual interfaces created with the 'iw' utility and if so, what am I missing?
> 
> 
> Thanks,
> 
> Michael John
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
> 
