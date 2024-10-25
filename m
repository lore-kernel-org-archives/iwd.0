Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC01F7544
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859997; cv=none; b=IAx4fV8iKsRd+JhiRU8TbWYMTvNp6N5kqNvM3uUi/fC1Q4FvRWZripcAAWFg5jYxka0i3+abEeEk5loLxGfQvq0YjiU8G9azsenZ8v/L3pTkz308Ljthuv0WHimp3u++5tBvoaqwSgZrAaF/kk+zExfD4JSBzwnnENLGUk7h4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859997; c=relaxed/simple;
	bh=uD81qTKzGI6hjnVfnzyLpwF80/ArLxGlXOk9+W3nWWQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B9vrKTFE8nk304NbwAaQMDOWbseq7deRnYrxZ0duFoMkchrFw2YuZN54XNMyBkEbbIS2Sj9588G83Y3pPw8AElDEpwzfOj1i5Gtrp6UkDIhElSGmip4xx0uZMNXwBoxWcHD6g3hXDF5GQZ9OBYUbcd45HtHVAd7VuGCkvMkj6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=PwVpxtuL; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="PwVpxtuL"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XZj6F6jSpzDvGP;
	Fri, 25 Oct 2024 14:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729859990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv2gazehRltxwidZ+g44wAixjR782htzqkIG7bP/kSE=;
	b=PwVpxtuLSL1udZufbDJkXbnoUpEEzs1Mvb7rkMJ8ZjUJ6MB9txMDyfzIpf72t77fkPA4wl
	PpOBggpy3Xz/vrP6d6+dB4Hohc8yjjlELDHmdxsepNc+0Y56/c1lvNXondyeLQsM77G19+
	r8XEaP5iCkmoC6FvmJHN74faeSpm7/xVU2geZvhyKxaKlfcBk4U4d4z1wnhw7J91gP6gpq
	n0bzS8lJ95laeyvKPiN2DhcDOz3nSJahdmVO1avlXMo26jI4+2kOYDi8rAXyXqjMk/WXv6
	1Iabu9lwfvioPy6xltg1MIJyvMnH7pBw5gvlTU1MC45C9TvvfWd+cBmpP8aD8g==
Message-ID: <5ba46601-a2fa-4c6d-b9e3-c6425bea119e@tavla.de>
Date: Fri, 25 Oct 2024 14:39:48 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
From: Martin Petzold <martin.petzold@tavla.de>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

Am 25.10.24 um 14:28 schrieb Martin Petzold:
> Hi James,
>
> Am 25.10.24 um 13:48 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 10/25/24 4:10 AM, Martin Petzold wrote:
>>> Hi all,
>>>
>>> Am 25.10.24 um 12:12 schrieb Martin Petzold:
>>>> Hi all,
>>>>
>>>> I open a new thread for this one: During the last weeks I have seen 
>>>> connection losses for 30+ minutes, sometimes even hours or just now 
>>>> even forever (IWD HEAD with v2 OWE / BSS selection patches). Driver 
>>>> is brcmfmac (NXP 6.1.36 kernel) and chip is BCM4339 (Laird LWB5).
>>>>
>>>> It happens in a) single router environment (WPA2-PSK; Touchstone 
>>>> TG3442DE), and b) router + repeater environment (WPA2 CCMP; 
>>>> Fritz!Box + Fritz!Repeater), and maybe also in the WPA3 OWE 
>>>> Transition network (yesterday lost a connection again).
>>>
>>> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
>>> roaming). However, now they don't disappear all after a shorter 
>>> while. It seems to be later.
>>>
>>> I also lost one device in a Router+Repeater WPA2 (CCMP) network. It 
>>> is confirmed here on router side, that the device is disconnected. 
>>> Since more than a day.
>>
>> We can't do anything without logs. If you suspect its the blacklist 
>> you can lower the blacklist time down in main.conf:
>>
>> [Blacklist]
>> MaximumTimeout=5
>>
>> But logs would be best, we would be able to see if that is whats 
>> happening or if its something else.
>>
>>
> I can also now see this on one of our local devices (which was 
> connected to Ethernet and WiFi).
>
> Please find attached the log. The logs start at late 23rd with the 
> image upgrade.
>
> I can see on our server side, that devices continuously connect and 
> disconnect again (missed heartbeat = hard loss of websocket 
> connection). I see some type of connection loop on client side too 
> ("org.eclipse.jetty.websocket.api.UpgradeException: 0 null" caused by 
> "java.util.concurrent.TimeoutException: DNS timeout 15000 ms"). Maybe 
> it alternates between Ethernet and WiFi. You will understand better. 
> Or the network is re-configured all the time.

