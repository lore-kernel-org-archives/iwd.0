Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F91C82F1
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697322; cv=none; b=DotAGp4Fb441gttl1CAP6hAmH7bs2/9uuPsRM5XNXBm3ToCJNeiXTnsH2bGHkiDJM1a4THRvU11DN4SmoeGjPM40sNaMZ2lJZh+ijpx2MlBVWH05uCA8Tf1kn/8TzdCcdw9/4cVlZNTWsJJeWvhSVk9xc0LsbzRU97o7m5hiCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697322; c=relaxed/simple;
	bh=H/lZH5ujJxeVgng/dCpEBheD6BgsnQbH/WNDJSLW22Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrdV25U4ebiCd2YQ//XYVGAv+5cuqMxQfqLlRlvL9CmlzE05lYp5VpYfXqYECMFs8asQ2SNCXSdN+mKfcnEoIMN0LRJ40NCQuuscO866Pu5G8VylEzOjEcFZnQF2EtzBircKb78SxF/MtKMcpY3x3wEsOgB44M/Bma3QmNb+ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXkC3Y+M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXkC3Y+M"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c9978a221so78982625ad.1
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729697320; x=1730302120; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWUOahOv0Bf/rChAPYB9jLAyIsOzXydzpwoi/08iXSo=;
        b=NXkC3Y+MZN7c7H1nsKUMNRDuAhnJCMJgfXpFcniwtkH0NxIBkDlKQ0Kxy9ZLITu+eb
         d4OlAYXJe6kq9GDbiMNM2TDQU5H7Fk9GoEyEvb/HKbVOKY2J4Ycv/9xBCJWye1rqtVyp
         5b9dGajy9yTOcseXv60LvsKkLYm1GaxbBkHBfn3oSVEbHm0sO0m9OLuLMWHDw+TpFPna
         KoVfXDh1+AIPiUZi8K3TQQ9HlzpfXRu0yBUtfUbZCAWUN4/ox9eVTXuYoRG3qt8v+50k
         y5BF622/6NhrUXdAkKHJRut5s5fR7TReucUDQM7BEn/6v7K2VpGy4GQ7p4PhtDCwBSnz
         O+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697320; x=1730302120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWUOahOv0Bf/rChAPYB9jLAyIsOzXydzpwoi/08iXSo=;
        b=eQZB0O9qFkRUDUvtd4vUSs7Tc2bGlICVQWDyQBFcm3pDrZoBqfHxK5y0x8VqBQADpI
         P5VmYHGhOQm+mECf3LqqiI+WLmKlAWazpDYRGlAfYmsZ8Hsmo00WkWT5I6achDEN6Bbu
         +F82xzMi6BMpouTU9TWjuj787pe8M77/4ZSriTCWc4HdbD+5ghs7N2/twNl83ajT7Klj
         QNuluE7joAbo4Me7dpgTncnnYjZ84ZuEkZ6kAsKTgHcsOCfHSqH+rpe5zdE1SwhmdjFJ
         uh8n7Z9snWBYNPyVuFZ29iGd0pDjKqNUudjl+vyPnS63k7HT43ebSDKsifqhTmiYCE36
         wLhQ==
X-Gm-Message-State: AOJu0Yy6LR4pH51wgvhmFO34Tm/gQGXSF8Z7CeJpYxmVjEAmExMjrZHw
	sa/eu2qklvRKyRB2s++jnmOQxFanaizNPv9Fu0GcN7t6MRyLb8bd
X-Google-Smtp-Source: AGHT+IEPgh3a/gjhVQZpWbEcR420VrhdxVd3tjZpDTS+234AmUciAMQzGjd6rsWoNLlSzIcCA6YZKA==
X-Received: by 2002:a17:902:ced2:b0:20c:af07:a816 with SMTP id d9443c01a7336-20fa9e8f817mr43086225ad.31.1729697320067;
        Wed, 23 Oct 2024 08:28:40 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd48fsm58844035ad.129.2024.10.23.08.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:28:39 -0700 (PDT)
