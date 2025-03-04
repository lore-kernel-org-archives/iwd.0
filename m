Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E101F4CB0
	for <iwd@lists.linux.dev>; Tue,  4 Mar 2025 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125634; cv=none; b=bJs463nrCrkqCBZQ8SffTFO8gkczGDN1JBvhRIbLoTyPdqrBT1vRbLLdDZ7R83rDVRyoJh1gH7rkXjX03kv/KjG0kzBcAuXPj1m1CnPcX8MgvWi8Pjw/pFUoHI9ttEo4UH5Wp9ihuDNW/yd4zGfCfBo9WSK2bOfmofgjrFkjvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125634; c=relaxed/simple;
	bh=pzir9Eyf4u9l33roOgKAK9m/ed9/F1crjkjNXeqR2M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVsTC6bEk5PVGtus8MElSkwgvczVzu0g9FYNQOZXOJ9L6i20/zIMVB8AGWqUzly/4lbj1a2JoAEJzgiLqnRFFw/oecbBzopz+syjdY/HnkR81La/re9zo1GnfvpRMwCr143K46T0tteq3vNW7CiVyshn+R5UkbLYJFZJutNQ7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc1U0ouH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc1U0ouH"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf5e1a6cd3so588324166b.2
        for <iwd@lists.linux.dev>; Tue, 04 Mar 2025 14:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741125631; x=1741730431; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqa9VJKfWn8yrHd7ROiYE4NmPQGdd2ajl8y7nUCv60s=;
        b=bc1U0ouHqgACWc5znttJ/xxxdThA7QFS7alRaBb9KroPMhFe4dO7+wzJlR3avV6OXg
         jx5viTRQp/1qUA2Pz8QNULh6Ijwg+b2dErrYplh94RplLn1/WWIm2IlnyilhurFp7hYz
         uGXklRQSfL9j1lXGilGYYaD1fM9iMY0Hk1lQmX951v18bFvwHvEAAi+kA3Tb7sjrdAqh
         FNv7GtfQvI2ZD2OQafzcxh/N6FZx9whpmxU7+sF5J+Ze5EFapMJpnFSi/PpFkSnUJklT
         nbodEqG4CiqFDuJvJVeMjiyPuwH5a79qXQXG2L6StglbON29paD0Z1D5+weBoDOFdPot
         J8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125631; x=1741730431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqa9VJKfWn8yrHd7ROiYE4NmPQGdd2ajl8y7nUCv60s=;
        b=pluzt88vYh01ahHnTV6AcwU8Cqnc6IKLO8ZpA+8fsE25/zpWBzetSO6GSKtRsOKo8F
         E9AT8kPSMtayRaxx2rswefWIMJl5oi+xgNPMRUVV+mwP9ys9mwzrz2CadQRXtnDwXscV
         tueqAJbxiyIpKt2QU6P1DeRkwg1r95nnTsvRE0zjwZnExd0psEMd0Y8t5xBSTCmECI0O
         5QYlWNJgNtDCleUMsgDC/UH0qgbqwAgPYxQOyAhd+mX9tmtK3bA0lUt7c4yNKe1QP+RJ
         3ox9OGF1BFFNHEFaAfj2N/uqQOiZrulNbiVS/53s5J5Dl4LfuSE84qhHROKzPNYQD8k9
         TQsQ==
X-Gm-Message-State: AOJu0YzNXv/rWtitGxcaRoe4qqcrB5T3PL68um56NjGZEuDyYzc1nY03
	0YOIxj6LqQVVH/3m85pqJb5fMsYVIGSoGSQoCIVUtMWdS+4SHU+tZ32lVBc4mLLRqLWH5uYIG9g
	qcT58qgINVsmsKhqpu2KghcaSopKQDPnf
X-Gm-Gg: ASbGncuwS261vWda+gAxnOAmR5ZxYq/mWNwyw6NoHbl/VHgo3ApZ4XtWwYFmu7H/LsF
	pCKuVCpmQjKqmtaaWPgKXXnj7LkUuYIQY3Hd6TjMgA/4A5HtBkH00Pp4+AarsmbeGYeaMGYjylE
	+48whuCpEDCpk7/mNDs1We2qrZxFXYF5SJ08oLlYG/mMDEjVrZxlyVXeilRbdK
X-Google-Smtp-Source: AGHT+IF0SK+hDXIfvtx/VZlHZx4KqLGIl3EMaRtRcjXqZIT8InZ6yIOO7dIrMPI5ouWRNQ4ILiS49+XZA5pphXEwfws=
X-Received: by 2002:a17:907:7d93:b0:abf:3cb2:1c03 with SMTP id
 a640c23a62f3a-ac20da424a3mr100104166b.8.1741125630379; Tue, 04 Mar 2025
 14:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOVeLGQuNx5Cr0WVcNQDJpPZk1bWKcmQ-+YeTxdruiAODBGxBw@mail.gmail.com>
 <44b67fe3-d5e1-405a-9198-18b3d6b81d14@gmail.com>
