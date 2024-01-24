Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF418C01
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091510; cv=none; b=FQw+bcTrm5qj5uDhxGIZKAux23I5ZT3FXrHBZfidZAFVOFLNvcdpFk0sBm75i1jkhmf+iroO/aw9An2DJyl8F7WCc6qme2TwrLlI4N8AHb81KqHY1J1+P9WUNK7/Yabx7nphxVZODQC036peHFrpoortra3kvyZ+G3GJnGlZBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091510; c=relaxed/simple;
	bh=gVeIkSdpQBPdio/ErIBkyJwUgW9Fi7B7Yvx4YytTAJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoR+EUeXJuRMR5BlAxbO8mHk9BASBOq1fNZMVBDt0jZkkh7RUTkp2sMP5u3GVdvgC+gE1n/9wJCrxcS+ohFgYOR/0kfc4/9qeLVaVMo7ONlBAnZtGglbBLHdQtzVvrDkiWiP+8WjVyL7GOHY9H6XdIu3jZghe4/G8+af0OASSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aOjhj0Az; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aOjhj0Az"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19038E0003;
	Wed, 24 Jan 2024 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706091505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/9ymQtPQSi+EclGQCJzQslybH0Lcm8HoJav9tZmdjA=;
	b=aOjhj0Az0EdO+DQ97PennyHeL1IZKAZ3/F1pMuIrPJ5bGn7yPKifs2yPIRBAL8Nat1cWZo
	bixldvMUkKJ4HhA+OS8nfW1SQKv5Cyvd0CpF3+hUD3pEqdGKrWJl5VvsM5QNV9Lpopua+4
	sFeAtsMxG+eDtXYLhHn5FVfmojkpyDxLSN3crLU/j6GDAyvbkFHR4HCJUTg8tTnIElYvBz
	nemVmUDS0KiEBNoTmn0qeUGFDf2I5T8FunucJnCG6AkykYfsCnzh++s9ThGpZwr5XG1yIl
	bosdt+grtkVDuFoiICOz8acg+CinmwRlROSfxRxFpATbg3SQg0BVGmphtJdMbQ==
Message-ID: <46d06d59-3695-4062-aebe-7e124fa67446@bootlin.com>
Date: Wed, 24 Jan 2024 11:18:24 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iwd: unable to start AP with NXP 88W9098 chipset
Content-Language: en-US, fr
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: gregory.clement@bootlin.com
References: <6c9b05a2-7474-4eed-bb74-6f5de1d433ba@bootlin.com>
 <c11d1310-a0ca-46a2-b08e-d1e35351826a@gmail.com>
 <8c484950-c99d-47c0-b048-5a447cffd719@bootlin.com>
 <edd63888-bf1f-440f-98d1-3fc33fc2b609@bootlin.com>
 <2f3e11c6-bcf8-43fc-82a1-afe836d37a2d@gmail.com>
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <2f3e11c6-bcf8-43fc-82a1-afe836d37a2d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: joaomarcos.costa@bootlin.com

Hi James,

On 1/19/24 18:44, James Prestwood wrote:

[...]

>
> Prior to me adding HT (high throughput) IWD's AP mode was just using 
> basic rates, so very slow. I added HT support, but apparently not all 
> drivers were happy about it. So DisableHT removes the extra stuff that 
> allows it to work with this specific driver, but at the cost of 
> performance.
>
> I'm not really in a position to devote a lot of time to AP mode at the 
> moment. I know we've gotten a lot of inquiries about it recently but 
> to be completely honest if your intent is to run a full fledged access 
> point hostapd is really the tool to use. I'd love to get IWD up to the 
> same level of quality and support as hostapd but its a massive 
> undertaking. Not only that but out of tree driver support is something 
> very hard to get right. Hostapd has been around long enough and is the 
> de-factor software for APs that hardware vendors have added their 
> quirks here and there, IWD doesn't have that luxury.
>
> Thanks,
>
> James

Thanks for this insight. I'll keep DisableHT for my tests, then.

However, there's still something I don't quite understand. I'm trying to 
set up this AP:

[General]
DisableHT=true
Channel=36

[Security]
Passphrase=***********

[IPv4]
Address=10.0.5.1
Gateway=10.0.5.1
Netmask=255.255.255.0
IPRange=10.0.5.100,10.0.5.110


but I keep getting this error:

# iwctl ap muap0 start-profile smarc5GHz
Argument type is wrong

AFAIK, 5GHz band supports up to Channel=37. Is this supported by iwd?


Thanks!


-- 
Best regards,
João Marcos Costa

