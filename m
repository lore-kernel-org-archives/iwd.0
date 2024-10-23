Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D311C578C
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697885; cv=none; b=sh/2loNTMTbBH41LAFH2CjyZ/ZYvSPxQcu4bdXmRDhm79W9Qz/nEuv3kOORi5SNH9PBD+FhjXLmgt8mk2Jo3sBmc60LzCvxblvFQWPUuP+gxE/emSnFWg71iyfybImhG8nelwOWY0Q7gtMtDyhvWQl7BbX1n0BfU8v4QamRrxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697885; c=relaxed/simple;
	bh=Gq24LVN32/SCXCt4vj85bYfUKudUL9kCDfY3H7f/QWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKmcYnm39RyZbQjPVNawYe8BmxkO6h2StdqMKi6QQhniYiSHJFSZXI/ikrIpIhYoiev/y4K83hsQmLK6XTXfEnRaZd3HshnM/YJDrQti7pKndS7WJ3uCirHmjnWynQtj+ObJ93yfhshbYVGSK2MUu9N3LYPKPfjEYM0QGGfExzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=ioGtaCzc; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="ioGtaCzc"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4XYY8k15s9zDtQM;
	Wed, 23 Oct 2024 17:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729697878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ri97mb+lyt7xQYxgplNyDmNhjlP85jdm8Ml1wB2XO8=;
	b=ioGtaCzch6ql43UbzFS4oTqJAk11hAwA+RGp/0VUwuJpiUJ730+LR8gZYu8OVWEiB6cYaS
	t3btZ7khBcZ36CD/v2/Mj+vb3MRIiSUEj4+kpHLtusPwUqSvhz5Y/63Rs6E2mUzIX6c+z4
	aakBET4cQrZJ/RdYRxBRmymgwJAdBvFQbTz0O8+kDbNy2W38iHGkeCr4GaBFfF6X1fDHaO
	oPHq6gpPo1pKiS2S+7JX7GlPpFCI6fm1Bd9t7MGDRhiRZLSjnbWlpJvcM23+wucKcm7nj6
	uTjYjxJhjVF7cq6C5+24SDPGUT4omLbx/O1inUBNjAjbJeFzs/Uh6jFgkG+nXg==
Message-ID: <19897b0d-ec6f-48ca-8c1b-4b8fd68ff166@tavla.de>
Date: Wed, 23 Oct 2024 17:37:56 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
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
 <d5c72fb3-5a2a-4167-ab06-a41247ae5f3c@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <d5c72fb3-5a2a-4167-ab06-a41247ae5f3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XYY8k15s9zDtQM

Hi James,

