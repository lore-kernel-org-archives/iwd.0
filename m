Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78220152781
	for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491787; cv=none; b=UtxRs5t+c1m8njQOPTnqza5ouHOCSkCeZ2TeaDvWKTXjV3AzTxhG1Uk4LaSy/tjFoFCfcx8az3MPfWe+VLZ21Lr2NLNhfF5l3qgW0QrXSrSrYN1u5D71e1DPS4W9iWG0RUaBXmB7j+dkFGS6WdVjXAtITPzm+cFcxK4x0Hm+SOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491787; c=relaxed/simple;
	bh=4azIvczt8ejkx1LTXsj2eRsRB6zBfO0WwtIlcb13kuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XR90z8yT4K6Y0/vqwiqKXIg2nEJzwjzCbg33It53T4ndshWbMcPAYXsvdjyRK7SVqBRu0PUP8eiMtBVYMpwhRAOIwHmuQLUZb8EOlemGb+rV6iWDPsgiZzvDv//ff2BVBUygMh9kf8Syd1Kw44XOpQYvTezdALrNnGeNdMm9gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfF926I9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfF926I9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so32038755e9.1
        for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714491784; x=1715096584; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4Y99PrQfk85Hd6bu3t8b0Ittypu7l7eNApqgQd7zns=;
        b=IfF926I9tw8P+gZyWh/z3KdgWHOz5fYfVfVe22mP/svj1CbWMBfJFQ3HMF/saLQqZn
         xNf+jK8AAYdvdS7enacGvdWRHG6xZ0XktCPnUlng1jpTOXJBSrx1wbeXx/h0eNJx1lkP
         agl9IB9ykNuq4CrynqlsfNVNwWHVFiyCJnvaiK913UCaKIoj7FZ66MfoJpqLBWDUiD5k
         ZMNUpJNnEzMP9GOWBfE1qzze6LFGgqedPKYhvTdYwgS7bCDTJQXTU9ia31CuSTxDbugp
         QV8quYW1IAO7j2X2qQeLbymcWRYOG0hEr0AoZd6xek9lNtf/ppS6zW1j7Ml+SMVdWUfK
         B1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714491784; x=1715096584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4Y99PrQfk85Hd6bu3t8b0Ittypu7l7eNApqgQd7zns=;
        b=D5C67d3TkGusWiEhwlcbrcO1fu3nYb+RhGT4CDVpazaBMGaTY2h4Utkf9UHC4yVsGh
         v8s7vQ/Cn4uGSjeYGNpo+1NyA9wNiexvXdNZsnyzG3J22wBKeOUydQ+2yVk7mc6QoVGV
         LLEYiiBfNYX+pY7VulAM4kgoPlcxbxnqS2hmcdCC3Ap7DTCW1G9NLuBIZ6HbUKIHaawn
         KNX3M6ji7I1+f72qyfuO+pzl3H46s1Kf0de81REaFLu1bTJ8MlhVdHel1VnkBE6F2X9T
         MfkthKT+qdGjcUEX3BDYDTivkqzIlCbUzKGZ3N6CMLfJLorAM1U5QZancTolKbtZ58NO
         huVg==
X-Forwarded-Encrypted: i=1; AJvYcCVfLWflBXpUVBe+0XmCyzndQgn82nr3Qttaozyli+Yu8tVLRnezw3X+RvkEWY16ybodNJXoL46ByjmZqKxt4FCjgmzG
X-Gm-Message-State: AOJu0Yzn/iHOs9qbKLeESCaRbN6RsV6HgH2gH8o5iuDnYMNoDMyxGkUp
	eO2S8FUOMvtzdcV4eIcARipic8IVHpf7qHg91XK0RDDureOGhWaFcNfVxAhiqomqlrP23nrC/yC
	TH4liw8ogWMgE3/xcOojf0+gWZo5EnfpvYCs=
