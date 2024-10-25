Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300618785B
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869440; cv=none; b=hwD2v8Rjlz8sWH6FxUQNtpSOAKFpmUc8knNasndzSJIbRdTVUT9c+mD4rI4ixddEpCBq2KhPBzybQuG+HIP1KXsmZrxBLHfIR0dyTDqZx/012hUT68g8XhdjyngEnBuMpIkKe8CCFEMSbvzG6R/BOoNMuqVi4T4nql1QGO8aHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869440; c=relaxed/simple;
	bh=XLhBpTmcESwELRVGbdoa+9pg3gXNBqHpWad123NBhB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrGrGED9FNLKxnZjNhnF4xk86p4mTbEAwcqOEDCwveTBO55lm3y6/ABRXBxB8NqQSa6rbMhk5qwIrWNJOYU8H8o87w6wGp6+puyeWstI3NGdOR1dgjYG8gLhp5uQWG7KL9cLtzJafCh9GT1R7u7TjEAJfiGdW2AVpVV40bSUN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZvS0gpw; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZvS0gpw"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so14665866d6.0
        for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729869437; x=1730474237; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sw/YFMVWUJEBOITY4SIZfdsyZBwDqpxLWXFmbvoSx9U=;
        b=ZZvS0gpwJMsow7fooJzjN7c0psagRnRLOMfkmO9CvsPPGW4n7u+DSr5BD1Wv+89Y3r
         DmUjWM0ogIRENAJWFkbCmMwja81zOpItf6b6o3MtwhODO9sUDV1ZlE7zBqUJ9Gy50NFS
         2BVuMugCdvz5Pv8/RbH8/B+hQT4gVfxo+kUjyKyGxqNkevrTAmlmeNRTKBxC2TrCl36H
         HmHGTEK33OjckibkN0DiDu3vUk7o320cW4VJkuZZ5fSgGAMyGShpBiv69sFCI1EHNbnj
         SGrDw3iYjP/181e41YN9seU7dt49C6JTpNI4bcS+Cc62a3+A/Mv7QkxGOZPVqTXb4ggo
         u9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729869437; x=1730474237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw/YFMVWUJEBOITY4SIZfdsyZBwDqpxLWXFmbvoSx9U=;
        b=lWRzqEO0mQiEJkzGXvXgUhOWY7igCRvXiN4mbb4vFaDAAmrN89GyfYxTKhVHcmDHM1
         DSWtSsPf1RI0ThhWBG+1Vu/6/NyzzBaPKMRDAusQMfhH2u4DUusgN19WM8rko6oDjyhs
         Ayms5iBy4GUUV03fhQFRzxBODHLhgVZ+ocVy3QPvbTa/65O0tdtRy0RhviX4do1YUw4h
         vSaMb2DHdh0Z2YGDzcGAYpEiE+PJ7PeqFgNs2Es5j8HAfFbk9fjT3WNCvdys/CFNaFJe
         aWO6QqVj1Ccv1vLPzbXU9nQtQR01DAwlvpwRYsb5dmM544mmPjku/9yemdtaPRNeiUJ+
         DnXA==
X-Gm-Message-State: AOJu0YxYs940tCV7YzeXD5KR/HkRoiPQ8FjsCxMBIqLb+kB2v1QLOvGI
	FBMmiFrYTiGJGEnTak8ojCNbMwPoKAHVWKvfNQvhWBhmRYeTNqgt+QXFfw==
X-Google-Smtp-Source: AGHT+IEohTszy8aWz3ezNzHDpsy/QVPf0rKzjBS6B5XWjHvUZy0buAM3tZnCUUajmY7ZOM5hMhdJcg==
X-Received: by 2002:a05:6214:3d0f:b0:6cc:1f0:d38a with SMTP id 6a1803df08f44-6ce3416d4c8mr139695536d6.14.1729869436593;
        Fri, 25 Oct 2024 08:17:16 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991e970sm6536826d6.74.2024.10.25.08.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 08:17:14 -0700 (PDT)
