Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945E230995
	for <iwd@lists.linux.dev>; Tue, 12 Nov 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413609; cv=none; b=RP8pKvn7q5GTAz4eBqrRThleKpEVhYjRdrtNxa3gb6BMiobDkFVNdX6T6R+/ZpXGlEq3bwZK5fs3NleSS+IY+IHfAqRQIZzoix9g9ZRA8IzEJcbOAzqAlyMILtlodjw4KFe69xFHy/eY8aUDBrZIMA3et+teDLReD1PzW1FpN3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413609; c=relaxed/simple;
	bh=7Efrw1bzc12Kcq/ZMJDuLdyxVBnxjVIrz7oUQ8J639s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjvxbCO+P1PrQsw0SPUf5+2IPnFyheogOtCUj6y6bwn+IBvOlcMlIueUhCaHTUSXySK/9FumBoz9qQoahj5AXjEDAoH6ZqJpEmqjjRFdZO5/xEzOXLKuXpASUHs0ZobWwfP01VKXcfafy3uoH6r7lpsUwEfXYrBQ+9kM4P3nMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz8rt52U; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz8rt52U"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46094b68e30so44405481cf.0
        for <iwd@lists.linux.dev>; Tue, 12 Nov 2024 04:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731413606; x=1732018406; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdtnOfefPjkPSBUNIjo4Y2TJFPdT84CEbbChdMCyRtA=;
        b=Qz8rt52Uv4gMyDMis1mYS6bRNZLX6ExuQa7JEIexKwII0EdjhfZkcdpaGhHDiOTdcc
         TqJjR4F+Ty7k+cuiSTpX0YEpB6dwihR0c2lpn55YY1te8V+N7kxYJiVjZF0xOnCOQq1D
         BudzbJp5wFmS60lwki7yeXTzzpn9IZTCn4eKzY9GewknPiTJpgEalcEGTf5I5VYQqViM
         vWNAhHjN/GHSJqZXdlWapTDjH2SO82BZpC6BzP+tQFCVDabqwql+UWrAKmL0JHcoD/Ut
         7ejZED3DvF1uFgdBNB4t0PiOyOcOTbF+4u+g+0L3/D6cwlIa6MxKO2kF+3GSqqruX14B
         2f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731413606; x=1732018406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdtnOfefPjkPSBUNIjo4Y2TJFPdT84CEbbChdMCyRtA=;
        b=WjXgwbElxInqBecsbv2oYinoZDSCnNl3Jp7cLRUlxMvwRCX+7TWaGLOB3Dnq3tRwRy
         pzjVxXP23KMOeRdjhn6LPxOE5tE5e3xtM2du5G9mnc+/NGZgl3er0Tr6DCh2j7UJOpxV
         RUwjLe2k9jiVPJCNhe7lWs4nzYnpl8RPbnnQaDra2/lNZZzBXJ2GNhOqvRaWM/JMjYPs
         +bq4LjiufFSBROjy5Dp4Co2DicxpyVTo5YrYswFPZbDyMCKfb5gahDBnGVMB/b7nNccd
         FNvYcEcrgzmaBle4ju86srt76f352OPXDPtYPSLIBKVXvUAiHXSFG+qjYg3XBk+but69
         HvDw==
X-Gm-Message-State: AOJu0Yw9ht4ZjvOdMkbOA3WuRqRdooHdJ4M3N00t7RDasU1y9e8h6RVN
	W9CbJH6qPnSDBaYZU6shBPxP7LNhyaJP8UqSaI6OUXlT7fQpJ7g0Rckw1Q==
X-Google-Smtp-Source: AGHT+IFF0X1M222fxu/3v2n+7F+1GkWq1afqubgbwe5Sn5+k3kZj7zIo32Eh9/lKLrHckhMDiLmnbw==
X-Received: by 2002:a05:622a:189e:b0:462:c14f:d13f with SMTP id d75a77b69052e-4630940f470mr273473001cf.41.1731413606069;
        Tue, 12 Nov 2024 04:13:26 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff4783f1sm74299111cf.51.2024.11.12.04.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:13:25 -0800 (PST)
Message-ID: <a2ef307c-e0a9-438f-9bc4-1076b7bc5c1c@gmail.com>
Date: Tue, 12 Nov 2024 04:13:23 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev, Arend Van Spriel <arend.vanspriel@broadcom.com>
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
 <57826e6a-8466-4e45-8906-6cb15968bcc8@tavla.de>
 <e19e7527-9cc1-4c84-95ac-dcb39f836d58@gmail.com>
 <78437e50-e6b1-4965-bd03-776fcf3c9801@tavla.de>
 <a64c4733-9011-448c-ab75-8916ff339ac4@gmail.com>
 <f9ca5733-7cda-4494-8b6d-7a4de4157da2@tavla.de>
 <f489d856-c788-47c5-8739-325a11d7ff42@gmail.com>
 <2d245329-365a-42fa-91d3-5f4da7ab846f@tavla.de>
 <49b9d8b9-2769-4c65-8f10-4ffafc822885@gmail.com>
 <43124b6c-cb86-4ac3-b632-01ed9322d685@gmail.com>
 <cadf648a-2bea-4802-951f-2e3267473704@tavla.de>
 <7fa8c348-9834-4a63-a700-eb3117c4ae89@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <7fa8c348-9834-4a63-a700-eb3117c4ae89@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 11/12/24 1:15 AM, Martin Petzold wrote:
