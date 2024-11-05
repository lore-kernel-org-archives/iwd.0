Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569301DAC89
	for <iwd@lists.linux.dev>; Tue,  5 Nov 2024 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834555; cv=none; b=fhnftruYs5bYf5t0lfK+BfYOD2/47AbPGslSebIg3470UPIh9nEDi1+5EqtLgUd+jmxAxQDTeXHHPqWNfcMdNWw04nT8zDCzf8njVtErsB0nowrt63KKtW6lWwt93VvCGoQK2Mhl2TFdXUniIvfhw4xWtVYUSmhQ9pyYTrsuycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834555; c=relaxed/simple;
	bh=TciDSyZQqZ6uskJte6NKJ8RsdIf9pQgUI/jKCetG7ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dxyZPxAsfznmavrnF7q/8XayGTkxIql9/3YAsoj+fSWSU4iDZhS9J7NMcISU7O8xN1Hhzi3c4UMlOWpAEVvxGbvNGf/uSp+/sNT1QEST7tzhQh3Fpmj/gBxPCBP2y3mVG7hz5a63EMchY4SAxClBjMr6T57L9q72/2fI83G8Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=eKsX88iD; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="eKsX88iD"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4XjdWl1jysz9wYF;
	Tue,  5 Nov 2024 20:22:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730834547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuyuMh3UbKVh7hudg2fBoITOT7W5Adt8hSadYkGS1z0=;
	b=eKsX88iDqexv1osjvL6e9GFM9cIYoku+SIWyT+vDbP/ENWp8eAgklkqhEblDm7yWwqDOuI
	vcEiyi+C+BtEjdu3797ghcT2NCuYrilmsFiEvnaivExJZJL6n79DXIMFqGni+xcpEdoKNU
	jr2vj0k5mq2zfp20Bjs1NeZeMIwu/4JYAtbwFvNCWq3mSBWKM6WPmvg4XDPVQN6KqHe7Y1
	GWQqX4pRO33ruUDSLxitpfvbg3Wfj6i7XvhQ/vq8eqEV08WnMVYmnpo2AvGUewDEN8p3vS
	LJxJJ1eZ5tOFS9FuKKPL99phinv5GE2ormLiNbhj26SAB5YjV32dbNYw5pOF3Q==
Message-ID: <7d815327-bf9b-441f-a736-a2f3a651112d@tavla.de>
Date: Tue, 5 Nov 2024 20:22:25 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: timesync when using IWD stand-alone
To: Harry ten Berge <htenberge@gmail.com>
References: <bb7c6c59-b5f1-4a22-a168-83ccfc5406a3@tavla.de>
 <CAN+yOboCgTLninh255t6Z61S1PaKXjS0yj1HTx5LU9c5dzyS_g@mail.gmail.com>
Content-Language: en-GB, de-DE
Cc: iwd@lists.linux.dev
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <CAN+yOboCgTLninh255t6Z61S1PaKXjS0yj1HTx5LU9c5dzyS_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Harry,

Am 05.11.24 um 19:23 schrieb Harry ten Berge:
> On Tue, 5 Nov 2024 at 19:15, Martin Petzold <martin.petzold@tavla.de> wrote:
>> Hi all,
>>
>> if I configured my Ethernet interface via systemd-networkd and there is
>> NO carrier (no cable connected). But my wifi is configured, managed and
>> connected by IWD (EnableNetworkConfiguration=true). In a typical case
>> there is no other NTP server configured in timesyncd.conf. How will
>> systemd-timesyncd sync the system time?
> Is there a specific reason why you have chosen for IWD to handle the
> network configuration?
> I use IWD in combination with systemd-networkd all the time, and it
> works like a charm. In that case systemd-timesyncd also works
> 'out-of-the-box.
>
Thanks, this may be the best approach then. I will switch back to that 
configuration. I changed it because, unfortunately, my chip (driver) 
does not work well with IWD.

However, the mentioned case should be known as a potential problem, 
because for this case timesyncd and IWD may not work together well. I 
wonder how NTP should be configured in general, if IWD manages a single 
wifi only network (maybe even without any systemd). Maybe there should 
be some documentation about this case. The wifi guest network is nothing 
uncommon. And there are several sources suggesting also IWD could take 
over control.

Best regards,

Martin

