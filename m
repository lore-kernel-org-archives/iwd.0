Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A018039
	for <iwd@lists.linux.dev>; Mon, 25 Mar 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393926; cv=none; b=IEMGh9sbawcXPP3uG8adDK2eDsL9Il/meS+JvtKo+SkKO2LdLLi5vmSn/+6bIQHDQOV40Zf4hwYNSpL4uGPUZfmrQSoeqNm0PigSf312mA71gPq2Pq9xq3HJkmzD9qanK4vUS8LAn6bzamDg6Olt6Q1XrWfL69q57pfCTXqldrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393926; c=relaxed/simple;
	bh=QgwhIBU1w7roPqeg7Cee9nnXrrhqntKovs3pMUHmPiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFxZ4a+aRrDRM+Bt1kFpE2/qBYIcViEXbZ2pGPUREcFQ3Rr58EsYb+PNtJpzneZjhQa3h1sDL8+1Zh5BoYOeDsRPeSo2A/NEYNaMaAxHkVd27U43XiJyuiHjVkESsRCzdBBRQ41LVWgKsme7BelSebN/V6NmXUg2T1QJ5vIzAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p5xyrUHA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p5xyrUHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711393917;
	bh=QgwhIBU1w7roPqeg7Cee9nnXrrhqntKovs3pMUHmPiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p5xyrUHAuSLAghGyorP+eGkxAXy60PMg9gKfx3CTu7fPD+Sik+B8pOj9UB2YEhHOu
	 Bulk+XysCG2aki9aFSVaqCN0nPvXFdvyCtOjjcYSF8tqZRhAE2JtwESgU6dLbTtyw5
	 IcA5YeBJzrpBrfhUpteh7CezxEx5VD/c6/NrYrDiBrddZ9/okppoF6KR8Nfrh9ZjPu
	 atYCrNGk1GjMWxPPHXuj4nTbEbub4lDSbZx38KOAQoJ5np6YVy6SZwJx/UvgTPg3dW
	 NskajyPS8EO0ij6yEWVFK/GyNAESjsHtKGNx3ZW4Dpx59eaNScMLVfR10+/zb0guvA
	 N4DvzyDiEaZFQ==
Received: from [100.110.102.249] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jwhiting)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B031837820E1;
	Mon, 25 Mar 2024 19:11:56 +0000 (UTC)
Message-ID: <bfb5d799-65bb-412c-be32-3ceea0211968@collabora.com>
Date: Mon, 25 Mar 2024 13:11:54 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ios hotspot fix
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: Edmund Smith <ed.smith@collabora.com>,
 Alvaro Soliverez <alvaro.soliverez@collabora.com>
References: <27b427-6601b380-b-46ef6f80@167641064>
 <bba319c4-6e65-4809-99d4-90019b89a89e@gmail.com>
Content-Language: en-US
From: Jeremy Whiting <jeremy.whiting@collabora.com>
In-Reply-To: <bba319c4-6e65-4809-99d4-90019b89a89e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 3/25/24 12:23, James Prestwood wrote:
> Hi Jeremy,
>
> On 3/25/24 10:26 AM, Jeremy Whiting wrote:
>> Hello,
>>
>> In recent testing it has been found that when trying to connect to an 
>> ios hotspot some messages are missed by iwd. It seems to be a timing 
>> issue, doesn't happen every time, but does happen often enough to be 
>> a problem. In testing the device fails to connect more than half of 
>> the attempts.
>>
>> Ed Smith has created a patch that seems to fix the problem here. I've 
>> attached the patch after rebasing on iwd master.
>>
>> Here's a bit of background and explanation:
>>
>> iwd has difficulty in connecting to iOS hotspots as of 2.7 (and not
>> fixed according to our testing as of 2.16 - latest at the time this is
>> done). This is because of several factors:
>>
>>
>> The iOS hotspot does not repeat its initial EAPOL challenge, where
>> most APs will.
>>
>>
>> The iOS hotspot is not reactive to EAPOL-Start (client request to be
>> challenged); it sends exactly one challenge, and then the connection
>> times out.
>>
>>
>> The iOS hotspot sends its challenge very quickly, more quickly than
>> iwd is prepared for. iwd is not ready to receive the challenge
>> packet before the association event is fired by the kernel's wifi
>> stack, but the iOS hotspot's challenge packet consistently arrives
>> before this.
>>
>>
>> This patch moves iwd's frame listener registration for EAPOL back to
>> the authenticate event fired by the kernel. At this point, the
>> necessary details about what kind of connection we expect to have
>> (e.g. are we an AP) are available, but it's not possible for any
>> plausible EAPOL packet to arrive yet (because authenticate requires us
>> to take action - EAPOL happens after association, which can't happen
>> before we respond to authenticate).
>
> Out of curiosity what client hardware are you using to test this? The 
> early frame handling was added to support brcmfmac IIRC and as I 
> understand it the EAPoL frame wasn't actually being sent too quickly, 
> its just that brcmfmac was sending the events in an unexpected order.


The bug we were experiencing was only on the OLED version of the steam 
deck. According to lscpi it uses this wifi chip:

3:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 Wireless 
Network Adapter (rev 01)
         DeviceName: Broadcom 5762
         Subsystem: Qualcomm Technologies, Inc QCNFA765 Wireless Network 
Adapter
         Flags: bus master, fast devsel, latency 0, IRQ 77
         Memory at 80000000 (64-bit, non-prefetchable) [size=2M]
         Capabilities: <access denied>
         Kernel driver in use: ath11k_pci
         Kernel modules: ath11k_pci

>
> So yes I suppose this could happen. There is even a comment in 
> wpa_supplicant which seems to indicate the behavior your talking about:
>
> https://w1.fi/cgit/hostap/tree/wpa_supplicant/wpa_supplicant.c#n5498
>
> Could you resend this using git-send-email so the patch is not an 
> attachment. That makes it easier to comment. Looking at the patch the 
> first thing that jumps out is you register prior to processing the 
> auth event. If there was any failures you would have registered for 
> EAPoL unnecessarily. Might as well move the registration until after 
> the even was processed successfully.


Ok, I'll get git send-email set up today and update the patch to do the 
register after auth is done processing.

Thanks,

Jeremy

>
> Thanks,
>
> James
>
>
>>
>> thanks,
>> Jeremy
