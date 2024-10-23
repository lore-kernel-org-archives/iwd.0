Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E192914
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697422; cv=none; b=QLn1DW/foiC4BMtwidbUKWeKaLRCfyjgBYCt/GXW+nYAvjX13XWMXv+ZgY/TwQTet7jZhWeZUk9KQcYx9GSk32c+hjDavWdRZMzSsVH+DT3qakDzj/LD78QYEiPg6spapTf5J2Crw7j630vwlMnwEIEVHK2jO51pWYv6P8PEARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697422; c=relaxed/simple;
	bh=fwkEzOR8Uv9RZuiqVCm662TOGvBtaKbfURK5vTMxO8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1PM2MZZoyPVkgmzU43Jvsehx6a8xg5bzKAQMmbLe7Sg4vwPmRQdhNAGnjFOxDQXmtt12jLNZB30d7V2NgcqITf/MZMOnHgzuVsZ2xa0OD7cJMyCsD0+uk2lto0ilLzYG5DkdJnkx8WK8ApH0Qwv9i834HgUOIY0koKr/4WA+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUQqflu6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUQqflu6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb47387ceso63128265ad.1
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729697420; x=1730302220; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YtFkm91LpUBtByOwuaTCHov3bW7JlD7+oFprJ3tAes=;
        b=nUQqflu6frSKqzfaLBQEA5GOMwah5nYzAMIhj7QIGA/lVRrOxUMAeZSXHqhvjYxxYM
         wB643q2fqiRb2Y0Qv23LXSvQCidv4TmAo9dgKpg8Mo9jRQ/WtvxGoqQHpBvlsA9lJztw
         7nz/qoukrxLFUy91oTwrj+urxqwho116T5hzaBDPnhdZQX4CrHrgg9DyNQG80M/gOP5A
         fQgibPXO5xAklwbdAt52Ktl0SIs8/8Z534Fu6EdgfWvjDCUyJgQWG1Q5vjmXxc/MbryJ
         m3JgztfC3Oivt+GAS4ceC/+iWNlK3TN7dqQtVOGfofmQz5BE/W3nhYVAf7j1iK705Gw7
         Yp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697420; x=1730302220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YtFkm91LpUBtByOwuaTCHov3bW7JlD7+oFprJ3tAes=;
        b=uQHdlKBs3oUUb5ZbRP8cGAtdnY66cjMbCkbTVUlkR+RiktQZK1UbF39S3YX1t062/M
         uFsnwbK3JHhcYvFqtqYw0a69mSH/U8RVtF2rnJ3Q2cOwfDe9GtiSv6Mad4NwKijXkRYS
         ZBqM/eeJv6yqUGpU0YoPsLnDae/mCfLZXcCPdyX9eHKhmM9Ka81BlVx/p3gyNBsAZNQ2
         nMnjUVYqEBsbXqysR4gP2+pGX59ddCmjM+y/XeJEXfRdwLMLAAv31f5AQ1yxGPdow8mw
         3/rzxszimVfY6x0l0gWH+A5AXk9iN7PFuH6vi0FLPSb3i4Pmtk5cd+tIHbN7EkDRDEdC
         BO5g==
X-Gm-Message-State: AOJu0YwIOqzAUazKc1FTNywoIUenOQw2GfPMhCatV1YyAba54mTk3Fru
	zx75vk3zeAnfpdLISRf9bzKBKuCpwgLgY4jjIp15sSpxvIULfvFM
X-Google-Smtp-Source: AGHT+IGy7pgRMLHDHfpk24AYWzjdHwWVSOUjHybvg9cYMn/yGMY8+sb0tMej50bTL6z/EaXArzLqyw==
X-Received: by 2002:a17:902:e883:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-20fa9de904amr41058335ad.1.1729697419964;
        Wed, 23 Oct 2024 08:30:19 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5e2029d29sm2963041a91.1.2024.10.23.08.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:30:19 -0700 (PDT)
Message-ID: <d5c72fb3-5a2a-4167-ab06-a41247ae5f3c@gmail.com>
Date: Wed, 23 Oct 2024 08:30:16 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
 <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
 <e5626359-2b7c-4161-9aa7-7fd7133ec390@tavla.de>
 <77fc14d0-96bc-465c-b425-111ba4310c86@gmail.com>
 <c2c8262e-9a40-4e2f-aa50-458373639dcb@tavla.de>
 <21d3d993-f753-4b01-98f1-5a9259cfb5a3@gmail.com>
 <713f032a-a286-47f2-9729-5430e4675b59@tavla.de>
 <f5a8eb0c-5cbc-4f3e-89c0-6704ae7d5ee1@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f5a8eb0c-5cbc-4f3e-89c0-6704ae7d5ee1@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/23/24 8:27 AM, Martin Petzold wrote:
