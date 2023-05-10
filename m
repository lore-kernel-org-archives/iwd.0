Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA463E
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 04:52:35 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-52c6504974dso6127731a12.2
        for <iwd@lists.linux.dev>; Tue, 09 May 2023 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683694355; x=1686286355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7bpyTM3yaUO7t/n7yVaG1xNP8QVsaR+3PLSrSa0pO0=;
        b=qFukcJ9vhR3z4rnSpOPT/kcZ8r6YjPBZKI6t2IP4bdVWlzS7iRRcZXB74JfAZXlMKj
         VZSC38TFg3i06/P11eBgObBq5iLLBf8hWXP26PSpub+L54+ndw13llKVuzjGCb4SnVTh
         bAK6xgBnAlsx45KFthIJeMDj1zugt8mdx/JakDQsCcBoHPdyLZOGHds+mbPUAhMirKsM
         i+FqVXitv8XRUSMrug1HDAojQTGMpDw/GGJhY4e0Hv6q/07tJn8TkRaqsIr3OoC+aM6P
         qyViHvJWyYo11v/QQZ+E/8A7XqGfCirexGPI+b+2aQwcZhdnr/Tud4Bj+J/nXRBdtjlE
         E5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694355; x=1686286355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7bpyTM3yaUO7t/n7yVaG1xNP8QVsaR+3PLSrSa0pO0=;
        b=jmnd++YDXX2LFjHUGlpPDN5RrIYfUO4PmKhuTHiUQLt5mNQdiatsDGAkc/hMKoRCt3
         lr/rmrGdF9eZ1CW3rlBI6pyZ0UwUdsRwp/IH7XJeYv2fDsvJepwCDARxwRnJKaWQ6uUz
         I0vKOZP2kGYOcMgUqr3j8BRA6uNu7HKiAPjxDAA10qsNtiy4hd99phA4Ng7xa6q72w5w
         0BK7NHJ905jxg0D2a7lpIoqsb34/UeEz9dcJMlKONfP6WHlUxayhy0zy0aGaIR6eTuCZ
         kVlRWGmNWxrUYsLEbf/24ZGxuQQBw6MqtMa32CRpdiUgcdBqkpsuhrbA4+hyYMRtLkHg
         srNg==
X-Gm-Message-State: AC+VfDwtySk5SNDIBNRavuYtHGFi8NBmqpOLpA2E0DFYDJjlnlKD0nC4
	LheK+uLI9aFCj0xzzrOvnJ2CeuOg3AcL7UdxR8nWh57u13xkeQ==
X-Google-Smtp-Source: ACHHUZ6FMqFr0P2JiUvODIV6mYnutrNjhG8L/tE3+BXPgdJHvrkvDwVMVC0ZGYfG6kLP4NurTKt/eepwX0soTrXonuU=
X-Received: by 2002:a17:902:a604:b0:1ac:b363:83b3 with SMTP id
 u4-20020a170902a60400b001acb36383b3mr1005376plq.41.1683694355241; Tue, 09 May
 2023 21:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_OaL_VK9e-s=DbwwKOAdjX9jR_B9ogifs9Di1-VW=ksmQ@mail.gmail.com>
 <152dff569b6fba0baadd7ac14673cf2a67c42eb4.camel@gmail.com>
In-Reply-To: <152dff569b6fba0baadd7ac14673cf2a67c42eb4.camel@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 9 May 2023 23:52:24 -0500
Message-ID: <CAG17S_OvMmYKJP==2bn-XoCtkUDC7b+sMRk+woeSN9Q_GR9PTw@mail.gmail.com>
Subject: Re: iwd ap mode changed?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 2, 2023 at 10:15=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Keith,
>
> On Tue, 2023-02-28 at 21:26 -0600, KeithG wrote:
> > I am playing with ap mode and I previously used this page to set it
> > up:
> > https://iwd.wiki.kernel.org/ap_mode
> > Now, when I use iwd 2.3, I get
> > "Operation failed"
> > when I use the iwctl ap start or start-profile command.
> > when I revert to version 1.28, it starts to work again.  Is there a
> > changed parameter in the main.conf or something that I do not have
> > set
> > right?
>
> Indeed AP mode has changed in recent releases to support HT. The logic
> now tries to pick the highest channel width possible, and in theory
> enable higher throughput.
>
> But perhaps some hardware doesn't like this, or the logic is wrong. For
> the time being you can set this in the AP profile (with upstream IWD).
>
> [General]
> DisableHT=3Dtrue
>
> But if you could also send an iwmon/debug log of the problem I can take
> a look. Make sure you start iwmon before IWD starts so I can see the
> advertised hardware capabilities.
>
> Thanks,
> James
>
> >
> > Keith
> >
>
James,

