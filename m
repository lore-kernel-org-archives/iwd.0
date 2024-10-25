Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82E1EABA8
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857680; cv=none; b=oae5kYneYwi6y2PP5jcobV5mD4cQaL08ePcS+Jl2Fznf0VdzeaxloGKKVjoa2U8dDq+UcGiI2pbp1+HxT6mH0SSiZWJRtef73EX1i6e0NTzI3GC1jR3BNhtbDpo8+JW2etca58cGBoqq0Zc+kr3mSGE3kdrf26dCRBRO7Hew+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857680; c=relaxed/simple;
	bh=HgqJZyoG6lEl6XxA81V/Hl458XG9Ba4v7r/Y3MWMIlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qB5ApdoM/4hEwHu4LepP7oyxuPVj7Wg226pn5kMi1tIx9FroRKrczfcawiHklsISHTOSgulrBPtqrgfJ2gCe49AP4JndevZ1e4i2d2BGstS1adoDnYV3N5IkZD7HmXkOcV8ixOvRacI3Ijy0SomYm69EyneIfwjQ9tTkfrm8/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=NuYFnzzq; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="NuYFnzzq"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4XZhFh1g9JzDtK7;
	Fri, 25 Oct 2024 14:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729857672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTjSfECITTHC5Ii/mshtJYA9EhrrK64p9PzJ+I2LtQM=;
	b=NuYFnzzqvIVQqJPPoKg9Q+eA+uOxZC7hB48sG+tu2br0oV7rg/lTy4On1eIdKCpl9ZiNzK
	/OEh7lFfElA32g1HfQjXs1lPqqigRYHusESgiPY9cCFUqcCDQygHKPj+EmPKN1XmyOTE5T
	M7HUeXRL0S4CPRBAFZIXB4imN6FtSfMOAplHstm+fkrVUnA8MxJ2SoZNEyQqmi2PwGToKE
	M3hrWSD1YpA51QBXS3aKAcmDv2vX4j2OMlN9QJzqoGqjlDbpEt/kqu3yc9qE/r+HclO2Ud
	MvORKB02TqsrRmUSS/4/ex5byLm3OKxEh1GmQp+BiHYjaicwDforzpq9gpYp5Q==
Message-ID: <134c0717-7708-411c-8455-53e70a889175@tavla.de>
Date: Fri, 25 Oct 2024 14:01:10 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: James Prestwood <prestwoj@gmail.com>
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
Content-Language: en-GB, de-DE
Cc: iwd@lists.linux.dev
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

Am 25.10.24 um 13:48 schrieb James Prestwood:
> Hi Martin,
>
> On 10/25/24 4:10 AM, Martin Petzold wrote:
>> Hi all,
>>
>> Am 25.10.24 um 12:12 schrieb Martin Petzold:
>>> Hi all,
>>>
>>> I open a new thread for this one: During the last weeks I have seen 
>>> connection losses for 30+ minutes, sometimes even hours or just now 
>>> even forever (IWD HEAD with v2 OWE / BSS selection patches). Driver 
>>> is brcmfmac (NXP 6.1.36 kernel) and chip is BCM4339 (Laird LWB5).
>>>
>>> It happens in a) single router environment (WPA2-PSK; Touchstone 
>>> TG3442DE), and b) router + repeater environment (WPA2 CCMP; 
>>> Fritz!Box + Fritz!Repeater), and maybe also in the WPA3 OWE 
>>> Transition network (yesterday lost a connection again).
>>
>> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
>> roaming). However, now they don't disappear all after a shorter 
>> while. It seems to be later.
>>
>> I also lost one device in a Router+Repeater WPA2 (CCMP) network. It 
>> is confirmed here on router side, that the device is disconnected. 
>> Since more than a day.
>
> We can't do anything without logs. If you suspect its the blacklist 
> you can lower the blacklist time down in main.conf:
>
> [Blacklist]
> MaximumTimeout=5
>
> But logs would be best, we would be able to see if that is whats 
> happening or if its something else.
>
I will provide logs at 17:30 CET. Hopefully they go far enough back.

>>
>>>
>>> We have 100% reproducable builds, test environments (testing sites), 
>>> and web socket-based telemetry. Thus my feeling is, there is still 
>>> something wrong with the BSS selection (maybe blacklisting)! Of 
>>> course this can also be something about the driver (brcmfmac) or 
>>> firmware (roaming?). Or can this be about IPv6 disabled (my 
>>> configuration below)?
>>>
>>> This is really really serious, I (still) lose connections to devices!
>>>
>>> I will investigate further and provide logs later today, if possible.
>>>
>>> SETUP:
>>>
>>> SoM: Variscite DART-IMX8M-PLUS
>>> SoC: NXP i.MX8M Plus
>>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>>> Antenna: Laird FlexPIFA
>>> RootFS: Debian bookworm
>>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>>> Network Daemon: systemd-networkd 252.30
>>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411 + 
>>> OWE and BSS selection patches) + ELL 0.69 
>>> (7bed251f8020ef896043f008276f41cd13fdd43f)
>>>
>>> KERNEL:
>>>
>>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from 
>>> https://github.com/varigit/linux-imx)
>>> BRANCH=lf-6.1.y_var03
>>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>>
>>> FIRMWARE:
>>>
>>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>>
>>> From: 
>>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/
>>>
>>> IWD
>>>
>>> -----
>>>
>>> [General]
>>> EnableNetworkConfiguration=true
>>>
>>> [Network]
>>> NameResolvingService=systemd
>>> EnableIPv6=false
>>>
>>> [DriverQuirks]
>>> OweDisable=brcmfmac
>>>
>>> -----
>>>
>>> Best regards,
>>>
>>> Martin
>>>
>>>
>