> Am 23.10.24 um 17:22 schrieb Martin Petzold:
>
>> Hi James,
>>
>> Am 23.10.24 um 15:22 schrieb James Prestwood:
>>> Hi Martin,
>>>
>>> On 10/23/24 5:19 AM, Martin Petzold wrote:
>>>> Hi James,
>>>>
>>>> Am 23.10.24 um 14:13 schrieb James Prestwood:
>>>>> Hi Martin,
>>>>>
>>>>> On 10/23/24 5:02 AM, Martin Petzold wrote:
>>>>>> Hi Arend and James,
>>>>>>
>>>>>> Am 21.10.24 um 20:26 schrieb Arend van Spriel:
>>>>>>> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
>>>>>>>> Hi Arend,
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I have not seen patches for OWE in brcmfmac. Looking at the 
>>>>>>>>> supported ciphers:
>>>>>>>>
>>>>>>>> OWE is an AKM.  It still uses CCMP/CMAC underneath.
>>>>>>>
>>>>>>> My bad. Always confused by those concepts.
>>>>>>>
>>>>>>>>>
>>>>>>>>> Supported Ciphers:
>>>>>>>>>   * WEP40 (00-0f-ac:1)
>>>>>>>>>   * WEP104 (00-0f-ac:5)
>>>>>>>>>   * TKIP (00-0f-ac:2)
>>>>>>>>>   * CCMP-128 (00-0f-ac:4)
>>>>>>>>>   * CMAC (00-0f-ac:6)
>>>>>>>>>
>>>>>>>>> The error message seems to match with the above.
>>>>>>>>
>>>>>>>> I've never seen support for OWE in brcmfmac mentioned. OWE 
>>>>>>>> requires CMD_AUTHENTICATE / CMD_ASSOCIATE (or 
>>>>>>>> CMD_EXTERNAL_AUTH) to derive the PMK, so iwd can't support it 
>>>>>>>> on FullMAC.
>>>>>>>
>>>>>>> I have never seen any mention of OWE either. Regarding 
>>>>>>> CMD_EXTERNAL_AUTH support I recently posted patches on 
>>>>>>> linux-wireless list as RFT. There has been zero feedback and so 
>>>>>>> I assume also zero interest. In order to use CMD_EXTERNAL_AUTH 
>>>>>>> the firmware needs to advertise "sae_ext" in fwcap debugfs file. 
>>>>>>> So if Martin can check that, ie:
>>>>>>>
>>>>>>> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
>>>>>>>
>>>>>>>
>>>>>> @James: Could please check the logs (PATCH WAS APPLIED):
>>>>>>
>>>>>> A. Initial boot and connect (device remained connected)
>>>>>
>>>>> On this run I'm seeing an agent connecting and issuing an explicit 
>>>>> connect call rather than IWD autoconnecting. This is fine, and 
>>>>> will create a new .open profile.
>>>>>
>>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_free() agent 
>>>>> free 0xaaaadbf376a0
>>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_register() agent 
>>>>> register called
>>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_register() agent 
>>>>> :1.69 path /agent/1420
>>>>> Okt 23 12:39:35 tavla iwd[383]: src/network.c:network_connect()
>>>>>
>>>>>> B. Reboot -> device does NOT connect
>>>>>
>>>>> This tells me you have no profile in /var/lib/iwd
>>>>>
>>>>>>
>>>>>> -----
>>>>>>
>>>>>> tavla@tavla:~$ sudo ls -l /system/var/lib/iwd/
>>>>>> insgesamt 4
>>>>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>>>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>>>>> tavla@tavla:~$ sudo cat /system/var/lib/iwd/XYZ-Gast.open
>>>>>> tavla@tavla:~$
>>>>>
>>>>> IWD is looking in /var/lib/iwd as seen by:
>>>>>
>>>>> Okt 23 12:35:58 tavla iwd[383]: 
>>>>> src/storage.c:storage_create_dirs() Using state directory 
>>>>> /var/lib/iwd
>>>>>
>>>>> Not sure if you have /system/var/lib/iwd mounted there or what, 
>>>>> but it seems IWD cannot find that profile. IWD will not 
>>>>> autoconnect to a random open network without a profile. On your 
>>>>> first boot you are forcing a connection which should generate a 
>>>>> profile, but on the second boot no profile exists. So that is 
>>>>> where I could check, where is the profile going? can you "ls" that 
>>>>> directory on the _second_ boot to see if it exists?
>>>> -----
>>>> tavla@tavla:~$ sudo ls -l /var/lib/iwd/
>>>> insgesamt 4
>>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>>> tavla@tavla:~$ sudo ls -l /system/var/lib/iwd/
>>>> insgesamt 4
>>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>>> tavla@tavla:~$ sudo cat /system/var/lib/iwd/XYZ-Gast.open
>>>> tavla@tavla:~$
>>>> tavla@tavla:~$
>>>> tavla@tavla:~$ iwctl known-networks list
>>>>                                  Known Networks
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>>   Name                              Security     Hidden Last connected
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>>   XYZ-Gast                          open Oct 23, 11:39 AM
>>>>
>>>> tavla@tavla:~$ iwctl known-networks XYZ-Gast show
>>>>                             Known Network: XYZ-Gast
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>>   Settable  Property Value
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>>             Name XYZ-Gast
>>>> Hidden
>>>>          *  AutoConnect yes
>>>>
>>>> tavla@tavla:~$
>>>> tavla@tavla:~$ iwctl station wlan0 show
>>>>                                  Station: wlan0
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>>   Settable  Property Value
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>>             Scanning no
>>>>             State                 disconnected
>>>>
>>>> -----
>>> I was barking up the wrong tree. I found a bug in the BSS selection 
>>> specific to OWE transitional networks. I just sent an RFC patch to 
>>> the list. Note, you will still need the earlier patches to disable 
>>> OWE in order to force the connection to the open network. 
>>
>> Device connected after image upgrade (pre-existing configured 
>> network) and then also connected after consecutive reboots. I have 
>> also tested to forget the network, re-configure the network and then 
>> do some reboots. I also tested manual disconnect and connect. Also 
>> tested manual disconnect and waiting for auto-connect. Here I can't 
>> force any roaming (not a mobile device). As I am not 100% confident, 
>> I will run several more tests also in other environments.
> btw. it did NOT auto re-connect if I disconnected manually (state 
> "degraded" in networkctl). I assume this is correct, if it was forced 
> to disconnect.
I'm not familiar with networkctl specifically, but if you issue a 
Disconnect DBus call to IWD that disables autoconnect until you manually 
connect again.
