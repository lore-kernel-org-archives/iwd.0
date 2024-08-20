Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDC18E37F
	for <iwd@lists.linux.dev>; Tue, 20 Aug 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166265; cv=none; b=DzNihJt1Vk48m3LM/eF8CYypnlZct4nZhuiKVdHckEQx6CE3pCnb/uaJfcK7BASiIMQFs51cOlFo9+TIdctJ18Hxid/iyRDSJN9y9Iu5nI4LNaRFzo33CybWo2JlkPtmjkPV6LuQ2/pczs7aoVUL+VS9vKY/+mYp53ZqTDnN7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166265; c=relaxed/simple;
	bh=lrlywUlc73YpssA+D8jN2P6SxjpuY8Q3YytKWcVAnA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTL1EtsfizeAY9J5mp3QwfXDGi8/IxVkpzarisase0RpmEhX3a4hrBQLf0/UIoT3Ld0nYB0Eb0CZnFYGT+I0pq3L4wc4n0xQ6K0LHjDPW5xXbpFIQ3ScCSYCohNeIZkmfmXQeyIAMug8wg/LLhCTM5HcSfl8iXk/JLY6/Bslg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc5SVCbd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc5SVCbd"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44ff99fcd42so32659291cf.0
        for <iwd@lists.linux.dev>; Tue, 20 Aug 2024 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724166263; x=1724771063; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JB5sEDLicdjr4F4B+1bPusJVp/9NYcSrfqzmko1DkQ=;
        b=gc5SVCbdafXmBKEl7AbiZVlATevEsoUSmK65PNpZyZlPYL4tDQhJgGGA1ilw2ieNTd
         QIO6lYS7xMOdsr3qYELwwqihvwYH6oCNoyx6hB1tvdzV+ZvPHtmPnnAZuJtfyfg1nTX2
         TpS3E41vTU/tgoUw4uP4z4C7k7MMaL4NFBXoiFNr0177fv67EZ562dS4MnhPKXo25ffz
         eZSC+fXFic630XWj5AO8lIKr8YP+sMAV7P3BbNGlj4qw7QW++iDVwwZ4wvEUfGziQmV6
         7olZhix6l8apd4g1DXgGEibpt0HwKgVGg3wVbleG09iarE1Wp4dI7TtxOsJGn73D5/7A
         N56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724166263; x=1724771063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JB5sEDLicdjr4F4B+1bPusJVp/9NYcSrfqzmko1DkQ=;
        b=Tjs1vsRh4ciKCyA2MX1XeJlkwWFfAoT2NYB7CbK/Bo4tZp6ws87VD6kjZtPxB1KZvc
         uqP7ShazaQfHjqCnDroZEGEoX4DrwETR8dApLyzQugOXiXnBLRZdbZGx7wC5+uW31yp5
         YfSuqV9oORIAg7Gk7mJv0Mlo1fdAXLCm7guQA0Bvwjh4DbkGryuobgi6jK9G+7fTQdqh
         q52AEi7z6pVjSrPUs8k31U4C1jkJDGU+Pyowqnz99vMv7+Z8GJixp37Dbn23XJ4t1piN
         Sii4gtBbsnDPD7ol73WTe8cwXunu7tcnrUefXItezMnGf2S0zUCCz3P+szeseW6WS/a5
         8xxw==
X-Gm-Message-State: AOJu0Yw9fJWXPtl8UBf/B/9HjD9ZSkoH54SHPtRDfZCfpktmWdbYZokr
	CKvyFLndOoxs3txQZfwOIzA+cT7EvTGmiKALlJY/43d9XEV4g/13
X-Google-Smtp-Source: AGHT+IHoccqjVJaRPxDqhmUYC7wjX5y2rd7sSaxohF8ECESTcdkv7l2UowzcYzRSfpdFWOpJuGhttg==
X-Received: by 2002:a05:622a:2a18:b0:453:56a9:3ef9 with SMTP id d75a77b69052e-4537435348bmr135891041cf.45.1724166262960;
        Tue, 20 Aug 2024 08:04:22 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm51029911cf.9.2024.08.20.08.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:04:22 -0700 (PDT)
