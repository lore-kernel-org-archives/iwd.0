Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76241BD9D4
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319994; cv=none; b=oDN0MAJ7WIY86iCdp4MG0PALNy4y4e4saCTAJEDZOImSiqFMoQO51yPK5xf5u/gLE0+pkaSdanAF/nRvLoDogjfNDAKb1/zNMH1/GIB0b9RwHZ4XpaxVKEO7BQIBgBFj0pPkMDY2sITuG+ngX17hz6Cs5qUBnd30GMaZMgkbSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319994; c=relaxed/simple;
	bh=e0G1x0IK5cjudKiN7dqLFWHefyScX8CV9r0wfbSL5dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNtTtEOPixZLxAKIPrcvjcPihmtWPg/35xwZ+hGMzeboMKwquNY0RCqdOaw+FJqEb6jBw9awjPFCnctxN2gn31MI1O8Omy+WrByIdqgRSCJDf4nTJlFDmknsqD1hQLtxq8jlW2A52zVb6a/LyN3H7LFApL1+Nv3n9+FSZsFpea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=kBLQwOkk; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="kBLQwOkk"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4XdzDD5pK2z9vtP;
	Wed, 30 Oct 2024 21:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730319980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOv9JILfUVEQwImu9ovS7T6bq0bc/v1YGP6klM990uY=;
	b=kBLQwOkkYU9W61pulGGtPzEX3dJ0c4e/3+XqmLzAZY97LOdr/KiKXBwYNjhu1LGl57OESP
	mTCIO1N58hmjIFSpmhaDhbwQdhbqDonYccvmmZu6+jXWiwLP8hFLb3GzV45hjkl/Cbhy/w
	Lr+AcwQ+UC2hDJH/MzmZwOC3v0Ui7i3FxEufLb+IP8ME/xhSHap/J/+yhrdi2f31EX2OzP
	WYJq8rc7pcJwRMBa9Xg1xPcYvrtu/ZxUzNj/cenpstGyywVevQIDZB4tLPyYlO3TDOJ7WO
	tmO0p81+WJ6aPj6nfORhmFCt4jxOiX7N06OVHOQTcpUi73YWFI37jEraTB1b+A==
Message-ID: <5e9122b7-dcee-4e98-8b8f-9c623276a5db@tavla.de>
Date: Wed, 30 Oct 2024 21:26:19 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
 <bc387186-dbd6-4ab3-adfa-2a8d0f7bcc71@gmail.com>
 <629def8d-2c7b-483c-8e2d-d73467a14486@tavla.de>
 <b134a703-6747-4b1a-a022-b61f7e282bfa@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <b134a703-6747-4b1a-a022-b61f7e282bfa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

Am 30.10.24 um 21:15 schrieb James Prestwood:
> Hi Martin,
>
> <snip>
>> Okt 30 21:10:43 tavla iwd[1212]: Wireless daemon version 2.3
> Your using IWD version 2.3 which doesn't support that.

Okay, thanks. This was another machine (Intel wifi) with not most recent 
image.

I have tested "PowerSaveDisable=brcmfmac" option on the machine with IWD 
2.22+ and it works as expected.

Is this feature actually a IWD featuer or rather a kernel driver 
feature? Does the brcmfmac driver have something like this, because with 
modinfo there is no related parameter?

However, on the Intel machine I also wonder why the following doesn't 
work also:

-----

tavla@tavla:~$ sudo reboot
[...]
tavla@tavla:~$ cat /etc/modprobe.d/iwlwifi_power_save.conf
options iwlwifi power_save=0
tavla@tavla:~$
tavla@tavla:~$ sudo iw wlan0 get power_save
Power save: on

-----

Thanks,

Martin

