Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CE14F6E
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoYZVFuv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3f3ee00a2so32495155ad.3
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 06:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704206434; x=1704811234; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMPPZ9isJOyKmrCvD3NkxkhoXBxQ9ko/juAvZBp2cE8=;
        b=IoYZVFuvvHfpzqwZlEon30YVot6KFiJBLXPNoeSryixlEwN1hSJ9vTJY9DYjUOJdWA
         ieVolMdy8oJZ1metTMMH1yjHnjm6I0B47AmZvIiSioDuWlaDcZM0uyUt6GOQ5n+1iRAM
         OXTF9YmkT9xWAkZjc4ygqtS/Pgsw55NTxXbvur2k0uyFOID+6ByJmurXWY9zQ5LjJ7FQ
         v0i/lrhUaOYtUxb3ghrGq3ENZ4Lb45skqAphpxrTFOePBGezwPNIRWXfFyWuAE07Mc7t
         d+qjPyCaOM9BCQENswaJ1ZlivKa7TYOi/hjn/qynYsSMiUfPs1VJyXRrQTWZeN9EX8vI
         d6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704206434; x=1704811234;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMPPZ9isJOyKmrCvD3NkxkhoXBxQ9ko/juAvZBp2cE8=;
        b=xMoRUVixli/taaakg/k5AEpsVqRNFoG4deA86S3ALov+DQqQtgZlmbEO4hX6dpkeJW
         1gEeCdXFg7xXLWBKx91iWLXnTZ+hClCxLxzqo59p56+gypg0YLo0NLBAShJd51Fgezid
         3+LX63mJ3nezc1RfL12BX8j8ap8zspVrd+GN/N23tpALuy6ME8q2/nvw6Hgn0dDbcfDr
         WipFP52QSVI7uUmu2UJ5bCtYUmxK1xva5biebbzi1+jxmU+Ti7ueckZWZ633zteuVkXm
         nlG8H9OEuiFKqUAcOvmR9qwgvDyF2TG/Vg8santZK4NOddszhe2eyZmRzkAEP23gpqv3
         2h3A==
X-Gm-Message-State: AOJu0YztR08Nm+4r7+CwV0x7+QQOi1j+GjobEVgPtwnpLEq8ijsYFxJ/
	1WBIru2dObxgCcRU/YBPJASiEQxzSR0=
X-Google-Smtp-Source: AGHT+IHQklCP4AbQxdpJV2W2rnttxNWtC6CwIpIswwZYhqy1Cxe42nLMgJdgy5UHn0lG3OFPWsf1Qw==
X-Received: by 2002:a17:90b:400d:b0:28c:8f7a:2e20 with SMTP id ie13-20020a17090b400d00b0028c8f7a2e20mr3392797pjb.67.1704206434155;
        Tue, 02 Jan 2024 06:40:34 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id y31-20020a17090a53a200b0028649b84907sm29071385pjh.16.2024.01.02.06.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 06:40:33 -0800 (PST)
Message-ID: <bf00447d-9817-4bd9-ba67-149356d6ecd6@gmail.com>
Date: Tue, 2 Jan 2024 06:40:32 -0800
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <2aaed79f-9fae-4750-8e85-994a48a45da1@mclink.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mauro,

