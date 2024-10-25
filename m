Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB2231C8C
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859623; cv=none; b=WmWMpq2RvP9cmc8Jyg/0iDIp7ITD0vXrckRTxWPufwT/3mWUo+hCNbkrj8hPnOkpIas83lY2wWWb4slRETUsr93oXqWN5MJl8Acs9R0P53SuGk2erNOewfpId/VyRHOo0G1/3vD9/Ulb2S2e8wUqEEkeibN3Rsr98oCGY0IyN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859623; c=relaxed/simple;
	bh=fYISCFr1RpYlDmtDCPvR1QGNHyraBtYy4Sz9ZvjCRh8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iLyZp5SNTit8WuGz1iuDNtAmvPAjd3iQ8tsYNf4hgmt80vfg0sKhVg3A5s0vTvA95nD9vcrzuiS7DqdZCwZmZVRUQ+MeXrTXvEbrWnHG+dx4x8xoJNPc9PIw3kpvPWftAJ0beXPqQ038K6JsAaX7fdz8RieJEpAD92jZa1OwoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=bxMS1tz/; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="bxMS1tz/"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XZhyx0mYyz9vfd;
	Fri, 25 Oct 2024 14:33:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729859609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YETVyZINsz3i16CwFrnC32g87SS0PP+B0ECNxVKMIAI=;
	b=bxMS1tz/TRgPxaqHdYbMjBh/2w3EXLkOWF02tSo29/G1sNjVnFbEPzR7DXIfHZG2A8+KNI
	NFmTlw+gQcbuPT0clchooWWk5SXVB3ix+2lB13jUGbwDzTQ3hKw1B6jAe9sRjUfna/QFfR
	ANULvFBdKF6Z9WNbem3Kp/Ps9IW7zDbpyR73u8uWi1QoXhq1uW9k2bU8FkY9t751XNms5+
	VKcw5d4p8NhTwkuU13dXTyaEv+LVNeKCmhMXql6uZQ45lhcVQ+s3CU7qv7sAmZZY5cuHZ8
	Wdg30pHwieA/xiTyKjfwDCvQRxRpj3Jw2SgLamVocK3mTxWAppriC6zUGND3YQ==
Message-ID: <7ff6147b-6b20-44e5-896d-3f1c76f81d86@tavla.de>
Date: Fri, 25 Oct 2024 14:33:28 +0200
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

Maybe also blacklisted on AP / router side because of this behaviour.

But I was also always wondering how your blacklisting works. Maybe you 
could explain? Does this also take into account network connection 
quality parameters?

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
