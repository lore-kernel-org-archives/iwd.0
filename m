Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2799A59
	for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767853; cv=none; b=e2+7BmalAC4wjKFtl53AdayEhZKpTn8Y7seI05uAq/8Tn70jMtzkfHi/rh9h0nhgqigECpHAVXahoIBqJQaBUtWLfR62vqW3tj+U8w6VAkBPfo8/vnM/w0YqrC6YB3I50fGsxab0EACu65ixsDBL4kfeQyU5tYS4N5QWE+gkSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767853; c=relaxed/simple;
	bh=TzCLwPf/t/0/3bt0jdGzDaxMOShHoAq+JQbM/vSnxcI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lTc2qtggTVgFU6oW4dRQCL/MskntlFjK/H75A+Al0XxJq0Bj37rNHm5Cvh8Tm1bUVWjqTdXMFt2Z6jAuVWzotsIrozxtZ4Z045fZf8/4/INyrXq03M5AnrExDebw5UWyJeALi0IJ/725zix6NSbBVaOUhr1LIBY/2JjnzDiDaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkIq6oJI; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkIq6oJI"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf7ba05f75so4773306d6.0
        for <iwd@lists.linux.dev>; Thu, 15 Aug 2024 17:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723767851; x=1724372651; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmskmZd2nnWew3kycfSSOdPXGRZew/+Dew5DSlEs31w=;
        b=HkIq6oJIMfKWhyUrSASfLDmYnXld8kOmBIWNUOgFOwt8FPWXfpA4KSwGFKObC4Vptn
         tSB1H6EhSmxEk567XQIRX7kfST4Xi3EPDATvLHrB/GyAeKQQrYxjrjDvjqC0NJ0RsxcE
         7ZAmq1TYVhPpuPC1da46AT9OZBZb6kstr9HuODZ4CtzsSPxnfQmCvvnJiYJ36EfZCTgO
         OqY16FC/cJepFPIJyPzNlvsvcBvHE1Et7jdz2dK7NepfBvt4XEieu+P6iiZD19lctuIe
         j4fVlkKrS8XpCod3/Tc2xLSrfhUzFox7rGBy8+PiU+paw6ZETwJatwxMaay3nVN+V9NL
         BFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723767851; x=1724372651;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmskmZd2nnWew3kycfSSOdPXGRZew/+Dew5DSlEs31w=;
        b=mUzi9w831zWjXLodeOTwvzXYb7pcL7WTD9DB7jaRvdn53fkRkbcHtctDspUCC+xz/r
         a9K67/6msDqshAmxEngFJh7UCfpbCWJ9vXUxMkkdRv7AIBDMTRORK8H86+rROOjE87zI
         lm5SOkS4Yl++E+ovBm2QN6Zwn/cRxOZpfcktyMLvJixysaShrz8EPoLF5kfM6zr4IO8i
         2nZKd/4q73nGe5gtM37sna4l88+vMPMe+rM612OF5WHyw+lPnJVhi2oXj0theK5uxzVi
         B8aulPaXV4sPburD9ICsW2HDL2Lung3fVHYfH6VFQqVkncf2daKM6wG4ehUyph2IUsem
         J8Uw==
X-Gm-Message-State: AOJu0Yz1q40pWz36ew0hClERNW+oh3x2vSuPCEQ5K7uSj4YAijZOSG7i
	s8broPJp6wds0fwbXnr+1QExiKuB5/QYZNElxiap1aqO/0tN1zV7iSO8aBGd
X-Google-Smtp-Source: AGHT+IFz9DThDRQsBL3ocWadpWEOfkDgexyv1BnYFo9EClkCDJmFeVvzE64p8aaLMUqzVpYp4yh0kA==
X-Received: by 2002:a05:6214:2622:b0:6b7:923c:e0b7 with SMTP id 6a1803df08f44-6bf6de389a2mr93375296d6.21.1723767850596;
        Thu, 15 Aug 2024 17:24:10 -0700 (PDT)
Received: from localhost ([2607:fea8:52a3:d200:324c:b818:b179:79b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec6006sm11541136d6.76.2024.08.15.17.24.10
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 17:24:10 -0700 (PDT)
Date: Thu, 15 Aug 2024 20:24:08 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: iwd@lists.linux.dev
Subject: Segmentation fault when taking device for a walk
Message-ID: <Zr6cKJePuQd4Dm_n@radian>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

A segmentation fault occurs in station_start_roam() when the station is
disconnected from an access point, or in other words, when the station's
connected_bss is NULL. Usually, this is triggered by a timeout, possibly
scheduled in response to a weak signal event.

This is occurring on my Pixel 3a running postmarketOS/Alpine Linux, when
receding from an access point, on iwd 2.19. I have collected 6 coredumps
of the crash in the span of around 2 weeks and would be willing to use
GDB if more information is necessary for a patch.

Sample:

	Program terminated with signal SIGSEGV, Segmentation fault.
	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
	
	warning: 2880	src/station.c: No such file or directory
	(gdb) bt
	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
	#1  0x0000aaaadf28c544 in timeout_callback (fd=<optimized out>, events=<optimized out>, 
	    user_data=0xffff876b2e20) at ell/timeout.c:68
	#2  timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0xffff876b2e20)
	    at ell/timeout.c:57
	#3  0x0000aaaadf28b9d0 in l_main_iterate (timeout=<optimized out>) at ell/main.c:461
	#4  0x0000aaaadf28bac0 in l_main_run () at ell/main.c:508
	#5  l_main_run () at ell/main.c:490
	#6  0x0000aaaadf28bce4 in l_main_run_with_signal (
	    callback=callback@entry=0xaaaadf1f1110 <signal_handler>, user_data=user_data@entry=0x0)
	    at ell/main.c:630
	#7  0x0000aaaadf1f0b0c in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:611
	(gdb) p station->connected_bss 
	$1 = (struct scan_bss *) 0x0
