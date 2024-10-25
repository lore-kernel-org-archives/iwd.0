Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25D1442F3
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868631; cv=none; b=MHPcgz5OH5QVJ4IznQ85Odad8pUFzbCqDPTRFjRBC9u5EZ4XBGjx6hKzSh/9lA9Jn4TOYTIcrcItc23uiJMS9pDRrrMVIVONHfFSpb5NpcJjVmDNrU7rIBgaBtDcNGYbSduZyoqlTJpHQF/zz4ZWCAg+DL0/599tJz5xJqND98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868631; c=relaxed/simple;
	bh=3vgjPvlMyGW6tEghQ9DZv6JN8fVCltLhGnjqq3oyzXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qB18fl2Mpus3wP4Pzkm/uEPO6iSwG7S4slBIXlHyhn3kIyrpOwSCQxCA/Rd7KW46ago5tAvqanZcxkUk0naK4s4unzoWPUFyRoIzoOHpOBHY9N3wJsvjAe0QLEOu7QrKf6fDOJzp1TANCus0BP0Qrpq9hd2SK3ABCKpAOAsQTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=t2n1Cvx+; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="t2n1Cvx+"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4XZmJG65Y1zDtDK;
	Fri, 25 Oct 2024 17:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729868622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l15TaJKJafx66+vCp49498qljOVSNkyOpZL6pNzSi1k=;
	b=t2n1Cvx+a+yyRFc9eXoeBOtHtfAVWXluw2VqZL4AghNOBA6j+dLkmhic2K0+WRRqKXPGk3
	euWwuYrcBNc1Dkr799Ahe8LH0/qHR5/egm8UrE5KUcn3s0QmkdHkabkdy61DyVNKOzjfIo
	32923dRQsXzozDIX9AJhYj7Mr7V6owaLKVdYvjZVhn1o1K8gcIm/U+bRj5zrS3k0HahWJv
	KjY5jzyoDL4iZrePhGV+askl/TEpAES2fMVdapBYWij5GjlyzX9MUjNIHyhGN/i8nKzPtQ
	WEfC63TcCOKThsYtYAzR8Fjjgx2jDoh53GzDoeCSRlj53isHeYTFw+6d/xi7Cg==
Message-ID: <78437e50-e6b1-4965-bd03-776fcf3c9801@tavla.de>
Date: Fri, 25 Oct 2024 17:03:41 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
 <57826e6a-8466-4e45-8906-6cb15968bcc8@tavla.de>
 <e19e7527-9cc1-4c84-95ac-dcb39f836d58@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <e19e7527-9cc1-4c84-95ac-dcb39f836d58@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

