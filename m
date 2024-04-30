Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247AF13D892
	for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479603; cv=none; b=uOMrKU53pZtcx/1bxOfFK+kucx7lTbwt4Sa62DEfOAAiUh/PyYcD9jvV11FOX6iADyGr4EVtf2e6lAbNRNxlD+8DjtouTCHtJMIbUWHIXgvFXiut2LNXXVoFV6wizNRN0emiAyHuVRO5b+0IvIqz4SDnBuBjoih2txaoHCHH6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479603; c=relaxed/simple;
	bh=gx2/9r18g2aCAYzut5GXO7+EXgNPMGmgrb4dX+tVYM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUgf78Qt+Rks7LhkXphhNQSczxahbxQYUnPoCVft/Sval4EeEhrS5pOtskZVC1caR3nOXmX1cPHeL7Pr664+O8drrvV7X7CbphS0aBNi0uZVfYKBO7V9dm5og6WC/5NuRNOcZJQrQknuDQaxtatGCQF1WUwS47DYvaksr3kJLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UimxK2tZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UimxK2tZ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-60585faa69fso3659903a12.1
        for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714479601; x=1715084401; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6yDj2cvjq5DFbGbLvBD9SdUNsFBe8ReMW8kHYUvnH0=;
        b=UimxK2tZHKK8D2N5e/7A5QhGwwD0XwWX/eWnHN9TRC5TU1iKNKY/3AmZF2tAr/FutL
         u4Whx6r3xottNiyg3l/4fSv7z3oGOZnHDDdZ06FXFtlqAxAFXheCwRGsxkNpOaGxEpX1
         lIIjKTT2gNMc9FS25dcny3Ow9WfDXaMrvPmD8VN8ewd5QmIS6QzOQaXYK9ysanpyA4yW
         qC4Urwzz+mIdzi+HFvhTA/xAHSbFJ6Y3fmKPY7yM2RfzgTSUVRR+8/QznZ1h6+XYyVqS
         7Zd87+daWUbQawUmPJcP1TMOt4xT//qCAaZFXbZqJE97unrr7YO+7chv9ppEPelabkJ3
         fs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714479601; x=1715084401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6yDj2cvjq5DFbGbLvBD9SdUNsFBe8ReMW8kHYUvnH0=;
        b=Fn4uYgg76Xv88WiwaecrHBHmCQToB2oeiREn58fpvIdpbegbqFmev/CAIPmc4RFLtl
         xgi8eyo0F5YUZFc+Ec5OE9Kl9C1gE0IoI4i8QseJoCcIQx4EtGxZH56TITSbQeDG+l9I
         U61y6na4ZROvCGPKa7Asx3DaMq8Dg3kyBNwJui5rFJQl5mfCXY+h68TJdw6J+eoOagVB
         T1njgGyzFntbrECHc4qqP2NymtCGePVgC5RWMEis/EJHEe2zyuKbRveiaj0nUVB8Fiuh
         mVVUAalRr2ZxFHJlmNKbJJnugCTe3+A0+oa2FvfcZ6NxUYyMdQdM96BzCpGUU+yezw9C
         zpSw==
X-Forwarded-Encrypted: i=1; AJvYcCWLMnA7fYK8lj1igvAMcx5Gb1y7dd6F7rRaYLRqUudgxHEScVZc0YzdZCQZtfTc2nkm89iZDi80ZxKzV+uYqDbSTDcV
X-Gm-Message-State: AOJu0YxhiGSaJsaKSvcTtWEMzsJNpLfiZ/tOePKKnu/LDD4qxn2gS73B
	5YEZm1kkdC1cFkWWiYmVFvPIOMHQC2mjBftmBvhD9w1+tHCktyDeOpV1R+R5hsj8SDTJPKopdxs
	sdr2znBpdtssA3IpLIJ3Y47S02rw=
X-Google-Smtp-Source: AGHT+IFZGCLdPCgfPgBW5AENJgZEYTjrgeF4ymYJenHXtPW6bn4B9meD7kkvLmgjGBPvVGnzRQLQzHWN8iL/UVk0fyA=
X-Received: by 2002:a17:90b:46cf:b0:2b2:826d:a387 with SMTP id
 jx15-20020a17090b46cf00b002b2826da387mr2841010pjb.14.1714479601154; Tue, 30
 Apr 2024 05:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
 <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com> <38861D9C-F5F5-4149-99CD-0C59480986ED@holtmann.org>
 <25618c14-df5a-4980-9e62-dd5c96084455@gmail.com>
In-Reply-To: <25618c14-df5a-4980-9e62-dd5c96084455@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 30 Apr 2024 07:19:49 -0500
Message-ID: <CAG17S_MTbFpQB-LDu6s87D1stbojwpto3y+V1X4kSPe3Gkixug@mail.gmail.com>
Subject: Re: Raspberry Pi 5 and WPA3
To: James Prestwood <prestwoj@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Harry ten Berge <htenberge@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 6:24=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Marcel,
>
> On 4/30/24 12:42 AM, Marcel Holtmann wrote:
> > Hi James,
> >
> >>> I'm not sure this is the right place to ask for some assistance, but
> >>> here we go...
> >>>
> >>> I'm the author for a small Raspberry Pi audio image that is
> >>> specifically targeting Roon.
> >>> If you're not familiair with Roon: it's an audio streaming platform
> >>> targeting audiophiles ;-)
> >>>
> >>> Anyways, about a year ago I switched from wpa_supplicant to iwd, to
> >>> full satisfaction.
> >>> Better and easier integration, and overall a feel of me being in more=
 control.