Happens also on a device here without Ethernet connected. So there is no 
alternation. Just on-going connects and disconnects.


>
> Here is my local status:
>
> tavla@tavla:~$ iwctl station wlan0 show
>                                  Station: wlan0
> -------------------------------------------------------------------------------- 
>
>   Settable  Property Value
> -------------------------------------------------------------------------------- 
>
>             Scanning no
>             State connecting
>             Connected network     XYZ
>             No IP addresses       Is DHCP client configured?
>
> tavla@tavla:~$ networkctl status
> ●        State: routable
>   Online state: unknown
>        Address: 192.168.178.178 on eth0
>                 2a0a:a549:da80:0:fadc:7aff:fe67:2e4 on eth0
>                 fe80::fadc:7aff:fe67:2e4 on eth0
>                 fe80::c2ee:40ff:fe8a:dd62 on wlan0
>        Gateway: 192.168.178.1 on eth0
>                 fe80::3a10:d5ff:fe37:2c79 on eth0
>            DNS: 192.168.178.1
>            NTP: 192.168.178.1
> IDX LINK  TYPE     OPERATIONAL SETUP
>   1 lo    loopback carrier     unmanaged
>   2 eth0  ether    routable    configured
>   3 wlan0 wlan     no-carrier  unmanaged
>
> 3 links listed.
>
>>>
>>>>
>>>> We have 100% reproducable builds, test environments (testing 
>>>> sites), and web socket-based telemetry. Thus my feeling is, there 
>>>> is still something wrong with the BSS selection (maybe 
>>>> blacklisting)! Of course this can also be something about the 
>>>> driver (brcmfmac) or firmware (roaming?). Or can this be about IPv6 
>>>> disabled (my configuration below)?
>>>>
>>>> This is really really serious, I (still) lose connections to devices!
>>>>
>>>> I will investigate further and provide logs later today, if possible.
>>>>
>>>> SETUP:
>>>>
>>>> SoM: Variscite DART-IMX8M-PLUS
>>>> SoC: NXP i.MX8M Plus
>>>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>>>> Antenna: Laird FlexPIFA
>>>> RootFS: Debian bookworm
>>>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>>>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>>>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>>>> Network Daemon: systemd-networkd 252.30
>>>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411 + 
>>>> OWE and BSS selection patches) + ELL 0.69 
>>>> (7bed251f8020ef896043f008276f41cd13fdd43f)
>>>>
>>>> KERNEL:
>>>>
>>>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from 
>>>> https://github.com/varigit/linux-imx)
>>>> BRANCH=lf-6.1.y_var03
>>>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>>>
>>>> FIRMWARE:
>>>>
>>>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>>>
>>>> From: 
>>>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/
>>>>
>>>> IWD
>>>>
>>>> -----
>>>>
>>>> [General]
>>>> EnableNetworkConfiguration=true
>>>>
>>>> [Network]
>>>> NameResolvingService=systemd
>>>> EnableIPv6=false
>>>>
>>>> [DriverQuirks]
>>>> OweDisable=brcmfmac
>>>>
>>>> -----
>>>>
>>>> Best regards,
>>>>
>>>> Martin
>>>>
>>>>
