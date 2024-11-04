Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C353C6BA
	for <iwd@lists.linux.dev>; Mon,  4 Nov 2024 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730762463; cv=none; b=XedD9vk9xff7h2oJUfH9jFiFMWc5wgfpgLbpYnw8sShOkQ2C/ugoVF90J9u86wmb9YS9vIXyhen5ZEQO1IUKYD3f4R2+fcWTuhfbVRSng7KVP/i/lMh6PwNd4JgkmJJaJO8wA5mYvY4LxUfdLMyIpTG7ZEi92MBELLOanOK9LH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730762463; c=relaxed/simple;
	bh=ZVLHG3fhibe8+hmVPr1VS3ppLqqd74oODbBd4KAQLrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQ1griHt/OhJ9aqCEnFQTo5gWx0UhsKhJ8WagBJb8IHf1ZIn6ERYOc3n5JymrHOzPYGzxk88fBS2xrFta95e3TOw41FZVxXMHFBnCHyaoay91mKZz9+zXv2zHA9MVr+i0QInlm1Nnz1NuMvDi3U06Q7f/+HvQid+IQmU7DyfnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFVXmalU; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFVXmalU"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7edb6879196so3285308a12.3
        for <iwd@lists.linux.dev>; Mon, 04 Nov 2024 15:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730762461; x=1731367261; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTYB/oEOGJNvyv2Q6yiQFJwFFWN0ll8breltVMnd5o8=;
        b=TFVXmalUF4B8cRV/Gn02Px99LR9BAXOUZa2TYzPg4ByowyxJbLTrdTkhRCp9SBcTPz
         cUhyBpaxls5QJIOCh8zyom+ooAijIluqu+FcX+qngSk6ULUwgjJGDp0FlCcm6fSwYiDX
         LdGmoICa35E2m0ATxN3JOFiw4cuoqMmOQnkI1RojsU4m4Zn5ldwDjQI3lQIulLNSQkLV
         fmwLRU+Bxe3dL9mepMxpPEakBN6kW11Rsui1yIWAmDMvH9urFI72wlCIVZwTi/upagUb
         I60gHnhGtUtD0y4OgwiT2CQGfpugkS6fLp+ivdHIytMyuMRWciy9KDQyxImvzV/zmrsO
         7pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730762461; x=1731367261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTYB/oEOGJNvyv2Q6yiQFJwFFWN0ll8breltVMnd5o8=;
        b=Z+vLFLauL0GeVUnVjx0joZDL6U7SuncOkPe1+WZsODGOeYSHK7hAnAZvee+MFMZava
         uBhqKCM5yOYc+ATzjtNheNXostFVev7xhP3LQca583280xZVnPGL4BUPOk1Sp+ouXUs2
         aXrLxhQA0s61R8NZWrNtPo1ZHQj8kuCwDX1Ptq0gM038SA+fdaZiWARZTPfRyO0ooQ7V
         xAFdTY4DplqGU69CS3w51CKu82giPPM/PqFtzvf+vzreBUo2kETPOgMbHTW+mcEMXB2J
         goOwvcStms4HQ2XF7Rp7FOFwj3AmRhQhjvgq+JiQFj1PEv+TkJVhX2/DxI9n5FKB39b1
         W96Q==
X-Gm-Message-State: AOJu0Yxq8/S1Vk3McF1FnfEflivORhr1+RMLTevqZXV3BjR/NOu0Zgtd
	j2wlCUqHLarQVcFMeDvZK7Xr/7ZKgl2ZckUq9Orp9XQzqZeWnJ9R
X-Google-Smtp-Source: AGHT+IEfLv7zPDpzsfCR3KT6LFmoWC3OZmwzLgjWOI45SQ4iI41ykhCfPQQGUuQrYzX6Bn8sfgwkvw==
X-Received: by 2002:a17:902:e882:b0:20c:c704:629e with SMTP id d9443c01a7336-210c6cd61c5mr473562185ad.56.1730762461371;
        Mon, 04 Nov 2024 15:21:01 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0801sm66652195ad.211.2024.11.04.15.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 15:21:00 -0800 (PST)
Message-ID: <49b9d8b9-2769-4c65-8f10-4ffafc822885@gmail.com>
Date: Mon, 4 Nov 2024 15:20:58 -0800
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <2d245329-365a-42fa-91d3-5f4da7ab846f@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 11/4/24 2:42 PM, Martin Petzold wrote:
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
> Are you sure? Maybe you could double-check?
I'm sure.
>
> Because my SOM vendor (Variscite) selling a few hundred thousand of 
> these do not report any issue with this kernel, firmware, and 
> NetworkManager (wpa_supplicant)...

Because wpa_supplicant sets internal timers for these commands in case 
the driver is broken. I would expect you would see this exact behavior 
with wpa_supplicant, it would just disconnect/reconnect after 5 seconds 
of no response from the kernel. And something like this either a) goes 
entirely unnoticed and/or b) works well enough for a hardware vendor to 
ship it to customers and not care.

This is the commit adding these timers to wpa_supplicant:

commit e29853bbff1eef781099a9108e3b51f26b477ac3
Author: Ben Greear <greearb@candelatech.com>
Date:   Thu Feb 24 16:59:46 2011 +0200

     SME: Add timers for authentication and asscoiation

     mac80211 authentication or association operation may get stuck for some
     reasons, so wpa_supplicant better use an internal timer to recover from
     this.

     Signed-off-by: Ben Greear <greearb@candelatech.com>

I wish it surprised me that 13 years later this behavior still 
happens... We don't like adding special driver workarounds like this in 
IWD because a) it becomes difficult to maintain and b) it just hides the 
root cause and nobody ever fixes it. But my opinions aside, for a driver 
like brcmfmac which is very mainstream, I guess we have no choice but to 
adapt IWD to work around it like wpa_supplicant does.

Thanks,

James

