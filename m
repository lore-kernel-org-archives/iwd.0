Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA746B91
	for <iwd@lists.linux.dev>; Tue, 20 Aug 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169639; cv=none; b=pgIe/yb+SShOXjAdHvYkv39vD5SybXmQOpPdEdsWb1MpazynK01h/UFfA8ANt3n8B6oTXJoEjujIKF/X0UBV9x25blXFQ08FY2oMzMfL1TPeivmTATUpBHd3L8SukLl6q2vdhY7WfiV2bOydbDyrpnX7x755Z90V7P8RJ4ohWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169639; c=relaxed/simple;
	bh=hsuXdl0/uUBvV2x/vo324J14jgMG6Aal+2GxYLJHBeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbFIPWjqsGIYdj0qhLJrSqqkGX3F/xgwEXHBpJaP1csL8mMyQdnrPy1IRFdT8rIWDYG/F8Bssjhf71hGzRL0mgjJaZNrVJrSy8fVBGgl1IOtHf6FhPJzk7ZrYTttmTxPAPVKwBEPx8qE9weeMkR/mAVza4fpGwfAC+BB4ra92oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuOQFAyR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuOQFAyR"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf775d1bdfso29398166d6.1
        for <iwd@lists.linux.dev>; Tue, 20 Aug 2024 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724169637; x=1724774437; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujbg1KTFPhYCDW5OuQlGPi8cpcme4BmGumUFV9qQa08=;
        b=FuOQFAyRVMZZA/gKieK76jVI1bzxV/nhDjXRmsoiNzz/UNzZJIazdI1T75yEZPoOii
         AVj5idLpaaByM6YZ6K6CH7h3bqVJl39Rg67GWpe3cd+hWcLjr3hpYJFHYeUhGhJuY7Lo
         qW5TH3Kb/NgAjsNnVBXo0Ctl2GmYSbjeN/tM5PeItcctA942X841geN99INDJITjAR2s
         9ZifoJmYcJ2uATtKfiUz1ZEkjKw3ntRZHLZCUJ2B8GqkofAdQsJr7bdN5NTXYdKrFYez
         rXLJtOuszTyOyuKIVZer1uAvY+ptduALtczBRW6sAQXUA+3FwuF0Nwpz7y/bpBUgaIqx
         rz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169637; x=1724774437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujbg1KTFPhYCDW5OuQlGPi8cpcme4BmGumUFV9qQa08=;
        b=p01yftf2LuU4Jni+ZB/tUzU9XKaYP8TU56n6P3rqeZeVqtolOSd1QScoAYR9rYM9h6
         Ia02m77vTOSwFYf9MIXutyJAi70/Ptmu7+kjAz1B1Eohk/0rA3G3sRo7QzMfl/VgLeyG
         YNA3SaXfcRdFLUBCyf/fS35GuF8Wz6ul+STEF95JQjysNobGIehbYtPRMF9LV6sDGphI
         JKKJOwUUx794koZwPrMqsvrD4fIqZL4xwuBMr/DRGpM60yijAgKc6u1bYu2giKiMKvwA
         Kn6O4+pl4ZFly4CswQ1xvz+CEPFH8+SrlzJD7M5zz5vixVlc5YjKdATRrCbG7AjeFivz
         +F+Q==
X-Gm-Message-State: AOJu0YwBoefSa8QE/dh5xTYqXB0YQWD5Xuam3/II/N9lJR2TDEgAAG15
	NtPOgQv9xNw26+OeD84N/oHhEMsiTTOgZ47uSwWQpGpNW9ZpyxNE
X-Google-Smtp-Source: AGHT+IGlnZS9QFfyCxuYdsCVCwdmOoiIM2SLZxKITb40HQEIi3X/U6Hlc1ULr/3kGo54rvX2viZf/g==
X-Received: by 2002:a05:6214:3da0:b0:6b5:52da:46f2 with SMTP id 6a1803df08f44-6bf7cd89a6amr201186216d6.6.1724169636887;
        Tue, 20 Aug 2024 09:00:36 -0700 (PDT)
