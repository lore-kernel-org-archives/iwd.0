Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50BE1429F
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQb9kJ/9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3aa0321b5so75898075ad.2
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704209811; x=1704814611; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zj/kYThZqP/X8+F1IaNAjgQ+a8P9l1HGhTI32xLrgcM=;
        b=dQb9kJ/9SqPYcIXgTuFY3LXWzMDvqADnJsEuSqnW3TH1CUZrE1tzUxR9rVgZqJ0ZC4
         0STpxKRdiekZVjMU54wuOY0kpy1ds4EdwQ9/vVHskOLkddjCkWEb5k06QlcbkOPWF/lH
         SOk+0bhEq1DGJ21sec16HCprDABTQWPbeiNYuiz0TB/W733dHoU0kPhUCjpGELvdxtFX
         Bigv77s7uEbLouOKbBsv6XWUl9gZ3x7Fd2S7Jo3b1swx+vvx9kulpfiDbfHZ0qzlB/A3
         PVAboR2AuCBR16qXjVYNEj7E0opBUl/wz03w7g4d8dO3q5+M7Nth3uMRybFekday8H0C
         8vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704209811; x=1704814611;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj/kYThZqP/X8+F1IaNAjgQ+a8P9l1HGhTI32xLrgcM=;
        b=ZIXvhtlly7WAHIQZYRPxyewPa3BidfpfSVbk44xQ51JaQunXrOQU+2QxkhpWBVdXjm
         swanXBg03HIMS2XD4t0dsxhWFPYezk0d7nRzpZW1T6nq/0SJcXWQAbc8pZdSgjme9+9h
         8wy1yayO9myt7/YCpHjNpomDa/baQPI2eLFwNqsPPeMcN/r1eV51nhMuKQB06FCpJ9kk
         yzEWUBnunda6X9R3OF28cp7/ce4jtJoYBB27VJ3eMXumUq52h/fgHhaqKC4E8mnOPFYV
         PuLig6XWz1CpcVFjvzhH0kZt6I9dfInbw002MtL4H5A4eJJ7xU7m31RaIpJInkZ8QSRs
         hOjQ==
X-Gm-Message-State: AOJu0Yz1GdjQYv1HoNK/vJLZ796ohAJVOAdtTZg1/dfQAYUdGl6FDxHp
	dw9wLdDAFwJuXs1HSmddTN8=
X-Google-Smtp-Source: AGHT+IHEU//hDthUDd/bcaIN6fZXFPIRTHc04CKQguvE6DLD5rPl+5eDL8MufD0+tU1zxBQgyk8c9g==
X-Received: by 2002:a17:902:e810:b0:1d4:cd18:f796 with SMTP id u16-20020a170902e81000b001d4cd18f796mr249621plg.76.1704209810789;
        Tue, 02 Jan 2024 07:36:50 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id ay10-20020a1709028b8a00b001d49607f8b5sm8677459plb.34.2024.01.02.07.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:36:50 -0800 (PST)
Message-ID: <b99e05cb-6661-4f57-8519-e88082975f1a@gmail.com>
Date: Tue, 2 Jan 2024 07:36:50 -0800
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <5f3370ee-14a4-4921-b337-944cf1d5aaf4@mclink.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mauro,

On 1/2/24 7:11 AM, Mauro Condarelli wrote:
> Thanks James,
> comments inline below.
>
> SNIP!
>
> On 1/2/24 15:07, Mauro Condarelli wrote:
>> On 1/2/24 14:01, James Prestwood wrote:
>>> I think there is more going on but for starters it appears whatever 
>>> app your using to scan is sending an invalid probe request frame. 
>>> This causes IWD to ignore it which seems like the reason you cant 
>>> even see the AP in the scans. I've attached a patch you can test, 
>>> but I'm not sure this is something we can really upstream since its 
>>> out of spec. The concerning IE is Extended capabilities, this is 
>>> something IWD actually uses and parses, so the fact there is a 
>>> duplicate and each one is different makes it impossible to know 
>>> which one we should use. The probe request is including multiple 
>>> entries for "Extended Capabilities" and "FILS Request Parameters 
>>> (tag 258)". With the patch applied, and some other modifications to 
>>> iwmon you can see two entries for these IEs:
>>>
>>>                     Extended Capabilities: len 10
>>>                         Capability: bit  2: Extended channel switching
>>>                         Capability: bit 17: WNM-Sleep mode
>>>                         Capability: bit 19: BSS transition
>>>                         Capability: bit 25: SSID list
>>>                         Capability: bit 46: WNM- Notification
>>>                         Capability: bit 62: Opmode Notification
>>>                         04 00 0a 02 00 40 00 40 80 
>>> 01                    .....@.@..
>>>                     Tag 258: len 2
>>>                         00 
>>> 12                                            ..
>>>                     Extended Capabilities: len 10
>>>                         Capability: bit 17: WNM-Sleep mode
>>>                         Capability: bit 19: BSS transition
>>>                         Capability: bit 25: SSID list
>>>                         Capability: bit 46: WNM- Notification
>>>                         00 00 0a 02 00 40 00 00 00 
>>> 01                    .....@....
>>>                     Tag 258: len 2
>>>                         00 ff
>>>
>>> If this patch doesn't resolve the issue could you re-run the test 
>>> and start iwmon at the very beginning, prior to starting IWD?
>> I'll do it ASAP, but it will take a bit of time since I'll have to 
>> compile from sources (I installed from standard Debian package).
> Done.
> Only change in behavior was smartphone could see `beelink`, but not to 
> connect to it (no password asked)
> This means now my two (standard) clients behave in the same way.

Ok, so I'm not seeing any request to even connect from the AP side of 
things. Since your clients aren't even asking for a password I suspect 
it thinks there is some issue with compatibility. You could try using 
hostapd with a very basic configuration and see if that works, then we 
can go from there:

hw_mode=g
channel=1
ssid=testssid

wpa=1
wpa_pairwise=TKIP
wpa_passphrase=secret123

>
> I also changed my start script as follows:
> -------------------------
> #!/bin/bash
>
> iwmon --write /tmp/iwmon.pcap >/tmp/iwmon.log 2>&1 &
> IWMON_PID=$!
> /usr/libexec/iwd -d >/tmp/iwd.log 2>&1 &
> IWD_PID=$!
>
> sleep 5
> iwctl device list
> iwctl device wlan0 set-property Mode ap
> iwctl ap wlan0 start-profile beelink
> iwctl ap wlan0 show
>
> mc
>
> kill $IWMON_PID
> kill $IWD_PID
>
> cd /tmp
> tar cJf iw.tar.xz iwmon.pcap iwmon.log iwd.log
> -------------------------
>
> I attach logs.
>
> Sorry being a continued nuisance.

No worries, its all part of the process. AP mode in IWD is still 
experimental, there are obviously kinks to work out still.

> Mauro
