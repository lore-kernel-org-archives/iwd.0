Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065C143757
	for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809226; cv=none; b=ASvtZ5+zDu4n9Bk+hhOGM5oXib/E6luArBmPdFKJngwBRVUJBziQm/U+aVcpSkMQCOEq6g0JL3sAIMF5ePXcYHfws0N2BZCt1rUd8wrczFShmv4/zJISe3liwFyd9F+7ALlln0ZbKoE7+mHIvZfWzBEkjpCCPt915ejdqaFl7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809226; c=relaxed/simple;
	bh=FHmfksPvxphLbM44/ajckFccdhXWgwLBt1A2g+sLBVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c7P7fHhNRMlHS8LmrByC6EYZ8E0ZfEqdwxjfZlhyLd0M30opADwFBk+fASbaMiwC8nbsDohYOaW/VCsNthVC329dHeL2OW6R7eOrID8B4r3GS6u6492XY4dENe2G8/Pe0lOYUUtn+eYIg9xTagvc32e3D/DfvTsgq5rvIVrKDN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZy6JJkn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZy6JJkn"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70968db52d0so2025143a34.3
        for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723809224; x=1724414024; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=48+g1BiOySXyTqPWxTBKLIgxQp70v+IW2ioOUSa6Q+I=;
        b=AZy6JJknoO/NHX7EdrJWOcvMRDdD/O13GDOCCSl5U6J84wX0O8yjnbYuTnVlXG1AGj
         uuv+j6C8x0wO9nKqaxbj5w2vCeq6f8Jp5ES8nf+eJrfNR9zSwVg0K1WK3Rml8YslDFws
         a0v0oAzFSrgDWTTmw/BPKUhHKGEIXWu5fQGXQ/OfQmtKSIWzZ/oYk4cwrljVL3dbkXZs
         kJppr4zYdtujhfdPOPw3Tcz/vzQKfFKd0TIv7bVCKVXfwcOI2AezDwV1VGgKABePQYox
         UQq3gHxo8M5C+Ax5CmYI3xdjN7lR4frgrALuFdanOVabiIr85qGyH0Aqv46AoihEABrf
         +f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809224; x=1724414024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48+g1BiOySXyTqPWxTBKLIgxQp70v+IW2ioOUSa6Q+I=;
        b=FsgGhYQbS0UiX3+Gd4o76AvG/4sC5SLONJo+DgqAx45xFUnvIvPsKityUryslvJWWI
         WUWBltZcxHrz0SjFC3kOS2XdUQPCQaTXXkteR9Jf99qXsnTiTrLFKdySF5l/j59AzAz3
         zJiCgXXE4jvRZ5BtOxEZSFjK3whEUMHlxHWFpk+kmPARSSdKbLp/CaHikCPHU+w84A7f
         LXpXC/bTkWwRKr2C0cHF2cuniEtA3T/rkclVE4SEqxyWQPTcPFXoNRicueaaGMARRWLd
         cZ2E23SLedBolPn0qONxoPWOkXfQxCSBQUbsc8hU4RVDoQQviwDw/DJ7dofl5bTwyTrB
         0XHg==
X-Forwarded-Encrypted: i=1; AJvYcCX2D6u3SQFAwhVTHpOSxFlZru/R6WDyK+wXo9Rzn+clAbU1G+/WuIJWZsjIFGba5iYUGxJg5OHeFrbqvkX2drsw6CXr
X-Gm-Message-State: AOJu0Yz4t0ugikLs/uO+jo5dSB051k90bZOVPdi2Y6zAE7lEcWDWznDg
	6bLyMS6VO0HYt4q09c/r/ih1E6Ypc0VbifbjEsPYq/UMFF5BjWz9
X-Google-Smtp-Source: AGHT+IHIR83IoBTMhL4a149JGhd848uMED61jAHTFD3kwq5e4Ia3GwONHSiIi7uc59ub5A5PXjK8vQ==
X-Received: by 2002:a05:6358:6f15:b0:1aa:d71f:692a with SMTP id e5c5f4694b2df-1b39313f1a1mr340199055d.5.1723809224305;
        Fri, 16 Aug 2024 04:53:44 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff055a92sm162517585a.50.2024.08.16.04.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 04:53:43 -0700 (PDT)
Message-ID: <5096b486-d2c1-4a7b-826a-d3e4af9e2eed@gmail.com>
Date: Fri, 16 Aug 2024 04:53:41 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segmentation fault when taking device for a walk
To: Richard Acayan <mailingradian@gmail.com>, iwd@lists.linux.dev
References: <Zr6cKJePuQd4Dm_n@radian>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <Zr6cKJePuQd4Dm_n@radian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Richard,

On 8/15/24 5:24 PM, Richard Acayan wrote:
> Hi,
>
> A segmentation fault occurs in station_start_roam() when the station is
> disconnected from an access point, or in other words, when the station's
> connected_bss is NULL. Usually, this is triggered by a timeout, possibly
> scheduled in response to a weak signal event.
>
> This is occurring on my Pixel 3a running postmarketOS/Alpine Linux, when
> receding from an access point, on iwd 2.19. I have collected 6 coredumps
> of the crash in the span of around 2 weeks and would be willing to use
> GDB if more information is necessary for a patch.
>
> Sample:
>
> 	Program terminated with signal SIGSEGV, Segmentation fault.
> 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
> 	
> 	warning: 2880	src/station.c: No such file or directory
> 	(gdb) bt
> 	#0  0x0000aaaadf2086a0 in station_start_roam (station=0xffff8776ae50) at src/station.c:2880
> 	#1  0x0000aaaadf28c544 in timeout_callback (fd=<optimized out>, events=<optimized out>,
> 	    user_data=0xffff876b2e20) at ell/timeout.c:68
> 	#2  timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0xffff876b2e20)
> 	    at ell/timeout.c:57
> 	#3  0x0000aaaadf28b9d0 in l_main_iterate (timeout=<optimized out>) at ell/main.c:461
> 	#4  0x0000aaaadf28bac0 in l_main_run () at ell/main.c:508
> 	#5  l_main_run () at ell/main.c:490
> 	#6  0x0000aaaadf28bce4 in l_main_run_with_signal (
> 	    callback=callback@entry=0xaaaadf1f1110 <signal_handler>, user_data=user_data@entry=0x0)
> 	    at ell/main.c:630
> 	#7  0x0000aaaadf1f0b0c in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:611
> 	(gdb) p station->connected_bss
> 	$1 = (struct scan_bss *) 0x0
>
Its hard to say without any debug logs as well but it appears the 
disconnect never cleared out the timer used for the next roam attempt. I 
did fix a hang due to a disconnect coming in during a roam attempt after 
2.19, but I can't really make heads or tails without debug logs to see 
what happened before/after the disconnect.

Thanks,

James

