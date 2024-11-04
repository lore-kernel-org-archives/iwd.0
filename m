Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43B33FE
	for <iwd@lists.linux.dev>; Mon,  4 Nov 2024 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730681543; cv=none; b=kJjkBmK9S3WWBTGgGUmQ1k6TBT9MqiiuEpWnev1BWKDYokjtciupFGWrcEP/nOXpQmkT8NP4YSJJ/kAkFKcHCKgsiL7JK0G2DuXrfE7pC10UAo2+B38LkTYN5o96jAPfIPkzK549C9ISD5Q99QDvq06lhCfqO2MZ+MmBoya4a94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730681543; c=relaxed/simple;
	bh=f9RMigdYzAJi5EYgt0b+yzIIxWtztyh6b/2c+ZbIF5Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RP5eU3llEqVXfKqnmDllR0wRgrjSRgznNt0NhMue1TBa/mKkVCIlI5fcm/2LWocGO+PM39Ac3FElw+5eo290TBi0POsq0QNMgqs6Jwwv24AA7VC/LWMbOjdFLe6PtecMRgmzCvn8IuWI9cQWmP7JtOPOD+XrQ/amoUE/KcYxVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=B+9tne4N; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="B+9tne4N"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XhXlF4rFgzDtyn;
	Mon,  4 Nov 2024 01:43:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730681017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRKNCLHEYT3O2Shoh+zZVeS9vEPy3HZi0Ck5xIH0JTU=;
	b=B+9tne4Nos9i5yN2XPsAAuCvFoxUe88WzPl3WBNFO7RkfmD1fvU42BxaNu8APoxol+iKMe
	lCmTjerliB2cNQOGVm55eh6u4QdlcqWV5Cy2p6e9vxeypfg2yqgbFLbwHOq1sY9XGekH3O
	4dErAbHmNAq4NZHp9qdRkZ/HcYlJmhi/D67ypveaqp0KqiVcUDjcQiI8+wVcH2H+DdEkgL
	luahTERoB3UW15KDaksPQZlXKAsda815d7pYxff6eCIPDSAAjdRlZybYy+L8P7orQTpgua
	TxU48nM5H9XvOEFrPFQI4V8uLJy63NzXG/jPBcpaOxbn0XKC0Dqwa+VjhJibag==
Message-ID: <62016eb5-dbd2-49ab-b0c6-7dcf153cdf0b@tavla.de>
Date: Mon, 4 Nov 2024 01:43:35 +0100
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
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <f9ca5733-7cda-4494-8b6d-7a4de4157da2@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear James,

Am 04.11.24 um 00:13 schrieb Martin Petzold:
> Dear James,
>
> Am 25.10.24 um 17:17 schrieb James Prestwood:
>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I open a new thread for this one: During the last weeks I 
>>>>>>>>>> have seen connection losses for 30+ minutes, sometimes even 
>>>>>>>>>> hours or just now even forever (IWD HEAD with v2 OWE / BSS 
>>>>>>>>>> selection patches). Driver is brcmfmac (NXP 6.1.36 kernel) 
>>>>>>>>>> and chip is BCM4339 (Laird LWB5).
>>>>>>>>>>
>>>>>>>>>> It happens in a) single router environment (WPA2-PSK; 
>>>>>>>>>> Touchstone TG3442DE), and b) router + repeater environment 
>>>>>>>>>> (WPA2 CCMP; Fritz!Box + Fritz!Repeater), and maybe also in 
>>>>>>>>>> the WPA3 OWE Transition network (yesterday lost a connection 
>>>>>>>>>> again).
>>>>>>>>>
>>>>>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
>>>>>>>>> roaming). However, now they don't disappear all after a 
>>>>>>>>> shorter while. It seems to be later.
>>>>>>>>>
>>>>>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) 
>>>>>>>>> network. It is confirmed here on router side, that the device 
>>>>>>>>> is disconnected. Since more than a day.
>>>>>>>>
>>>>>>>> We can't do anything without logs. If you suspect its the 
>>>>>>>> blacklist you can lower the blacklist time down in main.conf:
>>>>>>>>
>>>>>>>> [
>
> I am still losing devices. Sometimes they come back again, but mostly 
> do not re-connect. I have observed the following:
>
> - Connection exists for several hours until about one day, or two. 
> Then gone for several hours or mostly forever.
> - For FritzBox+FritzRepeater I have seen the connection coming back 
> after like a day (here connection loss was also confirmed on router 
> side!)
> - For the Aruba enterprise environment the connection never came back 
> (until now no AP logs - waiting for an answer)
> - After reboot the connection comes back
> - It occurs only in an environment with multiple APs with same SSID 
> (i.e. roaming environment), however my single AP environments have all 
> strong signal
> - Some devices with identical configuration in this environment DO NOT 
> get lost, those seem to have quite strong signal (maybe they don't roam)
> - Other devices in the same environment work without any problems 
> (Intel+NetworkManager) and the APs are Aruba enterprise grade
> - I see almost the same in the Aruba enterprise environment, but ALSO 
> in a FritzBox + FritzRepeater environment
> - We had a bug in our web socket connection, causing to many IWD 
> requests. However, this was fixed. And why are all the other devices 
> okay? Maybe co-incidence with roaming and anything related to dropping 
> and re-connecting web socket connection.
>
> Please find attached my currently available debug logs (they are a few 
> days old, but I am quite sure this is the connection loss situation). 
> These logs are from the FritzBox+FritzRepeater environment. There are 
> no brcmfmac messages (but also no special debug level configured here)!

After this there are no more log entries from IWD, but system us up. IWD 
may have crashed or is there a deadlock?

If there is roaming, why does IWD do anything if brcmfmac should handle 
roaming? Or does brcmfmac fail to roam?

>
> I have now also disabled WiFi power saving and will deploy to the 
> environment...hoping the best.
>
> Maybe you could check the logs and have an idea?
>
> -----
>
> SETUP:
>
> SoM: Variscite DART-IMX8M-PLUS
> SoC: NXP i.MX8M Plus
> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
> Antenna: Laird FlexPIFA
> RootFS: Debian bookworm
> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
> Driver: brcmfmac (from Kernel, only minor patches - device tree)
> Firmware: Laird 12.29.0.22
> Network Daemon: systemd-networkd 252.30
> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411 + 
> OWE and BSS selection patches) + ELL 0.69 
> (7bed251f8020ef896043f008276f41cd13fdd43f)
>
> KERNEL:
>
> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from 
> https://github.com/varigit/linux-imx)
> BRANCH=lf-6.1.y_var03
> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>
> FIRMWARE:
>
> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>
> From: 
> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/
>
> IWD
>
> -----
>
> [General]
> EnableNetworkConfiguration=true
>
> [Network]
> NameResolvingService=systemd
> EnableIPv6=false
>
> [DriverQuirks]
> OweDisable=brcmfmac
>
> -----
>
> Thanks,
>
> Martin
>