Am 23.10.24 um 17:30 schrieb James Prestwood:
>
> On 10/23/24 8:27 AM, Martin Petzold wrote:
>> Am 23.10.24 um 17:22 schrieb Martin Petzold:
>>
>>> Hi James,
>>>
>>> Am 23.10.24 um 15:22 schrieb James Prestwood:
>>>> Hi Martin,
>>>>
>>>> On 10/23/24 5:19 AM, Martin Petzold wrote:
>>>>> Hi James,
>>>>>
>>>>> Am 23.10.24 um 14:13 schrieb James Prestwood:
>>>>>> Hi Martin,
>>>>>>
>>>>>> On 10/23/24 5:02 AM, Martin Petzold wrote:
>>>>>>> Hi Arend and James,
>>>>>>>
>>>>>>> Am 21.10.24 um 20:26 schrieb Arend van Spriel:
>>>>>>>> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
>>>>>>>>> Hi Arend,
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I have not seen patches for OWE in brcmfmac. Looking at the 
>>>>>>>>>> supported ciphers:
>>>>>>>>>
>>>>>>>>> OWE is an AKM.  It still uses CCMP/CMAC underneath.
>>>>>>>>
>>>>>>>> My bad. Always confused by those concepts.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Supported Ciphers:
>>>>>>>>>>   * WEP40 (00-0f-ac:1)
>>>>>>>>>>   * WEP104 (00-0f-ac:5)
>>>>>>>>>>   * TKIP (00-0f-ac:2)
>>>>>>>>>>   * CCMP-128 (00-0f-ac:4)
>>>>>>>>>>   * CMAC (00-0f-ac:6)
>>>>>>>>>>
>>>>>>>>>> The error message seems to match with the above.
>>>>>>>>>
>>>>>>>>> I've never seen support for OWE in brcmfmac mentioned. OWE 
>>>>>>>>> requires CMD_AUTHENTICATE / CMD_ASSOCIATE (or 
>>>>>>>>> CMD_EXTERNAL_AUTH) to derive the PMK, so iwd can't support it 
>>>>>>>>> on FullMAC.
>>>>>>>>
>>>>>>>> I have never seen any mention of OWE either. Regarding 
>>>>>>>> CMD_EXTERNAL_AUTH support I recently posted patches on 
>>>>>>>> linux-wireless list as RFT. There has been zero feedback and so 
>>>>>>>> I assume also zero interest. In order to use CMD_EXTERNAL_AUTH 
>>>>>>>> the firmware needs to advertise "sae_ext" in fwcap debugfs 
>>>>>>>> file. So if Martin can check that, ie:
>>>>>>>>
>>>>>>>> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
>>>>>>>>
>>>>>>>>
>>>>>>> @James: Could please check the logs (PATCH WAS APPLIED):
>>>>>>>
>>>>>>> A. Initial boot and connect (device remained connected)
>>>>>>
>>>>>> On this run I'm seeing an agent connecting and issuing an 
>>>>>> explicit connect call rather than IWD autoconnecting. This is 
>>>>>> fine, and will create a new .open profile.
>>>>>>
>>>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_free() agent 
>>>>>> free 0xaaaadbf376a0
>>>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_register() 
>>>>>> agent register called
>>>>>> Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_register() 
>>>>>> agent :1.69 path /agent/1420
>>>>>> Okt 23 12:39:35 tavla iwd[383]: src/network.c:network_connect()
>>>>>>
>>>>>>> B. Reboot -> device does NOT connect
>>>>>>
>>>>>> This tells me you have no profile in /var/lib/iwd
>>>>>>
>>>>>>>
>>>>>>> -----
>>>>>>>
>>>>>>> tavla@tavla:~$ sudo ls -l /system/var/lib/iwd/
>>>>>>> insgesamt 4
>>>>>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>>>>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>>>>>> tavla@tavla:~$ sudo cat /system/var/lib/iwd/XYZ-Gast.open
>>>>>>> tavla@tavla:~$
>>>>>>
>>>>>> IWD is looking in /var/lib/iwd as seen by:
>>>>>>
>>>>>> Okt 23 12:35:58 tavla iwd[383]: 
>>>>>> src/storage.c:storage_create_dirs() Using state directory 
>>>>>> /var/lib/iwd
>>>>>>
>>>>>> Not sure if you have /system/var/lib/iwd mounted there or what, 
>>>>>> but it seems IWD cannot find that profile. IWD will not 
>>>>>> autoconnect to a random open network without a profile. On your 
>>>>>> first boot you are forcing a connection which should generate a 
>>>>>> profile, but on the second boot no profile exists. So that is 
>>>>>> where I could check, where is the profile going? can you "ls" 
>>>>>> that directory on the _second_ boot to see if it exists?
>>>>> -----
>>>>> tavla@tavla:~$ sudo ls -l /var/lib/iwd/
>>>>> insgesamt 4
>>>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>>>> tavla@tavla:~$ sudo ls -l /system/var/lib/iwd/
>>>>> insgesamt 4
>>>>> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
>>>>> drwx------ 2 root root 4096  4. Apr 2024  hotspot
>>>>> tavla@tavla:~$ sudo cat /system/var/lib/iwd/XYZ-Gast.open
>>>>> tavla@tavla:~$
>>>>> tavla@tavla:~$
>>>>> tavla@tavla:~$ iwctl known-networks list
>>>>>                                  Known Networks
>>>>> -------------------------------------------------------------------------------- 
>>>>>
>>>>>   Name                              Security     Hidden Last 
>>>>> connected
>>>>> -------------------------------------------------------------------------------- 
>>>>>
>>>>>   XYZ-Gast                          open Oct 23, 11:39 AM
>>>>>
>>>>> tavla@tavla:~$ iwctl known-networks XYZ-Gast show
>>>>>                             Known Network: XYZ-Gast
>>>>> -------------------------------------------------------------------------------- 
>>>>>
>>>>>   Settable  Property Value
>>>>> -------------------------------------------------------------------------------- 
>>>>>
>>>>>             Name XYZ-Gast
>>>>> Hidden
>>>>>          *  AutoConnect yes
>>>>>
>>>>> tavla@tavla:~$
>>>>> tavla@tavla:~$ iwctl station wlan0 show
>>>>>                                  Station: wlan0
>>>>> -------------------------------------------------------------------------------- 
>>>>>
>>>>>   Settable  Property Value
>>>>> -------------------------------------------------------------------------------- 
>>>>>
>>>>>             Scanning no
>>>>>             State                 disconnected
>>>>>
>>>>> -----
>>>> I was barking up the wrong tree. I found a bug in the BSS selection 
>>>> specific to OWE transitional networks. I just sent an RFC patch to 
>>>> the list. Note, you will still need the earlier patches to disable 
>>>> OWE in order to force the connection to the open network. 
>>>
>>> Device connected after image upgrade (pre-existing configured 
>>> network) and then also connected after consecutive reboots. I have 
>>> also tested to forget the network, re-configure the network and then 
>>> do some reboots. I also tested manual disconnect and connect. Also 
>>> tested manual disconnect and waiting for auto-connect. Here I can't 
>>> force any roaming (not a mobile device). As I am not 100% confident, 
>>> I will run several more tests also in other environments.
>> btw. it did NOT auto re-connect if I disconnected manually (state 
>> "degraded" in networkctl). I assume this is correct, if it was forced 
>> to disconnect.
> I'm not familiar with networkctl specifically, but if you issue a 
> Disconnect DBus call to IWD that disables autoconnect until you 
> manually connect again.
Thanks. I used iwctl for these tests. networkctl was just used for 
confirmation of the status as we use that information for general link 
status.
