Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380920D509
	for <iwd@lists.linux.dev>; Tue,  5 Nov 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837873; cv=none; b=JbcCBWmv+9fusw1sNwU43SxQOJXVmgXyDYtJNdPKibHp/GdV6czR8Ts07xrpcoZRswJgjaGjDwwp2Ca7g/a8qkDIJyCi8NszbrKPPQai4GhMUpWUJp2q7jw5fsXIHZukTTF2k8sIGV2UtQZvBZ20b/K/g20rMjR/Jy88t66K6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837873; c=relaxed/simple;
	bh=jGCf2vMvxfbmVkmjPSerHxdz7+LTLtmkeoaPuoNIWTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9o4yAQhqWIePdkNKRPpS9VqV3j08NYIES1Dlvte6vUiyO+JSJNFDXsc5WSkRqQ92k3OpgGLkb/WhqXItw/Uw/3VW55UXAKZ6GS7/MTJXBNjYVoWydLdIQBnOBalsKQaCKwQrW7VpkEryufhl8XWYq9rv+Yc9CVlsPWMHsqm+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=NjDH1iw4; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="NjDH1iw4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XjflS2gHTzDvG0;
	Tue,  5 Nov 2024 21:17:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730837860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8tEiIGAgKnZcJMhzdg6753xRucTuTzrOSozClKQCmo=;
	b=NjDH1iw4ieZPkyhWIRkqt8h/GBU14NEkWJArJzcstiOlRBY4gIQen5Veg/sv1L6TWIYz4E
	ZEdApKwdJrm8KK0xxxhNTKQvUBHRNthes0uda4T5o0fUfy2mAXurCW22xEW7qFont+hTxt
	AKHv6l5UvqlPiqqciziohWAKeBMs8ppCnk8oQk+rxHRy/rDaybdRlKsmH9xM/Cnvr59FPO
	OUhMqms43zao2X5sz464e/lhaDcT9aqAF4a0xm1lis2azqJ0IQL1Ph+Zkv7uq2p29Y9eBd
	MO44cUMfCNhmhxrGihWj+pJgIDBPfFBYzVDDe/6Yqu2SQ6o3qCLP70k+Bx9fCA==
Message-ID: <bb02480c-97aa-4833-86ac-eea737db4f41@tavla.de>
Date: Tue, 5 Nov 2024 21:17:39 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: timesync when using IWD stand-alone
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev, Harry ten Berge <htenberge@gmail.com>
References: <bb7c6c59-b5f1-4a22-a168-83ccfc5406a3@tavla.de>
 <CAN+yOboCgTLninh255t6Z61S1PaKXjS0yj1HTx5LU9c5dzyS_g@mail.gmail.com>
 <7d815327-bf9b-441f-a736-a2f3a651112d@tavla.de>
 <8958134f-25f4-45c6-8285-51e27afdd8e4@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <8958134f-25f4-45c6-8285-51e27afdd8e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XjflS2gHTzDvG0

Dear James,

Am 05.11.24 um 21:05 schrieb James Prestwood:
> Hi Martin,
>
> On 11/5/24 11:22 AM, Martin Petzold wrote:
>> Dear Harry,
>>
>> Am 05.11.24 um 19:23 schrieb Harry ten Berge:
>>> On Tue, 5 Nov 2024 at 19:15, Martin Petzold 
>>> <martin.petzold@tavla.de> wrote:
>>>> Hi all,
>>>>
>>>> if I configured my Ethernet interface via systemd-networkd and 
>>>> there is
>>>> NO carrier (no cable connected). But my wifi is configured, managed 
>>>> and
>>>> connected by IWD (EnableNetworkConfiguration=true). In a typical case
>>>> there is no other NTP server configured in timesyncd.conf. How will
>>>> systemd-timesyncd sync the system time?
>>> Is there a specific reason why you have chosen for IWD to handle the
>>> network configuration?
>>> I use IWD in combination with systemd-networkd all the time, and it
>>> works like a charm. In that case systemd-timesyncd also works
>>> 'out-of-the-box.
>>>
>> Thanks, this may be the best approach then. I will switch back to 
>> that configuration. I changed it because, unfortunately, my chip 
>> (driver) does not work well with IWD.
>>
>> However, the mentioned case should be known as a potential problem, 
>> because for this case timesyncd and IWD may not work together well. I 
>> wonder how NTP should be configured in general, if IWD manages a 
>> single wifi only network (maybe even without any systemd). Maybe 
>> there should be some documentation about this case. The wifi guest 
>> network is nothing uncommon. And there are several sources suggesting 
>> also IWD could take over control.
>
> I think in general, for the average user, NTP works fine with IWD 
> doing DHCP because a service like ntpd, chrony, or timesyncd will 
> still utilize external NTP servers to sync the time. Its only for 
> firewall'd networks blocking NTP where you would run into problems if 
> its expected that the client should use the NTP server provided over 
> DHCP.
I disagree, a FritzBox guest network is a very common setup (we have 
several testing sites and this is a selected common setup). Port 123 
could also be blocked in other guest network setups, seems reasonable. 
So, it should at least be noted in the documentation (single line). If 
it is required, no idea. But IMHO stand-alone IWD is then nothing really 
stable. We are not talking about devices connected by cable at a fixed 
place. With wifi they can be everywhere, in any potential (common) network.
>
> I actually don't see IWD/ELL doing anything with the NTP DHCP option 
> so this may be an area for improvement (i.e. advertise it over DBus). 
> It appears networkd-timesyncd and systemd-netword are closely coupled 
> as far as support for using an NTP server from DHCP. ntpd/chrony look 
> to be only statically configurable. So all in all if IWD wants to work 
> with timesyncd in this fashion its going to require buy in from both 
> IWD and timesyncd. I also wonder how common this is, or if most 
> clients just use an external NTP source and ignore what's in the DHCP 
> exchange.

In the case as mentioned, time won't be in sync. This can also effect 
TLS certificates and other time related systemd services.

Best regards,

Martin

