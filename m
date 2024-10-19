Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208FC2E9
	for <iwd@lists.linux.dev>; Sat, 19 Oct 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347122; cv=none; b=oJm/Od2TLyS0AWi8ZGGgc+suYQKeZPqefcDBhit4+sJz3iS+cqrBmlianIjVDkSWz+Df2uz29DI75FW7nnAXdreURUl2k8qIuwFWP9FngBL0lxaDbLrsL1S7vK4Im0S6f7sITsiA71HDyaD5Y0Yrvw486sfJ3pNZepvyC0yCYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347122; c=relaxed/simple;
	bh=pl8qRr9xTQTdCnIyJpjrTIxxdG4Zd6Pva/SMx8x/kl0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IW6iiGyYz4RTvlHEfNDFKf+UAaHX7CpZ3OVJftiRapHfkAJjBprrK1sxNwUuuAs9epnXU8KtdxDHtpzO5eUcqLwIC/fFgHuHSlhs52mffIo6njL3siJpUXy9mli4YoFxIdeqhaGFqw9t7G0Xg26SSJ7po0aHzixDZVZEo1Q5R8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=lJ13scGh; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="lJ13scGh"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4XW3H05tq1z9xHd;
	Sat, 19 Oct 2024 16:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729346684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuRWXNXKhs1eEtCOMlNiJZU1R1li038XvA5kf5TYQWo=;
	b=lJ13scGhRkC12+7fj4Uvb6RgzV1h7igHjS23jX/erCKLih72TXas8l/2YOGIGgU/HddCsU
	po6u3dHTeA8K2LB1/M4YPlw2vUXrX1452NqetD9qE8DuhTr9++c6wdbl/X2BFNvFW2utS4
	O3egjTCrRCgKuYoZHAXbLEosDA96nIpg1eiq93/xdbZGNPk4yeehDVRo+HKoQeCsQpduTC
	1w86AtmxgUqBeSgCAu1Y7+pATJrpGu8dmBHfj/mTHIlYsg3d0OoChB6o+GwfsrUyEwJrFY
	LRktcoJuALCNu99pMXXtElDuOcSlLnNDz8xSUrZexIqIa3nDRte1thabPFDZbQ==
Message-ID: <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
Date: Sat, 19 Oct 2024 16:04:43 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
From: Martin Petzold <martin.petzold@tavla.de>
To: Denis Kenzior <denkenz@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

Am 17.10.24 um 12:58 schrieb Martin Petzold:
> Hi Denis,
>
> Am 16.10.24 um 04:04 schrieb Denis Kenzior:
>> Hi Arend,
>>
>>>>
>>>> One may question why -67 AP was preferred over -29 one? We'd need 
>>>> logs to answer that question.  It could be the -29 one was simply 
>>>> not seen in the scan results at the time of the initial scan / 
>>>> connection.
>>>
>>> The roaming algorithm is not that intuitive. Roaming and rate 
>>> selection are not based on signal strength alone. They may look at 
>>> PER (packet error ratio) to decide. -29 dBm might actually be too 
>>> strong. I always try to get between -40 and -60 dBm.
>>
>> I was mostly thinking of the initial BSS selection which iwd can 
>> influence at initial CMD_CONNECT.  iwd sorts APs according to highest 
>> expected throughput, but that generally means that if 2 APs are 
>> identical, the one with better RSSI wins.  Still, without logs 
>> there's no way of knowing why the lower rssi one was picked.
>>
> I think you should have a look at the initial selection. Because the 
> connection to the router instead of repeater was on the initial boot 
> and thus very first connect. I know this for sure, because we use our 
> own OTA image upgrades and have our own remote device management with 
> telemetry data. I also know about the place of the two at this site 
> (repeater very close to our device). Later on, also after reboots, 
> until now the device is always connected to the stronger repeater 
> (glad about that). This is actually quite important issue for us, 
> because our devices usually upgrades the image, boots once, and 
> connects once. In the most common scenario the device will "never" 
> reboot or re-connect again.
>
> This is all about consumer grade router and repeater setup (I have no 
> idea if there is any roaming protocol implemented on these devices). 
> At the moment I can't provide logs, with significant overhead it would 
> be possible to get them. Just now I can also not do another upgrade, 
> however this may be the case next week again.
>
Additional information about our setup: We do OTA rootfs image upgrades. 
So the whole rootfs (including /var) is replaced. AND after reboot we 
always have a fresh setup an initial boot again (systemd "firstboot"). 
Here also machine id and other things are re-created. We ONLY preserve 
the "/var/lib/iwd" directory (and bluetooth etc.) on a separate 
partition and use bind mounts (in fstab) to include this path under "/".

So maybe for IWD it is uncommon to find a "known-network" on firstboot 
(typically not possible). Or maybe some kind of BSS information is 
cached and then gone because of our rootfs upgrade. Or it is about the 
change of machine id (MAC address in our case remains the same, because 
it comes from the chip). Maybe if you have a known-network, you assume 
the BSS cache has to exist (been built) already. No ideas, something 
like this...

This is a more or less common setup for embedded environments. Would be 
glad if you could double-check if this could cause wrong initial 
connection (weaker AP).

I will let you know about further tests next week.

Thanks,

Martin

