Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CF158A1F
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104787; cv=none; b=L1Yesi6MX6bIaFa5dJJiNKfbtYe5OWllbpok7zy22+5p7f+LldZACOAL0owHeAcJKVj82UpM1PdP4ainOcMWnZKPaXcboehkLttg7B5ma0yfRnPUUQL0GB3Uj8jAbVLEFAyRGfp03h2caq6zPqPhV2gyZ6oYtx0wVzDPeHJkC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104787; c=relaxed/simple;
	bh=v9hT/1X37C4oTZAa1Ia7gDhIPTKo8lRFSV1jjIKQVVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc6x9dFkR/fFH8YV+W1iZrtY9nw/jNYiFmGIjh7Hz5x+Bt7QxaB2dQ3XOA0+175P8IgJGK3SPKg3EzQPWooRcfzr0k/01ocj21FbWJpa1t94Dv2301k85hE9FQ0/WYFcdoCVnTkozVxLc3+RUgJcoUP3pYpQCzdXppMe+dQ7Q1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npcvDjI5; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npcvDjI5"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db157d3bb9so2765190b6e.2
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724104785; x=1724709585; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DndzxFLBsXoWOVJIg8a8fMj7UPA/pnh5bGZWmGCHzRU=;
        b=npcvDjI52CbEp8T4WkKC7z1t6D0pkGrZebdy5K7UBlskhh7UcN1HHC6Dx2Gm/bk+9X
         ix+/NF5xqYi8hFouUbfi1P3uicmItuQwhSAzPZVm3j+9hkJY+rkAkjIRvfGva/zikyvp
         MzcqDy/Q1i6aZU5R9vCETzWoVC/YqsxAUWWX8iB2Nd0dZIqGZalDqYC5aLm9u4REiVc1
         YBMHu87hwQHVZeen2YoX4szKa3+E4AiRkfWWuYE9PEMHnw3/wp7vekpgt/3LiLHLasqM
         Wq/LC+0Ic3zLvS1NzREkIDN3znznkZanwBglW0WDhoIYvFflWsGvpw4ivSiTzdThkBfS
         mRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104785; x=1724709585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DndzxFLBsXoWOVJIg8a8fMj7UPA/pnh5bGZWmGCHzRU=;
        b=TdrZBpYL0LcOLMB0dsViWA/mkGkafywK8KZ1vxss8AaecShfHPh+UVaw8BI9+TfsYb
         QSGbSV3Tre1EqNOysJYxWBOO1WEiPN8ne1zrlWZdyravRr7/HnszyB+a8aibHrCURzuE
         idGMaQhIXE2UnhWj33G1LMTcIZwbi9FHA9JAh9uFFDHOonG2FxLlaeFGDX9jsAsOLByl
         CzjOX73QntoN+Eq0JPgUX41U+76g98E2VVAJscpBPSxW70YLv2SJjfRWxWuN0/vW0aDo
         nzeQYQ0ekYZk2WfLGPyYbJkOGdHpU8k/jf21L4mnXE/s7MNfpXPXPHj6KSzx9c3zj6iQ
         1wmA==
X-Gm-Message-State: AOJu0Yz/sSXH4HXJQgFZE7WVJ/IS3E2z9kR2tR37YfmoJ6evcIS5WBoL
	O1zi/y+ezezGc4vN0j5xPMMNTQT9vMXmepBpGKdQfIy/LMz830vD
X-Google-Smtp-Source: AGHT+IGxsEkDLmrOYHDhbew/kSzjjydNibKAWQXp3F1EEK76GrId0RSo7WV3OqGCLpI9FCLDkvUXOA==
X-Received: by 2002:a05:6808:e87:b0:3da:a8f1:fe05 with SMTP id 5614622812f47-3dd3ae2501bmr10133201b6e.43.1724104784528;
        Mon, 19 Aug 2024 14:59:44 -0700 (PDT)
Received: from localhost ([2607:fea8:52a3:d200:324c:b818:b179:79b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff3688sm44283121cf.30.2024.08.19.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:59:44 -0700 (PDT)
Date: Mon, 19 Aug 2024 17:59:42 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Subject: Re: Segmentation fault when taking device for a walk
Message-ID: <ZsPATiu0_31D8Qcq@radian>
References: <Zr6cKJePuQd4Dm_n@radian>
 <5096b486-d2c1-4a7b-826a-d3e4af9e2eed@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5096b486-d2c1-4a7b-826a-d3e4af9e2eed@gmail.com>

On Fri, Aug 16, 2024 at 04:53:41AM -0700, James Prestwood wrote:
> Hi Richard,
>
> On 8/15/24 5:24 PM, Richard Acayan wrote:
>> Hi,
>> 
>> A segmentation fault occurs in station_start_roam() when the station is
>> disconnected from an access point, or in other words, when the station's
>> connected_bss is NULL. Usually, this is triggered by a timeout, possibly
>> scheduled in response to a weak signal event.
>> 
>> This is occurring on my Pixel 3a running postmarketOS/Alpine Linux, when
>> receding from an access point, on iwd 2.19. I have collected 6 coredumps
>> of the crash in the span of around 2 weeks and would be willing to use
>> GDB if more information is necessary for a patch.
>> 
>> Sample:
>> 
>> 	Program terminated with signal SIGSEGV, Segmentation fault.
>> 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
>> 	
>> 	warning: 2880	src/station.c: No such file or directory
>> 	(gdb) bt
>> 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
>> 	#1  0x0000aaaadf28c544 in timeout_callback (fd=<optimized out>, events=<optimized out>,
>> 	    user_data=0xffff876b2e20) at ell/timeout.c:68
>> 	#2  timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0xffff876b2e20)
>> 	    at ell/timeout.c:57
>> 	#3  0x0000aaaadf28b9d0 in l_main_iterate (timeout=<optimized out>) at ell/main.c:461
>> 	#4  0x0000aaaadf28bac0 in l_main_run () at ell/main.c:508
>> 	#5  l_main_run () at ell/main.c:490
>> 	#6  0x0000aaaadf28bce4 in l_main_run_with_signal (
>> 	    callback=callback@entry=0xaaaadf1f1110 <signal_handler>, user_data=user_data@entry=0x0)
>> 	    at ell/main.c:630
>> 	#7  0x0000aaaadf1f0b0c in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:611
>> 	(gdb) p station->connected_bss
>> 	$1 = (struct scan_bss *) 0x0
>> 
> Its hard to say without any debug logs as well but it appears the disconnect
> never cleared out the timer used for the next roam attempt. I did fix a hang
> due to a disconnect coming in during a roam attempt after 2.19, but I can't
> really make heads or tails without debug logs to see what happened
> before/after the disconnect.

It happened again with debug logs enabled. Relevant snippet (from
logread):

	[Aug 17 21:22:12] daemon iwd: src/station.c:station_roam_state_clear() 5
	[Aug 17 21:22:12] daemon iwd: event: state, old: connected, new: disconnecting
	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_link_notify() event 16 on ifindex 5
	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_deauthenticate_event() 
	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_disconnect_event() 
	[Aug 17 21:22:15] daemon iwd: src/station.c:station_disconnect_cb() 5, success: 1
	[Aug 17 21:22:15] daemon iwd: event: state, old: disconnecting, new: disconnected
	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
	[Aug 17 21:22:36] daemon iwd: src/station.c:station_roam_trigger_cb() 5

Afterwards is the segmentation fault.
