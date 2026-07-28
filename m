Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCC42A7B7
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244682; cv=none; b=qvU2KujnTijl5hsDGoDWpHJjFIMErjrRQdzD4iu7Cw1zmDxzHS5m5EnC+cuwZCv7Y2VRTGvsqypDF3IvURtuD5N9+uYBYvqgCnMCYl89SVJ7FljgGg0+BftECK9g3Vvn7quVR1bm2VxYz4MmSxtnaQGOMAr2Q3DT34uo7U6hw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244682; c=relaxed/simple;
	bh=tWfrxo787cH46YiFNsGF9J7aiDYXMK6MXNanio4Das8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z1BcuT6Rw2jgQ8uNmsRFN0L/qtULM1TBAZeJnPw/7ayxMuQZJfsdLGNt1n1glgWfcu4p9XkPJcdU6N9XERAra9DfMI9Ki8bih9ymb0CaaavTftWdLwzmQjzZRwTYRzhRpC4ychkOg+lavk1r0AVA9yXXwKoCamb/2E2lr6OVIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJp6HE6z; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJp6HE6z"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-902e4af2d9dso7821656d6.0
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785244679; x=1785849479; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eepjXkMTzU23HPNVD8fnFBQEw7VgKezjWqEXLJuYlF8=;
        b=OJp6HE6zKjg1FoD/e9jlFFlwjBuLd0NzwhzL7aNLO3R48ICZHNueHEuqZzBoYEClfB
         kmGrhSLD75j4dH+XTl77tqAJFTszbxcn6O73kAwdIYEm1M9oe4ZVeNHe02RMaEZKTiJx
         fQ/8bQorxzYC+wcBjQmKW6LHv4B/ChCwHDBHXBvUAui+fwLoujEk9hkwZeMiAWjsNeSA
         F5gODu8SU2xcKn9/ESGR8MDJdAimwL3Yzgz9rpYwF9g0O0FdlIrTHRjfjTO8NmWgyx9l
         98+kmsSLMR2rPbOP71m1s0IK5ppvxhaQIU25TMcCxtgf7uHmpbmZN1Vmt+BiqyifIm4e
         TgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244679; x=1785849479;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eepjXkMTzU23HPNVD8fnFBQEw7VgKezjWqEXLJuYlF8=;
        b=daEKIkYM4Dnr0ai1bBr/BmtILicVk2aLYvwZ7h18Exj7YrwJ9g8y4pcxVEKsscjAsS
         0JdbNpqUTnIw7MlvagUpe/twP1LSrYPkdm017lp1qAW4yhmjn3L8Jo/otn0Z5DbC2Fme
         xgQUqVSEBwGExUfckM8rdhAGQEVuEHpZ5w+gzDcQ1DVXn6Ts92k0IlIrk/7n3DPwRg9r
         uXLnaJlVJOipaFWJ21WxAPhGQjNB2vsoZJ2UPgtg0GdpnsFLz1T3vqsSXk+qo5CYaXQI
         WWM6IicLGJpKtzbZamTrEM2nkXBbxIDd+F6s9BjhNFo9gK5xd7Uqz2TDi3oefIjJVc+a
         bFTA==
X-Forwarded-Encrypted: i=1; AHgh+RrKCBlCP5VJ6mnj7DiRPOOp63L9+/WHs7a8Bj7zPguyEeJjGA/TfSSD1yX51wPOAvpBP3Y=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxsq0V8U7ntoHrs0Uj4iJFwiMS3WTnbRd4/sbXVLu9510jK5Uaa
	f5/dxbrdSvj4xF3hZV74WVorX15ZRzXHZ837zbBegSGxVf4GUluqR663
X-Gm-Gg: AR+sD12yoHyk0LLzYmnH55kT3qSaO73jBexyovLVgzQbG/b3Yx41/sImrj8sd7tEH6p
	vC8I8xHsRTxiflHN82G8RaF1ZxuSvzJRK0V5PYp6+4KcManQUG0Cgy2fxJtWzXKEHB0xcrjxXXU
	OrfXYKf5vnfty4g4xcxPcwVDOiklAdwFzN+OEGuY60ZfXifggOcTv8O1Uv2KTNTyoNIiHUocyS+
	5umUrZ2EvDXCy6tmb1mtuCqA/F0mW/6/ou2PDXA3HvlGgj81r403J7F9rGLL0ZeJGJQPDhkJXpj
	DJOw/PjLsudaKMc3DvlATmjNgzEko1aVb3gim23adob8L33mJJdxfWcaYV2AWp/CleDKz/rIvq5
	9aX5pIV/K3QvpnTQfmsRNotJmzE7faFEKkMstAlDb43ftm1rTiIC2pbtgXPOjxXWCeIyrvP3dP0
	rO02XBBVNWJEEZgD/2gKOGCbD/aB/GdoDI5AvSRg==
X-Received: by 2002:a05:6214:2d48:b0:907:6f9c:3b43 with SMTP id 6a1803df08f44-90816febcd5mr23383356d6.2.1785244679403;
        Tue, 28 Jul 2026 06:17:59 -0700 (PDT)
Received: from [10.100.120.121] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e85275a6sm87929446d6.3.2026.07.28.06.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:17:58 -0700 (PDT)
Message-ID: <63459fb3-3f3a-4cab-8b59-9427baad7adb@gmail.com>
Date: Tue, 28 Jul 2026 06:17:56 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Crash in network_info_get_roam_frequencies() when a
 neighbor report completes with -ENOTCONN during disconnect teardown
