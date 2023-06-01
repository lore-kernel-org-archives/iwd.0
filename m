Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC423DF
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 20:18:18 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-30789a4c537so1212306f8f.0
        for <iwd@lists.linux.dev>; Thu, 01 Jun 2023 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685650697; x=1688242697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MlX+a1otOL78/WuJP0zpaQHWyTWqjX/MnnhMFoai4g=;
        b=SOdT13wIpWqM+yGKaYF5DbzlqzEIP5F96Hoc0IgqHaxVjJ0yvuQtanGKSoLb7SVcQw
         xQL0LS2fzCTSgbkHobdE+I5oNGJ+JnISI8k4P7LwvIb/A0GYoxnF0tgBalRdmfKtvoz8
         QFnYWDqqqmwdQKz9S4ioGB0he8DS5KkwE190oOv5ekFxGVw27QUVjc2qMM9Nxo8GGjwY
         /0VyYMpywZCZrQ7Dnz7JfBbtpvItinYwPaz5m4U3ttgvyQIMpdHGcYwizWPSjVQ13W46
         WzEB1+lDVrMFES5B4dvaqFAE48Tfe7+lZ/05jUWvUqEyoq3R83AQfoHiSMCtTyPpbH3O
         4Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685650697; x=1688242697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MlX+a1otOL78/WuJP0zpaQHWyTWqjX/MnnhMFoai4g=;
        b=Zy8EPJ4jzKe6MXcsdwkOQiNPImAQMhN5d/KrYacpBlXN9Hiw/cYkduGo9D/aBK8I/C
         ydmUWbG1XiMICNqch5yL9qD4vaamdLviIrwn+ZHyDorM7ISFDEuf1BndSxMs7e7bu3s5
         3IcYdHZzp+xLBLeW1RYr85W+Yl/5bV7y1xeJVLzrviOEenNgXfl8r4R31G9FawkYP2Ow
         EhHYZVxauKLqTagELMKqDg8zXwQAIAhHsBdULaVIrh0LJi0i78aTuvHTpmfT+pNrKXZ0
         gfTrfFg/y//Qtrur9CuHNn4993axb08X0s79Ex+78ddeO4Xx4gOdW29fiVdJHZrxCphH
         WIjw==
X-Gm-Message-State: AC+VfDz/MyNWI2JeRFW2JzKCihA8c1EjLWDFDDeYjDPkOmmiJuBWzytz
	OnB7LKk3gAjQoHZD6/PSU9PmtG9EO8A=
X-Google-Smtp-Source: ACHHUZ4RAO2EJ9Ju+VWLQDxJBcsq9lo7+Hs1rK9FeKeQam9nIWy7QMwXZGAmWJKOPDeMvRKmEsOx4Q==
X-Received: by 2002:a5d:6a02:0:b0:30a:e378:76e with SMTP id m2-20020a5d6a02000000b0030ae378076emr2641325wru.64.1685650696875;
        Thu, 01 Jun 2023 13:18:16 -0700 (PDT)
Received: from [10.123.13.239] ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000114f00b0030af72bca98sm9132263wrx.103.2023.06.01.13.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 13:18:16 -0700 (PDT)
Message-ID: <7c72c879-98c1-2df3-e676-540ee1463cc9@gmail.com>
Date: Thu, 1 Jun 2023 13:18:13 -0700
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
 <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
 <17dd827c-a2de-b7ec-75de-99d0b17cf6f3@gmail.com>
 <BY3PR08MB7220AB646467DBCE1A4B7433AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <eba9839e-55ab-d532-c52f-c58cac465ea1@gmail.com>
 <CO1PR08MB7221B49078929FDBB79773B7AE499@CO1PR08MB7221.namprd08.prod.outlook.com>
 <0909f3d3-3ce0-cbe7-48f2-9b37d5ca4bbb@gmail.com>
 <BY3PR08MB72206FB8F6C0F2A34729731BAE499@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <BY3PR08MB72206FB8F6C0F2A34729731BAE499@BY3PR08MB7220.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/1/23 1:00 PM, Michael John wrote:
> Hi James,
> 
>> Hi Michael,
>>
>> <snip>
>>
>>>>
>>>>
>>>
>>> Thanks James, that allowed iwd to preserve and see wlan1 and recognize it as
>>> an AP.
>>>
>>> ~> iwctl device list
>>>                                       Devices
>>> --------------------------------------------------------------------------------
>>>     Name                  Address               Powered     Adapter     Mode
>>> --------------------------------------------------------------------------------
>>>     wlan1                 c0:ee:40:64:4a:1d     on          phy0        ap
>>>     wlan0                 c0:ee:40:64:4a:1c     on          phy0        station
>>>
>>> ~> iwctl ap list
>>>                             Devices in Access Point Mode
>>> --------------------------------------------------------------------------------
>>>     Name                  Started
>>> --------------------------------------------------------------------------------
>>>     wlan1                 no
>>>
>>>
>>> My last hurdle appears to be just bringing up an AP.
>>>
>>> ~> iwctl ap wlan1 start "testnet" test123456
>>> Argument type is wrong
>>
>> I'd need to see the debug logs, but this could be what others have
>> noticed where certain drivers don't like some of the recent AP mode
>> changes adding HT capabilities.
>>
>> Again, don't know for certain without logs, but you could try and work
>> around this potentially by using an AP profile:
>>
>> #file: /var/lib/iwd/ap/testnet.ap
>> [Security]
>> Passphrase=test123456
>>
>> [General]
>> DisableHT=true
>>
>> Then, you can start the AP:
>>
>> $ iwctl ap wlan1 start-profile testnet
>>
>>>
>>> - Michael
> 
> Here is some log information while using an AP profile.
> 
> ~> iwctl ap wlan1 start-profile testnet
> Argument type is wrong
> 
> ~> journalctl --no-pager -u iwd --since -5m
> -- Logs begin at Thu 2023-06-01 18:53:45 UTC, end at Thu 2023-06-01 18:54:19 UTC. --
> Jun 01 18:53:51 cm1sd iwd[8884]: src/agent.c:agent_register() agent register called
> Jun 01 18:53:51 cm1sd iwd[8884]: src/agent.c:agent_register() agent :1.84 path /agent/14661
> Jun 01 18:53:52 cm1sd iwd[8884]: src/ap.c:ap_validate_band_channel() AP using frequency 2437 and channel width 40MHz
> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 0000: -114
> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 0020: -114
> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 0040: -114
> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00a0: -114
> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00b0: -114
> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00c0: -114
> Jun 01 18:53:52 cm1sd iwd[8884]: START_AP failed: -22
> Jun 01 18:53:52 cm1sd iwd[8884]: src/agent.c:agent_disconnect() agent :1.84 disconnected
> Jun 01 18:53:52 cm1sd iwd[8884]: src/agent.c:agent_free() agent free 0x35ff98

Seems like DisableHT was not set correctly? With DisableHT=true the AP 
should not be using 40MHz channel width, it should use 20Mhz (no-HT).

> 
> Thanks,
> Michael
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