In-Reply-To: <44b67fe3-d5e1-405a-9198-18b3d6b81d14@gmail.com>
From: Donald <sirspudd@gmail.com>
Date: Tue, 4 Mar 2025 14:00:18 -0800
X-Gm-Features: AQ5f1JrzsjonFUw7x_1Jng76dGwG6nbWDuWU7RLKe-2Wk69xDFABqUJL3sWwKOw
Message-ID: <CAOVeLGSfj5gOzYXifRrzbxxewFn1peKw3GC5aZtRSZ8+Zd2Fdw@mail.gmail.com>
Subject: Re: systemd-networkd managed wireless networks
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Top of the morning,

Thank you both for your responses.

On Tue, Mar 4, 2025 at 6:54=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> wr=
ote:
> > Do the iwd dev team strongly recommend having iwd manage the wireless
> > interface with:
>
> This greatly depends on your use case.  If you are integrating iwd with a=
nother
> network manager that doesn't support iwd's NetworkConfigurationAgent APIs
> (ConnMan, systemd-networkd), then using EnableNetworkConfiguration=3Dtrue=
 is not
> what you want.  Recent versions of NetworkManager do support this feature=
 and
> are thus able to let iwd figure out the network configuration details and=
 apply
> the settings to the system.
>
> >
> > [General]
> > EnableNetworkConfiguration=3Dtrue
> >
> > I am asking as I am using iwd in conjunction with systemd-networkd,
> > and was caught by surprise that disconnecting from my ap in iwd:
> >
> > iwctl station wlan0 disconnect
> >
> > does not result in the associated networkd instance from being degraded=
:
> >
>
> That may be a question for systemd-networkd folks.  'station disconnect' =
should
> result in iwd bringing the interface down.  I don't see why it would cont=
inue
> having addresses assigned.
>
> >                     Link File: n/a
> >                  Network File: /etc/systemd/network/wireless.network
> >                         State: routable (configured)
> >                  Online state: online
> >                          Type: wlan
> >                          MTU: 1500 (min: 68, max: 1500)
> >                         QDisc: pfifo_fast
> > IPv6 Address Generation Mode: eui64
> >            Wi-Fi access point: (null) (00:00:00:00:00:00)
> >      Number of Queues (Tx/Rx): 1/1
> >                       Address: 192.168.50.153 (DHCPv4 via 192.168.50.1)
> >                                fe80::ea4f:25ff:fe44:f60b
> >                       Gateway: 192.168.50.1
> >                           DNS: 192.168.50.240
> >                                1.1.1.1
> >                                192.168.50.1
> >                                2600:1700:7c10:d0ff::1
> >                           NTP: 192.168.50.1
> >
> > It is interesting to me that networkd has enough insight to know the
> > ap's name, but still does not change the state off of: routable
> > (configured) or adjust the online state.
> >
>
> Perhaps it has to do with some roaming hacks that systemd-networkd introd=
uced
> recently?

I have 2 discrete products running the same yocto stack. One runs 6.13
and appears to work:

=E2=97=8F 3: wlan0
                   Link File: n/a
                Network File: /etc/systemd/network/wireless.network
                       State: no-carrier (configured)
                Online state: offline
                        Type: wlan
                        Path: platform-2198000.mmc-platform-wl18xx.0.auto
                      Driver: wl18xx_driver
            Hardware Address: f0:45:da:25:20:ed (Texas Instruments)
                         MTU: 1500 (min: 256, max: 2304)
                       QDisc: noqueue
IPv6 Address Generation Mode: eui64
          Wi-Fi access point: (null) (00:00:00:00:00:00)
    Number of Queues (Tx/Rx): 1/1
                     Address: fe80::f245:daff:fe25:20ed
           Activation Policy: up
         Required For Online: yes
          DHCPv6 Client IAID: 0xac2b916a
          DHCPv6 Client DUID: DUID-EN/Vendor:0000ab11e9977b7ff6c76c1e

the other device runs on 5.10.35, and provides the originally shared
line on disconnect:

=E2=97=8F 3: wlan0
                   Link File: n/a
                Network File: /etc/systemd/network/wireless.network
                       State: routable (configured)
                Online state: online
                        Type: wlan
                        Path: platform-30b40000.mmc
                      Driver: brcmfmac
            Hardware Address: e8:4f:25:44:f6:0b (Murata Manufacturing Co., =
Ltd.)
                         MTU: 1500 (min: 68, max: 1500)
                       QDisc: pfifo_fast
IPv6 Address Generation Mode: eui64
          Wi-Fi access point: (null) (00:00:00:00:00:00)
    Number of Queues (Tx/Rx): 1/1
                     Address: 192.168.50.153 (DHCPv4 via 192.168.50.1)
                              2600:1700:7c10:d0ff:ea4f:25ff:fe44:f60b
                              fe80::ea4f:25ff:fe44:f60b
                     Gateway: 192.168.50.1
                              fe80::7e10:c9ff:fee5:7cc8
                         DNS: 192.168.50.240
                              1.1.1.1
                              192.168.50.1

So this does appear to be a function of kernel version. I will
continue to spelunk and follow up here if I gain any insight.

Yours sincerely,
Donald
