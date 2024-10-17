Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7551D9697
	for <iwd@lists.linux.dev>; Thu, 17 Oct 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162723; cv=none; b=HCkk1qd1/dAkZh/PC3c061du/ToL0P0hZFQaNgYmob2V2gULM7lxRggkeiky4Xjw+TeepA2lu57i4Zs+lzrr6ZAssq77VsJlP70rXjOYMMEcGKBSfNgw0baDlLzhyxTSPhR5W/k6yXZGV6SDE+oWwJcSF1xq0j1dMI57FC4MwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162723; c=relaxed/simple;
	bh=TBQHbn5CMPb6QYM4we9+AtYXOnMjh/o9Jzf53fRKNT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ835Jh7bCqUBBWdoTuWjSz0NaDTX4NsCvPoUsduvzzu8Az5E3uzeU3l9GfWAxDJ+vGpW+VK/eo/jSQstMR6hZ0KpMH9PjJJuib8cEYLaRvUVgitGS/lEXDfHY4t7fxxJbT9+mrtp7K3jB7ly0aw+C7D2VJs+5/Gm070JDE5BR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=TXOD3p7f; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="TXOD3p7f"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XTlF20vbKz9vFy;
	Thu, 17 Oct 2024 12:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729162710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1ORUtJSmo/n8vBVzzJ9CRuMJM+hBcTkji5XB67D8oM=;
	b=TXOD3p7f37+9ENwi47NEe2cUq2N7Y5Tn9PLHOpCV3PFVQebrYQ5XEIHNXMqX5O9c8OeATi
	137oTqZ2c/PeXiSFCp+5ezKLPLkkoTA5M5i2Hj2ry+mfM4JQE7cMw5hxq0ulLLv+sJMLla
	5jChzEQhp8fyLKX88feZ3Y6tZAnPKJsUNaiK76Bl7p+bb0bfqAnbf+Ytjh9xTk/STPK2pV
	JIrANmh8M4hGUedI00EVWqSQNAAGq3M+ruZ66X5KItyfLrMuTuD4xXavxslW7vRHyzyZHq
	vF25xJpH+QXbN7sP66D8OPuTy88sWPkhCSaeIZPLrAd5jbqLlGbgotnOPD5/iA==
Message-ID: <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
Date: Thu, 17 Oct 2024 12:58:28 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

Am 16.10.24 um 04:04 schrieb Denis Kenzior:
> Hi Arend,
>
>>>
>>> One may question why -67 AP was preferred over -29 one?  We'd need 
>>> logs to answer that question.  It could be the -29 one was simply 
>>> not seen in the scan results at the time of the initial scan / 
>>> connection.
>>
>> The roaming algorithm is not that intuitive. Roaming and rate 
>> selection are not based on signal strength alone. They may look at 
>> PER (packet error ratio) to decide. -29 dBm might actually be too 
>> strong. I always try to get between -40 and -60 dBm.
>
> I was mostly thinking of the initial BSS selection which iwd can 
> influence at initial CMD_CONNECT.  iwd sorts APs according to highest 
> expected throughput, but that generally means that if 2 APs are 
> identical, the one with better RSSI wins.  Still, without logs there's 
> no way of knowing why the lower rssi one was picked.
>
I think you should have a look at the initial selection. Because the 
connection to the router instead of repeater was on the initial boot and 
thus very first connect. I know this for sure, because we use our own 
OTA image upgrades and have our own remote device management with 
telemetry data. I also know about the place of the two at this site 
(repeater very close to our device). Later on, also after reboots, until 
now the device is always connected to the stronger repeater (glad about 
that). This is actually quite important issue for us, because our 
devices usually upgrades the image, boots once, and connects once. In 
the most common scenario the device will "never" reboot or re-connect again.

This is all about consumer grade router and repeater setup (I have no 
idea if there is any roaming protocol implemented on these devices). At 
the moment I can't provide logs, with significant overhead it would be 
possible to get them. Just now I can also not do another upgrade, 
however this may be the case next week again.

On Monday we will deploy to a Cisco enterprise grade roaming 
environment. Of course here also the APs and the roaming protocols will 
play an important role (802.11k/v/r right - and I have no clue about 
these protocols; I assume these are implemented in the firmware or 
brcmfmac driver, right?!). The building has quite thick walls and thus 
selection of best AP is uttermost important and was completely broken - 
however, this was older driver, older IWD and unfortunately with US 
configured as regulatory domain (we are in Germany). However, it was 
newest Laird firmware.

Thanks,

Martin

