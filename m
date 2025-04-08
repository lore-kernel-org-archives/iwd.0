Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF805199FC5
	for <iwd@lists.linux.dev>; Tue,  8 Apr 2025 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079175; cv=none; b=kvVNitLK67r1o+Vfn2Iq5ATWdehUsg4sG2WePJAuka+pWignk4+LSDC9zgWZjYs+oxie3dTkd8VkURv629iAUXh6PXeKbgYpFGwFVtXT0tcaZUX7wHtH2ZuEXnGSh0eHAZ06nua16OQEwC1Y6O4ZTSJ/WoSV8tj5F3XfjSQcb4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079175; c=relaxed/simple;
	bh=gdwfxfuceL5PwlOMyYJbpckHwQSJFoJlw5JuEnJNoXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4AXp3Ap7RAFqu5CC/fEGcKrMntkQlsrTtkqPaOuTroJc8RTC6sDEcc7f6Xx1bHSKtZD8d4b7vTAqOmeYSebcWWnKI7MX6U9uMGtt8t0JD8kEeTcsTeY4kTk1SnOaBPlf6bVHRcPwIEK2kqk1YssHDPNGLvs8WVqVGfD5mA3QH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCZoJS8j; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCZoJS8j"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso4948236a91.3
        for <iwd@lists.linux.dev>; Mon, 07 Apr 2025 19:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744079173; x=1744683973; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p0RZ4qGS/GjeLNkne/W4CpQbzPGkz7/mnVeUY59IHQ=;
        b=SCZoJS8jzMR0NyW3zedFzr0Aoh4Qx56qKoLub3W1dfXub9RYIbzbqoVyh+JsTcToWA
         uttmTrD5cbDfK6n/SG0VbLb6jvmcl3/AkbXE6ftVS2WCZWPmpuuq7Ekux+5PeDK2AV+e
         RRWX8shWt7adT3KplBI64X91+gre3Lr3wr0vdNd6phPW0rDvrjYVmWTlq3gEAZ34ASRZ
         FdfsR9CZNfMgofllpehfOrpqdilXbngu8AT7UkU+ivLj8qU34hQAfy6zjqeQNW26i/QY
         yFEuNll+zZo+87bqEmkGHSCiMNtl3scRfik4FyRTxr3cTBFsUgmD7DwesXNctabwO3Im
         3e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079173; x=1744683973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p0RZ4qGS/GjeLNkne/W4CpQbzPGkz7/mnVeUY59IHQ=;
        b=nUHI2uT42wYsUhACwMf1mWKKo3m65kX4A4zITNnzO92JUfZMNkwWwSD+kmkep2mUy8
         qmlxn8yZfyLn4KYkaqIlf7QDQ8xY6uPCTyKMPTeLT2S9vWAsmwmH/0kwI5yVBTszdRk9
         Z06fmdImOc57cml3l1wQOAX8RKhIR/sbuOta+wCFV5rlaMLdmaCcypQHCx2LtqpUYIZ3
         jfMC2aMH0Y6hyTM1bpXcOVc03Xh0De47Aw9lwKGHWAYBrbVCk/7AYsCHe9V14vWZE7Vl
         B1HTYOqBgdPsG1vSe5oXV/NHYsL0ZlIalGWBH6lixR7MQQfeGwzmcRb+CFPV24a7cfG/
         +VUQ==
X-Gm-Message-State: AOJu0YyL1uzLxEExQ7O1FockXgIqjW04tB2iDRwNBAUNneMcQiyDmhlh
	MrLvBBl1T5gfNIWm1RcEr1wzkPC/9/SLJfcIQm6P3vPpgTO/6ZEqAoqwC7Qr04imOPR4XpH/Lgw
	Dq1arSAT90bwU+6xZEoAjbfymQZA=
X-Gm-Gg: ASbGncswoO8ZOXLtDKnYd/GpEcopjv/8JCunQqyphPnF+sibf4w4kPuVCjCBFaFYbx5
	U4hZDfbmgsbJuY7FJ/3bFKSF7UvmcdAYmnRSrpy5+ElhvopVZccYHRqnO384Dw3oli//qksMM5U
	KVfwR7bQhCLynxnlxvUSWq6BphWQUdoYgixB4g4vo=