> >>>
> >>> Now, recently I'm having issues with WPA3 support. This is partly
> >>> related to firmware (it's just so obfuscated how this all works with
> >>> firmware from broadcom and firmware from cypress :-(
> >>>
> >>> And one of those things is that I can't get it to work on the new Pi
> >>> 5. Specifically IWD reporting this:
> >>>
> >>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> >>> Network is WPA3-Personal...
> >>> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
> >>> CMD_EXTERNAL_AUTH for SAE
> >>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> >>> Can't use SAE, trying WPA2
> >>>
> >>> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message an=
d
> >>> advise me to go back to wpa_supplicant. Which is not something I woul=
d
> >>> like to do for various reasons...
> >>>
> >>> Do you have any advice for me on what I can do? is this
> >>> CMD_EXTERNAL_AUTH really related to  this and are you planning on
> >>> implementing this?
> >> Unfortunately the external auth support is not yet implemented in IWD.=
 The brcmfmac driver itself is rather unique being a fullmac driver. Depend=
ing on how you look at it, this on its own is "easier" to support. It handl=
es connecting/roaming all on its own. But then, for some reason, someone di=
dn't want to do SAE/WPA3 on the card itself so they came up with some one-o=
ff mechanism to offload that onto userspace. This is one of those things th=
at got put upstream that is a pain for projects like IWD to support IMO. It=
s something we do need to support eventually, especially given the raspi 5 =
requires it.
> > if the Broadcom firmware finally would be able to support external_auth=
,
> > then it would be nice, but as seen on recent linux-wireless discussions=
,
> > it is unclear who does what. Broadcom wanted to support external_auth,
> > but then Infineon (the new owner) might be rather using SAE as part of
> > the firmware. And actually the chip on the RPi5 marks itself as Cypress
> > and so you it is an unclear story. I think that Raspberry Pi foundation
> > should get their story straight. Until really recently they shipped a
> > firmware that couldn=E2=80=99t do SAE and also their drivers couldn=E2=
=80=99t even do
> > external_auth and you were stuck with WPA2 only.
> >
> > https://holtmann.dev/enabling-wpa3-on-raspberry-pi/
> I was not aware that it didn't even support it correctly. I figured
> broadcom was who added it in the first place.
> >
> > You can use an upstream firmware from linux-firmware and make the RPi5
> > support WPA3. And as of a few weeks ago, even RPi5 latest Debian was
> > switching to the upstream firmware.
> >
> > On side note, there exists no wpa_supplicant release that really suppor=
ts
> > SAE offload properly. You need to back port a lot of patches or hope
> > that your distro back ported them for you.
> >
> > We should actually check if nl80211 tells us that external_auth is
> > supported by the driver. And if not (which is the case for the Broadcom
> > upstream driver) send a proper message to users and not lead them into
> > a wild goose chase.
> >
> > Regards
> >
> > Marcel
> >
>

FWIW, the most recent update to the RPI Bookworm image has enabled
this capability:
# uname -a
Linux pi5 6.6.28+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.28-1+rpt1
(2024-04-22) aarch64 GNU/Linux

# dmesg | grep brcmfmac
[    2.195263] brcmfmac: F1 signature read @0x18000000=3D0x15264345
[    2.209946] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    2.216566] usbcore: registered new interface driver brcmfmac
[    2.384898] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
[    2.385212] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
01-996384e2

# iw list
Wiphy phy0
...
    Supported extended features:
        * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
        * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station m=
ode
        * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station=
 mode
        * [ DFS_OFFLOAD ]: DFS offload
        * [ SAE_OFFLOAD ]: SAE offload support
        * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
        * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support

This was achieved here with a normal 'apt update ; apt upgrade' routine.

This appears to work for all Pis, now. Even a 32 bit image on a 3b+
with similar hardware:
# uname -a
Linux rpi32 6.6.28+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.28-1+rpt1
(2024-04-22) armv7l GNU/Linux
# iw list
...
    Supported extended features:
        * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
        * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station m=
ode
        * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station=
 mode
        * [ DFS_OFFLOAD ]: DFS offload
        * [ SAE_OFFLOAD ]: SAE offload support
        * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
        * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support

The PiZero2W does not show this capability with the same 64 bit image
running as it has different hardware with different firmware:
# dmesg | grep brcmfmac
[    6.051393] brcmfmac: F1 signature read @0x18000000=3D0x1542a9a6
[    6.077172] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43430b0-sdio for chip BCM43430/2
[    6.080782] usbcore: registered new interface driver brcmfmac
[    6.476401] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
[    6.481953] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
wl0: Mar 31 2022 17:24:51 version 9.88.4.77 (g58bc5cc) FWID
01-3b307371

Keith