On 1/2/24 6:07 AM, Mauro Condarelli wrote:
> Thanks James,
> comments inline below.
>
> On 1/2/24 14:01, James Prestwood wrote:
>> Hi Mauro,
>>
>> On 1/1/24 4:34 PM, Mauro Condarelli wrote:
>>> Hi James,
>>> Thanks for the fast reply.
>>>
>>> Comments inline below.
>>>
>>> On 1/2/24 00:03, James Prestwood wrote:
>>>> Hi Mauro,
>>>>
>>>> On 1/1/24 11:26 AM, Mauro Condarelli wrote:
>>>>> Hi,
>>>>> I just installed `IWD version 2.3` on a small MiniPC (Beelink, if 
>>>>> it matters) sporting a
>>>>> `Intel Corporation Wireless 3165 (rev 81)` PCI Wireless adapter.
>>>>> O.S. is a fairly up-to-date "Debian GNU/Linux 12 (bookworm)"
>>>>> Installation was done via standard Debian package (`apt install iwd`)
>>>>> ======8<----------- SNIP
>>> I used the following script to reproducibly start IWD and friends:
>>> ---------------------------------
>>> root@lxd:~# cat ./start_iwd.sh
>>> #!/bin/bash
>>>
>>> /usr/libexec/iwd -d >/tmp/iwd.log 2>&1 &
>>> IWD_PID=$!
>>>
>>> sleep 5
>>> iwctl device list
>>> iwctl device wlan0 set-property Mode ap
>>> iwctl ap wlan0 start-profile beelink
>>> iwctl ap wlan0 show
>>>
>>> iwmon --write /tmp/iwmon.pcap >/tmp/iwmon.log 2>&1 &
>>> IWMON_PID=$!
>>>
>>> mc
>>>
>>> kill $IWMON_PID
>>> kill $IWD_PID
>>> ---------------------------------
>>>
>>> While shell was active I:
>>> - opened Fritz! `WLAN` app
>>>   - it took ~30s to see a `beelink` network apparently spanning 
>>> several channels
>>> - tried to connect from my desktop
>>>   - it did see a `beelink` AP a long time (>2m) after `WLAN` app saw 
>>> it.
>>>   - it tried several times to connect.
>>>   - it never succeeded.
>>>   - it didn't even ask for a passphrase.
>>> - tried to connect using my Android Phone (the ssame running `WLAN`.
>>>   - it never saw a `beelink` AP to attempt connection.
>>>
>>> I attach all logs I took.
>>> I changed password to "temp-password" so it can be shared as needed.
>>
>> I think there is more going on but for starters it appears whatever 
>> app your using to scan is sending an invalid probe request frame. 
>> This causes IWD to ignore it which seems like the reason you cant 
>> even see the AP in the scans. I've attached a patch you can test, but 
>> I'm not sure this is something we can really upstream since its out 
>> of spec. The concerning IE is Extended capabilities, this is 
>> something IWD actually uses and parses, so the fact there is a 
>> duplicate and each one is different makes it impossible to know which 
>> one we should use. The probe request is including multiple entries 
>> for "Extended Capabilities" and "FILS Request Parameters (tag 258)". 
>> With the patch applied, and some other modifications to iwmon you can 
>> see two entries for these IEs:
>>
>>                     Extended Capabilities: len 10
>>                         Capability: bit  2: Extended channel switching
>>                         Capability: bit 17: WNM-Sleep mode
>>                         Capability: bit 19: BSS transition
>>                         Capability: bit 25: SSID list
>>                         Capability: bit 46: WNM- Notification
>>                         Capability: bit 62: Opmode Notification
>>                         04 00 0a 02 00 40 00 40 80 
>> 01                    .....@.@..
>>                     Tag 258: len 2
>>                         00 
>> 12                                            ..
>>                     Extended Capabilities: len 10
>>                         Capability: bit 17: WNM-Sleep mode
>>                         Capability: bit 19: BSS transition
>>                         Capability: bit 25: SSID list
>>                         Capability: bit 46: WNM- Notification
>>                         00 00 0a 02 00 40 00 00 00 
>> 01                    .....@....
>>                     Tag 258: len 2
>>                         00 ff
>>
>> If this patch doesn't resolve the issue could you re-run the test and 
>> start iwmon at the very beginning, prior to starting IWD?
> I'll do it ASAP, but it will take a bit of time since I'll have to 
> compile from sources (I installed from standard Debian package).
>
> Notice I'm not using anything "strange" for scans:
> - normal Debian Sid Network Manager applet from desktop (which sees 
> "beelink")
> - normal Android phone `WiFi` Settings from phone (MIUI 12.0.3 on 
> POCOPHONE F1, if relevant) (does *not* see "beelink")
> Both are working as expected with several other Access Points.
> It seems (to my limited insight) unlikely they're sending invalid 
> probe requests.

I'll need to look more at the spec to determine if this is "illegal" 
(for lack of a better term) to duplicate these IEs. There are some IEs 
that we allow duplicates of (which you can see in that patch). With a 
simple search I cant find anything in the spec that disallows duplicates 
specifically, but we have this comment in IWD:

"Tag found, make sure no duplicates present unless allowed"

Denis, any idea where that comes from off the top of your head?

Thanks,

James