To: Muhammed Izzet Saglam <m.izzetsaglam@gmail.com>, iwd@lists.linux.dev
References: <889ea449fac3377cf73b35cd8dfe8de1@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <889ea449fac3377cf73b35cd8dfe8de1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muhammed,

On 7/27/26 1:03 PM, Muhammed Izzet Saglam wrote:
> Hi,
>
> iwd 3.12 crashes with SIGSEGV while roaming, when a pending 802.11k
> neighbor report request completes during connection teardown. The
> neighbor report callback only bails out on -ENODEV, so an -ENOTCONN
> completion falls through to a roam scan that dereferences the connection
> state netdev_connect_free() has just torn down.
>
> I hit this twice within one minute on 2026-07-25 and captured both core
> dumps. The backtraces are identical, so this looks deterministic rather
> than memory corruption.
>
> Backtrace (both dumps, identical):
>
>    #0  network_info_get_roam_frequencies (info=0x0, current_freq=2462,
>            max=max@entry=5 '\005') at src/knownnetworks.c:391
>    #1  station_roam_scan_known_freqs (station=station@entry=0x564903a82b50)
>            at src/station.c:3088
>    #2  station_neighbor_report_cb (netdev=<optimized out>, err=-107,
>            reports=<optimized out>, reports_len=0,
>            user_data=0x564903a82b50) at src/station.c:3129
>    #3  netdev_connect_free (netdev=netdev@entry=0x564903a77c40)
>            at src/netdev.c:867
>    #4  netdev_connect_failed (netdev=0x564903a77c40, result=<optimized out>,
>            status_or_reason=<optimized out>) at src/netdev.c:937
>    #5  netdev_disconnected (netdev=0x564903a77c40, result=<optimized out>,
>            event=NETDEV_EVENT_DISCONNECT_BY_SME,
>            status_or_reason=<optimized out>) at src/netdev.c:1004
>    #6  netdev_disconnect_by_sme_cb (msg=<optimized out>,
>            user_data=0x564903a77c40) at src/netdev.c:1019
>    #7  process_unicast (genl=<optimized out>, nlmsg=0x7ffffcf571d0)
>            at ell/genl.c:860
>    #8  received_data (io=<optimized out>, user_data=0x564903a69bb0)
>            at ell/genl.c:972
>    #9  io_callback (fd=<optimized out>, events=1, user_data=0x564903a69b00)
>            at ell/io.c:105
>    #10 l_main_iterate (timeout=<optimized out>) at ell/main.c:463
>    #11 l_main_run () at ell/main.c:511
>    #12 l_main_run () at ell/main.c:492
>    #13 l_main_run_with_signal (callback=0x5648f3df5bc0 <signal_handler>,
>            user_data=0x0) at ell/main.c:633
>    #14 main (argc=<optimized out>, argv=<optimized out>) at src/main.c:610
>
> The faulting line is knownnetworks.c:391, with info == NULL:
>
>    for (entry = l_queue_get_entries(info->known_frequencies); entry && max;
>
> Sequence, as I read it:
>
>    1. The AP disconnects us, so netdev_disconnect_by_sme_cb() runs
>       (NETDEV_EVENT_DISCONNECT_BY_SME).
>    2. netdev_connect_failed() -> netdev_connect_free() tears the
>       connection down and completes the outstanding neighbor report
>       request with an error.
>    3. station_neighbor_report_cb() is invoked with err = -107
>       (-ENOTCONN).
>    4. The guard at the top of that callback only returns early for
>       -ENODEV:
>
>          if (!station->preparing_roam || err == -ENODEV)
>                  return;
>
>       so -ENOTCONN continues to:
>
>          if (!reports || err) {
>                  r = station_roam_scan_known_freqs(station);
>
>    5. station_roam_scan_known_freqs() then reaches
>       network_info_get_roam_frequencies() with the network info already
>       gone, and dereferences NULL.
>
> Commit 155c266 ("station: add checks to prevent multiple roam scans",
> Jan 2023) fixed a different path to the same crash signature and is of
> course already in 3.12. This one arrives through the disconnect teardown
> rather than the roam rearm timer, and the code in master still looks
> affected: station_neighbor_report_cb() special-cases -ENODEV only, and
> station_roam_scan_known_freqs() has no NULL check on the connected
> network.
>
> I have not written a patch because I do not know which fix you would
> prefer -- treating any err as terminal in the callback, checking
> station->connected_network before the fallback scan, or cancelling the
> neighbor report request earlier in netdev_connect_free(). Happy to test
> a patch on this hardware.
>
> System:
>
>    iwd            3.12 (Arch Linux, iwd 3.12-1)
>    kernel         7.1.5-zen1-1-zen (x86_64)
>    device         Intel Wi-Fi 6E AX210/AX1675 2x2 [Typhoon Peak]
>                   [8086:2725] rev 1a, iwlwifi
>    firmware       89.735b75a4.0 ty-a0-gf-a0-89.ucode, op_mode iwlmvm
>    band at crash  2462 MHz (2.4 GHz, channel 11), roaming on a weak link
>
> Both core dumps are still on disk if anything else would help.
>
> Thanks,
> Muhammed Izzet Saglam

Thanks for reporting this. A quick fix is certainly to just add 
-ENOTCONN to station_neighbor_report_cb(). The only thing that makes me 
nervous is if -ENOTCONN is a possible return from netlink. I'm also 
questioning why netdev needs to call the callback in the first place 
(e.g. with -ENODEV). We just bail out and ignore it. I can see the 
argument for netdev completing the API contract with the caller, but it 
also feels like a waste of cycles to me.

Thanks,

James