I am finally back on this. I have switched OSes. I was on Arch and am
now on RPiOS.
I built and installed iwd/ell for this os but on the same hardware
(Rpi 3B+) and am having the same problem:
root@runeaudio(rw):~# cat /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=3Dtrue
UseDefaultInterface=3Dtrue
DisableHT=3Dtrue
root@runeaudio(rw):~# cat /var/lib/iwd/ap/RuneAudioAP.ap
[Security]
Passphrase=3DRuneAudio
[IPv4]
Address=3D192.168.5.1
Gateway=3D192.168.5.1
Netmask=3D255.255.255.0
DNSList=3D192.168.5.1
root@runeaudio(rw):~# iwctl device list
                                    Devices
---------------------------------------------------------------------------=
-----
  Name                  Address               Powered     Adapter     Mode
---------------------------------------------------------------------------=
-----
  wlan0                 b8:27:eb:xx:xx:xx    on          phy0        ap
root@runeaudio(rw):~# iwctl ap wlan0 start-profile RuneAudioAP
Operation failed
When I try to start iwmon, I also get an error:
root@runeaudio(rw):~# iwmon
Wireless monitor ver 2.4
Failed to create monitor interface nlmon: Unknown error -95

In the journal, I get this when I try to start in AP mode:
May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
type 0000: -114
May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
type 0020: -114
May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
type 0040: -114
May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
type 00a0: -114
May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
type 00b0: -114
May 09 23:47:03 runeaudio iwd[1747]: Could not register frame watch
type 00c0: -114
May 09 23:47:03 runeaudio iwd[1747]: START_AP failed: -52

when IWD starts, I get this in the journal:
May 09 23:37:17 runeaudio iwd[1747]: No Diffie-Hellman support found,
WPS will not be available
May 09 23:37:17 runeaudio iwd[1747]: The following options are missing
in the kernel:
May 09 23:37:17 runeaudio iwd[1747]:         CONFIG_KEY_DH_OPERATIONS
May 09 23:37:17 runeaudio iwd[1747]: Wireless daemon version 2.4
May 09 23:37:17 runeaudio iwd[1747]: Loaded configuration from
/etc/iwd/main.conf
May 09 23:37:17 runeaudio iwd[1747]: Wiphy: 0, Name: phy0
May 09 23:37:17 runeaudio iwd[1747]:         Permanent Address:
b8:27:eb:52:cc:d0
May 09 23:37:17 runeaudio iwd[1747]:         2.4Ghz Band:
May 09 23:37:17 runeaudio iwd[1747]:                 Bitrates (non-HT):
May 09 23:37:17 runeaudio iwd[1747]:                          1.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                          2.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                          5.5 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         11.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                          6.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                          9.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         12.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         18.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         24.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         36.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         48.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         54.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                 HT Capabilities:
May 09 23:37:17 runeaudio iwd[1747]:                         HT40
May 09 23:37:17 runeaudio iwd[1747]:                         Short GI for 2=
0Mhz
May 09 23:37:17 runeaudio iwd[1747]:                 HT RX MCS indexes:
May 09 23:37:17 runeaudio iwd[1747]:                         0-7
May 09 23:37:17 runeaudio iwd[1747]:         5Ghz Band:
May 09 23:37:17 runeaudio iwd[1747]:                 Bitrates (non-HT):
May 09 23:37:17 runeaudio iwd[1747]:                          6.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                          9.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         12.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         18.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         24.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         36.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         48.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                         54.0 Mbps
May 09 23:37:17 runeaudio iwd[1747]:                 HT Capabilities:
May 09 23:37:17 runeaudio iwd[1747]:                         HT40
May 09 23:37:17 runeaudio iwd[1747]:                         Short GI for 2=
0Mhz
May 09 23:37:17 runeaudio iwd[1747]:                         Short GI for 4=
0Mhz
May 09 23:37:17 runeaudio iwd[1747]:                 HT RX MCS indexes:
May 09 23:37:17 runeaudio iwd[1747]:                         0-7
May 09 23:37:17 runeaudio iwd[1747]:                 VHT Capabilities:
May 09 23:37:17 runeaudio iwd[1747]:                         Short GI for 8=
0Mhz
May 09 23:37:17 runeaudio iwd[1747]:                         Max RX
MCS: 0-9 for NSS: 1
May 09 23:37:17 runeaudio iwd[1747]:                         Max TX
MCS: 0-9 for NSS: 1
May 09 23:37:17 runeaudio iwd[1747]:         Ciphers: BIP-CMAC-128 CCMP-128=
 TKIP
May 09 23:37:17 runeaudio iwd[1747]:         Supported iftypes: ad-hoc
station ap p2p-client p2p-go p2p-device
May 09 23:37:17 runeaudio iwd[1747]: Wiphy phy0 will only use the
default interface
May 09 23:37:17 runeaudio iwd[1747]: Could not register frame watch
type 00b0: -22


Keith