Message-ID: <a64c4733-9011-448c-ab75-8916ff339ac4@gmail.com>
Date: Fri, 25 Oct 2024 08:17:11 -0700
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <78437e50-e6b1-4965-bd03-776fcf3c9801@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/25/24 8:03 AM, Martin Petzold wrote:
> Hi James,
>
> Am 25.10.24 um 15:18 schrieb James Prestwood:
>>
>> On 10/25/24 6:11 AM, Martin Petzold wrote:
>>> Hi James,
>>>
>>> Am 25.10.24 um 14:54 schrieb James Prestwood:
>>>> Hi Martin,
>>>>
>>>> On 10/25/24 5:28 AM, Martin Petzold wrote:
>>>>> Hi James,
>>>>>
>>>>> Am 25.10.24 um 13:48 schrieb James Prestwood:
>>>>>> Hi Martin,
>>>>>>
>>>>>> On 10/25/24 4:10 AM, Martin Petzold wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Am 25.10.24 um 12:12 schrieb Martin Petzold:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> I open a new thread for this one: During the last weeks I have 
>>>>>>>> seen connection losses for 30+ minutes, sometimes even hours or 
>>>>>>>> just now even forever (IWD HEAD with v2 OWE / BSS selection 
>>>>>>>> patches). Driver is brcmfmac (NXP 6.1.36 kernel) and chip is 
>>>>>>>> BCM4339 (Laird LWB5).
>>>>>>>>
>>>>>>>> It happens in a) single router environment (WPA2-PSK; 
>>>>>>>> Touchstone TG3442DE), and b) router + repeater environment 
>>>>>>>> (WPA2 CCMP; Fritz!Box + Fritz!Repeater), and maybe also in the 
>>>>>>>> WPA3 OWE Transition network (yesterday lost a connection again).
>>>>>>>
>>>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
>>>>>>> roaming). However, now they don't disappear all after a shorter 
>>>>>>> while. It seems to be later.
>>>>>>>
>>>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) network. 
>>>>>>> It is confirmed here on router side, that the device is 
>>>>>>> disconnected. Since more than a day.
>>>>>>
>>>>>> We can't do anything without logs. If you suspect its the 
>>>>>> blacklist you can lower the blacklist time down in main.conf:
>>>>>>
>>>>>> [Blacklist]
>>>>>> MaximumTimeout=5
>>>>>>
>>>>>> But logs would be best, we would be able to see if that is whats 
>>>>>> happening or if its something else.
>>>>>>
>>>>>>
>>>>> I can also now see this on one of our local devices (which was 
>>>>> connected to Ethernet and WiFi).
>>>>>
>>>>> Please find attached the log. The logs start at late 23rd with the 
>>>>> image upgrade.
>>>>>
>>>>> I can see on our server side, that devices continuously connect 
>>>>> and disconnect again (missed heartbeat = hard loss of websocket 
>>>>> connection). I see some type of connection loop on client side too 
>>>>> ("org.eclipse.jetty.websocket.api.UpgradeException: 0 null" caused 
>>>>> by "java.util.concurrent.TimeoutException: DNS timeout 15000 ms"). 
>>>>> Maybe it alternates between Ethernet and WiFi. You will understand 
>>>>> better. Or the network is re-configured all the time.
>>>>>
>>>>> Here is my local status:
>>>>>
>>>>> tavla@tavla:~$ iwctl station wlan0 show
>>>>>                                  Station: wlan0
>>>>> -------------------------------------------------------------------------------- 
>>>>>
>>>>>   Settable  Property Value
>>>>> -------------------------------------------------------------------------------- 
>>>>>
>>>>>             Scanning no
>>>>>             State connecting
>>>>>             Connected network     XYZ
>>>>>             No IP addresses       Is DHCP client configured?
>>>>>
>>>>> tavla@tavla:~$ networkctl status
>>>>> ●        State: routable
>>>>>   Online state: unknown
>>>>>        Address: 192.168.178.178 on eth0
>>>>>                 2a0a:a549:da80:0:fadc:7aff:fe67:2e4 on eth0
>>>>>                 fe80::fadc:7aff:fe67:2e4 on eth0
>>>>>                 fe80::c2ee:40ff:fe8a:dd62 on wlan0
>>>>>        Gateway: 192.168.178.1 on eth0
>>>>>                 fe80::3a10:d5ff:fe37:2c79 on eth0
>>>>>            DNS: 192.168.178.1
>>>>>            NTP: 192.168.178.1
>>>>> IDX LINK  TYPE     OPERATIONAL SETUP
>>>>>   1 lo    loopback carrier     unmanaged
>>>>>   2 eth0  ether    routable    configured
>>>>>   3 wlan0 wlan     no-carrier  unmanaged
>>>>>
>>>>> 3 links listed.
>>>>
>>>> Yep, IWD is ultimately hung up waiting for a connect event from the 
>>>> kernel/driver. A few things I noticed prior to that:
>>>>
>>>> 1. Not really critical but you have an agent connecting and 
>>>> disconnecting multiple times a second. Are you polling info with 
>>>> iwctl or something?
>
> What do you mean with an agent? I have no iwctl agent (there is only 
> web socket connection agent). Could this be something to check (also 
> on your side)?
Okt 23 23:00:48 tavla iwd[384]: src/agent.c:agent_register() agent 
register called
Okt 23 23:00:48 tavla iwd[384]: src/agent.c:agent_register() agent 
:1.179 path /agent/3420
Okt 23 23:00:48 tavla iwd[384]: src/agent.c:agent_disconnect() agent 
:1.179 disconnected
Okt 23 23:00:48 tavla iwd[384]: src/agent.c:agent_free() agent free 
0xaaaae76dec10

