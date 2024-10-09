Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE40152E1C
	for <iwd@lists.linux.dev>; Wed,  9 Oct 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496489; cv=none; b=ZDYVVZ/4GruMFIjwAHlE+l29F0VuMUeENnkWRyREPyI5XyDqOYDBCxoO3/eEQLxzwEoxJuRLOQlHupq/BJIoQiuKbAeHCYaP/aniByKQnU340qpgHRU8Ij7fdNOItvjor9wFE6E29P/1UpwFM1UT4xr3VY63ucbDkMpnO86C07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496489; c=relaxed/simple;
	bh=gIDmmFsSY+7K9SYlxxbuT/Nw2sciyzr8R5/IhKTfE2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NZeLHO3zpTCvzko9WT6yI0mXAFDopc3XOvBmLpbVmIeN/xvl+gtOv5wcm0GHSM2l66KX2dhNEr1mfyXXevx1VJQXzlSJq7BR65FHWcuSnQQyurgxv+F//oIW1aK4VHOsIMGSNx7oaQjn4BRWwgO5jMXhLc5qwdqNDo2ZRgKAtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=BcMib3+3; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="BcMib3+3"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XP0rx3DTVz9vc2;
	Wed,  9 Oct 2024 19:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1728496481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULSCrhxGklgHHQxJwjTlbwi2YSyWr294LSQoNiF+7Bs=;
	b=BcMib3+3am/JWQmMvoBrICrueZZO6IPAZ/GPojJgZhHrkjt3v3Mw8AHbCjX2/8k3ZKFDzU
	TC0ax2Ok4F/9DtkZ6dLUDM6z/rtFM5LMjVjmmZ+BnUkit/ObMmS27AFKn7tGprBFWqKpRm
	bBdqF9hu2gZNtUGwHQwYankt2ucKd2xXbqis5CcNaV69rwruikIDYpRCt4QDOuNNMauZ6d
	IAceoj/9ZRTx5tEuN+zNjLLWML2QgeL3If7/Y/7X3csfZ8wywZcGB1p0V7dXdM42AKH5gx
	rtzNTA7WhkxboeI591qvjHh+Ks+8OO7qf0Q53AFe2kXJA5iYNUIYQ388vAWSew==
Message-ID: <2257767f-85d8-4529-a4cd-4368c8405b92@tavla.de>
Date: Wed, 9 Oct 2024 19:54:39 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <19272307f90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
In-Reply-To: <19272307f90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XP0rx3DTVz9vc2

Hi Arend,

Am 09.10.24 um 18:50 schrieb Arend Van Spriel:
> On October 9, 2024 6:07:16 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
>> Hi Martin,
>>
>> On 10/9/24 4:43 AM, Martin Petzold wrote:
>>> Hi
>>>
>>> PROBLEM
>>>
>>> We (still) have some trouble with IWD together with brcmfmac. We 
>>> updated
>>> firmware for the chip (Infineon CYW43353) to latest version 
>>> 11.171.0.24 and also
>>
>> Ugh :)  That stuff is known to be problematic.  You might want to 
>> involve Arend
>> in this discussion.
>
> Is this specifically related to WPA3 or in general? The version does 
> not tell me much and I don't have access to Infineon firmware to 
> examine. I do know there are two variants floating around regarding 
> WPA3-SAE support: 1) supplicant in firmware and 2) using EXT_AUTH. The 
> latter is supported in  downstream repo on github, but it has not been 
> done in upstream linux-wireless. I did post patches for testing last 
> month.
>
This is my setup and roaming is completely broken (randomly connects to 
worse AP; drops connection; even does not connect at all to Cisco AP; a 
client switched to Cisco AP and now it does not connect at all any more; 
we have checked the AP setup of course):

SoM: Variscite DART-IMX8M-PLUS
SoC: NXP i.MX8M Plus
Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
Antenna: Laird FlexPIFA
RootFS: Debian bullseye
Kernel: NXP Kernel 5.10.52
Firmware: Laird 11.171.0.24 (loaded using brcm-patchram-plus)
Driver: brcmfmac
Network Daemon: systemd-networkd 252.x
Wi-Fi Daemon: IWD 1.27

Network: Open network with several APs roaming (no security); but also 
happens with WPA2 network and router+repeater (jumps to router sometimes).

I did not configure anything regarding brcmfmac or firmware, except of:

sed -i "s^ccode=.*^ccode=EU^" 
${ROOTDIR}/lib/firmware/brcm/brcmfmac4339-sdio.txt
sed -i "s^regrev=.*^regrev=116^" 
${ROOTDIR}/lib/firmware/brcm/brcmfmac4339-sdio.txt

and IWD:

-----

[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
EnableIPv6=false

[Scan]
InitialPeriodicScanInterval=10
MaximumPeriodicScanInterval=60

[Blacklist]
InitialTimeout=60
MaximumTimeout=3600

-----

Just now trying to migrate to NXP Kernel 6.1.36 on Debian bookworm 
rootfs. There is newer brcmfmac driver then (from Kernel right?) and IWD 
(at least 2.3). Then I am getting closer most recent versions of 
everything. I will then check and also track all logs again.

However, I was wondering if IWD + brcmfmac is actually working in 
general? Found some issues related [1,2].

[1] https://lore.kernel.org/all/6679878.YKXMNv7jBj@mmm/T/
[2] 
https://lore.kernel.org/r/all/07f49420-74e8-4954-bd87-9ae3290e86d3@app.fastmail.com/T/

Thanks,

Martin

