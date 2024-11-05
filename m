Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3C214418
	for <iwd@lists.linux.dev>; Tue,  5 Nov 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837143; cv=none; b=MgKwPaAx/zJ9x0KBs/jWnCMX45jgWZiCj7IT1Y9BWy4YiO+wsiYt60zwA4vXaDX4ZclWEavGxLFol2soouQTyaaNB16ZNX4GILx9lshIwpUIOx1oZG0RnKjqiTKqJPOI+MPAczV7qeqZrgBbRSXb3Veuz6iuJWPQhokqVZuT9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837143; c=relaxed/simple;
	bh=lIpc1BhsBRILQTLAmKtlQuwNkeuQxImjJK5d+tdrhnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feM0lZ3nOiAytRUldmqJ7JY3u8BH1X7hyEhJZTiSG+kEzoHwGqAgxM2ooYGMfC9M/j6+KViJ+J7VO/law5K8PoY5HI7JhLyHWqWovj8l0/Ax/PyEM0AocGPzG1zRiPSxtHE04mdn8FNK0dhv3S5baStJ4Aii5YfHwh7zCGQR5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLpHmflJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLpHmflJ"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5fcf464ecso3813047b6e.0
        for <iwd@lists.linux.dev>; Tue, 05 Nov 2024 12:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730837140; x=1731441940; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sToKInF2rat4PfOM1aAquRR97QJE1BPmdlhtUXudh8U=;
        b=gLpHmflJx3VnUTS+BgdmaYrPIgcb2ct6PBtXdHx3sWVHzeoattNX5XqUoQkxXMrcFD
         ga5Mmyld/vp3SzLV+oOgQhLIeTuhNugiS7ojTZ5qfNtQURqswrZUvIN5PUiTrqa5LE71
         suXTmHsGzhJUV3Toi/ffzpQocyRv5eRm3+7r+/XIcYzXve6l5XOX5q22SSyBC31QRsmL
         NL5yt/7T3RsMs9ogSCCogs3/p2s08oEoiCNvxLiIycQD2cpDtDmxU+INAhmB8RelsR7A
         qGUpZKWAvpeckmidqFECkmpTpxuMBtxpYHO2Sw4N8DKh6OVM/KuE94olz3n3c/zXOqFW
         moZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730837140; x=1731441940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sToKInF2rat4PfOM1aAquRR97QJE1BPmdlhtUXudh8U=;
        b=I5my0dl83jr+qOrHVCAJ+d4+W6QDHqe6P0SAMGk6MvHl0wz8AR2Nd7kqwQBYgbqqgz
         wqSWUVn0rxj/mgDmwBg68/nG894mIi4tCzDS9gmud2ufhDGQmR5fBH3qT2mOo/N7GYku
         5CGgr8oKkHrhG2BxLZdERunHpT3slgGR5icv3L2DCO40Vw9u0ZA0Ypl+mk9SL0wYb3jR
         sEz2Rp2Es3JfWyfW0A3Tg//wPeO5yC+hSCeZbhfxxvPLc8Sgm2WljCCCYhv/JMhyFdQx
         Q+s0vAoLt6XqlG8kzGkQ6DIIUtQj8pad9IwdBecbkXeRR6+jSudEP5wS8bj4fHFdcpiD
         s6Sw==
X-Gm-Message-State: AOJu0YyOOJqDm2GUUsu8SuO5gbS9P842NZn3qAplQOLTY/a+yF3MVok+
	2DrcP9pcfZweALOs8w82dtWtbtzMBq+/LBZKHUw346pffY+vPvaw
X-Google-Smtp-Source: AGHT+IHquRu3KQhw8ZjFat88w3bQzbUFgWO8cwNcEbYgCn06LqN/clf2x79NqGpT76CbNWqCWzwA2A==
X-Received: by 2002:a05:6808:14cb:b0:3e4:d6a6:546 with SMTP id 5614622812f47-3e6382488fbmr35565975b6e.15.1730837140283;
        Tue, 05 Nov 2024 12:05:40 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b2fesm64124356d6.92.2024.11.05.12.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 12:05:39 -0800 (PST)
Message-ID: <8958134f-25f4-45c6-8285-51e27afdd8e4@gmail.com>
Date: Tue, 5 Nov 2024 12:05:37 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: timesync when using IWD stand-alone
To: Martin Petzold <martin.petzold@tavla.de>,
 Harry ten Berge <htenberge@gmail.com>
Cc: iwd@lists.linux.dev
References: <bb7c6c59-b5f1-4a22-a168-83ccfc5406a3@tavla.de>
 <CAN+yOboCgTLninh255t6Z61S1PaKXjS0yj1HTx5LU9c5dzyS_g@mail.gmail.com>
 <7d815327-bf9b-441f-a736-a2f3a651112d@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <7d815327-bf9b-441f-a736-a2f3a651112d@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 11/5/24 11:22 AM, Martin Petzold wrote:
> Dear Harry,
>
> Am 05.11.24 um 19:23 schrieb Harry ten Berge:
>> On Tue, 5 Nov 2024 at 19:15, Martin Petzold <martin.petzold@tavla.de> 
>> wrote:
>>> Hi all,
>>>
>>> if I configured my Ethernet interface via systemd-networkd and there is
>>> NO carrier (no cable connected). But my wifi is configured, managed and
>>> connected by IWD (EnableNetworkConfiguration=true). In a typical case
>>> there is no other NTP server configured in timesyncd.conf. How will
>>> systemd-timesyncd sync the system time?
>> Is there a specific reason why you have chosen for IWD to handle the
>> network configuration?
>> I use IWD in combination with systemd-networkd all the time, and it
>> works like a charm. In that case systemd-timesyncd also works
>> 'out-of-the-box.
>>
> Thanks, this may be the best approach then. I will switch back to that 
> configuration. I changed it because, unfortunately, my chip (driver) 
> does not work well with IWD.
>
> However, the mentioned case should be known as a potential problem, 
> because for this case timesyncd and IWD may not work together well. I 
> wonder how NTP should be configured in general, if IWD manages a 
> single wifi only network (maybe even without any systemd). Maybe there 
> should be some documentation about this case. The wifi guest network 
> is nothing uncommon. And there are several sources suggesting also IWD 
> could take over control.

I think in general, for the average user, NTP works fine with IWD doing 
DHCP because a service like ntpd, chrony, or timesyncd will still 
utilize external NTP servers to sync the time. Its only for firewall'd 
networks blocking NTP where you would run into problems if its expected 
that the client should use the NTP server provided over DHCP.

I actually don't see IWD/ELL doing anything with the NTP DHCP option so 
this may be an area for improvement (i.e. advertise it over DBus). It 
appears networkd-timesyncd and systemd-netword are closely coupled as 
far as support for using an NTP server from DHCP. ntpd/chrony look to be 
only statically configurable. So all in all if IWD wants to work with 
timesyncd in this fashion its going to require buy in from both IWD and 
timesyncd. I also wonder how common this is, or if most clients just use 
an external NTP source and ignore what's in the DHCP exchange.

James

>
> Best regards,
>
> Martin
>
>