Am 25.10.24 um 15:18 schrieb James Prestwood:
>
> On 10/25/24 6:11 AM, Martin Petzold wrote:
>> Hi James,
>>
>> Am 25.10.24 um 14:54 schrieb James Prestwood:
>>> Hi Martin,
>>>
>>> On 10/25/24 5:28 AM, Martin Petzold wrote:
>>>> Hi James,
>>>>
>>>> Am 25.10.24 um 13:48 schrieb James Prestwood:
>>>>> Hi Martin,
>>>>>
>>>>> On 10/25/24 4:10 AM, Martin Petzold wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Am 25.10.24 um 12:12 schrieb Martin Petzold:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I open a new thread for this one: During the last weeks I have 
>>>>>>> seen connection losses for 30+ minutes, sometimes even hours or 
>>>>>>> just now even forever (IWD HEAD with v2 OWE / BSS selection 
>>>>>>> patches). Driver is brcmfmac (NXP 6.1.36 kernel) and chip is 
>>>>>>> BCM4339 (Laird LWB5).
>>>>>>>
>>>>>>> It happens in a) single router environment (WPA2-PSK; Touchstone 
>>>>>>> TG3442DE), and b) router + repeater environment (WPA2 CCMP; 
>>>>>>> Fritz!Box + Fritz!Repeater), and maybe also in the WPA3 OWE 
>>>>>>> Transition network (yesterday lost a connection again).
>>>>>>
>>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
>>>>>> roaming). However, now they don't disappear all after a shorter 
>>>>>> while. It seems to be later.
>>>>>>
>>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) network. 
>>>>>> It is confirmed here on router side, that the device is 
>>>>>> disconnected. Since more than a day.
>>>>>
>>>>> We can't do anything without logs. If you suspect its the 
>>>>> blacklist you can lower the blacklist time down in main.conf:
>>>>>
>>>>> [Blacklist]
>>>>> MaximumTimeout=5
>>>>>
>>>>> But logs would be best, we would be able to see if that is whats 
>>>>> happening or if its something else.
>>>>>
>>>>>
>>>> I can also now see this on one of our local devices (which was 
>>>> connected to Ethernet and WiFi).
>>>>
>>>> Please find attached the log. The logs start at late 23rd with the 
>>>> image upgrade.
>>>>
>>>> I can see on our server side, that devices continuously connect and 
>>>> disconnect again (missed heartbeat = hard loss of websocket 
>>>> connection). I see some type of connection loop on client side too 
>>>> ("org.eclipse.jetty.websocket.api.UpgradeException: 0 null" caused 
>>>> by "java.util.concurrent.TimeoutException: DNS timeout 15000 ms"). 
>>>> Maybe it alternates between Ethernet and WiFi. You will understand 
>>>> better. Or the network is re-configured all the time.
>>>>
>>>> Here is my local status:
>>>>
>>>> tavla@tavla:~$ iwctl station wlan0 show
>>>>                                  Station: wlan0
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>>   Settable  Property Value
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>>             Scanning no
>>>>             State connecting
>>>>             Connected network     XYZ
>>>>             No IP addresses       Is DHCP client configured?
>>>>
>>>> tavla@tavla:~$ networkctl status
>>>> ●        State: routable
>>>>   Online state: unknown
>>>>        Address: 192.168.178.178 on eth0
>>>>                 2a0a:a549:da80:0:fadc:7aff:fe67:2e4 on eth0
>>>>                 fe80::fadc:7aff:fe67:2e4 on eth0
>>>>                 fe80::c2ee:40ff:fe8a:dd62 on wlan0
>>>>        Gateway: 192.168.178.1 on eth0
>>>>                 fe80::3a10:d5ff:fe37:2c79 on eth0
>>>>            DNS: 192.168.178.1
>>>>            NTP: 192.168.178.1
>>>> IDX LINK  TYPE     OPERATIONAL SETUP
>>>>   1 lo    loopback carrier     unmanaged
>>>>   2 eth0  ether    routable    configured
>>>>   3 wlan0 wlan     no-carrier  unmanaged
>>>>
>>>> 3 links listed.
>>>
>>> Yep, IWD is ultimately hung up waiting for a connect event from the 
>>> kernel/driver. A few things I noticed prior to that:
>>>
>>> 1. Not really critical but you have an agent connecting and 
>>> disconnecting multiple times a second. Are you polling info with 
>>> iwctl or something?

What do you mean with an agent? I have no iwctl agent (there is only web 
socket connection agent). Could this be something to check (also on your 
side)?

>>> [...]
>> Okt 25 15:08:56 tavla iwd[384]: event: state, old: connecting (auto), 
>> new: disconnecting
>> Okt 25 15:08:56 tavla iwd[384]: src/wiphy.c:wiphy_radio_work_done() 
>> Work item 19 done
>> Okt 25 15:08:56 tavla iwd[384]: src/station.c:station_connect_cb() 3, 
>> result: 5
>> Okt 25 15:08:56 tavla iwd[384]: src/station.c:station_disconnect_cb() 
>> 3, success: 0
>> Okt 25 15:08:56 tavla iwd[384]: event: state, old: disconnecting, 
>> new: disconnected
>> Okt 25 15:08:56 tavla iwd[384]: src/agent.c:agent_disconnect() agent 
>> :1.13740 disconnected
>> Okt 25 15:08:56 tavla iwd[384]: src/agent.c:agent_free() agent free 
>> 0xaaaae76eaa50
> Yes, the driver seems completely stuck. I would recommend 
> unloading/reloading it with modprobe.

I'm quite sure this is related to your BSS / AKM patch. It happened on a 
client here after an image upgrade to this version. I have never seen 
this before.

Also, I have debugging for BRCM enabled (CONFIG_BRCMDBG=y and 
CONFIG_DEBUG_FS=y). It sounds strange if there is no output, even not 
before.

Thanks,

Martin