X-Google-Smtp-Source: AGHT+IGTKY/8efrcNUO3V68hC6bysyGvlJO2R2GemnDNJ0oHVDe9iUr/O6iJybU49hqxl0Ak8PlwJtY4dQxvRNXTMbQ=
X-Received: by 2002:a05:600c:4f01:b0:414:273:67d4 with SMTP id
 l1-20020a05600c4f0100b00414027367d4mr2515718wmq.30.1714491783471; Tue, 30 Apr
 2024 08:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
 <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com> <38861D9C-F5F5-4149-99CD-0C59480986ED@holtmann.org>
 <25618c14-df5a-4980-9e62-dd5c96084455@gmail.com> <CAG17S_MTbFpQB-LDu6s87D1stbojwpto3y+V1X4kSPe3Gkixug@mail.gmail.com>
In-Reply-To: <CAG17S_MTbFpQB-LDu6s87D1stbojwpto3y+V1X4kSPe3Gkixug@mail.gmail.com>
From: Harry ten Berge <htenberge@gmail.com>
Date: Tue, 30 Apr 2024 17:42:52 +0200
Message-ID: <CAN+yObpoD=4bTK3b-hUVR1hXZQe3+giqtCi8wbKNnTb1nPa5pg@mail.gmail.com>
Subject: Re: Raspberry Pi 5 and WPA3
To: KeithG <ys3al35l@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 at 14:20, KeithG <ys3al35l@gmail.com> wrote:
>
> On Tue, Apr 30, 2024 at 6:24=E2=80=AFAM James Prestwood <prestwoj@gmail.c=
om> wrote:
> >
> > Hi Marcel,
> >
> > On 4/30/24 12:42 AM, Marcel Holtmann wrote:
> > > Hi James,
> > >
> > >>> I'm not sure this is the right place to ask for some assistance, bu=
t
> > >>> here we go...
> > >>>
> > >>> I'm the author for a small Raspberry Pi audio image that is
> > >>> specifically targeting Roon.
> > >>> If you're not familiair with Roon: it's an audio streaming platform
> > >>> targeting audiophiles ;-)
> > >>>
> > >>> Anyways, about a year ago I switched from wpa_supplicant to iwd, to
> > >>> full satisfaction.
> > >>> Better and easier integration, and overall a feel of me being in mo=
re control.
> > >>>
> > >>> Now, recently I'm having issues with WPA3 support. This is partly
> > >>> related to firmware (it's just so obfuscated how this all works wit=
h
> > >>> firmware from broadcom and firmware from cypress :-(
> > >>>
> > >>> And one of those things is that I can't get it to work on the new P=
i
> > >>> 5. Specifically IWD reporting this:
> > >>>
> > >>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> > >>> Network is WPA3-Personal...
> > >>> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
> > >>> CMD_EXTERNAL_AUTH for SAE
> > >>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> > >>> Can't use SAE, trying WPA2
> > >>>
> > >>> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message =
and
> > >>> advise me to go back to wpa_supplicant. Which is not something I wo=
uld
> > >>> like to do for various reasons...
> > >>>
> > >>> Do you have any advice for me on what I can do? is this
> > >>> CMD_EXTERNAL_AUTH really related to  this and are you planning on
> > >>> implementing this?
> > >> Unfortunately the external auth support is not yet implemented in IW=
D. The brcmfmac driver itself is rather unique being a fullmac driver. Depe=
nding on how you look at it, this on its own is "easier" to support. It han=
dles connecting/roaming all on its own. But then, for some reason, someone =
didn't want to do SAE/WPA3 on the card itself so they came up with some one=
-off mechanism to offload that onto userspace. This is one of those things =
that got put upstream that is a pain for projects like IWD to support IMO. =
Its something we do need to support eventually, especially given the raspi =
5 requires it.
> > > if the Broadcom firmware finally would be able to support external_au=
th,
> > > then it would be nice, but as seen on recent linux-wireless discussio=
ns,
> > > it is unclear who does what. Broadcom wanted to support external_auth=
,
> > > but then Infineon (the new owner) might be rather using SAE as part o=
f
> > > the firmware. And actually the chip on the RPi5 marks itself as Cypre=
ss
> > > and so you it is an unclear story. I think that Raspberry Pi foundati=
on
> > > should get their story straight. Until really recently they shipped a
> > > firmware that couldn=E2=80=99t do SAE and also their drivers couldn=
=E2=80=99t even do
> > > external_auth and you were stuck with WPA2 only.
> > >
> > > https://holtmann.dev/enabling-wpa3-on-raspberry-pi/
> > I was not aware that it didn't even support it correctly. I figured
> > broadcom was who added it in the first place.
> > >
> > > You can use an upstream firmware from linux-firmware and make the RPi=
5
> > > support WPA3. And as of a few weeks ago, even RPi5 latest Debian was
> > > switching to the upstream firmware.
> > >
> > > On side note, there exists no wpa_supplicant release that really supp=
orts
> > > SAE offload properly. You need to back port a lot of patches or hope
> > > that your distro back ported them for you.
> > >
> > > We should actually check if nl80211 tells us that external_auth is
> > > supported by the driver. And if not (which is the case for the Broadc=
om
> > > upstream driver) send a proper message to users and not lead them int=
o
> > > a wild goose chase.
> > >
> > > Regards
> > >
> > > Marcel
> > >
> >
>
> FWIW, the most recent update to the RPI Bookworm image has enabled
> this capability:
> # uname -a
> Linux pi5 6.6.28+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.28-1+rpt1
> (2024-04-22) aarch64 GNU/Linux
>
> # dmesg | grep brcmfmac
> [    2.195263] brcmfmac: F1 signature read @0x18000000=3D0x15264345
> [    2.209946] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    2.216566] usbcore: registered new interface driver brcmfmac
> [    2.384898] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> available (err=3D-2)
> [    2.385212] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
> 01-996384e2
>
> # iw list
> Wiphy phy0
> ...
>     Supported extended features:
>         * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>         * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station=
 mode
>         * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in stati=
on mode
>         * [ DFS_OFFLOAD ]: DFS offload
>         * [ SAE_OFFLOAD ]: SAE offload support
>         * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>         * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> This was achieved here with a normal 'apt update ; apt upgrade' routine.
>
> This appears to work for all Pis, now. Even a 32 bit image on a 3b+
> with similar hardware:
> # uname -a
> Linux rpi32 6.6.28+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.28-1+rpt1
> (2024-04-22) armv7l GNU/Linux
> # iw list
> ...
>     Supported extended features:
>         * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>         * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station=
 mode
>         * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in stati=
on mode
>         * [ DFS_OFFLOAD ]: DFS offload
>         * [ SAE_OFFLOAD ]: SAE offload support
>         * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>         * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> The PiZero2W does not show this capability with the same 64 bit image
> running as it has different hardware with different firmware:
> # dmesg | grep brcmfmac
> [    6.051393] brcmfmac: F1 signature read @0x18000000=3D0x1542a9a6
> [    6.077172] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43430b0-sdio for chip BCM43430/2
> [    6.080782] usbcore: registered new interface driver brcmfmac
> [    6.476401] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> available (err=3D-2)
> [    6.481953] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
> wl0: Mar 31 2022 17:24:51 version 9.88.4.77 (g58bc5cc) FWID
> 01-3b307371
>
> Keith

Oeps. My earlier response was to Keith alone.

But basically Keith is doing some testing, because I can get this to
work with IWD, *only* when I'm on 6.1.
Switching to kernel 6.6 breaks it. (see ticket:
https://github.com/raspberrypi/linux/issues/6130)
I get continuous "iwd No suitable BSSes found" messages.

Curious if Keith gets this working on his setup.

Thanks