> Dear James,
>
> Am 05.11.24 um 16:16 schrieb Martin Petzold:
>> Dear James, dear Arend,
>>
>> Am 05.11.24 um 14:14 schrieb James Prestwood:
>>> Hi Martin,
>>>
>>> On 11/4/24 3:20 PM, James Prestwood wrote:
>>>> Hi Martin,
>>>>
>>>> On 11/4/24 2:42 PM, Martin Petzold wrote:
>>>>> Dear James,
>>>>>
>>>>> Am 04.11.24 um 13:36 schrieb James Prestwood:
>>>>>>
>>>>>> On 11/3/24 3:13 PM, Martin Petzold wrote:
>>>>>>> Dear James,
>>>>>>>
>>>>>>> Am 25.10.24 um 17:17 schrieb James Prestwood:
>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I open a new thread for this one: During the last weeks 
>>>>>>>>>>>>>>>> I have seen connection losses for 30+ minutes, 
>>>>>>>>>>>>>>>> sometimes even hours or just now even forever (IWD HEAD 
>>>>>>>>>>>>>>>> with v2 OWE / BSS selection patches). Driver is 
>>>>>>>>>>>>>>>> brcmfmac (NXP 6.1.36 kernel) and chip is BCM4339 (Laird 
>>>>>>>>>>>>>>>> LWB5).
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> It happens in a) single router environment (WPA2-PSK; 
>>>>>>>>>>>>>>>> Touchstone TG3442DE), and b) router + repeater 
>>>>>>>>>>>>>>>> environment (WPA2 CCMP; Fritz!Box + Fritz!Repeater), 
>>>>>>>>>>>>>>>> and maybe also in the WPA3 OWE Transition network 
>>>>>>>>>>>>>>>> (yesterday lost a connection again).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network 
>>>>>>>>>>>>>>> (with roaming). However, now they don't disappear all 
>>>>>>>>>>>>>>> after a shorter while. It seems to be later.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) 
>>>>>>>>>>>>>>> network. It is confirmed here on router side, that the 
>>>>>>>>>>>>>>> device is disconnected. Since more than a day.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> We can't do anything without logs. If you suspect its the 
>>>>>>>>>>>>>> blacklist you can lower the blacklist time down in 
>>>>>>>>>>>>>> main.conf:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> [
>>>>>>>
>>>>>>> I am still losing devices. Sometimes they come back again, but 
>>>>>>> mostly do not re-connect. I have observed the following:
>>>>>>>
>>>>>>> - Connection exists for several hours until about one day, or 
>>>>>>> two. Then gone for several hours or mostly forever.
>>>>>>> - For FritzBox+FritzRepeater I have seen the connection coming 
>>>>>>> back after like a day (here connection loss was also confirmed 
>>>>>>> on router side!)
>>>>>>> - For the Aruba enterprise environment the connection never came 
>>>>>>> back (until now no AP logs - waiting for an answer)
>>>>>>> - After reboot the connection comes back
>>>>>>> - It occurs only in an environment with multiple APs with same 
>>>>>>> SSID (i.e. roaming environment), however my single AP 
>>>>>>> environments have all strong signal
>>>>>>> - Some devices with identical configuration in this environment 
>>>>>>> DO NOT get lost, those seem to have quite strong signal (maybe 
>>>>>>> they don't roam)
>>>>>>> - Other devices in the same environment work without any 
>>>>>>> problems (Intel+NetworkManager) and the APs are Aruba enterprise 
>>>>>>> grade
>>>>>>> - I see almost the same in the Aruba enterprise environment, but 
>>>>>>> ALSO in a FritzBox + FritzRepeater environment
>>>>>>> - We had a bug in our web socket connection, causing to many IWD 
>>>>>>> requests. However, this was fixed. And why are all the other 
>>>>>>> devices okay? Maybe co-incidence with roaming and anything 
>>>>>>> related to dropping and re-connecting web socket connection.
>>>>>>>
>>>>>>> Please find attached my currently available debug logs (they are 
>>>>>>> a few days old, but I am quite sure this is the connection loss 
>>>>>>> situation). These logs are from the FritzBox+FritzRepeater 
>>>>>>> environment. There are no brcmfmac messages (but also no special 
>>>>>>> debug level configured here)!
>>>>>>>
>>>>>>> I have now also disabled WiFi power saving and will deploy to 
>>>>>>> the environment...hoping the best.
>>>>>>>
>>>>>>> Maybe you could check the logs and have an idea?
>>>>>>
>>>>>> Looks like the same thing as the last logs you sent. IWD tries to 
>>>>>> connect (sends CMD_CONNECT to the kernel) but gets no associated 
>>>>>> CMD_CONNECT event after that which causes IWD to wait 
>>>>>> indefinitely for that event. This, again, appears like a driver 
>>>>>> problem because its expected that the kernel tells userspace the 
>>>>>> result of the CMD_CONNECT request.
>>>>>>
>>>>>> Only similarity I can see between the two sets of logs is there 
>>>>>> is a failed connection just prior to the hang. IWD then attempts 
>>>>>> to connect again but the 4-way handshake is never started and 
>>>>>> this results in a failure with status 16 (group key handshake 
>>>>>> timeout). In your latest set of logs IWD actually again tries to 
>>>>>> connect to a different BSS and gets status 16 before trying yet 
>>>>>> again and hanging.
>>>>>>
>>>>>> This actually seems similar to an issue I encountered with ath10k 
>>>>>> where the network interface would time out being brought up. 
>>>>>> Retrying would succeed but the driver would be in a similar state 
>>>>>> where IWD could authenticate/associate but no data frames (i.e. 
>>>>>> 4-way handshake) would be passed to userspace. Only solution 
>>>>>> (until upstream fixed the bug) was to unload/reload the driver 
>>>>>> when we detected this condition.
>>>>>>
>>>>>> If you are able to physically attach to a device currently in 
>>>>>> this state you may be able to get more info. For example if IWD 
>>>>>> is stuck like this try disconnecting/reconnecting with iwctl or 
>>>>>> restarting IWD to see what happens. If you end up in the same 
>>>>>> state right away I'm 99.9% sure the driver is the entire reason 
>>>>>> your running into this.
>>>>>
>>>>> Are you sure? Maybe you could double-check?
>>>> I'm sure.
>>>>>
>>>>> Because my SOM vendor (Variscite) selling a few hundred thousand 
>>>>> of these do not report any issue with this kernel, firmware, and 
>>>>> NetworkManager (wpa_supplicant)...
>>>>
>>>> Because wpa_supplicant sets internal timers for these commands in 
>>>> case the driver is broken. I would expect you would see this exact 
>>>> behavior with wpa_supplicant, it would just disconnect/reconnect 
>>>> after 5 seconds of no response from the kernel. And something like 
>>>> this either a) goes entirely unnoticed and/or b) works well enough 
>>>> for a hardware vendor to ship it to customers and not care.
>>>>
>>>> This is the commit adding these timers to wpa_supplicant:
>>>>
>>>> commit e29853bbff1eef781099a9108e3b51f26b477ac3
>>>> Author: Ben Greear <greearb@candelatech.com>
>>>> Date:   Thu Feb 24 16:59:46 2011 +0200
>>>>
>>>>     SME: Add timers for authentication and asscoiation
>>>>
>>>>     mac80211 authentication or association operation may get stuck 
>>>> for some
>>>>     reasons, so wpa_supplicant better use an internal timer to 
>>>> recover from
>>>>     this.
>>>>
>>>>     Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>>
>>>> I wish it surprised me that 13 years later this behavior still 
>>>> happens... We don't like adding special driver workarounds like 
>>>> this in IWD because a) it becomes difficult to maintain and b) it 
>>>> just hides the root cause and nobody ever fixes it. But my opinions 
>>>> aside, for a driver like brcmfmac which is very mainstream, I guess 
>>>> we have no choice but to adapt IWD to work around it like 
>>>> wpa_supplicant does.
>>>>
>>>> Thanks,
>>>>
>>>> James
>>>
>>> I've sent a patch to the list which sets a timer within IWD in case 
>>> the connect event never arrives. Note that I cannot test this beyond 
>>> manually commenting out code to "trick" IWD into thinking this 
>>> happens. Applying that patch to the brcmfmac client your using is 
>>> going to be the true test.
>>
>> I may be able to test it, however only together with wifi power save 
>> disabled (I also prepared NetworkManager branch, because the customer 
>> will kill me otherwise).
>>
>> @Arent: Maybe you could check all this, as it seems to be related to 
>> some brcmfmac state. Just now I cannot provide logs, and your debug 
>> level for brcmfmac produces a lot lot of data, which I somehow also 
>> need to handle (limited space).
>
> With this patch and power save disabled, we have a better connection, 
> but still carrier losses several times a day (sometimes minutes, 
> sometimes hours). We think this is still due to driver / daemon. We 
> have checked AP logs and the infrastructure is Aruba. We will try to 
> get some more debug logs from that environment.
>
> My feeling is somehow, there could maybe still be a corner-case 
> related to BSS selection in WPA3 OWE. Or it is about failed roamings 
> of the driver.
>
> We will now a) upgrade to 6.6x kernel (driver) and b) add another wifi 
> chip (NXP IW611) to our board and test that one too.
>
> @James: Do you know if NXP IW611 works well with IWD?
Sorry, I have no experience with that chipset.
>
> Thanks,
>
> Martin
>
>
