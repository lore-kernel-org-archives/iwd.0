Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716516419
	for <iwd@lists.linux.dev>; Tue,  2 Jul 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907287; cv=none; b=b20jE99cEM/rfwnZIgJpyahj2cnHhStDlXu8k4f+zLPnFaZx8i3KMurFZUuD5t2kgwIvDrIbsLRdjWAknKOE/Ijic0ID23U+WILUPnxfhqKc4gNU3shMepnXS4XxTWjM+NryoqzhmKMF++TZzmxmxDs+mpJBBfkrDy5HgIfvVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907287; c=relaxed/simple;
	bh=Yz4J2nWKmbG4164GgfCTICTyAJXaQpfOx8WgllvGBmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=J51ETHbDmEOUWxs2NhCIj6IcL41iKnOyYOgml4ElYJGv9yQkefaP3rrvd6Y/wJ6DVtRTTIRKJg7pXq7U+YTE+71MfKhV4uL4okgGQPy1kaceEXLjiQD/xOYUPxtR0XlTcyWQ0YyDmjPFWMGjs5dUAM1f3hbCouaMU+/wm6jn5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=FCHEVmvx; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="FCHEVmvx"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4WCw9H6NnBzDtXD;
	Tue,  2 Jul 2024 09:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1719906723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IeWLXPMW4kiLX4mb+t2Nuy1KQY+LW9Htd1AaVXtocc=;
	b=FCHEVmvxfIQLo1DqBgtcBWN7gSMVjEon/h29n3zHY7/mj5z2zN98yePef2DXM5Scd1Wjkl
	r0riRG8190+PCZggdxcPHqYLw7S/Di3v/uAFY8tsrjVQVh5gix5DrmfthUrCx+X3pXTWW4
	CeU16Fr2mdd/BsiqTJ4URV1alwQ2cuK8eLR3w3MNr01v5I5+Z1NWUEI6D51Oxn4potG3fO
	IwDR0M/jfvppislF2FXcpPqFa+71Tp84yPnZGyv7VLq5uT2vpZ4hwUjFyBn2gNyQqDn6bf
	AiJUSzNIc/S0uWN4BUGOCLFQ4Zq9/OkEfaY7Y4OJd3E8Irv2lsRf/OVHwoLKHw==
Message-ID: <8c7ff992-2f03-4e4f-97bc-36eab3727d44@tavla.de>
Date: Tue, 2 Jul 2024 09:52:02 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: No re-connect using systemd-networkd and IWD
To: Denis Kenzior <denkenz@gmail.com>
References: <e088f7e6-c455-4635-9edd-a51c619654d4@tavla.de>
 <c8cc4e80-1f3e-4393-8e21-54804628f5b0@gmail.com>
Content-Language: en-GB, de-DE
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <c8cc4e80-1f3e-4393-8e21-54804628f5b0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WCw9H6NnBzDtXD

Hi Denis,

to sum-up: We think there is such a serious issue in IWD 1.14. We can 
reproduce that IWD does not re-connect if we hard-kill the network 
(either by pulling the power of the router or just renaming the SSID 
back and forth). Work-around may be our configuration in certain setups 
(see below). Maybe worth fixing this for Debian bullseye 1.14.

Am 26.06.24 um 16:57 schrieb Denis Kenzior:
> Hi Martin,
>
> On 6/26/24 4:24 AM, Martin Petzold wrote:
>> Dear all,
>>
>> I have some serious issues with the Wi-Fi connection using 
>> systemd-networkd and IWD. Our devices are fixed at a place and have 
>> only a single Wi-Fi network configured. There is also an Ethernet 
>> device, but no cable connected. Wi-Fi configuration and connection 
>> work well using iwctl. However, some of our devices lose the 
>> connection to this network and DO NOT re-connect. We have seen this 
>> with several devices and different routers. Some devices also do not 
>> have this problem. It seems to depend on the stability of the 
>> connection. But I am also talking about this issue like 1m away from 
>> the router - for such devices only rarely.
>>
>> SETUP
>>
>> SoM: Variscite DART-IMX8M-PLUS
>> SoC: NXP i.MX8M Plus
>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>> Antenna: Laird FlexPIFA
>> RootFS: Debian bullseye
>> Kernel: NXP Kernel 5.10.52
>> Driver: Laird 8.2.0.16
>> Network Daemon: systemd-networkd 247.x
>> Wi-Fi Daemon: IWD 1.14
>
> Is iwd version really that old?  We're at 2.18 now.

Yes, because it is the default package in Debian bullseye. We will now 
switch to Debian bookworm with IWD 2.3.

>
> What kind of authentication is being used on the network? PSK or 
> 802.1X?  Do you have logs (preferably with debugging enabled) around 
> the time this happens?
>
WPA2-PSK
>>
>> CONFIGURATION
>>
>> -> Blacklisted "brcmfmac" kernel module
>> -> Enabled Kernel "Networking support > RF switch subsystem support" 
>> (but as far as I understand the Laird driver does not support RF Kill)
>> -> Added [Scan] and [Blacklist] section later, problem still exists 
>> (however, I could reproduce that re-connect works better if I switch 
>> on/off Wi-Fi SSID)
>
> These options were added to take care of certain routers misbehaving.  
> For example, one of the APs in an ESS not responding to association 
> requests but still sending beacons / probe responses.  Modifying the 
> parameters from defaults should not be generally necessary, I think?
>
We are not 100% sure, but maybe these "[Scan]" and / or "[Blacklist]" 
options actually solve our problem. I would recommend these options to 
everyone having this re-connect problem using a fixed device setup and 
single WiFi network.
>>
>> ##### /etc/systemd/network/20-wlan0.network
>>
>> [Match]
>> Name=wlan0
>>
>> [Network]
>> DHCP=yes
>>
>> [Link]
>> RequiredForOnline=no
>>
>> ##### /etc/iwd/main.conf
>>
>> [General]
>> UseDefaultInterface=true
>>
>> [Network]
>> NameResolvingService=systemd
>>
>> [Scan]
>> InitialPeriodicScanInterval=10
>> MaximumPeriodicScanInterval=10
>>
>
> This will just make iwd scan more aggressively, without fixing the 
> underlying issue.  Aggressive scanning isn't really necessary unless 
> you're moving through your environment very fast.  You mentioned that 
> your devices are stationary.
It does not seem to re-connect. Thus, maybe it does not detect the 
network anymore. Just now I can't say if "[Scan]" or the “[Blacklist]“ 
options help.
>
>> [Blacklist]
>> InitialTimeout=10
>> MaximumTimeout=10
It would make sense that this helps, because we are talking about 
"currently misbehaving or misconfigured". Maybe IWD 1.14 is far far to 
aggressive (or in terms of network loss miss-behaving) regarding 
unstable connections.
>>
>> #####
>>
>> OPTIONS
>>
>> A. Try "IgnoreCarrierLoss=5s" in systemd -> but this is not about 
>> re-connect
>> B. Switch to Debian Bookworm (with systemd  and IWD ) and NXP Kernel 
>> 6.1.36 -> is already WIP
>> C. Switch to new Laird firmware 11.x
>>
>> -> Which option could be promising?
>> -> Do you have any other idea, how to address this issue?
>>
>
> Upgrading to latest iwd and logs [1] of the issue occurring would be 
> the steps I'd start with.

We will switch to newer kernel and IWD 2.3 as well as newer 
systemd-networkd very soon - already in testing. We will then also test 
the scenario again without these configuration parameters. We may also 
have some time to check logs and run more tests with debug enabled.

Best regards,

Martin

