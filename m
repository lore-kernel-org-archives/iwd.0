Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485713C677
	for <iwd@lists.linux.dev>; Thu,  2 May 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657634; cv=none; b=O+FqQaLHVavSNr1880Zr6W5VENVtBXTnLu2iQ7NXmSQLhovmOQhPFdSnF76G44qWPkNc9WLS2tKbtg6F/YrQDv9dg3fGxucaXWg0qrU03poS0klNF2rnvuBr9QifrFSZUxkfbtkZY+IpRo4RyPwUOQrimOpT74LEsfAGSaejVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657634; c=relaxed/simple;
	bh=gerc251wcRGij0xoOa7sMLamFAe20mQMTj22rhOE9QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3jP6AcZfMkDnQ7dPqV4lFj5yxjBySDIZf5VRknZJTX+HLZmYo6bpxf3okJ1Ad2gFXdD68beQ5prFmEDMWn8VeHCN+1WA7fxeeb4MgfT877SnlsDm67lkrEd2TvheUCyremj85bzxcIoctSvRcGRDPJtVv13EzThPrs7d46IMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5TfhflE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5TfhflE"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed5109d924so6768753b3a.0
        for <iwd@lists.linux.dev>; Thu, 02 May 2024 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714657632; x=1715262432; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUrDujVN36uS1irICAz2Gogkj0QtEZuSEMIaWSqPEBI=;
        b=j5TfhflErqsetSXuWFlMTlzPAMHc0V5Rt1JIXaMuTmFRlswm9gXk/ukFZZXLybvapK
         DGDiK+emQ+zmNTOOuH4weDBKhvKwrRg8wWE232jL9/THQVt5FtmqX/QyLAzosWWM2JX4
         7Dt3Csd2F+df/MtbAdL/YX984/cfH47Ujg5Uw6CjFujEVFWtGGDul9/b32wlFvpbWG/g
         4cnOfK9G1O+xRM16T6HRpjoAONiLV9AlZ2v8K7xQgLUllXFZLYXkoyIUvuLPIWLhwIfx
         dIi5F7kuVhx538TKeL+p+85a0MplhicZFncv2lg1wPGqxK/647FfWyeqJL06l1mRzGAj
         ET/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657632; x=1715262432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUrDujVN36uS1irICAz2Gogkj0QtEZuSEMIaWSqPEBI=;
        b=UzCM4COZ6F1/HO7r+bqbTVIGs//Zc31XcGXcDjT7XEiGJmO9hSA1NC3PqpTNvIZdvp
         /+7pciaTj4csq2zgq0ZWlQIZO9dJrc5mwbjCRg1YGSULMlbrOdUbrQbXkxU9aoNDesJX
         ImK3amfZsbSaSaLpdioCzUVUiyhZelz354J6mIb1FSd7xxXy+ZqNHA7tGi0D9NjPSx+v
         7dWPgfLCkwt6RUtuxgXGZ/xPKo4BeMjmUmqydmOZyGGwVN0z1Yh5aLw39RFpVYf9Ihnp
         WI3PW0JQykpgP1TYpiiGSuXH2EJ28sZ7144wo+nEHzzCpwDFRlfYJkWktuZHNGS5ZuEK
         2yrA==
X-Forwarded-Encrypted: i=1; AJvYcCVd9zrhtmezsJJIGqA8c1XLWkM1TG2JPZg83y+/gL60eW5Zwu2dB/LoJMzjW8Ceob3sR4rSlV6QAPuGTFdsHQyCCRBv
X-Gm-Message-State: AOJu0Yy1MuCT82XqKazXlJJIkGFXzAhUzh4I2tb5JEMQSRRi272tboD1
	cBCjJnhbuzESkuLpoc04UYwIXNRqVZO1eFEDxwdcuZKtB7AUFb4jtpGaRE58ZLGb+qbsyjqwQZv
	/B5dVqw4qhOdP7kn4mPKJHKJjyPv9HZ3l