Received: from localhost ([2607:fea8:52a3:d200:324c:b818:b179:79b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3107sm53598446d6.121.2024.08.20.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:00:36 -0700 (PDT)
Date: Tue, 20 Aug 2024 12:00:34 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Subject: Re: Segmentation fault when taking device for a walk
Message-ID: <ZsS9oqna82kDmgJy@radian>
References: <Zr6cKJePuQd4Dm_n@radian>
 <5096b486-d2c1-4a7b-826a-d3e4af9e2eed@gmail.com>
 <ZsPATiu0_31D8Qcq@radian>
 <e6ff554e-ad17-46e3-b614-ac6da796b337@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ff554e-ad17-46e3-b614-ac6da796b337@gmail.com>

On Tue, Aug 20, 2024 at 08:04:20AM -0700, James Prestwood wrote:
> Hi Richard,
> 
> On 8/19/24 2:59 PM, Richard Acayan wrote:
> > On Fri, Aug 16, 2024 at 04:53:41AM -0700, James Prestwood wrote:
> > > Hi Richard,
> > > 
> > > On 8/15/24 5:24 PM, Richard Acayan wrote:
> > > > Hi,
> > > > 
> > > > A segmentation fault occurs in station_start_roam() when the station is
> > > > disconnected from an access point, or in other words, when the station's
> > > > connected_bss is NULL. Usually, this is triggered by a timeout, possibly
> > > > scheduled in response to a weak signal event.
> > > > 
> > > > This is occurring on my Pixel 3a running postmarketOS/Alpine Linux, when
> > > > receding from an access point, on iwd 2.19. I have collected 6 coredumps
> > > > of the crash in the span of around 2 weeks and would be willing to use
> > > > GDB if more information is necessary for a patch.
> > > > 
> > > > Sample:
> > > > 
> > > > 	Program terminated with signal SIGSEGV, Segmentation fault.
> > > > 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
> > > > 	
> > > > 	warning: 2880	src/station.c: No such file or directory
> > > > 	(gdb) bt
> > > > 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
> > > > 	#1  0x0000aaaadf28c544 in timeout_callback (fd=<optimized out>, events=<optimized out>,
> > > > 	    user_data=0xffff876b2e20) at ell/timeout.c:68
> > > > 	#2  timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0xffff876b2e20)
> > > > 	    at ell/timeout.c:57
> > > > 	#3  0x0000aaaadf28b9d0 in l_main_iterate (timeout=<optimized out>) at ell/main.c:461
> > > > 	#4  0x0000aaaadf28bac0 in l_main_run () at ell/main.c:508
> > > > 	#5  l_main_run () at ell/main.c:490
> > > > 	#6  0x0000aaaadf28bce4 in l_main_run_with_signal (
> > > > 	    callback=callback@entry=0xaaaadf1f1110 <signal_handler>, user_data=user_data@entry=0x0)
> > > > 	    at ell/main.c:630
> > > > 	#7  0x0000aaaadf1f0b0c in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:611
> > > > 	(gdb) p station->connected_bss
> > > > 	$1 = (struct scan_bss *) 0x0
> > > > 
> > > Its hard to say without any debug logs as well but it appears the disconnect
> > > never cleared out the timer used for the next roam attempt. I did fix a hang
> > > due to a disconnect coming in during a roam attempt after 2.19, but I can't
> > > really make heads or tails without debug logs to see what happened
> > > before/after the disconnect.
> > It happened again with debug logs enabled. Relevant snippet (from
> > logread):
> > 
> > 	[Aug 17 21:22:12] daemon iwd: src/station.c:station_roam_state_clear() 5
> > 	[Aug 17 21:22:12] daemon iwd: event: state, old: connected, new: disconnecting
> > 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> > 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> > 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> > 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_deauthenticate_event()
> > 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> > 	[Aug 17 21:22:15] daemon iwd: src/netdev.c:netdev_disconnect_event()
> > 	[Aug 17 21:22:15] daemon iwd: src/station.c:station_disconnect_cb() 5, success: 1
> > 	[Aug 17 21:22:15] daemon iwd: event: state, old: disconnecting, new: disconnected
> > 	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> > 	[Aug 17 21:22:15] daemon iwd: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
> > 	[Aug 17 21:22:36] daemon iwd: src/station.c:station_roam_trigger_cb() 5
> > 
> > Afterwards is the segmentation fault.
> 
> Do you happen to have the logs a few minutes prior. The roam timeout is
> defaulted to 60 seconds, so at some point it was re-armed but the logs don't
> go back that far. Its trivial to handle the segfault but I suspect the roam
> timeout being rearmed is also leaking memory so we should address that as
> the root cause.

Unfortunately not, only for the last half-minute (with personal
information). Here's a bit more that I don't need to redact:

	[Aug 17 21:22:07] daemon iwd: src/station.c:station_roam_failed() 5
	[Aug 17 21:22:07] daemon iwd: src/wiphy.c:wiphy_radio_work_done() Work item 279 done
	[Aug 17 21:22:12] daemon iwd: src/station.c:station_dbus_disconnect() 
	[Aug 17 21:22:12] daemon iwd: src/station.c:station_reset_connection_state() 5
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

I can confirm, though, that there are more timeouts than expected, even
after (presumably) clearing the last timeout:

	Core was generated by `/usr/libexec/iwd -d'.
	Program terminated with signal SIGSEGV, Segmentation fault.
	#0  0x0000aaaadf1686a0 in station_start_roam (station=0xffffb0527b30) at src/station.c:2880
	
	warning: 2880	src/station.c: No such file or directory
	(gdb) p *watch_list[12]
	$1 = {fd = 12, events = 1073741825, flags = 1, callback = 0xaaaadf1ec4f0 <timeout_callback>, 
	  destroy = 0xaaaadf1ec350 <timeout_destroy>, user_data = 0xffffb0530dd0}
	(gdb) p *(struct l_timeout *) watch_list[12]->user_data
	$2 = {fd = 12, callback = 0xaaaadf1687a0 <station_roam_trigger_cb>, destroy = 0x0, 
	  user_data = 0xffffb0527b30}
	(gdb) p *watch_list[13]
	$3 = {fd = 13, events = 1073741825, flags = 0, callback = 0xaaaadf1ec4f0 <timeout_callback>, 
	  destroy = 0xaaaadf1ec350 <timeout_destroy>, user_data = 0xffffb0530ef0}
	(gdb) p *(struct l_timeout *) watch_list[13]->user_data
	$4 = {fd = 13, callback = 0xaaaadf1687a0 <station_roam_trigger_cb>, destroy = 0x0, 
	  user_data = 0xffffb0527b30}
	(gdb) p *watch_list[14]
	$5 = {fd = 14, events = 1073741825, flags = 0, callback = 0xaaaadf1ec4f0 <timeout_callback>, 
	  destroy = 0xaaaadf1ec350 <timeout_destroy>, user_data = 0xffffb0530c50}
	(gdb) p *(struct l_timeout *) watch_list[14]->user_data
	$6 = {fd = 14, callback = 0xaaaadf1687a0 <station_roam_trigger_cb>, destroy = 0x0, 
	  user_data = 0xffffb0527b30}
