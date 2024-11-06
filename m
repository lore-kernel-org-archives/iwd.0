Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502220C47E
	for <iwd@lists.linux.dev>; Wed,  6 Nov 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928922; cv=none; b=rHksB1a132xJAX2w1w5jBcIyLqn9pfaTjRfUeFXXWJh1LoiXBGzZAus8/HlArUlcaKRU0cXWNUf9FqbYqbAe2gyviaMaVBw4j31hOGzAKjVpKmbUXc0WrLGDn+3+ZFqbnCW2QUCaIOxaMe9CGKJ0FmPadCwjUmc4ULbvy22WbWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928922; c=relaxed/simple;
	bh=D+gNnjFvJ68s9DDYnUjnf+ojVDpccFdbj6EKEnAetIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBgM6JvfJ1HxuHTwXNq3Qd/9rzjtHLfwTU4eq4m2RZ2kuhPFhWyDjdu6xnxozE7IBxpei1woxG/QBpaUsg0AlZk7LYMGIsNqalgjEb+qYiplk5a9L0slsOBEn8AgkTblmaD/e96phv9MZu/a3nR7LYzfa11p/Bza9aLh1kkg/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgPIyv2f; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgPIyv2f"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1467af9dbso16483385a.0
        for <iwd@lists.linux.dev>; Wed, 06 Nov 2024 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730928917; x=1731533717; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWVT0gCvHbKNIFCCvEWd49uqy9MyC44EU1O3GFHrFeY=;
        b=TgPIyv2f/4jzQLgrPFEp8vqqFOvO3jPswlgt+Nd8e65hWXj2vTdKsm1fLaUzg5P0XW
         oM7ymy5QTnLUnZaBUToI2pfBmZCAjnGYk/COAUcRBHkfqDCohzKRn0P9NSOx58UIteSs
         5y0wo9/RjmRfFkqSENY5SVondCkR+Cu4rRb+B/QBnhwiNzEo0Ev0MzGnMzS4cHYF9/X0
         wF4ZmXV58pXIlZNGPCzU5QhPu6APXjOujhzgBB/cDRo6CVB2Nc0mkT1newM6bXA8i/th
         BrAgYias0RuCvOqdzOz+oJEWBLS18wHHa//Kw0tc44nd9zSpro9txZyv+jCPr4j5pXVn
         vIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730928917; x=1731533717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWVT0gCvHbKNIFCCvEWd49uqy9MyC44EU1O3GFHrFeY=;
        b=ulrt96pJbGZ5Rq9LAdAEBm3YEMT8CjWw8y+m4CB0mtKtZdwSVk25X4m5q2FxWUt9IM
         o5XIFmDQC26S5zzZd62AoBfGwKo0Uh0GAPggo1s1nNPVzRtxIhS7TYjGCr2tiYaWvTRS
         YtgbFbteQGB8+nr1KJ/B+xdwlqsCKuinlsDJ6Vp+AgA4UVKWhPdUTEXF9AlRxigpq5Zu
         Fob4cKaigjrpmo26AqYn2scy6AXNpRxas5aV059XkVNX9LwFBdAPwj4JTeJgRHbpPlR8
         ZVbljPfmRYjkKpdtEY6mk4oCcu9CQVO8mz3zGAl/w8bT0uzaN0i65eV7ZUohxmc3eaO6
         Upww==
X-Gm-Message-State: AOJu0YyCqDFLPDZSFpEw1CcVLb19sdJW2qAMKSk7dGtqwlOxzeccQeoM
	3Z5YCNJsY1uRpoXNLWzD6zT6cZyw2UfSva5XiTtfKY0v4cHl5KOCtbj0Sw==
