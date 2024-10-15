Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F681C07D1
	for <iwd@lists.linux.dev>; Tue, 15 Oct 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003433; cv=none; b=n/DuQd5BHNUMrER4lLxR2EGVfMQ9GscTEZGVGi5IunMUhC03D0Ada6YU3R6kDBUgRhbCGCAdMGbijtlQN25dq/ZResif+SBdkMYNlx9PsS3cRon1CUP2POLz3dgrkiyqV9ozjng4Rf5B51IuWZz8rajwk4LAGi7kt/86yB+C9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003433; c=relaxed/simple;
	bh=yCdxKSqGBSH2F73jJn0mR/uHxZZ7i0hKSWsQD5lMgFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZE31PmkkMC24ymFeogBhHUNxnES9nTA8cnAGbgRoqbS//4nk/2l3ATtq28VbFK6CYVK9cyBbka3FrYffg4huqD4xuNKnD67csUJoaphUS53pa4UTm6gqeK0aZuti6xr35mbNPpT7hh0pRTxaXEC8vg2es9kmb5RZx3i6A8fkblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=pIoACgnr; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="pIoACgnr"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XScKl6g6NzDv2G;
	Tue, 15 Oct 2024 16:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729003420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlkdShprEqWDkXRq5Cb/XkI0GH9iCaR58kF0XhqRLk8=;
	b=pIoACgnry/vHE8BOCPFIYerJvnXrNoMnJOHSHUD0eZRlU3gWzsBDLGIoHfxXM6zaBZEUU6
	gy6CS/hfkK99jsMFvPdrQuVImiv2I5iQ/ioREHhJZPNf8+RNlnCRDTGE4X0Oza4iMeQacX
	+i06JfioCrQF6XqW6de1m+Mtk3y0S/Nb8GNZLzBSKaq63GZw7X2iMDQHQOdf5p6duJcuzh
	f9Ksso1YBzU6tHpwS0KmTir6jP0ZM1GpWbr6rZikQLAsdyh0enI978y9whqnSuB8ztZ90c
	ZdgY1DI5c/exrGN4CpyNEEDSuexhVAGg2pCL4dUWlayjJnAa4YNF/931D40t5w==
Message-ID: <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
Date: Tue, 15 Oct 2024 16:43:38 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XScKl6g6NzDv2G

Hi Denis,

Am 09.10.24 um 18:07 schrieb Denis Kenzior:
> Hi Martin,
>
> On 10/9/24 4:43 AM, Martin Petzold wrote:
>> [...]
>> 3. Build IWD 2.22 from source (maybe using Debian sid source 
>> package?) -> how to do best and will this work with libc6 version 
>> 2.36? Missing libreadline8t64?
>
> I mean this is your only real solution.  There is no 'long term 
> support' model for iwd.  You either run the latest or you're on your 
> own.  It is highly unlikely that any of the developers will look at 
> logs (or attempt to fix) anything but the latest version.
>
Okay, I build IWD from source and am now using HEAD 
(c459dc75c080dcbff6f9b9389344e11328dec411). Please find below the new setup.

I think the regulatory domain issue is fixed. It seems that 99 is 
correct (because it is handled in firmware). We see far better signal 
and data rates at a site where we had problems. It seems the general 
setup is far better now for simple setups. We removed the configuration 
from device tree and then it may have used the configuration from 
brcmfmac4339-sdio.txt (device tree stuff was something the SOM vendor 
added for some reason).

However, I have now already seen at one of our testing sites, that it 
connected to the router instead of the repeater (which is far closer and 
has far far better signal: -67 vs. -29 dBm). It also did not switch to 
the repeater after several hours (both FritzBox - so consumer grade and 
we don't know the exact configuration). After a reboot, it connected to 
the repeater and until now it remains there. I will switch to more 
complex roaming environment, however, this is more sensitive because it 
is at a clients site. This first impression gave me not much confidence...

What do you think about the idea to disable roaming in the firmware / 
driver? (if I understand Arend right, this is setting "roam_off" in 
brcmfmac4339-sdio.txt)

Will IWD smoothly take over the roaming? How can I check who is handling 
the roaming?

What would you suggest? Roaming via firmware or roaming via daemon?

What do you think about the option to switch to Kernel / Debian firmware 
package instead of Laird?

SETUP:

SoM: Variscite DART-IMX8M-PLUS
SoC: NXP i.MX8M Plus
Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
Antenna: Laird FlexPIFA
RootFS: Debian bookworm
Kernel: NXP Kernel 6.1.36 (with Variscite patches)
Driver: brcmfmac (from Kernel, only minor patches - device tree)
Firmware: Laird 12.29.0.22 (loaded via scripts)
Network Daemon: systemd-networkd 252.30
Wi-Fi Daemon: IWD 2.22+ (HEAD) + ELL 0.69 (HEAD)

