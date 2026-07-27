Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444B4252A7
	for <iwd@lists.linux.dev>; Mon, 27 Jul 2026 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182633; cv=none; b=rzfLz2RhPATLmnIRNKuOLi377xgR3/aMDyhbqhT2xUo4hUURwCLUc1jr0goZpCiMqvkL80kd4hLZkRe6u9vWZar6AZ741sqQYtCE47p3IIaAJ/g8kSUU8HbzA//rSVr6XW9b2VTpIf5AXJdrW69yTwsLVvWOgQq42VWhfKMsxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182633; c=relaxed/simple;
	bh=m7lAk0IbbIIJ8aZYcF8CQ8BzbBvJVZSOyNGJwLoumx4=;
	h=Date:Message-ID:From:To:Subject; b=VTrxfW/rikkbGeAfXuEABXOVc770AN98X0n98JmweXzEZUG/J0cQoA+Yxu8JBsyTYPRLh7P6K1L7eLpcCqoWwgzL1ENkJCOFxlAx0Rhxunvy3v5g20uoAlgkLIg04y0UO798IhLASfIq4bX57rQfuZaxoi566zno8wkFjeUp0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8Tt5f60; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8Tt5f60"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1783652f8f.0
        for <iwd@lists.linux.dev>; Mon, 27 Jul 2026 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785182630; x=1785787430; darn=lists.linux.dev;
        h=subject:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m63SL4ZA0auHGFgOBoVT7Vwt+H9LrDmemSQiP4N89ws=;
        b=R8Tt5f60vRJDGbf5yrfKHi4FPBNKNNjSGHLeueVp5/YokM15OvZoXmFU6foFves9Mk
         i554+aEvJzBcuTv4yq0hedNv4dHOLDQoL5XD+ob5YqPD57I8dhZiGszuBMY9hIYoq4+d
         m85xs1m0jDVjgjZu0/BHrI8SCfxo8NRQQMChilnQcAVEwE9tE/N59aMlw8TrlYIwHjB7
         8Id6BbjR5tgkEDnA0iFukcyRqcau3uVOkjmGLWP8GN9YSfqPjgkYcaUYa0bOSxt6TN1+
         Jw+ZfdFabN06xBXjmCD8KlRKb2A+AUppVvACQ2Ls+jOpRzRW9f9zCpoldnsjhNz5PaNW
         YGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182630; x=1785787430;
        h=subject:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m63SL4ZA0auHGFgOBoVT7Vwt+H9LrDmemSQiP4N89ws=;
        b=sFNBgGgv5LWaGCk7JBKYR3hQQFHzSksEongQla2eTLjr7GVLBFtwwRwxzzYtyl1ilR
         vkfjrJT0BI7SCsRm3vw46n2qpQE+hCawl5tKdGvMcMUXRkHdECN67xd691xJhDD31k4k
         W2YnVERwC0p9VhXQR8nju2//M+/6aUeLs79qPIqTbr73dTzQVI046Rb8YMggghtY+5zb
         aFM6ZQSc7D3M78/c8V+7uLsQs5dQK0/EQtMHdmi58RGgRyod17F5rz5K9GEy1yeMhUlu
         KXeRzoNbGpKdAPIwwcxLRc29cGU6E5c3syvpTfc71jgi4J2HBq6KVEgod2kCkRIsUSCV
         GqCw==
X-Gm-Message-State: AOJu0YzcxiGwbnBfnBBhSJAeExf6tYFpXO1LqhZyVGpqrspxSb2LTieT
	pGVjg3reCYHWyjjkeX5KSXYGPOvIdEzj5SM/keq8QJ9YWEMaTpPsiMK5vQNlAiC3+J4=
X-Gm-Gg: AR+sD10UAWy68v5byzeAmynioq9UjPgpvidhrpgac3gNsCiKXpgSzqVrBeYTdj4EFhx
	+zBtNB+fHDD7M06Z78kGETpGezp3Pu46OIFwW+5ll3velcp3GhgsRSe45nX4WopXVoQcmHzJLIJ
	GR2N94rVZIdmE5qqCWQuMQrJ/E8Pu45f705/VgXwGPqufkOjd5q+3z7QhsmNu1g57dSPZGgYu/v
	WLkMHVnLirVoKkzm/R/Ip0zc8KtT2uNvN8JflVoLCsdBj8zDsQlfdadPRFuhCC0u14wCmnctZfn
	8tdxyJgRT7CHqC1ababPQE976L9glgc9tlK9rOwe5Bt7l5Gs43JFXcGc0RVfJ9Nh39R8bdsS7SK
	i78ivlpiTKRxQdiiikizPepxjS+1NpJakZk7nvL7+Yz3VNkY0Cu+eo1b2Z0MVv4KjdtAbJW3Heq
	uBag==
X-Received: by 2002:a5d:5f54:0:b0:47f:697b:de65 with SMTP id ffacd0b85a97d-47fafa9ed94mr543929f8f.60.1785182629672;
        Mon, 27 Jul 2026 13:03:49 -0700 (PDT)
