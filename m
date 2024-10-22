Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007A13AD26
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621292; cv=none; b=caRtUHIlo0JipxNbHMMIHgb3tga8XIyaRp8rEgRYDtgl7iMkAb2Zd4drJL/nBByJPlzeVfY469JBLUB7ToNEcg/fRyc4KX43Q2emAQYsCTwTXqpZJUXhuhU3N6sMv0sU+D6qG4ae/ReWqyBcN84kRQCoIHTjNrSQEux8YXm1oPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621292; c=relaxed/simple;
	bh=S4TCQhqNE7afYGabJVtAKzJTavcersF0x6k20bU0uRY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oALlmmtoldqNvaq8nfUGREuhktTWVpoqUdKVDV9fb7zECc1v7vu+xfVbi/yAk4G37K91ySGxNw65Sm45d+EWE4fpvG8vY6KIIHsrbpGx98NWwV89AcDaCIHr3/1TY2xBMgsjy5iOSpccShDyt/RQRMMsQPokF8eN4qfF64acXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=ERtkR7kd; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="ERtkR7kd"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XY0qm03fVz9vGh;
	Tue, 22 Oct 2024 20:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729621284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bEg19jfLortU1J3HLfVj3QnqCAVRX1r+t590dqRjfo=;
	b=ERtkR7kdy6L39POR9kS2XmjN/cRsg6nVqe4ATNpM9NAmfDVU5vUZySZYOQXgcW/mrFwHMl
	K2gMjTbBOoZchXHo/7bOXspw1iI4Q5V2DddLvJBHtKGO4cpAojCtP2PdgkTnMB25s4si9m
	KqRoswlSUr1IoX/CY5nIEWIPfayelFDyVcQOrfYgIq8LwTNaSwATZye33NiCw2jOgR1ZZ+
	YtD7pZzSZFPZ6MR/TRh9Xo/zAXDf5v8lCP5wBqQjvrJtyrz18HhUGaLPwLbgwlM5Nldnsl
	+iU+YUCvFJIMN3uXMd2QzQdsYHaTX+rWWPdg7EKzoSiWZLWnNGkQfWtOkUClFw==
Message-ID: <127f5b23-7951-4527-b301-ade5aac93feb@tavla.de>
Date: Tue, 22 Oct 2024 20:21:22 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
From: Martin Petzold <martin.petzold@tavla.de>
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev,
 KeithG <ys3al35l@gmail.com>, Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
 <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
 <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
 <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
 <f1f2b4cc-367b-43df-a637-b380d979e11d@gmail.com>
 <6170a2a5-dc7d-4182-8b83-1b43b93c4f46@tavla.de>
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <6170a2a5-dc7d-4182-8b83-1b43b93c4f46@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 22.10.24 um 20:04 schrieb Martin Petzold:

> Hi James,
>
> Am 22.10.24 um 19:40 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 10/21/24 3:10 PM, Martin Petzold wrote:
>>> Hi Arend,
>>>
>>> Am 22.10.24 um 00:01 schrieb KeithG:
>>>> Arend,
>>>>
>>>> If there is a patch for brcmfmac to use CMD_EXTERNAL_AUTH, I am
>>>> interested in testing. The last time we tried, it errored out and did
>>>> not work as expected.
>>>
>>> Support with our current chip for WPA3 and also OWE by offloading 
>>> SAE etc. to IWD. That is possible?! This would be great!
>>
>> Have you also checked with the vendor (Solid Run?) if SAE/OWE are 
>> supported by the hardware/kernel they ship with (even with 
>> wpa_supplicant)?
>
> Vendor is Variscite and the chip is Laird LWB5 (BCM4339). According to 
> Laird WPA3 is NOT supported. However, this is not the problem: I knew 
> this all the time.
>
> The Cisco enterprise network is (should be) configured as WPA3 OWE 
> with Transition Mode (there should be one hidden and one visible 
> network) [1]. And, my device connects ONCE initially (it is connected 
> and online). Then it looses the connection (I assume maybe due to 
> roaming) and does not connect again. Also manual re-connection 
> attempts using iwctl fail (see log). All auto-connects fail. Maybe you 
> can check the logs again, and can confirm WPA3 OWE with Transition 
> Mode is configured?

And there are no issues with this setup (BCM4339 + IWD) using single BSS 
WPA2-PSK (great connection). There seem to be some roaming problems in 
general (because also another Fritzbox + Repeater is not behaving as I 
would expect it), I assume something between brcmfmac and IWD. And maybe 
the WPA3 OWE Transition Mode is also not working (however, maybe due to 
some roaming problem). But als the firmware could make trouble. I have 
no idea.

My vendor Variscite uses NetworkManager and doesn't really support me on 
IWD. I was actually also using NetworkManager before on my devices. But 
now I wanted to switch to IWD with our new hardware and software 
platform (however, not the newest wifi chip). I have another device x86 
+ Intel Wifi which connects to exactly this WPA3 OWE Transition Mode 
network without any problems - using NetworkManager. That hardware is 
not really the newest, I don't think it supports WPA3. That means: a) 
WPA3 OWE Transition Mode is configured and working, b) Intel chip + 
NetworkManager is working, c) Laird LWB5 (BCM4339) with IWD is NOT working.

I have verified from both sides! I have access to the device in the 
environment via Ethernet and tried the connection myself via iwctl. 
There I also get the logs from.

I hope the logs would help. I will provide more later today (the 
requested debug output).