Something is registering itself with IWD, then unregistering itself over 
and over again every minute. It may not be iwctl but something is doing 
that. Its not going to cause problems but its just very odd.

>>>> [...]
>>> Okt 25 15:08:56 tavla iwd[384]: event: state, old: connecting 
>>> (auto), new: disconnecting
>>> Okt 25 15:08:56 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done() 
>>> Work item 19 done
>>> Okt 25 15:08:56 tavla iwd[384]: src/station.c:station_connect_cb() 
>>> 3, result: 5
>>> Okt 25 15:08:56 tavla iwd[384]: 
>>> src/station.c:station_disconnect_cb() 3, success: 0
>>> Okt 25 15:08:56 tavla iwd[384]: event: state, old: disconnecting, 
>>> new: disconnected
>>> Okt 25 15:08:56 tavla iwd[384]: src/agent.c:agent_disconnect() agent 
>>> :1.13740 disconnected
>>> Okt 25 15:08:56 tavla iwd[384]: src/agent.c:agent_free() agent free 
>>> 0xaaaae76eaa50
>> Yes, the driver seems completely stuck. I would recommend 
>> unloading/reloading it with modprobe.
>
> I'm quite sure this is related to your BSS / AKM patch. It happened on 
> a client here after an image upgrade to this version. I have never 
> seen this before.
For WPA2 those patches _should_ have zero effect. Based on your logs the 
behavior here is entirely different than with OWE. Before the connection 
to the OWE network was actually failing (failed within brcmfmac). Here 
IWD tried to connect and got no event back from the driver. To know this 
without a doubt we would need to to run iwmon and see the communication 
between IWD and the kernel.
>
> Also, I have debugging for BRCM enabled (CONFIG_BRCMDBG=y and 
> CONFIG_DEBUG_FS=y). It sounds strange if there is no output, even not 
> before.

Maybe Arend has some idea of why userspace could send a CMD_CONNECT and 
get no associated CMD_CONNECT event?

The fact that even manually connecting didn't work after this happened 
tells me the driver is "stuck". Did you try cycling the driver with 
modprobe?

>
> Thanks,
>
> Martin
>