X-Google-Smtp-Source: AGHT+IHfleBXz05ffN1EGszRtjcK/fhjPcSjzII1bM24KkawqKmtnGo9IdH4K7/eiu375AXQ0FCuSZNS4iMI1cWwgRM=
X-Received: by 2002:a17:90a:d007:b0:2ff:6608:78cd with SMTP id
 98e67ed59e1d1-306a47e0781mr23807470a91.9.1744079173039; Mon, 07 Apr 2025
 19:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_Mgb9fHFcwW1KoNZ2QxZVH2rKZuwG5i78c8us0HjwO7Eg@mail.gmail.com>
 <f436a083-5e70-46f3-841d-c59c10c6adf0@gmail.com> <CAG17S_N=DnnnLY+hGiqQCfopr1ZngCW0T4_H0+yyP9Z8DiqzhQ@mail.gmail.com>
 <27237ccf-edbe-4a1f-a39c-6070e4a7e821@gmail.com>
In-Reply-To: <27237ccf-edbe-4a1f-a39c-6070e4a7e821@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 7 Apr 2025 21:26:01 -0500
X-Gm-Features: ATxdqUFAw-NRm_CE_dQUdWF9h5rwomflKk5HoV1VhqH7fF4i-O2INB0uxBbVDIk
Message-ID: <CAG17S_NmCR--cBGMmjRB5VmEcuJyKqqriktbzo_Z4eHGXg8TdQ@mail.gmail.com>
Subject: Re: strange behavior with synthetic ap0
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:03=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> wr=
ote:
>
> Hi Keith,
>
> What does:
> iw phy | grep -3 'interface combinations'
> say?
>
> Typical WiFi chips support only a single channel (e.g. #channels <=3D 1)
>
>  >
> > How do I ensure it is on the same frequency? I would think that I
> > would have to change the freq to whatever the freq of the SSID I am
> > connecting to. The process would then have to be: query the SSID for a
> > freq then stop and restart the AP... Wouldn't this disconnect the AP0
> > from whatever is connected to it?
>
> There should be a way to tell the AP to switch the current channel.  The =
AP will
> inform clients about the channel switch and they should end up at the new
> frequency without losing connectivity.
>
> >
> > A bit oif background, I am trying to write a python script to do a bit
> > of magic. We use connman as the front end and iwd as the wifi
> > controller and there is no real good way to have this headless,
> > embedded device always allow a connection, so I am trying to get a
> > python script to monitor dbus and when it looses its wlan0 connection
> > to start ap0 and allow a connection that way unless it 'sees' an SSID
> > it already recognizes. In that case, I am having is down the ap0 then
> > connect to the SSID on wlan0. That works, but it must be serial: shut
> > down ap0 before connecting to SSID on wlan0 or it complains that the
> > password is bad.
> >
> > I may be mistaken, but I think that a year or so ago (kernel 5.x or
> > 6.1) it used to actually allow both simultaneously.
>
> Different firmware?
>
> >
> > I built a kernel last night so that I nave nlmon available to query
> > what is being passed if that is needed.
> >
>
> I doubt nlmon will show anything useful.  You'd need to have information =
about
> how the firmware / kernel driver works and any constraints.
>
> Regards,
> -Denis

Denis,

I am guessing it was an older firmware...
this is the current firmware:
[    3.587752] brcmfmac: F1 signature read @0x18000000=3D0x15264345
[    3.596066] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    3.596833] usbcore: registered new interface driver brcmfmac
[    3.880014] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
[    3.880438] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
01-b677b91b

With the current version, I get this:

root@pi4(rw):~# iw phy | grep -3 'interface combinations'
         * crit_protocol_stop
         * update_connect_params
    software interface modes (can always be added):
    valid interface combinations:
         * #{ managed } <=3D 2, #{ P2P-device } <=3D 1, #{ P2P-client,
P2P-GO } <=3D 1,
           total <=3D 3, #channels <=3D 2
         * #{ managed } <=3D 1, #{ AP } <=3D 1, #{ P2P-client } <=3D 1, #{
P2P-device } <=3D 1,