Message-ID: <e6ff554e-ad17-46e3-b614-ac6da796b337@gmail.com>
Date: Tue, 20 Aug 2024 08:04:20 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segmentation fault when taking device for a walk
To: Richard Acayan <mailingradian@gmail.com>
Cc: iwd@lists.linux.dev
References: <Zr6cKJePuQd4Dm_n@radian>
 <5096b486-d2c1-4a7b-826a-d3e4af9e2eed@gmail.com> <ZsPATiu0_31D8Qcq@radian>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ZsPATiu0_31D8Qcq@radian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Richard,

On 8/19/24 2:59 PM, Richard Acayan wrote:
> On Fri, Aug 16, 2024 at 04:53:41AM -0700, James Prestwood wrote:
>> Hi Richard,
>>
>> On 8/15/24 5:24 PM, Richard Acayan wrote:
>>> Hi,
>>>
>>> A segmentation fault occurs in station_start_roam() when the station is
>>> disconnected from an access point, or in other words, when the station's
>>> connected_bss is NULL. Usually, this is triggered by a timeout, possibly
>>> scheduled in response to a weak signal event.
>>>
>>> This is occurring on my Pixel 3a running postmarketOS/Alpine Linux, when
>>> receding from an access point, on iwd 2.19. I have collected 6 coredumps
>>> of the crash in the span of around 2 weeks and would be willing to use
>>> GDB if more information is necessary for a patch.
>>>
>>> Sample:
>>>
>>> 	Program terminated with signal SIGSEGV, Segmentation fault.
>>> 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
>>> 	
>>> 	warning: 2880	src/station.c: No such file or directory
>>> 	(gdb) bt
>>> 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
>>> 	#1  0x0000aaaadf28c544 in timeout_callback (fd=<optimized out>, events=<optimized out>,
>>> 	    user_data=0xffff876b2e20) at ell/timeout.c:68
>>> 	#2  timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0xffff876b2e20)
>>> 	    at ell/timeout.c:57
>>> 	#3  0x0000aaaadf28b9d0 in l_main_iterate (timeout=<optimized out>) at ell/main.c:461
>>> 	#4  0x0000aaaadf28bac0 in l_main_run () at ell/main.c:508
>>> 	#5  l_main_run () at ell/main.c:490
>>> 	#6  0x0000aaaadf28bce4 in l_main_run_with_signal (
>>> 	    callback=callback@entry=0xaaaadf1f1110 <signal_handler>, user_data=user_data@entry=0x0)
>>> 	    at ell/main.c:630
>>> 	#7  0x0000aaaadf1f0b0c in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:611
>>> 	(gdb) p station->connected_bss
>>> 	$1 = (struct scan_bss *) 0x0
>>>
>> Its hard to say without any debug logs as well but it appears the disconnect
>> never cleared out the timer used for the next roam attempt. I did fix a hang
>> due to a disconnect coming in during a roam attempt after 2.19, but I can't
>> really make heads or tails without debug logs to see what happened
>> before/after the disconnect.
> It happened again with debug logs enabled. Relevant snippet (from
> logread):
>
> 	[Aug 17 21:22:12] daemon iwd: src/station.c:station_roam_state_clear() 5
> 	[Aug 17 21:22:12] daemon iwd: event: state, old: connected, new: disconnecting
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_deauthenticate_event()
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_disconnect_event()
> 	[Aug 17 21:22:15] daemon iwd: src/station.c:station_disconnect_cb() 5, success: 1
> 	[Aug 17 21:22:15] daemon iwd: event: state, old: disconnecting, new: disconnected
> 	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> 	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
> 	[Aug 17 21:22:36] daemon iwd: src/station.c:station_roam_trigger_cb() 5
>
> Afterwards is the segmentation fault.

Do you happen to have the logs a few minutes prior. The roam timeout is 
defaulted to 60 seconds, so at some point it was re-armed but the logs 
don't go back that far. Its trivial to handle the segfault but I suspect 
the roam timeout being rearmed is also leaking memory so we should 
address that as the root cause.

Thanks,

James