X-Google-Smtp-Source: AGHT+IF0tX9ByAeiY8HMOi9hB8znmSgETECGGkbyzhtwHPTyZK1V/uSUJPEncZI0woGqOQHBApfutGlUtykn7ZBzK2s=
X-Received: by 2002:a17:90a:fe0c:b0:2b3:9ce8:1239 with SMTP id
 ck12-20020a17090afe0c00b002b39ce81239mr2242768pjb.6.1714657632269; Thu, 02
 May 2024 06:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
 <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com> <38861D9C-F5F5-4149-99CD-0C59480986ED@holtmann.org>
 <25618c14-df5a-4980-9e62-dd5c96084455@gmail.com> <CAG17S_MTbFpQB-LDu6s87D1stbojwpto3y+V1X4kSPe3Gkixug@mail.gmail.com>
 <CAG17S_PnK8PebjYZT5s0qyPMn7HhL=D+mC4VaG4i2ZAydeOjSA@mail.gmail.com> <997f2369-3805-4141-ba39-72d5f6ac6931@gmail.com>
In-Reply-To: <997f2369-3805-4141-ba39-72d5f6ac6931@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 2 May 2024 08:47:00 -0500
Message-ID: <CAG17S_MR1ZKkX7nUmb-0K0WAKDSpV8=xSR8ky-wD4uvmwiGiUw@mail.gmail.com>
Subject: Re: Raspberry Pi 5 and WPA3
To: James Prestwood <prestwoj@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Harry ten Berge <htenberge@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

James,

I tried to connect via my Samsung S23 phone and my desktop with an
intel card. The desktop uses iwd 2.17 and when I tried to connect via
iwctl, it did the same thing as the RPi. I suspect my hostapd config,
but do not know. I can try collecting some logs next week on the
desktop and the Pi. Which log do you need? '-d something' or an iwmon
log?

Keith

On Thu, May 2, 2024 at 8:09=E2=80=AFAM James Prestwood <prestwoj@gmail.com>=
 wrote:
>
> Hi Keith,
>
> On 5/2/24 5:56 AM, KeithG wrote:
> > On Tue, Apr 30, 2024 at 7:19=E2=80=AFAM KeithG <ys3al35l@gmail.com> wro=
te:
> >> On Tue, Apr 30, 2024 at 6:24=E2=80=AFAM James Prestwood <prestwoj@gmai=
l.com> wrote:
> >>> Hi Marcel,
> >>>
> >>> On 4/30/24 12:42 AM, Marcel Holtmann wrote:
> >>>> Hi James,
> >>>>
> >>>>>> I'm not sure this is the right place to ask for some assistance, b=
ut
> >>>>>> here we go...
> >>>>>>
> >>>>>> I'm the author for a small Raspberry Pi audio image that is
> >>>>>> specifically targeting Roon.
> >>>>>> If you're not familiair with Roon: it's an audio streaming platfor=
m
> >>>>>> targeting audiophiles ;-)
> >>>>>>
> >>>>>> Anyways, about a year ago I switched from wpa_supplicant to iwd, t=
o
> >>>>>> full satisfaction.
> >>>>>> Better and easier integration, and overall a feel of me being in m=
ore control.
> >>>>>>
> >>>>>> Now, recently I'm having issues with WPA3 support. This is partly
> >>>>>> related to firmware (it's just so obfuscated how this all works wi=
th
> >>>>>> firmware from broadcom and firmware from cypress :-(
> >>>>>>
> >>>>>> And one of those things is that I can't get it to work on the new =
Pi
> >>>>>> 5. Specifically IWD reporting this:
> >>>>>>
> >>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> >>>>>> Network is WPA3-Personal...
> >>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
> >>>>>> CMD_EXTERNAL_AUTH for SAE
> >>>>>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> >>>>>> Can't use SAE, trying WPA2
> >>>>>>
> >>>>>> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message=
 and
> >>>>>> advise me to go back to wpa_supplicant. Which is not something I w=
ould
> >>>>>> like to do for various reasons...
> >>>>>>
> >>>>>> Do you have any advice for me on what I can do? is this
> >>>>>> CMD_EXTERNAL_AUTH really related to  this and are you planning on
> >>>>>> implementing this?
> >>>>> Unfortunately the external auth support is not yet implemented in I=
WD. The brcmfmac driver itself is rather unique being a fullmac driver. Dep=
ending on how you look at it, this on its own is "easier" to support. It ha=
ndles connecting/roaming all on its own. But then, for some reason, someone=
 didn't want to do SAE/WPA3 on the card itself so they came up with some on=
e-off mechanism to offload that onto userspace. This is one of those things=
 that got put upstream that is a pain for projects like IWD to support IMO.=
 Its something we do need to support eventually, especially given the raspi=
 5 requires it.
> >>>> if the Broadcom firmware finally would be able to support external_a=
uth,
> >>>> then it would be nice, but as seen on recent linux-wireless discussi=
ons,
> >>>> it is unclear who does what. Broadcom wanted to support external_aut=
h,
> >>>> but then Infineon (the new owner) might be rather using SAE as part =
of
> >>>> the firmware. And actually the chip on the RPi5 marks itself as Cypr=
ess
> >>>> and so you it is an unclear story. I think that Raspberry Pi foundat=
ion
> >>>> should get their story straight. Until really recently they shipped =
a
> >>>> firmware that couldn=E2=80=99t do SAE and also their drivers couldn=
=E2=80=99t even do
> >>>> external_auth and you were stuck with WPA2 only.
> >>>>
> >>>> https://holtmann.dev/enabling-wpa3-on-raspberry-pi/
> >>> I was not aware that it didn't even support it correctly. I figured
> >>> broadcom was who added it in the first place.
> >>>> You can use an upstream firmware from linux-firmware and make the RP=
i5
> >>>> support WPA3. And as of a few weeks ago, even RPi5 latest Debian was
> >>>> switching to the upstream firmware.
> >>>>
> >>>> On side note, there exists no wpa_supplicant release that really sup=
ports
> >>>> SAE offload properly. You need to back port a lot of patches or hope
> >>>> that your distro back ported them for you.
> >>>>
> >>>> We should actually check if nl80211 tells us that external_auth is
> >>>> supported by the driver. And if not (which is the case for the Broad=
com
> >>>> upstream driver) send a proper message to users and not lead them in=
to
> >>>> a wild goose chase.
> >>>>
> >>>> Regards
> >>>>
> >>>> Marcel
> >>>>
> >> FWIW, the most recent update to the RPI Bookworm image has enabled
> >> this capability:
> >> # uname -a
> >> Linux pi5 6.6.28+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.28-1+rpt1
> >> (2024-04-22) aarch64 GNU/Linux
> >>
> >> # dmesg | grep brcmfmac
> >> [    2.195263] brcmfmac: F1 signature read @0x18000000=3D0x15264345
> >> [    2.209946] brcmfmac: brcmf_fw_alloc_request: using
> >> brcm/brcmfmac43455-sdio for chip BCM4345/6
> >> [    2.216566] usbcore: registered new interface driver brcmfmac
> >> [    2.384898] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> >> available (err=3D-2)
> >> [    2.385212] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> >> wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
> >> 01-996384e2
> >>
> >> # iw list
> >> Wiphy phy0
> >> ...
> >>      Supported extended features:
> >>          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
> >>          * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in sta=
tion mode
> >>          * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in s=
tation mode
> >>          * [ DFS_OFFLOAD ]: DFS offload
> >>          * [ SAE_OFFLOAD ]: SAE offload support
> >>          * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
> >>          * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload supp=
ort
> >>
> >> This was achieved here with a normal 'apt update ; apt upgrade' routin=
e.
> >>
> >> This appears to work for all Pis, now. Even a 32 bit image on a 3b+
> >> with similar hardware:
> >> # uname -a
> >> Linux rpi32 6.6.28+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.28-1+rpt1
> >> (2024-04-22) armv7l GNU/Linux
> >> # iw list
> >> ...
> >>      Supported extended features:
> >>          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
> >>          * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in sta=
tion mode
> >>          * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in s=
tation mode
> >>          * [ DFS_OFFLOAD ]: DFS offload
> >>          * [ SAE_OFFLOAD ]: SAE offload support
> >>          * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
> >>          * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload supp=
ort
> >>
> >> The PiZero2W does not show this capability with the same 64 bit image
> >> running as it has different hardware with different firmware:
> >> # dmesg | grep brcmfmac
> >> [    6.051393] brcmfmac: F1 signature read @0x18000000=3D0x1542a9a6
> >> [    6.077172] brcmfmac: brcmf_fw_alloc_request: using
> >> brcm/brcmfmac43430b0-sdio for chip BCM43430/2
> >> [    6.080782] usbcore: registered new interface driver brcmfmac
> >> [    6.476401] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> >> available (err=3D-2)
> >> [    6.481953] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
> >> wl0: Mar 31 2022 17:24:51 version 9.88.4.77 (g58bc5cc) FWID
> >> 01-3b307371
> >>
> >> Keith
> > I got around to testing this a bit tonight. I set up my Pi5 with
> > hostapd and used this /etc/hostapd/hostapd.conf
> >
> > # cat /etc/hostapd/hostapd.conf
> > # interface and driver
> > interface=3Dap0
> > driver=3Dnl80211
> >
> > # WIFI-Config
> > ssid=3DSSIDWPA3
> > channel=3D7
> > hw_mode=3Dg
> > ieee80211n=3D1
> > wmm_enabled=3D1
> > macaddr_acl=3D0
> > auth_algs=3D1
> > max_num_sta=3D10
> >
> > wpa=3D2
> > wpa_key_mgmt=3DSAE
> > rsn_pairwise=3DCCMP
> > ieee80211w=3D2
> > wpa_passphrase=3Dpassword
> > sae_pwe=3D2
> >
> > Form the log, it looks like SAE is enabled and ruinning, but I do not
> > know what I am looking at.
> > Using interface ap0 with hwaddr d8:3a:dd:27:6f:a7 and ssid "SSIDWPA3"
> > ...
> > SAE: Derive PT - group 19
> > SAE: SSID - hexdump_ascii(len=3D8):
> >       53 53 49 44 57 50 41 33                           SSIDWPA3
> > SAE: password - hexdump_ascii(len=3D9): [REMOVED]
> > SAE: pwd-seed - hexdump(len=3D32): [REMOVED]
> > SAE: pwd-value (u1 P1) - hexdump(len=3D48): [REMOVED]
> > SAE: u1 - hexdump(len=3D32): [REMOVED]
> > ...
> >
> > I can 'see' it from my other pi running iwd and on my laptop, but I
> > cannot connect on either. I get nothing in the log. When I type in the
> > password, I get:
> >
> > [iwd]# station wlan0 connect SSIDWPA3
> > Type the network passphrase for SSIDWPA3 psk.
> > Passphrase: *********
> > Operation failed
>
> We'll need to see some IWD logs to see whats going on. Also, can you
> connect from your phone or some other device?
>
> >
> > Both Pis show that they have what Marcel noted:
> >
> >      Supported extended features:
> >          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
> >          * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in stat=
ion mode
> >          * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in st=
ation mode
> >          * [ DFS_OFFLOAD ]: DFS offload
> >          * [ SAE_OFFLOAD ]: SAE offload support
> >          * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
> >          * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload suppo=
rt
> >
> > Is my config wrong?
> >
> > The version of iwd I am running is 2.17 built from git with the latest
> > commit as of e3f6a2c. The version if hostapd is:
> > # hostapd -v
> > hostapd v2.10
> > User space daemon for IEEE 802.11 AP management,
> > IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