Message-ID: <60e609c8-7c83-4510-9a3b-706698705e1b@gmail.com>
Date: Wed, 23 Oct 2024 08:28:36 -0700
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
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <713f032a-a286-47f2-9729-5430e4675b59@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 10/23/24 8:22 AM, Martin Petzold wrote:
> Hi James,
>
> Am 23.10.24 um 15:22 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 10/23/24 5:19 AM, Martin Petzold wrote:
>>> Hi James,
>>>
>>> Am 23.10.24 um 14:13 schrieb James Prestwood:
>>>> Hi Martin,
>>>>
>>>> On 10/23/24 5:02 AM, Martin Petzold wrote:
>>>>> Hi Arend and James,
>>>>>
>>>>> Am 21.10.24 um 20:26 schrieb Arend van Spriel:
>>>>>> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
>>>>>>> Hi Arend,
>>>>>>>
>>>>>>>>
>>>>>>>> I have not seen patches for OWE in brcmfmac. Looking at the 
>>>>>>>> supported ciphers:
>>>>>>>
>>>>>>> OWE is an AKM.  It still uses CCMP/CMAC underneath.
>>>>>>
>>>>>> My bad. Always confused by those concepts.
>>>>>>
>>>>>>>>
>>>>>>>> Supported Ciphers:
>>>>>>>>   * WEP40 (00-0f-ac:1)
>>>>>>>>   * WEP104 (00-0f-ac:5)
>>>>>>>>   * TKIP (00-0f-ac:2)
>>>>>>>>   * CCMP-128 (00-0f-ac:4)
>>>>>>>>   * CMAC (00-0f-ac:6)
>>>>>>>>
>>>>>>>> The error message seems to match with the above.
>>>>>>>
>>>>>>> I've never seen support for OWE in brcmfmac mentioned. OWE 
>>>>>>> requires CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) 
>>>>>>> to derive the PMK, so iwd can't support it on FullMAC.
>>>>>>
>>>>>> I have never seen any mention of OWE either. Regarding 
>>>>>> CMD_EXTERNAL_AUTH support I recently posted patches on 
>>>>>> linux-wireless list as RFT. There has been zero feedback and so I 
>>>>>> assume also zero interest. In order to use CMD_EXTERNAL_AUTH the 
>>>>>> firmware needs to advertise "sae_ext" in fwcap debugfs file. So 
>>>>>> if Martin can check that, ie:
>>>>>>
>>>>>> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
>>>>>>
>>>>>>
>>>>> @James: Could please check the logs (PATCH WAS APPLIED):
>>>>>
>>>>> A. Initial boot and connect (device remained connected)
>>>>
>>>> On this run I'm seeing an agent connecting and issuing an explicit 
>>>> connect call rather than IWD autoconnecting. This is fine, and will 
>>>> create a new .open profile.
>>>>
>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_free() agent free 
>>>> 0xaaaadbf376a0
>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_register() agent 
>>>> register called
>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_register() agent 
>>>> :1.69 path /agent/1420
>>>> Okt 23 12:39:35 tavla iwd[383]: src/network.c:network_connect()
>>>>
>>>>> B. Reboot -> device does NOT connect
>>>>
>>>> This tells me you have no profile in /var/lib/iwd
>>>>
>>>>>
>>>>> -----
>>>>>
>>>>> tavla@tavla:~$ sudo ls -l /system/var/lib/iwd/
>>>>> insgesamt 4
>>>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>>>> tavla@tavla:~$ sudo cat /system/var/lib/iwd/XYZ-Gast.open
>>>>> tavla@tavla:~$
>>>>
>>>> IWD is looking in /var/lib/iwd as seen by:
>>>>
>>>> Okt 23 12:35:58 tavla iwd[383]: src/storage.c:storage_create_dirs() 
>>>> Using state directory /var/lib/iwd
>>>>
>>>> Not sure if you have /system/var/lib/iwd mounted there or what, but 
>>>> it seems IWD cannot find that profile. IWD will not autoconnect to 
>>>> a random open network without a profile. On your first boot you are 
>>>> forcing a connection which should generate a profile, but on the 
>>>> second boot no profile exists. So that is where I could check, 
>>>> where is the profile going? can you "ls" that directory on the 
>>>> _second_ boot to see if it exists?
>>> -----
>>> tavla@tavla:~$ sudo ls -l /var/lib/iwd/
>>> insgesamt 4
>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>> tavla@tavla:~$ sudo ls -l /system/var/lib/iwd/
>>> insgesamt 4
>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>> tavla@tavla:~$ sudo cat /system/var/lib/iwd/XYZ-Gast.open
>>> tavla@tavla:~$
>>> tavla@tavla:~$
>>> tavla@tavla:~$ iwctl known-networks list
>>>                                  Known Networks
>>> -------------------------------------------------------------------------------- 
>>>
>>>   Name                              Security     Hidden Last connected
>>> -------------------------------------------------------------------------------- 
>>>
>>>   XYZ-Gast                          open Oct 23, 11:39 AM
>>>
>>> tavla@tavla:~$ iwctl known-networks XYZ-Gast show
>>>                             Known Network: XYZ-Gast
>>> -------------------------------------------------------------------------------- 
>>>
>>>   Settable  Property Value
>>> -------------------------------------------------------------------------------- 
>>>
>>>             Name XYZ-Gast
>>> Hidden
>>>          *  AutoConnect yes
>>>
>>> tavla@tavla:~$
>>> tavla@tavla:~$ iwctl station wlan0 show
>>>                                  Station: wlan0
>>> -------------------------------------------------------------------------------- 
>>>
>>>   Settable  Property Value
>>> -------------------------------------------------------------------------------- 
>>>
>>>             Scanning no
>>>             State                 disconnected
>>>
>>> -----
>> I was barking up the wrong tree. I found a bug in the BSS selection 
>> specific to OWE transitional networks. I just sent an RFC patch to 
>> the list. Note, you will still need the earlier patches to disable 
>> OWE in order to force the connection to the open network. 
>
> Device connected after image upgrade (pre-existing configured network) 
> and then also connected after consecutive reboots. I have also tested 
> to forget the network, re-configure the network and then do some 
> reboots. I also tested manual disconnect and connect. Also tested 
> manual disconnect and waiting for auto-connect. Here I can't force any 
> roaming (not a mobile device). As I am not 100% confident, I will run 
> several more tests also in other environments.
>
> Do you need logs?
No, not if its working. I was able to reproduce the same situation in a 
simulated environment so I'm pretty confident the bug is fixed with 
respect to OWE/open networks.
>
> However, I still also have some issues with devices in a non-OWE 
> network. I am not really confident general connection and roaming is 
> behaving as it should. I have seen one disappearing today (no network 
> logs available), however that one did not have any of the three 
> patches. But this network is using WPA2-PSK with a single router as 
> far as I know. Does your last patch only target WPA3 and/or OWE 
> environments or also others?
The patches should only change behavior on OWE networks. As far as 
roaming that is again up to brcmfmac. IWD just gets notified when a roam 
occurred. With OWE disabled though I would expect roaming within open 
networks to work as well as with WPA2 as this is quite basic, but I 
can't really assume anything here. We would need to see logs if there 
was some issue here to know if it was brcmfmac or IWD not acting properly.
>
> I will upgrade all our devices in testing environments and then will 
> have to observe carefully...
>
> Nevertheless, thanks for your response and effort!
No worries, glad we at least got the OWE part hopefully figured out.
>
> Martin
>
