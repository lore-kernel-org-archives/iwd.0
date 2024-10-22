Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E617C98
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621943; cv=none; b=OneUgZLnJeVO1U28hrFA3+6jLWFxRPeBgl4aQpNGCDEnWaefw9SNNb9B2WQk3N0troAzNJE6gIZ8xDyzOR1MeyOq4H4eYhE5bYM8z8WqlSNxy91YPYrrdW/mGDTgTDJjH//c7xpGShUvS1SKcnhGfKKUYn+Zfgpo3OhuHlwtZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621943; c=relaxed/simple;
	bh=b8XDF0ef+G+grSe5tqxNzzjHGp2Zo6KfjrJ8bpv4tFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffrpnJcHIYljw6jahHIkqbddfohACx/WTu4jBdp7e+yGdxvT3Nm550wSYKyo5NnNdXGzTnEacITtpdBZi6ppP6KLFKh4YhsXCOgEY8GEdcsaS3LL6/kFzJT7LxaMJTcGqNRgtjf6NGu2xgaB3B1z/BkQKwmCz3fZUca0ccmZ6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=o5v/w703; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="o5v/w703"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XY14B1TXzz9wPG;
	Tue, 22 Oct 2024 20:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729621930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx90wNmCxWYPhrQdD9IZmC/5w8LaIA9oam55dBFMLdU=;
	b=o5v/w703ciwpH3ugMtJvykYNEkFOwZiZ53MNXqtEo7HZg/Y+DfXG/f9kJyukOiObB5fL1s
	jFf2sOUA0Hra9c21ONwaNRMKDJneOVPhqF8nMpFjTnExwGvKnWbDBgkxsyHgTXqSsiXdu5
	L5ziytCXvVSXHy8sGeS7UovLKYrDV/yx3xK2fWfvkauowWiebCwgE883nHNZEyX/4uXcCA
	kz7CloXsaquNnjoDQ/BqZgi+dXi0gLsTzNUWMlpJ5Y+R3a2EL9/Sq3Lbn6ADmPpRaFyt51
	UpcMNCYGoidJeGyu67vO+R6rpJ3/XmFLDRaypvsedwyXc7lxq9DTePwowK4xBA==
Message-ID: <cd042c10-68db-47b1-8dc8-e92753c2d248@tavla.de>
Date: Tue, 22 Oct 2024 20:32:03 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev,
 KeithG <ys3al35l@gmail.com>, Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
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
 <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XY14B1TXzz9wPG

Hi James,

Am 22.10.24 um 20:24 schrieb James Prestwood:
> Hi Martin,
>
> On 10/22/24 11:04 AM, Martin Petzold wrote:
>> Hi James,
>>
>> Am 22.10.24 um 19:40 schrieb James Prestwood:
>>> Hi Martin,
>>>
>>> On 10/21/24 3:10 PM, Martin Petzold wrote:
>>>> Hi Arend,
>>>>
>>>> Am 22.10.24 um 00:01 schrieb KeithG:
>>>>> Arend,
>>>>>
>>>>> If there is a patch for brcmfmac to use CMD_EXTERNAL_AUTH, I am
>>>>> interested in testing. The last time we tried, it errored out and did
>>>>> not work as expected.
>>>>
>>>> Support with our current chip for WPA3 and also OWE by offloading 
>>>> SAE etc. to IWD. That is possible?! This would be great!
>>>
>>> Have you also checked with the vendor (Solid Run?) if SAE/OWE are 
>>> supported by the hardware/kernel they ship with (even with 
>>> wpa_supplicant)?
>>
>> Vendor is Variscite and the chip is Laird LWB5 (BCM4339). According 
>> to Laird WPA3 is NOT supported. However, this is not the problem: I 
>> knew this all the time.
>>
>> The Cisco enterprise network is (should be) configured as WPA3 OWE 
>> with Transition Mode (there should be one hidden and one visible 
>> network) [1]. And, my device connects ONCE initially (it is connected 
>> and online). Then it looses the connection (I assume maybe due to 
>> roaming) and does not connect again. Also manual re-connection 
>> attempts using iwctl fail (see log). All auto-connects fail. Maybe 
>> you can check the logs again, and can confirm WPA3 OWE with 
>> Transition Mode is configured?
>
> From your logs I see no successful connection, but it looks like the 
> OWE transition mode is configured on the APs. Based on what brcmfmac 
> is saying the issue appears to be that IWD chooses the OWE AKM when 
> connecting and brcmfmac errors out as its unsupported. I don't believe 
> there is any way for IWD to check if OWE is supported by the driver, 
> and we just assume it is (Arend, maybe you know of a way to check 
> this?). It appears that what you need is a new IWD option to force 
> connecting to an open network, not the OWE transition/hidden network, 
> right?

There was a reboot between initial successful connection and these logs. 
I only pulled the logs for the boot. But 100% it connected initially! 
Because this was confirmed, the device was online (no Ethernet) and was 
connected to our servers. Only then, I had access to the device 
connecting Ethernet. This is on clients site. I cannot access it all the 
time. However, of course I can debug everything at our site (except this 
WPA3 OWE Transition Mode scenario, and we also don't have roaming 
environment here).

Thanks,

Martin