X-Google-Smtp-Source: AGHT+IEsW15bPlCbg64Ts8OY6YOxTkYWve0s2MEA4v1x+VeldtfhI+10hUMFbJxdjtVs3M58AA3Lhw==
X-Received: by 2002:a05:620a:170c:b0:7b1:880c:57fa with SMTP id af79cd13be357-7b1aee4b8a3mr3966392385a.52.1730928917027;
        Wed, 06 Nov 2024 13:35:17 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39fae58sm672420785a.49.2024.11.06.13.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 13:35:16 -0800 (PST)
Message-ID: <22221676-2961-4dc9-a1ae-1ffbaed34316@gmail.com>
Date: Wed, 6 Nov 2024 13:35:15 -0800
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
 <b718a3d3-aa26-4b95-9b16-f4c9acd27663@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <b718a3d3-aa26-4b95-9b16-f4c9acd27663@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 11/6/24 12:32 PM, Martin Petzold wrote:
> Dear James,
>
> Am 04.11.24 um 13:36 schrieb James Prestwood:
>>
>> On 11/3/24 3:13 PM, Martin Petzold wrote:
>>> Dear James,
>>>
>>> Am 25.10.24 um 17:17 schrieb James Prestwood:
>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I open a new thread for this one: During the last weeks I 
>>>>>>>>>>>> have seen connection losses for 30+ minutes, sometimes even 
>>>>>>>>>>>> hours or just now even forever (IWD HEAD with v2 OWE / BSS 
>>>>>>>>>>>> selection patches). Driver is brcmfmac (NXP 6.1.36 kernel) 
>>>>>>>>>>>> and chip is BCM4339 (Laird LWB5).
>>>>>>>>>>>>
>>>>>>>>>>>> It happens in a) single router environment (WPA2-PSK; 
>>>>>>>>>>>> Touchstone TG3442DE), and b) router + repeater environment 
>>>>>>>>>>>> (WPA2 CCMP; Fritz!Box + Fritz!Repeater), and maybe also in 
>>>>>>>>>>>> the WPA3 OWE Transition network (yesterday lost a 
>>>>>>>>>>>> connection again).
>>>>>>>>>>>
>>>>>>>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network 
>>>>>>>>>>> (with roaming). However, now they don't disappear all after 
>>>>>>>>>>> a shorter while. It seems to be later.
>>>>>>>>>>>
>>>>>>>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) 
>>>>>>>>>>> network. It is confirmed here on router side, that the 
>>>>>>>>>>> device is disconnected. Since more than a day.
>>>>>>>>>>
>>>>>>>>>> We can't do anything without logs. If you suspect its the 
>>>>>>>>>> blacklist you can lower the blacklist time down in main.conf:
>>>>>>>>>>
>>>>>>>>>> [
>>>
>>> I am still losing devices. Sometimes they come back again, but 
>>> mostly do not re-connect. I have observed the following:
>>>
>>> - Connection exists for several hours until about one day, or two. 
>>> Then gone for several hours or mostly forever.
>>> - For FritzBox+FritzRepeater I have seen the connection coming back 
>>> after like a day (here connection loss was also confirmed on router 
>>> side!)
>>> - For the Aruba enterprise environment the connection never came 
>>> back (until now no AP logs - waiting for an answer)
>>> - After reboot the connection comes back
>>> - It occurs only in an environment with multiple APs with same SSID 
>>> (i.e. roaming environment), however my single AP environments have 
>>> all strong signal
>>> - Some devices with identical configuration in this environment DO 
>>> NOT get lost, those seem to have quite strong signal (maybe they 
>>> don't roam)
>>> - Other devices in the same environment work without any problems 
>>> (Intel+NetworkManager) and the APs are Aruba enterprise grade
>>> - I see almost the same in the Aruba enterprise environment, but 
>>> ALSO in a FritzBox + FritzRepeater environment
>>> - We had a bug in our web socket connection, causing to many IWD 
>>> requests. However, this was fixed. And why are all the other devices 
>>> okay? Maybe co-incidence with roaming and anything related to 
>>> dropping and re-connecting web socket connection.
>>>
>>> Please find attached my currently available debug logs (they are a 
>>> few days old, but I am quite sure this is the connection loss 
>>> situation). These logs are from the FritzBox+FritzRepeater 
>>> environment. There are no brcmfmac messages (but also no special 
>>> debug level configured here)!
>>>
>>> I have now also disabled WiFi power saving and will deploy to the 
>>> environment...hoping the best.
>>>
>>> Maybe you could check the logs and have an idea?
>>
>> Looks like the same thing as the last logs you sent. IWD tries to 
>> connect (sends CMD_CONNECT to the kernel) but gets no associated 
>> CMD_CONNECT event after that which causes IWD to wait indefinitely 
>> for that event. This, again, appears like a driver problem because 
>> its expected that the kernel tells userspace the result of the 
>> CMD_CONNECT request.
>>
>> Only similarity I can see between the two sets of logs is there is a 
>> failed connection just prior to the hang. IWD then attempts to 
>> connect again but the 4-way handshake is never started and this 
>> results in a failure with status 16 (group key handshake timeout). In 
>> your latest set of logs IWD actually again tries to connect to a 
>> different BSS and gets status 16 before trying yet again and hanging.
>>
>> This actually seems similar to an issue I encountered with ath10k 
>> where the network interface would time out being brought up. Retrying 
>> would succeed but the driver would be in a similar state where IWD 
>> could authenticate/associate but no data frames (i.e. 4-way 
>> handshake) would be passed to userspace. Only solution (until 
>> upstream fixed the bug) was to unload/reload the driver when we 
>> detected this condition.
>>
>> If you are able to physically attach to a device currently in this 
>> state you may be able to get more info. For example if IWD is stuck 
>> like this try disconnecting/reconnecting with iwctl or restarting IWD 
>> to see what happens. If you end up in the same state right away I'm 
>> 99.9% sure the driver is the entire reason your running into this.
>
> -----
>
> Okt 24 02:30:33 tavla iwd[386]: src/netdev.c:netdev_mlme_notify() MLME 
> notification Disconnect(48)
> Okt 24 02:30:33 tavla iwd[386]: src/netdev.c:netdev_disconnect_event()
> Okt 24 02:30:33 tavla iwd[386]: Received Deauthentication event, 
> reason: 8, from_ap: true
>
> -----
>
> From where does this MLME notification Disconnect come before the AP 
> Deauth event?
Its all part of the same call stack.  The kernel sent a disconnect 
notification and IWD handles it.
>
> And does reason 8 mean "Disassociated because sending station is 
> leaving (or has left)" (which sounds like originally station decision) 
> OR "AP moved the client to another access point using non-aggressive 
> load balancing" (which then seems to be an AP decision)?
I've learned to take any disconnect reason code the AP sends with a huge 
grain of salt. I work with devices running under various professional 
WiFi network vendors (Cisco, Meraki, Aruba, etc) and I've seen all kinds 
of reason codes that make little to no sense at all. I've seen reason 
code 8 specifically with Cisco APs and actually sat on calls with Cisco 
engineers asking them why. They weren't able to give me a reason, even 
denied that reason code 8 was possible with their equipment (until I 
showed them an OTA packet capture of it happening). Anyways, what I'm 
saying is you could spend a eternity trying to make sense of why or how 
a client gets disconnect by an AP but its generally not worth time 
(unless its happening very frequently). If the disconnects are 
infrequent, and the client recovers quickly, this is about par for the 
course in my experience.
>
> Because we are talking about signals around -70. What would the event 
> be, if the AP finds the station unacceptable because of bad signal 
> strength (so this is signal in direction to AP). Or doesn't this exist?
You'd have to ask the AP vendors. IWD just gets notified it was 
disconnected and a reason code. When you see "from_ap: true" all we know 
is it was initiated by the AP.
>
> Thanks,
>
> Martin
>