Received: from localhost ([31.223.9.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm48139966f8f.29.2026.07.27.13.03.48
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:03:49 -0700 (PDT)
Date: Mon, 27 Jul 2026 23:03:48 +0300
Message-ID: <889ea449fac3377cf73b35cd8dfe8de1@gmail.com>
From: Muhammed Izzet Saglam <m.izzetsaglam@gmail.com>
To: iwd@lists.linux.dev
Subject: [BUG] Crash in network_info_get_roam_frequencies() when a neighbor
 report completes with -ENOTCONN during disconnect teardown
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>

Hi,

iwd 3.12 crashes with SIGSEGV while roaming, when a pending 802.11k
neighbor report request completes during connection teardown. The
neighbor report callback only bails out on -ENODEV, so an -ENOTCONN
completion falls through to a roam scan that dereferences the connection
state netdev_connect_free() has just torn down.

I hit this twice within one minute on 2026-07-25 and captured both core
dumps. The backtraces are identical, so this looks deterministic rather
than memory corruption.

Backtrace (both dumps, identical):

  #0  network_info_get_roam_frequencies (info=0x0, current_freq=2462,
          max=max@entry=5 '\005') at src/knownnetworks.c:391
  #1  station_roam_scan_known_freqs (station=station@entry=0x564903a82b50)
          at src/station.c:3088
  #2  station_neighbor_report_cb (netdev=<optimized out>, err=-107,
          reports=<optimized out>, reports_len=0,
          user_data=0x564903a82b50) at src/station.c:3129
  #3  netdev_connect_free (netdev=netdev@entry=0x564903a77c40)
          at src/netdev.c:867
  #4  netdev_connect_failed (netdev=0x564903a77c40, result=<optimized out>,
          status_or_reason=<optimized out>) at src/netdev.c:937
  #5  netdev_disconnected (netdev=0x564903a77c40, result=<optimized out>,
          event=NETDEV_EVENT_DISCONNECT_BY_SME,
          status_or_reason=<optimized out>) at src/netdev.c:1004
  #6  netdev_disconnect_by_sme_cb (msg=<optimized out>,
          user_data=0x564903a77c40) at src/netdev.c:1019
  #7  process_unicast (genl=<optimized out>, nlmsg=0x7ffffcf571d0)
          at ell/genl.c:860
  #8  received_data (io=<optimized out>, user_data=0x564903a69bb0)
          at ell/genl.c:972
  #9  io_callback (fd=<optimized out>, events=1, user_data=0x564903a69b00)
          at ell/io.c:105
  #10 l_main_iterate (timeout=<optimized out>) at ell/main.c:463
  #11 l_main_run () at ell/main.c:511
  #12 l_main_run () at ell/main.c:492
  #13 l_main_run_with_signal (callback=0x5648f3df5bc0 <signal_handler>,
          user_data=0x0) at ell/main.c:633
  #14 main (argc=<optimized out>, argv=<optimized out>) at src/main.c:610

The faulting line is knownnetworks.c:391, with info == NULL:

  for (entry = l_queue_get_entries(info->known_frequencies); entry && max;

Sequence, as I read it:

  1. The AP disconnects us, so netdev_disconnect_by_sme_cb() runs
     (NETDEV_EVENT_DISCONNECT_BY_SME).
  2. netdev_connect_failed() -> netdev_connect_free() tears the
     connection down and completes the outstanding neighbor report
     request with an error.
  3. station_neighbor_report_cb() is invoked with err = -107
     (-ENOTCONN).
  4. The guard at the top of that callback only returns early for
     -ENODEV:

        if (!station->preparing_roam || err == -ENODEV)
                return;

     so -ENOTCONN continues to:

        if (!reports || err) {
                r = station_roam_scan_known_freqs(station);

  5. station_roam_scan_known_freqs() then reaches
     network_info_get_roam_frequencies() with the network info already
     gone, and dereferences NULL.

Commit 155c266 ("station: add checks to prevent multiple roam scans",
Jan 2023) fixed a different path to the same crash signature and is of
course already in 3.12. This one arrives through the disconnect teardown
rather than the roam rearm timer, and the code in master still looks
affected: station_neighbor_report_cb() special-cases -ENODEV only, and
station_roam_scan_known_freqs() has no NULL check on the connected
network.

I have not written a patch because I do not know which fix you would
prefer -- treating any err as terminal in the callback, checking
station->connected_network before the fallback scan, or cancelling the
neighbor report request earlier in netdev_connect_free(). Happy to test
a patch on this hardware.

System:

  iwd            3.12 (Arch Linux, iwd 3.12-1)
  kernel         7.1.5-zen1-1-zen (x86_64)
  device         Intel Wi-Fi 6E AX210/AX1675 2x2 [Typhoon Peak]
                 [8086:2725] rev 1a, iwlwifi
  firmware       89.735b75a4.0 ty-a0-gf-a0-89.ucode, op_mode iwlmvm
  band at crash  2462 MHz (2.4 GHz, channel 11), roaming on a weak link

Both core dumps are still on disk if anything else would help.

Thanks,
Muhammed Izzet Saglam
